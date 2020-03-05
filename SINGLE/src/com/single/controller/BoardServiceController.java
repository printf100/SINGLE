package com.single.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * board
 * 파일 다운로드 기능을 호출하기 위함
 */

@WebServlet(name = "file", urlPatterns = { "noticeFileDownload.do", // 공지 첨부 파일 다운로드로 이동
		"resaleFileUpload.do," })
public class BoardServiceController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	HttpSession session;

	public BoardServiceController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String command = request.getRequestURI();
		System.out.println("[" + command + "]");

		/*
		 * 파일 다운로드
		 */

		if (command.endsWith("/noticeFileDownload.do")) {
			noticeFileDownload(request, response);
		} else if (command.endsWith("/resaleFileUpload.do")) {
			resaleFileUpload(request, response);
		}

	}

	private void resaleFileUpload(HttpServletRequest request, HttpServletResponse response) {

	}

	// 파일 다운로드
	private void noticeFileDownload(HttpServletRequest request, HttpServletResponse response) {

		String FILE_SERVER = request.getParameter("FILE_SERVER");
		System.out.println(FILE_SERVER);

		String FILE_PATH = this.getServletContext().getRealPath("/uploadImages/");
		System.out.println(FILE_PATH);

		File downloadFile = new File(FILE_PATH + "/" + FILE_SERVER);
		System.out.println(downloadFile);

		String mimeType = getServletContext().getMimeType(downloadFile.toString());
		if (mimeType == null) {
			response.setContentType("application/octet-stream");
		}
		String downloadName = null;
		if (request.getHeader("user-agent").indexOf("MSIE") == -1) {
			try {
				downloadName = new String(FILE_SERVER.getBytes("UTF-8"), "8859_1");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} else {
			try {
				downloadName = new String(FILE_SERVER.getBytes("EUC-KR"), "8859_1");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		System.out.println(downloadName);
		response.setHeader("Content-Disposition", "attachment;filename=\"" + downloadName + "\";");
		FileInputStream in = null;
		ServletOutputStream out = null;
		// out.clear();

		byte b[] = new byte[1024];
		int data = 0;
		try {
			in = new FileInputStream(downloadFile);
			out = response.getOutputStream();
			while ((data = (in.read(b, 0, b.length))) != -1) {
				out.write(b, 0, data);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			out.flush();
			out.close();
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
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
