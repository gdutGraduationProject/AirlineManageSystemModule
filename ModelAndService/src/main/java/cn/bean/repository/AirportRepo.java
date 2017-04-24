package cn.bean.repository;

import cn.bean.Airport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/26.
 */
@Repository
public interface AirportRepo extends CrudRepository<Airport,String> {

    public Page<Airport> findByIsDelete(boolean isDelete, Pageable pageable);

    public List<Airport> findByIsDeleteOrderByShortEng(boolean isDelete);

}
