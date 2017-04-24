package cn.util;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ChenGeng on 2017/3/24.
 */
public class ListCopy {

    public static List copy(List oldList){
        List newList;
        if(oldList==null || oldList.size()==0){
            newList = new ArrayList();
        }else{
            newList = new ArrayList();
            for(int i=0;i<oldList.size();i++){
                newList.add(oldList.get(i));
            }
        }
        return newList;
    }

}
