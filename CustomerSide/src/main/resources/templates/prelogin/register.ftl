<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>用户注册</title>
	<link rel="stylesheet" type="text/css" href="${ctx}/bootstrap/css/bootstrap.min.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/font-awesome/css/font-awesome.min.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/customized/css/iconfont.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/customized/css/header.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/customized/css/footer.css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/customized/css/register.css"/>
</head>
<body>
	<!--头部开始-->
	<header id="header">
		<!--顶部通栏-->
		<div class="topbar visible-md visible-lg">
	      <div class="container">
	        <div class="row">
	          <div class="col-md-1">
	          	<a href="index.html">
			      	<i class="iconfont icon-feiji"></i>
			    </a>
	          </div>
	          <div class="col-md-2 text-center">
	            <button id="author" class="btn btn-default btn-sm" 
	            	data-toggle="popover"><i class="fa fa-wechat"></i>  联系作者</button>
	          </div>
	          <div class="col-md-2 text-center">
	          	<button id="friend" class="btn btn-default btn-sm" 
	            	data-toggle="popover"><i class="fa fa-handshake-o"></i>  合作伙伴</button>
	          </div>
	          <div class="col-md-4 text-center">
	            <i class="fa fa-envelope"></i> weiyeweb@126.com（服务时间：9:00-21:00）
	          </div>
	          
	          <div class="col-md-3 text-center">
	            <a href="signUp.html" class="btn btn-danger btn-sm register">立即注册</a>
	            <a href="login.html" class="btn btn-primary btn-sm log"> 登录</a>
	          </div>
	        </div>
	      </div>
	    </div>
	</header>
	<section id="register">
		<div class="container">
			<div class="page-header">
				<h2>会员注册 <small>Member registration</small></h2>
			</div>
			<div class="panel panel-default">
				<div class="panel-body">
					<form action="/registe" class="form-horizontal">
						<div class="form-group">
							<label for="rgname" class="col-md-2 control-label">用户名</label>
						    <div class="col-md-5">
						      <input type="text" class="form-control" id="rgname" name="username" placeholder="username">
						    </div>
						</div>
						<div class="form-group">
							<label for="rguser" class="col-md-2 control-label">真实姓名</label>
						    <div class="col-md-5">
						      <input type="text" class="form-control" id="rguser" name="realName" placeholder="Real name">
						    </div>
						</div>
						<div class="form-group">
							<label for="idcard" class="col-md-2 control-label">身份证号</label>
						    <div class="col-md-5">
						      <input type="text" class="form-control" id="idcard" placeholder="ID card" name="idNumber">
						    </div>
						</div>
						<div class="form-group">
							<label for="rgphone" class="col-md-2 control-label">手机号</label>
						    <div class="col-md-5">
						      <input type="tel" class="form-control" id="rgphone" placeholder="Mobile phone" name="newPhoneNumber">
						    </div>
						</div>
						<div class="form-group">
						    <label for="rgemail" class="col-md-2 control-label">电子邮件</label>
						    <div class="col-md-5">
						      <input type="email" class="form-control" id="rgemail" placeholder="Email" name="newEmail">
						    </div>
						</div>	
						<div class="form-group">
						    <label  class="col-md-2 control-label">密保问题</label>
						    <div class="col-md-5">
						        <select class="form-control" name="passwordQuestion">
									<option>您大学学的什么专业？</option>
									<option>您小学班主任的名字？</option>
									<option>您的中学名字？</option>
									<option>谁是您最好的朋友？</option>
							    </select>
						    </div>
						</div>
						<div class="form-group">
						    <label for="answer" class="col-md-2 control-label">密保答案</label>
						    <div class="col-md-5">
						      <input type="text" class="form-control" id="answer" placeholder="Encrypted answers" name="passwordAnswer">
						    </div>
						</div>
						<div class="form-group">
						    <label for="rgpassword" class="col-md-2 control-label">密码</label>
						    <div class="col-md-5">
						      <input type="password" class="form-control" id="rgpassword" placeholder="Password" name="password">
						    </div>
						</div>
						<div class="form-group">
							<label for="cfpassword" class="col-md-2 control-label">确认密码</label>
						    <div class="col-md-5">
						      <input type="password" class="form-control" id="cfpassword" placeholder="Confirm Password">
						    </div>
						</div>
						<div class="form-group">
							<label class="col-md-2 control-label">AMS服务条款</label>
							<div class=" col-md-5">
								<textarea disabled="disabled" class="form-control" rows="8"> AMS注册声明：								
1.“AMS系统”是由highnessE负责管理及运营。
2.法人或其他非法人组织没有资格参加本奖励计划。本奖励计划除家庭积分计划规定外，亦不受理以共同累积积分或相关情况为目的的数人联合申请或同一人重复申请。 								
3.旅客填写的个人信息须详细、准确；若个人信息提供不完整或不真实，AMS将无法办理此类注册申请。 
4.加入成为会员，即表示同意并遵守AMS的相关规定和要求，以及今后可能发生的变动和补充。 
5.除家庭积分合算之外，会员积分均不得转让或合并，积分奖励如因政府相关法规而应予课税时，税费须由会员自行承担。 
6.会员如呈不实之资料(如飞行记录)等任何违反本计划条款或规则的行为，本人有权视情节采取以下一项或数项法律行动：(1)要求赔偿损失；(2)终止会员资格；(3)取消已累积的积分；(4)会员须缴付已搭乘航班的全额经济舱、头等舱之票价及相关的律师费、诉讼费等。  
7.AMS是决定会员是否符合资格获取积分的最终机构；若会员违反会员指南中的条款及规则而获得积分，AMS有权在任何时候予以取消。 
8.AMS合作伙伴及其地址、电话如有更改或终止合作计划，将在官网进行公示。AMS及有关合作伙伴恕不另行通知。
9.为保障您的合法权益，请会员认真阅读本会员指南，尤其是本会员指南中粗体部分。 
								</textarea>
							</div>	
						</div>
						<div class="col-md-offset-2">
							<input type="checkbox" id="agree" /> 已阅读并同意以上条款  
						</div>
						<br />
						<div class="col-md-offset-2">
							<input type="submit" disabled="disabled" value="下一步" class="btn btn-warning" id="next"/>
						</div>
						
					</form>
				</div>
			</div>
			
		</div>
		
	</section>
	<footer id="footer" >
			<div class="footer-copyright">
	            &copy; AirManagement System by  <a href="">HighnessE</a>.
	        </div>
	</footer>
	<script src="${ctx}/jquery/jquery-1.11.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx}/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="${ctx}/customized/js/register.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>