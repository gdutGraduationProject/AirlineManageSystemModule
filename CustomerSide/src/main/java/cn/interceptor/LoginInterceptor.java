package cn.interceptor;

import cn.util.GlobalContants;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * Created by ChenGeng on 2017/3/19.
 */
@Component
public class LoginInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        HttpSession session = request.getSession();
        Object object = session.getAttribute(GlobalContants.SESSION_LOGIN_CUSTOMER);
        if(object==null){
            //该用户尚未登录
            session.setAttribute(GlobalContants.SESSION_LOGIN_BACK_URL,request.getRequestURI());
            Map map=request.getParameterMap();
            Set keSet=map.entrySet();
            StringBuffer buffer = new StringBuffer();
            buffer.append("?");
            for(Iterator itr = keSet.iterator(); itr.hasNext();){

                Map.Entry me=(Map.Entry)itr.next();
                Object ok=me.getKey();
                Object ov=me.getValue();
                String[] value=new String[1];
                if(ov instanceof String[]){
                    value=(String[])ov;
                }else{
                    value[0]=ov.toString();
                }

                for(int k=0;k<value.length;k++){
                    buffer.append(ok);
                    buffer.append("=");
                    buffer.append(value[k]);
                    buffer.append("&&");
                }
            }
            String parameterString = buffer.toString();
            if (parameterString.length()==1)
            {
                parameterString = new String();
            }else {
                parameterString = parameterString.substring(0,parameterString.length()-2);
            }
            session.setAttribute(GlobalContants.SESSION_LOGIN_BACK_PARAMETER_STRING,parameterString);

            response.sendRedirect("/loginPage");
            return false;
        }else{
            //该用户已经登录
            return true;
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
