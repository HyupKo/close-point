var daum_key = '9ff735caefceafcda92cfb983847b997517e07ec';

var map;
var roadView;
var mark;
var now_x, now_y;

function select_pos() {
	obj.init();
	obj.pingSearch();
}


function insert_Daum_Map()
{/*
	var insert_html = "<div id=\"map\">" +
							"<div id=\"top_msg\">" +
							"<font size=3 color=\"red\">※주소를 \"동\"이름으로 검색하세요.</font>"+
							"</div><input type=\"text\"name=\"address\" id=\"address\">"+
							"<input type=\"button\" value=\"검색\" onclick=\"select_pos();\">"+
							"<div id=\"read\">"+ 
							"</div><div id=\"pp\"></div></div>";
	document.getElementById("content_map").innerHTML = insert_html;  */
}

function createHiddenValues()					// Tweet 할때? 혹은 불러올때? 언제 사용해야할 지 궁리중.
{
	var pos_x = document.getElementById("point_x").value;
	var pos_y = document.getElementById("point_y").value;	
	
	if(document.getElementById("pano_id").value != null)
	{
		
	}
	
	var div_value = document.getElementById("updateForm");
/*		
	var hidden = document.createElement("input");
	hidden.nodeName="POINT_X";
	hidden.nodeType="hidden";
//	hidden.nodeValue=;

*/
}

var obj = {
	init : function()
	{
		obj.q = document.getElementById("address");
		obj.r = document.getElementById("sub_msg");
	},
	//xml로 검색을 요청하는 함수
	getXML : function()
	{
		var xml_url = 'http://apis.daum.net/maps/addr2coord?apikey=' + daum_key + '&output=xml&q=';
		xml_url = xml_url + encodeURI(obj.q.value);

	},
	// 검색을 요청하는 함수 
 	pingSearch : function()
 	{
	    if (obj.q.value)
		{
			obj.s = document.createElement('script');
			obj.s.type ='text/javascript';
			obj.s.charset ='utf-8';
		    obj.s.src = 'http://apis.daum.net/maps/addr2coord?apikey=' + daum_key + '&output=json&callback=obj.pongSearch&q=' + encodeURI(obj.q.value);
			document.getElementsByTagName('head')[0].appendChild(obj.s);
	    }
 	},

	pungSearch : function(lon, lat)
 	{
	    if (1)
		{
			obj.s = document.createElement('script');
			obj.s.type ='text/javascript';
			obj.s.charset ='utf-8';		  
		    obj.s.src = 'http://apis.daum.net/maps/coord2addr?apikey=' + daum_key + '&longitude=' + lon + '&latitude=' + lat + '&format=simple&output=json&callback=obj.resultSearch';
			document.getElementsByTagName('head')[0].appendChild(obj.s);
	    }
 	},
 	
 	// 검색 결과를 뿌리는 함수 
	pongSearch : function(z)
	{
		obj.r.innerHTML = '';
		if(!z.channel || z.channel.item.length <= 0)
		{
			obj.r.innerHTML = "검색 결과가 없습니다.";
			return;
		}
		else
		{
			for (var i = 0; i < z.channel.item.length; i++)
			{
				var li = document.createElement('li');
				var a = document.createElement('a');
				a.href = "javascript:obj.show_map(" + z.channel.item[i].point_y + ", " + z.channel.item[i].point_x + ");";   //마커는 x, y값을 받는다.
				a.innerHTML = z.channel.item[i].title;
				li.appendChild(a);
				obj.r.appendChild(li);
			}
		}
	},
	
	show_map : function(lat, lng)
	{
		obj.r.innerHTML = "";
		var point = new DLatLng(lat, lng);
		map = new DMap("map");
		var mapTypeControl = new DMapTypeControl();
		map.addControl(mapTypeControl);
		map.setCenter(point, 5);
		map.setEnableContextMenu();
		map.addControl(new DZoomControl());
		
		roadView = new DRoadViewClient(point);
				
		DEvent.addListener(map, "click", function(e) {
			now_y = e.x;
			now_x = e.y;

			var point = new DLatLng(now_x, now_y);
			mark = new DMark(point);
			map.clearOverlay();
			map.addOverlay(mark);
			map.panTo(point, 2);
			document.getElementById("POINT_X").value = now_x;
			document.getElementById("POINT_Y").value = now_y;
			obj.my_position(now_x, now_y);
			
			roadView.getNearestRoadView(point, obj.set_roadview);
//			obj.addMark(e.x, e.y);
		});
	},
		
	my_position : function(posx, posy)
	{
		var iw = new DInfoWindow("위치", {width:100, height:40});
		var go_point = new DLatLng(posy, posx);
		var m = new DMark(go_point, {infowindow:iw, draggable:true});
		map.addOverlay(m);
		map.setCenter(go_point, 4);
	},
	
	set_roadview : function(z)
	{
		var addButton = document.getElementById("sub_msg");
		var p_id;
		var p_x;
		var p_y;
		var p_point;
		if(z.service)
		{
			p_id = z.id;
			p_x = z.photox;
			p_y = z.photoy;
//			p_point = new DPoint(p_x, p_y);
						
			var a = document.createElement("a");
			a.href = "javascript:obj.show_roadview("+p_id+","+ p_x + "," + p_y + ");";
			a.innerHTML = "<span id=\"map_able\">로드뷰</span>";
			if(addButton.hasChildNodes())
				addButton.removeChild(addButton.lastChild);
			
			addButton.appendChild(a);			
		}
		else
		{
			alert("이곳은 로드뷰를 활성화 할 수 없습니다.");
		}
	},
	
	show_roadview : function(p_id, p_x, p_y)
	{
		p_point = new DLatLng(p_y, p_x);
		roadView = new DRoadView("road", {point:p_point, width:620});
		
		var addButton = document.getElementById("sub_msg");
		var a = document.createElement("a");
		a.href = "javascript:obj.remove_road_map("+p_y+","+p_x+")";
		a.innerHTML = "<span id=\"map_able\">다음지도</span>";
		if(addButton.hasChildNodes())
			addButton.removeChild(addButton.lastChild);
		
		addButton.appendChild(a);
		
		document.getElementById("pano_id").value = roadView.getPanoId();
		document.getElementById("pan").value = roadView.getPan();
		document.getElementById("tilt").value = roadView.getTilt();
		
		if(roadView.isLoaded())
		{
			roadView.setPanoId(p_id);
			roadView.show();
		}
	},
	
	remove_road_map : function(p_y, p_x)
	{
		if(roadView.isLoaded())
			roadView.hide();
		
		var addButton = document.getElementById("sub_msg");
		addButton.removeChild(addButton.lastChild);
		obj.show_map(p_y, p_x);
	},

	// HTML태그 안 먹게 하는 함수
	escapeHtml : function(str) 
	{
		str = str.replace(/&amp;/g, "&");
		str = str.replace(/&lt;/g, "<");
		str = str.replace(/&gt;/g, ">");
		return str;
	},
	// HTML태그 삭제하는 함수
	stripHTMLtag : function(string) {
		var objStrip = new RegExp();
		objStrip = /[<][^>]*[>]/gi;
		return string.replace(objStrip, "");
	},
	// 특정 좌표에 마커 추가
	addMark : function(lat, lng)
	{
		var point = new DLatLng(lat, lng);
		var mark = new DMark(point);
		map.addOverlay(mark);
		map.panTo(point, 2);								// 이전 버전에서 지도를 움직이는 부분.
	}
};

