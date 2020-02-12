package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.InvalidKeyException;
import java.security.PrivateKey;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.util.RSA.RSA;
import com.single.util.RSA.RSAUtil;

/*
 * Member Controller
 * 회원 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "member", //
		urlPatterns = { //
				"joinpage.do", // join.jsp로 이동
				"emailCheck.do", // 이메일 중복 체크
				"nickCheck.do", // 닉네임 중복 체크
				"join.do", // 회원가입 처리
				"snsjoin.do", // SNS 회원가입 처리
				"loginpage.do", // login.jsp로 이동
				"login.do", // 로그인 처리
				"snschk.do", // SNS 아이디 중복체크
				"snslogin.do", // SNS 로그인 처리
				"logout.do" // 로그아웃 처리
		})

public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MemberBiz biz = new MemberBizImpl();

	HttpSession session;

	public MemberController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		/*
		 * 회원가입
		 */

		if (command.endsWith("/joinpage.do")) {
			joinpage(request, response);
		}

		else if (command.endsWith("/emailCheck.do")) {
			doEmailChk(request, response);
		}

		else if (command.endsWith("/nickCheck.do")) {
			doNickChk(request, response);
		}

		else if (command.endsWith("/join.do")) {
			doJoin(request, response);
		}

		else if (command.endsWith("/snsjoin.do")) {
			doSNSJoin(request, response);
		}

		/*
		 * 로그인
		 */

		else if (command.endsWith("/loginpage.do")) {
			loginpage(request, response);
		}

		else if (command.endsWith("/login.do")) {
			doLogin(request, response);
		}

		else if (command.endsWith("/snschk.do")) {
			doSNSChk(request, response);
		}

		else if (command.endsWith("/snslogin.do")) {
			doSNSLogin(request, response);
		}

		else if (command.endsWith("/logout.do")) {
			doLogout(request, response);
		}

	}

	/*
	 * 회원가입
	 */

	private RSAUtil rsaUtil = new RSAUtil();

	// 회원가입 페이지로 이동
	private void joinpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 RSA 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/join.jsp", request, response);
	}

	// 이메일 중복 체크
	private void doEmailChk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String NEW_EMAIL = request.getParameter("MEMBER_EMAIL");
		int res = biz.emailCheck(NEW_EMAIL);
		System.out.println("doEmailChk 결과 : " + res);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 닉네임 중복 체크
	private void doNickChk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String NEW_NICKNAME = request.getParameter("MEMBER_NICKNAME");
		int res = biz.nicknameCheck(NEW_NICKNAME);
		System.out.println("doNickChk 결과 : " + res);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 회원가입 처리
	private void doJoin(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

		MemberDTO new_member = new MemberDTO();

		PrivateKey privateKey = null;
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") == null) {
			System.out.println("session 에 RSAprivateKey가 존재하지 않습니다!!");
			dispatch("/views/member/join.jsp", request, response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		try {
			int MEMBER_VERIFY = Integer.parseInt(request.getParameter("MEMBER_VERIFY"));
			String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
			String MEMBER_PASSWORD = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PASSWORD"));
			String MEMBER_NAME = request.getParameter("MEMBER_NAME");
			String MEMBER_NICKNAME = request.getParameter("MEMBER_NICKNAME");
			String MEMBER_GENDER = request.getParameter("MEMBER_GENDER");

			System.out.println("MemberController - doJoin() 비밀번호 : " + MEMBER_PASSWORD);

			new_member.setMEMBER_VERIFY(MEMBER_VERIFY);
			new_member.setMEMBER_EMAIL(MEMBER_EMAIL);
			new_member.setMEMBER_PASSWORD(MEMBER_PASSWORD);
			new_member.setMEMBER_NAME(MEMBER_NAME);
			new_member.setMEMBER_NICKNAME(MEMBER_NICKNAME);
			new_member.setMEMBER_GENDER(MEMBER_GENDER);
			
		} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException e) {
			e.printStackTrace();
		}

		int res = biz.memberJoin(new_member);

		if (res > 0) {
			session.removeAttribute("RSAprivateKey");
			jsResponse("회원가입 성공", "/SINGLE/member/loginpage.do", response);
		} else {
			jsResponse("회원가입 실패", "/SINGLE/member/joinpage.do", response);
		}
	}

	// SNS 회원가입 처리
	private void doSNSJoin(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_VERIFY = Integer.parseInt(request.getParameter("MEMBER_VERIFY"));
		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
		String MEMBER_NAME = request.getParameter("MEMBER_NAME");
		String MEMBER_NICKNAME = request.getParameter("MEMBER_NICKNAME");
		String MEMBER_GENDER = request.getParameter("MEMBER_GENDER");

		String snsType = request.getParameter("snsType");
		String SNS_ID = request.getParameter("SNS_ID");
		String SNS_NICKNAME = request.getParameter("SNS_NICKNAME");
		String access_token = request.getParameter("access_token");

		System.out.println(snsType);

		if (snsType.equals("KAKAO")) {
			KakaoMemberDTO kakao_member = new KakaoMemberDTO(MEMBER_VERIFY, MEMBER_EMAIL, MEMBER_NAME, MEMBER_NICKNAME,
					MEMBER_GENDER, SNS_ID, SNS_NICKNAME);

			System.out.println(kakao_member);

			int res = biz.kakaoJoin(kakao_member);

			if (res > 0) {
				// 회원가입 후 자동로그인
				session = request.getSession();
				session.setAttribute("loginKakao", kakao_member);
				session.setAttribute("access_token", access_token);
				jsResponse("KAKAO 회원가입 성공", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("KAKAO 회원가입 실패", "/SINGLE/member/joinpage.do", response);
			}
		}

		else if (snsType.equals("NAVER")) {
			NaverMemberDTO naver_member = new NaverMemberDTO(MEMBER_VERIFY, MEMBER_EMAIL, MEMBER_NAME, MEMBER_NICKNAME,
					MEMBER_GENDER, SNS_ID, SNS_NICKNAME);

			System.out.println(naver_member);

			int res = biz.naverJoin(naver_member);

			if (res > 0) {
				// 회원가입 후 자동로그인
				session = request.getSession();
				session.setAttribute("loginNaver", naver_member);
				jsResponse("NAVER 회원가입 성공", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("NAVER 회원가입 실패", "/SINGLE/member/joinpage.do", response);
			}
		}
	}

	/*
	 * 로그인
	 */

	// 로그인 페이지로 이동
	private void loginpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 기존 생성되어있는 privateKey가 있다면 session에서 파기!
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		// 새로운 RSA 객체 생성
		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/login.jsp", request, response);
	}

	// 로그인 처리
	private void doLogin(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		MemberDTO member = new MemberDTO();

		PrivateKey privateKey = null;
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") == null) {
			System.out.println("session 에 RSAprivateKey가 존재하지 않습니다!!");
			dispatch("/views/member/login.jsp", request, response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		try {
			String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
			String MEMBER_PASSWORD = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PASSWORD"));

			member.setMEMBER_EMAIL(MEMBER_EMAIL);
			member.setMEMBER_PASSWORD(MEMBER_PASSWORD);

			System.out.println("MemberController - doLogin() 비밀번호 : " + MEMBER_PASSWORD);

		} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException e) {
			e.printStackTrace();
		}

		MemberDTO loginMember = biz.memberLogin(member);
		JSONObject obj = new JSONObject();

		if (loginMember != null) {
			obj.put("result", 1);
			session = request.getSession();
			session.setAttribute("loginMember", loginMember);
			session.removeAttribute("RSAprivateKey");
		} else {
			obj.put("result", 0);
		}

		String res = obj.toJSONString();
		System.out.println("doLogin 결과 : " + res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// SNS 아이디 중복체크 (로그인 처리를 할지, 회원가입 폼을 띄울지 결정하기 위함)
	private void doSNSChk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String snsType = request.getParameter("snsType");
		String kakao_id = request.getParameter("KAKAO_ID");
		String naver_id = request.getParameter("NAVER_ID");

		JSONObject obj = new JSONObject();

		if (snsType.equals("KAKAO")) {
			obj.put("result", biz.kakaoIdCheck(kakao_id));
		}

		else if (snsType.equals("NAVER")) {
			obj.put("result", biz.naverIdCheck(naver_id));
		}

		String res = obj.toJSONString();
		System.out.println("doSNSChk 결과 : " + res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// SNS 로그인 처리
	private void doSNSLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String snsType = request.getParameter("snsType");
		String SNS_ID = request.getParameter("SNS_ID");
		String access_token = request.getParameter("access_token");

		System.out.println(snsType);

		if (snsType.equals("KAKAO")) {
			KakaoMemberDTO kakao_member = biz.kakaoLoginMember(SNS_ID);

			if (kakao_member != null) {
				session = request.getSession();
				session.setAttribute("loginKakao", kakao_member);
				session.setAttribute("access_token", access_token);
				jsResponse("KAKAO 로그인 성공", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("KAKAO 로그인 실패", "/SINGLE/member/loginpage.do", response);
			}
		}

		else if (snsType.equals("NAVER")) {
			NaverMemberDTO naver_member = biz.naverLoginMember(SNS_ID);

			if (naver_member != null) {
				session = request.getSession();
				session.setAttribute("loginNaver", naver_member);
				jsResponse("NAVER 로그인 성공", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("NAVER 로그인 실패", "/SINGLE/member/loginpage.do", response);
			}
		}
	}

	// 로그아웃 처리
	private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();
		jsResponse("로그아웃", "/SINGLE/main/mainpage.do", response);
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
