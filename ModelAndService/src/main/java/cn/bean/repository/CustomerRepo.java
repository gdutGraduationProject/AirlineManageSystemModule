package cn.bean.repository;

import cn.bean.Customer;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by ChenGeng on 2017/2/15.
 */
@Repository
public interface CustomerRepo extends CrudRepository<Customer,String> {

    /**
     * 根据用户名找到用户
     */
    public Customer findByUsernameAndIsDelete(String username, Boolean isDelete);

    /*
     * 根据已经验证的手机号码找到用户
     */
    public Customer findByCheckedPhoneNumberAndIsDelete(String checkedPhoneNumber, Boolean isDelete);

    /*
     * 根据已经验证的邮箱地址找到用户
     */
    public Customer findByCheckedEmailAndIsDelete(String checkedEmail, Boolean isDelete);
}
