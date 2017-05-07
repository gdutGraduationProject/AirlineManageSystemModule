package cn.controller;

import cn.bean.Airport;
import cn.service.AirportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/7.
 */
@Controller
public class IndexController {

    @Autowired
    AirportService airportService;

    @RequestMapping(value = {"","index"})
    public String indexJump(HttpServletRequest request){
        List<Airport> airportList = airportService.findAllAirport();
        request.setAttribute("airportList",airportList);
        return "index";
    }

}
