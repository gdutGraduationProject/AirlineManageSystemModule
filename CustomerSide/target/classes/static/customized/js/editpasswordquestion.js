function checkForm(){
	var answer =$("#answer").val();	
	if (answer==null||answer=="") {
		window.wxc.xcConfirm("密保答案不能为空","error");
		return false;
	}else if(checkAnswer(answer)==false){
		window.wxc.xcConfirm("密保答案格式错误，只能输入3个汉字","error");
		return false;
	}else{
		return true;
	}
	
}
//检验密保，限制为3个汉字
function checkAnswer(str){
	// var reg=/[\u4e00-\u9fa5]{3}/;
	// return reg.test(str);
	return true;
}