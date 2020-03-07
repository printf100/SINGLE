package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.single.model.biz.map.FoodBiz;
import com.single.model.biz.map.FoodBizImpl;
import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;

@WebServlet( //
		name = "food", //
		urlPatterns = { //
				"foodUpload.do", // 식재료 등록
				"foodList.do", // 지도 내 식재료 리스트
				"MyFoodList.do", // 내 식재료 리스트
				"myFoodUpdate.do", // 식재료 수정 폼 이동
				"myFoodUpdateRes.do", // 식재료 수정
				"myFoodDelete.do" // 식재료 삭제
		})

public class FoodController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	FoodBiz biz = new FoodBizImpl();

	HttpSession session;

	MemberBiz mbiz = new MemberBizImpl();

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/foodUpload.do")) {
			foodUpload(request, response);
		}

		else if (command.endsWith("/foodList.do")) {
			foodList(request, response);
		}

		else if (command.endsWith("/myFoodUpdate.do")) {
			selectOneFood(request, response);
		}

		else if (command.endsWith("/myFoodUpdateRes.do")) {
			foodUpdate(request, response);
		}

		else if (command.endsWith("/myFoodDelete.do")) {
			myFoodDelete(request, response);
		}
	}

	// 식재료 삭제
	private void myFoodDelete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int marker_code = Integer.parseInt(request.getParameter("marker_code"));

		int res = biz.delete(marker_code);

		System.out.println(marker_code);

		if (res > 0) {
			jsResponse("삭제 완료", "/SINGLE/food/foodList.do", response);
		} else {
			jsResponse("삭제 실패", "/SINGLE/food/foodList.do", response);
		}

	}

	// 식재료 수정
	private void foodUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		FoodDto dto = new FoodDto();

		String uploadDir = this.getClass().getResource("").getPath();

		uploadDir = uploadDir.substring(1, uploadDir.indexOf(".metadata"))
				+ "/SINGLE/WebContent/resources/images/uploadImg";

		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding,
				new DefaultFileRenamePolicy());

		String food_image_name = multipartRequest.getOriginalFileName("file");
		String food_image_realname = multipartRequest.getFilesystemName("file");
		String food_name = multipartRequest.getParameter("food_name");
		String food_content = multipartRequest.getParameter("food_content");
		int marker_code = Integer.parseInt(multipartRequest.getParameter("marker_code"));

		dto.setMarker_code(marker_code);
		dto.setFood_name(food_name);
		dto.setFood_content(food_content);
		dto.setFood_image_name(food_image_name);
		dto.setFood_image_realname(food_image_realname);

		int res = biz.update(dto);

		if (res > 0) {
			PrintWriter out = response.getWriter();

			out.println("<script type='text/javascript'>");
			out.println("alert('수정완료')");
			out.println("opener.window.location.reload();");
			out.println("self.close();");
			out.println("</script>");
		} else {
			jsResponse("수정 실패", "/SINGLE/food/foodList.do", response);
		}

	}

	// 식재료 SelectOne
	private void selectOneFood(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int marker_code = Integer.parseInt(request.getParameter("marker_code"));

		FoodDto dto = biz.selectFood(marker_code);

		request.setAttribute("dto", dto);

		dispatch("/views/map/foodUpdate.jsp", request, response);
	}

	// 지도 내 식재료 리스트
	private void foodList(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
		KakaoMemberDTO loginKakao = (KakaoMemberDTO) session.getAttribute("loginKakao");
		NaverMemberDTO loginNaver = (NaverMemberDTO) session.getAttribute("loginNaver");

		int MEMBER_CODE = 0;

		if (session.getAttribute("loginMember") != null) {
			MEMBER_CODE = loginMember.getMEMBER_CODE();
		}

		if (session.getAttribute("loginKakao") != null) {
			MEMBER_CODE = loginKakao.getMEMBER_CODE();
		}

		if (session.getAttribute("loginNaver") != null) {
			MEMBER_CODE = loginNaver.getMEMBER_CODE();
		}

		request.setAttribute("member_code", MEMBER_CODE);

		List<FoodDto> foodList = biz.foodList();

		List<FoodDto> myFoodList = biz.MyFoodList(MEMBER_CODE);

		request.setAttribute("myFoodList", myFoodList);
		request.setAttribute("foodList", foodList);

		dispatch("/views/map/foodMap.jsp", request, response);
	}

	// 식재료 등록
	private void foodUpload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		FoodDto dto = new FoodDto();
		String uploadDir = this.getClass().getResource("").getPath();

		uploadDir = uploadDir.substring(1, uploadDir.indexOf(".metadata"))
				+ "/SINGLE/WebContent/resources/images/uploadImg";

		int maxSize = 1024 * 1024 * 100;
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, uploadDir, maxSize, encoding,
				new DefaultFileRenamePolicy());

		int member_code = Integer.parseInt(multipartRequest.getParameter("member_code"));
		String food_image_name = multipartRequest.getOriginalFileName("file");
		String food_image_realname = multipartRequest.getFilesystemName("file");
		String food_name = multipartRequest.getParameter("food_name");
		String food_content = multipartRequest.getParameter("food_content");
		String food_x = multipartRequest.getParameter("x");
		String food_y = multipartRequest.getParameter("y");

		dto.setMember_code(member_code);
		dto.setFood_name(food_name);
		dto.setFood_content(food_content);
		dto.setFood_x(food_x);
		dto.setFood_y(food_y);
		dto.setFood_image_name(food_image_name);
		dto.setFood_image_realname(food_image_realname);

		int res = biz.foodInsert(dto);

		if (res > 0) {
			jsResponse("식재료 등록 성공", "/SINGLE/food/foodList.do", response);
		} else {
			jsResponse("식재료 등록 실패", "/SINGLE/food/foodList.do", response);
		}

	}

	/*
	 * Servlet Basic Template : PLEASE DO NOT MODIFY !!!!!
	 */
	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	private void jsResponse(String msg, String url, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("alert('" + msg + "')");
		out.println("location.href='" + url + "'");
		out.println("</script>");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		processRequest(request, response);
	}

}