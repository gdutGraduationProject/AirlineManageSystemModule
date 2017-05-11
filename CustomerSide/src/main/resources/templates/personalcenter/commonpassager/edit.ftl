<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改旅客</title>
	<#include "/include/resources.ftl">
	</head>
	<body>
		 <!--头部开始-->
		 <#include "/include/pagehead.ftl"/>
		<!--个人中心主体-->
		<section id="person" style="padding-top: 50px;">
			<div class="container">
				<div class="row">
					<div class="col-md-2 text-center">
						<div class="list-group">
							<a href="../../personalcenter/myorder" class="list-group-item">我的订单</a>
							<a href="../../personalcenter/commonpassager/list" class="list-group-item active">常用旅客</a>
							<a href="../../personalcenter/edit" class="list-group-item">修改密码</a>
							<a href="../../personalcenter/editquestion" class="list-group-item">修改密保</a>
							<a href="../../personalcenter/editemail" class="list-group-item">修改邮箱</a>
						</div>
					</div>
					<!--订单列表-->
					<div class="col-md-10 well">
					
						<div class="panel panel-default">
						  <div class="panel-heading">
						  	
						  </div>
						  <div class="panel-body">
						   		<form action="../../personalcenter/commonpassager/update" method="post" class="form-horizontal">
									<input type="hidden" name="oldId" value="${commonPassager.id!}">
									 <div class="form-group">
									    <label for="newuser" class="col-md-2 control-label">姓名</label>
									    <div class="col-md-3">
									      <input type="text" class="form-control" id="newuser" name="name" value="${commonPassager.name!}">
									    </div>
									 </div>
									<div class="form-group">
									    <label for="newphone" class="col-md-2 control-label">手机号码</label>
									    <div class="col-md-3">
									      <input type="text" class="form-control" id="newphone" name="phoneNumber" value="${commonPassager.phoneNumber!}" >
									    </div>
									 </div>
									 <div class="form-group">
									    <label class="col-md-2 control-label">证件类型</label>
									    <div class="col-md-3">
											<select class="form-control" name="idType">
												<option value="身份证" <#if commonPassager.idType=="身份证">selected</#if>>身份证</option>
												<option value="港澳通行证" <#if commonPassager.idType=="港澳通行证">selected</#if>>港澳通行证</option>
											</select>
									      <#--<input type="text" class="form-control" value="身份证" disabled="disabled">-->
									    </div>
									 </div>
									<div class="form-group">
									    <label for="newidcard" class="col-md-2 control-label">证件号码</label>
									    <div class="col-md-3">
									      <input type="text" class="form-control" id="newidcard" name="idNumber" value="${commonPassager.idNumber!}">
									    </div>
									 </div>
									 <div class="form-group">
									    <label for="" class="col-md-2 control-label">性别</label>
									    <div class="col-md-3">
									    	<label class="radio-inline">
											  <input type="radio" name="sex" value="男" <#if commonPassager.sex=="男">checked</#if>> 男
											</label>
											<label class="radio-inline">
											  <input type="radio" name="sex" value="女" <#if commonPassager.sex=="女">checked</#if>> 女
											</label>
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
