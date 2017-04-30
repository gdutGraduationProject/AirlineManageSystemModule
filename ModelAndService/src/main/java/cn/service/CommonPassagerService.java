package cn.service;

import cn.bean.CommonPassager;
import cn.bean.Customer;
import cn.bean.repository.CommonPassagerRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Chen Geng on 2017/4/30.
 */
@Service
public class CommonPassagerService {

    @Autowired
    CommonPassagerRepo commonPassagerRepo;

    public CommonPassager findById(String id){
        return commonPassagerRepo.findOne(id);
    }

    public CommonPassager save(CommonPassager commonPassager){
        return commonPassagerRepo.save(commonPassager);
    }

    /**
     * 删除常用旅客，若根据id找不到该常用旅客或该旅客信息已被删除，则返回false，否则返回true
     * @param id
     * @return
     */
    public boolean deleteCommonPassager(String id){
        CommonPassager commonPassager = commonPassagerRepo.findOne(id);
        if(commonPassager == null || commonPassager.getIsDelete()==true){
            return false;
        }else{
            commonPassager.setIsDelete(true);
            commonPassagerRepo.save(commonPassager);
            return true;
        }
    }

    public List<CommonPassager> findListByCustomer(Customer customer){
        return commonPassagerRepo.findByIsDeleteAndAndCustomerOrderByCreateDate(false,customer);
    }

}
