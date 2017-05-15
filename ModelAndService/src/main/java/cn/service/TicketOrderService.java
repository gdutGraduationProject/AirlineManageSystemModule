package cn.service;

import cn.bean.*;
import cn.bean.repository.TicketOrderRepo;
import cn.util.DateTransformTool;
import cn.util.TicketOrderNumberGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Component
@Service
public class TicketOrderService {

    @Autowired
    TicketOrderRepo ticketOrderRepo;

    TicketOrderNumberGenerator ticketOrderNumberGenerator = new TicketOrderNumberGenerator();

    DateTransformTool dateTransformTool = new DateTransformTool();

    @Autowired
    LeftTicketService leftTicketService;

    @Autowired
    SubOrderService subOrderService;

    @Autowired
    PaymentService paymentService;

    public List<TicketOrder> unpayedTicketOrder(){
        return ticketOrderRepo.findByOrderStatusAndIsDelete(1,false);
    }

    public TicketOrder payTicketOrder(TicketOrder ticketOrder, Payment payment){
        ticketOrder.setOrderStatus(2);
        ticketOrder.setPayment(payment);
        for(SubOrder subOrder:ticketOrder.getSubOrderList()){
            subOrder.setStatus(2);
            subOrderService.save(subOrder);
        }
        return ticketOrderRepo.save(ticketOrder);
    }

    public TicketOrder createNewOrder(Customer customer, LeftTicket leftTicket, LeftTicketClass leftTicketClass, TicketOrder mainOrder, List<CommonPassager> commonPassagerList, Airline airline){
        Date buyDateTime = new Date();
        TicketOrder ticketOrder = new TicketOrder();
        List<SubOrder> subOrderList = new ArrayList<SubOrder>();
        double totalPrice = 0;
        for(CommonPassager commonPassager:commonPassagerList){
            SubOrder subOrder = new SubOrder();
            subOrder.setCommonPassager(commonPassager);
            subOrder.setStatus(1);
            subOrderList.add(subOrder);
            subOrder.setPayFee(leftTicketClass.getCurPrice()+leftTicket.getAirline().getFuelTex()+leftTicket.getAirline().getAirportConstruction());
            totalPrice += leftTicketClass.getCurPrice();
        }
        ticketOrder.setOrderTime(buyDateTime);
        ticketOrder.setOrderNum(ticketOrderNumberGenerator.generate());
        ticketOrder.setFlightDay(leftTicket.getDepartureDate());
        ticketOrder.setOrderStatus(1);
        if(mainOrder!=null){
            ticketOrder.setOrderType(2);
            ticketOrder.setMainOrder(mainOrder);
        }else {
            ticketOrder.setOrderType(1);
        }
        ticketOrder.setOrderDate(buyDateTime);
        ticketOrder.setDeleteByCustomer(false);
        ticketOrder.setCustomer(customer);
        ticketOrder.setSubOrderList(subOrderList);
        ticketOrder.setAirline(airline);
        ticketOrder.setLeftTicketClass(leftTicketClass);
        ticketOrder.setPayFee(totalPrice);
        ticketOrder = ticketOrderRepo.save(ticketOrder);
        leftTicket = leftTicketService.findById(leftTicket.getId());
        for(LeftTicketClass ticketClass :leftTicket.getLeftTicketClassList()){
            if(leftTicketClass.getId().equals(ticketClass.getId())){
                leftTicketClass = ticketClass;
            }
        }
        int saleCount = commonPassagerList.size();
        leftTicketClass.setLeftCount(leftTicketClass.getLeftCount()-saleCount);
        leftTicketClass.setSaleCount(leftTicketClass.getSaleCount()+saleCount);
        ticketOrder.setLeftTicket(leftTicket);
        leftTicket = leftTicketService.save(leftTicket);

        return ticketOrder;

    }


    public List<TicketOrder> findOrderByCustomer(Customer customer){
        return ticketOrderRepo.findByDeleteByCustomerAndCustomerAndIsDeleteOrderByOrderTimeDesc(false,customer,false);
    }


    public TicketOrder findById(String id){
        return ticketOrderRepo.findOne(id);
    }


    public TicketOrder deleteTicketOrder(TicketOrder ticketOrder) {
        ticketOrder.setDeleteByCustomer(true);
        return ticketOrderRepo.save(ticketOrder);

    }

