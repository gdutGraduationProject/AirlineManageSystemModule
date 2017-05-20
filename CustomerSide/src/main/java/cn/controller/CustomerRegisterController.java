package cn.controller;

import cn.bean.Customer;
import cn.service.CustomerService;
import cn.util.EmailSendTool;
import cn.util.GlobalContants;
import cn.util.UuidGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Chen Geng on 2017/4/26.
 */
@Controller
public class CustomerRegisterController {

    @Autowired
    CustomerService customerService;

    UuidGenerator uuidGenerator = new UuidGenerator();

    EmailSendTool emailSendTool = new EmailSendTool();

    /**
     * 跳转到注册页面
     */
    @RequestMapping("/registePage")
    public String registeRedirect(){
        return "prelogin/register";
    }

    @RequestMapping("/registe")
    public String userRegiste(HttpServletRequest request, Customer customer){
        customer = customerService.encryptCustomerPassword(customer);
        customer.setUrlCode(uuidGenerator.uuidGenerate());
        customer = customerService.save(customer);
        /**
         * 发送电子邮件
         */
        emailSendTool.sendConfirmEmail(customer);
        request.setAttribute(GlobalContants.REQUEST_SUCCESS_TEXT,"注册成功，请到注册邮箱中查收确认邮件！");
        return "success";
    }

    @RequestMapping("sameusername")
    @ResponseBody
    public String sameUsername(String username){
        Customer customer = customerService.findCustomer(username);
        if(customer == null){
            return "true";
        }else{
            return "false";
        }
    }

    @RequestMapping("/registeverify")
    public String verify(String customerid, String uri, HttpServletRequest request){
        HttpSession session = request.getSession();
        Customer customer = customerService.findCustomerById(customerid);
        if(customer.getUrlCode()==null || customer.getUrlCode().equals("")){
            //错误页面
            request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"您已通过验证，无需再次验证！");
            return "error";
        }else{
            if(customer.getUrlCode().equals(uri)){
                /**
                 * 验证通过
                 */
                customer.setUrlCode(null);
                customer.setCheckedEmail(customer.getNewEmail());
                customer.setNewEmail(null);
                customerService.save(customer);
                request.setAttribute(GlobalContants.REQUEST_SUCCESS_TEXT,"验证成功，您现在可以通过该邮箱登陆了！");
                return "success";
            }else{
                /**
                 * 验证不通过
                 */
                request.setAttribute(GlobalContants.REQUEST_ERROR_REASON,"验证失败，请重试！");
                return "error";
            }
        }
    }

}



