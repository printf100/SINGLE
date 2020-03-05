<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.single.model.dto.map.FoodDto" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head> 
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String x = (String)request.getAttribute("x");
	String y = (String)request.getAttribute("y");
%>


	<form action="/SINGLE/food/foodUpload.do" method="POST" enctype="multipart/form-data">
		<input type = "hidden" name="x" value="<%=x%>">
		<input type = "hidden" name="y" value="<%=y%>">
		<input type = "hidden" name="member_code" value="${member_code }">
	<table>
		<tr>
			<td>식재료이름 <input type="text" name ="food_name" id="food_name" value="양배추"/></td>
		</tr> 
		<tr>
			<td>내용 <textarea name="food_content"></textarea></td>
		</tr>
		<tr>
			<td>이미지<input type="file" name="file"></td>
		</tr> 
		<tr>
			<td><input type="submit" value="업로드"></td>
		</tr>
		 
	</table> 
	</form>
</body> 
</html> 