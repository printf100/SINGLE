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
<title>Insert title here</title>

<!-- START :: CSS -->
<style type="text/css">

	.table {
		margin-top: 30px;
	}
	
	.table a {
		color: #000;
	}

	th, td {
		text-align: center;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function(){
		$("#form").submit(function(){
			if($("#form input:checked").length == 0){
				alert("하나 이상 체크해주세요!");
				return false;
			}
		});
	});
	
	function allChks(bool){
		var chks = document.getElementsByName("chk");
		for(var i = 0; i < chks.length; i ++){
			chks[i].checked = bool;
		}
	}
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">

		<div style="text-align: center;">
			<img style="width:35px; height:35px;" src="../resources/Images/heart.png">
		</div>
		
		<form action="/SINGLE/board/interestDelete.do" method="post" id="form">
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th style="width: 10%">
							<input type="checkbox" name="all" onclick="allChks(this.checked);"/>
						</th>	
						<th style="width: 90%">제목</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty list }">
							<tr>
								<td colspan="2">관심리스트로 등록된 항목이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list }" var="dto">
								<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }"/>
								<tr>
									<td style="width: 10%;">
										<input type="checkbox" name="chk" value="${dto.RESALE_CODE }"/>
									</td>
									<td style="width: 90%;"><a href="/SINGLE/board/resaleDetail.do?RESALE_CODE=${dto.RESALE_CODE }">${dto.RESALE_TITLE }</a></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
	
			<div style="float: right;">
				<input type="submit" class="btn btn-danger" value="선택삭제">
			</div>
		</form>
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>