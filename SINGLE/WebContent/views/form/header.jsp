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
<title>Insert title here</title>

<!-- START :: 잘못된 접근을 막기 위함 -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver }">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 잘못된 접근을 막기 위함 -->

<!-- START :: CSS -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		
		#header {
			width: 100%;
			position: fixed;
			margin: 10px;
			z-index: 10;
		}
		
		footer {
			background-color: plum;
			width: 100%;
			text-align: center;
			line-height: 30px;
		}
		
		a {
			text-decoration: none;
		}
		
		.logo {
			display: block;
		    margin-left: 50px;
		    width: 28%;
		    max-width: 142px;
		}
		
		.menu-list {
		    display: block;
		    position: absolute;
		    right: 100px;
    		width: 50%;
		}
		
		.menu-list li {
			display: inline-block;
			list-style: none;
			width: 10%;
		    margin-top: -60px;
		    vertical-align: middle;
		}
		
		.account-list {
			display: block;
		    position: absolute;
		    text-align: right;
		    right: 50px;
    		width: 50%;
		}
		
		.account-list li {
			display: inline-block;
			list-style: none;
		    margin-top: -60px;
		    vertical-align: middle;
		    text-align: center;
		    width: 5%;
		}
		
		.dropdown-member-list {
			position: absolute;
			border: 1px solid gray;
			border-radius: 5px;
			margin-top: 3%;
			right: 1%;
			width: 300px;
			z-index: 1;
			background: white;
		}
		
		.profile-img {
			position: relative;
			float: left;
			width: 50px;
			height: 50px;
			border-radius: 30%;
			overflow: hidden;
		}
		
		#PROFILE_IMG {
			width: 100%;
			height: 100%;
			object-fit: cover;
		}
		
		.member-info {
			position: relative;
			margin-left: 50px;
		}
		
		.member-account {
			margin-top: 5px;
		}
	
	</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$(".dropdown-member-list").css("display", "none");
		
		$(".dropdown-member").click(function() {
			$(".dropdown-member-list").toggle(100);
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div id="header">
		<div class="logo">
			<a href="/SINGLE/main/mainpage.do">SINGLE</a>
		</div>
		
		<c:choose>
			<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver }">
				<div class="dropdown">
					<ul class="menu-list">
						<li>
							<a href="#">MAP</a>
						</li>
						<li>
							<a href="/SINGLE/chat/chatpage.do">CHATTING</a>
						</li>
						<li>
							<a href="/SINGLE/board/noticepage.do">BOARD</a>
						</li>
						<li>
							<a href="/SINGLE/life/lifeSelect.do">LIFE</a>
						</li>
						<li>
							<a href="/SINGLE/festival/festivalpage.do">FESTIVAL</a>
						</li>
					</ul>
					
					<ul class="account-list">
						<li>
							<a class="dropdown-notification">알림</a>
						</li>
						<li>
							<a class="dropdown-member">계정</a>
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
	</div>
	
	<!-- 계정관련 드롭다운 메뉴 -->
	<div class="dropdown-member-list">
		<div class="profile-img">
			<img id="PROFILE_IMG" alt="프로필 사진" src="../resources/images/profileimg/${profile.MPROFILE_IMG_SERVERNAME }">
		</div>
		<div class="member-info">
			<h3>${profile.MEMBER_NICKNAME }</h3>
			<h4>${profile.MEMBER_EMAIL }</h4>
		</div>
		<hr>
		<div class="member-account">
			<div>
				<a href="/SINGLE/member/profilepage.do">MYPAGE</a>
			</div>
			<div>
				<a href="/SINGLE/member/logout.do">로그아웃</a>
			</div>
		</div>
	</div>

</body>
</html>