package com.single.controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.single.model.biz.map.FoodBiz;
import com.single.model.biz.map.FoodBizImpl;
import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.map.MapDto;
import com.single.model.dto.map.ScDto;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;

@WebServlet(name = "map", urlPatterns = { "map.do", "cctv.do", "food.do", "sc.do", "foodInsert.do", "search.do" })

public class MapController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	MemberBiz biz = new MemberBizImpl();
	FoodBiz biz2 = new FoodBizImpl();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/cctv.do")) {

			String address = request.getParameter("my_address");
			String encodedAddress = URLDecoder.decode(address, "UTF-8");

			String s_address[] = encodedAddress.split(" ");

			List<MapDto> list = new ArrayList<>();
			BufferedReader br = null;

			try {
				br = Files.newBufferedReader(Paths.get("C:\\Users\\gksgu\\Desktop\\CSV\\CCTV.csv"));
				Charset.forName("UTF-8");
				String line = "";

				while ((line = br.readLine()) != null) {
					// CSV 1���� �����ϴ� ����Ʈ
					MapDto dto = new MapDto();
					String array[] = line.split(",");
					// �迭���� ����Ʈ ��ȯ
					if (array[2].contains(s_address[2])) {
						dto.setManagement(array[0]);
						dto.setAddress(array[2]);
						dto.setPurpose(array[3]);
						dto.setTel(array[9]);

						list.add(dto);
					}
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (br != null) {
						br.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			request.setAttribute("list", list);
			request.setAttribute("my_address", encodedAddress);
			joinmap(request, response);
		} else if (command.endsWith("/food.do")) {
			response.sendRedirect("/SINGLE/views/map/foodMap.jsp");
		} else if (command.endsWith("/sc.do")) {

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

			MemberProfileDTO member_profile = biz.selectMemberProfile(MEMBER_CODE);

			System.out.println(member_profile);

			request.setAttribute("info", member_profile);

			List<ScDto> list = new ArrayList<>();
			BufferedReader br = null;

			try {
				br = Files.newBufferedReader(Paths.get("C:\\Users\\gksgu\\Desktop\\CSV\\SC.csv"));
				Charset.forName("UTF-8");
				String line = "";

				while ((line = br.readLine()) != null) {
					// CSV 1���� �����ϴ� ����Ʈ
					ScDto sc = new ScDto();
					String array[] = line.split(",");
					// �迭���� ����Ʈ ��ȯ

					sc.setFacility_name(array[0]);
					sc.setAddress(array[4]);

					list.add(sc);
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (br != null) {
						br.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			request.setAttribute("list", list);

			sc(request, response);

		} else if (command.endsWith("/foodInsert.do")) {

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

			System.out.println(MEMBER_CODE);

			request.setAttribute("member_code", MEMBER_CODE);

			foodInsert(request, response);

		} else if (command.endsWith("/map.do")) {

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

			MemberProfileDTO member_profile = biz.selectMemberProfile(MEMBER_CODE);

			System.out.println(member_profile);

			request.setAttribute("info", member_profile);

			dispatch("/views/map/map.jsp", request, response);

		} else if (command.endsWith("/search.do")) {

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

			List<MemberProfileDTO> memberList = biz2.memberList(MEMBER_CODE);

			MemberProfileDTO member_profile = biz.selectMemberProfile(MEMBER_CODE);

			System.out.println(member_profile);

			request.setAttribute("memberList", memberList);
			request.setAttribute("info", member_profile);

			searchF(request, response);

		}
	}

	private void searchF(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/map/searchF.jsp", request, response);
	}

	private void foodInsert(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/map/foodInsert.jsp", request, response);
	}

	private void sc(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		dispatch("/views/map/sc.jsp", request, response);
	}

	private void joinmap(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/map/cctv.jsp", request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		doGet(request, response);

	}

	private void dispatch(String url, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		RequestDispatcher dispatcher = request.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

}
