package cn.controller;

import cn.bean.Customer;
import cn.service.CustomerService;
import cn.util.GlobalContants;
import cn.util.MD5Encrypt;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Chen Geng on 2017/4/30.
 */
@Controller
@RequestMapping("/personalcenter/password")
public class UpdatePasswordController {

    MD5Encrypt md5Encrypt = new MD5Encrypt();

    @Autowired
    CustomerService customerService;

    @RequestMapping("edit")
    public String edit(){
        return "personalcenter/singlepage/edit";
    }

    @RequestMapping("/update")
    public String update(String oldPassword, String newPassword, HttpServletRequest request){
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        /**
         * 校验旧密码
         */
        boolean result = md5Encrypt.passwordCheck(oldPassword,customer.getSalt(),customer.getPassword());
        if(result == true){
            /**
             * 检验通过，进行加密并保存到DB和Session
             */
            customer.setPassword(md5Encrypt.encryption(newPassword,customer.getSalt()));
            customerService.save(customer);
            session.setAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER,customer);
            request.setAttribute(GlobalContants.REQUEST_SUCCESS_TEXT,"修改成功。");
            return "success";
        }else {
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"旧密码输入有误。");
            return "error";
        }

    }


    @RequestMapping("editquestion")
    public String editquestion(){
        return "personalcenter/singlepage/passwordquestion";
    }

    @RequestMapping("/updatequestion")
    public String updatequestion(HttpServletRequest request,String question,String answer){
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        customer.setPasswordQuestion(question);
        customer.setPasswordAnswer(answer);
        customerService.save(customer);
        session.setAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER,customer);
        request.setAttribute(GlobalContants.REQUEST_SUCCESS_TEXT,"密保问题修改成功。");
        return "success";
    }

}
