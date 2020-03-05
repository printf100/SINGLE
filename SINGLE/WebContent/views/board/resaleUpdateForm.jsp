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

#deleteFile{
	cursor: pointer;
	color: #ff4500;
}

th{
	font-weight: bold;
	color:#696969;
}

#file_name{
	color:#696969;
}

#text{
	height: 360px;
	width: 80%;
	}
	
.fileDiv label {
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
.fileDiv label input {
    position:absolute;
    width:0;
    height:0;
    overflow:hidden;
}
.fileDiv input[type=text] {
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

</style>
<!-- END :: CSS -->
<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="//cdn.ckeditor.com/4.13.1/standard/ckeditor.js"></script>
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
	
	var str = "<input type='file' name='RESALE_IMG_ORIGINAL' required>";
	$("#fileDiv").append(str);
	
	$("#deleteFile").on("click", function(e) {
		e.preventDefault();
		deleteFile($(this));
	});
};

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
<!-- END :: JAVASCRIPT -->
</head>
<body>
	
	<div class="container">
		<form id="form" action="/SINGLE/board/resaleUpdateRes.do" method="post" enctype="Multipart/form-data">
			<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
			<input type="hidden" name="RESALE_CODE" value="${dto.RESALE_CODE }">
			
			<table class="table">
				<tr>
					<th>제목</th>
					<td><input type="text" class="form-control" name="RESALE_TITLE" value="${dto.RESALE_TITLE }"></td>
				</tr>
				<tr>
					<th>희망 가격</th>
					<td><input type="text" class="form-control" name="RESALE_PRICE" value="${dto.RESALE_PRICE }"></td>
				</tr>
				<tr>
					<th>교환 희망 주소</th>
						<td><input type="text" class="form-control" name="RESALE_ADDRESS" value="${dto.RESALE_ADDRESS }"></td>
					</tr>
				<tr>
					<td colspan="2">
						<textarea id="resaleContent" name="RESALE_CONTENT">${dto.RESALE_CONTENT }</textarea>
						<script>
			                CKEDITOR.replace('resaleContent',{
			                	filebrowerUploadUrl: '/SINGLE/board/resaleWriteRes.do'
			                });
			            </script>
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td>${dto.RESALE_IMG_ORIGINAL }	<a href="#" id="deleteFile">삭제하기</a></td>
				</tr>
				</table>
				
				<div style="text-align: center;">
					<input class="btn btn-outline-secondary" type="button" value="취소" onclick="location.href='/SINGLE/board/resaleDetail.do?&RESALE_CODE=${dto.RESALE_CODE}'"/>
					<input class="btn btn-info" type="submit" value="수정"/>
				</div>
		</form>
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>