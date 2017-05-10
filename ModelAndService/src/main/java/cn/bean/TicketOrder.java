package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/8.
 */
@Entity
public class TicketOrder extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 下单时间
     */
    Date orderTime;

    /**
     * 订单号
     */
    String orderNum;

    /**
     * 航班日期
     */
    String flightDay;

    /**
     * 订单状态
     * 1：未付款    2：已付款   3：已取消   4.已失效
     * 备注：下单成功后需在10分钟内付款，否则订单自动失效，无法继续支付，座位退回
     */
    int orderStatus;

    /**
     * 订单类型
     * 1：一般订单，即主订单  2：改签订单，即主订单的改签订单
     */
    int orderType;

    /**
     * 下单时间
     */
    Date orderDate;

    /**
     * 顾客是否在订单中心中删除了此订单
     */
    @org.hibernate.annotations.Type(type="yes_no")
    boolean deleteByCustomer;

    /**
     * 顾客
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id")
    Customer customer;

    /**
     * 主订单，当订单类型为 2 时不为空
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "main_order_id", nullable = true)
    TicketOrder mainOrder;

    @OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY)
    private List<SubOrder> subOrderList = new ArrayList<SubOrder>();


}
