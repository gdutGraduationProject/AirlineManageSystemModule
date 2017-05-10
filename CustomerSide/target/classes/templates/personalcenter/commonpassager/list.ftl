<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>常用旅客列表</title>
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
							<a href="#" class="list-group-item active disabled">常用旅客</a>
							<a href="changepassword.html" class="list-group-item">修改密码</a>
							<a href="changemibao.html" class="list-group-item">修改密保</a>
							<a href="changeemail.html" class="list-group-item">修改邮箱</a>
						</div>
					</div>
					<!--订单列表-->
					<div class="col-md-10 well">
						<div class="panel panel-default">
							<div class="panel-heading">
							常用旅客列表：<button class="pull-right btn btn-default btn-sm"><a href="../../personalcenter/commonpassager/edit">新增</a></button>
							</div>
							<div class="panel-body">
								<table class="table table-condensed">
							<tr>
								<th>姓名</th>
								<th>手机号码</th>
								<th>证件类型</th>
								<th>证件号码</th>
								<th>性别</th>
								<th>操作</th>
							</tr>

									<#if isNull=="true">
									    <tr><td colspan="6" style="text-align: center"><h3>当前无常用联系人</h3>	</td></tr>
									<#else>
										<#list passagerList as passager>
                                            <tr>
                                                <td>${passager.name}</td>
                                                <td>${passager.phoneNumber}</td>
                                                <td>${passager.idType}</td>
                                                <td>${passager.idNumber}</td>
                                                <td>${passager.sex}</td>
                                                <td><a href="${ctx}/personalcenter/commonpassager/delete?id=${passager.id}">删除</a>
                                                    <a href="${ctx}/personalcenter/commonpassager/edit?id=${passager.id}">编辑</a>
                                                </td>
                                            </tr>
										</#list>
									</#if>
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							<#--<tr>-->
								<#--<td>张三</td>-->
								<#--<td>18888888888</td>-->
								<#--<td>身份证</td>-->
								<#--<td>4415211999999999999</td>-->
								<#--<td>男</td>-->
								<#--<td><a href="#">删除</a>-->
									<#--<a href="#">编辑</a>-->
								<#--</td>-->
							<#--</tr>-->
							
							
						</table>
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
