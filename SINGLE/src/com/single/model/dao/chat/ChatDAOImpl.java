package com.single.model.dao.chat;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.mybatis.SqlMapConfig;

public class ChatDAOImpl extends SqlMapConfig implements ChatDAO {

	final String namespace = "com.single.chat-mapper";

	// 이메일로 회원 찾기
	@Override
	public MemberProfileDTO findMember(String MEMBER_EMAIL) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberProfileDTO profile = session.selectOne(namespace + ".findMember", MEMBER_EMAIL);

		session.close();

		return profile;
	}

	/*
	 * 채팅방
	 */

	// 채팅방 처음 생성하기 (일대일)
	@Override
	public int createOnetoOneRoom(int CHATROOM_CHIEF_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".createOnetoOneRoom", CHATROOM_CHIEF_CODE);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 채팅방 처음 생성하기 (다대다)
	@Override
	public int createNtoNRoom(ChatRoomDTO nRoom) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".createNtoNRoom", nRoom);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 채팅방에 참여했을 때 (첫 메세지가 전송됐을 때)
	@Override
	public int gointoRoom(MyChatroomListDTO mylist) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".gointoRoom", mylist);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 내가 참여중인 일대일 채팅방 리스트 가져오기
	@Override
	public List<ChatRoomDTO> selectOnetoOneChatList(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<ChatRoomDTO> myChatList = session.selectList(namespace + ".getMyOnetoOneChatList", MEMBER_CODE);

		session.close();

		return myChatList;
	}

	// 내가 참여중인 다대다 채팅방 리스트 가져오기
	@Override
	public List<ChatRoomDTO> selectNtoNChatList(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<ChatRoomDTO> myChatList = session.selectList(namespace + ".getMyNtoNChatList", MEMBER_CODE);

		session.close();

		return myChatList;
	}

	// 대화를 한적이 있는지 검사
	@Override
	public Integer countOneChatChk(int MY_MEMBER_CODE, int TO_MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("MY_MEMBER_CODE", MY_MEMBER_CODE);
		map.put("TO_MEMBER_CODE", TO_MEMBER_CODE);

		Integer res = session.selectOne(namespace + ".oneChatChk", map);

		session.close();

		return res;
	}

	// 생성된 채팅방 코드 가져오기 (처음 채팅방 생성시 사용하기 위해)
	@Override
	public ChatRoomDTO getChatroomCode(int CHATROOM_CHIEF_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		ChatRoomDTO room_code = session.selectOne(namespace + ".getChatRoomCode", CHATROOM_CHIEF_CODE);

		session.close();

		return room_code;
	}

	// 다대다 채팅방에 사람이 들어왔을 때 참여자수 + 1
	@Override
	public int increaseMemberCount(int room_code) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".increaseMemberCount", room_code);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 다대다 채팅방 제목 수정하기
	@Override
	public int updateRoomTitle(ChatRoomDTO nRoom) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateRoomTitle", nRoom);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	/*
	 * 채팅메세지
	 */

	// 채팅메세지 최근부터 20개씩 뿌려주기
	@Override
	public List<ChatMessageDTO> selectChatMessageList(int CHATROOM_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<ChatMessageDTO> messageList = session.selectList(namespace + ".getChatMessage", CHATROOM_CODE);

		session.close();

		return messageList;
	}

	// 메세지 전송하기
	@Override
	public int sendMessage(ChatMessageDTO message) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".sendMessage", message);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 어떤 채팅방의 메세지 갯수 (상대방 mylist에 insert하기 위함)
	@Override
	public int getMessageCount(int CHATROOM_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".getMessageCount", CHATROOM_CODE);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

//	// 채팅방 리스트 가져오기
//	@Override
//	public List<ChatDTO> selectChatListById(ChatDTO chat) {
//
//		SqlSession session = getSqlSessionFactory().openSession(false);
//
//		List<ChatDTO> chatList = session.selectList(namespace + ".getChatListById", chat);
//
//		session.close();
//
//		return chatList;
//	}

}
