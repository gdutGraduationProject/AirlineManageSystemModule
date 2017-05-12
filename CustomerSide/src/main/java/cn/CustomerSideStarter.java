package cn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Created by Chen Geng on 2017/4/26.
 */
@SpringBootApplication
@EnableScheduling
@EntityScan("cn.bean")
@EnableJpaRepositories("cn.bean.repository")
@ComponentScan(basePackages = {"cn.controller","cn.service","cn.interceptor","cn.timer","cn.configuration"})
public class CustomerSideStarter {

    public static void main(String[] args) {
        SpringApplication.run(CustomerSideStarter.class,args);

    }
}
