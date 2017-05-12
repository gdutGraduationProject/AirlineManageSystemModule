package cn.bean.repository;

import cn.bean.Airline;
import cn.bean.Airport;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Chen Geng on 2017/4/12.
 */
@Repository
public interface AirlineRepo extends CrudRepository<Airline, String> {

    public List<Airline> findByIsDelete(boolean isDelete);

    public Page<Airline> findByIsDeleteOrderByStatus(boolean isDelete, Pageable pageable);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndSunday(boolean isDelete, int status, Airport departure, Airport destination,boolean sunday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndMonday(boolean isDelete, int status, Airport departure, Airport destination,boolean monday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndTuesday(boolean isDelete, int status, Airport departure, Airport destination,boolean tuesday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndWednesday(boolean isDelete, int status, Airport departure, Airport destination,boolean wednesday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndThursday(boolean isDelete, int status, Airport departure, Airport destination,boolean thursday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndFriday(boolean isDelete, int status, Airport departure, Airport destination,boolean friday);

    public List<Airline> findByIsDeleteAndStatusAndDepartureAndDestinationAndSaturday(boolean isDelete, int status, Airport departure, Airport destination,boolean saturday);

}
