package cn.service;

import cn.bean.Airline;
import cn.bean.AirlineClass;
import cn.bean.LeftTicket;
import cn.bean.LeftTicketClass;
import cn.bean.repository.LeftTicketClassRepo;
import cn.bean.repository.LeftTicketRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Chen Geng on 2017/5/2.
 */
@Service
public class LeftTicketService {

    @Autowired
    LeftTicketRepo leftTicketRepo;

    @Autowired
    LeftTicketClassRepo leftTicketClassRepo;

    /**
     * 根据单个航班查找该航班在该日期的余票信息并返回
     */
    public LeftTicket findLeftTicketByAirline(Airline airline, String dateString){
        LeftTicket leftTicket = leftTicketRepo.findByIsDeleteAndAirlineAndDepartureDate(false,airline,dateString);
        if(leftTicket == null){
            leftTicket = initLeftTicket(airline,dateString);
        }
        return leftTicket;
    }

    /**
     * 根据航班信息列表查找所有的余票信息，并返回余票列表
     */
    public List<LeftTicket> findLeftTicketListByAirline(List<Airline> airlineList, String dateString){
        List<LeftTicket> leftTicketList = new ArrayList<LeftTicket>();
        for(Airline airline:airlineList){
            LeftTicket leftTicket = findLeftTicketByAirline(airline,dateString);
            leftTicketList.add(leftTicket);
        }
        return leftTicketList;
    }

    private LeftTicket initLeftTicket(Airline airline, String dateString){
        LeftTicket leftTicket = new LeftTicket();
        leftTicket.setAirline(airline);
        leftTicket.setDepartureDate(dateString);
        List<LeftTicketClass> leftTicketClassList = new ArrayList<LeftTicketClass>();
        for(AirlineClass airlineClass:airline.getAirlineClassList()){
            LeftTicketClass leftTicketClass = new LeftTicketClass();
            leftTicketClass.setAirlineClass(airlineClass);
            leftTicketClass.setTotalCount(airlineClass.getPlaneClass().getTotalCount());
            leftTicketClass.setLeftCount(airlineClass.getPlaneClass().getTotalCount());
            leftTicketClass.setSaleCount(0);
            leftTicketClass.setFullPrice(airlineClass.getFullPrice());
            leftTicketClass.setDiscount(airlineClass.getDefaultDiscount());
            leftTicketClass.setCurPrice(leftTicketClass.getFullPrice()/leftTicketClass.getDiscount()*100);
            leftTicketClass = leftTicketClassRepo.save(leftTicketClass);
            leftTicketClassList.add(leftTicketClass);
        }
        leftTicket.setLeftTicketClassList(leftTicketClassList);
        leftTicket = leftTicketRepo.save(leftTicket);
        return leftTicket;
    }

}
