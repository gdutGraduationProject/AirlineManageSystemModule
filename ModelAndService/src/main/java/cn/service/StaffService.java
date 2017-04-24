package cn.service;

import cn.bean.Staff;
import cn.bean.repository.StaffRepo;
import cn.util.MD5Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by ChenGeng on 2017/2/28.
 */
@Component
public class StaffService {

    @Autowired
    StaffRepo staffRepo;

    MD5Encrypt md5Encrypt = new MD5Encrypt();

    /**
     * 职工登录的方法
     * @param loginUsername 登录的用户名
     * @param loginPassword 登录的密码
     * @return 验证成功返回该职工的对象，登录失败返回null
     */
    public Staff staffLogin(String loginUsername, String loginPassword){
        Staff staff = findStaffByUsernameOrEmail(loginUsername);
        if(staff == null){
            //根据输入的登录名称找不到对应的职员
            return staff;
        }else{
            if(md5Encrypt.passwordCheck(loginPassword,staff.getSalt(),staff.getPassword())){
                //验证通过
                return staff;
            }else{
                //密码验证不通过，返回空
                return null;
            }
        }
    }

    /**
     * 根据职员的用户名或者电子邮件找到该职员
     * @param usernameOrEmail 用户名或电子邮件
     * @return 找到的职员
     */
    public Staff findStaffByUsernameOrEmail(String usernameOrEmail){
        Staff staff = staffRepo.findByUsernameAndIsDelete(usernameOrEmail,false);
        if(staff == null){
            staff = staffRepo.findByCheckedEmailAndIsDelete(usernameOrEmail,false);
        }
        return staff;
    }

    /**
     * 新增职工
     * @return 注册结果
     */
    public Staff saveStaff(Staff staff, String password){
        staff.setSalt(md5Encrypt.createSalt());
        staff.setPassword(md5Encrypt.encryption(password,staff.getSalt()));
        staff = staffRepo.save(staff);
        return staff;
    }

    /**
     * 找到所有的职工信息，包括已禁用的和未被禁用的
     */
    public Page<Staff> findByPageable(Pageable pageable){
        return staffRepo.findByIsDelete(false,pageable);
    }

    /**
     * 根据id找到相应的职工
     * @param id
     */
    public Staff findById(String id){
        return staffRepo.findOne(id);
    }

    /**
     * 修改职工信息，包含修改密码和非修改密码的情况
     * 如果password为空，则表示不修改密码，否则需要修改密码
     */
    public Staff update(Staff staff, String password){
        if(password!=null && !password.equals("")){
            staff.setSalt(md5Encrypt.createSalt());
            staff.setPassword(md5Encrypt.encryption(password,staff.getSalt()));
        }
        staff = staffRepo.save(staff);
        return staff;
    }

    /**
     * 根据id删除相应的职工
     */
    public void deleteStaffById(String id){
        Staff staff = staffRepo.findOne(id);
        staff.setIsDelete(true);
        staffRepo.save(staff);
    }

}
