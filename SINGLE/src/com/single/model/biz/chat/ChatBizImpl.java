package com.single.model.biz.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.single.model.dao.chat.ChatDAO;
import com.single.model.dao.chat.ChatDAOImpl;
import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.MemberProfileDTO;

public class ChatBizImpl implements ChatBiz {

	ChatDAO dao = new ChatDAOImpl();

	// 이메일로 회원 찾기
	@Override
	public List<MemberProfileDTO> findMember(int MY_MEMBER_CODE, String MEMBER_ACCOUNT) {
		return dao.findMember(MY_MEMBER_CODE, MEMBER_ACCOUNT);
	}

	/*
	 * 채팅방
	 */

	// 채팅방 처음 생성하고 채팅방 번호 리턴 (일대일)
	@Override
	public int createOnetoOneRoom(int MY_MEMBER_CODE) {

		int create_res = dao.createOnetoOneRoom(MY_MEMBER_CODE);
		int gointo_res = 0;
		int room_code = 0;

		if (create_res > 0) {
			ChatRoomDTO new_room = dao.getOneChatroomCode(MY_MEMBER_CODE);
			MyChatroomListDTO addRoom = new MyChatroomListDTO();

			// 생성한 사람만 일단 mylist에 insert
			addRoom.setCHATROOM_CODE(new_room.getCHATROOM_CODE());
			addRoom.setMEMBER_CODE(MY_MEMBER_CODE);

			gointo_res = dao.gointoRoom(addRoom);
			if (gointo_res > 0) {
				// 채팅방 번호 가져오기
				room_code = addRoom.getCHATROOM_CODE();
				System.out.println("ChatBizImpl - 새로 생성된 채팅방 : " + room_code);

				return room_code;

			} else {
				return gointo_res;
			}

		} else {
			return create_res;
		}
	}

	// 채팅방 처음 생성하기 (다대다)
	@Override
	public int createNtoNRoom(ChatRoomDTO nRoom) {

		int create_res = dao.createNtoNRoom(nRoom);
		int gointo_res = 0;
		int room_code = 0;

		if (create_res > 0) {
			ChatRoomDTO new_room = dao.getNChatroomCode(nRoom.getCHATROOM_CHIEF_CODE());
			MyChatroomListDTO addRoom = new MyChatroomListDTO();

			// 생성한 사람 mylist에 insert
			addRoom.setCHATROOM_CODE(new_room.getCHATROOM_CODE());
			addRoom.setMEMBER_CODE(new_room.getCHATROOM_CHIEF_CODE());

			gointo_res = dao.gointoRoom(addRoom);
			if (gointo_res > 0) {
				// 채팅방 번호 가져오기
				room_code = addRoom.getCHATROOM_CODE();
				System.out.println("ChatBizImpl - 새로 생성된 채팅방 : " + room_code);

				return room_code;

			} else {
				return gointo_res;
			}

		} else {
			return create_res;
		}
	}

	// 내가 참여중인 일대일 채팅방 리스트 가져오기
	@Override
	public Map<String, Object> selectOnetoOneChatList(int MEMBER_CODE) {

		List<ChatRoomDTO> chatList = dao.selectOnetoOneChatList(MEMBER_CODE);

		List<Integer> unreadList = new ArrayList<Integer>();
		for (int i = 0; i < chatList.size(); i++) {
			ChatRoomDTO dto = new ChatRoomDTO();
			dto.setCHATROOM_CODE(chatList.get(i).getCHATROOM_CODE());
			dto.setMEMBER_CODE(MEMBER_CODE);

			int msgCnt = dao.unreadMsgCount(dto); // 안읽은 메세지 갯수
			unreadList.add(msgCnt);
		}

		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("chatList", chatList);
		listMap.put("unreadList", unreadList);

		return listMap;
	}

