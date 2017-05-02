<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>用户登录</title>
<#include "/include/resources.ftl">
	<link rel="stylesheet" type="text/css" href="customized/css/login.css"/>
</head>
<body>
	<!--头部开始-->
	<#include "/include/pagehead.ftl"/>
	<section id="login">
		<div class="container">
			<div class="row">
				<div class="page-header">
					<h2>会员登录 <small>Member Login</small></h2>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">
                        <div class="form-group has-feedback" style="text-align: center">
                            <h2>
							<#if error_reason??>
                        ${error_reason }
                    </#if>
                            </h2>
                        </div>
						<form class="form-horizontal" action="loginconfirm" method="post" onsubmit="return submitCheck()">
							<div class="form-group">
							    <div class="input-group col-md-offset-4 col-md-4">
				            		<label for="username" class="input-group-addon"><i class="fa fa-envelope-o fa-fw"></i></label>
								  	<input class="form-control" id="username" placeholder="Email / username / phone number" name="loginUsername">
							    </div>
							</div>
							<div class="form-group">
							    <div class="input-group col-md-offset-4 col-md-4">
				            		<label for="password" class="input-group-addon"><i class="fa fa-key fa-fw"></i></label>
								  	<input type="password" class="form-control" id="loginPassword" placeholder="Password" name="password">
							    </div>
							</div>

				            <div class="form-group">
				            	<div class="col-md-offset-6 col-md-2">
					             	<span>没有账号？</span><a href="${ctx}/registePage">立即注册！</a>
					             </div>
				            </div>
				            <div class="form-group">
				            	<div class="col-md-offset-7">
				            		<input type="submit" class="btn btn-primary" value="登录"/>
				            	</div>
				            </div>
						</form>
					</div>
				</div>
			</div>	
		</div>
		
	</section>
	<#include "/include/pagefoot.ftl"/>

	<script src="customized/js/index.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		function submitCheck() {
			var username = $("#username").val();
			var password = $("#loginPassword").val();
			if(username==null || username==""){
			    window.wxc.xcConfirm("用户名不能为空","error");
			    return false;
			}else if(password==null || password==""){
                window.wxc.xcConfirm("密码不能为空","error");
                return false;
			}else{
			    return true;
			}
        }

        function isEmail(str){
            var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
            return reg.test(str);
        }
	</script>
</body>
</html>