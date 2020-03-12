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

	.container {
		height: auto;
		min-width: 300px;
		max-width: 520px;
		padding: 50px;
		margin-top: 150px;
		border: 10px solid #46b8da;
		border-radius: 5px;
	}
	
	#resetForm {
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

<script type="text/javascript" src="../resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="../resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="../resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="../resources/js/RSA/rng.js"></script>

<script type="text/javascript">
	
	$(function() {
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");
		
		$("#SUBMIT").attr("disabled", "disabled");
		
		// 비밀번호 정규식 (숫자와 영문자 조합으로 최소 8자리)
		var regExp = /^[a-zA-Z0-9]{8,}$/;
		
		//비밀번호 체크
		$("#MEMBER_PASSWORD,#PW_CONFIRM").keyup(function() {
		
			if($("#MEMBER_PASSWORD").val() != null && $("#MEMBER_PASSWORD").val() != ""){
				
				// 비밀번호 형식인지 체크
				if(regExp.test($("#MEMBER_PASSWORD").val())) {
					$("#pw_check").text("");
					
					// 비밀번호 확인 체크
					if($("#MEMBER_PASSWORD").val() != "" && $("#PW_CONFIRM").val() != "") {
						
						if($("#MEMBER_PASSWORD").val() != $("#PW_CONFIRM").val()) {
							$("#pw_confirm").text("비밀번호가 일치하지 않습니다.");
							$("#pw_confirm").attr("style", "color:red");
						} else {
							$("#SUBMIT").removeAttr("disabled");
							
							$("#pw_confirm").text("비밀번호가 일치합니다.");
							$("#pw_confirm").attr("style", "color:green");
						}
					}
					
				} else {
					$("#pw_check").text("적어도 하나의 영문자와 숫자, 최소 8자 이상");
					$("#pw_check").attr("style", "color:red");
				}
			}
		});
		
		// 입력된 값들을 서버에 전송
		$("#resetForm").submit(function(e) {
			e.preventDefault();
			
			var MEMBER_PASSWORD = $(this).find("#MEMBER_PASSWORD").val();
	
			// 사용자가 입력한 form에서 hidden form으로 셋팅
			// 비밀번호 암호화
			$("#resethiddenForm input[name='MEMBER_PASSWORD']").val(rsa.encrypt(MEMBER_PASSWORD));
						
			$("#resethiddenForm").submit();
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<h3><strong>비밀번호 재설정</strong></h3>
		<h6 style="color: #98A8B9;">	비밀번호를 다시 설정합니다. 비밀번호는 적어도 하나의 영문자와 숫자를 포함해야 하며, 최소 8자 이상 되어야 합니다.</h6>
		
		<form action="/SINGLE/member/pwReset.do" method="post" id="resetForm">
				
			<div class="form-group">
				<label class="required" for="MEMBER_PASSWORD">새로운 비밀번호</label>
				<input type="password" class="form-control" name="MEMBER_PASSWORD" id="MEMBER_PASSWORD" autocomplete="off" required="required">
				<div class="check_font" id="pw_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>				
			
			<div class="form-group">
				<label class="required" for="PW_CONFIRM">비밀번호 확인</label>
				<input type="password" class="form-control" id="PW_CONFIRM" autocomplete="off" required="required">
				<div class="check_font" id="pw_confirm"></div><!-- 경고문이 들어갈 공간 -->
			</div>
			
			<div class="submit-btn form-group">
				<input type="submit" class="btn btn-info btn-block" id="SUBMIT" value="완료">
			</div>
		</form>
	</div>
	
	<form action="/SINGLE/member/pwReset.do" method="post" id="resethiddenForm">
		<input type="hidden" name="MEMBER_PASSWORD">
		<input type="hidden" name="MEMBER_CODE" value="${sessionLoginMember.MEMBER_CODE }">
	</form>

</body>
</html>