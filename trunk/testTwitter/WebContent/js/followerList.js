function showFriends()
{
	var follower_content = document.getElementById('followers');
	var friend_content = document.getElementById('friends');
	
	friend_content.style.display = "block";
	if( follower_content.style.display =="block" )
		follower_content.style.display = "none";

	
/*
	if( friend_content.style.display == "none" )
	{
		friend_content.style.display = "block";
		if( follower_content.style.display =="block" )
		{
			follower_content.style.display = "none";
		}
	}else
	{
		friend_content.style.display = "none";
	}
*/
}

function showFollowers()
{
	var follower_content = document.getElementById('followers');
	var friend_content = document.getElementById('friends');
	
	follower_content.style.display = "block";
	if( friend_content.style.display =="block" )
		friend_content.style.display = "none";
	
/*	
	if( follower_content.style.display == "none" )
	{
		follower_content.style.display = "block";
		
		if( friend_content.style.display =="block" )
			friend_content.style.display = "none";
	}else
		follower_content.style.display = "none";		*/
}

function clickedPage(kind, page, value)
{	//clickedPage('followers','"+followers_page+"', 1)
	var test = document.getElementById("test");
	var form;
	var num_page = Number( page );
	test.innerHTML = "kind:&nbsp;"+kind+"&nbsp;page:&nbsp;"+page+"&nbsp;value="+value;
	if( value==1 )
	{
		num_page = num_page + value;
	}
	else
		num_page = num_page + value;
	
	if( kind == "friends")
	{
		form = document.getElementById("friend_form");
		form.innerHTML += "<input type=\"hidden\" name=\"friends_page\" value=\""+num_page+"\"/>";
	}
	else
	{
		form = document.getElementById("follower_form");
		form.innerHTML += "<input type=\"hidden\" name=\"followers_page\" value=\""+num_page+"\"/>";
	}
	form.submit();
}
