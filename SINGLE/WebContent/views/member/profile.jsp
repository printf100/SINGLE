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
<title>회원프로필</title>

<!-- START :: CSS -->
<style type="text/css">

	#container {
		height: 100%;
	}
	
	#side-menu {
		position: relative;
		float: left;
		border: 1px solid green;
	}
	
	#mypage-detail {
		position: relative;
		margin-left: 150px;
	}
	
	#PROFILE_BOX {
		width: 100px;
		height: 100px;
		border-radius: 30%;
		overflow: hidden;
	}
	
	#PROFILE_IMG {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<h1>회원프로필</h1>

	<div id="container">
		<div id="side-menu">
			<div>
				<a href="/SINGLE/member/profilepage.do">프로필 정보</a>
			</div>
			<div>
				<a href="/SINGLE/member/infopage.do">회원 정보</a>
			</div>
			<!-- 사이트로 가입한 회원일 때만 보여주기 -->
			<c:if test="${not empty sessionLoginMember }">
				<div>
					<a href="/SINGLE/member/pwpage.do">비밀번호</a>
				</div>
			</c:if>
		</div>
	
		<form action="/SINGLE/member/profileUpdate.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="MEMBER_CODE" value="${profile.MEMBER_CODE }">
			
			<div id="mypage-detail">
				<div>
					<label for="MPROFILE_IMG_NAME">프로필 이미지</label>
				</div>
				<div id="PROFILE_BOX">
					<input type="file" id="MPROFILE_IMG_NAME" name="MPROFILE_IMG_NAME" style="display: none;" value="${profile.MPROFILE_IMG_NAME }">
					<img id="PROFILE_IMG" alt="프로필 사진" src="../resources/images/profileupload/${profile.MPROFILE_IMG_SERVERNAME}" onclick="$('#MPROFILE_IMG_NAME').click();">
				</div>
				
				<div>
					<label for="MEMBER_NICKNAME">닉네임</label>
				</div>
				<div>
					<input type="text" id="MEMBER_NICKNAME" name="MEMBER_NICKNAME" value="${profile.MEMBER_NICKNAME }" required="required">
				</div>
				
				<div>
					<label for="MPROFILE_INTRODUCE">상태메세지</label>
				</div>
				<div>
					<input type="text" id="MPROFILE_INTRODUCE" name="MPROFILE_INTRODUCE" value="${profile.MPROFILE_INTRODUCE }">
				</div>
				
				<div>
					<label for="MPROFILE_LATITUDE">위도</label>
				</div>
				<div>
					<input type="text" id="MPROFILE_LATITUDE" name="MPROFILE_LATITUDE" value="${profile.MPROFILE_LATITUDE }">
				</div>
				
				<div>
					<label for="MPROFILE_LONGITUDE">경도</label>
				</div>
				<div>
					<input type="text" id="MPROFILE_LONGITUDE" name="MPROFILE_LONGITUDE" value="${profile.MPROFILE_LONGITUDE }">
				</div>
				
				<div>
					<input type="submit" value="변경사항 저장">
				</div>	
			</div>
		</form>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>