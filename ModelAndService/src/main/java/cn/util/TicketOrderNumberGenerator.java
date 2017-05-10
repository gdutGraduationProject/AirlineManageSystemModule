package cn.util;

import java.util.Date;

/**
 * Created by ChenGeng on 2017/5/10.
 */

public  class TicketOrderNumberGenerator {

    static long cuurentTime = 0;

    static int count = 1;

    public String generate() {
        Date date = new Date();
        StringBuffer buffer = new StringBuffer();
        buffer.append(date.getTime());
        if (date.getTime()==cuurentTime){
            count++;
        }else {
            cuurentTime = date.getTime();
            count = 1;
        }
        if(count<10){
            buffer.append("00");
        }else if(count<100){
            buffer.append("0");
        }
        buffer.append(count);
        return buffer.toString();
    }

}
