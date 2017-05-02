<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
  		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">	
		<title>欢迎来到航空售票系统</title>
	<#include "/include/resources.ftl">
	<link rel="stylesheet" type="text/css" href="customized/css/index.css"/>
	</head>
	<body>
		
		<!--头部开始-->
		<#include "/include/pagehead.ftl"/>
		<!--头部结束-->
		
		<!--轮播图区域-->
		<section>
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
		  <!-- 小圆点 -->
			  	<ol class="carousel-indicators">
			      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			      <li data-target="#myCarousel" data-slide-to="1"></li>
			      <li data-target="#myCarousel" data-slide-to="2"></li>
			    </ol>
			
			  <!--图片轮播-->
			  	<div class="carousel-inner" >
				    <div class="item active" >
				      <img src="images/slider01.jpg" >
				      <!--<div class="carousel-caption"></div>-->
				    </div>
				    <div class="item" >
				      <img src="images/slider02.jpg" >
				      <!--<div class="carousel-caption"></div>-->
				    </div>
				    <div class="item" style="background: #222222">
				      <img src="images/slider03.jpg" >
				      <!--<div class="carousel-caption"></div>-->
				    </div>
				</div>
				
		       <!-- 控件 -->
				<a class="left carousel-control" href="#myCarousel" data-slide="prev">
					 <span class="glyphicon glyphicon-chevron-left" ></span>
				</a>
				<a class="right carousel-control" href="#myCarousel" data-slide="next">
					  <span class="glyphicon glyphicon-chevron-right" ></span>
				</a>

                <!--机票查询区域-->
                <div class="panel panel-default" id="checkDiv">
                    <!--面板头部-->
                    <div class="panel-heading">
                        <h3 class="panel-title">机票搜索 <span class="label label-default">Ticket search</span></h3>
                    </div>
                    <!--面板主体-->
                    <div class="panel-body">
                        <form action="../../ticketsearch" method="post" class="form-horizontal" id="ticketForm">
                            <div class="form-group">
                                <label class="control-label col-md-3">出发城市</label>
                                <div class="col-md-9">
                                    <select class="form-control" name="departureId">
									<#list airportList as airport>
                                        <option value="${airport.id}"}>${airport.shortEng} - ${airport.city} - ${airport.airportName}</option>
									</#list>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="control-label col-md-3">目的城市</label>
                                <div class="col-md-9">
                                    <select class="form-control" name="destinateId">
										<#list airportList as airport>
										    <option value="${airport.id}"}>${airport.shortEng} - ${airport.city} - ${airport.airportName}</option>
										</#list>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-md-3">出发日期</label>
                                <div class="col-md-9">
                                    <input type="text" class="form-control" onclick="WdatePicker()" name="departure">
                                </div>
                            </div>
                            <br /><br />
                            <button type="submit" class="btn btn-warning col-md-3 col-md-offset-9">搜索机票</button>
                        </form>
                    </div>
                </div>
		</section>
		
		
	    <!--脚注区域-->
		<#include "/include/pagefoot.ftl"/>

	<script src="customized/js/index.js" type="text/javascript" charset="utf-8"></script>
	
	</body>
</html>
