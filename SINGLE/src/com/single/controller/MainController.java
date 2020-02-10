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

/*
 * Main Controller
 * �α��� �� ����ȭ���� ȣ���ϱ� ����
 */
@WebServlet(//
		name = "main", //
		urlPatterns = { //
				"mainpage.do" // main.jsp�� �̵�
		})

public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

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

	// ������������ �̵�
	private void mainpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		session = request.getSession();

		if (session.getAttribute("loginMember") != null || session.getAttribute("loginKakao") != null
				|| session.getAttribute("loginNaver") != null) {
			// �α��� ������ ��
			dispatch("/views/main/main.jsp", request, response);
		} else {
			// �α׾ƿ� ������ ��
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