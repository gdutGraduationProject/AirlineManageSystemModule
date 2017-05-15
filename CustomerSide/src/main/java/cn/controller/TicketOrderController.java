package cn.controller;

import cn.bean.*;
import cn.service.CommonPassagerService;
import cn.service.LeftTicketService;
import cn.service.PaymentService;
import cn.service.TicketOrderService;
import cn.util.EmailSendTool;
import cn.util.GlobalContants;
import cn.util.TicketOrderNumberGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/8.
 */
@Controller
@RequestMapping("buyticket")
public class TicketOrderController {

    @Autowired
    LeftTicketService leftTicketService;

    @Autowired
    TicketOrderService ticketOrderService;

    @Autowired
    CommonPassagerService commonPassagerService;

    @Autowired
    PaymentService paymentService;

    EmailSendTool emailSendTool = new EmailSendTool();

    TicketOrderNumberGenerator ticketOrderNumberGenerator = new TicketOrderNumberGenerator();

    @RequestMapping("chooseleftticket")
    public String chooseLeftTicket(HttpServletRequest request, String leftTicketId, String leftTicketClassId){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        LeftTicket leftTicket = leftTicketService.findById(leftTicketId);
        List<CommonPassager> commonPassagerList = commonPassagerService.findListByCustomer(customer);
        LeftTicketClass leftTicketClass = null;
        for(LeftTicketClass ticketClass:leftTicket.getLeftTicketClassList()){
            if(ticketClass.getId().equals(leftTicketClassId))
                leftTicketClass = ticketClass;
        }
        request.setAttribute("commonPassager", commonPassagerList);
        request.setAttribute("leftTicket", leftTicket);
        request.setAttribute("leftTicketClass", leftTicketClass);
        request.setAttribute("airline",leftTicket.getAirline());

        return "buyticket/choosepassager";
    }

    @RequestMapping("submitOrder")
    public String submitOrder(HttpServletRequest request, String leftTicketId, String leftTicketClassId, int classCount, @RequestParam(required=false)String[] commonPassagerId){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        LeftTicket leftTicket = leftTicketService.findById(leftTicketId);
        LeftTicketClass leftTicketClass = null;
        Airline airline = leftTicket.getAirline();
        for(LeftTicketClass ticketClass : leftTicket.getLeftTicketClassList()){
            if(ticketClass.getId().equals(leftTicketClassId)){
                leftTicketClass = ticketClass;
            }
        }
        List<CommonPassager> commonPassagerList = new ArrayList<CommonPassager>();
        if (commonPassagerId!=null && commonPassagerId.length!=0)
            for(String passagerId : commonPassagerId){
                CommonPassager commonPassager = commonPassagerService.findById(passagerId);
                commonPassagerList.add(commonPassager);
            }
        for(int i = 0; i<classCount;i++){
            String passagerName = request.getParameter(new String("user"+i));
            if(passagerName==null || passagerName.equals("")){
                //这个旅客被删了
                continue;
            }else{
                //需要添加的旅客
                String idNumber = request.getParameter(new String("idcard"+i));
                String phoneNumber = request.getParameter(new String("phone"+i));
                CommonPassager commonPassager = new CommonPassager();
                commonPassager.setCustomer(customer);
                commonPassager.setName(passagerName);
                commonPassager.setIdNumber(idNumber);
                commonPassager.setPhoneNumber(phoneNumber);
                commonPassager.setIdType("身份证");
                commonPassager.setSex("男");
                commonPassager = commonPassagerService.save(commonPassager);
                commonPassagerList.add(commonPassager);
            }
        }
        if(leftTicketClass.getLeftCount()<commonPassagerList.size()){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该舱位剩余机票不足，无法购买。该舱剩余机票数："+leftTicketClass.getLeftCount());
            return "error";
        }else{
            TicketOrder ticketOrder = ticketOrderService.createNewOrder(customer,leftTicket,leftTicketClass,null,commonPassagerList,airline);
            emailSendTool.sendConfirmOrderTicket(ticketOrder);
            return "redirect:/personalcenter/orderdetail?id="+ticketOrder.getId();
        }
    }

