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

	function downloadConfirm(){
		var result = confirm("다운로드 하시겠습니까?");
		if(result)
			location.href='/SINGLE/file/noticeFileDownload.do?FILE_SERVER=${dto.FILE_SERVER }';
	}

</script>

<style type="text/css">

#board_content{
	margin: auto;
	width : 100%;
	height: 100%;
}

.class{
	text-align: center;
}

th{
	text-align: center;
}

#title{
	font-weight: normal;
}

#content{
	padding: 15px;
	height: 300px;
}

.btn btn-default{
	float: left;
	margin: auto;
}



</style>

<!-- END :: JAVASCRIPT -->
</head>
<body>
	
	<div class="container">
		<table class="table table-bordered">
		
			<col width="50"/>
			<col width="300"/>
			<col width="70"/>
			<col width="100"/>
			
			<thead>
				<tr>
					<th>제목</th>
					<th id="title">${dto.BOARD_TITLE }</th>
					<th>조회수</th>
					<th>${COUNT_VIEW }</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td id="content" colspan="4">
					 ${dto.BOARD_CONTENT }
					</td>
				</tr>
				<tr>
				
				<!-- 첨부파일 -->
				<c:choose>
					<c:when test="${dto.FILE_SERVER eq null }">
						<td colspan="4">
							첨부된 파일 없음
						</td>
					</c:when>
					<c:otherwise>
						<td colspan="4"><a href="#" onclick="downloadConfirm();">${dto.FILE_ORIGINAL }</a></td>
					</c:otherwise>
				</c:choose>
				</tr>
			</tbody>
		</table>	
		
		<!-- 목록 / 수정 / 삭제 -->
		<div style="text-align: center;">
			<input class="btn btn-default" type="button" value="목록" onclick="location.href='/SINGLE/board/noticepage.do'"/>
			
			<c:if test="${dto.MEMBER_CODE eq sessionLoginMember.MEMBER_CODE }">
				<input class="btn btn-info" type="button" value="수정" onclick="location.href='/SINGLE/board/noticeUpdate.do?&BOARD_CODE=${dto.BOARD_CODE }'"/>
				<input class="btn btn-danger" type="button" value="삭제" onclick="location.href='/SINGLE/board/noticeDelete.do?&BOARD_CODE=${dto.BOARD_CODE }&FILE_SERVER=${dto.FILE_SERVER }'"/>
			</c:if>
		</div>
	</div>
	

	
<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>