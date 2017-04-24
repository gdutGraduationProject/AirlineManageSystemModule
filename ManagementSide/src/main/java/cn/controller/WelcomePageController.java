package cn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ChenGeng on 2017/3/19.
 */
@Controller
public class WelcomePageController {

    @RequestMapping("/")
    public String welcomePage(){
        return "index";
    }

}
