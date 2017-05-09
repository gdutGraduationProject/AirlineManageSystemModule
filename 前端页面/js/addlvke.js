$(".user-info").each(function(i,e){
	$(e).css('left',i*68+'px')
})
$("label.btn").hover(function(){
	$(this).next().css('display','block');
},function(){
	$(this).next().css('display','none');
})