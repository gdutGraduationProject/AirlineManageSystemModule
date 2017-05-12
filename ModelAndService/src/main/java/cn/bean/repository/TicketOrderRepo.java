package cn.bean.repository;

import cn.bean.Customer;
import cn.bean.TicketOrder;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Repository
public interface TicketOrderRepo extends CrudRepository<TicketOrder, String> {

    public List<TicketOrder> findByDeleteByCustomerAndCustomerAndIsDeleteOrderByOrderTimeDesc(boolean deleteByCustomer, Customer customer, boolean isDelete );

    public List<TicketOrder> findByOrderStatusAndIsDelete(int orderStatus, boolean isDelete);

}
