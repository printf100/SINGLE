<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.single.model.dto.map.FoodDto"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<meta charset="UTF-8">
<title>SINGLE</title>
<style>
/* The Modal (background) */
.modal2 {
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.modal-content2 {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 100%; /* Could be more or less, depending on screen size */
}

.filebox input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0;
}

.filebox label {
	display: inline-block;
	padding: .5em .75em;
	color: #999;
	font-size: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}

/* named upload */
.filebox .upload-name {
	display: inline-block;
	padding: .5em .75em;
	font-size: inherit;
	font-family: inherit;
	line-height: normal;
	vertical-align: middle;
	background-color: #f5f5f5;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.filebox.bs3-primary label {
	color: #fff;
	background-color: #337ab7;
	border-color: #2e6da4;
}
</style>
</head>
<body>
	<script>
		$(function() {

			$("#MARKER_CODE")
					.val($(opener.document).find("#MARKER_CODE").val());
			$("#IMAGE_NAME").val($(opener.document).find("#IMAGE_NAME").val());
			$("#FOOD_NAME").val($(opener.document).find("#FOOD_NAME").val());
			$("#FOOD_CONTENT").val(
					$(opener.document).find("#FOOD_CONTENT").val());
			1

		});

		$(document).ready(
				function() {
					var fileTarget = $('.filebox .upload-hidden');

					fileTarget.on('change', function() {
						if (window.FileReader) {
							var filename = $(this)[0].files[0].name;
						} else {
							var filename = $(this).val().split('/').pop()
									.split('\\').pop();
						}

						$(this).siblings('.upload-name').val(filename);
					});
				});

		function goOpener() {
			opener.name = "update";
			document.frmName.target = opener.name;
			document.frmName.action = "/SINGLE/food/myFoodUpdateRes.do";
			document.frmName.submit();
			self.close();
		}
	</script>


	<div id="myModal" class="modal2">

		<!-- Modal content -->
		<div class="modal-content2">
			<p style="text-align: center;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 15pt;">식재료를 등록해주세요</span></b></span>
			</p>
			<form action="/SINGLE/food/myFoodUpdateRes.do" method="POST"
				enctype="multipart/form-data">
				<input type="hidden" id="MARKER_CODE" name="marker_code">

				<div class="wrapper">
					<p>식재료 이름</p>
					<input type="text" class="form-control" name="food_name"
						id="FOOD_NAME" />
					<p>내용</p>

					<textarea class="form-control" name="food_content"
						id="FOOD_CONTENT"></textarea>
					<p>이미지</p>
					<div class="filebox bs3-primary">
						<input class="upload-name" id="IMAGE_NAME" disabled="disabled">
						<label for="ex_filename">업로드</label> <input type="file"
							id="ex_filename" class="upload-hidden" name="file"
							accept=".jpg,.jpeg,.png">
					</div>
					<p></p>
					<button class="btn btn-lg btn-info btn-block" onClick="goOpener();">수정</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
