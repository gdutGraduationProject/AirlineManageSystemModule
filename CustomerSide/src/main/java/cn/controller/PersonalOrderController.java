package cn.controller;

import cn.bean.Customer;
import cn.bean.TicketOrder;
import cn.service.TicketOrderService;
import cn.util.GlobalContants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Controller
@RequestMapping("/personalcenter/")
public class PersonalOrderController {

    @Autowired
    TicketOrderService ticketOrderService;

    @RequestMapping("/myorder")
    public String searchMyOrder(HttpServletRequest request){
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        List<TicketOrder> ticketOrderList = ticketOrderService.findOrderByCustomer(customer);
        request.setAttribute("ticketOrder",ticketOrderList);
        if(ticketOrderList == null || ticketOrderList.size()==0){
            request.setAttribute("hasOrder","false");
        }else {
            request.setAttribute("hasOrder","true");
        }
        return "ticketorder/orderlist";
    }

    @RequestMapping("orderdetail")
    public String oderDetail(HttpServletRequest request, String id){
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        request.setAttribute("ticketOrder",ticketOrder);
        return "ticketorder/orderdetail";
    }

}
