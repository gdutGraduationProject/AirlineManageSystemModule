<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>关于AMS网站</title>
	<#include "/include/resources.ftl">
	</head>
	<body >
		< <!--头部开始-->
		<#include "/include/pagehead.ftl"/>
		<div class="container">
			<div class="row">
				<div class="col-md-3" id="myAffix" style="margin-top: 60px;">
					<div class="list-group" data-spy="affix" >
						<a class="list-group-item" href="#section-1">网站介绍</a>
						<a class="list-group-item" href="#section-2">核心技术</a>
						<a class="list-group-item" href="#section-3">联系我们</a>
					</div>
				</div>
				<div class="col-md-9 contents">
					<h2 id="section-1" class="page-header">网站介绍</h2>
					<div style="line-height:2;text-indent: 2em;" class="well">
						<p>AirManagement System简称'AMS'，创建于2017年。主要分为两部分：用户系统和管理员系统，本站为用户系统方向的站点。</p>
						<p>用户进入本站后经过注册、登录即可使用网站的机票搜索功能。在选择出发城市和日期以及目的城市后将会跳转到可购买的机票列表页面，可以选择您中意的航空公司的航班，当选择订票后会弹出该航班在售的机票信息和价格。用户点击预定按钮后将来到网站的添加乘客的界面。若您不是初次购票，可以快速常用联系人进行购票，您也可以在个人中心管理您的常用旅客方便日后购票。若是初次购票，点击增加乘客按钮后输入乘客相关信息即可进入支付页面。值得注意的是，此时的乘客信息将自动变成您的常用旅客。若您因特殊原因想退票，可以移步到订单详情页实现退票功能。您也可以在个人中心随时查看我的订单和我的积分，有必要的话还可以在这里修改密码、密保或者邮箱。</p>
					</div>
					<h2 id="section-2" class="page-header">核心技术</h2>
					<div style="line-height:2;text-indent: 2em;" class="well">
						<p>本站是基于web标准的前台开发页面。在web前端开发方面使用到的核心技术包括HTML5、CSS3、jQuery和bootstrap。</p>
						<p>HTML5是HTML最新的修订版本，2014年10月由万维网联盟（W3C）完成标准制定。HTML5的设计目的是为了在移动设备上支持多媒体。HTML5定义了一系列新元素，如新语义标签、智能表单、多媒体标签等，可以帮助开发者创建富互联网应用，还提供了一些Javascript API，如地理定位、重力感应、硬件访问等，可以在浏览器内实现类原生应用，甚至结合Canvas我们可开发网页版游戏。</p>
						<p>CSS3是被W3C推荐的产品，是CSS技术的升级版本，CSS3语言开发是朝着模块化发展的。这些模块包括：盒子模型、列表模块、超链接方式、语言模块、背景与边框、文字特效、多栏布局和动画特效等，这些模块从2001年到今天都处在开发和完善之中，是下一代Web标准。</p>
						<p>jQuery是一个快速、简洁的JavaScript类库，它通过封装原生的JavaScript函数得到一整套定义好的方法。jQuery设计的宗旨是“Write Less，Do More”，即倡导写更少的代码，完成更多复杂而困难的功能，从而得到了开发者的青睐。jQuery是一个快速、简洁的JavaScript类库，它通过封装原生的JavaScript函数得到一整套定义好的方法。jQuery设计的宗旨是“Write Less，Do More”，即倡导写更少的代码，完成更多复杂而困难的功能，从而得到了开发者的青睐。</p>
						<p>Bootstrap是目前很受欢迎的前端框架。Bootstrap 是基于 HTML、CSS、JavaScript的，它简洁灵活，使得 Web 开发更加快捷。它由Twitter的设计师Mark Otto和Jacob Thornton合作开发，是一个CSS/HTML框架。Bootstrap提供了优雅的HTML和CSS规范，它即是由动态CSS语言Less写成。Bootstrap一经推出后颇受欢迎，一直是GitHub上的热门开源项目。</p>													
					</div>
					<h2 id="section-3" class="page-header">联系方式</h2>
					<div style="line-height:2;text-indent: 2em;" class="well">
						<p>地址：广东省广州市番禺区大学城外环西路100号</p>
						<p>邮编：510000</p>
						<p>邮箱地址：${myemail}</p>
					</div>
					
					
				</div>
			</div>
		</div>
		<#include "/include/pagefoot.ftl"/>
	<script src="lib/jquery/jquery-1.11.3.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="lib/bootstrap/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
	</body>
</html>
