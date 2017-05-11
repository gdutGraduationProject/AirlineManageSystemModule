package cn.service;

import cn.bean.SubOrder;
import cn.bean.repository.SubOrderRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by ChenGeng on 2017/5/10.
 */
@Service
public class SubOrderService {

    @Autowired
    SubOrderRepo subOrderRepo;


    public SubOrder save(SubOrder subOrder){
        return subOrderRepo.save(subOrder);
    }

}
