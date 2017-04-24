<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 首页</title>
    <#include "/include/head.ftl">

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper" id="main-containter">
<#include "/include/admintop-menu.ftl"/>
    <!-- Left side column. contains the logo and sidebar -->
<#include "/include/adminleft-menu.ftl"/>
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                欢迎您
            </h1>
            <h5>
                今天是&nbsp;&nbsp;${.now}
            </h5>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li class="active">Dashboard</li>
            </ol>
        </section>
        <!-- /.content -->

        <section class="content">
            <div class="row">


                <div class="col-xs-12">

                    <div class="box">
                        <div class="box-body" style="text-align: center">
                            <h1>欢迎登陆航空售票管理系统</h1>
                            <h1>请在左侧菜单栏中选择相应功能选项</h1>
                        </div>
                    </div>

                </div>
        </section>


    </div>
    <!-- /.content-wrapper -->
    <#include "/include/adminfoot.ftl">
</div>




</body>
</html>
