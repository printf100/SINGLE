package com.single.controller;

import java.io.File;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.util.RSA.RSA;
import com.single.util.RSA.RSAUtil;
import com.single.util.SHA256.SHA256_Util;
import com.single.util.email.RandomNum;
import com.single.util.email.SendEmail;

/*
 * Member Controller
 * 회원 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "member", //
		urlPatterns = { //
				"joinpage.do", // join.jsp로 이동
				"emailAuth.do", // 이메일 인증
				"emailCheck.do", // 이메일 중복 체크
				"nickCheck.do", // 닉네임 중복 체크
				"join.do", // 회원가입 처리
				"snsjoin.do", // SNS 회원가입 처리
				"loginpage.do", // login.jsp로 이동
				"login.do", // 로그인 처리
				"snschk.do", // SNS 아이디 중복체크
				"snslogin.do", // SNS 로그인 처리
				"logout.do", // 로그아웃 처리
				"profilepage.do", // profile.jsp로 이동
				"profileImgUpdate.do", // 프로필 이미지 수정 처리
				"profileUpdate.do", // 프로필 수정 처리 (닉네임, 상태메세지)
				"profileLocUpdate.do", // 프로필 내위치 수정 처리
				"infopage.do", // info.jsp로 이동
				"infoUpdate.do", // 회원정보 수정 처리
				"pwpage.do", // password.jsp로 이동 (비밀번호 변경 화면)
				"pwResetpage.do", // passwordemail.jsp로 이동 (비밀번호를 잊어버렸을 때)
				"pwResetEmail.do", // 비밀번호 재설정 메일 보내기
				"pwResetEmailpage.do", // 재설정 메일창에서 passwordreset.jsp로 이동
				"pwReset.do", // 비밀번호 변경 처리
		})

public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	MemberBiz biz = new MemberBizImpl();

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

		else if (command.endsWith("/emailAuth.do")) {
			doEmailAuth(request, response);
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

		/*
		 * 회원 정보, 프로필
		 */

		else if (command.endsWith("/profilepage.do")) {
			profilepage(request, response);
		}

		else if (command.endsWith("/profileImgUpdate.do")) {
			doProfileImgUpdate(request, response);
		}

		else if (command.endsWith("/profileUpdate.do")) {
			doProfileUpdate(request, response);
		}

		else if (command.endsWith("/profileLocUpdate.do")) {
			doProfileLocUpdate(request, response);
		}

		else if (command.endsWith("/infopage.do")) {
			infopage(request, response);
		}

		else if (command.endsWith("/infoUpdate.do")) {
			doInfoUpdate(request, response);
		}

		else if (command.endsWith("/pwpage.do")) {
			pwpage(request, response);
		}

		else if (command.endsWith("/pwResetpage.do")) {
			pwResetpage(request, response);
		}

		else if (command.endsWith("/pwResetEmail.do")) {
			doPwResetEmail(request, response);
		}

		else if (command.endsWith("/pwResetEmailpage.do")) {
			pwResetEmailpage(request, response);
		}

		else if (command.endsWith("/pwReset.do")) {
			doPwReset(request, response);
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

	// 이메일 인증 진행
	private void doEmailAuth(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String NEW_EMAIL = request.getParameter("MEMBER_EMAIL");
		String authNum = "";

		RandomNum random = new RandomNum();
		authNum = random.RandomNum();

		SendEmail sendEmail = new SendEmail();
		sendEmail.sendEmail(NEW_EMAIL, authNum);

		JSONObject obj = new JSONObject();
		obj.put("result", 1);
		obj.put("authNum", authNum);

		PrintWriter out = response.getWriter();
		out.println(obj);
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
			jsResponse("회원가입을 성공했어요!", "/SINGLE/member/loginpage.do", response);
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
				jsResponse("KAKAO로 회원가입을 성공했어요!", "/SINGLE/member/loginpage.do", response);
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
				jsResponse("NAVER로 회원가입을 성공했어요!", "/SINGLE/member/loginpage.do", response);
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
			MemberProfileDTO profile = biz.selectMemberProfile(loginMember.getMEMBER_CODE());

			obj.put("result", 1);
			loginMember.setMEMBER_PASSWORD(""); // 세션에는 비밀번호를 담아다니지 않도록! 위험위험
			profile.setMEMBER_PASSWORD("");

			session = request.getSession();
			session.setAttribute("loginMember", profile);
			session.setAttribute("profile", profile);
			session.removeAttribute("RSAprivateKey");

			session.setMaxInactiveInterval(60 * 60);
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
				MemberProfileDTO profile = biz.selectMemberProfile(kakao_member.getMEMBER_CODE());
				
				session = request.getSession();
				session.setAttribute("loginKakao", profile);
				session.setAttribute("profile", profile);
				session.setAttribute("access_token", access_token);
				session.setMaxInactiveInterval(60 * 60);

				jsResponse("KAKAO로 로그인을 성공했어요!", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("KAKAO 로그인 실패", "/SINGLE/member/loginpage.do", response);
			}
		}

		else if (snsType.equals("NAVER")) {
			NaverMemberDTO naver_member = biz.naverLoginMember(SNS_ID);

			if (naver_member != null) {
				MemberProfileDTO profile = biz.selectMemberProfile(naver_member.getMEMBER_CODE());

				session = request.getSession();
				session.setAttribute("loginNaver", profile);
				session.setAttribute("profile", profile);
				session.setMaxInactiveInterval(60 * 60);

				jsResponse("NAVER로 로그인을 성공했어요!", "/SINGLE/main/mainpage.do", response);
			} else {
				jsResponse("NAVER 로그인 실패", "/SINGLE/member/loginpage.do", response);
			}
		}
	}

	// 로그아웃 처리
	private void doLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		request.getSession().invalidate();
		jsResponse("로그아웃합니다.", "/SINGLE/main/mainpage.do", response);
	}

	/*
	 * 회원 정보, 프로필
	 */

	// 회원 프로필 화면으로 이동
	private void profilepage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		MemberProfileDTO loginMember = (MemberProfileDTO) session.getAttribute("loginMember");
		MemberProfileDTO loginKakao = (MemberProfileDTO) session.getAttribute("loginKakao");
		MemberProfileDTO loginNaver = (MemberProfileDTO) session.getAttribute("loginNaver");

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
		dispatch("/views/member/profile.jsp", request, response);
	}

	// 프로필 이미지 수정 처리
	private void doProfileImgUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {

		// 업로드될 경로
		String filePath = "/resources/images/profileimg/";

		// 업로드될 실제 경로 (이클립스 상의 절대경로)
		String MPROFILE_IMG_PATH = getServletContext().getRealPath(filePath);
		System.out.println("절대경로 : " + MPROFILE_IMG_PATH);

		String encoding = "UTF-8";
		int maxSize = 1024 * 1024 * 3;

		File file;
		if (!(file = new File(MPROFILE_IMG_PATH)).isDirectory()) {
			file.mkdirs();
		}

		MultipartRequest mr = null;

		try {
			mr = new MultipartRequest(request, MPROFILE_IMG_PATH, // 파일이 저장될 폴더
					maxSize, // 최대 업로드크기 (5MB)
					encoding, // 인코딩 방식
					new DefaultFileRenamePolicy() // 동일한 파일명이 존재하면 파일명 뒤에 일련번호를 부여
			);

		} catch (IOException e) {
			System.out.println("[ERROR] MemberController - doProfileImgUpdate() : MultipartRequest 객체 생성 오류");
			e.printStackTrace();
		}

		int MEMBER_CODE = Integer.parseInt(mr.getParameter("MEMBER_CODE"));
		System.out.println(MEMBER_CODE);

		// 이미지 관련
		String MPROFILE_IMG_NAME = null;
		String MPROFILE_IMG_SERVERNAME = null;
		String imgExtend = null;

		// 실제 저장된 이미지 이름
		MPROFILE_IMG_SERVERNAME = mr.getFilesystemName("MPROFILE_IMG_NAME");

		if (MPROFILE_IMG_SERVERNAME != null) {

			// 원래 이미지 이름
			MPROFILE_IMG_NAME = mr.getOriginalFileName("MPROFILE_IMG_NAME");

			// 이미지 확장자
			imgExtend = MPROFILE_IMG_SERVERNAME.substring(MPROFILE_IMG_SERVERNAME.lastIndexOf(".") + 1);
			System.out.println(imgExtend);

			if (!imgExtend.equals("jpg") && !imgExtend.equals("png") && !imgExtend.equals("jpeg")) {
				jsResponse("이미지만 첨부 가능합니다.", "/SINGLE/memeber/profilepage.do", response);
			}
		}

		MemberProfileDTO update_profileimg = new MemberProfileDTO();

		update_profileimg.setMEMBER_CODE(MEMBER_CODE);
		update_profileimg.setMPROFILE_IMG_NAME((MPROFILE_IMG_NAME == null) ? "" : MPROFILE_IMG_NAME);
		update_profileimg.setMPROFILE_IMG_SERVERNAME((MPROFILE_IMG_SERVERNAME == null) ? "" : MPROFILE_IMG_SERVERNAME);
		update_profileimg.setMPROFILE_IMG_PATH((MPROFILE_IMG_PATH == null) ? "" : MPROFILE_IMG_PATH);

		JSONObject obj = new JSONObject();

		int update_res = biz.updateProfileImg(update_profileimg);
		obj.put("result", update_res);
		obj.put("img", biz.selectMemberProfile(MEMBER_CODE).getMPROFILE_IMG_SERVERNAME());

		String res = obj.toJSONString();
		System.out.println("doProfileImgUpdate 결과 : " + res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 프로필 수정 처리
	private void doProfileUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		System.out.println(MEMBER_CODE);

		MemberProfileDTO update_intro = new MemberProfileDTO();
		MemberDTO update_nickname = new MemberDTO();

		String MEMBER_NICKNAME = request.getParameter("MEMBER_NICKNAME");
		String MPROFILE_INTRODUCE = request.getParameter("MPROFILE_INTRODUCE");

		update_intro.setMEMBER_CODE(MEMBER_CODE);
		update_intro.setMPROFILE_INTRODUCE((MPROFILE_INTRODUCE == null) ? "" : MPROFILE_INTRODUCE);

		update_nickname.setMEMBER_CODE(MEMBER_CODE);
		update_nickname.setMEMBER_NICKNAME((MEMBER_NICKNAME == null) ? "" : MEMBER_NICKNAME);

		int res = 0;
		int intro_res = biz.updateProfileIntro(update_intro);
		int nickname_res = biz.updateNickname(update_nickname);

		if (intro_res > 0 && nickname_res > 0) {
			res = 1;
		}

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 프로필 내위치 수정 처리
	private void doProfileLocUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		System.out.println(MEMBER_CODE);

		MemberProfileDTO update_profileloc = new MemberProfileDTO();

		String MPROFILE_LATITUDE = request.getParameter("MPROFILE_LATITUDE");
		String MPROFILE_LONGITUDE = request.getParameter("MPROFILE_LONGITUDE");

		System.out.println(MPROFILE_LATITUDE);
		System.out.println(MPROFILE_LONGITUDE);

		update_profileloc.setMEMBER_CODE(MEMBER_CODE);
		update_profileloc.setMPROFILE_LATITUDE((MPROFILE_LATITUDE == null) ? "" : MPROFILE_LATITUDE);
		update_profileloc.setMPROFILE_LONGITUDE((MPROFILE_LONGITUDE == null) ? "" : MPROFILE_LONGITUDE);

		JSONObject obj = new JSONObject();

		int update_res = biz.updateProfileLoc(update_profileloc);
		obj.put("result", update_res);

		String res = obj.toJSONString();
		System.out.println("doProfileLocUpdate 결과 : " + res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 회원 정보 화면으로 이동
	private void infopage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		MemberProfileDTO loginMember = (MemberProfileDTO) session.getAttribute("loginMember");
		MemberProfileDTO loginKakao = (MemberProfileDTO) session.getAttribute("loginKakao");
		MemberProfileDTO loginNaver = (MemberProfileDTO) session.getAttribute("loginNaver");

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

		System.out.println(MEMBER_CODE);

		MemberProfileDTO member_profile = biz.selectMemberProfile(MEMBER_CODE);

		System.out.println(member_profile);

		request.setAttribute("info", member_profile);
		dispatch("/views/member/info.jsp", request, response);
	}

	// 회원정보 수정 처리
	private void doInfoUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		String MEMBER_NAME = request.getParameter("MEMBER_NAME");
		String MEMBER_GENDER = request.getParameter("MEMBER_GENDER");

		MemberDTO new_info = new MemberDTO();
		new_info.setMEMBER_NAME(MEMBER_NAME);
		new_info.setMEMBER_GENDER(MEMBER_GENDER);
		new_info.setMEMBER_CODE(MEMBER_CODE);

		int res = biz.updateMemberInfo(new_info);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 회원 비밀번호 변경 화면으로 이동
	private void pwpage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/password.jsp", request, response);
	}

	// 비밀번호를 잊어버렸을 때 이메일 전송 화면으로 이동
	private void pwResetpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/member/passwordemail.jsp", request, response);
	}

	// 비밀번호 재설정 링크가 담긴 이메일 전송
	private void doPwResetEmail(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String CONFIRM_EMAIL = request.getParameter("CONFIRM_EMAIL");
		String MEMBER_NAME = request.getParameter("MEMBER_NAME");

		SendEmail sendEmail = new SendEmail();
		sendEmail.sendPwEmail(CONFIRM_EMAIL, MEMBER_NAME);

		jsResponse("비밀번호 설정 메일이 발신되었습니다.", "/SINGLE/main/mainpage.do", response);
	}

	// 재설정 메일창에서 비밀번호 변경 화면으로 이동
	private void pwResetEmailpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") != null)
			session.removeAttribute("RSAprivateKey");

		RSA rsa = rsaUtil.createRSA();
		request.setAttribute("modulus", rsa.getModulus());
		request.setAttribute("exponent", rsa.getExponent());
		session.setAttribute("RSAprivateKey", rsa.getPrivateKey());

		dispatch("/views/member/passwordreset.jsp", request, response);
	}

	// 회원 비밀번호 변경 처리
	private void doPwReset(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		PrivateKey privateKey = null;
		session = request.getSession();

		if (session.getAttribute("RSAprivateKey") == null) {
			System.out.println("session 에 RSAprivateKey가 존재하지 않습니다!!");
			dispatch("/views/member/pwpage.jsp", request, response);
		} else {
			privateKey = (PrivateKey) session.getAttribute("RSAprivateKey");
		}

		String ORIGINAL_PASSWORD = request.getParameter("ORIGINAL_PASSWORD"); // 사용자가 입력한 원래 비밀번호
		String DB_PASSWORD = null; // DB에 저장된 비밀번호
		String NEW_PASSWORD = request.getParameter("MEMBER_PASSWORD"); // 사용자가 입력한 새로운 비밀번호

		int res = 0;

		// 사이트 로그인 회원일 때만!
		if (session.getAttribute("loginMember") != null) {

			int MEMBER_CODE = (((MemberProfileDTO) session.getAttribute("loginMember")).getMEMBER_CODE());
			System.out.println(MEMBER_CODE);

			MemberDTO member = biz.loginMember(MEMBER_CODE);
			MemberDTO new_pw = new MemberDTO();

			// 비밀번호를 잊어버리지 않았을 때
			if (ORIGINAL_PASSWORD != null) {
				System.out.println("기존 비밀번호 알고 있을 때");

				try {
					ORIGINAL_PASSWORD = new SHA256_Util().encryptSHA256(
							rsaUtil.getDecryptText(privateKey, request.getParameter("ORIGINAL_PASSWORD")));
					DB_PASSWORD = member.getMEMBER_PASSWORD();

					System.out.println("MemberController - doPwReset() 원래 비밀번호 : " + ORIGINAL_PASSWORD);
					System.out.println("MemberController - doPwReset() DB 저장된 비밀번호 : " + DB_PASSWORD);

					if (!ORIGINAL_PASSWORD.equals(DB_PASSWORD)) { // 기존 비밀번호가 맞지 않으면
						jsResponse("현재 비밀번호가 일치하지 않습니다.", "/SINGLE/member/pwpage.do", response);

					} else { // 기존 비밀번호를 맞게 잘 썼으면

						NEW_PASSWORD = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PASSWORD"));
						System.out.println("MemberController - doPwReset() 새로운 비밀번호 : " + NEW_PASSWORD);
					}

					new_pw.setMEMBER_CODE(MEMBER_CODE);
					new_pw.setMEMBER_PASSWORD(NEW_PASSWORD);

				} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException e) {
					e.printStackTrace();
				}

				res = biz.updateMemberPW(new_pw);

				if (res > 0) {
					// 비밀번호 변경 후 로그아웃 처리
					jsResponse("비밀번호가 변경되었습니다. 다시 로그인해주세요.", "/SINGLE/member/logout.do", response);
				}

			} else {
				System.out.println("기존 비밀번호를 잊어버렸을 때");

				try {
					NEW_PASSWORD = rsaUtil.getDecryptText(privateKey, request.getParameter("MEMBER_PASSWORD"));

					System.out.println("MemberController - doPwReset() 새로운 비밀번호 : " + NEW_PASSWORD);

				} catch (InvalidKeyException | IllegalBlockSizeException | BadPaddingException e) {
					e.printStackTrace();
				}

				new_pw.setMEMBER_CODE(MEMBER_CODE);
				new_pw.setMEMBER_PASSWORD(NEW_PASSWORD);

				res = biz.updateMemberPW(new_pw);

				if (res > 0) {
					// 비밀번호 변경 후 로그아웃 처리
					jsResponse("비밀번호가 변경되었습니다. 다시 로그인해주세요!", "/SINGLE/member/logout.do", response);
				}
			}

		} else {
			jsResponse("로그인 세션이 만료되었습니다. 다시 로그인 해주세요!", "/SINGLE/main/mainpage.do", response);
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
