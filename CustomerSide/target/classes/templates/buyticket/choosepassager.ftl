<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>添加旅客</title>
	<#include "/include/resources.ftl">
	<link rel="stylesheet" type="text/css" href="../../customized/css/choosepassager.css"/>
	</head>
	<body>
	<!--头部开始-->
	<#include "/include/pagehead.ftl"/>
	
	<section id="addlvke" style="margin-top: 50px;margin-bottom: 100px;">
		<div class="container">
			<div class="row">
				<div class="col-md-8">
					<!--乘客列表面板-->
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">乘客</h3>
						</div>
						<div class="panel-body">
							<form action="" method="post">
                                <input type="hidden" name="leftTicket" id="leftTicket" value="${leftTicket.id}" />
                                <input type="hidden" name="leftTicketClass" id="leftTicketClass" value="${leftTicketClass.id}" />
								<input type="hidden" name="classCount" id="classCount" value="0" />
								<div class="btn-group user-check" data-toggle="buttons">

									<#list commonPassager as passager>
                                    <label class="btn btn-default">
                                        <input type="checkbox" autocomplete="off" name="commonPassager" value="${passager.id}" > ${passager.name}
                                    </label>
                                    <div class="user-info">
                                        <ul class="list-group">
                                            <li class="list-group-item list-group-item-success">姓名：${passager.name}</li>
                                            <li class="list-group-item list-group-item-success">${passager.idType}：${passager.idNumber}</li>
                                            <li class="list-group-item list-group-item-success">手机号：${passager.phoneNumber}</li>
                                        </ul>
                                    </div>
									</#list>


								<#--<label class="btn btn-default">-->
								      <#--<input type="checkbox" autocomplete="off" > 孙悟空-->
								    <#--</label>-->
								    <#--<div class="user-info">-->
								     	<#--<ul class="list-group">-->
								     		<#--<li class="list-group-item list-group-item-success">姓名：孙悟空</li>-->
								     		<#--<li class="list-group-item list-group-item-success">身份证：111111111111111</li>-->
								     		<#--<li class="list-group-item list-group-item-success">手机号：13288888888</li>-->
								     	<#--</ul>-->
								    <#--</div>							    -->
								    <#--<label class="btn btn-default">-->
								      <#--<input type="checkbox" autocomplete="off"> 猪八戒-->
								    <#--</label>-->
								    <#--<div class="user-info">-->
								     	<#--<ul class="list-group">-->
								     		<#--<li class="list-group-item list-group-item-success">姓名：猪八戒</li>-->
								     		<#--<li class="list-group-item list-group-item-success">身份证：111111111111111</li>-->
								     		<#--<li class="list-group-item list-group-item-success">手机号：13288888888</li>-->
								     	<#--</ul>-->
								    <#--</div>-->
								    <#--<label class="btn btn-default">-->
								      <#--<input type="checkbox" autocomplete="off"> 沙和尚-->
								    <#--</label>-->
								    <#--<div class="user-info">-->
								     	<#--<ul class="list-group">-->
								     		<#--<li class="list-group-item list-group-item-success">姓名：沙和尚</li>-->
								     		<#--<li class="list-group-item list-group-item-success">身份证：111111111111111</li>-->
								     		<#--<li class="list-group-item list-group-item-success">手机号：13288888888</li>-->
								     	<#--</ul>-->
								    <#--</div>-->
								</div>
								<hr />
								<div class="panel panel-default alert alert-dismissible" style="display: none;">	
									<button type="button" class="close" data-dismiss='alert'>&times;</button>
									<div class="panel-body">
										<div class="col-md-7 left">
											<div class="col-md-12 fw">
												姓名：<input type="text" id="user" name="user" placeholder="姓名"/>
											</div>
											<div class="col-md-12 fw">
												身份证：<input type="text" class="fw" id="idcard" name="idcard" placeholder="身份证"/ >
											</div>
											<div class="col-md-12 fw">
												电话：<input type="text" id="phone" name="phone" placeholder="电话"/>
											</div>								
										</div>
										<div class="col-md-5 right">								
											<div class="price">¥${leftTicketClass.curPrice?c}</div>
										</div>
									</div>
								</div>
								<button type="button" class="btn btn-default add">+添加乘客</button>
								<hr />
								<button type="submit" class="btn btn-primary btn-block">下一步</button>
							</form>							
						</div>
					</div>
					
					<br/>
				</div>
				<!--右侧机票信息-->
				<div class="col-md-4 text-center bg">
					<dl>
						<dt>${leftTicket.departureDate}</dt>
						<#--<dd>周日</dd>-->
						<dd>${leftTicket.airline.departure.city}</dd>
						<dd>→</dd>
						<dd>${leftTicket.airline.destination.city}</dd>
					</dl>
					<dl class="color">
						<dd>广工航空</dd>
						<dd>${airline.airlineNum}</dd>
						<dd>${airline.plane.company}${airline.plane.modelName}</dd>
						<dd>${leftTicketClass.airlineClass.name}</dd>
					</dl>
					<div class="col-md-4">
						<p class="time">${leftTicket.airline.startTime?time}</p>
						<p>${leftTicket.airline.departure.airportName}</p>
					</div>
					<div class="col-md-4"><i class="fa fa-long-arrow-right"></i></div>
					<div class="col-md-4">
						<p class="time">${leftTicket.airline.arriveTime?time}</p>
						<p>${leftTicket.airline.destination.airportName}</p>
					</div>
					<br /><br /><br /><br />
					<p class="pull-right"><span class="yuan">¥${leftTicketClass.curPrice?c}</span></p>
				</div>
			</div>
		</div>
		
	</section>
	<!--页脚-->
	<#include "/include/pagefoot.ftl"/>


	<script src="../../customized/js/choosepassager.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
		  var num=0;
		$(function(){
		//	增加旅客按钮
		  
		 	$(".add").on("click",function(){	
		 		var classCount=parseInt($("#classCount").val());
		 		var box = $(".panel.alert").eq(0).clone();
		 		box.removeAttr("style");	
		 		circleChangeInput(box,num);
		 		num++;
		 		classCount++;
		 		box.insertBefore(".add");		 		
		 	})
		
		})
		function circleChangeInput(domList,changeNum) {
		    var list = domList.children("input");
		    for(var i=0;i<list.length;i++){
		        $(list[i]).attr("id",$(list[i]).attr("id")+changeNum);
		        $(list[i]).attr("name",$(list[i]).attr("name")+changeNum);
		    }
		    list = domList.children("div");
		    for(var i=0;i<list.children().length;i++){
		        circleChangeInput($(list[i]),changeNum);
		    }
		}
	</script>
	</body>
</html>
