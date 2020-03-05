<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.single.model.dto.map.FoodDto"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

 
<style>

.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; } .filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }


.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 750px;
}

#category {
	position: absolute;
	top: 10px;
	left: 10px;
	border-radius: 5px;
	border: 1px solid #909090;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
	background: #fff;
	overflow: hidden;
	z-index: 2;
}

#category li {
	float: left;
	list-style: none;
	width: 50px; px;
	border-right: 1px solid #acacac;
	padding: 6px 0;
	text-align: center;
	cursor: pointer;
}

#category li.on {
	background: #eee;
}

#category li:hover {
	background: #ffe6e6;
	border-left: 1px solid #acacac;
	margin-left: -1px;
}

#category li:last-child {
	margin-right: 0;
	border-right: 0;
}

#category li span {
	display: block;
	margin: 0 auto 3px;
	width: 27px;
	height: 28px;
}



#category li .bank {
	background-position: -10px 0;
}
 
#category li .mart { 
	background-position: -10px -36px;
}

#category li .pharmacy {
	background-position: -10px -72px;
}

#category li .oil {
	background-position: -10px -108px;
}

#category li .cafe {
	background-position: -10px -144px;
}

#category li .store { 
	background-position: -10px -180px;
}

#category li .cctv {
	background-position: -10px -180px;
}

#category li.on .category_bg {
	background-position-x: -46px;
}	

#category li.on .category_han {
	background-position-x: -46px;
}

.placeinfo_wrap {
	position: absolute;
	bottom: 28px;
	left: -150px;
	width: 300px;
} 

.placeinfo {
	position: relative;
	width: 100%;
	border-radius: 6px;
	border: 1px solid #ccc;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
	background: #fff;
}

.placeinfo:nth-of-type(n) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.placeinfo_wrap .after {
	content: '';
	position: relative;
	margin-left: -12px;
	left: 50%;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.placeinfo a, .placeinfo a:hover, .placeinfo a:active {
	color: #fff;
	text-decoration: none;
}

.placeinfo a, .placeinfo span {
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.placeinfo span {
	margin: 5px 5px 0 5px;
	cursor: default;
	font-size: 13px;
}

.placeinfo .title {
	font-weight: bold;
	font-size: 14px;
	border-radius: 6px 6px 0 0;
	margin: -1px -1px 0 -1px;
	padding: 10px;
	color: #fff;
	background: #d95050;
	background: #d95050
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png)
		no-repeat right 14px center;
}

.placeinfo .tel {
	color: #0f7833;
}

.placeinfo .jibun {
	color: #999;
	font-size: 11px;
	margin-top: 0;
}

#select{
	margin-top:500px;
}
.navicon {
        height: 25px;
        width: 50px;
        transition: transform 0.5s;
        z-index: 10000;
        position: fixed;
        cursor: pointer;
        top: 3%;
        left:93%;
        background-color: #106190;
        padding: 10px; 
        border-radius: 5px;
    }
    
    .line1 {
        height: 5px;
        width: 50px;
        background: white;
        margin-bottom: 10%;
        transition: transform 0.5s;
    }
    .line2 {
        height: 5px;
        width: 50px;
        background: white;
        box-shadow: 0px 10px 0px white;
        transition: transform 0.5s;
    }  
    .slidemenu {
        top: 0px;
        position: fixed;
        height: 100%;
        width: 20%;
        background-color: #106190;
        right: -25%;
        z-index : 10000;
    }
    .slidemenuinner {
        position: relative;
        top: 20%;
        height: 100%;
        width: 100%;
        color: #fff;
        font-size: 14px;
    }
    .menulink {
        height: 10%;
        border-top:1px solid #0d3c74;
        border-bottom:1px solid #0d3c74;
        padding: 10px 0px 10px 0px;
        margin-left:10px;
    }
    .menulink:hover{
        background: #217fb5;
    }
    .menulink a {
        color: white;
        text-decoration: none;
    }
    
    /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 30%; /* Could be more or less, depending on screen size */                          
        }


