package com.single.model.dao.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.mybatis.SqlMapConfig;

public class ChatDAOImpl extends SqlMapConfig implements ChatDAO {

	final String namespace = "com.single.chat-mapper";

	// 이메일로 회원 찾기
	@Override
	public List<MemberProfileDTO> findMember(int MY_MEMBER_CODE, String MEMBER_ACCOUNT) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("MY_MEMBER_CODE", MY_MEMBER_CODE);
		map.put("MEMBER_ACCOUNT", MEMBER_ACCOUNT);

		List<MemberProfileDTO> profile_list = session.selectList(namespace + ".findMember", map);

		session.close();

		return profile_list;
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

	// 채팅방에 참여했을 때
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

	// 전체 다대다 채팅방 리스트 불러오기
	@Override
	public List<ChatRoomDTO> selectNtoNChatList() {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<ChatRoomDTO> nRoomList = session.selectList(namespace + ".getNChatRoomList");

		session.close();

		return nRoomList;
	}

	// 제목으로 다대다 채팅방 검색하기
	@Override
	public List<ChatRoomDTO> searchNtoNChatRoom(String SEARCH_CHATROOM_TITLE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<ChatRoomDTO> searchList = session.selectList(namespace + ".searchNChatRoom", SEARCH_CHATROOM_TITLE);

		session.close();

		return searchList;
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

	// 내가 참여중인 다대다 채팅방인지 아닌지 확인하기
	@Override
	public int countNChatChk(ChatRoomDTO nChk) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".nChatChk", nChk);

		session.close();

		return res;
	}

	// 생성된 일대일 채팅방 코드 가져오기 (처음 채팅방 생성시 사용하기 위해)
	@Override
	public ChatRoomDTO getOneChatroomCode(int CHATROOM_CHIEF_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		ChatRoomDTO room_code = session.selectOne(namespace + ".getOneChatRoomCode", CHATROOM_CHIEF_CODE);

		session.close();

		return room_code;
	}

	// 생성된 다대다 채팅방 코드 가져오기 (처음 채팅방 생성시 사용하기 위해)
	@Override
	public ChatRoomDTO getNChatroomCode(int CHATROOM_CHIEF_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		ChatRoomDTO room_code = session.selectOne(namespace + ".getNChatRoomCode", CHATROOM_CHIEF_CODE);

		session.close();

		return room_code;
	}

	// 다대다 채팅방에 사람이 들어왔을 때 참여자수 + 1
	@Override
	public int increaseMemberCount(int CHATROOM_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".increaseMemberCount", CHATROOM_CODE);
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

	// 다대다 채팅방에 참여 중인 회원들 정보 가져오기
	@Override
	public List<MemberProfileDTO> selectNChatMember(ChatRoomDTO nRoom) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<MemberProfileDTO> profiles = session.selectList(namespace + ".getNChatMember", nRoom);

		session.close();

		return profiles;
	}

	// 다대다 채팅방 나가기
	@Override
	public int gooutRoom(MyChatroomListDTO mylist) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".gooutRoom", mylist);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 다대다 채팅방 나가면 참여자수 - 1
	@Override
	public int decreaseMemberCount(int CHATROOM_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".decreaseMemberCount", CHATROOM_CODE);
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
	public List<ChatMessageDTO> selectChatMessageList(int CHATROOM_CODE, int MEMBER_CODE, int startNo) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("CHATROOM_CODE", CHATROOM_CODE);
		map.put("MEMBER_CODE", MEMBER_CODE);
		map.put("startNo", startNo);

		List<ChatMessageDTO> messageList = session.selectList(namespace + ".getChatMessage", map);

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

	// 채팅방 닫은 순간에 OUTDATE 수정 (안 읽은 메세지 갯수 출력하기 위함)
	@Override
	public int updateRoomOutDate(ChatRoomDTO dto) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateRoomOutDate", dto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 채팅방마다 안 읽은 메세지 갯수
	@Override
	public int unreadMsgCount(ChatRoomDTO dto) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".getUnreadMsgCount", dto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

}
