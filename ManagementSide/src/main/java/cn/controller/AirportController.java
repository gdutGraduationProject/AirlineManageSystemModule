package cn.controller;

import cn.bean.Airport;
import cn.bean.Staff;
import cn.bean.vo.JqueryDataTablesVo;
import cn.service.AirportService;
import cn.util.GlobalContants;
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
 * Created by ChenGeng on 2017/3/26.
 */
@Controller
@RequestMapping("/airport/")
public class AirportController {

    @Autowired
    AirportService airportService;

    @RequestMapping(value = {"list",""},method = RequestMethod.GET)
    public String staffList(){
        return "airport/index";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map query(Pageable pageable, JqueryDataTablesVo jqueryDataTablesVo){
        Map returnModel = new HashMap();

        int pageindex = jqueryDataTablesVo.getiDisplayStart() / jqueryDataTablesVo.getiDisplayLength();
        pageable = new PageRequest(pageindex,  jqueryDataTablesVo.getiDisplayLength());
        Page<Airport> airportPage = airportService.findAirportList(pageable);
        long totalElement = airportPage.getTotalElements();
        List<Airport> airportList = airportPage.getContent();

        returnModel.put("aaData",airportList);
        returnModel.put("iTotalRecords",totalElement);
        returnModel.put("iTotalDisplayRecords",totalElement);

        return returnModel;
    }

    @RequestMapping("/edit")
    public String addAirport(String id, HttpServletRequest request, Map model){
        Airport airport = new Airport();
        if(id==null || id.equals("")){
            model.put("isNew",true);
            airport.setIsDisable(false);
        }else{
            model.put("isNew",false);
            airport = airportService.findById(id);
        }
        model.put("airport",airport);
        return "airport/edit";
    }

    @RequestMapping("/update")
    public String updateAirport(String isNew,Airport airport,HttpServletRequest request){
        boolean isNewBoolean = Boolean.parseBoolean(isNew);
        Airport saveAirport;

        if(isNewBoolean){
            //提交修改的机场是新的机场
            saveAirport = airport;
        }else{
            //提交修改的机场是旧的机场进行编辑
            saveAirport = airportService.findById(airport.getId());
            saveAirport.setAirportName(airport.getAirportName());
            saveAirport.setCity(airport.getCity());
            saveAirport.setProvince(airport.getProvince());
            saveAirport.setShortEng(airport.getShortEng());
        }
        airportService.save(saveAirport);
        return "redirect:/airport/list";
    }

    @RequestMapping("/changeDisable")
    @ResponseBody
    public Map changeDisable(String id){
        Map model = new HashMap();
        Airport airport = airportService.findById(id);
        if(airport.getIsDisable()==true){
            airport.setIsDisable(false);
        }else{
            airport.setIsDisable(true);
        }
        airportService.save(airport);
        model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
        model.put(GlobalContants.RESPONSE_MESSAGE,"修改成功");
        return model;
    }

}
