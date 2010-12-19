window.onload = setEmpty;
	
function setEmpty()
{
	var text = document.getElementById("dm_text");
	text.value = "";
}

function clickedSender(id)
{
	var div_id = "dm_"+id;
	var content = document.getElementById(div_id);
	var dm_list = content.childNodes;
	var recipient = document.getElementById('friends_name');
	var recip_arr = recipient.options;
	
	for(var i=0 ; i<recip_arr.length ; i++)
	{
		if(id == recip_arr[i].text)
		{
			recip_arr[i].selected = true;
			break;
		}
	}
	
//			var test = document.getElementById("div_a");
//			var test2 = document.getElementById("div_b");
//			test.innerHTML = "clickedSender()";
//			test2.innerHTML = "div_id:&nbsp;"+div_id;
	var index = 0;
	if( content.style.display == "none" )	//sender를 클릭하면 처음 5개를 보여준다.
	{
		content.style.display = "block";
		while( index< 5)  //dm_list.length 
		{
			dm_list[index].style.display = "block";
			index++;
		}
	}else		//목록이 출력된 상태에서 sender를 다시 클릭했을
	{			
		content.style.display = "none";
		
		while( index< 5 )  
		{
			dm_list[index].style.display = "none";
			index++;
		}
	}
}

function clickedPage(name, kind)
{
	var test = document.getElementById("div_a");
	var test2 = document.getElementById("div_b");
	
	var dm_id = "dm_"+name;
	var page_id = "page_"+name;
	var content = document.getElementById(dm_id);
	var page = Number( document.getElementById(page_id).innerHTML);
	var dm_list = content.childNodes;
	
	test.innerHTML ="clickedPage()";
	test2.innerHTML = "id:&nbsp;&nbsp;"+name+"&nbsp;&nbsp;page:&nbsp;&nbsp;"+page+"&nbsp;&nbsp;kind:&nbsp;"+kind;

	var index, last_index;
	
	if( kind!=1 && page==1 )
		alert("이전페이지가 없음!");
	else
	{
		test2.innerHTML = "이전페이지가 있음! 이제 보여줬던거 다 지울거임!";
		index = 5*(page-1);
		last_index = dm_list.length-2;		//index는 length보다 1 작으며, dm_list는 맨 마지막에 페이지를 넘기는 div까지 포함된다.
		if(5*(page-1)+4 < last_index )		
			last_index = 5*(page-1)+4;
		
		while(index<=last_index)		//현재 보여준 리스트 안보이게 함 
		{
			test2.innerHTML += "<br/>"+index;
			if(dm_list[index].style.display == "block" )
				dm_list[index].style.display = "none";
			index++;
		}
		test2.innerHTML += "<br/>다 지웠음!!";
		if( kind == 1 )		//다음 페이지 출력 
		{
			test2.innerHTML += "<br/>Next페이지 출력";
			index = 5*page;
			last_index = dm_list.length-2;
			
			if( 5*page+4 < last_index)
				last_index = 5*page+4;
			
			while( index<= last_index )  
			{
				dm_list[index].style.display = "block";
				index++;
			}
			page+=1;
			document.getElementById(page_id).innerHTML = page;
			
		}else
		{
			test2.innerHTML += "<br/>Pre페이지 출력";
			
			index = 5*(page-2);
			last_index = dm_list.length-2;
			
			if( 5*(page-2)+4 < last_index)
				last_index = 5*(page-2)+4;
			
			while( index<= last_index )  
			{
				dm_list[index].style.display = "block";
				index++;
			}
			
			page -= 1;
			document.getElementById(page_id).innerHTML = page;
		}
	}
	
	
	
}

function clickedDelete(id)
{
	var form = document.getElementById('info_form');
	form.innerHTML = "<input type=\"hidden\" name=\"hidden_num\" value = \""+id+"\">";
	form.submit();
}

function CountNum()
{
	var text = document.getElementById('dm_text');
	var output = document.getElementById('text_length');
	var div_button = document.getElementById('button_area');
	var text_length = text.value.length;
	
	output.innerHTML = 140-text_length;
	
	if( text_length>140 )
	{
		div_button.innerHTML = "<span id=\"button_enable\">send</span>";
	}else
	{
		div_button.innerHTML ="<span id=\"send_button\"><a href=\"#\" onclick=\"sendMessage()\">send</a></span>";
	}
}

function sendMessage()
{
	var form = document.getElementById('send_form');
	form.submit();
}