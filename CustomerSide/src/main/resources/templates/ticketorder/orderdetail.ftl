<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>个人中心</title>
	<#include "/include/resources.ftl">
	<link rel="stylesheet" type="text/css" href="../../customized/css/orderdetail.css"/>
	</head>
	<body>
		 <!--头部开始-->
		 <#include "/include/pagehead.ftl"/>
		<!--个人中心主体-->
		<section id="person" style="margin-top: 50px;margin-bottom: 50px;">
			<div class="container">
				<div class="row">
					<div class="col-md-2 text-center">
						<div class="list-group">
                            <a href="../../personalcenter/myorder" class="list-group-item active">我的订单</a>
                            <a href="../../personalcenter/commonpassager/list" class="list-group-item">常用旅客</a>
                            <a href="../../personalcenter/edit" class="list-group-item">修改密码</a>
                            <a href="../../personalcenter/editquestion" class="list-group-item">修改密保</a>
                            <a href="../../personalcenter/editemail" class="list-group-item">修改邮箱</a>
						</div>
					</div>					
					<div class="col-md-10">
						<!--订单信息-->
						<div class="ticketdetail panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">详细信息</h3>
							</div>
							<div class="panel-body">
								<p>订单状态：<span class="fw">
								<#if ticketOrder.orderStatus==1>待付款<font color="red"> 请在${cancleTime}前支付，否则订单将被取消</font>
								<#elseif ticketOrder.orderStatus==2>已付款
								<#elseif ticketOrder.orderStatus==3>已取消
								<#elseif ticketOrder.orderStatus==4>已失效</#if>
								</span></p>
								<p>订单号：<span class="fw">${ticketOrder.orderNum}</span></p>
								<p>预定日期：${ticketOrder.orderTime}</p>
								<p>预定方式：网上预定</p>
								<p class="price">总金额：¥<span id="allprice">${ticketOrder.payFee}</span></p>
								<p class="text-right">
									<button type="button"  class="btn btn-primary" onclick="jumpUrl('../../buyticket/payorder?id=${ticketOrder.id}')" <#if ticketOrder.orderStatus!=1>style="display: none" </#if> >去支付</button>
									<button type="button" class="btn btn-danger" onclick="jumpUrl('../../buyticket/deleteorder?id=${ticketOrder.id}')" <#if ticketOrder.orderStatus==1>style="display: none" </#if> >删除订单</button>
									<button type="button" class="btn btn-warning" onclick="jumpUrl('../../buyticket/cancleorder?id=${ticketOrder.id}')" <#if ticketOrder.orderStatus!=1>style="display: none" </#if>>取消订单</button>
								</p>
							</div>
						</div>
						<!--航班-->
						<div class="ticketmodal panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">航班</h3>
							</div>
							<div class="panel-body">
								<div class="ticketheader">
									<div class="col-md-8">
										<dl>
											<dt>单程</dt>
											<dd>${ticketOrder.flightDay}</dd>
											<dd>${ticketOrder.airline.departure.city}-${ticketOrder.airline.destination.city}</dd>
											<dd><span class="custom"></span></dd>
										</dl>
									</div>
								</div>
								<div class="container">
									<div class="row">
										<div class="col-md-2">
								    		<p class="airName">广工航空</p>
								    		<p class="airModel">${ticketOrder.airline.plane.company}${ticketOrder.airline.plane.modelName}</p>
								    	</div>
							    		<div class="col-md-2 text-center">
							    			<p><span class="goTime">${ticketOrder.airline.startTime?time}</span></p>
							    			<p>${ticketOrder.airline.departure.airportName}</p>
							    		</div>
							    		<div class="col-md-1 text-center"><i class="fa fa-long-arrow-right"></i></div>
							    		<div class="col-md-2 text-center">
							    			<p><span class="arriveTime">${ticketOrder.airline.arriveTime?time}</span></p>
							    			<p>${ticketOrder.airline.destination.airportName}</p>
							    		</div>
									</div>									
								</div>
								<div class="container" style="margin-top: 10px;">
									<div class="row">
										<div class="col-md-1">
											<p>退改说明</p>
										</div>	
										<div class="col-md-8">
											<table class="table table-bordered">
												<tr>
													<th></th>
													<th>起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时前</th>
													<th>起飞前${ticketOrder.leftTicketClass.airlineClass.splitTime}小时后</th>
												</tr>
												<tr>
													<td>产品退订费</td>
													<td>¥${ticketOrder.leftTicketClass.airlineClass.beforeRefundFee}/人</td>
													<td>¥${ticketOrder.leftTicketClass.airlineClass.afterRefundFee}/人</td>
												</tr>
												<tr>
													<td>产品更改费</td>
													<td>¥${ticketOrder.leftTicketClass.airlineClass.beforeChangeFee}/人</td>
													<td>¥${ticketOrder.leftTicketClass.airlineClass.afterChangeFee}/人</td>
												</tr>
												
											</table>
										</div>
									</div>									
								</div>								
							</div>
						</div>	
						<!--乘机人-->
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">乘机人</h3>
							</div>
							<div class="panel-body">

								<#list ticketOrder.subOrderList as subOrder>
                                <div class="customDetail">
                                    <div class="col-md-2">
                                        <p>姓名：</p>
                                        <p>证件信息：</p>
                                        <p>预定日期：</p>
                                        <p>手机号码：</p>
                                        <p>状态：</p>
                                    </div>
                                    <div class="col-md-4">
                                        <p><span class="fw">${subOrder.commonPassager.name}</span></p>
                                        <p><span class="fw">${subOrder.commonPassager.idType} ${subOrder.commonPassager.idNumber}</span></p>
                                        <p>${ticketOrder.orderTime?date}</p>
                                        <p>${subOrder.commonPassager.phoneNumber}</p>
                                        <p><#if subOrder.status==1>待付款
										<#elseif subOrder.status==2>已付款
										<#elseif subOrder.status==3>已取消
										<#elseif subOrder.status==4>已失效
										<#elseif subOrder.status==5>已退票
										<#elseif subOrder.status==6>已改签</#if></p>
                                    </div>
                                </div>
								</#list>

								<#--<div class="customDetail">-->
									<#--<div class="col-md-2">-->
										<#--<p>姓名：</p>-->
										<#--<p>证件信息：</p>-->
										<#--<p>预定日期：</p>-->
										<#--<p>手机号码：</p>-->
										<#--<p>票号：</p>-->
									<#--</div>-->
									<#--<div class="col-md-4">-->
										<#--<p><span class="fw">孙悟空</span></p>-->
										<#--<p><span class="fw">身份证 23244555****</span></p>-->
										<#--<p>2017-1-1</p>-->
										<#--<p>18888888888</p>-->
										<#--<p>880-2130900362（已使用）</p>-->
									<#--</div>-->
								<#--</div>-->
								<#--<div class="customDetail">-->
									<#--<div class="col-md-2">-->
										<#--<p>姓名：</p>-->
										<#--<p>证件信息：</p>-->
										<#--<p>预定日期：</p>-->
										<#--<p>手机号码：</p>-->
										<#--<p>票号：</p>-->
									<#--</div>-->
									<#--<div class="col-md-4">-->
										<#--<p><span class="fw">孙悟空</span></p>-->
										<#--<p><span class="fw">身份证 23244555****</span></p>-->
										<#--<p>2017-1-1</p>-->
										<#--<p>18888888888</p>-->
										<#--<p>880-2130900362（已使用）</p>-->
									<#--</div>-->
								<#--</div>-->
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--脚注区域-->
		 <#include "/include/pagefoot.ftl"/>
	</body>
<script type="text/javascript" >
	function jumpUrl(url) {
        window.location.href=url;
    }
</script>
</html>
