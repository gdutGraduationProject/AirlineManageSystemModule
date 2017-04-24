package cn.service;

import cn.bean.StaffPerms;
import cn.bean.repository.StaffPermsRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/19.
 */
@Service
public class StaffPermsService {

    @Autowired
    StaffPermsRepo staffPermsRepo;

    public List<StaffPerms> findAllStaffPerms(){
        return staffPermsRepo.findByIsDelete(false);
    }

    public void save(StaffPerms staffPerms){
        staffPermsRepo.save(staffPerms);
    }

    public StaffPerms findPermsById(String id){
        return staffPermsRepo.findById(id);
    }

}
