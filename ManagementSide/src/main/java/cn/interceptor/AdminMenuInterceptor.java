package cn.interceptor;

import cn.bean.Staff;
import cn.bean.StaffPerms;
import cn.util.GlobalContants;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.DispatcherServletWebRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by ChenGeng on 2017/3/7.
 */
@Component
public class AdminMenuInterceptor implements HandlerInterceptor {
    //用于在管理员端左侧的菜单的初始化操作

    /**
     * 将该用户的操作权限放置到request中，供前端页面读取
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = request.getSession();
        Object staffObj = session.getAttribute(GlobalContants.SESSION_LOGIN_STAFF);
        Staff staff = null;
        if(staffObj == null){
            return true;
        }else{
            String url =  request.getRequestURI();
            staff = (Staff) staffObj;
            List<StaffPerms> staffPermsList = staff.getStaffPerms();
            StaffPerms staffPerms = findActivePerms(url,staffPermsList);
            if(staffPerms!=null){
                staffPerms.setActivStatus(true);
            }

            request.setAttribute("staff",staffObj);
            request.setAttribute("adminMenus",staffPermsList);
            return true;
        }

    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }

    StaffPerms findActivePerms(String url,List<StaffPerms> permss){
        StaffPerms returnPerms = null;
        for (StaffPerms staffPerms : permss) {
            if(url.indexOf(staffPerms.getJumpUrl())>-1){
                returnPerms = staffPerms;
            }else{
                staffPerms.setActivStatus(false);
            }
        }
        return returnPerms;
    }
}
