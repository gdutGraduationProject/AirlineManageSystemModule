<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
<#include "/include/resources.ftl">
    <link rel="stylesheet" type="text/css" href="../../customized/css/orderlist.css"/>
</head>
<body>
<!--头部开始-->
<#include "/include/pagehead.ftl"/>
<!--个人中心主体-->
<section id="person" style="margin-top: 50px;margin-bottom: 150px;">
    <div class="container">
        <div class="row">
            <div class="col-md-2 text-center">
                <div class="list-group">
                    <a href="#" class="list-group-item active disabled">我的订单</a>
                    <a href="jifen.html" class="list-group-item">我的积分</a>
                    <a href="lvke.html" class="list-group-item">常用旅客</a>
                    <a href="#" class="list-group-item">修改密码</a>
                    <a href="#" class="list-group-item">修改密保</a>
                    <a href="#" class="list-group-item">修改邮箱</a>
                </div>
            </div>
            <!--订单列表-->
            <div class="col-md-10 well">

            <#if hasOrder == "false">
                <h1>暂无订单</h1>
            <#else >
                <#list ticketOrder as order>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="col-md-3">订单号：${order.orderNum}</div>
                            <div class="col-md-3">预定日期：${order.orderTime}</div>
                            <div class="col-md-1 pull-right"><a href="#" class="btn btn-danger btn-xs">删除订单</a></div>
                        </div>
                        <div class="panel-body">
                            <div class="col-md-2 v">${order.airline.departure.city}-${order.airline.destination.city}</div>
                            <div class="col-md-4 v"><span class="airName">广工航空</span>
                                <small class="airModel">${order.airline.plane.company}${order.airline.plane.modelName}</small>
                            </div>
                            <div class="col-md-2 v"><span class="passenger"> </span></div>
                            <div class="col-md-2 v">${order.flightDay}</div>
                            <div class="col-md-2">
                                <p>已出票</p>
                                <p><a href="../../personalcenter/orderdetail?id=${order.id}">订单详情</a></p>
                            </div>
                        </div>
                    </div>
                </#list>
            </#if>




            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading">-->
            <#--<div class="col-md-3" >订单号：2976610234</div>-->
            <#--<div class="col-md-3" >预定日期：2017-5-1</div>-->
            <#--<div class="col-md-1 pull-right" ><a href="#" class="btn btn-danger btn-xs">删除订单</a></div>-->
            <#--</div>-->
            <#--<div class="panel-body">-->
            <#--<div class="col-md-2 v">西安-广州</div>-->
            <#--<div class="col-md-4 v"><span class="airName">海南航空</span>  <small class="airModel">空中客车A330（大型）</small></div>-->
            <#--<div class="col-md-2 v"><span class="passenger">孙悟空</span></div>-->
            <#--<div class="col-md-2 v">2017-5-1</div>-->
            <#--<div class="col-md-2">-->
            <#--<p>已出票</p>-->
            <#--<p><a href="#">订单详情</a></p>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->
            <#---->
            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading">-->
            <#--<div class="col-md-3" >订单号：2976610234</div>-->
            <#--<div class="col-md-3" >预定日期：2017-5-1</div>-->
            <#--<div class="col-md-1 pull-right" ><a href="#" class="btn btn-danger btn-xs">删除订单</a></div>-->
            <#--</div>-->
            <#--<div class="panel-body">-->
            <#--<div class="col-md-2 v">西安-广州</div>-->
            <#--<div class="col-md-4 v"><span class="airName">海南航空</span>  <small class="airModel">空中客车A330（大型）</small></div>-->
            <#--<div class="col-md-2 v"><span class="passenger">孙悟空</span></div>-->
            <#--<div class="col-md-2 v">2017-5-1</div>-->
            <#--<div class="col-md-2">-->
            <#--<p>已出票</p>-->
            <#--<p><a href="#">订单详情</a></p>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->
            <#---->
            <#--<div class="panel panel-default">-->
            <#--<div class="panel-heading">-->
            <#--<div class="col-md-3" >订单号：2976610234</div>-->
            <#--<div class="col-md-3" >预定日期：2017-5-1</div>-->
            <#--<div class="col-md-1 pull-right" ><a href="#" class="btn btn-danger btn-xs">删除订单</a></div>-->
            <#--</div>-->
            <#--<div class="panel-body">-->
            <#--<div class="col-md-2 v">西安-广州</div>-->
            <#--<div class="col-md-4 v"><span class="airName">海南航空</span>  <small class="airModel">空中客车A330（大型）</small></div>-->
            <#--<div class="col-md-2 v"><span class="passenger">孙悟空</span></div>-->
            <#--<div class="col-md-2 v">2017-5-1</div>-->
            <#--<div class="col-md-2">-->
            <#--<p>已出票</p>-->
            <#--<p><a href="#">订单详情</a></p>-->
            <#--</div>-->
            <#--</div>-->
            <#--</div>-->

            </div>
        </div>
    </div>
</section>
<!--脚注区域-->
<#include "/include/pagefoot.ftl"/>
</body>
</html>
