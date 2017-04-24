package cn.service;

import cn.bean.Plane;
import cn.bean.repository.PlaneRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/27.
 */
@Component
public class PlaneService {

    @Autowired
    PlaneRepo planeRepo;

    public Page<Plane> findByPageable(Pageable pageable){
        return planeRepo.findByIsDelete(false,pageable);
    }

    public Plane save(Plane plane){
        return planeRepo.save(plane);
    }

    public Plane findById(String id){
        return planeRepo.findOne(id);
    }

    public List<Plane> findAllPlane(){
        return planeRepo.findByIsDeleteOrderByModelName(false);
    }

}
