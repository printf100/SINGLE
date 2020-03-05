package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.single.model.biz.clean.CleanBiz;
import com.single.model.biz.clean.CleanBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.model.dto.clean.CleanDTO;

/*
 * Clean Controller
 * 가사도우미, 빨래수거 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "life", //
		urlPatterns = { //
				"lifepage.do", // 빨래수거 메인으로 이동
				"address.do", // 주소 입력페이지로 이동
		})

public class CleanController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	CleanBiz biz = new CleanBizImpl();
	Logger logger = Logger.getLogger(CleanController.class.getName());

	public CleanController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		// life는 두 개의 기능이 있는데 시간관계상 clean페이지로 처리함.
		if (command.endsWith("/clean/lifepage.do")) {
			cleanpage(request, response);
		}

		else if (command.endsWith("/clean/address.do")) {
			inputAddress(request, response);
		}

		else if (command.endsWith("/clean/select.do")) {
			inputSelect(request, response);
		}

		else if (command.endsWith("/clean/pay.do")) {
			pay(request, response);
		} else if (command.endsWith("/clean/complete.do")) {
			complete(request, response);
		} else if (command.endsWith("/clean/cancel.do")) {
			cancel(request, response);
		} else if (command.endsWith("/clean/edit.do")) {
			editPage(request, response);
		} else if (command.endsWith("/clean/updateForm.do")) {
			updateForm(request, response);
		} else if (command.endsWith("/clean/update.do")) {
			update(request, response);
		}

	}

	// 픽업예약 메인화면
	private void cleanpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dispatch("/views/life/clean/reserv_clean_home.jsp", request, response);
	}

	// 주소선택 화면
	private void inputAddress(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dispatch("/views/life/clean/reserv_clean_address.jsp", request, response);
	}

	// 예약일 및 예약시간 선택화면
	private void inputSelect(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		CleanDTO clean_info = new CleanDTO();

		int MEMBER_CODE = getMemberCode(request, response);
		String CLEAN_POSTCODE = request.getParameter("CLEAN_POSTCODE");
		String CLEAN_ADDRESS = request.getParameter("CLEAN_ADDRESS");
		String CLEAN_DETAIL_ADDRESS = request.getParameter("CLEAN_DETAIL_ADDRESS");

		logger.info(CLEAN_POSTCODE);
		logger.info(CLEAN_ADDRESS);
		clean_info.setMEMBER_CODE(MEMBER_CODE);
		clean_info.setCLEAN_POSTCODE(CLEAN_POSTCODE);
		clean_info.setCLEAN_ADDRESS(CLEAN_ADDRESS);
		clean_info.setCLEAN_DETAIL_ADDRESS(CLEAN_DETAIL_ADDRESS);

		request.setAttribute("clean_info", clean_info);

		dispatch("/views/life/clean/reserv_clean_select.jsp", request, response);
	}

	// 픽업비용 결제 팝업
	private void pay(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		dispatch("/views/life/clean/reserve_kakaopay.jsp", request, response);
	}

	// 비용 결제 후 완료 페이지
	private void complete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		CleanDTO clean_info = new CleanDTO();

		int MEMBER_CODE = getMemberCode(request, response);
		String CLEAN_POSTCODE = request.getParameter("CLEAN_POSTCODE");
		String CLEAN_ADDRESS = request.getParameter("CLEAN_ADDRESS");
		String CLEAN_DETAIL_ADDRESS = request.getParameter("CLEAN_DETAIL_ADDRESS");
		String CLEAN_TIME = request.getParameter("CLEAN_TIME");
		String CLEAN_MANAGER = request.getParameter("CLEAN_MANAGER");
		String payComplete = request.getParameter("payComplete");

		clean_info.setMEMBER_CODE(MEMBER_CODE);
		clean_info.setCLEAN_POSTCODE(CLEAN_POSTCODE);
		clean_info.setCLEAN_ADDRESS(CLEAN_ADDRESS);
		clean_info.setCLEAN_DETAIL_ADDRESS(CLEAN_DETAIL_ADDRESS);
		clean_info.setCLEAN_TIME(CLEAN_TIME);
		clean_info.setCLEAN_MANAGER(Integer.parseInt(CLEAN_MANAGER));

		request.setAttribute("clean_info", clean_info);

		// 결제 완료되면
		if (payComplete.equals("1")) {
			int res = biz.reservClean(clean_info);
			// int res = 1;
			// 결제는 완료되었는데, 예약에 성공 또는 실패할 경우
			if (res > 0) {
				dispatch("/views/life/clean/reserv_clean_comp.jsp", request, response);
			} else {
				jsResponse("예약에 실패하였습니다. 다시 시도해주세요.", "/views/life/clean/reserv_clean_address.jsp", response);
			}
		} else {
			dispatch("/views/life/clean/reserv_clean_address.jsp", request, response);
		}

	}

	// 예약 변경 및 취소 페이지 이동
	private void editPage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();
		int MEMBER_CODE = getMemberCode(request, response);

		List<CleanDTO> reservList = biz.getReservList(MEMBER_CODE);

		request.setAttribute("reservList", reservList);

		dispatch("/views/life/clean/reserv_clean_edit.jsp", request, response);

	}

	// 예약 변경 폼 이동
	private void updateForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int CLEAN_CODE = Integer.parseInt(request.getParameter("CLEAN_CODE"));

		CleanDTO clean_info = biz.getCleanInfo(CLEAN_CODE);

		request.setAttribute("clean_info", clean_info);

		dispatch("/views/life/clean/reserv_clean_update.jsp", request, response);

	}

	// 예약 수정하기 실제 DB작업
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		session = request.getSession();

		CleanDTO clean_info = new CleanDTO();

		int CLEAN_CODE = Integer.parseInt(request.getParameter("CLEAN_CODE"));
		int MEMBER_CODE = getMemberCode(request, response);

		String CLEAN_POSTCODE = request.getParameter("CLEAN_POSTCODE");
		String CLEAN_ADDRESS = request.getParameter("CLEAN_ADDRESS");
		String CLEAN_DETAIL_ADDRESS = request.getParameter("CLEAN_DETAIL_ADDRESS");
		String CLEAN_TIME = request.getParameter("CLEAN_TIME");
		String CLEAN_MANAGER = request.getParameter("CLEAN_MANAGER");

		clean_info.setCLEAN_CODE(CLEAN_CODE);
		clean_info.setMEMBER_CODE(MEMBER_CODE);
		clean_info.setCLEAN_POSTCODE(CLEAN_POSTCODE);
		clean_info.setCLEAN_ADDRESS(CLEAN_ADDRESS);
		clean_info.setCLEAN_DETAIL_ADDRESS(CLEAN_DETAIL_ADDRESS);
		clean_info.setCLEAN_TIME(CLEAN_TIME);
		clean_info.setCLEAN_MANAGER(Integer.parseInt(CLEAN_MANAGER));

		int res = biz.updateClean(clean_info);

		if (res > 0) {
			jsResponse("예약 변경이 완료 되었습니다.", "/SINGLE/life/clean/edit.do", response);
		} else {
			jsResponse("예약 변경에 실패하였습니다. 다시 시도해주세요.", "/SINGLE/life/clean/edit.do", response);
		}

	}

	/*
	 * 예약 취소(예약하자마자 취소와 예약 및 취소 변경 페이지에서의 취소 한번에 처리 바로 예약취소는 해당 회원의 가장 최근에 예약한
	 * CLEAN_CODE를 받아서 처리 예약 및 취소 변경 페이지에서의 취소는 CLEAN_CODE와 status를 넘겨받아서 처리
	 */

	private void cancel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		session = request.getSession();

		int MEMBER_CODE = getMemberCode(request, response);

		CleanDTO dto = biz.getCleanCode(MEMBER_CODE);

		String status = request.getParameter("status");
		int CLEAN_CODE = 0;
		// 예약 변경 및 취소페이지일경우
		if (status != null && status.equals("1")) {
			CLEAN_CODE = Integer.parseInt(request.getParameter("CLEAN_CODE"));
		} else {
			CLEAN_CODE = dto.getCLEAN_CODE();
		}
		int res = biz.reservCancel(CLEAN_CODE);

		if (res > 0) {
			// 바로 예약 취소시에는 세탁메인 페이지로 이동되고 예약 및 취소 변경 페이지에서의 취소는 예약목록페이지로 이동
			if (status != null && status.equals("1")) {
				jsResponse("예약이 취소되었습니다.", "/SINGLE/life/clean/edit.do", response);
			} else {
				jsResponse("예약이 취소되었습니다.", "/SINGLE/life/clean/lifepage.do", response);
			}

		} else {
			jsResponse("에러가 발생하였습니다. 예약 내역을 다시 확인하여 주십시오.", "/SINGLE/life/clean/lifepage.do", response);
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

	// 현재 세션에 로그인 된 멤버의 코드 값을 불러옴.
	private int getMemberCode(HttpServletRequest request, HttpServletResponse response)
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

		return MEMBER_CODE;
	}

}
