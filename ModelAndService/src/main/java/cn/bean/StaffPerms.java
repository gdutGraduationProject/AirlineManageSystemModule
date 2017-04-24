package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ChenGeng on 2017/2/14.
 */
@Entity
public class StaffPerms extends BaseDomain implements Serializable {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 菜单项的文字显示
     */
    private String menuText;

    /**
     * 跳转的url
     */
    private String jumpUrl;

    @Transient
    private Boolean activStatus = false;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMenuText() {
        return menuText;
    }

    public void setMenuText(String menuText) {
        this.menuText = menuText;
    }

    public String getJumpUrl() {
        return jumpUrl;
    }

    public void setJumpUrl(String jumpUrl) {
        this.jumpUrl = jumpUrl;
    }

    public Boolean getActivStatus() {
        return activStatus;
    }

    public void setActivStatus(Boolean activStatus) {
        this.activStatus = activStatus;
    }
}
