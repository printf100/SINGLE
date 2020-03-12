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

<!-- START :: CSS -->
<style type="text/css">
	
h1 {
	display:inline-block;
}

h3 {
	display:inline-block;
}

.table {
	margin-top: 30px;
}

#notice{
	font-weight: bold;
	color: #4169e1;
}

th {
	text-align: center;
}

a {
	color:#2f4f4f;
}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
</script>
<!-- END :: JAVASCRIPT -->
</head>
<body>

	<div class="container">
		
		<div style="text-align: center;">
			<a id="notice" href="/SINGLE/board/noticepage.do">
				<img style="width:35px; height:35px;"src="${pageContext.request.contextPath}/resources/images/icon/info.png">
			</a>
		</div>
		
		<div style="margin-top: 30px;">
			<div style="float:right;">
				<c:if test="${sessionLoginMember.MEMBER_VERIFY eq 1 }">
					<input class="btn btn-info btn-sm" id="writebutton" type="button" value="글쓰기" onclick="location.href='/SINGLE/board/noticeWrite.do'">
				</c:if>
			</div>
		
			<div style="float:left;">
				<form action="/SINGLE/board/noticepage.do" method="post">
					<select name="option">
						<option value="0" <c:if test="${option=='0' }">selected</c:if>>제목</option>
						<option value="1" <c:if test="${option=='1' }">selected</c:if>>내용</option>
						<option value="2" <c:if test="${option=='2' }">selected</c:if>>제목+내용</option>
						<option value="3" <c:if test="${option=='3' }">selected</c:if>>작성자</option>
					</select>
					<c:choose>
						<c:when test="${condition eq null }">
							<input type="text" size="40" name="condition"/>
						</c:when>
						<c:otherwise>
							<input type="text" size="40" name="condition" value="${condition }"/>
						</c:otherwise>
					</c:choose>
					
					<input type="submit" class="btn btn-secondary btn-sm" value="검색">
				</form>
			</div>
		</div>
			
		<table class="table table-bordered table-hover">
			<thead>
				<tr>
					<th style="width: 8.33%">번호</th>
					<th style="width: 65%">제목</th>
					<th style="width: 11.67%">조회수</th>
					<th style="width: 15%">작성시간</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty NoticeBoardList }">
						<tr>
							<td colspan="4" align="center">----------작성된 글이 없습니다----------</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${NoticeBoardList}" var="dto">
							<tr>
								<td>${dto.BOARD_CODE }</td>
								<td><a href="/SINGLE/board/noticeDetail.do?BOARD_CODE=${dto.BOARD_CODE }&FILE_SERVER=${dto.FILE_SERVER}">${dto.BOARD_TITLE }</a></td>
								<td>${dto.COUNT_VIEW }</td>
								<td>${dto.BOARD_REGDATE }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>	
			</tbody>
		</table>
			
		<ul class="pagination justify-content-center">
		
			<c:set var="option" value="${option }"/>
			<c:set var="condition" value="${condition }"/>
			
			<c:if test="${curPageNum > 5 }">
				<c:if test="${condition != null }">
					<p>${condition }</p>
					<li class="page-item"><a class="page-link" href="/SINGLE/board/noticepage.do?curPage=${blockStartNum -1 }&option=${option}&condition=${condition}">Previous</a></li>
				</c:if>
				<c:if test="${condition == null }">
					<li class="page-item"><a class="page-link" href="/SINGLE/board/noticepage.do?curPage=${blockStartNum -1 }">Previous</a></li>
				</c:if>
			</c:if>
			<c:forEach var="i" begin="${blockStartNum }" end="${blockLastNum }">
				<c:choose>
					<c:when test="${i > lastPageNum }">
						<li class="page-item">${i }</li>
					</c:when>
					
					<c:when test="${i == curPageNum }">
						<li class="page-item">${i }</li>
					</c:when>
					
					<c:otherwise>
						<c:if test="${condition != null }">
							<li class="page-item"><a class="page-link" href="/SINGLE/board/noticepage.do?curPage=${i }&option=${option}&condition=${condition}">${i }</a></li>
						</c:if>
						<c:if test="${condtion == null }">
							<li class="page-item"><a class="page-link" href="/SINGLE/board/noticepage.do?curPage=${i }">${i }</a></li>
						</c:if>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<c:if test="${lastPageNum > blockNum }">
				<li class="page-item"><a class="page-link" href="/SINGLE/board/noticepage.do?curPage=${blockLastNum + 1 }&option=${option}&condition=${condition}">Next</a></li>
			</c:if>
		</ul>
		
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>