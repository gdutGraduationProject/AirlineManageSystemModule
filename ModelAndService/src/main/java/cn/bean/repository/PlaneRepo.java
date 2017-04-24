package cn.bean.repository;

import cn.bean.Plane;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/27.
 */
@Repository
public interface PlaneRepo extends CrudRepository<Plane,String> {

    /**
     * 查找所有未被删除的机型的列表
     */
    public Page<Plane> findByIsDelete(boolean isDelete, Pageable pageable);

    public List<Plane> findByIsDeleteOrderByModelName(boolean isDelete);

}
