package cn.controller;

import cn.bean.Plane;
import cn.bean.PlaneClass;
import cn.bean.vo.JqueryDataTablesVo;
import cn.service.PlaneService;
import cn.util.GlobalContants;
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
 * Created by ChenGeng on 2017/3/27.
 */
@Controller
@RequestMapping("/plane")
public class PlaneController {

    @Autowired
    PlaneService planeService;

    @RequestMapping(value = {"list",""},method = RequestMethod.GET)
    public String planeList(){
        return "plane/index";
    }

    @RequestMapping(value = "list",method = RequestMethod.POST)
    @ResponseBody
    public Map query(Pageable pageable, JqueryDataTablesVo jqueryDataTablesVo){
        Map returnModel = new HashMap();

        int pageindex = jqueryDataTablesVo.getiDisplayStart() / jqueryDataTablesVo.getiDisplayLength();
        pageable = new PageRequest(pageindex,  jqueryDataTablesVo.getiDisplayLength());
        Page<Plane> planePage = planeService.findByPageable(pageable);
        long totalElement = planePage.getTotalElements();
        List<Plane> planeList = planePage.getContent();

        returnModel.put("aaData",planeList);
        returnModel.put("iTotalRecords",totalElement);
        returnModel.put("iTotalDisplayRecords",totalElement);

        return returnModel;
    }

    @RequestMapping("/edit")
    public String addPlane(String id, HttpServletRequest request, Map model){
        int classCount ;
        Plane plane = new Plane();
        List<PlaneClass> oldClass = null;
        if(id==null || id.equals("")){
            model.put("isNew",true);
            plane.setIsDisable(false);
            classCount = 0;
        }else{
            model.put("isNew",false);
            plane = planeService.findById(id);
            oldClass = plane.getPlaneClassList();
            classCount = oldClass.size();
            model.put("maxMileage",String.valueOf(plane.getMaxMileage()));
        }
        model.put("classCount",classCount);
        model.put("oldClass",oldClass);
        model.put("plane",plane);
        return "plane/edit";
    }

    @RequestMapping("/update")
    public String updatePlane(HttpServletRequest request, String isNew, Plane plane, int classCount){
        boolean isNewBoolean = Boolean.parseBoolean(isNew);
        List<PlaneClass> planeClassList = new ArrayList<PlaneClass>();
        Plane savePlane = null;
        if(isNewBoolean){
            //提交修改的机型是新的机型
            savePlane = plane;
        }else{
            //提交修改的机型是旧的机型进行编辑
            savePlane = planeService.findById(plane.getId());
            savePlane.setCompany(plane.getCompany());
            savePlane.setModelName(plane.getModelName());
            savePlane.setMaxMileage(plane.getMaxMileage());
            savePlane.setIsDisable(plane.getIsDisable());
        }
        for(int i = 0;i<classCount;i++){
            String classIsNew = request.getParameter(new String("classIsNew"+i));
            boolean classIsNewBoolean = Boolean.parseBoolean(classIsNew);
            PlaneClass planeClass = new PlaneClass();
            planeClass = new PlaneClass();
            planeClass.setName(request.getParameter(new String("name"+i)));
            planeClass.setSimpleName(request.getParameter(new String("simpleName"+i)));
            planeClass.setTotalCount(Integer.valueOf(request.getParameter(new String("totalCount"+i))));
            if(!classIsNewBoolean){
                planeClass.setId(request.getParameter(new String("classId"+i)));
            }
            planeClassList.add(planeClass);
        }
        savePlane.setSeatCount(countTotal(planeClassList));
        savePlane.setPlaneClassList(planeClassList);
        planeService.save(savePlane);
        return "redirect:/plane/list";
    }

    @RequestMapping("/changeDisable")
    @ResponseBody
    public Map changeDisable(String id){
        Map model = new HashMap();
        Plane plane = planeService.findById(id);
        if(plane.getIsDisable()==true){
            plane.setIsDisable(false);
        }else{
            plane.setIsDisable(true);
        }
        planeService.save(plane);
        model.put(GlobalContants.ResponseStatus.SUCCESS,GlobalContants.ResponseStatus.SUCCESS);
        model.put(GlobalContants.RESPONSE_MESSAGE,"修改成功");
        return model;
    }

    /**
     * 统计该list中的客舱一共可容纳的乘客数量
     */
    private int countTotal(List<PlaneClass> planeClassList){
        int total = 0;
        for(PlaneClass planeClass:planeClassList){
            total += planeClass.getTotalCount();
        }
        return total;
    }

}
