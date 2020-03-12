<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- START :: include header -->
<%@ include file="/views/form/header.jsp" %>

<!-- END :: include header -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>SINGLE</title>

<!-- START :: CSS -->
<style type="text/css">

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

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

$(function(){
	$('#form').submit(function(){
		var content = CKEDITOR.instances.noticeContent.getData();
		if(content.trim() == "" || content == null){
			alert("본문을 입력해 주시기 바랍니다.");
			return false;
		}
		
	});
	
});


</script>
<script type="text/javascript" src="../../resources/js/ckeditor/ckeditor.js"></script>
<!-- END :: JAVASCRIPT -->
</head>
<body>

	<div class="container">
		<form id="form" action="/SINGLE/board/noticeWriteRes.do" method="post" enctype="Multipart/form-data">
			<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
			
			<table class="table">
				<thead>
					<tr>
						<td><input type="text" class="form-control" name="BOARD_TITLE" required></td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2" class="text">
							<textarea id="noticeContent" name="BOARD_CONTENT">
							</textarea>
							<script>
				                CKEDITOR.replace('noticeContent',{
				                	filebrowerUploadUrl: '/SINGLE/board/noticeWriteRes.do'
				                });
				
				            </script>
						</td>
					</tr>
				</tbody>
			</table>
			
		<div style="width: 50%; float:none; margin:0 auto; text-align: left;">	
			<div class="file_input">
			    <label>
			        	파일 첨부하기
			        <input type="file" name="NOTICE_FILE_ORIGINAL" onchange="javascript:document.getElementById('file_route').value=this.value">
			    </label>
			    <input type="text" readonly="readonly" title="File Route" id="file_route">
			</div>
		</div>
		
		<div style="text-align: center; margin-top: 30px;">
			<input class="btn btn-outline-secondary" type="button" value="취소" onclick="location.href='/SINGLE/board/noticepage.do'"/>
			<input class="btn btn-info" type="submit" value="등록"/>
		</div>
		</form>
	</div>

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>