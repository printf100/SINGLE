package com.single.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.Gson;
import com.single.model.biz.chat.ChatBiz;
import com.single.model.biz.chat.ChatBizImpl;
import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.util.string.Format;

/*
 * Chat Controller
 * 채팅 관련 기능을 호출하기 위함
 */
@WebServlet(//
		name = "chat", //
		urlPatterns = { //
				"chatpage.do", // chat.jsp로 이동
				"getNChatList.do", // 모든 다대다 채팅방 리스트 가져오기
				"findMember.do", // 회원 찾기
				"searchNChatRoom.do", // 다대다 채팅방 검색하기
				"getMyOnetoOneChatList.do", // 내가 참여한 일대일 채팅방 리스트 가져오기
				"getMyNtoNChatList.do", // 내가 참여한 다대다 채팅방 리스트 가져오기
				"oneChatRoompage.do", // 일대일 채팅방 생성하기
				"getOneChatMember.do", // 일대일 채팅방에 참여하는 회원의 프로필 가져오기
				"getMessageList.do", // 채팅방에 기존 메세지 뿌려주기
				"sendMessage.do", // 메세지 전송 처리
				"createNChatRoom.do", // 다대다 채팅방 생성하기
				"getNChatMember.do", // 다대다 채팅방에 참여하는 회원들 프로필 가져오기
				"nChatChk.do", // 전체 리스트에서 내가 참여한 다대다 채팅방인지 아닌지 확인하기
				"nChatRoompage.do", // 다대다 채팅방 참여하기
				"updateOutDate.do", // 채팅방 나간 순간 mylist OUTDATE 수정
				"goOutNRoom.do", // 다대다 채팅방 나가기
				"updateRoomTitle.do", // 채팅방 제목 수정하기 (방장만)
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

		else if (command.endsWith("/getNChatList.do")) {
			getNChatList(request, response);
		}

		else if (command.endsWith("/findMember.do")) {
			doFindMember(request, response);
		}

		else if (command.endsWith("/searchNChatRoom.do")) {
			doSearchNtoNChatRoom(request, response);
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

		else if (command.endsWith("/getOneChatMember.do")) {
			getOneChatMember(request, response);
		}

		else if (command.endsWith("/getMessageList.do")) {
			getMessageList(request, response);
		}

		else if (command.endsWith("/sendMessage.do")) {
			doSendMessage(request, response);
		}

		else if (command.endsWith("/createNChatRoom.do")) {
			createNChatRoom(request, response);
		}

		else if (command.endsWith("/getNChatMember.do")) {
			getNChatMember(request, response);
		}

		else if (command.endsWith("/nChatChk.do")) {
			doNChatChk(request, response);
		}

		else if (command.endsWith("/nChatRoompage.do")) {
			nChatRoompage(request, response);
		}

		else if (command.endsWith("/updateOutDate.do")) {
			doUpdateOutDate(request, response);
		}

		else if (command.endsWith("/goOutNRoom.do")) {
			doGoOutNRoom(request, response);
		}

		else if (command.endsWith("/updateRoomTitle.do")) {
			doUpdateRoomTitle(request, response);
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
		member_profile.setMEMBER_PASSWORD("");
		System.out.println(member_profile);

		request.setAttribute("profile", member_profile);

		dispatch("/views/chat/chat.jsp", request, response);
	}

	// 존재하는 모든 다대다 채팅방 리스트 가져오기
	private void getNChatList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		List<ChatRoomDTO> nRoomList = biz.selectNtoNChatList();
		System.out.println(nRoomList);

		for (int i = 0; i < nRoomList.size(); i++) {
			System.out.println("nRoomList[" + i + "] = " + nRoomList.get(i).getCHATROOM_CODE());
		}

		Gson gson = new Gson();
		String jsonList = gson.toJson(nRoomList);
		PrintWriter out = response.getWriter();
		out.println(jsonList);
	}

	// 이메일로 회원 찾기
	private void doFindMember(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		String MEMBER_ACCOUNT = request.getParameter("MEMBER_ACCOUNT");

		List<MemberProfileDTO> memberList = biz.findMember(MY_MEMBER_CODE, MEMBER_ACCOUNT);
		System.out.println(memberList);

		int res = 0;
		if (memberList != null) {
			res = 1;
		}

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < memberList.size(); i++) {
			JSONObject list = new JSONObject();

			list.put("profileimg", memberList.get(i).getMPROFILE_IMG_SERVERNAME());
			list.put("nickname", memberList.get(i).getMEMBER_NICKNAME());
			list.put("email", memberList.get(i).getMEMBER_EMAIL());
			list.put("introduce", memberList.get(i).getMPROFILE_INTRODUCE());
			list.put("TO_MEMBER_CODE", memberList.get(i).getMEMBER_CODE());

			jArray.add(list);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("jArray", jArray);
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 제목으로 다대다 채팅방 검색하기
	private void doSearchNtoNChatRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {

		String SEARCH_CHATROOM_TITLE = request.getParameter("SEARCH_CHATROOM_TITLE");

		List<ChatRoomDTO> chatList = biz.searchNtoNChatRoom(SEARCH_CHATROOM_TITLE);
		System.out.println(chatList);

		int res = 0;
		if (chatList != null) {
			res = 1;
		}

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < chatList.size(); i++) {
			JSONObject list = new JSONObject();

			list.put("CHATROOM_CODE", chatList.get(i).getCHATROOM_CODE());
			list.put("CHATROOM_TITLE", chatList.get(i).getCHATROOM_TITLE());
			list.put("CHATROOM_MEMBER_COUNT", chatList.get(i).getCHATROOM_MEMBER_COUNT());
			list.put("CHATROOM_CHIEF_CODE", chatList.get(i).getCHATROOM_CHIEF_CODE());

			jArray.add(list);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("jArray", jArray);
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 내가 참여한 일대일 채팅방 리스트 가져오기
	private void getMyOnetoOneChatList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));

		Map<String, Object> myChatList = biz.selectOnetoOneChatList(MY_MEMBER_CODE);
		System.out.println(myChatList.get("chatList") + " : " + myChatList.get("unreadList"));

		List<ChatRoomDTO> chatList = (List<ChatRoomDTO>) myChatList.get("chatList");
		List<Integer> unreadList = (List<Integer>) myChatList.get("unreadList");

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < chatList.size(); i++) {
			JSONObject list = new JSONObject();

			list.put("CHATROOM_CODE", chatList.get(i).getCHATROOM_CODE());
			list.put("MEMBER_CODE", chatList.get(i).getMEMBER_CODE());
			list.put("MEMBER_NICKNAME", chatList.get(i).getMEMBER_NICKNAME());
			list.put("UNREAD", unreadList.get(i));

			jArray.add(list);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("list", jArray);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 내가 참여한 대다대 채팅방 리스트 가져오기
	private void getMyNtoNChatList(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MY_MEMBER_CODE = Integer.parseInt(request.getParameter("MY_MEMBER_CODE"));

		Map<String, Object> myChatList = biz.selectNtoNChatList(MY_MEMBER_CODE);
		System.out.println(myChatList.get("chatList") + " : " + myChatList.get("unreadList"));

		List<ChatRoomDTO> chatList = (List<ChatRoomDTO>) myChatList.get("chatList");
		List<Integer> unreadList = (List<Integer>) myChatList.get("unreadList");

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < chatList.size(); i++) {
			JSONObject list = new JSONObject();

			list.put("CHATROOM_CODE", chatList.get(i).getCHATROOM_CODE());
			list.put("CHATROOM_TITLE", chatList.get(i).getCHATROOM_TITLE());
			list.put("CHATROOM_MEMBER_COUNT", chatList.get(i).getCHATROOM_MEMBER_COUNT());
			list.put("UNREAD", unreadList.get(i));
			list.put("CHATROOM_CHIEF_CODE", chatList.get(i).getCHATROOM_CHIEF_CODE());

			jArray.add(list);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("list", jArray);

		PrintWriter out = response.getWriter();
		out.println(obj);
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

	// 일대일 채팅방에 참여하는 상대방 프로필 가져오기
	private void getOneChatMember(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int TO_MEMBER_CODE = Integer.parseInt(request.getParameter("TO_MEMBER_CODE"));

		MemberProfileDTO to_member = mBiz.selectMemberProfile(TO_MEMBER_CODE);
		to_member.setMEMBER_PASSWORD("");
		System.out.println(to_member);

		int res = 0;
		JSONObject obj = new JSONObject();

		if (to_member != null) {
			res = 1;
			// 상대방 정보
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
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		int startNo = Integer.parseInt(request.getParameter("startNo"));
		System.out.println("채팅방 번호 : " + CHATROOM_CODE);

		List<ChatMessageDTO> msgList = biz.selectChatMessageList(CHATROOM_CODE, MEMBER_CODE, startNo);

		String time = null;

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < msgList.size(); i++) {
			time = Format.isTwo(Integer.toString(msgList.get(i).getCHATMESSAGE_SENDDATE().getHours())) + ":"
					+ Format.isTwo(Integer.toString(msgList.get(i).getCHATMESSAGE_SENDDATE().getMinutes()));

			JSONObject in = new JSONObject();

			in.put("CHATROOM_CODE", msgList.get(i).getCHATROOM_CODE());
			in.put("CHATMESSAGE_CODE", msgList.get(i).getCHATMESSAGE_CODE());
			in.put("CHATMESSAGE_CONTENT", msgList.get(i).getCHATMESSAGE_CONTENT());
			in.put("CHATMESSAGE_FROM", msgList.get(i).getCHATMESSAGE_FROM());
			in.put("MEMBER_NICKNAME", msgList.get(i).getMEMBER_NICKNAME());
			in.put("MEMBER_IMG", msgList.get(i).getMPROFILE_IMG_SERVERNAME());

			in.put("TIME", time);

			jArray.add(in);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("item", jArray);

		PrintWriter out = response.getWriter();
		out.println(obj);
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
		System.out.println("보냄 " + CHAT_CONTENT + " " + res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 다대다 채팅방 생성하기
	private void createNChatRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CHIEF_CODE = Integer.parseInt(request.getParameter("CHATROOM_CHIEF_CODE"));
		String CHATROOM_TITLE = request.getParameter("CHATROOM_TITLE");

		ChatRoomDTO nRoom = new ChatRoomDTO();
		nRoom.setCHATROOM_CHIEF_CODE(CHATROOM_CHIEF_CODE);
		nRoom.setCHATROOM_TITLE(CHATROOM_TITLE);

		int res = 0;
		int CHATROOM_CODE = biz.createNtoNRoom(nRoom);
		JSONObject obj = new JSONObject();

		if (CHATROOM_CODE > 0) {
			res = 1;
			obj.put("CHATROOM_CODE", CHATROOM_CODE);
		}

		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 다대다 채팅방에 참여하는 회원들 프로필 가져오기
	private void getNChatMember(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		ChatRoomDTO nRoom = new ChatRoomDTO();
		nRoom.setCHATROOM_CODE(CHATROOM_CODE);
		nRoom.setMEMBER_CODE(MEMBER_CODE);

		List<MemberProfileDTO> mList = biz.selectNChatMember(nRoom);

		JSONArray jArray = new JSONArray();
		for (int i = 0; i < mList.size(); i++) {
			JSONObject list = new JSONObject();

			list.put("MEMBER_CODE", mList.get(i).getMEMBER_CODE());
			list.put("MEMBER_IMG", mList.get(i).getMPROFILE_IMG_SERVERNAME());
			list.put("MEMBER_NICKNAME", mList.get(i).getMEMBER_NICKNAME());

			jArray.add(list);
		}

		System.out.println(jArray.toString());

		JSONObject obj = new JSONObject();
		obj.put("list", jArray);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 내가 참여한 다대다 채팅방인지 아닌지 확인
	private void doNChatChk(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));
		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));

		ChatRoomDTO nChk = new ChatRoomDTO();
		nChk.setMEMBER_CODE(MEMBER_CODE);
		nChk.setCHATROOM_CODE(CHATROOM_CODE);

		int res = biz.countNChatChk(nChk);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 다대다 채팅방 참여하기
	private void nChatRoompage(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		MyChatroomListDTO mylist = new MyChatroomListDTO();
		mylist.setCHATROOM_CODE(CHATROOM_CODE);
		mylist.setMEMBER_CODE(MEMBER_CODE);

		int res = biz.gointoRoom(mylist);

		if (res > 0) {
			biz.increaseMemberCount(CHATROOM_CODE);
		}

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 채팅방 나간 순간 mylist OUTDATE 수정하기
	private void doUpdateOutDate(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		ChatRoomDTO update = new ChatRoomDTO();
		update.setCHATROOM_CODE(CHATROOM_CODE);
		update.setMEMBER_CODE(MEMBER_CODE);

		int res = biz.updateRoomOutDate(update);
		System.out.println("update 결과 : " + res);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 다대다 채팅방 나가기
	private void doGoOutNRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		int MEMBER_CODE = Integer.parseInt(request.getParameter("MEMBER_CODE"));

		MyChatroomListDTO mylist = new MyChatroomListDTO();
		mylist.setCHATROOM_CODE(CHATROOM_CODE);
		mylist.setMEMBER_CODE(MEMBER_CODE);

		int res = biz.gooutRoom(mylist);

		JSONObject obj = new JSONObject();
		obj.put("result", res);

		PrintWriter out = response.getWriter();
		out.println(obj);
	}

	// 채팅방 제목 수정하기 (방장만)
	private void doUpdateRoomTitle(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int CHATROOM_CODE = Integer.parseInt(request.getParameter("CHATROOM_CODE"));
		String CHATROOM_TITLE = request.getParameter("CHATROOM_TITLE");

		ChatRoomDTO update = new ChatRoomDTO();
		update.setCHATROOM_CODE(CHATROOM_CODE);
		update.setCHATROOM_TITLE(CHATROOM_TITLE);

		int res = biz.updateRoomTitle(update);

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
