package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.util.RSA.RSA;
import com.single.util.RSA.RSAUtil;

/*
 * Main Controller
 * 로그인 후 메인화면을 호출하기 위함
 */
@WebServlet(//
		name = "main", //
		urlPatterns = { //
				"mainpage.do" // main.jsp로 이동
		})

public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;
	MemberBiz biz = new MemberBizImpl();

	public MainController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/mainpage.do")) {
			mainpage(request, response);
		}

	}

	private RSAUtil rsaUtil = new RSAUtil();

	// 메인페이지로 이동
	private void mainpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		if (session.getAttribute("loginMember") != null || session.getAttribute("loginKakao") != null
				|| session.getAttribute("loginNaver") != null) {
			// 로그인 상태일 때

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

			MemberProfileDTO member_profile = biz.selectMemberProfile(MEMBER_CODE);

			request.setAttribute("profile", member_profile);

			dispatch("/views/main/main.jsp", request, response);
		} else {
			// 로그아웃 상태일 때
			dispatch("/views/home/home.jsp", request, response);
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
