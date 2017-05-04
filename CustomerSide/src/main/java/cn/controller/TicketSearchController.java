package cn.controller;

import cn.bean.Airline;
import cn.bean.Airport;
import cn.service.AirlineService;
import cn.service.AirportService;
import cn.util.DateTransformTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Date;
import java.util.List;

/**
 * Created by Chen Geng on 2017/5/2.
 */
@Controller
public class TicketSearchController {

    @Autowired
    AirportService airportService;

    @Autowired
    AirlineService airlineService;

    DateTransformTool dateTransformTool = new DateTransformTool();

    @RequestMapping("/ticketsearch")
    public String searchTicket(String departureId, String destinateId, String departure){
        Airport departureAirport = airportService.findById(departureId);
        Airport destinateAirport = airportService.findById(destinateId);
        Date departureDate = dateTransformTool.datePickerStringToDate(departure);
        List<Airline> airlineList = airlineService.airlineSearch(departureAirport,destinateAirport,departureDate);

        return "success";
    }

}
