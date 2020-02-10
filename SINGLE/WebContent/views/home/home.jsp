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
<title>HOME</title>

<!-- START :: 로그인 상태일 때 이 화면으로 오면 안되기 때문 -->
<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver }">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 로그인 상태일 때 이 화면으로 오면 안되기 때문 -->

</head>
<body>

	<h1>SINGLE :: 나 혼자 산다</h1>
	<a href="/SINGLE/member/joinpage.do">회원가입</a>
	<a href="/SINGLE/member/loginpage.do">로그인</a>

</body>
</html>