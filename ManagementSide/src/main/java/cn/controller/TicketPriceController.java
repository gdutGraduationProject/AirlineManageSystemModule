package cn.controller;

import cn.bean.Airline;
import cn.bean.LeftTicket;
import cn.bean.LeftTicketClass;
import cn.service.AirlineService;
import cn.service.LeftTicketService;
import cn.util.DateTransformTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/12.
 */
@Controller
@RequestMapping("ticketprice")
public class TicketPriceController {

    @Autowired
    AirlineService airlineService;

    DateTransformTool dateTransformTool = new DateTransformTool();

    @Autowired
    LeftTicketService leftTicketService;



    @RequestMapping("")
    public String ticketPrice(HttpServletRequest request){
        List<Airline> airlineList = airlineService.findAllAirline();
        request.setAttribute("airlineList",airlineList);
        return "ticketprice/choose";
    }

    @RequestMapping("edit")
    public String editPrice(HttpServletRequest request,String airlineId,  String startDate, String endDate){
        Date startDateDate = dateTransformTool.datePickerStringToDate(startDate);
        Date endDateDate = dateTransformTool.datePickerStringToDate(endDate);
        Airline airline = airlineService.findById(airlineId);
            //修改当天
            LeftTicket leftTicket = leftTicketService.findLeftTicketByAirline(airline,startDate);
            if(leftTicket == null){
                request.setAttribute("result","操作失败！您选择的日期该航班不飞行。");
                return "ticketprice/result";
            }else {
                request.setAttribute("airline",airline);
                request.setAttribute("leftTicket",leftTicket);
                return "ticketprice/updateday";
            }


    }

    @RequestMapping("updatesingle")
    public String updateSingle(HttpServletRequest request, String leftTicketId){
        LeftTicket leftTicket = leftTicketService.findById(leftTicketId);
        for(int i=0;i<leftTicket.getLeftTicketClassList().size();i++){
            String leftTicketClassId = request.getParameter(new String("leftTicketClassId"+i));
            double newPrice = Double.valueOf(request.getParameter(new String("newPrice"+i)));
            LeftTicketClass leftTicketClass = null;
            for(LeftTicketClass ticketClass:leftTicket.getLeftTicketClassList()){
                if(ticketClass.getId().equals(leftTicketClassId)){
                    leftTicketClass = ticketClass;
                }
            }
            leftTicketClass.setCurPrice(newPrice);
            leftTicketClass.setDiscount(Math.round(leftTicketClass.getCurPrice()/leftTicketClass.getFullPrice()*100));
            leftTicketClass = leftTicketService.save(leftTicketClass);
        }
        leftTicket.updateMinPrice();
        leftTicketService.save(leftTicket);
        request.setAttribute("result","操作成功，新价格已保存。");
        return "ticketprice/result";
    }

}
