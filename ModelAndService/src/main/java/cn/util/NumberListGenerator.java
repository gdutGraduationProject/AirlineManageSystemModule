package cn.util;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Chen Geng on 2017/4/13.
 */
public class NumberListGenerator {

    public List numberListGenerator(int startIndex,int endIndex){
        List numberList = new ArrayList();
        for(int i = startIndex; i <= endIndex ;i++){
            numberList.add(i);
        }
        return numberList;
    }

    public List timeListGenerator(int startIndex, int endIndex){
        List timeList = new ArrayList();
        for(int i = startIndex; i <= endIndex ; i++){
            TimeClass timeClass = new TimeClass();
            timeClass.setValue(i);
            if(i<10){
                timeClass.setShowText(new String("0"+i));
            }else{
                timeClass.setShowText(String.valueOf(i));
            }
            timeList.add(timeClass);
        }
        return timeList;
    }

    public class TimeClass{
        String showText;
        int value;

        public String getShowText() {
            return showText;
        }

        public void setShowText(String showText) {
            this.showText = showText;
        }

        public int getValue() {
            return value;
        }

        public void setValue(int value) {
            this.value = value;
        }
    }

}
