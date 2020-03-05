package com.single.model.biz.chat;

import java.util.HashMap;
import java.util.List;

import com.single.model.dao.chat.ChatDAO;
import com.single.model.dao.chat.ChatDAOImpl;
import com.single.model.dto.chat.ChatDTO;
import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.MemberProfileDTO;

public class ChatBizImpl implements ChatBiz {

	ChatDAO dao = new ChatDAOImpl();
	
	// 이메일로 회원 찾기
	@Override
	public MemberProfileDTO findMember(String MEMBER_EMAIL) {
		return dao.findMember(MEMBER_EMAIL);
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
		
		if(create_res > 0) {
			ChatRoomDTO new_room = dao.getChatroomCode(MY_MEMBER_CODE);
			MyChatroomListDTO addRoom = new MyChatroomListDTO();
			
			// 생성한 사람만 일단 mylist에 insert
			addRoom.setCHATROOM_CODE(new_room.getCHATROOM_CODE());
			addRoom.setMEMBER_CODE(MY_MEMBER_CODE);

			gointo_res = dao.gointoRoom(addRoom);
			if(gointo_res > 0) {
				// 채팅방 번호 가져오기
				room_code = addRoom.getCHATROOM_CODE();
				System.out.println("ChatBizImpl - 새로 생성된 채팅방 : " + room_code);
			}
			
			return room_code;
			
		} else {
			return create_res;			
		}
	}

	// 채팅방 처음 생성하기 (다대다)
	@Override
	public int createNtoNRoom(ChatRoomDTO nRoom) {
		return dao.createNtoNRoom(nRoom);
	}

	// 내가 참여중인 일대일 채팅방 리스트 가져오기
	@Override
	public List<ChatRoomDTO> selectOnetoOneChatList(int MEMBER_CODE) {
		return dao.selectOnetoOneChatList(MEMBER_CODE);
	}

	// 내가 참여중인 다대다 채팅방 리스트 가져오기
	@Override
	public List<ChatRoomDTO> selectNtoNChatList(int MEMBER_CODE) {
		return dao.selectNtoNChatList(MEMBER_CODE);
	}

	// 대화 한적이 있는지 검사
	@Override
	public Integer countOneChatChk(int MY_MEMBER_CODE, int TO_MEMBER_CODE) {
		return dao.countOneChatChk(MY_MEMBER_CODE, TO_MEMBER_CODE);
	}
	
	// 채팅방에 참여했을 때 (첫 메세지가 전송됐을 때)
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

	/*
	 * 채팅메세지
	 */
	
	// 채팅메세지 최근부터 20개씩 뿌려주기
	@Override
	public List<ChatMessageDTO> selectChatMessageList(int CHATROOM_CODE) {
		return dao.selectChatMessageList(CHATROOM_CODE);
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

	
//	// 채팅방 리스트 가져오기
//	@Override
//	public List<ChatDTO> selectChatListById(ChatDTO chat) {
//		return dao.selectChatListById(chat);
//	}

}
