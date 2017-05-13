package cn.controller;

import cn.bean.Airline;
import cn.bean.SubOrder;
import cn.bean.TicketOrder;
import cn.bean.vo.JqueryDataTablesVo;
import cn.service.TicketOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ChenGeng on 2017/5/13.
 */
@Controller
@RequestMapping("order")
public class OrderController {

    @Autowired
    TicketOrderService ticketOrderService;

    @RequestMapping(value = {"list", ""}, method = RequestMethod.GET)
    public String orderList() {
        return "order/index";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map query(Pageable pageable, JqueryDataTablesVo jqueryDataTablesVo){
        Map returnModel = new HashMap();

        int pageindex = jqueryDataTablesVo.getiDisplayStart() / jqueryDataTablesVo.getiDisplayLength();
        pageable = new PageRequest(pageindex,  jqueryDataTablesVo.getiDisplayLength());
        Page<TicketOrder> ticketOrderPage = ticketOrderService.findAllTicketOrder(pageable);
        long totalElement = ticketOrderPage.getTotalElements();
        List<TicketOrder> ticketOrderList = ticketOrderPage.getContent();
        for(TicketOrder ticketOrder:ticketOrderList){
            ticketOrder.getAirline().setAirlineClassList(null);
            ticketOrder.getCustomer().setCommonPassagerList(null);
            for(SubOrder subOrder:ticketOrder.getSubOrderList()){
                subOrder.getCommonPassager().setCustomer(null);
            }
        }
        returnModel.put("aaData",ticketOrderList);
        returnModel.put("iTotalRecords",totalElement);
        returnModel.put("iTotalDisplayRecords",totalElement);

        return returnModel;
    }

    @RequestMapping("detail")
    public String orderDetail(HttpServletRequest request,String id){
        TicketOrder ticketOrder = ticketOrderService.findById(id);
        request.setAttribute("ticketOrder",ticketOrder);
        return "order/detail";
    }


}
