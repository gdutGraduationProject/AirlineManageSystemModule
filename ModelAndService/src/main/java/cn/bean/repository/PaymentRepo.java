package cn.bean.repository;

import cn.bean.Payment;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Repository
public interface PaymentRepo extends CrudRepository<Payment, String> {
}
