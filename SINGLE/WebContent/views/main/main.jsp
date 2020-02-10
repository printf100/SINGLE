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
<title>MAIN</title>

<!-- START :: css -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

<!-- START :: 잘못된 접근을 막기 위함 -->
<c:if test="${empty sessionLoginMember && empty sessionLoginKakao && empty sessionLoginNaver }">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 잘못된 접근을 막기 위함 -->

</head>
<body>

	<a href="/SINGLE/member/logout.do">로그아웃</a>
	<c:out value="${sessionLoginMember.MEMBER_NICKNAME }"></c:out>
	<c:out value="${sessionLoginKakao.KAKAO_ID }"></c:out>
	
</body>
</html>