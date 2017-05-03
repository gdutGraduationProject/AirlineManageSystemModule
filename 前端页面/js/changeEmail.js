
//表单总验证
function checkForm(){
	var newemail=$("#newemail").val();
	var mypassword =$("#password").val();
	
	if (newemail==null||newemail=="") {
		window.wxc.xcConfirm("电子邮箱不能为空！！！","error");
		return false;
	}else if(checkEmail(newemail)==false){
		window.wxc.xcConfirm("电子邮箱格式错误！！！","error");
		return false;
	}else if(mypassword==null||mypassword==""){
		window.wxc.xcConfirm("密码不能为空！！！","error");
		return false;
	}else if(checkPassword(mypassword)==false){
		window.wxc.xcConfirm("密码格式不正确，只能由26个小写字母和数字组成","error");
	}else{
		return true;
	}
	
	
}
//检验密码
function checkPassword(str){
	var reg = /^[a-z0-9]+$/;	//只能输入由数字和26个英文小写字母组成的字符串
    return reg.test(str);
}	
//检验邮箱地址
		function checkEmail(str){		
	        var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
	    	return reg.test(str);
		}