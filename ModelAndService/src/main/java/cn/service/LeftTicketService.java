package cn.service;

import cn.bean.Airline;
import cn.bean.LeftTicket;
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



    /**
     * 根据单个航班查找该航班在该日期的余票信息并返回
     */
    public LeftTicket findLeftTicketByAirline(Airline airline, String dateString){
        LeftTicket leftTicket = leftTicketRepo.findByIsDeleteAndAirlineAndDepartureDate(false,airline,dateString);
        if(leftTicket == null){



        }
        return leftTicket;
    }

    public LeftTicket initLeftTicket(Airline airline, String dateString){
        LeftTicket leftTicket = new LeftTicket();
        leftTicket.setAirline(airline);
        leftTicket.setDepartureDate(dateString);



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

}
