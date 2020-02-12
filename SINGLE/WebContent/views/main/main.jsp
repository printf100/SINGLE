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

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<c:out value="${sessionLoginMember.MEMBER_NICKNAME }"></c:out>
	<c:out value="${sessionLoginKakao.MEMBER_NICKNAME }"></c:out>
	<c:out value="${sessionLoginKakao.KAKAO_ID }"></c:out>
	<c:out value="${sessionLoginNaver.MEMBER_NICKNAME }"></c:out>
	<c:out value="${sessionLoginNaver.NAVER_ID }"></c:out>
	
<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
	
</body>
</html>