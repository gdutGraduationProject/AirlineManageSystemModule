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
public class Staff extends BaseDomain implements Serializable {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 用户名
     */
    private String username;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 加密盐
     */
    private String salt;

    /**
     * 加密后的密码
     */
    private String password;

    /**
     * 是否被禁用
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private Boolean isDisable;

    /**
     * 工作岗位
     */
    private String posts;

    /**
     * 通过验证的电子邮件地址
     */
    private String checkedEmail;

    /**
     * 该职工的权限
     */
    @ManyToMany(cascade = CascadeType.PERSIST, fetch = FetchType.LAZY)
    @JoinTable(name = "staff_links_staff_perms",
            joinColumns ={@JoinColumn(name = "staff_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "staff_perms_id", referencedColumnName = "id")
            })
    private List<StaffPerms> staffPerms = new ArrayList<StaffPerms>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getIsDisable() {
        return isDisable;
    }

    public void setIsDisable(Boolean disable) {
        isDisable = disable;
    }

    public String getPosts() {
        return posts;
    }

    public void setPosts(String posts) {
        this.posts = posts;
    }

    public List<StaffPerms> getStaffPerms() {
        return staffPerms;
    }

    public void setStaffPerms(List<StaffPerms> staffPerms) {
        this.staffPerms = staffPerms;
    }

    public String getCheckedEmail() {
        return checkedEmail;
    }

    public void setCheckedEmail(String checkedEmail) {
        this.checkedEmail = checkedEmail;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
}
