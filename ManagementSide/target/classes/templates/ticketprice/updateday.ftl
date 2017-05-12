<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 票价管理</title>
<#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>
    <!-- Left side column. contains the logo and sidebar -->
<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                修改价格
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/ticketprice/">票价管理</a></li>
                <li class="active"><a href="#">修改价格</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">修改价格</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/ticketprice/updatesingle" method="post" >
                            <input type="hidden" name="leftTicketId" value="${leftTicket.id}">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">航班号</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${airline.airlineNum}" disabled="disabled" >
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">日期</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${leftTicket.departureDate}" disabled="disabled" >
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">出发机场</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${airline.departure.city}-${airline.departure.airportName}" disabled="disabled" >
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">到达机场</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${airline.destination.city}-${airline.destination.airportName}" disabled="disabled" >
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label">起飞时间</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${airline.startTime?string('hh:mm')}" disabled="disabled" >
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">到达时间</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${airline.arriveTime?string('hh:mm')}" disabled="disabled" >
                                    </div>

                                </div>

                                <#list leftTicket.leftTicketClassList as leftTicketClass>
                                <div class="form-group">
                                    <input type="hidden" name="leftTicketClassId${leftTicketClass_index}" value="${leftTicketClass.id}">

                                    <label for="inputEmail3" class="col-sm-2 control-label">舱位名称</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${leftTicketClass.airlineClass.name}" disabled="disabled" >
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label">现价</label>
                                    <div class="col-sm-1">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${leftTicketClass.curPrice?c}" disabled="disabled" >
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>新价 </label>
                                    <div class="col-sm-1">
                                        <input type="number" class="form-control" id="" name="newPrice${leftTicketClass_index}"
                                               value=""  >
                                    </div>

                                </div>
                                </#list>




                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/ticketprice/')">取消
                                </button>
                                <button id="register" type="submit" class="btn btn-info pull-right">保存</button>
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
    function endDateDisplay() {
        var temp  = document.getElementsByName("editType");
        var intHot;
        for(var i=0;i<temp.length;i++)
        {
            if(temp[i].checked)
                 intHot = temp[i].value;
        }
        if(intHot == 1){
            $("#endDateDiv").attr("style","");
        }else {
            $("#endDateDiv").attr("style","display:none");
        }
    }

    function cancel(url){
        window.location.href=url;
    }

</script>

</body>
</html>
