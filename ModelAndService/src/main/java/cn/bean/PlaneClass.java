package cn.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

/**
 * Created by ChenGeng on 2017/3/27.
 */
@Entity
public class PlaneClass {
    /**
     * 该机型的某个舱位
     */

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
     * 剩余的数量
     */
    private int leftCount;

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

    public int getLeftCount() {
        return leftCount;
    }

    public void setLeftCount(int leftCount) {
        this.leftCount = leftCount;
    }
}
