package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.single.model.biz.note.NoteBiz;
import com.single.model.biz.note.NoteBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.model.dto.note.MyNoteListDTO;
import com.single.model.dto.note.NoteDTO;
import com.single.util.string.Format;

/*
 * Note Controller
 * 쪽지 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "note", //
		urlPatterns = { //
				"noteInList.do", // 받은 쪽지함(notein.jsp)으로 이동
				"noteInDetailpage.do", // 받은 쪽지 내용 화면으로 이동
				"noteOutList.do", // 보낸 쪽지함(noteout.jsp)으로 이동
				"noteOutDetailpage.do", // 보낸 쪽지 내용 화면으로 이동
				"sendNote.do", // 쪽지 전송하기
				"deleteNote.do", // 쪽지 삭제하기
				"noteInUnread.do", // 안 읽은 받은 쪽지 갯수 가져오기
		})
public class NoteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	NoteBiz biz = new NoteBizImpl();

	public NoteController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/noteInList.do")) {
			noteInpage(request, response);
		}

		else if (command.endsWith("/noteOutList.do")) {
			noteOutpage(request, response);
		}

		else if (command.endsWith("/noteInDetailpage.do")) {
			noteInDetailpage(request, response);
		}

		else if (command.endsWith("/noteOutDetailpage.do")) {
			noteOutDetailpage(request, response);
		}

		else if (command.endsWith("/sendNote.do")) {
			doSendNote(request, response);
		}

		else if (command.endsWith("/deleteNote.do")) {
			doDeleteNote(request, response);
		}

		else if (command.endsWith("/noteInUnread.do")) {
			noteInUnread(request, response);
		}
	}

	// 받은 쪽지함으로 이동
	private void noteInpage(HttpServletRequest request, HttpServletResponse response)
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

		List<NoteDTO> inList = biz.selectNoteInList(MEMBER_CODE);
		request.setAttribute("inList", inList);
		System.out.println(inList);

		int inAll = biz.noteInCount(MEMBER_CODE);
		int inUnread = biz.noteInUnreadCount(MEMBER_CODE);
		request.setAttribute("inAll", inAll);
		request.setAttribute("inUnread", inUnread);

		dispatch("/views/note/notein.jsp", request, response);
	}

	// 안 읽은 받은 쪽지 갯수 가져오기
	private void noteInUnread(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		int inUnread = biz.noteInUnreadCount(MEMBER_CODE);

		JSONObject obj = new JSONObject();
		obj.put("inUnread", inUnread);
		System.out.println(obj);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 받은 쪽지 내용 화면으로 이동
	private void noteInDetailpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int NOTE_CODE = Integer.parseInt(request.getParameter("NOTE_CODE"));

		NoteDTO inDetail = biz.selectNoteInDetail(NOTE_CODE);
		request.setAttribute("in", inDetail);
		
		System.out.println(inDetail);

		dispatch("/views/note/noteindetail.jsp", request, response);
	}

	// 보낸 쪽지함으로 이동
	private void noteOutpage(HttpServletRequest request, HttpServletResponse response)
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

		List<NoteDTO> outList = biz.selectNoteOutList(MEMBER_CODE);
		request.setAttribute("outList", outList);

		int outAll = biz.noteOutCount(MEMBER_CODE);
		int inUnread = biz.noteInUnreadCount(MEMBER_CODE);
		request.setAttribute("outAll", outAll);
		request.setAttribute("inUnread", inUnread);

		dispatch("/views/note/noteout.jsp", request, response);
	}

	// 보낸 쪽지 내용 화면으로 이동
	private void noteOutDetailpage(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int NOTE_CODE = Integer.parseInt(request.getParameter("NOTE_CODE"));

		NoteDTO outDetail = biz.selectNoteOutDetail(NOTE_CODE);

		request.setAttribute("out", outDetail);

		dispatch("/views/note/noteoutdetail.jsp", request, response);
	}

	// 쪽지 전송하기
	private void doSendNote(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int NOTE_FROM_CODE = Integer.parseInt(request.getParameter("NOTE_FROM_CODE"));
		int NOTE_TO_CODE = Integer.parseInt(request.getParameter("NOTE_TO_CODE"));
		String NOTE_TITLE = request.getParameter("NOTE_TITLE");
		String NOTE_CONTENT = request.getParameter("NOTE_CONTENT");

		NoteDTO sendNote = new NoteDTO();
		sendNote.setNOTE_FROM_CODE(NOTE_FROM_CODE);
		sendNote.setNOTE_TO_CODE(NOTE_TO_CODE);
		sendNote.setNOTE_TITLE(NOTE_TITLE);
		sendNote.setNOTE_CONTENT(NOTE_CONTENT);

		int res = 0;
		int note_code = biz.sendNote(sendNote);
		if (note_code > 0) {
			res = 1;

			// 쪽지 보내진 순간에 상대방 mylist에도 insert
			MyNoteListDTO toNote = new MyNoteListDTO();

			toNote.setMEMBER_CODE(NOTE_TO_CODE);
			toNote.setNOTE_CODE(note_code);
			toNote.setNOTE_VERIFY("IN");

			biz.insertMyList(toNote);
		}

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 쪽지 삭제하기
	private void doDeleteNote(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int NOTE_CODE = Integer.parseInt(request.getParameter("NOTE_CODE"));

		int res = biz.deleteNote(NOTE_CODE);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
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
