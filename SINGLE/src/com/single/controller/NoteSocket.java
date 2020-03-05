package com.single.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;

@ServerEndpoint(value = "/websocket_note", configurator = ChatConfigurator.class)
public class NoteSocket {

	public HttpSession httpSession;
	public Session session;

	public int MEMBER_CODE = 0;

	private static Map<Integer, Session> sessionMap = new HashMap<Integer, Session>();

	// 클라이언트가 접속할 때마다 이 클래스의 인스턴스가 새로 생성됨
	public NoteSocket() {
		// 서버측에서는 Thread가 새로 생성됨
		String threadName = "Thread Name : " + Thread.currentThread().getName();

		System.out.println(threadName);
	}

	// 클라이언트 접속 시 (웹 소켓이 연결됐을 시)
	@OnOpen
	public void onOpen(Session userSession, EndpointConfig config) {
		System.out.println("클라이언트 연결됨 (세션 아이디 : " + userSession.getId() + ")");
		// 한개의 브라우저에서 여러개의 탭을 사용해서 접속하면 Session은 서로 다르지만 HttpSession 은 동일함

		httpSession = (HttpSession) config.getUserProperties().get(ChatConfigurator.Session);

		MemberDTO loginMember = (MemberDTO) httpSession.getAttribute("loginMember");
		KakaoMemberDTO loginKakao = (KakaoMemberDTO) httpSession.getAttribute("loginKakao");
		NaverMemberDTO loginNaver = (NaverMemberDTO) httpSession.getAttribute("loginNaver");

		if (httpSession.getAttribute("loginMember") != null) {
			MEMBER_CODE = loginMember.getMEMBER_CODE();
		}

		if (httpSession.getAttribute("loginKakao") != null) {
			MEMBER_CODE = loginKakao.getMEMBER_CODE();
		}

		if (httpSession.getAttribute("loginNaver") != null) {
			MEMBER_CODE = loginNaver.getMEMBER_CODE();
		}

		System.out.println("http세션 MEMBER_CODE : " + MEMBER_CODE);

		sessionMap.put(MEMBER_CODE, userSession);
	}

	// 현재 세션과 연결된 클라이언트로부터 메세지가 도착할 때마다 새로운 쓰레드 실행
	@OnMessage
	public void onMessage(String obj, Session userSession) {
		String threadName = "Thread Name : " + Thread.currentThread().getName();
		System.out.println(threadName + " , " + MEMBER_CODE + " , " + userSession.getId());

		try {
			// 문자열로 넘어온 JSON 오브젝트를 JSON 오브젝트로~
			JSONObject json = (JSONObject) new JSONParser().parse(obj);
			System.out.println(json);

			Set<Integer> keys = sessionMap.keySet();
			Iterator<Integer> iter = keys.iterator();
			while (iter.hasNext()) {
				Integer key = iter.next();
				session = sessionMap.get(key);

				if (json.get("NOTE_TO_CODE").equals(Integer.toString(key))) {
					session.getBasicRemote().sendText(json.get("NOTE_TITLE").toString());
				}
			}

		} catch (ParseException | IOException e) {
			e.printStackTrace();
		}
	}

	// 클라이언트 접속 해제 시 (웹 소켓 연결이 해제됐을 시)
	@OnClose
	public void onClose(Session userSession) {
		System.out.println("클라이언트 연결 해제됨");

		sessionMap.remove(MEMBER_CODE);
	}

	@OnError
	public void handleError(Throwable e, Session userSession) {
		e.printStackTrace();
	}
}
