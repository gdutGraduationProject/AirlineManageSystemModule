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
     * 购票时支付的金额
     */
    double payFee;

    /**
     * 航班信息
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "airline_id")
    Airline airline;

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
     * 1：未付款    2：已付款   3：已取消   4.已失效   5.部分退票  6.全部退票
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

    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "left_ticket_class_id")
    LeftTicketClass leftTicketClass;

    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "left_ticket_id")
    LeftTicket leftTicket;

    /**
     * 支付单
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER )
    @JoinColumn(name = "payment_id" )
    Payment payment;

    @OneToMany(cascade=CascadeType.ALL,fetch=FetchType.LAZY)
    private List<SubOrder> subOrderList = new ArrayList<SubOrder>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public String getFlightDay() {
        return flightDay;
    }

    public void setFlightDay(String flightDay) {
        this.flightDay = flightDay;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public int getOrderType() {
        return orderType;
    }

    public void setOrderType(int orderType) {
        this.orderType = orderType;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public boolean getDeleteByCustomer() {
        return deleteByCustomer;
    }

    public void setDeleteByCustomer(boolean deleteByCustomer) {
        this.deleteByCustomer = deleteByCustomer;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public TicketOrder getMainOrder() {
        return mainOrder;
    }

    public void setMainOrder(TicketOrder mainOrder) {
        this.mainOrder = mainOrder;
    }

    public List<SubOrder> getSubOrderList() {
        return subOrderList;
    }

    public void setSubOrderList(List<SubOrder> subOrderList) {
        this.subOrderList = subOrderList;
    }

    public Airline getAirline() {
        return airline;
    }

    public void setAirline(Airline airline) {
        this.airline = airline;
    }

    public LeftTicketClass getLeftTicketClass() {
        return leftTicketClass;
    }

    public void setLeftTicketClass(LeftTicketClass leftTicketClass) {
        this.leftTicketClass = leftTicketClass;
    }

    public double getPayFee() {
        return payFee;
    }

    public void setPayFee(double payFee) {
        this.payFee = payFee;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public LeftTicket getLeftTicket() {
        return leftTicket;
    }

    public void setLeftTicket(LeftTicket leftTicket) {
        this.leftTicket = leftTicket;
    }

    public void updateOrderStatus(){
        int refundCount = 0;
        int leftCount = 0;
        for(SubOrder subOrder:subOrderList){
            if(subOrder.getStatus()==2){
                leftCount++;
            }
            if(subOrder.getStatus()==5){
                refundCount++;
            }
        }
        if(leftCount!=0 && refundCount!=0){
            orderStatus = 5;
        }else if(leftCount==0 && refundCount!=0){
            orderStatus = 6;
        }
    }

}
