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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>청소 도우미</title>

<!-- START :: CSS -->
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/life/clean/date.js"></script>
<script type="text/javascript">
	//예약 목록으로 가기
	function reservList(){
		location.href="/SINGLE/life/clean/edit.do";
	}
	//예약 취소하기
	function reservCancel(){
		var result = confirm('예약을 취소하시겠습니까?'); 
		
		if(result) {
			location.href="/SINGLE/life/clean/cancel.do";
		}
	 
	}
		
	
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<!-- TEXT AREA / BUTTON AREA-->
		
		 <div class="reserv_div" id="reserv_div" >
			<h1>예약이 완료되었습니다</h1>
			<br><br><br><br>
			<input class="btn btn-light" type="button" value="예약목록" onclick="reservList()">
			<input class="btn btn-light" type="button" value="예약취소" onclick="reservCancel()">
		 </div>
		
	</div>
	


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>

</html>