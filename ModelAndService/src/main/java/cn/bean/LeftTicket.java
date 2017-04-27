package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Chen Geng on 2017/4/25.
 */
@Entity
public class LeftTicket extends BaseDomain{

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 出发日期
     */
    private Date departureDate;

    /**
     * 航班信息
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "airline_id")
    private Airline airline;

    /**
     * 最低价格
     */
    private double minPrice;

    /**
     * 已销售的机票数
     */
    private int saleTicketCount;

    /**
     * 剩余机票数
     */
    private int leftTicketCount;

    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
    @JoinTable(name = "leftticket_links_class",
            joinColumns ={@JoinColumn(name = "leftticket_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "leftticket_class_id", referencedColumnName = "id")
            })
    private List<LeftTicketClass> leftTicketClassList = new ArrayList<LeftTicketClass>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDepartureDate() {
        return departureDate;
    }

    public void setDepartureDate(Date departureDate) {
        this.departureDate = departureDate;
    }

    public Airline getAirline() {
        return airline;
    }

    public void setAirline(Airline airline) {
        this.airline = airline;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public int getSaleTicketCount() {
        return saleTicketCount;
    }

    public void setSaleTicketCount(int saleTicketCount) {
        this.saleTicketCount = saleTicketCount;
    }

    public int getLeftTicketCount() {
        return leftTicketCount;
    }

    public void setLeftTicketCount(int leftTicketCount) {
        this.leftTicketCount = leftTicketCount;
    }

    public List<LeftTicketClass> getLeftTicketClassList() {
        return leftTicketClassList;
    }

    public void setLeftTicketClassList(List<LeftTicketClass> leftTicketClassList) {
        this.leftTicketClassList = leftTicketClassList;
    }
}
