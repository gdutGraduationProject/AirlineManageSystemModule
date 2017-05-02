package cn.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Chen Geng on 2017/5/2.
 */
public class DateTransformTool {

    public Date datePickerStringToDate(String dateString){
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        try {
            date = dateFormat.parse(dateString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public String dateToDatePickerString(Date date){
        StringBuffer stringBuffer = new StringBuffer();
        int currentYear = date.getYear()+1900;
        stringBuffer.append(currentYear);
        stringBuffer.append("-");
        int currentMonth = date.getMonth()+1;
        if(currentMonth<10){
            stringBuffer.append("0");
        }
        stringBuffer.append(currentMonth);
        stringBuffer.append("-");
        int cuurentDay = date.getDate();
        if(cuurentDay<10){
            stringBuffer.append("0");
        }
        stringBuffer.append(cuurentDay);
        return stringBuffer.toString();
    }

}
