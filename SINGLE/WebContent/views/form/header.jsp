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
			background-color: plum;
			height: 50px;
		}
		
		footer {
			background-color: plum;
			height: 30px;
			text-align: center;
			line-height: 30px;
		}
		
		a {
			text-decoration: none;
		}
	
	</style>
<!-- END :: CSS -->

</head>
<body>

	<div id="header">
		<span>
			<a href="/SINGLE/main/mainpage.do">SINGLE</a>
		</span>
		
		<c:choose>
			<c:when test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver }">
				<span>
					<a href="#">MAP</a>
					<a href="#">CHATTING</a>
					<a href="#">BOARD</a>
					<a href="#">LIFE</a>
					<a href="/SINGLE/member/profilepage.do">MYPAGE</a>
					<a href="/SINGLE/member/logout.do">로그아웃</a>
				</span>				
			</c:when>
			<c:otherwise>
				<span>
					<a href="/SINGLE/member/joinpage.do">회원가입</a>
					<a href="/SINGLE/member/loginpage.do">로그인</a>
				</span>
			</c:otherwise>
		</c:choose>
	</div>

</body>
</html>