package cn.bean.vo;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by ChenGeng on 2017/3/23.
 */
public class JqueryDataTablesVo {


    /**
     *
     */
    private Integer iColumns;
    /**
     * 每页数据条数
     */
    private Integer iDisplayLength =10;
    /**
     * 起始页码
     */
    private Integer iDisplayStart = 0;
    /**
     * 操作次数
     */
    private Integer sEcho = 0;

    private String sColumns;

    @Override
    public String toString() {
        return "JqueryDataTablesVo{" +
                "sColumns='" + sColumns + '\'' +
                ", sEcho=" + sEcho +
                ", iDisplayStart=" + iDisplayStart +
                ", iDisplayLength=" + iDisplayLength +
                ", iColumns=" + iColumns +
                '}';
    }

    public Map toMap(){
        Map map = new HashMap();
        map.put("sColumns",sColumns);
        map.put("sEcho",sEcho);
        map.put("iDisplayStart",iDisplayStart);
        map.put("iDisplayLength",iDisplayLength);
        map.put("iColumns",iColumns);
        return map;
    }

    public Integer getiColumns() {
        return iColumns;
    }

    public void setiColumns(Integer iColumns) {
        this.iColumns = iColumns;
    }

    public Integer getiDisplayLength() {
        return iDisplayLength;
    }

    public void setiDisplayLength(Integer iDisplayLength) {
        this.iDisplayLength = iDisplayLength;
    }

    public Integer getiDisplayStart() {
        return iDisplayStart;
    }

    public void setiDisplayStart(Integer iDisplayStart) {
        this.iDisplayStart = iDisplayStart;
    }

    public Integer getsEcho() {
        return sEcho;
    }

    public void setsEcho(Integer sEcho) {
        this.sEcho = sEcho;
    }

    public String getsColumns() {
        return sColumns;
    }

    public void setsColumns(String sColumns) {
        this.sColumns = sColumns;
    }
}
