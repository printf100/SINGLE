<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SINGLE 이메일 인증</title>

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">

	body {
		font-family: 'Noto Sans KR';
		overflow: hidden;
	}

	.container {
		margin: 40px 20px 0px 20px;
	}
	
	#emailAuth {
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
	
	.auth-btn {
		text-align: center;
	}	

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#inputAuthNum").focus();
		
		$("#emailAuth").submit(function(e) {
			e.preventDefault();
			
			var authNum = $(opener.document).find("#emailAuthHiddenForm input[name='authNum']").val();
			var inputAuthNum = $("#inputAuthNum").val();
			
			if(authNum == inputAuthNum) {
				alert("이메일 인증을 성공하였습니다.");
				$(opener.document).find("#email_check").text("이메일 인증을 성공하였습니다.");
				$(opener.document).find("#email_check").attr("style", "color:green");
				
				$(opener.document).find("#email_auth").remove();
				$(opener.document).find("#MEMBER_EMAIL").attr("disabled", "disabled");
				
				$(opener.document).find("#MEMBER_PASSWORD").focus();

				close();
			} else {
				alert("인증번호가 일치하지 않습니다.");
			}
		});
	});
	
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	<div class="container">
		<div class="text-center">
			<p style="color:#46b8da; font-size: 20pt;"><strong>이메일 인증하기</strong>
		</div>
		
		<form action="#" id="emailAuth">
			<div class="form-group">
				<label class="required" for="inputAuthNum">인증번호</label>
				<input type="text" class="form-control" id="inputAuthNum" name="inputAuthNum" placeholder="이메일로 전송된 인증번호를 입력해주세요." autocomplete="off" required="required" />
			</div>
			
			<div class="auth-btn form-group">
				<input type="submit" class="btn btn-info btn-block" value="인증하기">
			</div>
		</form>
	</div>

</body>
</html>