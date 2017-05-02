package cn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * Created by ChenGeng on 2017/2/14.
 */

@SpringBootApplication
@EntityScan("cn.bean")
@EnableJpaRepositories("cn.bean.repository")
@ComponentScan(basePackages = {"cn.controller","cn.service","cn.interceptor","cn.configuration"})
public class ManagementSideStarter {

    public static void main(String[] args) {
        SpringApplication.run(ManagementSideStarter.class,args);

    }

}