    public LeftTicket cancleTicketOrder(TicketOrder ticketOrder) {
        int ticketCount = 0;
        for(SubOrder subOrder:ticketOrder.getSubOrderList()){
            subOrder.setStatus(3);
            subOrderService.save(subOrder);
            ticketCount++;
        }
        ticketOrder.setOrderStatus(3);
        ticketOrderRepo.save(ticketOrder);
        LeftTicketClass leftTicketClass = ticketOrder.getLeftTicketClass();
        LeftTicket leftTicket = ticketOrder.getLeftTicket();
        leftTicket = leftTicketService.findById(leftTicket.getId());
        for(LeftTicketClass ticketClass : leftTicket.getLeftTicketClassList()){
            if(ticketClass.getId().equals(leftTicketClass.getId())){
                leftTicketClass = ticketClass;
            }
        }
        leftTicketClass.setSaleCount(leftTicketClass.getSaleCount()-ticketCount);
        leftTicketClass.setLeftCount(leftTicketClass.getLeftCount()+ticketCount);
        return leftTicketService.save(leftTicket);
    }

    public LeftTicket disableTicketOrder(TicketOrder ticketOrder) {
        int ticketCount = 0;
        ticketOrder = ticketOrderRepo.findOne(ticketOrder.getId());
        for(SubOrder subOrder:ticketOrder.getSubOrderList()){
            subOrder.setStatus(4);
            subOrderService.save(subOrder);
            ticketCount++;
        }
        ticketOrder.setOrderStatus(4);
        ticketOrderRepo.save(ticketOrder);
        LeftTicketClass leftTicketClass = ticketOrder.getLeftTicketClass();
        LeftTicket leftTicket = ticketOrder.getLeftTicket();
        leftTicket = leftTicketService.findById(leftTicket.getId());
        for(LeftTicketClass ticketClass : leftTicket.getLeftTicketClassList()){
            if(ticketClass.getId().equals(leftTicketClass.getId())){
                leftTicketClass = ticketClass;
            }
        }
        leftTicketClass.setSaleCount(leftTicketClass.getSaleCount()-ticketCount);
        leftTicketClass.setLeftCount(leftTicketClass.getLeftCount()+ticketCount);
        return leftTicketService.save(leftTicket);
    }

    public TicketOrder refundTicketOrder(TicketOrder ticketOrder, List<SubOrder> subOrderList){
        Date systemDate = new Date();
        Date spiltDate = dateTransformTool.datePickerStringToDate(ticketOrder.getFlightDay());
        int hour = ticketOrder.getAirline().getStartTime().getHours()-ticketOrder.getLeftTicketClass().getAirlineClass().getSplitTime();
        if(hour<0){
            hour+=24;
            spiltDate.setDate(spiltDate.getDate()-1);
        }
        spiltDate.setHours(hour);
        spiltDate.setMinutes(ticketOrder.getAirline().getStartTime().getMinutes());
        double refundFee ;
        if(systemDate.before(spiltDate)){
            refundFee = ticketOrder.getLeftTicketClass().getAirlineClass().getBeforeRefundFee();
        }else{
            refundFee = ticketOrder.getLeftTicketClass().getAirlineClass().getAfterRefundFee();
        }
        double returnFee = 0;
        List<String> subOrderIdString = new ArrayList<String>();
        for(SubOrder subOrder:subOrderList){
            subOrder.setStatus(5);
            subOrderIdString.add(subOrder.getId());
            if(subOrder.getPayFee()>refundFee){
                returnFee = returnFee+subOrder.getPayFee()-refundFee;
            }
        }
        Payment payment = new Payment();
        payment.setCustomer(ticketOrder.getCustomer());
        payment.setPaymentMoney(returnFee);
        payment.setPaymentType(2);
        payment.setPaymentTime(new Date());
        payment.setPaymentNum(ticketOrderNumberGenerator.generate());
        payment = paymentService.save(payment);
        for(SubOrder subOrder:ticketOrder.getSubOrderList()){
            if(subOrderIdString.contains(subOrder.getId())){
                subOrder.setStatus(5);
                subOrder.setPayment(payment);
                subOrderService.save(subOrder);
            }
        }
        ticketOrder.updateOrderStatus();
        return ticketOrder = ticketOrderRepo.save(ticketOrder);
    }

    public Page<TicketOrder> findAllTicketOrder(Pageable pageable) {
        return ticketOrderRepo.findByIsDeleteOrderByOrderTimeDesc(false,pageable);
    }
}
