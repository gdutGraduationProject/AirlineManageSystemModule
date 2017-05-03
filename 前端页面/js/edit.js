function checkForm(){
	var user=$("#newuser").val();
	var phone=$("#newphone").val();
	var idcard=$("#newidcard").val();
	
	if (user==null||user=="") {
		window.wxc.xcConfirm("用户名不能为空","error");
		return false;
	}else if(checkRealName(user)==false){
		window.wxc.xcConfirm("姓名格式错误，只能由2到4位汉字组成","error");
		return false;
	}else if(phone==null||phone==""){
		window.wxc.xcConfirm("手机号不能为空","error");
		return false;
	}else if(checkPhone(phone)==false){
		window.wxc.xcConfirm("手机号格式有误","error");
		return false;
	}else if(idcard==null||idcard==""){
		window.wxc.xcConfirm("身份证号不能为空","error");
		return false;
	}else if(checkIdcard(idcard)==false){
		window.wxc.xcConfirm("身份证号码只能由15到18位数字组成","error");
		return false;
	}else{
		return true;
	}
}
	//判断真实姓名
    	function checkRealName(str){
    		var reg =/^[\u4e00-\u9fa5]{2,4}$/;
    		return reg.test(str);
    	}
    //检验手机号
    	function checkPhone(str){
    		var reg = /^1[34578]\d{9}$/;
    		return reg.test(str);
    	}
    //检验身份证号
        function checkIdcard(str){
        	var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
        	return reg.test(str);
        }