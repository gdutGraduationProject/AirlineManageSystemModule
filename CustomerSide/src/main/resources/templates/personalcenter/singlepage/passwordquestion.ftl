<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>修改密保</title>
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
							<a href="changepassword.html" class="list-group-item">修改密码</a>
							<a href="changemibao.html" class="list-group-item active">修改密保</a>
							<a href="changeemail.html" class="list-group-item">修改邮箱</a>
						</div>
					</div>
					<!--订单列表-->
					<div class="col-md-10 well">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title"><i class="fa fa-quora"></i>修改密保</h3>
							</div>
							<div class="panel-body">
								<form action="/updatequestion" class="form-horizontal" method="post">
									 <div class="form-group">
									    <label  class="col-md-2 control-label">密保问题</label>
									    <div class="col-md-5">
									        <input type="text" class="form-control" name="question" value="${customer.passwordQuestion}">
										    </input>
									    </div>
									</div>
									<div class="form-group">
									    <label  class="col-md-2 control-label">密保答案</label>
									    <div class="col-md-5">
									      <input type="text" class="form-control" name="answer" value="${customer.passwordAnswer}" >
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
</html>
