<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 个人信息管理</title>
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
                修改个人信息
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/information/">个人信息管理</a></li>
                <li class="active"><a href="#">修改个人信息</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">修改密码</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/information/updatepassword" method="post" >
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>旧密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="" name="oldPassword"
                                               value="" onclick="" required>
                                    </div>

                                </div>



                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>新密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="" name="newPassword"
                                               value="" onclick="" required>
                                    </div>
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>确认密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="" name="confirmPassword"
                                               value="" onclick="" required>
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


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">修改邮箱</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/information/updateemail" method="post" >
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>旧邮箱</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name=""
                                               value="${staff.checkedEmail}" onclick="" disabled="disabled">
                                    </div>

                                </div>



                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="" name="password"
                                               value="" onclick="" required>
                                    </div>
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>新邮箱</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="" name="newEmail"
                                               value="" onclick="" required>
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


    </div>

<#include "/include/adminfoot.ftl">
</div>


<script>


    function cancel(url){
        window.location.href=url;
    }

</script>

</body>
</html>
