<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS 회원가입</title>

<!-- START :: CSS -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript">

	$(function() {
		// join.jsp에서 넘긴 정보 가져오기
		var snsType = $(opener.document).find("#snshiddenForm input[name='snsType']").val();
		var SNS_ID = $(opener.document).find("#snshiddenForm input[name='SNS_ID']").val();
		var SNS_NICKNAME = $(opener.document).find("#snshiddenForm input[name='SNS_NICKNAME']").val();
		var SNS_EMAIL = $(opener.document).find("#snshiddenForm input[name='SNS_EMAIL']").val();
		var access_token = $(opener.document).find("#snshiddenForm input[name='access_token']").val();
		var MEMBER_VERIFY = $(opener.document).find("#snshiddenForm input[name='MEMBER_VERIFY']").val();
		
		// 이메일을 받았다면 받은 이메일로 입력되도록!
		if(SNS_EMAIL != null && SNS_EMAIL != "") {
			$("#MEMBER_EMAIL").val(SNS_EMAIL);
		}
		
		$("#snsjoinForm").submit(function(e) {
			e.preventDefault();
			
			var MEMBER_EMAIL = $(this).find("#MEMBER_EMAIL").val();
			var MEMBER_NAME = $(this).find("#MEMBER_NAME").val();
			var MEMBER_NICKNAME = $(this).find("#MEMBER_NICKNAME").val();
			var MEMBER_GENDER = $(this).find("#MEMBER_GENDER").val();
			
			$(opener.document).find("#snsjoinhiddenForm input[name='snsType']").val(snsType);
			$(opener.document).find("#snsjoinhiddenForm input[name='MEMBER_VERIFY']").val(MEMBER_VERIFY);
			$(opener.document).find("#snsjoinhiddenForm input[name='MEMBER_EMAIL']").val(MEMBER_EMAIL);
			$(opener.document).find("#snsjoinhiddenForm input[name='MEMBER_NAME']").val(MEMBER_NAME);
			$(opener.document).find("#snsjoinhiddenForm input[name='MEMBER_NICKNAME']").val(MEMBER_NICKNAME);
			$(opener.document).find("#snsjoinhiddenForm input[name='MEMBER_GENDER']").val(MEMBER_GENDER);
			$(opener.document).find("#snsjoinhiddenForm input[name='SNS_ID']").val(SNS_ID);
			$(opener.document).find("#snsjoinhiddenForm input[name='SNS_NICKNAME']").val(SNS_NICKNAME);
			$(opener.document).find("#snsjoinhiddenForm input[name='access_token']").val(access_token);
			
			$(opener.document).find("#snsjoinhiddenForm").submit();
			
			close();
			
			// 로그인 체크 아쟉스 구현해야됨!!!!!!!!!!!!!
			/* $.ajax({

				type : "POST",
				url : "",
				data : {
					MEMBER_VERIFY : MEMBER_VERIFY,
					MEMBER_EMAIL : MEMBER_EMAIL,
					MEMBER_NAME : MEMBER_NAME,
					MEMBER_NICKNAME : MEMBER_NICKNAME,
					MEMBER_GENDER : MEMBER_GENDER,
					
					snsType : snsType,
					SNS_ID : SNS_ID,
					SNS_NICKNAME : SNS_NICKNAME,
					access_token : access_token
				},
				dataType : "JSON",

				success : function(args) {
					alert("SNS 회원가입 성공");
				},

				error : function(request, status, error) {
					alert("통신 실패");
					alert("code : " + request.status
							+ "\n" + "message : "
							+ request.responseText
							+ "\n" + "error : " + error);
				}
			}) */
		});
	});

</script>

<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div>
		<!-- 사용자에게 입력받는 form -->
		<form id="snsjoinForm" method="post" action="/SINGLE/member/snsjoin.do">
			<div>
				<input type="hidden" id="MEMBER_VERIFY" name="MEMBER_VERIFY">
			</div>
		
			<div>
				<label for="MEMBER_EMAIL">이메일</label>
			</div>
			<div>
			    <input type="text" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="example@example.com" autofocus autocomplete="off" required />
			</div>
			<div class="check_font" id="email_check"></div><!-- 경고문이 들어갈 공간 -->

			<div>
				<label for="MEMBER_NAME">이름</label>
			</div>
			<div>
				<input type="text" id="MEMBER_NAME" name="MEMBER_NAME" placeholder="이름" autocomplete="off" required/>
			</div>
			
			<div>
				<label for="MEMBER_NICKNAME">닉네임</label>
			</div>
			<div>
				<input type="text" id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" placeholder="별명" autocomplete="off" required/>
			</div>
			<div class="check_font" id="nick_check"></div>
			
			<div>
				<label for="MEMBER_GENDER">성별</label>
			</div>
			<div>
				<input type="radio" id="MEMBER_GENDER" name="MEMBER_GENDER" value="M">남자
				<input type="radio" id="MEMBER_GENDER" name="MEMBER_GENDER" value="F">여자
			</div>

			<input type="submit" value="가입">
		</form>		
	</div>

</body>
</html>