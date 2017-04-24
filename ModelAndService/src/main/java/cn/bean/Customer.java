package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;

/**
 * Created by ChenGeng on 2017/2/14.
 */
@Entity
public class Customer extends BaseDomain {

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
     * 未经验证电子邮件地址
     */
    private String newEmail;

    /**
     * 通过验证的电子邮件地址
     */
    private String checkedEmail;

    /**
     * 加密盐
     */
    private String salt;

    /**
     * 加密后的密码
     */
    private String password;

    /**
     * 电子邮件发送时间
     */
    private Date sendMailTime;

    /**
     * 电子邮件发送的链接中编码，采用UUID
     */
    private String urlCode;

    /**
     * 密保问题
     */
    private String passwordQuestion;

    /**
     * 密保答案
     */
    private String passwordAnswer;

    /**
     * 验证通过的手机号码
     */
    private String checkedPhoneNumber;

    /**
     * 未经验证的手机号码
     */
    private String newPhoneNumber;

    /**
     * 短信验证码，6位
     */
    private String phoneCheckNumber;

    /**
     * 短信发送时间
     */
    private Date phoneSendTime;

    /**
     * 短信验证是否通过，1分钟只能发送一条短信
     */
//    @org.hibernate.annotations.Type(type="yes_no")
//    private boolean phoneIsChecked;

    /**
     * 真实姓名
     */
    private String realName;

    /**
     * 身份证号码
     */
    private String idNumber;

    /**
     * 未使用的里程，可用于支付机票，每100旅程可用于支付1元
     */
    private Long remainedDistance;

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

    public String getNewEmail() {
        return newEmail;
    }

    public void setNewEmail(String newEmail) {
        this.newEmail = newEmail;
    }

    public String getCheckedEmail() {
        return checkedEmail;
    }

    public void setCheckedEmail(String checkedEmail) {
        this.checkedEmail = checkedEmail;
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

    public Date getSendMailTime() {
        return sendMailTime;
    }

    public void setSendMailTime(Date sendMailTime) {
        this.sendMailTime = sendMailTime;
    }

    public String getUrlCode() {
        return urlCode;
    }

    public void setUrlCode(String urlCode) {
        this.urlCode = urlCode;
    }

    public String getPasswordQuestion() {
        return passwordQuestion;
    }

    public void setPasswordQuestion(String passwordQuestion) {
        this.passwordQuestion = passwordQuestion;
    }

    public String getPasswordAnswer() {
        return passwordAnswer;
    }

    public void setPasswordAnswer(String passwordAnswer) {
        this.passwordAnswer = passwordAnswer;
    }

    public String getCheckedPhoneNumber() {
        return checkedPhoneNumber;
    }

    public void setCheckedPhoneNumber(String checkedPhoneNumber) {
        this.checkedPhoneNumber = checkedPhoneNumber;
    }

    public String getNewPhoneNumber() {
        return newPhoneNumber;
    }

    public void setNewPhoneNumber(String newPhoneNumber) {
        this.newPhoneNumber = newPhoneNumber;
    }

    public String getPhoneCheckNumber() {
        return phoneCheckNumber;
    }

    public void setPhoneCheckNumber(String phoneCheckNumber) {
        this.phoneCheckNumber = phoneCheckNumber;
    }

    public Date getPhoneSendTime() {
        return phoneSendTime;
    }

    public void setPhoneSendTime(Date phoneSendTime) {
        this.phoneSendTime = phoneSendTime;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public Long getRemainedDistance() {
        return remainedDistance;
    }

    public void setRemainedDistance(Long remainedDistance) {
        this.remainedDistance = remainedDistance;
    }

}
