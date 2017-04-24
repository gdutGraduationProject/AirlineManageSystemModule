package cn.controller;

import cn.bean.*;
import cn.bean.vo.JqueryDataTablesVo;
import cn.service.AirlineService;
import cn.service.AirportService;
import cn.service.PlaneService;
import cn.util.GlobalContants;
import cn.util.NumberListGenerator;
import com.sun.org.apache.xpath.internal.operations.Bool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Chen Geng on 2017/4/11.
 */
@Controller
@RequestMapping("/airline")
public class AirlineController {

    @Autowired
    AirlineService airlineService;

    @Autowired
    AirportService airportService;

    @Autowired
    PlaneService planeService;



    NumberListGenerator numberListGenerator = new NumberListGenerator();

    @RequestMapping(value = {"list", ""}, method = RequestMethod.GET)
    public String staffList() {
        return "airline/index";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map query(Pageable pageable, JqueryDataTablesVo jqueryDataTablesVo){
        Map returnModel = new HashMap();

        int pageindex = jqueryDataTablesVo.getiDisplayStart() / jqueryDataTablesVo.getiDisplayLength();
        pageable = new PageRequest(pageindex,  jqueryDataTablesVo.getiDisplayLength());
        Page<Airline> airlinePage = airlineService.findAllAirline(pageable);
        long totalElement = airlinePage.getTotalElements();
        List<Airline> airlineList = airlinePage.getContent();

        returnModel.put("aaData",airlineList);
        returnModel.put("iTotalRecords",totalElement);
        returnModel.put("iTotalDisplayRecords",totalElement);

        return returnModel;
    }

    @RequestMapping("/edit")
    public String addAirline(String id, HttpServletRequest request, Map model) {
        List hourList = numberListGenerator.timeListGenerator(0, 23);
        List minuteList = numberListGenerator.timeListGenerator(0, 59);
        List<Airport> airportList = airportService.findAllAirport();
        List<Plane> planeList = planeService.findAllPlane();
        Airline airline = new Airline();
        if (id == null || id.equals("")) {
            model.put("isNew", true);
            airline.setIsDisable(false);
        } else {
            model.put("isNew", false);
            airline = airlineService.findById(id);

        }
        model.put("hourList", hourList);
        model.put("minuteList", minuteList);
        model.put("airline", airline);
        model.put("airportList", airportList);
        model.put("planeList", planeList);
        return "airline/edit";
    }

    @RequestMapping("getPlaneClass")
    @ResponseBody
    public Map getPlaneClass(String planeId) {
        Map returnMap = new HashMap();
        Plane plane = planeService.findById(planeId);
        List<PlaneClass> planeClassList = plane.getPlaneClassList();
        returnMap.put("planeClassList", planeClassList);
        return returnMap;
    }

    @RequestMapping("update")
    public String update(HttpServletRequest request, String isNew, Airline airline, int departureTimeHour, int departureTimeMinute, int destinationTimeHour, int destinationTimeMinute) {
        boolean isNewBoolean = Boolean.parseBoolean(isNew);
        String departureAirportId = request.getParameter("departureId");
        String destinationId = request.getParameter("destinationId");
        String planeId = request.getParameter("planeId");
        //起飞机场和降落机场的处理
        Airport depature = airportService.findById(departureAirportId);
        Airport destination = airportService.findById(destinationId);
        airline.setDeparture(depature);
        airline.setDestination(destination);
        //起飞时间和降落时间的处理
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HH:mm");
        Date startTime = null;
        Date arriveTime = null;
        try {
            startTime = simpleDateFormat.parse(new String(String.valueOf(departureTimeHour)+":"+String.valueOf(departureTimeMinute)));
            arriveTime = simpleDateFormat.parse(new String(String.valueOf(destinationTimeHour)+":"+String.valueOf(destinationTimeMinute)));
        }catch (Exception e){

        }
        airline.setStartTime(startTime);
        airline.setArriveTime(arriveTime);
        //机型和客舱价格的处理
        Plane plane = planeService.findById(planeId);
        airline.setPlane(plane);
        List<AirlineClass> airlineClassList = new ArrayList<AirlineClass>();
        for(int i = 0 ; i<plane.getPlaneClassList().size();i++){
            AirlineClass airlineClass = new AirlineClass();
            String inputName = new String("planeClassId"+i);
            String planeClassId = request.getParameter(inputName);
            PlaneClass planeClass = findPlaneClassByIdInList(planeClassId,plane.getPlaneClassList());
            airlineClass.setPlaneClass(planeClass);
            inputName = new String("fullPrice"+i);
            double fullPrice = Double.valueOf(request.getParameter(inputName));
            airlineClass.setFullPrice(fullPrice);
            inputName = new String("defaultDiscount"+i);
            double defaultDisount = Double.valueOf(request.getParameter(inputName));
            airlineClass.setDefaultDiscount(defaultDisount);
            inputName = new String("spiltTime"+i);
            int spiltTime = Integer.valueOf(request.getParameter(inputName));
            airlineClass.setSplitTime(spiltTime);
            inputName = new String("beforeRefundFee"+i);
            double beforeRefundeFee = Double.valueOf(request.getParameter(inputName));
            airlineClass.setBeforeRefundFee(beforeRefundeFee);
            inputName = new String("afterRefundFee"+i);
            double afterRefundFee = Double.valueOf(request.getParameter(inputName));
            airlineClass.setAfterRefundFee(afterRefundFee);
            inputName = new String("beforeChangeFee"+i);
            double beforeChangeFee = Double.valueOf(request.getParameter(inputName));
            airlineClass.setBeforeChangeFee(beforeChangeFee);
            inputName = new String("afterChangeFee"+i);
            double afterChangeFee = Double.valueOf(request.getParameter(inputName));
            airlineClass.setAfterChangeFee(afterChangeFee);
            airlineClassList.add(airlineClass);
        }
        airline.setAirlineClassList(airlineClassList);
        airline.setStatus(1);
        airlineService.save(airline);
        return "redirect:/airline/list";
    }

    @RequestMapping(value = {"delete"},method = RequestMethod.POST)
    @ResponseBody
    public Map delete(String id){
        Map model = new HashMap();
        airlineService.deleteAirlineById(id);
        model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
        model.put(GlobalContants.RESPONSE_MESSAGE,"删除成功");
        return model;
    }

    @RequestMapping("/changeDisable")
    @ResponseBody
    public Map changeDisable(String id){
        Map model = new HashMap();
        Airline airline = airlineService.findById(id);
        if(airline.getStatus()==1){
            airline.setStatus(2);
        }else if(airline.getStatus()==2){
            airline.setStatus(3);
        }else if(airline.getStatus()==3){
            airline.setStatus(2);
        }
        airlineService.save(airline);
        model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
        model.put(GlobalContants.RESPONSE_MESSAGE,"修改成功");
        return model;
    }

    private PlaneClass findPlaneClassByIdInList(String classId, List<PlaneClass> planeClassList){
        if(classId == null || classId.equals("")){
            return null;
        }
        for(PlaneClass planeClass:planeClassList){
            if(planeClass.getId().equals(classId)){
                return planeClass;
            }
        }
        return null;
    }

}
