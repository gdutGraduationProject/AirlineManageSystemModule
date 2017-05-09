package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by ChenGeng on 2017/5/8.
 */
@Entity
public class Payment extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 支付时间
     */
    Date paymentTime;

    /**
     * 支付单号
     */
    String paymentNum;

    /**
     * 支付类型
     * 1：付款 2：退款
     */
    int paymentType;

    /**
     * 金额
     */
    double paymentMoney;

    /**
     * IP地址
     */
    String ipAddress;

    /**
     * 备注
     */
    String remark;

    /**
     * 关联顾客
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id")
    Customer customer;

}
