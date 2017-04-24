package cn.configuration;

import cn.interceptor.AdminLoginInterceptor;
import cn.interceptor.AdminMenuInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

/**
 * Created by ChenGeng on 2017/3/8.
 */
@Configuration
public class MyMvcConfiguration extends WebMvcConfigurerAdapter {

    @Autowired
    AdminLoginInterceptor adminLoginInterceptor;

    @Autowired
    AdminMenuInterceptor adminMenuInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        registry.addInterceptor(adminLoginInterceptor).addPathPatterns("/**").excludePathPatterns("/admin/login","/admin/adminlogin","/static/*");
        registry.addInterceptor(adminMenuInterceptor).addPathPatterns("/**").excludePathPatterns("/admin/login","/admin/adminlogin","/static/*");
    }

    @Bean
    public FreeMarkerViewResolver freeMarkerViewResolver() {
        FreeMarkerViewResolver resolver = new FreeMarkerViewResolver();
        resolver.setContentType("text/html; charset=UTF-8");
        resolver.setPrefix("");
        resolver.setSuffix(".ftl");
        resolver.setRequestContextAttribute("request");
        return resolver;
    }

}
