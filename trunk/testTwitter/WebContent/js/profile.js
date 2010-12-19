var now = {};
var doc_ele = document.documentElement;
var doc_body = document.body;
var getNowScroll= function(){
										now.X = document.all ? (!doc_ele.scrollLeft ? doc_body.scrollLeft : doc_ele.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
										now.Y = document.all ? (!doc_ele.scrollTop ? doc_body.scrollTop : doc_ele.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);
	
										return now;
									}
	
function goNextUser(next_page)
{
	var scroll = getNowScroll();
	var form_next = document.getElementById("form_user_next");
	var test = document.getElementById("test");
	test.innerHTML = "함수진입";
	form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_kind\" value=\"user\"/>";
	form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_page\" value=\""+next_page+"\"/>";
	form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollX\" value=\""+scroll.X+"\"/>";
	form_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollY\" value=\""+scroll.Y+"\"/>";
	form_next.submit();
}
		
function deleteStatus(id)
{
	var name = "form_"+id;
	var form = document.getElementById(name);
	form.innerHTML += "<input type=\"hidden\" name = \"hidden_delete\" value=\""+id+"\"/>";
	form.submit();
}