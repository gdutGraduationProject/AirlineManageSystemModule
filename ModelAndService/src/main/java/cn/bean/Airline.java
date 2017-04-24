package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Chen Geng on 2017/4/8.
 */
@Entity
public class Airline extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 航班号
     */
    private String airlineNum;

    /**
     * 出发机场
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "departure_airport_id")
    private Airport departure;

    /**
     * 出发时间
     */
    private Date startTime;

    /**
     * 到达机场
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "destination_airport_id")
    private Airport destination;

    /**
     * 到达时间
     */
    private Date arriveTime;

    /**
     * 里程
     */
    private int mileage;

    /**
     * 采用的机型
     */
    @OneToOne(optional = true, fetch = FetchType.EAGER)
    @JoinColumn(name = "plane_id")
    private Plane plane;

    /**
     * 机场建设费
     */
    private double airportConstruction;

    /**
     * 燃油税
     */
    private double fuelTex;

    /**
     * 该航线的舱位信息
     */
    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinTable(name = "airline_links_airline_class",
            joinColumns ={@JoinColumn(name = "airline_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "airline_class_id", referencedColumnName = "id")
            })
    private List<AirlineClass> airlineClassList = new ArrayList<AirlineClass>();

    /**
     * 是否被禁用
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean isDisable;

    /**
     * 航班状态
     * 1.未开售    2.已开售   3.已停售
     */
    private int status;

    /**
     * 周日该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean sunday;

    /**
     * 周一该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean monday;

    /**
     * 周二该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean tuesday;

    /**
     * 周三该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean wednesday;

    /**
     * 周四该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean thursday;

    /**
     * 周五该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean friday;

    /**
     * 周六该航线是否飞行
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private boolean saturday;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAirlineNum() {
        return airlineNum;
    }

    public void setAirlineNum(String airlineNum) {
        this.airlineNum = airlineNum;
    }

    public Airport getDeparture() {
        return departure;
    }

    public void setDeparture(Airport departure) {
        this.departure = departure;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Airport getDestination() {
        return destination;
    }

    public void setDestination(Airport destination) {
        this.destination = destination;
    }

    public Date getArriveTime() {
        return arriveTime;
    }

    public void setArriveTime(Date arriveTime) {
        this.arriveTime = arriveTime;
    }

    public int getMileage() {
        return mileage;
    }

    public void setMileage(int mileage) {
        this.mileage = mileage;
    }

    public Plane getPlane() {
        return plane;
    }

    public void setPlane(Plane plane) {
        this.plane = plane;
    }

    public double getAirportConstruction() {
        return airportConstruction;
    }

    public void setAirportConstruction(double airportConstruction) {
        this.airportConstruction = airportConstruction;
    }

    public double getFuelTex() {
        return fuelTex;
    }

    public void setFuelTex(double fuelTex) {
        this.fuelTex = fuelTex;
    }

    public List<AirlineClass> getAirlineClassList() {
        return airlineClassList;
    }

    public void setAirlineClassList(List<AirlineClass> airlineClassList) {
        this.airlineClassList = airlineClassList;
    }

    public boolean getIsDisable() {
        return isDisable;
    }

    public void setIsDisable(boolean disable) {
        isDisable = disable;
    }

    public boolean getSunday() {
        return sunday;
    }

    public void setSunday(boolean sunday) {
        this.sunday = sunday;
    }

    public boolean getMonday() {
        return monday;
    }

    public void setMonday(boolean monday) {
        this.monday = monday;
    }

    public boolean getTuesday() {
        return tuesday;
    }

    public void setTuesday(boolean tuesday) {
        this.tuesday = tuesday;
    }

    public boolean getWednesday() {
        return wednesday;
    }

    public void setWednesday(boolean wednesday) {
        this.wednesday = wednesday;
    }

    public boolean getThursday() {
        return thursday;
    }

    public void setThursday(boolean thursday) {
        this.thursday = thursday;
    }

    public boolean getFriday() {
        return friday;
    }

    public void setFriday(boolean friday) {
        this.friday = friday;
    }

    public boolean getSaturday() {
        return saturday;
    }

    public void setSaturday(boolean saturday) {
        this.saturday = saturday;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
