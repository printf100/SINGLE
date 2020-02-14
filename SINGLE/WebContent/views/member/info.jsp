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
<title>회원정보</title>

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

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<h1>회원정보</h1>
	
	<div id="container">
		<div id="side-menu">
			<div>
				<a href="/SINGLE/member/profilepage.do">프로필</a>
			</div>
			<div>
				<a href="/SINGLE/member/infopage.do">회원정보</a>
			</div>
			<!-- 사이트로 가입한 회원일 때만 보여주기 -->
			<c:if test="${not empty sessionLoginMember }">
				<div>
					<a href="/SINGLE/member/pwpage.do">비밀번호</a>
				</div>
			</c:if>
		</div>
	
		<div id="mypage-detail">
			<div>
				<label for="MEMBER_EMAIL">이메일</label>
			</div>
			<div>
				<input type="text" value="${info.MEMBER_EMAIL }" disabled="disabled">
			</div>
			<div style="color: gray; font-size: 8pt;">
				이메일은 수정할 수 없습니다.
			</div>

			<div>
				<label for="MEMBER_NAME">이름</label>
			</div>
			<div>
				<input type="text" id="MEMBER_NAME" name="MEMBER_NAME" value="${info.MEMBER_NAME }" required="required">
			</div>
			
			<div>
				<label for="MEMBER_GENDER">성별</label>
			</div>
			<div>
				<div>
					<input type="radio" name="MEMBER_GENDER" value="M" required="required" <c:if test="${info.MEMBER_GENDER eq 'M'}">checked="checked"</c:if>/>남자
				</div>
				<div>
					<input type="radio" name="MEMBER_GENDER" value="F" required="required" <c:if test="${info.MEMBER_GENDER eq 'F'}">checked="checked"</c:if>/>여자
				</div>
			</div>
			
			<div>
				<a href="SINGLE/member/infoUpdatepage.do">변경 사항 저장</a>
			</div>
		</div>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>