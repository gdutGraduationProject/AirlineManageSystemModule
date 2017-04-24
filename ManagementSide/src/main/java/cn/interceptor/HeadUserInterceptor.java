package cn.interceptor;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by ChenGeng on 2017/2/27.
 */
@WebFilter(filterName="myFilter",urlPatterns="/*")
public class HeadUserInterceptor implements Filter {
    //用于初始化页面上方的导航栏的用户名称等

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpSession session = request.getSession();
    }

    @Override
    public void destroy() {

    }
}
