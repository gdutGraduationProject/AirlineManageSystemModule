package cn.service;

import cn.ManagementSideStarter;
import cn.bean.Staff;
import cn.bean.repository.StaffRepo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

/**
 * Created by ChenGeng on 2017/3/22.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = ManagementSideStarter.class)
@WebAppConfiguration
public class StaffServiceTest {

    @Autowired
    private StaffService staffService;

    @Autowired
    private StaffRepo staffRepo;

    @Test
    public void test(){
        Pageable pageable = new PageRequest(0,10);
        Page<Staff> staffPage1 = staffService.findByPageable(pageable);
        Page<Staff> staffPage2 = staffRepo.findByIsDelete(false,pageable);
        List<Staff> staffList = staffRepo.findByIsDelete(false);
        System.out.println(staffPage1.getContent().size());
        System.out.println(staffPage2.getContent().size());
        System.out.println(staffList.size());
    }



}
