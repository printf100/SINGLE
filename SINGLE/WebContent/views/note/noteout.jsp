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

<style type="text/css">

	body {
		position: relative;
	}

	.col-sm-3 {
		margin: 20px;
	}
	
	.list-group a {
		color: #263747;
	}
  	
  	table a {
		color: #263747;
	}
	
  	ul .nav-pills {
    	top: 20px;
    	position: fixed;
    }
    
  	div .col-sm-8 div {
  		height: 500px;
  	}
  	
  	#noteSearch {
  		margin-top: 20px;
  		margin-bottom: 20px;
  	}

</style>

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		// 쪽지 검색하기
		$("#noteSearch").keyup(function() {
			var value = $(this).val().toLowerCase();
		    
			$("#outList tr").filter(function() {
				$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		});
		
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body data-spy="scroll" data-target="#myScrollspy" data-offset="1">

	<div class="container">
		<div class="row">
		
			<!-- 왼쪽 메뉴 바 -->
			<div class="col-sm-3">
				<ul class="list-group" id="myScrollspy">
					<li class="list-group-item d-flex justify-content-between align-items-center">
						<a class="nav-link active" href="/SINGLE/note/noteInList.do">받은 쪽지함</a>
						<span class="badge badge-primary badge-pill">${inUnread }</span>
			        </li>
			        <li class="list-group-item d-flex justify-content-between align-items-center">
			        	<a class="nav-link" href="/SINGLE/note/noteOutList.do">보낸 쪽지함</a>
			        </li>
			     </ul>
			</div>
			
			<!-- 콘텐츠 -->
			<div class="col-sm-8">
				<p style="font-size: 25pt;"><strong>보낸 쪽지함</strong>	<span style="color: black; font-size: 15pt;">${outAll }</span>
				
				<input class="form-control" id="noteSearch" type="text" placeholder="쪽지 검색">
				
				<table class="table table-bordered">
					<col width="50">
					<col width="100">
					<col width="50">
					<col width="50">
					<thead>
						<tr>
							<th>받는 사람</th>
							<th>제목</th>
							<th>날짜</th>
							<th>읽음</th>
						</tr>
					</thead>
					
					<tbody id="outList">
						<c:choose>
							<c:when test="${empty outList }">
								<tr>
									<th colspan="4">보낸 쪽지가 없습니다.</th>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${outList }" var="out">
									<tr>
										<td>${out.NOTE_TO_NICKNAME }</td>
										<td><a href="/SINGLE/note/noteOutDetailpage.do?NOTE_CODE=${out.NOTE_CODE }">${out.NOTE_TITLE }</a></td>
										<td>${out.NOTE_SENDDATE }</td>
										<td>${out.NOTE_READ }</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
		</div>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>