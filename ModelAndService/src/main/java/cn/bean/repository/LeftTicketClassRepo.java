package cn.bean.repository;

import cn.bean.LeftTicketClass;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Chen Geng on 2017/4/25.
 */
@Repository
public interface LeftTicketClassRepo extends CrudRepository<LeftTicketClass,String> {
}
