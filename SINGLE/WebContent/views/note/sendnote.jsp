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
<title>Insert title here</title>

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
	}

</style>
<!-- END :: CSS -->

<!-- START :: JAVASCRIPT -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">

	$(function() {
		
		$("#NOTE_FROM_CODE").val($(opener.document).find("#MY_MEMBER_CODE").val());

		$("#NOTE_TO_CODE").val($(opener.document).find("#TO_MEMBER_CODE").val());
		$("#NOTE_TO_NICKNAME").val($(opener.document).find("#TO_MEMBER_NICKNAME").val());

		/*
		* 웹 소켓
		*/
		var ws = new WebSocket("ws://localhost:8090/SINGLE/websocket_note");
		
		// 웹 소켓이 연결됐을 때
		ws.onopen = function(e) {
		};
		
		// 웹 소켓 연결이 해제됐을 때
		ws.onclose = function(e) {
			alert("연결 해제됨");
		};
		
		// 웹 소켓 에러
		ws.onerror = function(e) {
			alert("error");
		};
		
		// 메세지가 온 경우
		ws.onmessage = function(e) {
			alert(e.data);
		};
		
		// 쪽지 전송하기
		$("#sendNote").click(function() {
			
			// 웹 소켓
			var obj = {};
			var jsonStr;
			
			obj.NOTE_FROM_CODE = $("#NOTE_FROM_CODE").val();
			obj.NOTE_TO_CODE = $("#NOTE_TO_CODE").val();
			obj.NOTE_TITLE = $("#NOTE_TITLE").val();
			obj.NOTE_CONTENT = $("#NOTE_CONTENT").val();
			jsonStr = JSON.stringify(obj);
			ws.send(jsonStr); // 전송
			
			$.ajax({
				type: "POST",
				url: "/SINGLE/note/sendNote.do",
				data: {
					NOTE_FROM_CODE : $("#NOTE_FROM_CODE").val(),
					NOTE_TO_CODE : $("#NOTE_TO_CODE").val(),
					NOTE_TITLE : $("#NOTE_TITLE").val(),
					NOTE_CONTENT : $("#NOTE_CONTENT").val()
				},
				dataType: "JSON",
				success: function(msg) {
					
					if(msg.result > 0) {
						alert("쪽지가 전송되었습니다.");
						close();
						
					} else {
						alert("쪽지 전송에 실패하였습니다.");
					}
				},
				error: function() {
					alert("메세지 전송 통신 실패");
				}
			});
			
		});
	});

</script>
<!-- END :: JAVASCRIPT -->

</head>
<body>

	<!-- START :: 전달받은 값 셋팅 -->
	<input type="hidden" id="NOTE_FROM_CODE">
	<input type="hidden" id="NOTE_TO_CODE">
	<!-- END :: 전달받은 값 셋팅 -->

	<div class="container">
	
		<div class="text-center">
			<p style="color:#46b8da; font-size: 20pt;"><strong>쪽지 쓰기</strong>
		</div>
		
		<div class="form-group">
			<label for="NOTE_TO_NICKNAME">받는 사람</label>
		    <input type="text" class="form-control form-control-sm" id="NOTE_TO_NICKNAME" name="NOTE_TO_NICKNAME" readonly="readonly" />
		</div>
		
		<div class="form-group">
			<label for="NOTE_TITLE">제목</label>
		    <input type="text" class="form-control form-control-sm" id="NOTE_TITLE" name="NOTE_TITLE" autofocus autocomplete="off" required="required" />
		</div>
		
		<div class="form-group">
			<label for="NOTE_CONTENT">내용</label>
		    <textarea class="form-control" rows="10" id="NOTE_CONTENT" name="NOTE_CONTENT" autofocus autocomplete="off" required="required"></textarea>
		</div>
		
		<div class="submit-btn">
			<button type="button" class="btn btn-outline-info" onclick="window.close();">취소</button>
			<button type="button" id="sendNote" class="btn btn-info">전송</button>		
		</div>
	</div>

</body>
</html>