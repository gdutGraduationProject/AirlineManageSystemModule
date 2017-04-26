$(function(){
	//联系作者弹出框
//	$("#author").popover({
//		trigger : 'click',//鼠标以上时触发弹出提示框
//      html:true,//开启html 为true的话，data-content里就能放html代码了
//      content:'<img src="images/qrcode.jpg" height="90" width="90">'
//	});
//	
//	//合作伙伴弹出框
//	$("#friend").popover({
//		trigger : 'click',//鼠标以上时触发弹出提示框
//      html:true,//开启html 为true的话，data-content里就能放html代码了
//      content:'<p>helloCG</p><P>Email:69676900@qq.com</p>'
//	});
	
//	判断协议是否勾选

	$('#agree').on('click',function(){
		var isChecked = $('#agree').is(':checked');
		if(isChecked){
			$('#next').removeAttr("disabled");
		}else{
			$('#next').attr('disabled','disabled');
		}
	})
	
	
	
})