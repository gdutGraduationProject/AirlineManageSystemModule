package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * Created by Chen Geng on 2017/4/8.
 */
@Entity
public class AirlineClass extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 该舱位的名称，如经济舱、商务舱等
     */
    private String name;

    /**
     * 该舱位的英文简称，如Y、X等
     */
    private String simpleName;

    /**
     * 该舱位的人数
     */
    private int totalCount;

    /**
     * 全价
     */
    private double fullPrice;

    /**
     * 默认折扣
     */
    private double defaultDiscount;

    /**
     * 分隔时间，按起飞时间前几个钟
     * 如起飞前2小时前和起飞前2小时后，退票/改签价格不一样。
     */
    private int splitTime;

    /**
     * 分隔时间前退票的费用
     */
    private double beforeRefundFee;

    /**
     * 分隔时间后退票的费用
     */
    private double afterRefundFee;

    /**
     * 分隔时间前改签的费用
     */
    private double beforeChangeFee;

    /**
     * 分隔时间后改签的费用
     */
    private double afterChangeFee;

    /**
     * 该航线舱位与机型舱位的对应
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "plane_class_id")
    private PlaneClass planeClass;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSimpleName() {
        return simpleName;
    }

    public void setSimpleName(String simpleName) {
        this.simpleName = simpleName;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public double getFullPrice() {
        return fullPrice;
    }

    public void setFullPrice(double fullPrice) {
        this.fullPrice = fullPrice;
    }

    public double getDefaultDiscount() {
        return defaultDiscount;
    }

    public void setDefaultDiscount(double defaultDiscount) {
        this.defaultDiscount = defaultDiscount;
    }

    public int getSplitTime() {
        return splitTime;
    }

    public void setSplitTime(int splitTime) {
        this.splitTime = splitTime;
    }

    public double getBeforeRefundFee() {
        return beforeRefundFee;
    }

    public void setBeforeRefundFee(double beforeRefundFee) {
        this.beforeRefundFee = beforeRefundFee;
    }

    public double getAfterRefundFee() {
        return afterRefundFee;
    }

    public void setAfterRefundFee(double afterRefundFee) {
        this.afterRefundFee = afterRefundFee;
    }

    public double getBeforeChangeFee() {
        return beforeChangeFee;
    }

    public void setBeforeChangeFee(double beforeChangeFee) {
        this.beforeChangeFee = beforeChangeFee;
    }

    public double getAfterChangeFee() {
        return afterChangeFee;
    }

    public void setAfterChangeFee(double afterChangeFee) {
        this.afterChangeFee = afterChangeFee;
    }

    public PlaneClass getPlaneClass() {
        return planeClass;
    }

    public void setPlaneClass(PlaneClass planeClass) {
        this.planeClass = planeClass;
    }
}
