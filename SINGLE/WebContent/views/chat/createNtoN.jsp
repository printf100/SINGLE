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
<title>단체 채팅방 만들기</title>

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
	
	.submit-btn {
		text-align: center;
		margin-top: 30px;
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		var MY_MEMBER_CODE = $(opener.document).find("#MY_MEMBER_CODE").val();
		$("#MY_MEMBER_CODE").val(MY_MEMBER_CODE);
		
		$("#create").click(function() {
			
			$.ajax({
				type: "POST",
				url: "/SINGLE/chat/createNChatRoom.do",
				data: {
					CHATROOM_TITLE : $("#CHATROOM_TITLE").val(),
					CHATROOM_CHIEF_CODE : $("#MY_MEMBER_CODE").val()
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("방 만들기를 성공했어요!");
						var CHATROOM_CODE = $("#CHATROOM_CODE").val(msg.CHATROOM_CODE);
						
						// 채팅방 팝업창 띄우기
	 					var url = "/SINGLE/views/chat/nchatroom.jsp";
	 				    var title = "";
	 				    var prop = "top=200px,left=600px,width=500px,height=700px";
	 				    window.name = "createNtoN";		// 현재 창(부모창) 이름
	 				    window.open(url, title, prop);		// 자식 창 생성
	 				    
					} else {
						alert("방 만들기 실패");
					}
				},
				error: function() {
					alert("방 만들기 통신 실패");
				}
			});
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<div class="container">
		<div class="text-center">
			<p style="color:#46b8da; font-size: 20pt;"><strong>단체 채팅방 만들기</strong>
		</div>
		
		<form id="createForm">
			<div class="form-group">
				<label for="CHATROOM_TITLE">채팅방 제목</label>
				<input type="text" class="form-control form-control-sm" id="CHATROOM_TITLE" name="CHATROOM_TITLE" placeholder="채팅방 제목을 입력해주세요." required="required">
			</div>
			
			<input type="hidden" id="MY_MEMBER_CODE" name="MY_MEMBER_CODE" readonly="readonly">
	
			<div class="submit-btn">
				<button type="button" class="btn btn-outline-info" onclick="window.close();">취소</button>
				<button type="button" id="create" class="btn btn-info">방 만들기</button>		
			</div>
		</form>
	</div>
	
	<input type="hidden" id="CHATROOM_CODE">
	<input type="hidden" id="CHATROOM_MEMBER_COUNT" value="1">

</body>
</html>