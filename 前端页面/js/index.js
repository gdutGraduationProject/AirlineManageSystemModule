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
function checkForm(){
		window.wxc.xcConfirm("成功","success");
		var username =$('#username').val();
		var password =$('#password').val();
		
		
		
//			if(checkEmail(user)){
//			$('#username').nextSibling('span').addClass('glyphicon-ok');
//			return true;
//			}else{
//			$('#username').nextSibling('span').addClass('glyphicon-remove');
//			return false;
		
//		if (checkEmail(username)==false) {
//			$('#username').nextSibling('span').addClass('glyphicon-remove');
//			return false;
//		}else if(checkPassword(password)==false){
//			$('password').nextSibling('span').addClass('glyphicon-remove');
//			return false;
//		}else {
//			$(".loginModal").submit();
//			return true;
//		}


	}
//	检验是否为空
	function checkNull(input){
        if(input !=''){
            return true;
        }else{
            return false
        }
    }

//	检验手机号
	function checkPhone(input){
		var regex = /^1\d{10}$/;
        /*match表示匹配函数*/
        if (input.match(regex)) {
            return true;
        } else {
            return false;
        }
    }
//	检验邮箱地址
	function checkEmail(input){
		var regex = /^\w+([\.\-]\w+)*\@\w+([\.\-]\w+)*\.\w+$/;
        /*match表示匹配函数*/
        if (input.match(regex)) {
            return true;
        } else {
            return false;
        }
	}
//	检验密码
	function checkPassword(){
		var regex = /^[A-Za-z0-9]+$/;
        /*match表示匹配函数*/
        if (input.match(regex)) {
            return true;
        } else {
            return false;
        }
	}
$(function(){
	

})


$(function(){
	//联系作者弹出框
	$("#author").popover({
		trigger : 'click',//鼠标以上时触发弹出提示框
        html:true,//开启html 为true的话，data-content里就能放html代码了
        content:'<img src="images/qrcode.jpg" height="90" width="90">'
	});
	
	//合作伙伴弹出框
	$("#friend").popover({
		trigger : 'click',//鼠标以上时触发弹出提示框
        html:true,//开启html 为true的话，data-content里就能放html代码了
        content:'<p>helloCG</p><P>Email:69676900@qq.com</p>'
	});
	
	
	$('#goCity').on('focus',function(){
	$('.citylist').css('display','block');
	});
	
	
})
