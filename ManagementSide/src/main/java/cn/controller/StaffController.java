package cn.controller;

import cn.bean.Staff;
import cn.bean.StaffPerms;
import cn.bean.vo.JqueryDataTablesVo;
import cn.service.StaffPermsService;
import cn.service.StaffService;
import cn.util.GlobalContants;
import cn.util.lang.Copys;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ChenGeng on 2017/3/19.
 */
@Controller
@RequestMapping("/staff")
public class StaffController {

    @Autowired
    StaffPermsService staffPermsService;

    @Autowired
    StaffService staffService;

    @RequestMapping(value = {"list",""},method = RequestMethod.GET)
    public String staffList(){
        return "staff/index";
    }


    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map query( Pageable pageable,JqueryDataTablesVo jqueryDataTablesVo){
        Map returnModel = new HashMap();

        int pageindex = jqueryDataTablesVo.getiDisplayStart() / jqueryDataTablesVo.getiDisplayLength();
        pageable = new PageRequest(pageindex,  jqueryDataTablesVo.getiDisplayLength());
        Page<Staff> staffPage = staffService.findByPageable(pageable);
        long totalElement = staffPage.getTotalElements();
        List<Staff> staffList = staffPage.getContent();
        List<Staff> newList = new ArrayList<Staff>();
        for(Staff staff:staffList){
            staff.setStaffPerms(null);
            newList.add(staff);
        }

        returnModel.put("aaData",newList);
        returnModel.put("iTotalRecords",totalElement);
        returnModel.put("iTotalDisplayRecords",totalElement);

        return returnModel;
    }

    @RequestMapping("/edit")
    public String addStaff(String id, HttpServletRequest request,Map model){
        Staff staff = new Staff();
        List<StaffPerms> staffPermsList = staffPermsService.findAllStaffPerms();
        List<StaffPerms> oldPerms = null;
        if(id==null || id.equals("")){
            model.put("isNew",true);
            staff.setIsDisable(false);
        }else{
            model.put("isNew",false);
            staff = staffService.findById(id);
            oldPerms = staff.getStaffPerms();
        }
        model.put("oldPerms",oldPerms);
        model.put("staffPerms",staffPermsList);
        model.put("editStaff",staff);
        return "staff/edit";
    }

    @RequestMapping("/update")
    public String updateStaff(String isNew,Staff staff,HttpServletRequest request,String[] staffPerms,int disable){
        boolean isNewBoolean = Boolean.parseBoolean(isNew);
        List<StaffPerms> staffPermss = new ArrayList<StaffPerms>();
        Staff saveStaff;
        if(staffPerms!=null && staffPerms.length>0){
            for(String id:staffPerms){
                StaffPerms perms = staffPermsService.findPermsById(id);
                staffPermss.add(perms);
            }
        }

        if(isNewBoolean){
            //提交修改的职员是新的职员
            staff.setIsDelete(false);
            saveStaff = staff;

        }else{
            //提交修改的职员是旧的职员进行编辑
            saveStaff = staffService.findById(staff.getId());
            saveStaff.setRealName(staff.getRealName());
            saveStaff.setCheckedEmail(staff.getCheckedEmail());
            saveStaff.setPosts(staff.getPosts());
        }
        if (disable==0){
            saveStaff.setIsDisable(false);
        }else{
            saveStaff.setIsDisable(true);
        }
        saveStaff.setStaffPerms(staffPermss);
        if(isNewBoolean){
            staffService.saveStaff(saveStaff,staff.getPassword());
        }else{
            if(staff.getPassword()==null || staff.getPassword().equals("")){
                staffService.update(saveStaff,null);
            }else{
                staffService.update(saveStaff,staff.getPassword());
            }
        }
        return "redirect:/staff/list";
    }

    @RequestMapping("/changeDisable")
    @ResponseBody
    public Map changeDisable(String id){
        Map model = new HashMap();
        Staff staff = staffService.findById(id);
        if(staff.getIsDisable()==true){
            staff.setIsDisable(false);
        }else{
            staff.setIsDisable(true);
        }
        staffService.saveStaff(staff,null);
        model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
        model.put(GlobalContants.RESPONSE_MESSAGE,"修改成功");
        return model;
    }

    @RequestMapping(value = {"delete"},method = RequestMethod.POST)
    @ResponseBody
    public Map delete(String id){
        Map model = new HashMap();
            staffService.deleteStaffById(id);
            model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
            model.put(GlobalContants.RESPONSE_MESSAGE,"删除成功");
        return model;
    }
}
