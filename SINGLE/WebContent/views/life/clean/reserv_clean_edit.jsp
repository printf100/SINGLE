<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/life/clean/date.js"></script>
<script type="text/javascript">
// checkBox를 radio버튼처럼 하나만 체크되게
$(function(){ 
	  $('input[type="checkbox"]').bind('click',function() {
	    $('input[type="checkbox"]').not(this).prop("checked", false);
	  });
});
 

    // 수거마감시간 setting
	function reservEnd(time,status){
		var end = time.substring(11,13);
		if(end == '16'){
			end = '18시';
		}else if(end == '18'){
			 end = '20시';
		 }else if(end == '20'){
			 end = '22시';
		 }else if(end == '22'){
			 end = '자정이후';
		 } 
		$("#end_span"+status).text(end);
		return end;
	}
   // 예약 변경 function
   function reservChange() {
	   if( $("input[name=check_list]:checked").length <1 ){
		   alert("변경할 예약을 선택해주세요.");
		   return false;
	   }
	   var result = confirm('해당 예약을 변경 하시겠습니까?'); 
		
		if(result) {
			 $("input[name=check_list]:checked").each(function() {
				   var CLEAN_CODE = $(this).val(); 
				   location.href="/SINGLE/life/clean/updateForm.do?CLEAN_CODE="+CLEAN_CODE;
				 });
		}
	   
	   
	   
   }
	 
   // 예약 취소 function
   function reservCancel(){
	   if( $("input[name=check_list]:checked").length <1 ){
		   alert("취소할 예약을 선택해주세요.");
		   return false;
	   }
	   
	   var result = confirm('해당 예약을 취소하시겠습니까?'); 
		
		if(result) {
	   $("input[name=check_list]:checked").each(function() {
		   var CLEAN_CODE = $(this).val(); 

		   location.href="/SINGLE/life/clean/cancel.do?CLEAN_CODE="+CLEAN_CODE+"&status=1";
		 });
		}

   }
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<!-- TEXT AREA / BUTTON AREA-->
		
		 <div class="reserv_div" id="reserv_div">
			<h1>${fn:length(reservList)}개의 예약이 있습니다.</h1>
			<br><br><br><br> 
			<c:forEach items="${reservList}" var="list" varStatus="status">
			<input type="checkbox" name="check_list" value="${list.CLEAN_CODE }">
			<fmt:parseDate var="CLEAN_TIME" value="${list.CLEAN_TIME }" pattern="yyyy-MM-dd HH:mm:ss" />
			<fmt:formatDate value="${CLEAN_TIME }" pattern="MM월 dd일 E요일 오후 HH시 ~ "/><span id="end_span${status.count }"></span>
			<script>reservEnd("${list.CLEAN_TIME }","${status.count}")</script> 
			<BR><BR>
			</c:forEach> 
			<input class="btn btn-light" type="button" value="예약변경" onclick="reservChange()"> 
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