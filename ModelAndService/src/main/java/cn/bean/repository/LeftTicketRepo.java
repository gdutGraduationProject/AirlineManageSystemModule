package cn.bean.repository;

import cn.bean.LeftTicket;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Chen Geng on 2017/4/25.
 */
@Repository
public interface LeftTicketRepo extends CrudRepository<LeftTicket,String> {
}
