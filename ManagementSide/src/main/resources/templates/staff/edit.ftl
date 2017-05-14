<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>航空售票管理系统 - 职员管理</title>
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
                添加职员
            </h1>
            <ol class="breadcrumb">
                <li><a href="${ctx}/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
                <li><a href="${ctx}/staff/list">职员列表</a></li>
                <li class="active"><a href="#">编辑职员</a></li>
            </ol>
        </section>


        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box box-info">
                        <div class="box-header with-border">
                            <h3 class="box-title">编辑职员</h3>
                        </div>
                        <!-- /.box-header -->
                        <!-- form start -->
                        <form class="form-horizontal" id="editForm" action="${ctx}/staff/update" method="post" onsubmit="return submitCheck()">
                            <input type="hidden" id="isNew" name="isNew" value="${isNew?string('true', 'false')}"/>
                            <input type="hidden" id="staffId" name="id" value="${editStaff.id!}"/>
                            <div class="box-body">
                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>用户名</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="username" name="username" <#if isNew ==false>disabled="disabled"</#if>
                                               value="${editStaff.username!}" required placeholder="用户名">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>真实姓名</label>
                                    <div class="col-sm-3">
                                        <input type="text" id="realName" name="realName" value="${editStaff.realName!}" class="form-control" required
                                               placeholder="真实姓名">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>电子邮箱</label>
                                    <div class="col-sm-3">
                                        <input type="text" class="form-control" id="checkedEmail" name="checkedEmail"
                                               value="${editStaff.checkedEmail!}" required placeholder="电子邮箱">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>工作岗位</label>
                                    <div class="col-sm-3">
                                        <input type="text" id="posts" name="posts" value="${editStaff.posts!}" class="form-control" required
                                               placeholder="工作岗位">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="inputEmail3" class="col-sm-2 control-label"><span class="text-red">*</span>密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="password" name="password"
                                               value=""  placeholder="密码">
                                    </div>

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>确认密码</label>
                                    <div class="col-sm-3">
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword"
                                               value=""  placeholder="确认密码">
                                    </div>

                                </div>

                                <div class="form-group">

                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>是否禁用</label>
                                    <div class="col-sm-5">
                                        <div class="radio-inline"><input type="radio" name="disable" value="0" <#if editStaff.isDisable ==false>checked="checked"</#if>> 否</div>
                                        <div class="radio-inline"><input type="radio" name="disable" value="1" <#if editStaff.isDisable ==true>checked="checked"</#if>>是</div>
                                    </div>

                                </div>

                                <div class="form-group">
                                    <label for="inputPassword3" class="col-sm-2 control-label"><span class="text-red">*</span>职员权限</label>

                                    <#list staffPerms as perm>
                                        <div class="radio-inline"><input type="checkbox" name="staffPerms" value="${perm.id }"
                                        <#if isNew==false>
                                            <#list oldPerms as oldPerm>
                                                <#if perm.id == oldPerm.id> checked="checked" </#if>
                                            </#list>
                                        </#if>
                                        > ${perm.menuText }</div>
                                    </#list>

                                </div>

                                <div class="form-group">
                                </div>

                            </div>
                            <!-- /.box-body -->
                            <div class="box-footer">
                                <button type="button" class="btn btn-default" onclick="cancel('${ctx}/staff/')">取消
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
        var checkedEmail = $("#checkedEmail").val();
        var password = $("#password").val();
        var confirmPassword = $("#confirmPassword").val();
        var isFlag = true;
        var emailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
        isFlag = emailReg.test(checkedEmail);
        if(isNew=="true"){
            if(password.length<6){
                isFlag=false;
                window.wxc.xcConfirm("密码长度至少为6位，请重新输入。", "error");
            }else if(password!=confirmPassword){
                isFlag=false;
                window.wxc.xcConfirm("两次输入的密码不一致，请确认后重试。", "error");
            }
        }
        return isFlag;
    }

    function cancel(url){
        window.location.href=url;
    }

</script>

</body>
</html>
