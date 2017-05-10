package cn.service;

import cn.bean.*;
import cn.bean.repository.TicketOrderRepo;
import cn.util.TicketOrderNumberGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Service
public class TicketOrderService {

    @Autowired
    TicketOrderRepo ticketOrderRepo;

    TicketOrderNumberGenerator ticketOrderNumberGenerator = new TicketOrderNumberGenerator();

    public TicketOrder createNewOrder(Customer customer, LeftTicket leftTicket, LeftTicketClass leftTicketClass, TicketOrder mainOrder, List<CommonPassager> commonPassagerList, Airline airline){
        Date buyDateTime = new Date();
        TicketOrder ticketOrder = new TicketOrder();
        List<SubOrder> subOrderList = new ArrayList<SubOrder>();
        for(CommonPassager commonPassager:commonPassagerList){
            SubOrder subOrder = new SubOrder();
            subOrder.setCommonPassager(commonPassager);
            subOrder.setStatus(0);
            subOrderList.add(subOrder);
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
        ticketOrder = ticketOrderRepo.save(ticketOrder);
        return ticketOrder;

    }


    public List<TicketOrder> findOrderByCustomer(Customer customer){
        return ticketOrderRepo.findByDeleteByCustomerAndCustomerAndIsDeleteOrderByOrderDate(false,customer,false);
    }


    public TicketOrder findById(String id){
        return ticketOrderRepo.findOne(id);
    }


}
