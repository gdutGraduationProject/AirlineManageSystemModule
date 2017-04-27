package cn.controller;

import cn.bean.Customer;
import cn.service.CustomerService;
import cn.util.UuidGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Chen Geng on 2017/4/26.
 */
@Controller
public class CustomerRegisterController {

    @Autowired
    CustomerService customerService;

    UuidGenerator uuidGenerator = new UuidGenerator();

    /**
     * 跳转到注册页面
     */
    @RequestMapping("/registePage")
    public String registeRedirect(){
        return "prelogin/register";
    }

    @RequestMapping("/registe")
    public String userRegiste(HttpServletRequest request, Customer customer){
        customerService.encryptCustomerPassword(customer);
        customer.setUrlCode(uuidGenerator.uuidGenerate());
        customerService.save(customer);
        /**
         * 发送电子邮件
         */
        return "index";
    }

}



