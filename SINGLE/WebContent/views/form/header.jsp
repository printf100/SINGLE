<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="sessionLoginMember" value="${sessionScope.loginMember }"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao }"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver }"></c:set>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<!-- START :: 잘못된 접근을 막기 위함 -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver }">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 잘못된 접근을 막기 위함 -->

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">

	@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap');
	
	body {
		font-family: 'Noto Sans KR';
	}

	.navbar a {
		color: #000;
		font-weight: 700;
	}
	
	.navbar {
		position: relative;
		display: flex;
		padding: 0.375rem 1rem;
		height: 80px;
		border-bottom: 1px solid lightgray;
	}
	
	.navbar-collapse {
		flex-grow: 1;
		align-items: center;
	}
	
	.nav-link {
		padding: 0.25rem 1rem;
	}
	
	.member-info {
		display: flex;
		margin-bottom: 0.25rem;
		padding: 0.6875rem 1rem 1rem 1rem;
		border-bottom: 0.0625rem solid #E9ECF3;
		color: #263747;
	}
	
	.rounded {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	.profile-img {
		width: 2.5rem;
		height: 2.5rem;
		border-radius: 0.25rem;
	}
		
	.info-text {
		margin-left: 1rem;
		-webkit-font-smoothing: antialiased;
	}
	
	.title-text {
		font-weight: 700;
	}
	
	.dropdown-item {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0.125rem 0.875rem;
		color: #263747;
		font-weight: 500;
	}
	
</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">

	$(function() {
		
		$(".dropdown-member-list").css("display", "none");
		
		$(".dropdown-member").click(function() {
			$(".dropdown-member-list").toggle(100);
		});
		
		
		/*
		* 알림 (notification API)
		*/
		
		// 브라우저 지원 여부 체크
		if(!("Notification" in window)) {
			alert("데스크탑 알림을 제공하지 않는 브라우저입니다.");
		}
		
		// 데스크탑 알림 권한 요청
		Notification.requestPermission(function (result) {
			// 권한 거절
			if(result == "denied") {
				alert("알림을 차단하셨습니다.\n브라우저의 사이트 설정에서 변경하실 수 있습니다.");
				return false;
			}
		});
		
		
		/*
		* 웹 소켓
		*/
		
		var ws = new WebSocket("ws://localhost:8090/SINGLE/websocket_note");
		
		// 웹 소켓 연결이 해제됐을 때
		ws.onclose = function(e) {
			alert("웹소켓 연결 해제됨");
		};
		
		// 웹 소켓 에러
		ws.onerror = function(e) {
			alert("웹소켓 에러");
		};
		
		// 쪽지가 온 경우
		ws.onmessage = function(e) {
			notify(e.data);
		};
		
	});
	
	// 알림 띄우기
	function notify(msg) {
		var options = {
				body: "쪽지가 왔습니다.\n" + msg
		}
		
		var notification = new Notification("SINGLE", options);
		
		notification.onclick = function() {
			///////////////////////////////////////////////////링크맞아?
			window.open("/SINGLE/note/noteInList.do");
		}
		
		// 3초 뒤 알림 닫기
		setTimeout(function() {
			notification.close();
		}, 3000);
	}

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body style="font-family: 'Noto Sans KR';">

	<nav id="header" class="navbar navbar-expand-md fixed-top">
		<a class="navbar-brand" href="/SINGLE/main/mainpage.do">SINGLE</a>
		
		<c:choose>
			<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver }">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="collapsibleNavbar">
					<ul class="nav navbar-nav">
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/board/noticepage.do">NOTICE</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/map/map.do">MAP</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/life/lifeSelect.do">LIFE</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/board/resaleMainList.do">MARKET</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/festival/festivalpage.do">FESTIVAL</a>
						</li>
					</ul>
					
					<ul class="nav navbar-nav ml-auto">
						
						<!-- 채팅 -->
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/chat/chatpage.do">채팅</a>
						</li>
						
						<!-- 쪽지 -->
						<li class="nav-item">
							<a class="nav-link" href="/SINGLE/note/noteInList.do">쪽지</a>
						</li>
						
						<!-- 계정관련 드롭다운 메뉴 -->
						<li class="nav-item display-lg-up dropdown">
							<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">계정</a>
							<div class="dropdown-menu dropdown-menu-right">
								<div class="member-info">
									<div class="profile-img">
										<img class="rounded" alt="${profile.MEMBER_NICKNAME }" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
									</div>
									<div class="info-text">
										<h6 class="title-text">${profile.MEMBER_NICKNAME }</h6>
										<h6 class="title-text">${profile.MEMBER_EMAIL }</h6>
									</div>
								</div>
								<a class="dropdown-item" href="/SINGLE/member/profilepage.do">MYPAGE</a>
								<a class="dropdown-item" href="/SINGLE/member/logout.do">로그아웃</a>
							</div>
						</li>
					</ul>
				</div>
			
			</c:when>
			<c:otherwise>
				<span>
					<a href="/SINGLE/member/joinpage.do">회원가입</a>
					<a href="/SINGLE/member/loginpage.do">로그인</a>
				</span>
			</c:otherwise>
		</c:choose>
	</nav>

</body>
</html>