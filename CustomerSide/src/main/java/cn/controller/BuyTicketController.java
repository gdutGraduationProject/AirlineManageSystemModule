package cn.controller;

import cn.bean.LeftTicket;
import cn.bean.LeftTicketClass;
import cn.service.LeftTicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ChenGeng on 2017/5/8.
 */
@Controller
@RequestMapping("buyticket")
public class BuyTicketController {

    @Autowired
    LeftTicketService leftTicketService;

    @RequestMapping("chooseleftticket")
    public String chooseLeftTicket(String leftTicketId, String leftTicketClassId){
        LeftTicket leftTicket = leftTicketService.findById(leftTicketId);
        LeftTicketClass leftTicketClass = null;
        for(LeftTicketClass ticketClass:leftTicket.getLeftTicketClassList()){
            if(ticketClass.getId().equals(leftTicketClassId))
                leftTicketClass = ticketClass;
        }

        return "success";
    }

}
