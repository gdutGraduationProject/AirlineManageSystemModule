<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 订单管理</title>
<#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini" >
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>

<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">

        <section class="content-header">
            <h1>
                订单详情
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/order/">订单管理</a></li>
                <li class="active"><a href="#">订单详情</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">订单详情</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="#" method="post">
                            <div class="box-body" id="formBody">

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">订单号</label>
                                    <div class="col-sm-3">
                                        <label id="" name="" class="form-control">${ticketOrder.orderNum}</label>
                                    </div>


                                    <label for="inputEmail3" class="col-sm-2 control-label">订单状态</label>
                                    <div class="col-sm-3">
                                        <label id="" name="" class="form-control">
                                        <#if ticketOrder.orderStatus==1>待付款
                                        <#elseif ticketOrder.orderStatus==2>已付款
                                        <#elseif ticketOrder.orderStatus==3>已取消
                                        <#elseif ticketOrder.orderStatus==4>已失效</#if>
                                        </label>
                                    </div>

                                </div>

                                <#if ticketOrder.orderStatus==2>
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">付款单号</label>
                                    <div class="col-sm-3">
                                        <label id="" name="" class="form-control">${ticketOrder.payment.paymentNum}</label>
                                    </div>


                                    <label for="inputEmail3" class="col-sm-2 control-label">付款时间</label>
                                    <div class="col-sm-3">
                                        <label id="" name="" class="form-control">
                                        ${ticketOrder.payment.paymentTime}
                                        </label>
                                    </div>

                                </div>
                                    <div class="form-group">
                                        <label for="inputEmail3" class="col-sm-2 control-label">付款金额</label>
                                        <div class="col-sm-3">
                                            <label id="" name="" class="form-control">${ticketOrder.payment.paymentMoney}元</label>
                                        </div>



                                    </div>
                                </#if>


                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">航班号</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="airlineNum" name="airlineNum"
                                               value="${ticketOrder.airline.airlineNum!}" required placeholder="航班号">
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">航班日期</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${ticketOrder.flightDay}" required ="">
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">起飞</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${ticketOrder.airline.departure.airportName} ${ticketOrder.airline.startTime?string('hh:MM')}"  placeholder="">
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">降落</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${ticketOrder.airline.destination.airportName} ${ticketOrder.airline.arriveTime?string('hh:MM')}" required ="">
                                    </div>

                                </div>


                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label">机场建设费</label>
                                    <div class="col-sm-3">
                                        <input type="number" class="form-control" id=""
                                               name=""
                                               value="${ticketOrder.airline.airportConstruction}" placeholder="">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label">燃油税</label>
                                    <div class="col-sm-3">
                                        <input type="number" class="form-control" id="" name=""
                                               value="${ticketOrder.airline.fuelTex}" placeholder="">
                                    </div>

                                </div>


                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="box">
                                            <div class="box-header">
                                                <h3 class="box-title">退改签费用</h3>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body table-responsive no-padding">
                                                <table class="table table-hover">
                                                    <tbody><tr>
                                                        <th>退票/改签时间</th>
                                                        <th>退票费用</th>
                                                        <th>改签费用</th>

                                                    </tr>
                                                    <tr>
                                                        <td>航班起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时前</td>
                                                        <td>${ticketOrder.leftTicketClass.airlineClass.beforeRefundFee}元</td>
                                                        <td>${ticketOrder.leftTicketClass.airlineClass.beforeChangeFee}元</td>

                                                    </tr>
                                                    <tr>
                                                        <td>航班起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时后</td>
                                                        <td>${ticketOrder.leftTicketClass.airlineClass.afterRefundFee}元</td>
                                                        <td>${ticketOrder.leftTicketClass.airlineClass.afterChangeFee}元</td>

                                                    </tr>

                                                    </tbody></table>
                                            </div>
                                            <!-- /.box-body -->
                                        </div>
                                        <!-- /.box -->
                                    </div>
                                </div>

                                <div class="row" >
                                    <div class="col-xs-12">
                                        <div class="box">
                                            <div class="box-header">
                                                <h3 class="box-title">乘机人信息</h3>
                                            </div>
                                            <!-- /.box-header -->
                                            <div class="box-body table-responsive no-padding">
                                                <table class="table table-hover">
                                                    <tbody><tr>
                                                        <th>序号</th>
                                                        <th>姓名</th>
                                                        <th>联系方式</th>
                                                        <th>证件类型</th>
                                                        <th>证件号码</th>
                                                        <th>票价</th>
                                                        <th>状态</th>
                                                    </tr>
                                                    <#list ticketOrder.subOrderList as subOrder>
                                                    <tr>
                                                        <td>${subOrder_index+1}</td>
                                                        <td>${subOrder.commonPassager.name}</td>
                                                        <td>${subOrder.commonPassager.phoneNumber}</td>
                                                        <td>${subOrder.commonPassager.idType}</td>
                                                        <td>${subOrder.commonPassager.idNumber}</td>
                                                        <td>${subOrder.payFee}元</td>
                                                        <td><#if subOrder.status==1>待付款
                                                        <#elseif subOrder.status==2>已付款
                                                        <#elseif subOrder.status==3>已取消
                                                        <#elseif subOrder.status==4>已失效
                                                        <#elseif subOrder.status==5>已退票
                                                        <#elseif subOrder.status==6>已改签</#if></td>
                                                    </tr>
                                                    </#list>


                                                    </tbody></table>
                                            </div>
                                            <!-- /.box-body -->
                                        </div>
                                        <!-- /.box -->
                                    </div>
                                </div>

                                <#--<div class="">-->

                                    <#--<div class="">-->
                                        <#--<table class="">-->
                                            <#--<tr>-->
                                                <#--<td>退票/改签时间</td>-->
                                                <#--<td>退票费用</td>-->
                                                <#--<td>改签费用</td>-->
                                            <#--</tr>-->
                                            <#--<tr>-->
                                                <#--<td>航班起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时前</td>-->
                                                <#--<td>${ticketOrder.leftTicketClass.airlineClass.beforeRefundFee}元</td>-->
                                                <#--<td>${ticketOrder.leftTicketClass.airlineClass.beforeChangeFee}元</td>-->
                                            <#--</tr>-->
                                            <#--<tr>-->
                                                <#--<td>航班起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时后</td>-->
                                                <#--<td>${ticketOrder.leftTicketClass.airlineClass.afterRefundFee}元</td>-->
                                                <#--<td>${ticketOrder.leftTicketClass.airlineClass.afterChangeFee}元</td>-->
                                            <#--</tr>-->
                                        <#--</table>-->
                                    <#--</div>-->

                                <#--</div>-->








                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/order/')">返回
                                </button>

                            </div>
                            <!-- /.box-footer -->
                        </form>
                    </div>
                </div>
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->
    </div>

<#include "/include/adminfoot.ftl">
</div>


<script>

    function cancel(url) {
        window.location.href = url;
    }

</script>

</body>
</html>
