package cn.controller;

import cn.bean.Staff;
import cn.bean.StaffPerms;
import cn.bean.repository.StaffPermsRepo;
import cn.service.StaffPermsService;
import cn.service.StaffService;
import cn.util.GlobalContants;
import cn.util.ListCopy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ChenGeng on 2017/2/27.
 */
@Controller
@RequestMapping("/admin")
public class AdminLoginController {

    @Autowired
    StaffService staffService;

    @Autowired
    StaffPermsService staffPermsService;

    @RequestMapping("/login")
    public String administratorLogin(HttpServletRequest request){

        return "loginpage";
    }

    @RequestMapping("/adminlogin")
    public String administratorLogin(HttpServletRequest request,String username, String password){
        Staff staff = staffService.staffLogin(username,password);
        HttpSession session = request.getSession();
        if(staff == null){
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"用户名不存在或密码错误");
            request.setAttribute("isLoginFail",true);

            /**
             * 测试用，暂时没有职员用户
             */
//            session.setAttribute(GlobalContants.SESSION_LOGIN_USER_TYPE, GlobalContants.UserType.STAFF);
//            staff = new Staff();
//            StaffPerms staffPerms = new StaffPerms();
//            staffPerms.setJumpUrl("1111111111");
//            staffPerms.setMenuText("111111");
//            staffPerms.setIsDelete(true);
//            List<StaffPerms> staffPermss = new LinkedList<StaffPerms>();
//            staffPermss.add(staffPerms);
//            staffPerms = new StaffPerms();
//            staffPerms.setJumpUrl("222222");
//            staffPerms.setMenuText("2222222");
//            staffPerms.setIsDelete(false);
//            staffPermss.add(staffPerms);
//            staff.setStaffPerms(staffPermss);
//            session.setAttribute(GlobalContants.SESSION_LOGIN_STAFF,staff);
//            return "index";
            /**
             * 测试用，暂时没有职员用户
             */



            return "login";
        }else{
            if(staff.getIsDisable()==true){
                request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"账户已被冻结");
                request.setAttribute("isLoginFail",true);
                return "login";
            }else{
                staff.setStaffPerms(ListCopy.copy(staff.getStaffPerms()));
                session.setAttribute(GlobalContants.SESSION_LOGIN_USER_TYPE, GlobalContants.UserType.STAFF);
                session.setAttribute(GlobalContants.SESSION_LOGIN_STAFF,staff);
                String nextUrl = (String)session.getAttribute(GlobalContants.SESSION_LOGIN_BACK_URL);
                if(nextUrl==null || nextUrl.equals("")){
                    nextUrl = new String("redirect:/admin/index");
                }
                return nextUrl;
            }
        }
    }

    @RequestMapping("/index")
    public String backToIndex(){
        return "index";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute(GlobalContants.SESSION_LOGIN_STAFF);
        session.removeAttribute(GlobalContants.SESSION_LOGIN_USER_TYPE);
        return "admin/login";
    }

}
