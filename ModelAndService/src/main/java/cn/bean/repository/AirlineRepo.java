package cn.bean.repository;

import cn.bean.Airline;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by Chen Geng on 2017/4/12.
 */
@Repository
public interface AirlineRepo extends CrudRepository<Airline, String> {

    public Page<Airline> findByIsDeleteOrderByStatus(boolean isDelete, Pageable pageable);

}
