package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by ChenGeng on 2017/3/27.
 */
@Entity
public class Plane extends BaseDomain {

    @Id
    @GenericGenerator(name = "PKUUID", strategy = "uuid2")
    @GeneratedValue(generator = "PKUUID")
    @Column(length = 36)
    protected String id;

    /**
     * 制造商的公司名称，如空客、波音等
     */
    private String company;

    /**
     * 客机型号，如737、A320等
     */
    private String modelName;

    /**
     * 最大里程数
     */
    private int maxMileage;

    /**
     * 总座位数
     */
    private int seatCount;

    /**
     * 是否被禁用
     */
    @org.hibernate.annotations.Type(type="yes_no")
    private Boolean isDisable;

    /**
     * 该机型的座舱
     */
    @ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.LAZY)
    @JoinTable(name = "plane_links_plane_class",
            joinColumns ={@JoinColumn(name = "plane_id", referencedColumnName = "id") },
            inverseJoinColumns = { @JoinColumn(name = "plane_class_id", referencedColumnName = "id")
            })
    private List<PlaneClass> planeClassList = new ArrayList<PlaneClass>();

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public int getMaxMileage() {
        return maxMileage;
    }

    public void setMaxMileage(int maxMileage) {
        this.maxMileage = maxMileage;
    }

    public int getSeatCount() {
        return seatCount;
    }

    public void setSeatCount(int seatCount) {
        this.seatCount = seatCount;
    }

    public List<PlaneClass> getPlaneClassList() {
        return planeClassList;
    }

    public void setPlaneClassList(List<PlaneClass> planeClassList) {
        this.planeClassList = planeClassList;
    }

    public Boolean getIsDisable() {
        return isDisable;
    }

    public void setIsDisable(Boolean disable) {
        isDisable = disable;
    }
}
