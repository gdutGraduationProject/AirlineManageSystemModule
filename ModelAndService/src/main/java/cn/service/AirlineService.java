package cn.service;

import cn.bean.Airline;
import cn.bean.repository.AirlineRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

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

    public void deleteAirlineById(String id) {
        Airline airline = airlineRepo.findOne(id);
        airline.setIsDelete(true);
        airlineRepo.save(airline);
    }
}
