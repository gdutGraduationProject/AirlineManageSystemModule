<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>操作失败</title>
<#include "/include/resources.ftl">
</head>
<body>
<#include "/include/pagehead.ftl"/>
		
		<!--错误信息-->
		<div class="container" style="margin-top: 50px;">
			<div class="well well-lg" style="height: 450px;">
				<p class="text-center"><img src="../../images/error.png"/></p>
				<br /><br /><br /><br />
				<p class="text-center">操作失败，请重试！</p>
                <p class="text-center"><#if error_reason??>错误原因：${error_reason}</#if></p>
			</div>
			
		</div>


<#include "/include/pagefoot.ftl"/>
	

	<script src="customized/js/index.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>