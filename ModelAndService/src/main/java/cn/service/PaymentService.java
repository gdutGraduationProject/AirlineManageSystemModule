package cn.service;

import cn.bean.Payment;
import cn.bean.repository.PaymentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by ChenGeng on 2017/5/11.
 */
@Service
public class PaymentService {

    @Autowired
    PaymentRepo paymentRepo;


    public Payment save(Payment payment){
        return paymentRepo.save(payment);
    }

}
