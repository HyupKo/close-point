
var doc_ele = document.documentElement;
var doc_body = document.body;

function CountNum()
{
	var text = document.getElementById('content_text');
	var output = document.getElementById('content_length');
	var div_button = document.getElementById('content_button');
	var text_length = text.value.length;
	
	output.innerHTML = 140-text_length;
	
	if( text_length>140 )
	{
		div_button.innerHTML = "<span  id=\"button_enable\">tweet</span>";
	}else
	{
		div_button.innerHTML = "<span  id=\"button_able\"><a href=\"#\" onclick=\"actionSubmit()\">tweet</a></span>";
	}
}

function actionSubmit()
{
//		var value = document.getElementById("content_text").value;
	// 함수
	
	document.updateForm.submit();
}	
var now = {};

var getNowScroll= function(){
								now.X = document.all ? (!doc_ele.scrollLeft ? doc_body.scrollLeft : doc_ele.scrollLeft) : (window.pageXOffset ? window.pageXOffset : window.scrollX);
								now.Y = document.all ? (!doc_ele.scrollTop ? doc_body.scrollTop : doc_ele.scrollTop) : (window.pageYOffset ? window.pageYOffset : window.scrollY);

								return now;
							}


function onClickDelete(id)	//changed
{
	var name = "form_"+id;
	var form = document.getElementById(name);
	form.innerHTML+="<input type=\"hidden\" name=\"hidden_delete\" value=\""+id+"\"/>";
	form.submit();
}

function onClickRetweet(id)
{
	var name = "form_"+id;
	var form = document.getElementById(name);
	form.innerHTML+="<input type=\"hidden\" name=\"hidden_retweet\" value=\""+id+"\"/>";
	form.submit();
}

function goNext(next_page)		//next homeTimeLine
{
	var scroll = getNowScroll();
//		var go_next = document.form_home_next;
	var go_next = document.getElementById("form_home_next");
	go_next.innerHTML += "<input type=\"hidden\" name=\"hidden_kind\" value=\"home\"/>";
	go_next.innerHTML += "<input type=\"hidden\" name=\"hidden_page\" value=\""+next_page+"\"/>";
	go_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollX\" value=\""+scroll.X+"\"/>";
	go_next.innerHTML += "<input type=\"hidden\" name=\"hidden_scrollY\" value=\""+scroll.Y+"\"/>";
	
	go_next.submit();
}	