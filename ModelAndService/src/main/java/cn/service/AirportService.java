package cn.service;

import cn.bean.Airport;
import cn.bean.repository.AirportRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/26.
 */
@Component
public class AirportService {

    @Autowired
    AirportRepo airportRepo;

    /**
     * 根据id找到相应的airport
     */
    public Airport findById(String id){
        return airportRepo.findOne(id);
    }

    /**
     * 找到所有未被删除的airport
     */
    public Page findAirportList(Pageable pageable){
        return airportRepo.findByIsDelete(false,pageable);
    }

    /**
     * 保存修改的airport
     */
    public Airport save(Airport airport){
        return airportRepo.save(airport);
    }

    /**
     * 获取机场列表
     * 查找到所有机场
     */
    public List<Airport> findAllAirport(){
        return airportRepo.findByIsDeleteOrderByShortEng(false);
    }


}
