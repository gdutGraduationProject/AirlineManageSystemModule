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
					  <div class="panel-heading">
					    <h3 class="panel-title">机票搜索 <span class="label label-default">Ticket search</span></h3>
					  </div>
					  <div class="panel-body">
					    <form action="#" method="post" class="form-inline" id="ticketForm">					   		
					   		<div class="goBox">
					   			<div class="form-group">
						    		<label for="#goCity">出发城市</label>
								    <input type="text" class="form-control" id="goCity" >
								    <div class="citylist">
								    	<ul class="nav nav-pills" >
										    <li  class="active"><a href="#city-1" data-toggle="tab">ABCDE</a></li>
										    <li ><a href="#city-2"  data-toggle="tab">FGHIJ</a></li>
										    <li ><a href="#city-3"  data-toggle="tab">KLMNO</a></li>
										    <li ><a href="#city-4"  data-toggle="tab">PQRST</a></li>
										    <li ><a href="#city-5"  data-toggle="tab">UVWXYZ</a></li>
										</ul>
										
										  <!-- Tab panes -->
										<div class="tab-content">
										    <div class="tab-pane active" id="city-1">
										    	<dl>
										    		<dt>A</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    		
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>B</dt>
										    		<dd>
										    			<a href="javascript:;">宝宝</a>
										    			<a href="javascript:;">宝宝</a>
										    			<a href="javascript:;">宝宝</a>
										    		</dd>
										    		<dt>C</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    		
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>D</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    		</dd>
										    		<dt>E</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    	</dl>
										    </div>
										    <div class="tab-pane" id="city-2">
										    	<dl>
										    		<dt>F</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		
										    		</dd>
										    		<dt>G</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										   
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>H</dt>
										    		<dd>
										    			<a href="javascript:;">菜菜</a>
										    			
										    			<a href="javascript:;">菜菜</a>
										    		</dd>                      
										    		<dt>I</dt>
										    		<dd>
										    			<a href="javascript:;">等等</a>
										    	
										    		</dd>
										    		<dt>J</dt>
										    		<dd>
										    			<a href="javascript:;">嗯额</a>
										    			
										    			<a href="javascript:;">嗯额</a>
										    		</dd>
										    	</dl>
										    </div>
										    <div class="tab-pane" id="city-3">
										    	<dl>
										    		<dt>K</dt>
										    		<dd>
										    			
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>L</dt>
										    		<dd>

										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>M</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>

										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>N</dt>
										    		<dd>

										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>O</dt>
										    		<dd>

										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    	</dl>
										    </div>
										    <div class="tab-pane" id="city-4">
										    	<dl>
										    		<dt>P</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>

										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>Q</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>

										    		</dd>
										    		<dt>R</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>

										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>S</dt>
										    		<dd>

										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>T</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>

										    		</dd>
										    	</dl>
										    </div>
										    <div class="tab-pane" id="city-5">
										    	<dl>
										    		<dt>U</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    		</dd>
										    		<dt>V</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    		</dd>
										    		<dt>W</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    		</dd>
										    		<dt>X</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    			
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>Y</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    			
										    			<a href="javascript:;">阿门</a>
										    		</dd>
										    		<dt>Z</dt>
										    		<dd>
										    			<a href="javascript:;">阿门</a>
										    			
										    			<a href="javascript:;">阿门</a>
										    			<a href="javascript:;">阿门</a>
										    		</dd>	
										    	</dl>
										    </div>
										</div>
								    </div>
								</div>
								<div class="form-group">
								   <label for="#goDate">出发日期</label>
								   <input type="email" class="form-control" id="godate" onclick="WdatePicker()">
								</div>
					   		</div>
				   			<div class="backBox">
				   				<div class="form-group">
						    		<label for="#targetCity">到达城市</label>
								    <input type="text" class="form-control" id="targetCity" >
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
