package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Chen Geng on 2017/4/25.
 */
@Entity
public class LeftTicketClass extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 该客舱的原编号
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "airline_class_id")
    private AirlineClass airlineClass;

    /**
     * 该客舱总共的座位数
     */
    private int totalCount;

    /**
     * 剩余座位数
     */
    private int leftCount;

    /**
     * 销售座位数
     */
    private int saleCount;

    /**
     * 原价
     */
    private double fullPrice;

    /**
     * 折扣
     */
    private double discount;

    /**
     * 现价
     */
    private double curPrice;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public AirlineClass getAirlineClass() {
        return airlineClass;
    }

    public void setAirlineClass(AirlineClass airlineClass) {
        this.airlineClass = airlineClass;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getLeftCount() {
        return leftCount;
    }

    public void setLeftCount(int leftCount) {
        this.leftCount = leftCount;
    }

    public int getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(int saleCount) {
        this.saleCount = saleCount;
    }

    public double getFullPrice() {
        return fullPrice;
    }

    public void setFullPrice(double fullPrice) {
        this.fullPrice = fullPrice;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getCurPrice() {
        return curPrice;
    }

    public void setCurPrice(double curPrice) {
        this.curPrice = curPrice;
    }
}
