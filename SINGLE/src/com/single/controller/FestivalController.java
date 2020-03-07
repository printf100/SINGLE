package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Festival Controller
 * 축제 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "festival", //
		urlPatterns = { //
				"festivalpage.do", // festival.jsp
				"festivalapipage.do", // festivalapi.jsp
				"detailapipage.do", // detailapi.jsp
				"aroundpage.do", // around.jsp
		})

public class FestivalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FestivalController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/festivalpage.do")) {
			festivalpage(request, response);
		}

		else if (command.endsWith("/festivalapipage.do")) {
			festivalapipage(request, response);
		}

		else if (command.endsWith("/detailapipage.do")) {
			detailapipage(request, response);
		}

		else if (command.endsWith("/aroundpage.do")) {
			aroundpage(request, response);
		}

	}

	private void aroundpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/festival/around.jsp", request, response);

	}

	private void detailapipage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		dispatch("/views/festival/detailapi.jsp", request, response);

	}

	private void festivalapipage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dispatch("/views/festival/festivalapi.jsp", request, response);

	}

	private void festivalpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		dispatch("/views/festival/festival.jsp", request, response);
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
