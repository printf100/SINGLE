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

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

<script type="text/javascript">

	var naver_id_login = new naver_id_login("tl7_MvP2GoSrA_PE_reP", "http://localhost:8090/SINGLE/views/member/navercallback.jsp"); // 역시 마찬가지로 'localhost'가 포함된 CallBack URL
	
	// 접근 토큰 값 출력
	alert(naver_id_login.oauthParams.access_token);
	
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		alert(naver_id_login.getProfileData('id'));
	    alert(naver_id_login.getProfileData('email'));
	    alert(naver_id_login.getProfileData('name'));
	    
	    var uniqId = naver_id_login.getProfileData('id');
		var name = naver_id_login.getProfileData('name');
		var email = naver_id_login.getProfileData('email');
		console.log(uniqId);
		console.log(name);
		console.log(email);
		
		// NAVER 아이디 중복 체크
		$.ajax({
			type : "POST",
			url : "/SINGLE/member/snschk.do",
			data : {
				NAVER_ID : uniqId,
				snsType : "NAVER"
			},
			dataType : "JSON",
			success : function(msg) {
				if(msg.result > 0) {	// 가입한 회원 -> 바로 로그인
					alert("이미 네이버로 가입한 회원입니다.");
				
					$(opener.document).find("#snsloginhiddenForm input[name='snsType']").val("NAVER");
					$(opener.document).find("#snsloginhiddenForm input[name='SNS_ID']").val(uniqId);
					
					$(opener.document).find("#snsloginhiddenForm").submit();
            		
				} else {	// 회원가입 팝업 띄우고 회원가입 진행
					alert("가입 이력이 없습니다. 회원가입을 진행합니다.");
				
					// snshiddenForm에 value값 셋팅
            		$(opener.document).find("#snshiddenForm input[name='snsType']").val("NAVER");
            		$(opener.document).find("#snshiddenForm input[name='SNS_ID']").val(uniqId);
            		$(opener.document).find("#snshiddenForm input[name='SNS_NICKNAME']").val(name);
            		$(opener.document).find("#snshiddenForm input[name='SNS_EMAIL']").val(email);
            		
            		var url = "/SINGLE/views/member/snsjoin.jsp";
            		var title = "";
            		var prop = "top=200px,left=600px,width=500px,height=500px";
            		opener.window.open(url, title, prop);
				}
				close();
			},
			error : function() {
				alert("NAVER 아이디 중복 체크 통신 실패");
			}
		})
	}
	
</script>

</body>
</html>