    @RequestMapping("payorder")
    public String payTicketOrder(HttpServletRequest request, String id){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        if(ticketOrder.getOrderStatus()!=1){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该订单无需支付");
            return "error";
        }else if(customer.getId().equals(ticketOrder.getCustomer().getId())){
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_TEXT,"确认要支付该订单吗？金额："+ticketOrder.getPayFee());
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_URL,"buyticket/confirmpay?id="+ticketOrder.getId());
            return "confirm";
        }else{
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该订单不是您的订单");
            return "error";
        }
    }

    @RequestMapping("deleteorder")
    public String deleteTicketOrder(HttpServletRequest request, String id){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        if(ticketOrder.getOrderStatus()==1){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"未支付的订单不能删除");
            return "error";
        }else if(customer.getId().equals(ticketOrder.getCustomer().getId())){
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_TEXT,"确认要删除该订单吗？");
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_URL,"buyticket/confirmdelete?id="+ticketOrder.getId());
            return "confirm";
        }else{
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该订单不是您的订单");
            return "error";
        }
    }

    @RequestMapping("cancleorder")
    public String cancleTicketOrder(HttpServletRequest request, String id){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        if(ticketOrder.getOrderStatus()!=1){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"已支付的订单不能删除");
            return "error";
        }else if(customer.getId().equals(ticketOrder.getCustomer().getId())){
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_TEXT,"确认要取消该订单吗？");
            request.setAttribute(GlobalContants.REQUEST_CONFIRM_URL,"buyticket/confirmcancle?id="+ticketOrder.getId());
            return "confirm";
        }else{
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该订单不是您的订单");
            return "error";
        }
    }

    @RequestMapping("confirmpay")
    @ResponseBody
    public String confirmPay(HttpServletRequest request,String id){
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        Payment payment = new Payment();
        payment.setPaymentTime(new Date());
        payment.setPaymentNum(ticketOrderNumberGenerator.generate());
        payment.setPaymentType(1);
        payment.setPaymentMoney(ticketOrder.getPayFee());
        payment.setIpAddress(request.getRemoteAddr());
        payment.setCustomer(customer);
        payment = paymentService.save(payment);
        ticketOrderService.payTicketOrder(ticketOrder,payment);
        emailSendTool.sendPayTicket(ticketOrder);
        return "success";
    }

    @RequestMapping("confirmdelete")
    @ResponseBody
    public String confirmDelete(HttpServletRequest request,String id){
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        ticketOrderService.deleteTicketOrder(ticketOrder);
        return "success";
    }

    @RequestMapping("confirmcancle")
    @ResponseBody
    public String confirmCancle(HttpServletRequest request,String id){
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        ticketOrderService.cancleTicketOrder(ticketOrder);
        return "success";
    }

    @RequestMapping("refundticket")
    public String refundTicket(HttpServletRequest request, String ticketOrderId, String[] subOrderId){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        TicketOrder ticketOrder = ticketOrderService.findById(ticketOrderId);
        if(!customer.getId().equals(ticketOrder.getCustomer().getId())){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"该订单不是您的订单");
            return "error";
        }else {

        List<SubOrder> subOrderList = new ArrayList<SubOrder>();
        for(String newString:subOrderId){
            SubOrder subOrder = new SubOrder();
            for(SubOrder order : ticketOrder.getSubOrderList()){
                if(order.getId().equals(newString)){
                    subOrder = order;
                }
            }
            subOrderList.add(subOrder);
        }
        ticketOrder = ticketOrderService.refundTicketOrder(ticketOrder,subOrderList);
        return "redirect:/personalcenter/orderdetail?id="+ticketOrder.getId();
        }
    }

}
