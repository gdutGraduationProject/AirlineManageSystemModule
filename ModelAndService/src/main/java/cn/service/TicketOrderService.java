package cn.service;

import cn.bean.Customer;
import cn.bean.TicketOrder;
import cn.bean.repository.TicketOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Service
public class TicketOrderService {

    @Autowired
    TicketOrderRepo ticketOrderRepo;

    public List<TicketOrder> findOrderByCustomer(Customer customer){
        return ticketOrderRepo.findByDeleteByCustomerAndCustomerAndIsDeleteOrderByOrderDate(false,customer,false);
    }


}
