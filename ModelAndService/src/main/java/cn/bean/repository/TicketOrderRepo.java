package cn.bean.repository;

import cn.bean.TicketOrder;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Repository
public interface TicketOrderRepo extends CrudRepository<TicketOrder, String> {
}
