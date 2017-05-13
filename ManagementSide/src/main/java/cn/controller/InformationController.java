package cn.controller;

import cn.bean.Staff;
import cn.service.StaffService;
import cn.util.GlobalContants;
import cn.util.MD5Encrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by ChenGeng on 2017/5/12.
 */
@Controller
@RequestMapping("information")
public class InformationController {

    @Autowired
    StaffService staffService;

    MD5Encrypt md5Encrypt = new MD5Encrypt();

    @RequestMapping(value = {"","list"})
    public String checkPage(HttpServletRequest request){
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute(GlobalContants.SESSION_LOGIN_STAFF);

        request.setAttribute("staff",staff);
        return "information/edit";
    }

    @RequestMapping("updateemail")
    public String updateEmail(HttpServletRequest request,String password, String newEmail){
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute(GlobalContants.SESSION_LOGIN_STAFF);
        if(md5Encrypt.passwordCheck(password,staff.getSalt(),staff.getPassword())){
            staff.setCheckedEmail(newEmail);
            staff = staffService.save(staff);
            session.setAttribute(GlobalContants.SESSION_LOGIN_STAFF,staff);
            request.setAttribute("result","操作成功，邮箱修改成功。");
        }else{
            request.setAttribute("result","操作失败，密码输入有误，请重新输入。");
        }
        return "information/result";
    }

    @RequestMapping("updatepassword")
    public String updatePassword(HttpServletRequest request,String oldPassword, String newPassword){
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute(GlobalContants.SESSION_LOGIN_STAFF);
        if(md5Encrypt.passwordCheck(oldPassword,staff.getSalt(),staff.getPassword())){
            staff.setPassword(md5Encrypt.encryption(newPassword,staff.getSalt()));
            staff = staffService.save(staff);
            session.setAttribute(GlobalContants.SESSION_LOGIN_STAFF,staff);
            request.setAttribute("result","操作成功，密码修改成功。");
        }else{
            request.setAttribute("result","操作失败，旧密码输入有误，请重新输入。");
        }
        return "information/result";
    }


}
