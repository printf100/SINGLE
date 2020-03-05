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

import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.single.model.biz.chat.ChatBiz;
import com.single.model.biz.chat.ChatBizImpl;
import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.chat.ChatDTO;
import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;

/*
 * Chat Controller
 * 채팅 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "chat", //
		urlPatterns = { //
				"chatpage.do", // chat.jsp로 이동
				"findMember.do", // 회원 찾기
				"getMyOnetoOneChatList.do", // 내가 참여한 일대일 채팅방 리스트 가져오기
				"getMyNtoNChatList.do", // 내가 참여한 대다대 채팅방 리스트 가져오기
				"oneChatRoompage.do", // 일대일 채팅방 생성
				"getchatMember.do", // 채팅방에 참에하는 회원의 프로필 가져오기
				"getMessageList.do", // 채팅방에 기존 메세지 뿌려주기
				"sendMessage.do", // 메세지 전송 처리
				"goChatRoom.do", // 채팅방 들어가기
		})
public class ChatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	ChatBiz biz = new ChatBizImpl();
	MemberBiz mBiz = new MemberBizImpl();

	public ChatController() {
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String command = request.getRequestURI();
		System.out.println("[ " + command + " ]");

		if (command.endsWith("/chatpage.do")) {
			chatpage(request, response);
		}

		else if (command.endsWith("/findMember.do")) {
			doFindMember(request, response);
		}

		else if (command.endsWith("/getMyOnetoOneChatList.do")) {
			getMyOnetoOneChatList(request, response);
		}

		else if (command.endsWith("/getMyNtoNChatList.do")) {
			getMyNtoNChatList(request, response);
		}

		else if (command.endsWith("/oneChatRoompage.do")) {
			createOneChatRoom(request, response);
		}

		else if (command.endsWith("/getchatMember.do")) {
			getChatMember(request, response);
		}

		else if (command.endsWith("/getMessageList.do")) {
			getMessageList(request, response);
		}

		else if (command.endsWith("/sendMessage.do")) {
			doSendMessage(request, response);
		}
		
		else if (command.endsWith("/goChatRoom.do")) {
			chatRoompage(request, response);
		}

	}

	// 채팅 메인화면으로 이동
	private void chatpage(HttpServletRequest request, HttpServletResponse response)
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

		MemberProfileDTO member_profile = mBiz.selectMemberProfile(MEMBER_CODE);
		System.out.println(member_profile);

		request.setAttribute("profile", member_profile);

		dispatch("/views/chat/chat.jsp", request, response);
	}

	// 이메일로 회원 찾기
	private void doFindMember(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String MEMBER_EMAIL = request.getParameter("MEMBER_EMAIL");
		System.out.println("찾을 회원의 이메일 : " + MEMBER_EMAIL);
		MemberProfileDTO find_member = biz.findMember(MEMBER_EMAIL);
		System.out.println(find_member);

		int res = 0;
		JSONObject obj = new JSONObject();

		if (find_member != null) {
			res = 1;
			obj.put("profileimg", find_member.getMPROFILE_IMG_SERVERNAME());
			obj.put("nickname", find_member.getMEMBER_NICKNAME());
			obj.put("introduce", find_member.getMPROFILE_INTRODUCE());
			obj.put("TO_MEMBER_CODE", find_member.getMEMBER_CODE());
		}

		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 내가 참여한 일대일 채팅방 리스트 가져오기
	private void getMyOnetoOneChatList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));

		List<ChatRoomDTO> myChatList = biz.selectOnetoOneChatList(MY_MEMBER_CODE);
		System.out.println(myChatList);

		for (int i = 0; i < myChatList.size(); i++) {
			System.out.println("myChatList[" + i + "] = " + myChatList.get(i).getMEMBER_NICKNAME());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(myChatList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 내가 참여한 대다대 채팅방 리스트 가져오기
	private void getMyNtoNChatList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));

		List<ChatRoomDTO> myChatList = biz.selectNtoNChatList(MY_MEMBER_CODE);
		System.out.println(myChatList);

		for (int i = 0; i < myChatList.size(); i++) {
			System.out.println("myChatList[" + i + "]" + myChatList.get(i).getCHATROOM_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(myChatList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 일대일 채팅방 생성
	private void createOneChatRoom(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));
		int TO_MEMBER_CODE = Integer.parseInt(request.getParameter("TO_MEMBER_CODE"));

		Integer CHATROOM_CODE = biz.countOneChatChk(MY_MEMBER_CODE, TO_MEMBER_CODE);
		JSONObject obj = new JSONObject();
		System.out.println("------------채팅방 유무 결과-----------" + CHATROOM_CODE);
		Integer res = CHATROOM_CODE;

		if (CHATROOM_CODE == null) { // 대화한 적이 없으면
			CHATROOM_CODE = biz.createOnetoOneRoom(MY_MEMBER_CODE); // 채팅방 새로 생성
			System.out.println("새로 생성된 채팅방 : " + CHATROOM_CODE);

			// 새로운 채팅방 생성된 순간에 상대방 mylist에도 insert!
			MyChatroomListDTO toList = new MyChatroomListDTO();

			toList.setCHATROOM_CODE(CHATROOM_CODE);
			toList.setMEMBER_CODE(TO_MEMBER_CODE);

			biz.gointoRoom(toList);
		}

		obj.put("result", res);
		obj.put("CHATROOM_CODE", CHATROOM_CODE);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 채팅방에 참에하는 회원의 프로필 가져오기
	private void getChatMember(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));
		int TO_MEMBER_CODE = Integer.parseInt(request.getParameter("TO_MEMBER_CODE"));
		System.out.println("FROM " + MY_MEMBER_CODE + " TO " + TO_MEMBER_CODE);

		MemberProfileDTO my_member = mBiz.selectMemberProfile(MY_MEMBER_CODE);
		my_member.setMEMBER_PASSWORD("");
		MemberProfileDTO to_member = mBiz.selectMemberProfile(TO_MEMBER_CODE);
		to_member.setMEMBER_PASSWORD("");

		System.out.println(my_member);
		System.out.println(to_member);

		int res = 0;
		JSONObject obj = new JSONObject();

		if (my_member != null && to_member != null) {
			res = 1;
			// 보내는 사람 정보
			obj.put("my_img", my_member.getMPROFILE_IMG_SERVERNAME());
			obj.put("my_nickname", my_member.getMEMBER_NICKNAME());
			// 받는 사람 정보
			obj.put("to_img", to_member.getMPROFILE_IMG_SERVERNAME());
			obj.put("to_nickname", to_member.getMEMBER_NICKNAME());
		}

		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 채팅방에 기존 메세지 20개 뿌려주기
	private void getMessageList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		System.out.println("채팅방 번호 : " + CHATROOM_CODE);

		List<ChatMessageDTO> msgList = biz.selectChatMessageList(CHATROOM_CODE);
		System.out.println(msgList);

		for (int i = 0; i < msgList.size(); i++) {
			System.out.println("msgList[" + i + "]" + msgList.get(i).getCHATMESSAGE_CONTENT());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(msgList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 메세지 전송 처리
	private void doSendMessage(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ChatMessageDTO message = new ChatMessageDTO();

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		int CHATMESSAGE_FROM = Integer.parseInt(request.getParameter("CHATMESSAGE_FROM"));
		String CHAT_CONTENT = request.getParameter("CHAT_CONTENT");

		message.setCHATROOM_CODE(CHATROOM_CODE);
		message.setCHATMESSAGE_FROM(CHATMESSAGE_FROM);
		message.setCHATMESSAGE_CONTENT(CHAT_CONTENT);

		int res = biz.sendMessage(message);
		JSONObject obj = new JSONObject();

		if (res > 0) {
			obj.put("content", CHAT_CONTENT);
		}

		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 채팅방리스트에서 채팅방으로 이동
	private void chatRoompage(HttpServletRequest request, HttpServletResponse response) {
		
		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
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
