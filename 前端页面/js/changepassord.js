function checkForm(){
	var oldpsw=$('#oldpsw').val();
	var newpsw=$("#newpsw").val();
	var cfpsw=$("#cfpsw").val();
	
	if (oldpsw==null||oldpsw=="") {
		window.wxc.xcConfirm("密码不能为空","error");
		return false;
	}else if(checkPassword(oldpsw)==false){
		window.wxc.xcConfirm("密码只能由26位小写字母和数字组成","error");
		return false;
	}else if(newpsw==null||newpsw==""){
		window.wxc.xcConfirm("新密码不能为空","error");
		return false;
	}else if(checkPassword(newpsw)==false){
		window.wxc.xcConfirm("新密码只能由26位小写字母和数字组成","error");
		return false;
	}else if(newpsw!=cfpsw){
		window.wxc.xcConfirm("两次密码不相同，请重新输入","error");
		return false;
	}else{
		return true;
	}
}

//检验密码
		function checkPassword(str){
			var reg = /^[a-z0-9]+$/;	//只能输入由数字和26个英文小写字母组成的字符串
	        return reg.test(str);
		}	