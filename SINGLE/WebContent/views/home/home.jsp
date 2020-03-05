<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %> 

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="sessionLoginMember" value="${sessionScope.loginMember }"></c:set>
<c:set var="sessionLoginKakao" value="${sessionScope.loginKakao }"></c:set>
<c:set var="sessionLoginNaver" value="${sessionScope.loginNaver }"></c:set>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>SINGLE</title>

<!-- START :: 로그인 상태일 때 이 화면으로 오면 안되기 때문 -->
<c:if test="${not empty sessionLoginMember || not empty sessionLoginKakao || not empty sessionLoginNaver }">
	<jsp:forward page="/main/mainpage.do"></jsp:forward>
</c:if>
<!-- END :: 로그인 상태일 때 이 화면으로 오면 안되기 때문 -->

<!-- START :: CSS -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link href="/SINGLE/resources/css/master.css" rel="stylesheet" type="text/css">
<style type="text/css">
	
	body {
		background: #F5F5F5;
	}
	
	.container {
		height: auto;
		background: white;
		min-width: 300px;
		max-width: 520px;
		padding: 50px;
		margin-top: 180px;
		box-shadow: 5px 5px 5px #999;
		border: 10px solid #46b8da;
		border-radius: 5px;
	}
	
	.join-link {
		margin-top: 10px;
	}
	
	#kakao-login-btn {
		width: 185px;
		margin-right: 15px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript" src="/SINGLE/resources/js/RSA/rsa.js"></script>
<script type="text/javascript" src="/SINGLE/resources/js/RSA/jsbn.js"></script>
<script type="text/javascript" src="/SINGLE/resources/js/RSA/prng4.js"></script>
<script type="text/javascript" src="/SINGLE/resources/js/RSA/rng.js"></script>

