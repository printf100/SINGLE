<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- START :: include header -->
<%@include file="/views/form/header.jsp" %>
<!-- END :: include header -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SINGLE</title>

<!-- START :: CSS -->
<style type="text/css">
	
	.main {
		text-align: center;
		height: 100vh;
	}
	
	.main-profile-img {
		position: relative;
		width: 15rem;
		height: 15rem;
		border-radius: 0.25rem;
		overflow: hidden;
		margin: 0 auto;
	}
	
	#img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e279f4719a19c18fde6278302eaeb6d8&libraries=services"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	
	var scrollEvent = false;
	var count = 0;
	
	$("html, body").on('mousewheel', function(c) {
		
		var m = c.originalEvent.wheelDelta;
		var sb = $(".main").height();
		
		if(m>1 && scrollEvent == false && count >= 1) {
			console.log(count);
			scrollEvent = true;
			count--;
			
			$("html,body").stop().animate({scrollTop: sb*count},
					{duration: 600, complete: function() {
						scrollEvent = false;}
					});
			
		} else if (m<1 && scrollEvent == false && count < 3) {
			console.log(count);
			scrollEvent = true;
			count++;
			
			$("html,body").stop().animate({scrollTop: sb*count},
					{duration: 600, complete: function() {
						scrollEvent = false;}
					});
		}
		
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container-fluid">
		<div class="main">
			<div class="main-profile-img">
				<img id="img" alt="프로필 사진" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
			</div>
			<div>
				<h2>${profile.MEMBER_NICKNAME }</h2>
			</div>
			<div>
				<h3>${profile.MPROFILE_INTRODUCE }</h3>
			</div>
				
			<!-- 카카오 맵 -->
			<div id="map" style="width: 300px; height: 300px; margin: auto"></div>
				
		</div>
		
		<div class="main">
			<ul>
				<li><a href="#">MENU</a></li>
			</ul>
		</div>
		
		<div class="main">
			<!-- START :: include footer -->
			<%@include file="/views/form/footer.jsp" %>
			<!-- END :: include footer -->
		</div>
		
		<input type="hidden" id="MPROFILE_LATITUDE" name="MPROFILE_LATITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>37.499017</c:if>${profile.MPROFILE_LATITUDE }">
		<input type="hidden" id="MPROFILE_LONGITUDE" name="MPROFILE_LONGITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>127.032907</c:if>${profile.MPROFILE_LONGITUDE }">
	</div>
	
</body>

<!-- START :: 카카오 맵 -->
<script type="text/javascript">

	var mapContainer = document.getElementById('map');
	var mapOption = {
		center: new kakao.maps.LatLng($("#MPROFILE_LATITUDE").val(), $("#MPROFILE_LONGITUDE").val()),
		draggable: false,
		level: 4
	};
	
	// 지도 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 마커 설정
	var imageSrc = '../resources/images/marker/marker_myLocation.png',
    	imageSize = new kakao.maps.Size(55, 55), // 마커 크기
    	imageOption = {offset: new kakao.maps.Point(27, 69)};
	
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    	markerPosition = new kakao.maps.LatLng($("#MPROFILE_LATITUDE").val(), $("#MPROFILE_LONGITUDE").val());

	var marker = new kakao.maps.Marker({
	    position: markerPosition,
	    image: markerImage
	});
	
	// 지도에 마커 표시
	marker.setMap(map);
	
</script>
<!-- END :: 카카오 맵 -->

</html>