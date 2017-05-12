package cn.timer;

import cn.bean.TicketOrder;
import cn.service.TicketOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by ChenGeng on 2017/5/12.
 */
@Component
public class TicketOrderTimer
{
    @Autowired
    TicketOrderService ticketOrderService;

    @javax.transaction.Transactional
    @Scheduled(fixedRate = 2000)
    public void disableTicketOrder(){
        Date currentTime = new Date();
        currentTime.setMinutes(currentTime.getMinutes()-30);
            List<TicketOrder> ticketOrderList = ticketOrderService.unpayedTicketOrder();

        for(TicketOrder ticketOrder:ticketOrderList){

                if(currentTime.after(ticketOrder.getOrderTime())){
                    ticketOrderService.disableTicketOrder(ticketOrder);
                }

        }
    }

}
