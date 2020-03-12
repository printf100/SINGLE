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

	.col-sm-3 {
		margin: 20px;
	}
	
	.list-group a {
		color: #263747;
	}
	
	.card-body {
		padding: 40px;
		padding-top: 20px;
		padding-bottom: 20px;
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
	
	.submit-btn {
		margin-top: 30px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#SUBMIT").click(function() {
			
			$.ajax({
				type: "POST",
				url: "/SINGLE/member/infoUpdate.do",
				data: {
					MEMBER_CODE : $("input[name='MEMBER_CODE']").val(),
					MEMBER_NAME : $("#MEMBER_NAME").val(),
					MEMBER_GENDER : $("input:radio[name='MEMBER_GENDER']:checked").val()
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("회원 정보 수정이 완료되었습니다.");
					} else {
						alert("회원 정보 수정을 실패하였습니다.");
					}
				},
				error: function() {
					alert("회원정보 수정 통신 실패");
				}
			});
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<div class="row">
			
			<!-- 왼쪽 메뉴 바 -->
			<div id="side-menu" class="col-sm-3">
				<ul class="list-group">
					<li class="list-group-item list-group-item-action">
						<a class="nav-link active" href="/SINGLE/member/profilepage.do">프로필 정보</a>
			        </li>
			        <li class="list-group-item list-group-item-action">
			        	<a class="nav-link" href="/SINGLE/member/infopage.do">회원 정보</a>
			        </li>
			        <!-- 사이트로 가입한 회원일 때만 보여주기 -->
					<c:if test="${not empty sessionLoginMember }">
			        <li class="list-group-item list-group-item-action">
			        	<a class="nav-link" href="/SINGLE/member/pwpage.do">비밀번호</a>
			        </li>
			        </c:if>
			     </ul>
			</div>
	
			<!-- 콘텐츠 -->
			<div id="mypage-detail" class="col-sm-8">
				<p style="font-size: 25pt;"><strong>회원정보</strong>
					
				<div class="card">
					<div class="card-body">
						<form>
							<input type="hidden" name="MEMBER_CODE" value="${info.MEMBER_CODE }">
							
							<div class="form-group">
								<label class="required" for="MEMBER_EMAIL">이메일</label>
								<input type="text" class="form-control" value="${info.MEMBER_EMAIL }" disabled="disabled">
								<div style="color: #98A8B9; font-size: 9pt;">이메일은 수정할 수 없습니다.</div>
							</div>
				
							<div class="form-group">
								<label class="required" for="MEMBER_NAME">이름</label>
								<input type="text" class="form-control" id="MEMBER_NAME" name="MEMBER_NAME" value="${info.MEMBER_NAME }" required="required">
							</div>
							
							<div class="form-group">
								<label class="required">성별</label>
								<div class="form-check">
									<input type="radio" class="form-check-input" name="MEMBER_GENDER" value="M" required="required" <c:if test="${info.MEMBER_GENDER eq 'M'}">checked="checked"</c:if>/>
									<label class="form-check-label">남자</label>
								</div>
								<div class="form-check">
									<input type="radio" class="form-check-input" name="MEMBER_GENDER" value="F" required="required" <c:if test="${info.MEMBER_GENDER eq 'F'}">checked="checked"</c:if>/>
									<label class="form-check-label">여자</label>
								</div>
							</div>
						
							<div class="submit-btn form-group">
								<input type="button" class="btn btn-info btn-sm" id="SUBMIT" value="변경 사항 저장">
							</div>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>


<!-- START :: include footer -->
<%@include file="/views/form/footer.jsp" %>
<!-- END :: include footer -->

</body>
</html>