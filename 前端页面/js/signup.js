$(function(){

	$('#agree').on('click',function(){
		var isChecked = $('#agree').is(':checked');
		if(isChecked){
			$('#next').removeAttr("disabled");
		}else{
			$('#next').attr('disabled','disabled');
		}
	})
	
	
	
})
//表单总验证
    function checkForm(){
		window.wxc.xcConfirm("成功","success");
		var username =$('#username').val();
		var password =$('#password').val();

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