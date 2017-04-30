package cn.controller;

import cn.bean.CommonPassager;
import cn.bean.Customer;
import cn.service.CommonPassagerService;
import cn.util.GlobalContants;
import org.apache.catalina.servlet4preview.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Chen Geng on 2017/4/30.
 */
@Controller
@RequestMapping("/personalcenter/commonpassager")
public class CommonPassagerController {

    @Autowired
    CommonPassagerService commonPassagerService;

    @RequestMapping("list")
    public String passagerlist(HttpServletRequest request){
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        List<CommonPassager> commonPassagerList = commonPassagerService.findListByCustomer(customer);
        if(commonPassagerList==null || commonPassagerList.size()==0){
            request.setAttribute("isNull","true");
        }else{
            request.setAttribute("isNull","false");
        }
        request.setAttribute("passagerList",commonPassagerList);
        return "personalcenter/commonpassager/list";
    }

    @RequestMapping("edit")
    public String editPassager(HttpServletRequest request,String id){
        CommonPassager commonPassager = new CommonPassager();
        if(id!=null && !id.equals("")){
            commonPassager = commonPassagerService.findById(id);
        }else{
            commonPassager.setIdType("身份证");
            commonPassager.setSex("男");
        }
        request.setAttribute("commonPassager",commonPassager);
        return "personalcenter/commonpassager/edit";
    }

    @RequestMapping("update")
    public String updatePassager(HttpServletRequest request, String oldId, CommonPassager commonPassager){
        if(oldId!=null && !oldId.equals("")){
            commonPassagerService.deleteCommonPassager(oldId);
        }
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        commonPassager.setCustomer(customer);
        commonPassagerService.save(commonPassager);
        return "redirect:/personalcenter/commonpassager/list";
    }

    @RequestMapping("delete")
    public String delete(String id){
        commonPassagerService.deleteCommonPassager(id);
        return "redirect:/personalcenter/commonpassager/list";
    }

}
