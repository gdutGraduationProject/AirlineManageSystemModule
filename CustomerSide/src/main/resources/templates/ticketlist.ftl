<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>机票订购</title>
<#include "/include/resources.ftl">
    <link rel="stylesheet" type="text/css" href="../../customized/css/ticketlist.css"/>
</head>
<body>

<div style="display: none">
    <form action="../../buyticket/chooseleftticket" method="post" id="hiddenFormForJump">
        <input id="leftTicketId" name="leftTicketId">
        <input id="leftTicketClassId" name="leftTicketClassId" >
    </form>
</div>

<!--头部开始-->
<#include "/include/pagehead.ftl"/>
<!--机票搜索-->
<div class="container">
    <h2 class="page-header">机票搜索
        <small> Ticket search</small>
    </h2>
</div>
<section id="ticket">
    <div class="container">
        <form action="../../ticketsearch" method="post" class="form-horizontal" id="ticketForm">

            <div class="form-group">
                <label class="col-md-2 control-label">出发城市</label>
                <div class="col-md-5">
                    <select class="form-control" name="departureId">
                    <#list airportList as airport>
                        <option value="${airport.id}" }>${airport.shortEng} - ${airport.city}
                            - ${airport.airportName}</option>
                    </#list>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">目的城市</label>
                <div class="col-md-5">
                    <select class="form-control" name="destinateId">
                    <#list airportList as airport>
                        <option value="${airport.id}" }>${airport.shortEng} - ${airport.city}
                            - ${airport.airportName}</option>
                    </#list>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-2">出发日期</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" onclick="WdatePicker()" name="departure">
                </div>
                <div class="col-md-2">
                    <input type="submit" class="btn btn-warning" value="搜索机票">
                </div>
            </div>

        </form>
    </div>
</section>
<!--机票信息部分-->
<section id="ticketInfo">
    <div class="container">
        <div class="row">
            <!--信息头-->
            <div class="panel panel-default pb-1">
                <div class="panel-body ">
                    <div class="col-md-2">航班信息</div>
                    <div class="col-md-2 text-center">起飞时间</div>
                    <div class="col-md-1"></div>
                    <div class="col-md-2 text-center">到达时间</div>
                    <div class="col-md-3">准点率</div>
                    <div class="col-md-1">价格</div>
                </div>
            </div>
            <!--大概信息-->
            <div class="panel-group" id="accordion">


            <#list leftTicketList as leftTicket>
                <div class="panel panel-default">
                    <div class="panel-heading" id="heading${leftTicket_index}">
                        <div class="col-md-2">
                            <p class="airName">广工航空</p>
                            <p class="airModel"><!-- 空中客车A330（大型）-->${leftTicket.airline.plane.company}
                                -${leftTicket.airline.plane.modelName}</p>
                        </div>
                        <div class="col-md-2 text-center">
                            <p><span class="goTime">${leftTicket.airline.startTime?time}</span></p>
                            <p>${leftTicket.airline.departure.airportName}</p>
                        </div>
                        <div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>
                        <div class="col-md-2 text-center">
                            <p><span class="arriveTime">${leftTicket.airline.arriveTime?time}</span></p>
                            <p>${leftTicket.airline.destination.airportName}</p>
                        </div>
                        <div class="col-md-2 vCenter">准点率100%</div>
                        <div class="col-md-2">
                            <span class="PriceBox"><i class="fa fa-money"></i><span
                                    class="tPrice">${leftTicket.minPrice?c}</span>起</span>
                            <button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion"
                                    href="#collapse${leftTicket_index}" aria-expanded="true"
                                    aria-controls="collapse${leftTicket_index}">
                                订票<span class="caret"></span>
                            </button>
                        </div>
                    </div>
                    <!--详细信息-->
                    <div id="collapse${leftTicket_index}" class="panel-collapse collapse">
                        <div class="panel-body">
                            <ul class="list-group">
                                <#list leftTicket.leftTicketClassList as class>
                                    <li class="list-group-item">
                                        <div class="col-md-2">行程单</div>
                                        <div class="col-md-offset-5 col-md-1">${class.airlineClass.name}</div>
                                        <div class="col-md-1">¥<span>${class.curPrice?c}</span></div>
                                        <div class="col-md-offset-1 col-md-1">
                                            <botton class="btn btn-warning" onclick="urlJump('${leftTicket.id}','${class.id}')">选定</botton>
                                        </div>
                                    </li>
                                </#list>

                            </ul>
                        </div>
                    </div>
                </div>
            </#list>


            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingOne">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>-->
            <#--</div>-->
            <#--<!--详细信息&ndash;&gt;-->
            <#--<div id="collapseOne" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->



            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingTwo">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>		-->
            <#--</div>-->
            <#--<div id="collapseTwo" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->



            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingThree">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>	-->
            <#--</div>-->
            <#--<div id="collapseThree" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->
            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingOne">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>-->
            <#--</div>-->
            <#--<!--详细信息&ndash;&gt;-->
            <#--<div id="collapseOne" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div><div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingOne">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>-->
            <#--</div>-->
            <#--<!--详细信息&ndash;&gt;-->
            <#--<div id="collapseOne" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->
            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingOne">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>-->
            <#--</div>-->
            <#--<!--详细信息&ndash;&gt;-->
            <#--<div id="collapseOne" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div><div class="panel panel-default">-->
            <#--<div class="panel-heading" id="headingOne">-->
            <#--<div class="col-md-2">-->
            <#--<p class="airName">海南航空</p>-->
            <#--<p class="airModel">空中客车A330（大型）</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="goTime">08:00</span></p>-->
            <#--<p>虹桥国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>-->
            <#--<div class="col-md-2 text-center">-->
            <#--<p><span class="arriveTime">11:10</span></p>-->
            <#--<p>首都国际机场</p>-->
            <#--</div>-->
            <#--<div class="col-md-2 vCenter">准点率78%</div>-->
            <#--<div class="col-md-2">-->
            <#--<span class="PriceBox"><i class="fa fa-money"></i><span class="tPrice">1000</span>起</span>-->
            <#--<button class="btn btn-primary" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">-->
            <#--订票<span class="caret"></span>-->
            <#--</button>-->
            <#--</div>-->
            <#--</div>-->
            <#--<!--详细信息&ndash;&gt;-->
            <#--<div id="collapseOne" class="panel-collapse collapse" >-->
            <#--<div class="panel-body">-->
            <#--<ul class="list-group">-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">经济舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务舱</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">9折</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--<li class="list-group-item">-->
            <#--<div class="col-md-2">行程单</div>-->
            <#--<div class="col-md-offset-5 col-md-1">公务全价</div>-->
            <#--<div class="col-md-1">¥<span>1000</span></div>-->
            <#--<div class="col-md-offset-1 col-md-1"><botton class="btn btn-warning">选定</botton></div>-->
            <#--</li>-->
            <#--</ul>-->
            <#--</div>-->
            <#--</div>-->
            </div>


        </div>
    </div>
    </div>
</section>





<#include "/include/pagefoot.ftl"/>
<script src="customized/js/ticketlist.js"></script>
</body>
</html>
