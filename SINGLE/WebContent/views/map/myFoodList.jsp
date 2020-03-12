<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.single.model.dto.map.FoodDto"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<%@include file="/views/form/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SINGLE</title>

<style>
table {
	width: 60%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>
	<%
		List<FoodDto> foodList = (List<FoodDto>) request.getAttribute("foodList");
	%>


	<div style="padding-top: 100px;">
		<table>
			<thead>
				<tr>
					<th>음식사진</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>

			<%
				for (int i = 0; i < foodList.size(); i++) {
			%>
			<tbody>
				<tr>
					<td><img
						src="${pageContext.request.contextPath}/resources/images/uploadImg/<%=foodList.get(i).getFood_image_name()%>"
						width="100px" height="100px"></td>
					<td><%=foodList.get(i).getFood_name()%></td>
					<td><%=foodList.get(i).getFood_content()%></td>
					<td><%=foodList.get(i).getMember_name()%></td>
					<td><input type="button" value="수정"
						onClick="window.open('/SINGLE/f	ood/myFoodUpdate.do?marker_code='+<%=foodList.get(i).getMarker_code()%>, height=1000, width=1000)">
					</td>
					<td><input type="button" value="삭제"
						onClick="location.href('/SINGLE/food/myFoodDelete.do?marker_code='+<%=foodList.get(i).getMarker_code()%>">
					</td>
				</tr>

				<%
					}
				%>

			</tbody>

		</table>
	</div>
</body>
</html>