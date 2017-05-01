//	登录校验
	function checkForm(){
		var username = $('#username').val();
		var password = $('#loginPassword').val();
			if(username==null||username==""){
				window.wxc.xcConfirm("用户名不能为空","error");
				return false;
		    }else if(password==null||password==""){
		    	window.wxc.xcConfirm('密码不能为空','error');
		    	return false;
		    }else{
		    	return true;
		    }	       
	    }

