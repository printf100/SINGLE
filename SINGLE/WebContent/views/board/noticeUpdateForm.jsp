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

@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

body {
  font-family: "Noto Sans KR", sans-serif !important;
}

.text{
	height: 360px;
	width: 80%;
}

th{
	text-align: center;
	line-height: 100%;
}
	
.file_input label {
    position:relative;
    margin: 2px;
    cursor:pointer;
    display:inline-block;
    vertical-align:middle;
    overflow:hidden;
    width:100px;
    height:30px;
    background:#1e90ff;
    color:#fff;
    text-align:center;
    line-height:30px;
    border-top-left-radius: 5px; 
    border-bottom-left-radius: 5px;
    border-top-right-radius: 5px;
    border-bottom-right-radius: 5px;

}
.file_input label input {
    position:absolute;
    width:0;
    height:0;
    overflow:hidden;
}
.file_input input[type=text] {
    vertical-align:middle;
    display:inline-block;
    width:400px;
    height:28px;
    line-height:28px;
    font-size:11px;
    padding:0;
    border:0;
    border:1px solid #b0c4de;
    border-top-left-radius: 1px; 
    border-bottom-left-radius: 1px;
    border-top-right-radius: 1px;
    border-bottom-right-radius: 1px;
    
 
}

#deleteFile{
	color: #ff4500;
}


</style>
<!-- END :: CSS -->
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(function() {
	$("#deleteFile").on("click", function(e) {
		e.preventDefault();
		deleteFile($(this));
	})
})

function deleteFile(obj) {
	
	obj.parent().remove();
	obj.parent().parent().remove();
	
	var str = "<p><input type='file' name='FILE_ORIGINAL'>"
	$("#fileDiv").append(str);
	
	$("#deleteFile").on("click", function(e) {
		e.preventDefault();
		deleteFile($(this));
	});
}

$(function(){
	$("#form").submit(function(){
		var content = CKEDITOR.instances.resaleContent.getData();
		if(content.trim() == "" || content == null){
			alert("본문을 입력해 주시기 바랍니다.");
			return false;
		}
		
	});
});



</script>
<script src="//cdn.ckeditor.com/4.13.1/standard/ckeditor.js"></script>
<!-- END :: JAVASCRIPT -->
</head>
<body>

	<div class="container">
		<form id="form" action="/SINGLE/board/noticeUpdateRes.do" method="post" enctype="Multipart/form-data">
			<input type="hidden" name="BOARD_CODE" value="${dto.BOARD_CODE }"/>
			
			<table class="table">
					<tr>
						<th>제목</th>
						<td>
							<input class="form-control" type="text" name="BOARD_TITLE" value="${dto.BOARD_TITLE }" required/>
						</td>
					<tr>
					<tr>
						<td colspan="3" class="text">
							<textarea id="editor1" name="BOARD_CONTENT">${dto.BOARD_CONTENT }</textarea>
							<script>
				                CKEDITOR.replace( 'editor1' );
				            </script>
						</td>
					</tr>
			</table>
			
			<br/>
			
				<c:if test="${dto.FILE_ORIGINAL ne '0' }">
				
					<div id="fileDiv" style="float:none; margin: 0 auto; text-align: left;">
					
						<c:choose>
							<c:when test="${dto.FILE_ORIGINAL ne null }">
								<input type="hidden" name="FILE_ORIGINAL" value="${dto.FILE_ORIGINAL }">
								<p>
									파일 | ${dto.FILE_ORIGINAL } <a href="#" id="deleteFile">삭제하기</a>
								</p>
							</c:when>
							<c:otherwise>
								<p><input type="file" name="FILE_ORIGINAL"></p>
							</c:otherwise>
						</c:choose>
						
						
					</div>
				</c:if>
				
					<div style="text-align: center; margin-top: 30px;">
						<input class="btn btn-default" type="button" value="취소" onclick="location.href='/SINGLE/board/noticeDetail.do?BOARD_CODE=${dto.BOARD_CODE}'"/>
						<input class="btn btn-info" type="submit" value="등록"/>
					</div>
		</form>
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>