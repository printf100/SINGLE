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
<title>회원프로필</title>

<!-- START :: CSS -->
<style type="text/css">

	#container {
		height: 100%;
	}
	
	#side-menu {
		position: relative;
		float: left;
		border: 1px solid green;
	}
	
	#mypage-detail {
		position: relative;
		margin-left: 150px;
	}
	
	#PROFILE_BOX {
		width: 100px;
		height: 100px;
		border-radius: 30%;
		overflow: hidden;
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

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#img").click(function() {
			$('#MPROFILE_IMG_NAME').click();
		});
		
		// 파일 체인지 시
		$("#MPROFILE_IMG_NAME").change(function() {
			
			var imgForm = $("#imgForm")[0];
			var formData = new FormData(imgForm);
			
			$.ajax({
				type: "POST",
				enctype: "multipart/form-data",
				url: "/SINGLE/member/profileImgUpdate.do",
				contentType: false,
				processData: false,
				data: formData,
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("프로필 이미지가 수정 완료되었습니다." + msg.img);
						$("#img").attr("src", "../resources/images/profileimg/" + msg.img);
					} else {
						alert("프로필 이미지 수정에 실패하였습니다.");
					}
				},
				error: function() {
					alert("프로필 수정 통신 실패");
				}
			});
		});

	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<h1>회원프로필</h1>

	<div id="container">
		<div id="side-menu">
			<div>
				<a href="/SINGLE/member/profilepage.do">프로필 정보</a>
			</div>
			<div>
				<a href="/SINGLE/member/infopage.do">회원 정보</a>
			</div>
			<!-- 사이트로 가입한 회원일 때만 보여주기 -->
			<c:if test="${not empty sessionLoginMember }">
				<div>
					<a href="/SINGLE/member/pwpage.do">비밀번호</a>
				</div>
			</c:if>
		</div>
		
		<div id="mypage-detail">
			<!-- ajax로 처리 -->
			<form id="imgForm" action="/SINGLE/member/profileImgUpdate.do" method="post" enctype="multipart/form-data">
				<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
				
				<div>
					<label for="MPROFILE_IMG_NAME">프로필 이미지</label>
				</div>
				<div id="PROFILE_BOX">
					<img id="img" alt="프로필 사진" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
					<input type="file" id="MPROFILE_IMG_NAME" name="MPROFILE_IMG_NAME" style="display: none;">
				</div>
			</form>
		
			<form action="/SINGLE/member/profileUpdate.do" method="post">
				<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
	
				<div>
					<label for="MEMBER_NICKNAME">닉네임</label>
				</div>
				<div>
					<input type="text" id="MEMBER_NICKNAME"	 name="MEMBER_NICKNAME" value="${profile.MEMBER_NICKNAME }" required="required">
				</div>
				
				<div>
					<label for="MPROFILE_INTRODUCE">상태메세지</label>
				</div>
				<div>
					<input type="text" id="MPROFILE_INTRODUCE" name="MPROFILE_INTRODUCE" value="${profile.MPROFILE_INTRODUCE }">
				</div>
				
				<div>
					<input type="submit" value="변경사항 저장">
				</div>	
			</form>
			
			<div>
				<label for="">내 위치 설정하기</label>
			</div>
			<div>
				<em style="color:gray; font-size:8pt;">검색 후 지도를 클릭하거나 마커를 이동해주세요!</em>
			</div>
			
			<!-- 주소 검색 -->
			<div>
				<input type="text" id="myLocation">
				<button type="button" onclick="searchLocation();">주소로 검색하기</button>
			</div>
			<!-- 카카오 맵 -->
			<div id="map" style="width:500px; height:400px;"></div>
				
			<form id="locationForm" action="/SINGLE/member/profileLocUpdate.do" method="post">
				<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
				<input type="hidden" id="MPROFILE_LATITUDE" name="MPROFILE_LATITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>37.499017</c:if>${profile.MPROFILE_LATITUDE }">
				<input type="hidden" id="MPROFILE_LONGITUDE" name="MPROFILE_LONGITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>127.032907</c:if>${profile.MPROFILE_LONGITUDE }">
			</form>
		</div>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>

<!-- START :: 카카오 맵 -->
<script type="text/javascript">
	
	var mapContainer = document.getElementById('map');
	var mapOption = {
		center: new kakao.maps.LatLng($("#locationForm input[name='MPROFILE_LATITUDE']").val(), $("#locationForm input[name='MPROFILE_LONGITUDE']").val()),
		level: 4
	};
	
	// 지도 생성
	var map = new kakao.maps.Map(mapContainer, mapOption);
	
 	// 장소 검색 객체 생성
	var ps = new kakao.maps.services.Places();
	
	function searchLocation() {
		var loc = $("#myLocation").val();
		ps.keywordSearch(loc, placesSearchCB);
	}
	
	// 키워드 검색 완료 시 호출되는 콜백함수
	function placesSearchCB(data, status, pagination) {
		if(status === kakao.maps.services.Status.OK) {
			
			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기 위해 객체에 좌표 추가
			var bounds = new kakao.maps.LatLngBounds();
			
			for(var i=0; i<data.length; i++) {
				bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			}
			
			// 검색된 장소 위치를 기준으로 지도 범위 재설정
			map.setBounds(bounds);
		}
	}
	
	// 마커 설정
	var imageSrc = '../resources/images/marker/marker_myLocation.png',
		imageSize = new kakao.maps.Size(55, 55),
    	imageOption = {offset: new kakao.maps.Point(27, 69)};
    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    	markerPosition = new kakao.maps.LatLng($("#MPROFILE_LATITUDE").val(), $("#MPROFILE_LONGITUDE").val());

	var marker = new kakao.maps.Marker({
		 position: markerPosition,
		 image: markerImage
	});
	
	// 지도에 마커 표시
	marker.setMap(map);
	marker.setDraggable(true);
	
	var infowindow = new kakao.maps.InfoWindow();
	
	// 지도 클릭이벤트
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	 	//인포윈도우 생성
		var iwContent = "<em onclick='saveLocation(" + latlng.getLat() + "," + latlng.getLng() + ");'>위치 저장하기</em>";
		var iwPosition = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
		
		infowindow.setContent(iwContent);
		infowindow.setPosition(iwPosition);
		infowindow.open(map, marker);
	    
	    kakao.maps.event.addListener(marker, 'dragend', function() {
			infowindow.close();
	    	infowindow.open(map, marker);
	    });
	});
	
	function saveLocation(lat, lng) {
		
		var MPROFILE_LATITUDE = $("#locationForm input[name='MPROFILE_LATITUDE']").val(lat);
		var MPROFILE_LONGITUDE = $("#locationForm input[name='MPROFILE_LONGITUDE']").val(lng);
		
		$.ajax({
			type: "POST",
			url: "/SINGLE/member/profileLocUpdate.do",
			data: {
				MEMBER_CODE : $("#locationForm input[name='MEMBER_CODE']").val(),
				MPROFILE_LATITUDE : MPROFILE_LATITUDE.val(),
				MPROFILE_LONGITUDE : MPROFILE_LONGITUDE.val()
			},
			dataType: "JSON",
			success: function(msg) {
				
				if(msg.result > 0) {
					alert("내위치 설정이 완료되었습니다.");
				} else {
					alert("내위치 설정을 실패하였습니다.");
				}
			},
			error: function() {
				alert("내위치 설정 통신 실패");
			}
		});
	}
	
</script>
<!-- END :: 카카오 맵 -->

</html>