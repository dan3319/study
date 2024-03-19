$('.id_put').focus(function(){
    $('.id_put').attr('placeholder', ' ID');
});


$('.id_put').blur(function(){
    $('.id_put').attr('placeholder', '');
});

$('.pw_put').focus(function(){
    $('.pw_put').attr('placeholder', ' PASSWORD');
});


$('.pw_put').blur(function(){
    $('.pw_put').attr('placeholder', '');
});




$(document).ready(function(){
	var key = getCookie("idChk"); //user1
	if(key!=""){
		$("#iputid").val(key); 
	}
	 
	if($("#iputid").val() != ""){ 
		$("#checkId").attr("checked", true); 
	}
	 
	$("#checkId").change(function(){ 
		if($("#checkId").is(":checked")){ 
			setCookie("idChk", $("#iputid").val(), 7); 
		}else{ 
			deleteCookie("idChk");
		}
	});
	 
	$("#iputid").keyup(function(){ 
		if($("#checkId").is(":checked")){
			setCookie("idChk", $("#iputid").val(), 7); 
		}
	});
});

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
	var expireDate = new Date();
	expireDate.setDate(expireDate.getDate() - 1);
	document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
	 
function getCookie(cookieName) {
	cookieName = cookieName + '=';
	var cookieData = document.cookie;
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1){
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1)end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);
}