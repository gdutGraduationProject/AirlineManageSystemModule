<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 机场管理</title>
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
                添加机场
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/airport/list">机场列表</a></li>
                <li class="active"><a href="#">编辑机场</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">编辑机场</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/airport/update" method="post" onsubmit="return submitCheck()">
                            <input type="hidden" id="isNew" name="isNew" value="${isNew?string('true', 'false')}"/>
                            <input type="hidden" id="airportId" name="id" value="${airport.id!}"/>
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>机场名称</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="airportName" name="airportName"
                                               value="${airport.airportName!}" required placeholder="机场名称">
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>所在省份</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="province" name="province"
                                               value="${airport.province!}" required placeholder="所在省份">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>所在城市</label>
                                    <div class="col-sm-3">
                                        <input type="text" id="city" name="city" value="${airport.city!}" class="form-control" required
                                               placeholder="所在城市">
                                    </div>
                                </div>

                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>英文简称</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="shortEng" name="shortEng"
                                               value="${airport.shortEng!}"  placeholder="英文简称">
                                    </div>

                                </div>



                                <div class="form-group">
                                </div>

                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/airport/')">取消
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
        var isNew = $("#isNew").val();
        var province = $("#province").val();
        var city = $("#city").val();
        var airport = $("#airportName").val();
        var shortEng = $("#shortEng").val();
        var isFlag = true;
        if(airport.length<2){
            window.wxc.xcConfirm("机场名称至少2个字，请重新输入。", "error");
            isFlag = false;
        }
        else if(province.length<2){
            window.wxc.xcConfirm("所在省份长度至少为2个字，请重新输入。", "error");
            isFlag = false;
        }else if(city<2){
            window.wxc.xcConfirm("所在城市长度至少为2个字，请重新输入。", "error");
            isFlag = false;
        }else if(shortEng<2){
            window.wxc.xcConfirm("英文简写长度至少为2个字母，请重新输入。", "error");
            isFlag = false;
        }

        return isFlag;
    }

    function cancel(url){
        window.location.href=url;
    }

</script>

</body>
</html>
