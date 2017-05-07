$(function(){
	$("#author").popover({
		trigger : 'click',//鼠标以上时触发弹出提示框
        html:true,//开启html 为true的话，data-content里就能放html代码了
        content:'<img src="images/qrcode.jpg" height="90" width="90">'
	});
})
