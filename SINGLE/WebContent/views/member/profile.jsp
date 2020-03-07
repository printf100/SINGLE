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
	
	.col-sm-3 {
		margin: 20px;
	}
	
	.list-group a {
		color: #263747;
	}
	
	.card-body {
		padding: 40px;
		padding-top: 20px;
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
	
	label.required::before {
		content: '*';
	    display: inline-block;
	    vertical-align: top;
	    font-weight: 700;
	    -webkit-font-smoothing: antialiased;
	    color: #F44336;
	    margin: 0 0.125rem 0 0;
	    font-size: 1.25rem;
	    line-height: 1.25rem;
	}
	
	.submit-btn {
		margin-top: 20px;
	}
	
	#map {
		width: 100%;
		height: 300px;
	}
	
	.customoverlay {
		position: relative;
		bottom: 102px;
		border-radius: 6px;
		border: 1px solid #ccc;
		border-bottom: 2px solid #ddd;
		float: left;
	}
	
	.customoverlay:nth-of-type(n) {
		border: 0;
		box-shadow: 0px 1px 2px #888;
	}
	
	.customoverlay div {
		cursor: pointer;
		display: block;
		text-decoration: none;
		color: #000;
		text-align: center;
		border-radius: 6px;
		font-size: 14px;
		font-weight: bold;
		overflow: hidden;
		background: #46b8da;
		background: #46b8da url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
	}
	
	.customoverlay .title {
		display: block;
		text-align: center;
		background: #fff;
		margin-right: 35px;
		padding: 10px 15px;
		font-size: 14px;
		font-weight: bold;
	}
	
	.customoverlay:after {
		content: '';
		position: absolute;
		margin-left: -12px;
		left: 50%;
		bottom: -12px;
		width: 22px;
		height: 12px;
		background: url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
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
		
		// 파일 체인지 시 동작
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
						alert("프로필 이미지 수정이 완료되었어요!" + msg.img);
						$("#img").attr("src", "../resources/images/profileimg/" + msg.img);
					} else {
						alert("프로필 이미지 수정을 실패하였습니다.");
					}
				},
				error: function() {
					alert("프로필 이미지 수정 통신 실패");
				}
			});
		});
		
		// 닉네임 체크
		$("#MEMBER_NICKNAME").keyup(function() {
			
			if($("#MEMBER_NICKNAME").val() != null && $("#MEMBER_NICKNAME").val() != "") {			
				// 닉네임 중복 체크
				$.ajax({
					type: "POST",
					url: "/SINGLE/member/nickCheck.do",
					data: { MEMBER_NICKNAME : $("#MEMBER_NICKNAME").val() },
					dataType: "JSON",
					success: function(msg) {
						
						if(msg.result > 0) {
							$("#nick_check").text("이미 사용중인 닉네임입니다.");
							$("#nick_check").attr("style", "color:red");
							
							$("#SUBMIT").attr("disabled", "disabled");
						} else {
							$("#nick_check").text("사용 가능한 닉네임입니다.");
							$("#nick_check").attr("style", "color:blue");
							
							$("#SUBMIT").removeAttr("disabled");
						}
					},
					error: function() {
						alert("닉네임 중복 체크 통신 실패");
					}
				});
			} else {
				$("#nick_check").text("필수 정보입니다.");
				$("#nick_check").attr("style", "color:red");
			}
		});
		
		// 변경 사항 저장
		$("#SUBMIT").click(function() {
			
			$.ajax({
				type: "POST",
				url: "/SINGLE/member/profileUpdate.do",
				data: {
					MEMBER_CODE : $("input[name='MEMBER_CODE']").val(),
					MEMBER_NICKNAME : $("#MEMBER_NICKNAME").val(),
					MPROFILE_INTRODUCE : $("#MPROFILE_INTRODUCE").val()
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("프로필 수정이 완료되었어요!");
					} else {
						alert("프로필 수정을 실패하였습니다.");
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

	<div class="container">
		<div class="row">
			
			<!-- 왼쪽 메뉴 바 -->
			<div id="side-menu" class="col-sm-3">
				<ul class="list-group">
					<li class="list-group-item list-group-item-action">
						<a class="nav-link active" href="/SINGLE/member/profilepage.do">프로필 정보</a>
			        </li>
			        <li class="list-group-item list-group-item-action">
			        	<a class="nav-link" href="/SINGLE/member/infopage.do">회원 정보</a>
			        </li>
			        <!-- 사이트로 가입한 회원일 때만 보여주기 -->
					<c:if test="${not empty sessionLoginMember }">
			        <li class="list-group-item list-group-item-action">
			        	<a class="nav-link" href="/SINGLE/member/pwpage.do">비밀번호</a>
			        </li>
			        </c:if>
			     </ul>
			</div>
			
			<!-- 콘텐츠 -->
			<div id="mypage-detail" class="col-sm-8">
				<p style="font-size: 25pt;"><strong>프로필</strong>
					
				<div class="card">
					<div class="card-body">
						<!-- ajax로 처리 -->
						<form id="imgForm" action="/SINGLE/member/profileImgUpdate.do" method="post" enctype="multipart/form-data">
							<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
							
							<div class="form-group">
								<label for="MPROFILE_IMG_NAME">프로필 이미지</label> <span style="color: #98A8B9; font-size:9pt;">(Optional)</span>
								<div id="PROFILE_BOX">
									<img id="img" alt="프로필 사진" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
									<input type="file" class="form-control" id="MPROFILE_IMG_NAME" name="MPROFILE_IMG_NAME" style="display: none;">
								</div>
							</div>
						</form>
					
						<form>
							<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
				
							<div class="form-group">
								<label class="required" for="MEMBER_NICKNAME">닉네임</label>
								<input type="text" class="form-control" id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" value="${profile.MEMBER_NICKNAME }" required="required">
								<div class="check_font" id="nick_check"></div><!-- 경고문이 들어갈 공간 -->
							</div>
							
							<div class="form-group">
								<label for="MPROFILE_INTRODUCE">상태메세지</label> <span style="color: #98A8B9; font-size:9pt;">(Optional)</span>
								<input type="text" class="form-control" id="MPROFILE_INTRODUCE" name="MPROFILE_INTRODUCE" value="${profile.MPROFILE_INTRODUCE }">
							</div>
							
							<div class="submit-btn form-group">
								<input type="button" id="SUBMIT" class="btn btn-info btn-sm" value="변경사항 저장">
							</div>	
						</form>
						
						<hr>
						
						<div class="form-group">
							<label class="required">내 위치 설정하기</label>
							<em style="color:gray; font-size:9pt;">검색 후 지도를 클릭하거나 마커를 이동해주세요!</em>
						</div>
						
						<!-- 주소 검색 -->
						<div class="form-group">
							<div class="input-group input-group-sm">
								<input type="text" class="form-control" id="myLocation">
								<div class="input-group-append">
									<button type="button" class="btn btn-info" onclick="searchLocation();">주소로 검색하기</button>
								</div>
							</div>
						</div>
						<!-- 카카오 맵 -->
						<div id="map"></div>
							
						<form id="locationForm" action="/SINGLE/member/profileLocUpdate.do" method="post">
							<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
							<input type="hidden" id="MPROFILE_LATITUDE" name="MPROFILE_LATITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>37.499017</c:if>${profile.MPROFILE_LATITUDE }">
							<input type="hidden" id="MPROFILE_LONGITUDE" name="MPROFILE_LONGITUDE" value="<c:if test='${profile.MPROFILE_LATITUDE eq null}'>127.032907</c:if>${profile.MPROFILE_LONGITUDE }">
						</form>
					</div>
				</div>
			</div>
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
 	
 	$(function() {
 		
 		// 주소로 검색하기
 		$("#myLocation").keyup(function(e) {
 			e.preventDefault();
 			
 			var loc = $("#myLocation").val();
 			
 			var code = e.keyCode ? e.keyCode : e.which;
 			
 			if(code == 13) {	// 엔터키
 				searchLocation();
 				ps.keywordSearch(loc, placesSearchCB);
 			}
 		});
 	});
	
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
	
	var customOverlay = new kakao.maps.CustomOverlay({
		clickable: true
	});
	
	// 지도 클릭이벤트
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng;
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	 	// 커스텀 오버레이 생성
		var iwContent = "<div class='customoverlay'>" +
									"<div onclick='saveLocation(" + latlng.getLat() + "," + latlng.getLng() + ")';>" +
										"<span class='title'>위치 저장하기</span>" +
									"</div>" +
								"</div>";
								
		var iwPosition = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());

		customOverlay.setContent(iwContent);
		customOverlay.setPosition(iwPosition);
		customOverlay.setMap(map);
		customOverlay.setZIndex(5);
	});
		
	// 마커 드래그 이벤트
	kakao.maps.event.addListener(marker, 'dragstart', function() {
	   	customOverlay.setMap(null);
	});
	    
	kakao.maps.event.addListener(marker, 'dragend', function() {
	  	var iwContent = "<div class='customoverlay'>" +
							"<div onclick='saveLocation(" + marker.getPosition().getLat() + "," + marker.getPosition().getLng() + ")';>" +
								"<span class='title'>위치 저장하기</span>" +
							"</div>" +
						"</div>";
							
	    customOverlay.setContent(iwContent);
		customOverlay.setPosition(marker.getPosition());
	    customOverlay.setMap(map);
	    customOverlay.setZIndex(5);
	});
	
/* 	// 마커 드래그 이벤트
	kakao.maps.event.addListener(marker, 'dragstart', function() {
    	customOverlay.setMap(null);
    });
    
    kakao.maps.event.addListener(marker, 'dragend', function(mouseEvent) {
    	
    	// 옮긴 위도, 경도 정보를 가져옵니다
	    var latlng = mouseEvent.latLng;
    	
    	// 커스텀 오버레이 생성
    	var iwContent = "<div class='customoverlay'>" +
    								"<div onclick='saveLocation(" + latlng.getLat() + "," + latlng.getLng() + ")';>" +
    									"<span class='title'>위치 저장하기</span>" +
    								"</div>" +
    							"</div>";
    	var iwPosition = new kakao.maps.LatLng(latlng.getLat(), latlng.getLng());
    	
    	customOverlay.setContent(iwContent);
		customOverlay.setPosition(iwPosition);
    	customOverlay.setMap(map);
    	customOverlay.setZIndex(5);
    }); */
	
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