	// 내가 참여중인 다대다 채팅방 리스트 가져오기
	@Override
	public Map<String, Object> selectNtoNChatList(int MEMBER_CODE) {

		List<ChatRoomDTO> chatList = dao.selectNtoNChatList(MEMBER_CODE);

		List<Integer> unreadList = new ArrayList<Integer>();
		for (int i = 0; i < chatList.size(); i++) {
			ChatRoomDTO dto = new ChatRoomDTO();
			dto.setCHATROOM_CODE(chatList.get(i).getCHATROOM_CODE());
			dto.setMEMBER_CODE(MEMBER_CODE);

			int msgCnt = dao.unreadMsgCount(dto); // 안읽은 메세지 갯수
			unreadList.add(msgCnt);
		}

		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("chatList", chatList);
		listMap.put("unreadList", unreadList);

		return listMap;
	}

	// 전체 채팅방 리스트 불러오기
	@Override
	public List<ChatRoomDTO> selectNtoNChatList() {
		return dao.selectNtoNChatList();
	}

	// 제목으로 다대다 채팅방 검색하기
	@Override
	public List<ChatRoomDTO> searchNtoNChatRoom(String SEARCH_CHATROOM_TITLE) {
		return dao.searchNtoNChatRoom(SEARCH_CHATROOM_TITLE);
	}

	// 대화 한적이 있는지 검사
	@Override
	public Integer countOneChatChk(int MY_MEMBER_CODE, int TO_MEMBER_CODE) {
		return dao.countOneChatChk(MY_MEMBER_CODE, TO_MEMBER_CODE);
	}

	// 내가 참여중인 다대다 채팅방인지 아닌지 확인하기
	@Override
	public int countNChatChk(ChatRoomDTO nChk) {
		return dao.countNChatChk(nChk);
	}

	// 채팅방에 참여했을 때
	@Override
	public int gointoRoom(MyChatroomListDTO mylist) {
		return dao.gointoRoom(mylist);
	}

	// 다대다 채팅방에 사람이 들어왔을 때 참여자수 + 1
	@Override
	public int increaseMemberCount(int room_code) {
		return dao.increaseMemberCount(room_code);
	}

	// 다대다 채팅방 제목 수정하기
	@Override
	public int updateRoomTitle(ChatRoomDTO nRoom) {
		return dao.updateRoomTitle(nRoom);
	}

	// 다대다 채팅방에 참여 중인 회원들 정보 가져오기
	@Override
	public List<MemberProfileDTO> selectNChatMember(ChatRoomDTO nRoom) {
		return dao.selectNChatMember(nRoom);
	}

	// 다대다 채팅방 나가기
	@Override
	public int gooutRoom(MyChatroomListDTO mylist) {

		int goout_res = dao.gooutRoom(mylist);
		int updateCnt_res = 0;

		if (goout_res > 0) {
			// 채팅방의 참여자 수 - 1
			updateCnt_res = dao.decreaseMemberCount(mylist.getCHATROOM_CODE());

			return updateCnt_res;

		} else {
			return goout_res;
		}
	}

	/*
	 * 채팅메세지
	 */

	// 채팅메세지 최근부터 20개씩 뿌려주기
	@Override
	public List<ChatMessageDTO> selectChatMessageList(int CHATROOM_CODE, int MEMBER_CODE, int startNo) {
		return dao.selectChatMessageList(CHATROOM_CODE, MEMBER_CODE, startNo);
	}

	// 메세지 전송하기
	@Override
	public int sendMessage(ChatMessageDTO message) {
		return dao.sendMessage(message);
	}

	// 어떤 채팅방의 메세지 갯수 (상대방 mylist에 insert하기 위함)
	@Override
	public int getMessageCount(int CHATROOM_CODE) {
		return dao.getMessageCount(CHATROOM_CODE);
	}

	// 채팅방 닫은 순간에 OUTDATE 수정 (안 읽은 메세지 갯수 출력하기 위함)
	@Override
	public int updateRoomOutDate(ChatRoomDTO dto) {
		return dao.updateRoomOutDate(dto);
	}

	// 채팅방마다 안 읽은 메세지 갯수
	@Override
	public int unreadMsgCount(ChatRoomDTO dto) {
		return dao.unreadMsgCount(dto);
	}

}
