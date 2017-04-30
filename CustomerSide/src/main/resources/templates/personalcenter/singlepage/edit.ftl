<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改密码</title>
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
							<a href="person.html" class="list-group-item">我的订单</a>
							<a href="jifen.html" class="list-group-item">我的积分</a>
							<a href="lvke.html" class="list-group-item">常用旅客</a>
							<a href="changepassword.html" class="list-group-item active">修改密码</a>
							<a href="changemibao.html" class="list-group-item">修改密保</a>
							<a href="changeemail.html" class="list-group-item">修改邮箱</a>
						</div>
					</div>
					<!--订单列表-->
					<div class="col-md-10 well">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title"><i class="fa fa-key"></i>修改密码</h3>
							</div>
							<div class="panel-body">
								<form action="/update" class="form-horizontal">
									 <div class="form-group">
									    <label for="oldpsw" class="col-md-2 control-label">当前密码</label>
									    <div class="col-md-3">
									      <input type="password" name="oldPassword" class="form-control" id="oldpsw" >
									    </div>
									 </div>
									<div class="form-group">
									    <label for="newpsw" class="col-md-2 control-label">新密码</label>
									    <div class="col-md-3">
									      <input type="password" class="form-control" id="newpsw" name="newPassword" >
									    </div>
									 </div>
									<div class="form-group">
									    <label for="cfpsw" class="col-md-2 control-label">确认密码</label>
									    <div class="col-md-3">
									      <input type="password" class="form-control" id="cfdpsw" >
									    </div>
									 </div>
									 <div class="form-group">
									    <input type="submit" value="保存修改" class="col-md-offset-3  btn btn-primary" />
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
</html>
