<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改邮箱</title>
	<#include "/include/resources.ftl">
	</head>
	<body>
		 <!--头部开始-->
		 <#include "/include/pagehead.ftl"/>
		<!--我的积分主体-->
		<section id="person" style="padding-top: 50px;">
			<div class="container">
				<div class="row">
					<div class="col-md-2 text-center">
						<div class="list-group">
                            <a href="../../personalcenter/myorder" class="list-group-item">我的订单</a>
                            <a href="../../personalcenter/commonpassager/list" class="list-group-item">常用旅客</a>
                            <a href="../../personalcenter/edit" class="list-group-item">修改密码</a>
                            <a href="../../personalcenter/editquestion" class="list-group-item">修改密保</a>
                            <a href="../../personalcenter/editemail" class="list-group-item active">修改邮箱</a>
						</div>
					</div>
					<!--订单列表-->
					<div class="col-md-10 well">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title"><i class="fa fa-envelope"></i> 修改邮箱</h3>
							</div>
							<div class="panel-body">
								<form action="../../personalcenter/updateemail" class="form-horizontal">
									<div class="form-group">
									    <p class="col-md-4">当前邮箱：<span>${customer.checkedEmail!}</span></p>
									</div>
									<div class="form-group">
									    <label  class="col-md-2 control-label">新邮箱</label>
									    <div class="col-md-5">
									      <input type="email" name="newEmail" class="form-control" >
									    </div>
									</div>
									<div class="form-group">
									    <label  class="col-md-2 control-label">输入密码确认</label>
									    <div class="col-md-5">
									      <input type="password" name="password" class="form-control" >
									    </div>
									</div>
									 <div class="col-md-offset-2">
										<input type="submit" value="保存修改" class="btn btn-primary" />
									</div>
								</form>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</section>
		<!--脚注区域-->
		 <#include "/include/pagefoot.ftl"/>
	</body>
    <script src="${ctx}/customized/js/editemail.js" type="text/javascript" charset="utf-8"></script>
</html>
