<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<title>确定</title>
<#include "/include/resources.ftl">
</head>
<body>
	     <!--头部开始-->
		 <#include "/include/pagehead.ftl"/>
		<div class="container" style="margin-top: 50px;">
			<div class="well well-lg" style="height: 450px;">
				<p class="text-center"><img src="../../images/question.png" style="width: 128px;"/></p>
				<br />
				<p class="text-center">${confirm_text}</p>
				<br />
				<p class="text-center">
				<button type="button" class="btn btn-primary yes">确定</button>
				<button type="button" class="btn btn-danger no">取消</button>
				</p>
			</div>
			
		</div>				
	<!--脚注区域-->
		 <#include "/include/pagefoot.ftl"/>

	<script type="text/javascript" charset="utf-8">
        $(function(){
            $(".yes").on("click",function(){

                $.ajax({
                    type: 'POST',
                    url: "../../${confirm_url}" ,
                    data:{
                    },
                    success: function (data) {
                        if(data=="success"){
                            window.wxc.xcConfirm("操作成功","info");
                            setTimeout(function(){
                                window.history.back();
                            },3000)
                        }
                    },
                    error:function (data) {
                        window.wxc.xcConfirm("异常，请联系管理员。", "error");
                    }
                });



            })
            $(".no").on("click",function(){
                window.history.back();
            })
        })

	</script>
</body>
</html>