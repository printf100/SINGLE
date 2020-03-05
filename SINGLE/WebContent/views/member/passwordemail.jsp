<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
	
	.container {
		height: auto;
		min-width: 300px;
		max-width: 520px;
		padding: 50px;
		margin-top: 180px;
		border: 10px solid #46b8da;
		border-radius: 5px;
	}
	
	.emailForm {
		margin-top: 50px;
	}
	
	label.required::before {
		content: '*';
	    display: inline-block;
	    vertical-align: top;
	    font-weight: 700;
	    -webkit-font-smoothing: antialiased;
	    color: #F44336;
	    margin: 0 0.125rem 0 0;
	    font-size: 1.25rem;
	    line-height: 1.25rem;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		$("#email_auth").attr("disabled", "disabled");
		
		// 이메일 정규식
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;	
		
		// 이메일 체크
		$("#CONFIRM_EMAIL").keyup(function() {
			
			if($("#CONFIRM_EMAIL").val() != null && $("#CONFIRM_EMAIL").val() != ""){
				
				// 이메일 형식인지 체크
				if(regExp.test($("#CONFIRM_EMAIL").val())) {
					$("#email_auth").removeAttr("disabled");
					$("#email_check").text("");
				
				} else {
					$("#email_auth").attr("disabled", "disabled");
					
					$("#email_check").text("이메일 형식이 아닙니다.");
					$("#email_check").attr("style", "color:red");
				}
			}
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	
	<div class="container">
		<h3><strong>비밀번호 찾기</strong></h3>
		<h6 style="color: #98A8B9;">	비밀번호를 재설정 할 이메일을 입력하세요. 자세한 안내가 담긴 메일을 보내드리겠습니다.</h6>
		
		<form action="/SINGLE/member/pwResetEmail.do" method="post" class="emailForm">
			<input type="hidden" name="MEMBER_NAME" value="${sessionLoginMember.MEMBER_NAME }">
					
			<div class="form-group">
				<label class="required" for="CONFIRM_EMAIL">비밀번호를 재설정 할 이메일</label>
				<input type="text" class="form-control" id="CONFIRM_EMAIL" name="CONFIRM_EMAIL" placeholder="example@example.com" autofocus autocomplete="off" required="required" />
				<div class="check_font" id="email_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>
					
			<div class="submit-btn form-group">
		    	<input type="submit" class="btn btn-info btn-block" value="비밀번호 재설정 메일 보내기" >
			</div>
		</form>
	</div>

</body>
</html>