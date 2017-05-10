package cn.controller;

import cn.bean.CommonPassager;
import cn.bean.Customer;
import cn.bean.LeftTicket;
import cn.bean.LeftTicketClass;
import cn.service.CommonPassagerService;
import cn.service.LeftTicketService;
import cn.util.GlobalContants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
    public String submitOrder(HttpServletRequest request, String leftTicketId, String leftTicketClassId, int classCount){

    }

}