<script type="text/javascript">

	$(function() {
		var rsa = new RSAKey();
		rsa.setPublic("${modulus}", "${exponent}");
		
		$("#loginForm").submit(function(e) {
			e.preventDefault();
			
			var MEMBER_EMAIL = $(this).find("#MEMBER_EMAIL").val();
			var MEMBER_PASSWORD = $(this).find("#MEMBER_PASSWORD").val();
			
			// hidden form에 사용자가 입력한 값 셋팅
			var hidden_MEMBER_EMAIL = $("#loginhiddenForm input[name='MEMBER_EMAIL']").val(MEMBER_EMAIL);
			var hidden_MEMBER_PASSWORD = $("#loginhiddenForm input[name='MEMBER_PASSWORD']").val(rsa.encrypt(MEMBER_PASSWORD)); // 비밀번호 암호화
			
			// 로그인 체크
			$.ajax({
				type: "POST",
				url: "/SINGLE/member/login.do",
				data: {
					MEMBER_EMAIL : hidden_MEMBER_EMAIL.val(),
					MEMBER_PASSWORD : hidden_MEMBER_PASSWORD.val()
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) { // 로그인 성공
						location.href = "/SINGLE/main/mainpage.do";
					} else {	// 로그인 실패
						$("#login_check").text("아이디 또는 비밀번호를 확인해주세요.");
						$("#login_check").attr("style","color:red");
					}
				},
				error: function(request, status, error) {
					alert("로그인 통신 실패");
					alert("code : " + request.status
							+ "\n" + "message : "
							+ request.responseText
							+ "\n" + "error : " + error);
				}
			});
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<div class="text-info text-center form-group">
			<p style="color:#46b8da; font-weight: 1000; font-size: 30pt;">로그인
			<p style="color:gray;">SINGLE에 오신 것을 환영합니다.
		</div>
		
		<!-- 사용자에게 입력받는 form -->
		<form id="loginForm" action="/SINGLE/member/login.do" method="post">
			<div class="form-group">
				<label for="MEMBER_EMAIL">이메일</label>
				<input type="text" class="form-control" id="MEMBER_EMAIL" name="MEMBER_EMAIL" placeholder="example@example.com">
			</div>
			<div class="form-group">
				<label for="MEMBER_PASSWORD">비밀번호</label>
				<a href="/SINGLE/member/pwResetpage.do" style="color: #46b8da; font-size:8pt; float: right;">비밀번호 재설정</a>
				<input type="password" class="form-control" id="MEMBER_PASSWORD" name="MEMBER_PASSWORD" placeholder="">
				<div class="check_font" id="login_check"></div><!-- 경고문이 들어갈 공간 -->
			</div>
			<button type="submit" class="btn btn-info btn-block">로그인</button>		
		</form>
		
		<div class="join-link">
			<p style="color: gray; font-size: 10pt;">아직 계정이 없으신가요?
			<a href="/SINGLE/member/joinpage.do" style="color: #46b8da; font-size: 9pt;">계정 만들기 ></a>
		</div>
		
		<!-- START :: SNS 로그인 버튼 -->
		<!-- SNS 로그인 -->
		<span id="kakao-login-btn"></span><span id="naver_id_login"></span>
		<!-- END :: SNS 로그인 버튼 -->
	</div>
		
	<!-- START :: 웹 로그인 시 실제 서버로 전송되는 form -->
	<form action="/SINGLE/member/login.do" method="post" id="loginhiddenForm">
		<input type="hidden" name="MEMBER_EMAIL">
		<input type="hidden" name="MEMBER_PASSWORD">
	</form>
	<!-- END :: 웹 로그인 시 실제 서버로 전송되는 form -->
		
	<!-- START :: SNS 로그인 시 실제로 전송되는 form -->
	<form action="/SINGLE/member/snslogin.do" method="post" id="snsloginhiddenForm">
		<input type="hidden" name="snsType">
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="access_token">
	</form>
	<!-- END :: SNS 로그인 시 실제로 전송되는 form -->
		
	<!-- START :: SNS 회원가입 이력이 없을 때 -->
	<!-- SNS 회원가입시 팝업창으로 전송되는 form -->		
	<form action="/SINGLE/user/join.do" method="post" id="snshiddenForm">
		<input type="hidden" name="snsType">
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="SNS_NICKNAME">
		<input type="hidden" name="SNS_EMAIL">
		<input type="hidden" name="access_token">
		<input type="hidden" name="MEMBER_VERIFY" value="2">
	</form>
		
	<!-- 팝업창에서 전송된 form -->
	<form action="/SINGLE/member/snsjoin.do" method="post" id="snsjoinhiddenForm">
		<input type="hidden" name="snsType">
		<input type="hidden" name="MEMBER_VERIFY" value="2">
		<input type="hidden" name="MEMBER_EMAIL">
		<input type="hidden" name="MEMBER_NAME">
		<input type="hidden" name="MEMBER_NICKNAME">
		<input type="hidden" name="MEMBER_GENDER">
		<input type="hidden" name="SNS_ID">
		<input type="hidden" name="SNS_NICKNAME">
		<input type="hidden" name="SNS_EMAIL">
		<input type="hidden" name="access_token">
	</form>
	<!-- END :: SNS 회원가입 이력이 없을 때 -->

</body>

<script type='text/javascript'>

	/*
	*	카카오 로그인
	*/

	Kakao.init('e279f4719a19c18fde6278302eaeb6d8');
    // 카카오 로그인 버튼 생성
    Kakao.Auth.createLoginButton({
    	container: '#kakao-login-btn',
        success: function(authObj) {
        	Kakao.API.request({
           		url:'/v2/user/me',
           		success:function(res) {
            		console.log(res.id);
            		console.log(res.properties.nickname);
            		console.log(res.kaccount_email);
            		console.log(authObj.access_token);

            		$.ajax({
            			type : "POST",
            			url : "/SINGLE/member/snschk.do",
            			data : {
            				KAKAO_ID : res.id,
            				snsType : "KAKAO"
            			},
            			dataType : "JSON",
            			success : function(msg) {
            				if(msg.result == 1) {	// 가입한 회원 -> 바로 로그인
            					alert("이미 카카오로 가입한 회원입니다.");
            				
            					$("#snsloginhiddenForm input[name='snsType']").val("KAKAO");
                        		$("#snsloginhiddenForm input[name='SNS_ID']").val(res.id);
                        		$("#snsloginhiddenForm input[name='access_token']").val(authObj.access_token);
            					
                        		$("#snsloginhiddenForm").submit();
                        		
            				} else {	// 회원가입 팝업 띄우고 회원가입 진행
            					alert("가입 이력이 없습니다. 회원가입을 진행합니다.");
            				
            					// snshiddenForm에 value값 셋팅
                        		$("#snshiddenForm input[name='snsType']").val("KAKAO");
                        		$("#snshiddenForm input[name='SNS_ID']").val(res.id);
                        		$("#snshiddenForm input[name='SNS_NICKNAME']").val(res.properties.nickname);
                        		$("#snshiddenForm input[name='SNS_EMAIL']").val(res.kaccount_email);
                        		$("#snshiddenForm input[name='access_token']").val(authObj.access_token);
                        		
                        		var url = "/SINGLE/views/member/snsjoin.jsp";
                        		var title = "";
                        		var prop = "top=200px,left=600px,width=600px,height=650px";
                        		window.open(url, title, prop);
            				}
            			},
            			error : function() {
            				alert("통신 실패");
            			}
            		})
            	}
            });
          },
          fail: function(err) {
             alert(JSON.stringify(err));
          }
		});
    
	    /*
	      	네이버 로그인
		*/
		var naver_id_login = new naver_id_login("tl7_MvP2GoSrA_PE_reP",
				"http://localhost:8090/SINGLE/views/member/navercallback.jsp");

		var state = naver_id_login.getUniqState();

		naver_id_login.setButton("green", 3, 40);
		naver_id_login.setDomain("http://localhost:8090/SINGLE");
		naver_id_login.setState(state);
		naver_id_login.setPopup();
		naver_id_login.init_naver_id_login();		

</script>

</html>