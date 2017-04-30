package cn.bean.repository;

import cn.bean.CommonPassager;
import cn.bean.Customer;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Chen Geng on 2017/4/30.
 */
@Repository
public interface CommonPassagerRepo extends CrudRepository<CommonPassager,String> {

    public List<CommonPassager> findByIsDeleteAndAndCustomerOrderByCreateDate(boolean isDelete, Customer customer);

}
