package cn.bean.repository;

import cn.bean.StaffPerms;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ChenGeng on 2017/2/28.
 */
@Repository
public interface StaffPermsRepo extends CrudRepository<StaffPerms, String> {

    /**
     * 找到所有未被删除的管理员菜单
     */
    public List<StaffPerms> findByIsDelete(boolean isDelete);

    /**
     * 根据id找到相应的管理员菜单
     */
    public StaffPerms findById(String id);

}
