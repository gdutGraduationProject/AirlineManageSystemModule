$(function(){
	$("#author").popover({
		trigger : 'click',//鼠标以上时触发弹出提示框
        html:true,//开启html 为true的话，data-content里就能放html代码了
        content:'<img src="images/qrcode.jpg" height="90" width="90">'
	});







})

//设置命名空间
var CodeSTD = window.CodeSTD || {};

window.CodeSTD = CodeSTD;

/**
 * 创建Form表单
 * @author 王成委
 * @param config Object
 *  <p>url:form的Action，提交的后台地址</p>
 *  <p>method:使用POST还是GET提交表单</p>
 *  <p>params:参数 K-V</p>
 * @return Form
 */
CodeSTD.form = function(config){
    config = config || {};

    var url = config.url,
        method = config.method || 'GET',
        params = config.params || {};

    var form = document.createElement('form');
    form.action = url;
    form.method = method;
    form.target = "_self";

    for(var param in params){
        var value = params[param],
            input = document.createElement('input');

        input.type = 'hidden';
        input.name = param;
        input.value = value;

        form.appendChild(input);
    }

    return form;
}

function urlJump(leftTicketId,leftTicketClassId) {
    // $("#leftTicketId").val(leftTicketId);
    // $("#leftTicketClassId").val(leftTicketClassId);
    // var formVar = $("#hiddenFormForJump");
    // formVar.submit();

    var form = new CodeSTD.form({
        url:'../../buyticket/chooseleftticket',
        method:'POST',
        params:{
            leftTicketId:leftTicketId,
            leftTicketClassId:leftTicketClassId
        }
    })

    $(form).submit();

    form = null;

}
