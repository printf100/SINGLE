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

<script src="${pageContext.request.contextPath}/resources/js/festivaljs/libs/jquery-ui/jquery-ui.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/js/festivaljs/libs/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/festival.css" />
<script src="${pageContext.request.contextPath}/resources/js/scripts/scripts.js"></script>
<!-- END :: JAVASCRIPT -->


</head>
<body>
	<div id="container" style="margin-top: 50px;">
    <div id="header" style="margin-top: 50px;">
        <div class="menu-items right">
          <a href="/SINGLE/festival/festivalapipage.do">전국 축제</a>
          <img src="${pageContext.request.contextPath}/resources/css/images/line_maintop_gray.png" />
          <a href="/SINGLE/festival/aroundpage.do">주변관광지 찾기</a> 
        </div>
      </div>
    <div id="body">
      <div id="title-text" class="lg-text">FESTIVAL</div>
      <div id="title-sub-text" class="md-text">Do you want to go together?</div>
      </div>
     </div>

</body>
</html>