</style>
<meta charset="utf-8" />
<title>Kakao 지도 시작하기</title>
</head>
<body>
<div id="clickLatlng"></div>
	<%
		List<FoodDto> foodList = (List<FoodDto>) request.getAttribute("foodList");
	%>
	 
	<!-- CCTV , 성범죄자, 식재료 ,  -->
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
		<ul id="category">

			<li id="MT1" data-order="1"><span class="category_bg mart"></span>
				마트</li>
			<li id="AT4" data-order="5"><span class="category_bg store"></span>
				관광지</li>
			<li id="cctv" data-order="5"><span class="category_han store"></span>CCTV</li>
			<li id="food" data-order="5"><span class="category_han store"></span>식재료</li>
			<li id="sc" data-order="5"><span class="category_han store"></span>안심택배</li>
			<li id="behind" data-order="5"><span class="category_han store"></span>MAP</li>
		</ul> 
	</div>
	
	    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
                <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="font-size: 24pt;">식재료를 등록해주세요</span></b></span></p>
                <p style="text-align: center; line-height: 1.5;"><br/>	
         <form action="/SINGLE/food/foodUpload.do" method="POST" enctype="multipart/form-data" id="frm">
		<input type = "hidden" name="x" value=""/>
		<input type = "hidden" name="y" value=""/>
		<input type = "hidden" name="member_code" value="${member_code }">
	<table>

    <tbody>
            <tr>
                <th>식재료이름&nbsp;&nbsp;&nbsp;&nbsp;</th>
                <td><input type="text" placeholder="제목을 입력하세요. " name="food_name" class="form-control"/></td>
            </tr>
            <tr>
                <th>식재료내용  </th>
                <td><textarea cols="10" placeholder="내용을 입력하세요. " name="food_content" class="form-control"></textarea></td>
            </tr> 
            <tr>
                <th>식재료사진 </th>
                <td></td>
            </tr>
    </tbody>
</table>



  <div class="wrapper">      
      <h2 class="form-signin-heading">Please login</h2>
      <input type="text" class="form-control" name="username" placeholder="Email Address" required="" autofocus="" />
      <input type="password" class="form-control" name="password" placeholder="Password" required=""/>      
      <button class="btn btn-lg btn-primary btn-block" type="submit">등록</button>   
  </div>
  <div class="input-group">

  <div class="custom-file">
    <input type="file" class="custom-file-input" id="inputGroupFile01"
      aria-describedby="inputGroupFileAddon01">
    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
  </div>
</div>

  <div class="input-group-prepend">
    <span class="input-group-text" id="inputGroupFileAddon01">업로드</span>
  </div>
            </form>
      </div>
 
    </div>
    


	



