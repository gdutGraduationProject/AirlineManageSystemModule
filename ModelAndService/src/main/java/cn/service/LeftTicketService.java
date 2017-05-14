package cn.service;

import cn.bean.Airline;
import cn.bean.AirlineClass;
import cn.bean.LeftTicket;
import cn.bean.LeftTicketClass;
import cn.bean.repository.LeftTicketClassRepo;
import cn.bean.repository.LeftTicketRepo;
import cn.util.DateTransformTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
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

    DateTransformTool dateTransformTool = new DateTransformTool();

    /**
     * 根据单个航班查找该航班在该日期的余票信息并返回
     */
    public LeftTicket findLeftTicketByAirline(Airline airline, String dateString){
        Date date = dateTransformTool.datePickerStringToDate(dateString);
        boolean isFlag = true;
        switch (date.getDay()){
            case 0:{
                if(airline.getSunday()==false){
                    isFlag = false;
                }
                break;
            }case 1:{
                if(airline.getMonday()==false){
                    isFlag = false;
                }
                break;
            }case 2:{
                if(airline.getTuesday()==false){
                    isFlag = false;
                }
                break;
            }case 3:{
                if(airline.getWednesday()==false){
                    isFlag = false;
                }
                break;
            }case 4:{
                if(airline.getThursday()==false){
                    isFlag = false;
                }
                break;
            }case 5:{
                if(airline.getFriday()==false){
                    isFlag = false;
                }
                break;
            }case 6:{
                if(airline.getSaturday()==false){
                    isFlag = false;
                }
                break;
            }
        }
        if(isFlag == false){
            return null;
        }
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

    /**
     * 保存
     */
    public LeftTicket save(LeftTicket leftTicket){
        for(LeftTicketClass leftTicketClass : leftTicket.getLeftTicketClassList()){
            leftTicketClassRepo.save(leftTicketClass);
        }
        return leftTicketRepo.save(leftTicket);

    }

    public LeftTicketClass save(LeftTicketClass leftTicketClass){
        return leftTicketClassRepo.save(leftTicketClass);
    }


    /**
     * 根据id找到对应的LeftTicket
     */
    public LeftTicket findById(String id){
        return leftTicketRepo.findOne(id);
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
            leftTicketClass.setCurPrice(Math.rint(leftTicketClass.getFullPrice()*leftTicketClass.getDiscount()/100));
            leftTicketClass = leftTicketClassRepo.save(leftTicketClass);
            leftTicketClassList.add(leftTicketClass);
        }
        leftTicket.setLeftTicketClassList(leftTicketClassList);
        leftTicket = leftTicketRepo.save(leftTicket);
        return leftTicket;
    }

}
