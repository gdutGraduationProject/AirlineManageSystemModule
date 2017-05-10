package cn.controller;

import cn.bean.*;
import cn.service.CommonPassagerService;
import cn.service.LeftTicketService;
import cn.service.TicketOrderService;
import cn.util.GlobalContants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/8.
 */
@Controller
@RequestMapping("buyticket")
public class BuyTicketController {

    @Autowired
    LeftTicketService leftTicketService;

    @Autowired
    TicketOrderService ticketOrderService;

    @Autowired
    CommonPassagerService commonPassagerService;

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

        TicketOrder ticketOrder = ticketOrderService.createNewOrder(customer,leftTicket,leftTicketClass,null,commonPassagerList,airline);



        return "success";

    }

}
