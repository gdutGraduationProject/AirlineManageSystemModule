<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 机场管理</title>
<#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini" onload="changeDisabled()">
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>
    <!-- Left side column. contains the logo and sidebar -->
<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                添加机型
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/plane/list">机型列表</a></li>
                <li class="active"><a href="#">编辑机型</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">编辑机型</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/plane/update" method="post" onsubmit="return submitCheck()">
                            <input type="hidden" id="isNew" name="isNew" value="${isNew?string('true', 'false')}"/>
                            <input type="hidden" id="planeId" name="id" value="${plane.id!}"/>
                            <input type="hidden" id="classCount" name="classCount" value="${classCount}">
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>品牌</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="company" name="company"
                                               value="${plane.company!}" required placeholder="品牌">
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>型号</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="modelName" name="modelName"
                                               value="${plane.modelName!}" required placeholder="型号">
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>最大里程</label>
                                    <div class="col-sm-3">
                                        <input type="number" class="form-control" id="maxMileage" name="maxMileage"
                                               value="${maxMileage!}" required placeholder="最大里程">
                                    </div>

                                </div>


                                <div class="form-group">

                                </div>

                                <div class="form-group" style="text-align: center">
                                    <button type="button" class="btn btn-default" onclick="addPlaneClass()" id="addPlaneClassButton">添加舱位
                                    </button>
                                    &nbsp;
                                    <button type="button" class="btn btn-default" onclick="deletePlaneClass()" id="deletePlaneClassButton">删减舱位
                                    </button>
                                </div>

                                <div class="form-group">
                                </div>

                                <div class="form-group" style="display: none" id="oldPlaneClass">
                                    <input type="hidden" name="classIsNew" value="true">
                                    <input type="hidden" name="classId">

                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>舱名</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="name" name="name"
                                                placeholder="舱名">
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>简称</label>
                                    <div class="col-sm-2">
                                        <input type="text" class="form-control" id="simpleName" name="simpleName"
                                                 placeholder="简称">
                                    </div>

                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>人数</label>
                                    <div class="col-sm-1">
                                        <input type="number" class="form-control" id="totalCount" name="totalCount"
                                                 placeholder="人数">
                                    </div>
                                </div>

                                <#if isNew==false>
                                <#list oldClass as class>
                                    <div class="form-group"  id="newPlaneClass${class_index }">
                                        <input type="hidden" name="classIsNew${class_index }" value="false">
                                        <input type="hidden" name="classId${class_index }" value="${class.id}">

                                        <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>舱名</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="name${class_index }" name="name${class_index }"
                                                   placeholder="舱名" value="${class.name}" required>
                                        </div>

                                        <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>简称</label>
                                        <div class="col-sm-2">
                                            <input type="text" class="form-control" id="simpleName${class_index }" name="simpleName${class_index }"
                                                   placeholder="简称" value="${class.simpleName}" required>
                                        </div>

                                        <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>人数</label>
                                        <div class="col-sm-1">
                                            <input type="number" class="form-control" id="totalCount${class_index }" name="totalCount${class_index }"
                                                   placeholder="人数" value="${class.totalCount}" required>
                                        </div>
                                    </div>
                                </#list>
                                </#if>

                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/plane/')">取消
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

    function addPlaneClass(){
        var classCount = parseInt($("#classCount").val());
        var oldClassDiv = $("#oldPlaneClass");
        var newClassDiv = oldClassDiv.clone();
        newClassDiv.removeAttr("style");
        newClassDiv.attr("id","newPlaneClass"+classCount);
        changeDom(newClassDiv,classCount);
        if(classCount != 0){
            oldClassDiv = $("#newPlaneClass"+(classCount-1));
        }
        oldClassDiv.after(newClassDiv);
        classCount = classCount+1;
        $("#classCount").val(classCount);
        changeDisabled();
    }

    function changeDisabled(){
        var classCount = parseInt($("#classCount").val());
        var addButton = $("#addPlaneClassButton");
        var deleteButton = $("#deletePlaneClassButton");
        if(classCount == 0){
            deleteButton.attr("disabled","disabled");
        }else{
            deleteButton.removeAttr("disabled");
        }
        if(classCount == 10){
            addButton.attr("disabled","disabled");
        }else{
            addButton.removeAttr("disabled");
        }
    }

    function deletePlaneClass(){
        var classCount = parseInt($("#classCount").val());
        var oldClassDiv = $("#newPlaneClass"+(classCount-1));
        oldClassDiv.remove();
        classCount = classCount - 1;
        $("#classCount").val(classCount);
        changeDisabled();
    }

    function changeDom(domList,changeNum){
        var list = domList.children("input");
        for(var i=0;i<list.length;i++){
            $(list[i]).attr("id",$(list[i]).attr("id")+changeNum);
            $(list[i]).attr("name",$(list[i]).attr("name")+changeNum);
        }
        list = domList.children("div");
        for(var i=0;i<list.children().length;i++){
            $(list[i]).children("input").attr("id",$(list[i]).children("input").attr("id")+changeNum);
            $(list[i]).children("input").attr("name",$(list[i]).children("input").attr("name")+changeNum);
            $(list[i]).children("input").attr("required","required");
        }
    }

    function submitCheck() {
        var isNew = $("#isNew").val();
        var company = $("#company").val();
        var modelName = $("#modelName").val();
        var maxMileage = $("#maxMileage").val();
        var isFlag = true;
        if(company.length<2){
            window.wxc.xcConfirm("品牌至少2个字，请重新输入。", "error");
            isFlag = false;
        }else if(modelName.length<2){
            window.wxc.xcConfirm("型号至少为2个字，请重新输入。", "error");
            isFlag = false;
        }else if(maxMileage<0){
            window.wxc.xcConfirm("最大里程需为正数，请重新输入。", "error");
            isFlag = false;
        }
        if(isFlag == true){
            $("#oldPlaneClass").remove();
        }
        return isFlag;
    }

    function cancel(url){
        window.location.href=url;
    }

</script>

</body>
</html>
