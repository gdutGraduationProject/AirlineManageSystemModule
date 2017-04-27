package cn.interceptor;

import cn.bean.Customer;
import cn.util.GlobalContants;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Chen Geng on 2017/4/27.
 */
@Component
public class PageHeadInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        HttpSession session = httpServletRequest.getSession();
        Customer customer = (Customer) session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        if(customer == null) {
            /**
             * 尚未登录
             */
            httpServletRequest.setAttribute("isLogin",false);
        } else{
            /**
             * 已经登录
             */
            httpServletRequest.setAttribute("isLogin",true);
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
