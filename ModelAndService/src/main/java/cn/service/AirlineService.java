package cn.service;

import cn.bean.Airline;
import cn.bean.Airport;
import cn.bean.repository.AirlineRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * Created by Chen Geng on 2017/4/12.
 */
@Service
public class AirlineService {

    @Autowired
    AirlineRepo airlineRepo;

    public Airline findById(String id){
        return airlineRepo.findOne(id);
    }

    public Airline save(Airline airline){
        airline = airlineRepo.save(airline);
        return airline;
    }

    public Page<Airline> findAllAirline(Pageable pageable){
        return airlineRepo.findByIsDeleteOrderByStatus(false,pageable);
    }

    public List<Airline> findAllAirline(){
        return airlineRepo.findByIsDelete(false);
    }

    public void deleteAirlineById(String id) {
        Airline airline = airlineRepo.findOne(id);
        airline.setIsDelete(true);
        airlineRepo.save(airline);
    }

    public List<Airline> airlineSearch(Airport departure, Airport destination, Date date){
        List<Airline> airlineList = null;
        switch (date.getDay()){
            case 0:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndSunday(false,2,departure,destination,true);
                break;
            }case 1:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndMonday(false,2,departure,destination,true);
                break;
            }case 2:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndTuesday(false,2,departure,destination,true);
                break;
            }case 3:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndWednesday(false,2,departure,destination,true);
                break;
            }case 4:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndThursday(false,2,departure,destination,true);
                break;
            }case 5:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndFriday(false,2,departure,destination,true);
                break;
            }case 6:{
                airlineList = airlineRepo.findByIsDeleteAndStatusAndDepartureAndDestinationAndSaturday(false,2,departure,destination,true);
                break;
            }
        }
        return airlineList;
    }
}
