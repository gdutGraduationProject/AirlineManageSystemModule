package cn.bean.repository;

import cn.bean.Staff;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by ChenGeng on 2017/2/28.
 */
@Repository
public interface StaffRepo extends CrudRepository<Staff, String> {

    public Staff findByUsernameAndIsDelete(String usernmae, boolean isDelete);

    public Staff findByCheckedEmailAndIsDelete(String checkedEmail, boolean isDelete);

    public Page<Staff> findByIsDelete(boolean isDelete, Pageable pageable);

    public List<Staff> findByIsDelete(boolean isDelete);

}
