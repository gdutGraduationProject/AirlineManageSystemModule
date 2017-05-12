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
                选择航班
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/ticketprice/">票价管理</a></li>
                <li class="active"><a href="#">选择航班</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">选择航班</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/ticketprice/edit" method="post" >
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>选择航班</label>
                                    <div class="col-sm-5">
                                        <select name="airlineId" class="form-control">
                                            <#list airlineList as airline>
                                                <option value="${airline.id}" >${airline.airlineNum} -  ${airline.departure.city} ${airline.departure.airportName}${airline.startTime?string('hh:mm')} - ${airline.destination.city} ${airline.destination.airportName}${airline.arriveTime?string('hh:mm')}</option>
                                            </#list>
                                        </select>

                                    </div>

                                </div>

                                <#--<div class="form-group">-->

                                    <#--<label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>修改类型</label>-->
                                    <#--<div class="col-sm-5">-->
                                        <#--<div class="radio-inline"><input type="radio" id="onlyThatDay" name="editType" value="0" checked="checked" onclick="endDateDisplay()" > 仅当天</div>-->
                                        <#--<div class="radio-inline"><input type="radio" name="editType" value="1" onclick="endDateDisplay()" >时间段</div>-->
                                    <#--</div>-->

                                <#--</div>-->

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>起始日期</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="startDate" name="startDate"
                                               value="${.now?date}" onclick="WdatePicker()">
                                    </div>



                                </div>



                                <div class="form-group"  id="endDateDiv"  style="display: none">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>结束日期</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="endDate" name="endDate"
                                               value="${.now?date}" onclick="WdatePicker()"  >
                                    </div>
                                </div>

                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/admin/index')">取消
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
