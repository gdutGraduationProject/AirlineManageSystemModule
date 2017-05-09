package cn.bean;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.ManyToAny;

import javax.persistence.*;

/**
 * Created by ChenGeng on 2017/5/9.
 */
@Entity
public class SubOrder {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /*
    该子订单对应的旅客信息
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "common_passager_id")
    CommonPassager commonPassager;

    /**
     * 订单状态
     * 1：未付款    2：已付款   3：已取消   4：已失效   5：已退票   6：已改签
     */
    int status;

    @ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="ticket_order_id")
    TicketOrder ticketOrder;

    /**
     * 改签订单
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "alter_ticket_order_id")
    TicketOrder alterTicketOrder;

    /**
     * 退款支付单号,当该订单被退款时有效
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "refund_payment_id")
    Payment payment;

}
