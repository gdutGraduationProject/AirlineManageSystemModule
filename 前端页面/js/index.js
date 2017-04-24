//$(function(){
//	//设置轮播控件垂直居中
//	$(".carousel-control").css("line-height",$(".carousel-inner img").height()+ "px");
//	$(window).resize(function(){
//		var $height = $(".carousel-inner img").eq(0).height()||
//		              $(".carousel-inner img").eq(1).height()||
//		              $(".carousel-inner img").eq(2).height();
//		$(".carousel-control").css("line-height",$height + "px");
//	})
//})
$(function(){
	$('#goCity').on('focus',function(){
	$('.citylist').css('display','block');
	}).on('blur',function(){
		$('.citylist').css('display','none');
	})
})
$(function(){
	$("#author").popover({
		trigger : 'click',//鼠标以上时触发弹出提示框
        html:true,//开启html 为true的话，data-content里就能放html代码了
        content:'<img src="images/qrcode.jpg" height="90" width="90">'
	});
})
