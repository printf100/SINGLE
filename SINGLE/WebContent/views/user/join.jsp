<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<!-- START :: css -->
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<!-- END :: css -->

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
		
		<!-- 카카오 로그인 -->
		<div>
			<a id="kakao-login-btn"></a>
			<a type="button" onclick="kakaologout()">카카오톡 로그아웃</a>
			<a href="https://developers.kakao.com/logout">완전로그아웃</a>
		</div>
		
		<!-- 사용자에게 입력받는 form -->
		<form id="joinForm" method="post" action="/SINGLE/member/join.do">
			<div>
				<label for="MEMBER_VERIFY">회원구분</label>
			</div>
			<div>
				<input type="radio" name="MEMBER_VERIFY" value="2">일반회원
				<input type="radio" name="MEMBER_VERIFY" value="3">업체
			</div>
			
			<div>
				<label for="MEMBER_EMAIL">이메일</label>
			</div>
			<div>
			    <input type="text" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="example@example.com" autofocus autocomplete="off" required />
			</div>
			<div class="check_font" id="email_check"></div><!-- 경고문이 들어갈 공간 -->

			<div>
				<label for="MEMBER_PASSWORD">비밀번호</label>
			</div>
			<div>
			    <input type="password" id="MEMBER_PASSWORD" name="MEMBER_PASSWORD" placeholder="" autocomplete="off" required />
			</div>
			
			<div>
				<label for="PASSWORD">비밀번호 확인</label>
			</div>
			<div>
			    <input type="password" id="PW_CONFIRM" placeholder="" autocomplete="off" required />
			</div>
			<div class="check_font" id="pw_check"></div><!-- 경고문이 들어갈 공간 -->

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
				<input type="radio" name="MEMBER_GENDER" value="M">남자
				<input type="radio" name="MEMBER_GENDER" value="F">여자
			</div>

			<input type="submit" value="가입">
			<input type="button" onclick="location.href='/SINGLE/home/home.do'" value="취소">
		</form>
		
		<!-- SNS 회원가입시 팝업창으로 전송되는 form (SNS 회원가입은 무조건 일반회원으로 가입) -->
		<form action="/SINGLE/user/join.do" method="post" id="snshiddenForm">
			<input type="hidden" name="snsType">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="SNS_NICKNAME">
			<input type="hidden" name="SNS_EMAIL">
			<input type="hidden" name="access_token">
			<input type="hidden" name="MEMBER_VERIFY" value="2">
		</form>
		
		<!-- 팝업창에서 전송되는 form -->
		<form action="/SINGLE/member/snsjoin.do" method="post" id="snsjoinhiddenForm">
			<input type="hidden" name="snsType">
			<input type="hidden" name="MEMBER_VERIFY">
			<input type="hidden" name="MEMBER_EMAIL">
			<input type="hidden" name="MEMBER_NAME">
			<input type="hidden" name="MEMBER_NICKNAME">
			<input type="hidden" name="MEMBER_GENDER">
			<input type="hidden" name="SNS_ID">
			<input type="hidden" name="SNS_NICKNAME">
			<input type="hidden" name="SNS_EMAIL">
			<input type="hidden" name="access_token">
		</form>
		
	</div>
</body>

	<script type='text/javascript'>
      //<![CDATA[
        // 사용할 앱의 JavaScript 키를 설정해 주세요.
        Kakao.init('e279f4719a19c18fde6278302eaeb6d8');
        // 카카오 로그인 버튼을 생성합니다.
        Kakao.Auth.createLoginButton({
          container: '#kakao-login-btn',
          success: function(authObj) {
            alert(JSON.stringify(authObj));
            Kakao.API.request({
            	url:'/v1/user/me',
            	success:function(res) {
            		alert(JSON.stringify(res));
            		console.log(res.id);
            		console.log(res.properties.nickname);
            		console.log(res.kaccount_email);
            		//console.log(res.kakao_account.gender);
            		console.log(authObj.access_token);

            		// snshiddenForm에 value값 셋팅
            		$("#snshiddenForm input[name='snsType']").val("KAKAO");
            		$("#snshiddenForm input[name='SNS_ID']").val(res.id);
            		$("#snshiddenForm input[name='SNS_NICKNAME']").val(res.properties.nickname);
            		$("#snshiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
            		$("#snshiddenForm input[name='access_token']").val(authObj.access_token);
            		
            		var url = "/SINGLE/views/user/snsjoin.jsp";
            		var title = "";	// blank -> url이 새로운 창으로 띄워지게 함
            		var prop = "top=200px,left=600px,width=500px,height=500px";
            		window.open(url, title, prop);
            	}
            });
          },
          fail: function(err) {
             alert(JSON.stringify(err));
          }
        });
      //]]>
      
	      // 카카오톡 로그아웃
	      function kakaologout() {
	    	  Kakao.Auth.logout(function() {
	    		  setTimeout(function() {
	    			  location.href="/SINGLE/home/home.do";
	    		  }, 1000);
	    	  });
	      }
	    </script>
</html>