<div id="select"><a href="/SINGLE/food/MyFoodList.do">내가 등록한 식재료 보러가기</a></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be4fb953e79914c6f6b09a0e189164da&libraries=services"></script>
	<script>

	
	window.onload = function(){ 
		document.getElementByClassName('pop_bt').onclick = function(){ 
			document.getElementById('frm').submit(); 
				return false;
			}; 
		};



	
	
	
	$('#cctv').click(function(){
		location.href="/SINGLE/map/cctv.do";
	});
	
		var c1 = null;
	
		// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
		var placeOverlay = new kakao.maps.CustomOverlay({
			zIndex : 1
		}), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		markers = [], // 마커를 담을 배열입니다
		currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
	
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);
		 
		// 장소 검색 객체를 생성합니다
		var ps = new kakao.maps.services.Places(map);
		
		// 지도에 idle 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', searchPlaces);
		
		// 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
		contentNode.className = 'placeinfo_wrap';

		// 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
		// 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
		addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
		addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
		
		// 커스텀 오버레이 컨텐츠를 설정합니다
		placeOverlay.setContent(contentNode);

		// 각 카테고리에 클릭 이벤트를 등록합니다 
		addCategoryClickEvent();

		// 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다 
		function addEventHandle(target, type, callback) {
			if (target.addEventListener) {
				target.addEventListener(type, callback);
			} else {
				target.attachEvent('on' + type, callback);
			}
		}

		// 카테고리 검색을 요청하는 함수입니다
		function searchPlaces() {
			if (!currCategory) {
				return;
			}

			// 커스텀 오버레이를 숨깁니다 
			placeOverlay.setMap(null);

			// 지도에 표시되고 있는 마커를 제거합니다
			removeMarker();
 
			ps.categorySearch(currCategory, placesSearchCB, {
				useMapBounds : true
			});
		} 

		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
			if (status === kakao.maps.services.Status.OK) {

				// 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
				displayPlaces(data);
			} else if (status === kakao.maps.services.Status.ZERO_RESULT) {
				// 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

			} else if (status === kakao.maps.services.Status.ERROR) {
				// 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

			}
		}

		// 지도에 마커를 표출하는 함수입니다 
		function displayPlaces(places) {

			// 몇번째 카테고리가 선택되어 있는지 얻어옵니다
			// 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
			var order = document.getElementById(currCategory).getAttribute('data-order');

			for (var i = 0; i < places.length; i++) {

				// 마커를 생성하고 지도에 표시합니다
				var marker = addMarker(new kakao.maps.LatLng(places[i].y,
						places[i].x), order);
				
				// 마커와 검색결과 항목을 클릭 했을 때
				// 장소정보를 표출하도록 클릭 이벤트를 등록합니다
				(function(marker, place) {
					kakao.maps.event.addListener(marker, 'click', function() {
						displayPlaceInfo(place);
					});
				})(marker, places[i]);
			}
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, order) { 
			var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(27, 28), // 마커 이미지의 크기
			imgOptions = {
				spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
				spriteOrigin : new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset : new kakao.maps.Point(11, 28)
			
			
			// 마커 좌표에 일치시킬 이미지 내에서의 좌표 
			}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imgOptions), marker = new kakao.maps.Marker({
				position : position, // 마커의 위치
				image : markerImage 
			});

			marker.setMap(map); // 지도 위에 마커를 표출합니다
			markers.push(marker); // 배열에 생성된 마커를 추가합니다

			return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
		}

		// 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
		function displayPlaceInfo(place) {
			var content = '<div class="placeinfo">'
					+ '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
					+ place.place_name + '</a>';

			if (place.road_address_name) {
				content += '    <span title="' + place.road_address_name + '">'
						+ place.road_address_name
						+ '</span>'
						+ '  <span class="jibun" title="' + place.address_name + '">(지번 : '
						+ place.address_name + ')</span>';
			} else {
				content += '    <span title="' + place.address_name + '">'
						+ place.address_name + '</span>';
			}

			content += '    <span class="tel">' + place.phone + '</span>'
					+ '</div>' + '<div class="after"></div>';

			contentNode.innerHTML = content;
			placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
			placeOverlay.setMap(map);
		}

		// 각 카테고리에 클릭 이벤트를 등록합니다
		function addCategoryClickEvent() {
			var category = document.getElementById('category'), children = category.children;

			for (var i = 0; i < children.length; i++) {
				children[i].onclick = onClickCategory;
			}
		}

		// 카테고리를 클릭했을 때 호출되는 함수입니다
		function onClickCategory() {
			var id = this.id, className = this.className;

			placeOverlay.setMap(null);

			if (className === 'on') {
				currCategory = '';
				changeCategoryClass();
				removeMarker();
			} else {
				currCategory = id;
				changeCategoryClass(this);
				searchPlaces();
			}
		}

		// 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
		function changeCategoryClass(el) {  
			var category = document.getElementById('category'), children = category.children, i;

			for (i = 0; i < children.length; i++) {
				children[i].className = '';
			}
			
			if (el) {
				el.className = 'on'; 
			}
		}
		
		
		
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var marker = new kakao.maps.Marker({
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		

		
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng;
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    
		    x = latlng.getLat();
		    y = latlng.getLng();
			
		    document.getElementsByName("x")[0].value = x;
		    document.getElementsByName("y")[0].value = y;
		     
		});

		
	
		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다 
		var iwContent2 = '<div id="modal" style="padding:5px;">식재료 등록하러 가기</div>',
		    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다 
				
		var infowindows = new kakao.maps.InfoWindow({ 
		    content : iwContent2,
		    removable : iwRemoveable
			});
		    
		kakao.maps.event.addListener(marker, 'click', function() { 
		      // 마커 위에 인포윈도우를 표시합니다
		      infowindows.open(map, marker);  
		}); 
	    
	    $(document).on('click', '#modal', function() {
	    	$('#myModal').show(); 
	    });
	
	    <%
	    for (int i = 0; i < foodList.size(); i++) {
	    %>  
		
	    
        var imageSrc = '/SINGLE/resources/uploadImg/<%=foodList.get(i).getFood_image_name()%>', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(50, 50), // 마커이미지의 크기입니다
        imageOption = {offset: new kakao.maps.Point(10, 10)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption), 
        markerPosition = new kakao.maps.LatLng(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>);
        
        var markerPosition  = new kakao.maps.LatLng(<%=foodList.get(i).getFood_x()%>, <%=foodList.get(i).getFood_y()%>); 
        
        markers = new kakao.maps.Marker({ 
            position: markerPosition,
            image : markerImage,
            clickable: true
        });

    
        markers.setMap(map);

        iwContent = '<div style="padding:5px;">'+'<a href=""><%=foodList.get(i).getMember_name()%></a>'+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
         
        var infowindow = new kakao.maps.InfoWindow({
            content : iwContent,
            removable : iwRemoveable
            
        });


        
        kakao.maps.event.addListener(markers, 'click', makeClickListener(map, markers, infowindow));
	
        
        function makeClickListener(map, markers, infowindow) {
        	return function() {
        	infowindow.open(map, markers);
        	};
        	
        	
        	}
        <% 
    	}
    	%>
    	

    	


	    // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	    function makeOutListener(infowindow) {
	        return function() {
	            infowindow.close();
	        };
	    } 
	    
		$('#cctv').click(function(){
			location.href="/SINGLE/map/cctv.do?my_address="+my_address;
		}); 
		
		$('#behind').click(function(){
			location.href="/SINGLE/map/map.do";
		}); 
		
		$('#food').click(function(){
			location.href="/SINGLE/food/foodList.do"; 
		}); 
		$('#sc').click(function(){
			location.href="/SINGLE/map/sc.do";
		});
		
		



		//팝업 Close 기능
		function close_pop(flag) {
			$('#myModal').hide();
		};

	</script>




</body>
</html>