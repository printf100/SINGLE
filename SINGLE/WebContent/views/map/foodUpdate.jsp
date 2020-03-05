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



	<form action="/SINGLE/food/myFoodUpdateRes.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="marker_code" value="${dto.marker_code }">
	<table>
		<tr>
			<td>식재료이름 <input type="text" name ="food_name" value="${dto.food_name }"></td>
		</tr>  
		
	
		<tr>
			<td>내용 <textarea name="food_content" placeholder="">${dto.food_content }</textarea></td>
		</tr>
		<tr>
			<td>이미지<input type="file" name="file" accept=".jpg,.jpeg,.png"></td>
		</tr>  
		<tr> 
			<td><input type="submit" value="수정하기"></td>
		</tr>
	</table> 
	</form>
</body> 
</html> 