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
	
	.file_input label {
	    position:relative;
	    margin: 2px;
	    cursor:pointer;
	    display:inline-block;
	    vertical-align:middle;
	    overflow:hidden;
	    width:150px;
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
	    width: 80%;
	    height:28px;
	    line-height:28px;
	    font-size:11px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript" src="../../resources/js/ckeditor/ckeditor.js"></script>

<script type="text/javascript">


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
		
		<form id="form" action="/SINGLE/board/resaleWriteRes.do" method="post" enctype="Multipart/form-data">
			<input type="hidden" id="member_code" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }${sessionLoginKakao.MEMBER_CODE }${sessionLoginNaver.MEMBER_CODE }">
			
			<table class="table">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="resale_title" class="form-control" name="RESALE_TITLE" required="required"/>
					</td>
				</tr>
				<tr>
					<th>희망 가격</th>
					<td>
						<input type="text" class="form-control" id="resale_price" required="required" name="RESALE_PRICE" placeholder="숫자만 기입해주세요. 예) 5,000"/>
					</td>
				</tr>
				<tr>
					<th>교환 희망 주소</th>
					<td>
						<input type="text" class="form-control" required="required" id="resale_address" name="RESALE_ADDRESS"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" id="text">
						<textarea id="resaleContent" name="RESALE_CONTENT" required="required">
						</textarea>
						<script>
				             CKEDITOR.replace('resaleContent',{
				             	filebrowerUploadUrl: '/SINGLE/board/resaleWriteRes.do'
				             });
				        </script>
				    </td>
				</tr>
			</table>
			
			<div id="file_input_container">	
			<div class="file_input">
				<label>
			        	파일 첨부하기
			        <input type="file" name=RESALE_IMG_ORIGINAL id="resale_img" required="required" onchange="javascript:document.getElementById('file_route').value=this.value">
		        </label>
		    	<input type="text" class="form-control" readonly="readonly" title="File Route" id="file_route">
			</div>
		</div>
	
			<div style="text-align: center; margin-top: 30px;">
				<input type="button" class="btn btn-outline-secondary" value="취소" onclick="location.href='/SINGLE/board/resalepage.do'"/>
				<input type="submit" class="btn btn-info" id="submitbtn" value="등록"/>
			</div>
			
		</form>
	</div>
	

<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->
</body>
</html>