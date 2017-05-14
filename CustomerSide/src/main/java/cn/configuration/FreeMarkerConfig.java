package cn.configuration;

import cn.util.EncodeURLMethod;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.resource.ResourceUrlProvider;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.servlet.ServletContext;

/**
 * Created by xiaoqian on 2016/10/12.
 */
@Configuration
public class FreeMarkerConfig  implements InitializingBean,ServletContextAware {
    @Autowired
    FreeMarkerConfigurer freeMarkerConfigurer;

    /**
     * 项目静态内容路径
     */
    @Value("${context.ctx}")
    private String dynaContentPath;

    @Value("${context.myname}")
    private String myName;

    @Value("${context.myemail}")
    private String myEmail;

    @Autowired
    ResourceUrlProvider resourceUrlProvider;
    @Bean
    public EncodeURLMethod encodeURLMethod(){
        return new EncodeURLMethod(resourceUrlProvider);
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        //设置各个内容的访问前缀，没有配置为contextpath
        freemarker.template.Configuration configuration = freeMarkerConfigurer.getConfiguration();
        String projectContextPath = servletContext.getContextPath();
        configuration.setSharedVariable("ctx",dynaContentPath);
        configuration.setSharedVariable("myname",myName);
        configuration.setSharedVariable("myemail",myEmail);
        if(StringUtils.isEmpty(dynaContentPath)){
            configuration.setSharedVariable("ctx",projectContextPath);
            configuration.setSharedVariable("myname",myName);
            configuration.setSharedVariable("myemail",myEmail);
        }
        freeMarkerConfigurer.getConfiguration().setSharedVariable("_v",encodeURLMethod());
    }

    ServletContext servletContext;
    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
