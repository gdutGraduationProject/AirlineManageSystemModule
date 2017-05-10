package cn.controller;

import cn.bean.Airport;
import cn.bean.Customer;
import cn.service.AirportService;
import cn.service.CustomerService;
import cn.util.GlobalContants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by ChenGeng on 2017/2/15.
 */
@Controller
public class LoginController {

    @Autowired
    CustomerService customerService;

    @Autowired
    AirportService airportService;

    @RequestMapping("loginPage")
    public String loginPage(){
        return "prelogin/login";
    }

    @RequestMapping("/loginconfirm")
    public String customerLogin(HttpServletRequest request, String loginUsername, String password, Map model){
        Customer customer = customerService.customerLogin(loginUsername,password);
        if(customer == null){
            model.put(GlobalContants.SESSION_ERROR_REASON,"用户不存在或密码错误");
            return "prelogin/login";
        }else{
            HttpSession session = request.getSession();
            session.setAttribute(GlobalContants.SESSION_LOGIN_USER_TYPE, GlobalContants.UserType.CUSTOMER);
            session.setAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER,customer);
            String nextUrl = (String)session.getAttribute(GlobalContants.SESSION_LOGIN_BACK_URL);
            String parameterString = (String)session.getAttribute(GlobalContants.SESSION_LOGIN_BACK_PARAMETER_STRING);
            if(nextUrl==null || nextUrl.equals("")){
                nextUrl = new String("/index");
            }
            if(parameterString == null || parameterString.equals("")){
                return "redirect:"+nextUrl;
            }else {
                return "redirect:"+nextUrl+parameterString;
            }

        }
    }

    @RequestMapping("logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute(GlobalContants.SESSION_LOGIN_USER_TYPE);
        session.removeAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        return "redirect:/index";
    }


}
