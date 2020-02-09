<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<!-- START :: CSS -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- END :: JAVASCRIPT -->

</head>
<body>
	<div>
		<div>
			<a href="/SINGLE/main/mainpage.do">돌아가기</a>
		</div>

		<!-- 사용자에게 입력받는 form -->
		<form id="loginForm" action="/SINGLE/member/login.do" method="post">
			<div>
				<label for="MEMBER_EMAIL">이메일</label>
			</div>
			<div>
				<input type="text" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="example@example.com">
			</div>

			<div>
				<label for="MEMBER_PASSWORD">비밀번호</label>
			</div>
			<div>
				<input type="password" id="MEMBER_PASSWORD" name="MEMBER_PASSWORD" placeholder="">
			</div>

			<div class="check_font" id="login_check"></div><!-- 경고문이 들어갈 공간 -->

			<input type="submit" value="로그인">
		</form>

		<!-- 실제 서버로 전송되는 form -->
<!-- 		<form id=hiddenForm action="" method="post"> -->
<!-- 			<input type="hidden" name="USERID"/> -->
<!-- 			<input type="hidden" name="PASSWORD"/> -->
<!-- 		</form> -->
	</div>

</body>
</html>