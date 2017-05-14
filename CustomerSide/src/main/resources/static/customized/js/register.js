$(function(){
    //	通过服从协议判断是否禁用下一步按钮
    $('#agree').on('click',function(){
        var isChecked = $(this).is(':checked');
        if(isChecked){
            $('#next').removeAttr("disabled");
        }else{
            $('#next').attr('disabled','disabled');
        }
    })
})

//表单总验证
function checkForm(){
    var rgname =$('#rgname').val();//用户名
    var realuser =$('#rguser').val();//真实姓名
    var idcard =$("#idcard").val();//身份证
    var rgphone =$("#rgphone").val();//手机号
    var rgemail =$("#rgemail").val();//邮箱地址
    var answer =$("#answer").val();//密保答案
    var rgpassword =$("#rgpassword").val();//密码
    var cfpassword =$("#cfpassword").val();//确认密码


    if (rgname=="null"||rgname=="") {
        window.wxc.xcConfirm("用户名不能为空","error");
        return false;
    }else if(checkName(rgname)==false){
        window.wxc.xcConfirm("用户名格式不正确，只能以字母开头，6到12位字母和数字组成","error");
        return false;
    }else if(realuser==null||realuser==""){
        window.wxc.xcConfirm("真实姓名不能为空","error");
        return false;
    }else if(checkRealName(realuser)==false){
        window.wxc.xcConfirm("真实姓名格式不正确，只能由2到4个汉字组成","error");
        return false;
    }else if(idcard==null||idcard==""){
        window.wxc.xcConfirm("身份证号不能为空","error");
        return false;
    }else if(checkIdcard(idcard)==false){
        window.wxc.xcConfirm("身份证号格式不正确，只能输入15位或者18位数字","error");
        return false;
    }else if(rgphone==null||rgphone==""){
        window.wxc.xcConfirm("手机号码不能为空","error");
        return false;
    }else if(checkPhone(rgphone)==false){
        window.wxc.xcConfirm("手机号格式不正确，请输入正确的手机号","error");
        return false;
    }else if(rgemail==null||rgemail==""){
        window.wxc.xcConfirm("电子邮箱不能为空","error");
        return false;
    }else if(checkEmail(rgemail)==false){
        window.wxc.xcConfirm("电子邮箱格式不正确，请输入正确的邮箱地址","error");
        return false;
    }else if(answer==null||answer==""){
        window.wxc.xcConfirm("密保答案不能为空","error");
        return false;
    }else if(checkAnswer(answer)==false){
        window.wxc.xcConfirm("密保答案格式错误，只能由3汉字组成","error");
        return false;
    }else if(rgpassword==null||rgpassword==""){
        window.wxc.xcConfirm("密码不能为空","error");
        return false;
    }else if(checkPassword(rgpassword)==false){
        window.wxc.xcConfirm("密码格式不正确，只能由数字和26位小写字母组成","error");
        return false;
    }else if(rgpassword!=cfpassword){
        window.wxc.xcConfirm("两次密码不相同，请重新输入","error");
        return false;
    }else{
        return true;
    }

}
//判断用户名
function checkName(str){
    var reg =/^[a-zA-Z][a-zA-Z0-9_]{5,11}$/;//只能由26个字母和数字组成
    return reg.test(str);
}
//判断真实姓名
function checkRealName(str){
    var reg =/^[\u4e00-\u9fa5]{2,4}$/;
    return reg.test(str);
}
//检验身份证号
function checkIdcard(str){
    var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
    return reg.test(str);
}
//检验手机号
function checkPhone(str){
    var reg = /^1\d{10}$/;
    return reg.test(str);
}
//检验邮箱地址
function checkEmail(str){
    var reg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
    return reg.test(str);
}
//检验密保，3个汉字
function checkAnswer(str){
    var reg=/[\u4e00-\u9fa5]{3}/;
    return reg.test(str);
}
//检验密码
function checkPassword(str){
    var reg = /^[a-z0-9]+$/;	//只能输入由数字和26个英文小写字母组成的字符串
    return reg.test(str);
}