<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 航线管理</title>
<#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini" onload="getPlaneClass()">
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>

<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">

        <section class="content-header">
            <h1>
                添加航线
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/airline/list">航线列表</a></li>
                <li class="active"><a href="#">编辑航线</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">编辑航线</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/airline/update" method="post"
                              onsubmit="return submitCheck()">
                            <input type="hidden" id="isNew" name="isNew" value="${isNew?string('true', 'false')}"/>
                            <input type="hidden" id="airlineId" name="id" value="${airline.id!}"/>
                            <div class="box-body" id="formBody">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>航班号</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="airlineNum" name="airlineNum"
                                               value="${airline.airlineNum!}" required placeholder="航班号">
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>出发机场</label>
                                    <div class="col-sm-3">

                                        <select id="departureId" name="departureId" class="form-control">
                                        <#list airportList as airport>
                                            <option value="${airport.id}">${airport.shortEng} ${airport.city} ${airport.airportName}</option>
                                        </#list>
                                        </select>
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>出发时间</label>
                                    <div class="col-sm-1">
                                        <select class="form-control" name="departureTimeHour">
                                        <#list hourList as hour>
                                            <option value="${hour.value}">${hour.showText}</option>
                                        </#list>
                                        </select>

                                    </div>
                                    <label style="width: 0px" for="inputPassword3"
                                           class="col-sm-1 control-label">:</label>
                                    <div class="col-sm-1">
                                        <select class="form-control" name="departureTimeMinute">
                                        <#list minuteList as minute>
                                            <option value="${minute.value}">${minute.showText}</option>
                                        </#list>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>到达机场</label>
                                    <div class="col-sm-3">
                                        <select id="destinationId" name="destinationId" class="form-control">
                                        <#list airportList as airport>
                                            <option value="${airport.id}">${airport.shortEng} ${airport.city} ${airport.airportName}</option>
                                        </#list>
                                        </select>
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>到达时间</label>
                                    <div class="col-sm-1">
                                        <select class="form-control" name="destinationTimeHour">
                                        <#list hourList as hour>
                                            <option value="${hour.value}">${hour.showText}</option>
                                        </#list>
                                        </select>

                                    </div>
                                    <label style="width: 0px" for="inputPassword3"
                                           class="col-sm-1 control-label">:</label>
                                    <div class="col-sm-1">
                                        <select class="form-control" name="destinationTimeMinute">
                                        <#list minuteList as minute>
                                            <option value="${minute.value}">${minute.showText}</option>
                                        </#list>
                                        </select>

                                    </div>

                                </div>


                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>里程</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="mileage" name="mileage"
                                               value="" placeholder="里程">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>机场建设费</label>
                                    <div class="col-sm-3">
                                        <input type="number" class="form-control" id="airportConstruction"
                                               name="airportConstruction"
                                               value="" placeholder="机场建设费">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>燃油税</label>
                                    <div class="col-sm-3">
                                        <input type="number" class="form-control" id="fuelTex" name="fuelTex"
                                               value="" placeholder="燃油税">
                                    </div>

                                </div>


                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>飞行时间</label>
                                    <div class="col-sm-10">
                                        <div class="radio-inline"><input type="checkbox" name="sunday" value="true"
                                                                         <#if airline.sunday==true>checked="checked"</#if>>星期天
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="monday" value="true"
                                                                         <#if airline.monday==true>checked="checked"</#if>>星期一
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="tuesday" value="true"
                                                                         <#if airline.tuesday==true>checked="checked"</#if>>星期二
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="wednesday"
                                                                         value="true"
                                                                         <#if airline.wednesday==true>checked="checked"</#if>>星期三
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="thursday"
                                                                         value="true"
                                                                         <#if airline.thursday==true>checked="checked"</#if>>星期四
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="friday" value="true"
                                                                         <#if airline.friday==true>checked="checked"</#if>>星期五
                                        </div>
                                        <div class="radio-inline"><input type="checkbox" name="saturday"
                                                                         value="true"
                                                                         <#if airline.saturday==true>checked="checked"</#if>>星期六
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span
                                            class="text-red">*</span>机型</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="planeId" name="planeId"
                                                onchange="getPlaneClass()">
                                        <#list planeList as plane>
                                            <option value="${plane.id}">${plane.company} - ${plane.modelName} -
                                                总座位数${plane.seatCount}</option>
                                        </#list>
                                        </select>
                                    </div>

                                </div>

                                <div class="form-group" style="text-align: center">
                                    <h4>舱位信息</h4>
                                </div>

                                <div id="oldAirlineClass" hidden >
                                    <HR style="FILTER: alpha(opacity=100,finishopacity=0,style=3)" width="80%"
                                        color=#987cb9 SIZE=3>

                                    <input type="hidden" id="planeClassId" name="planeClassId" >

                                    <div class="form-group">

                                        <label for="inputPassword3" class="col-sm-2 control-label">舱位名称</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="planeClassName" name="planeClassName"
                                                   value="经济舱" placeholder="总价" disabled>
                                        </div>

                                        <label for="inputPassword3" class="col-sm-2 control-label">英文简称</label>
                                        <div class="col-sm-1">
                                            <input type="text" class="form-control" id="simpleName" name="simpleName"
                                                   value="英文简称" placeholder="英文简称" disabled>
                                        </div>

                                        <label for="inputPassword3" class="col-sm-2 control-label">人数</label>
                                        <div class="col-sm-1">
                                            <input type="text" class="form-control" id="totalCount" name="totalCount"
                                                   value="50" placeholder="人数" disabled>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputPassword3" class="col-sm-2 control-label">总价</label>
                                        <div class="col-sm-2">
                                            <input type="number" class="form-control" id="fullPrice" name="fullPrice"
                                                   value="" placeholder="总价">
                                        </div>

                                        <label for="inputPassword3" class="col-sm-1 control-label">默认折扣</label>
                                        <div class="col-sm-2">
                                            <input type="number" class="form-control" id="defaultDiscount" name="defaultDiscount"
                                                   value="" placeholder="默认折扣">
                                        </div>

                                        <label for="inputPassword3" class="col-sm-1 control-label">分隔时间</label>
                                        <div class="col-sm-2">
                                            <input type="number" class="form-control" id="spiltTime" name="spiltTime"
                                                   value="" placeholder="分隔时间">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="inputPassword3" class="col-sm-2 control-label">提前的退票费用</label>
                                        <div class="col-sm-3">
                                            <input type="number" class="form-control" id="beforeRefundFee" name="beforeRefundFee"
                                                   value="" placeholder="提前的退票费用">
                                        </div>
                                        <label for="inputPassword3" class="col-sm-2 control-label">提前的改签费用</label>
                                        <div class="col-sm-3">
                                            <input type="number" class="form-control" id="beforeChangeFee" name="beforeChangeFee"
                                                   value="" placeholder="提前的改签费用">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="inputPassword3" class="col-sm-2 control-label">延后的退票费用</label>
                                        <div class="col-sm-3">
                                            <input type="number" class="form-control" id="afterRefundFee" name="afterRefundFee"
                                                   value="" placeholder="延后的退票费用">
                                        </div>
                                        <label for="inputPassword3" class="col-sm-2 control-label">延后的改签费用</label>
                                        <div class="col-sm-3">
                                            <input type="number" class="form-control" id="afterChangeFee" name="afterChangeFee"
                                                   value="" placeholder="延后的改签费用">
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/airline/')">取消
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
    function submitCheck() {
        var isFlag = true;

        return isFlag;
    }

    function cancel(url) {
        window.location.href = url;
    }

    function getPlaneClass() {
        for(var i=0;i<10;i++){
            if($("#newAirlineClass"+i)!=null){
                $("#newAirlineClass"+i).remove();
            }
        }

        var planeId = $("#planeId").val();
        $.ajax({
            type: 'POST',
            url: "${ctx}/airline/getPlaneClass",
            data: {
                "planeId": planeId
            },
            success: function (data) {
                var oldPlaneClass = $("#oldAirlineClass");

                var planeClassList = data.planeClassList;
                var formBody = $("#formBody");
                for(var i = 0;i<planeClassList.length;i++){
                    var newAirlineClass = oldPlaneClass.clone();
                    newAirlineClass.attr("id","newAirlineClass"+i);
                    newAirlineClass.removeAttr("hidden");
                    changeDom(newAirlineClass,i);
                    formBody.append(newAirlineClass);
                    $("#planeClassId"+i).attr("value",planeClassList[i].id);
                    $("#planeClassName"+i).attr("value",planeClassList[i].name);
                    $("#simpleName"+i).val(planeClassList[i].simpleName);
                    $("#totalCount"+i).attr("value",planeClassList[i].totalCount);

                }
            },
            error: function (data) {
                window.wxc.xcConfirm("异常，请联系管理员。", "error");
            }
        });
    }

    function changeDom(domList,changeNum){
        var list = domList.children("input");
        for(var i=0;i<list.length;i++){
            $(list[i]).attr("id",$(list[i]).attr("id")+changeNum);
            $(list[i]).attr("name",$(list[i]).attr("name")+changeNum);
            $(list[i]).attr("required");
        }
        list = domList.children("div");
        for(var i=0;i<list.children().length;i++){
            circleChangeInput($(list[i]),changeNum);
        }
    }

    function circleChangeInput(domList,changeNum) {
        var list = domList.children("input");
        for(var i=0;i<list.length;i++){
            $(list[i]).attr("id",$(list[i]).attr("id")+changeNum);
            $(list[i]).attr("name",$(list[i]).attr("name")+changeNum);
        }
        list = domList.children("div");
        for(var i=0;i<list.children().length;i++){
            circleChangeInput($(list[i]),changeNum);
        }
    }

</script>

</body>
</html>
