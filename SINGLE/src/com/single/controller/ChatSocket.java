package com.single.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

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

import com.single.model.biz.member.MemberBiz;
import com.single.model.biz.member.MemberBizImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;

// handshake 설정을 위한 클래스 지정
@ServerEndpoint(value = "/websocket", configurator = ChatConfigurator.class)
public class ChatSocket {

	public HttpSession httpSession;
	public Session session;

	public int MEMBER_CODE = 0;
	public MemberProfileDTO member_profile = new MemberProfileDTO();
	MemberBiz mBiz = new MemberBizImpl();

	private static Map<Integer, Session> sessionMap = new HashMap<Integer, Session>();
	private static final Set<ChatSocket> connections = new CopyOnWriteArraySet<ChatSocket>();

	// 클라이언트가 접속할 때마다 이 클래스의 인스턴스가 새로 생성됨
	public ChatSocket() {
		// 서버측에서는 Thread가 새로 생성됨
		String threadName = "Thread Name : " + Thread.currentThread().getName();

		System.out.println(threadName);
	}

	// 메세지 전체 전송
	private void send(String text) {

		synchronized (sessionMap) {

			Set<Integer> keys = sessionMap.keySet();
			Iterator<Integer> iter = keys.iterator();

			while (iter.hasNext()) {
				Integer key = iter.next();
				session = sessionMap.get(key);

				try {
					session.getBasicRemote().sendText(text);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
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

		member_profile = mBiz.selectMemberProfile(MEMBER_CODE);
		member_profile.setMEMBER_PASSWORD("");
		System.out.println("http세션 MEMBER_CODE : " + MEMBER_CODE);

		connections.add(this); // 사용자 세션이 저장된 객체 set에 저장
		sessionMap.put(MEMBER_CODE, userSession);

		System.out.println(member_profile.getMEMBER_NICKNAME() + " " + sessionMap.size());
		send(member_profile.getMEMBER_NICKNAME() + "님이 입장하셨습니다. 총 접속자 수 : " + sessionMap.size());
	}

	// 현재 세션과 연결된 클라이언트로부터 메세지가 도착할 때마다 새로운 쓰레드 실행
	@OnMessage
	public void onMessage(String obj, Session userSession) {
		String threadName = "Thread Name : " + Thread.currentThread().getName();
		System.out.println(threadName + " , " + MEMBER_CODE + " , " + userSession.getId());

		JSONObject client = new JSONObject();

		try {
			// 문자열로 넘어온 JSON 오브젝트를 JSON 오브젝트로~
			JSONObject json = (JSONObject) new JSONParser().parse(obj);
			System.out.println(json);

			Set<Integer> keys = sessionMap.keySet();
			Iterator<Integer> iter = keys.iterator();
			while (iter.hasNext()) {
				Integer key = iter.next();
				session = sessionMap.get(key);

				client.put("profileimg", member_profile.getMPROFILE_IMG_SERVERNAME());
				client.put("nickname", member_profile.getMEMBER_NICKNAME());
				client.put("message", json.get("CHAT_CONTENT").toString());
				client.put("online", sessionMap.size());

				if (!json.get("MEMBER_CODE").equals(Integer.toString(key))) {
					session.getBasicRemote().sendText(client.toJSONString());
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

		connections.remove(this);
		sessionMap.remove(MEMBER_CODE);

		System.out.println(member_profile.getMEMBER_NICKNAME() + " " + sessionMap.size());
		send(member_profile.getMEMBER_NICKNAME() + "님이 퇴장하셨습니다. 총 접속자 수 : " + sessionMap.size());
	}

	@OnError
	public void handleError(Throwable e, Session userSession) {
		e.printStackTrace();
	}
}
