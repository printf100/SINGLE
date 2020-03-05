package com.single.model.biz.chat;

import java.util.List;
import java.util.Map;

import com.single.model.dto.chat.ChatMessageDTO;
import com.single.model.dto.chat.ChatRoomDTO;
import com.single.model.dto.chat.MyChatroomListDTO;
import com.single.model.dto.member.MemberProfileDTO;

public interface ChatBiz {

	// 이메일로 회원 찾기
	public List<MemberProfileDTO> findMember(int MY_MEMBER_CODE, String MEMBER_ACCOUNT);

	/*
	 * 채팅방
	 */

	// 채팅방 처음 생성하기 (일대일)
	public int createOnetoOneRoom(int MY_MEMBER_CODE);

	// 채팅방 처음 생성하기 (다대다)
	public int createNtoNRoom(ChatRoomDTO nRoom);

	// 내가 참여중인 일대일 채팅방 리스트 가져오기
	public Map<String, Object> selectOnetoOneChatList(int MEMBER_CODE);

	// 내가 참여중인 다대다 채팅방 리스트 가져오기
	public Map<String, Object> selectNtoNChatList(int MEMBER_CODE);

	// 전체 다대다 채팅방 리스트 불러오기
	public List<ChatRoomDTO> selectNtoNChatList();

	// 제목으로 다대다 채팅방 검색하기
	public List<ChatRoomDTO> searchNtoNChatRoom(String SEARCH_CHATROOM_TITLE);

	// 일대일 대화를 한적이 있는지 검사
	public Integer countOneChatChk(int MY_MEMBER_CODE, int TO_MEMBER_CODE);

	// 내가 참여중인 다대다 채팅방인지 아닌지 확인하기
	public int countNChatChk(ChatRoomDTO nChk);

	// 채팅방에 참여했을 때
	public int gointoRoom(MyChatroomListDTO mylist);

	// 다대다 채팅방에 사람이 들어왔을 때 참여자수 + 1
	public int increaseMemberCount(int room_code);

	// 다대다 채팅방 제목 수정하기
	public int updateRoomTitle(ChatRoomDTO nRoom);

	// 다대다 채팅방에 참여 중인 회원들 정보 가져오기
	public List<MemberProfileDTO> selectNChatMember(ChatRoomDTO nRoom);

	// 다대다 채팅방 나가기
	public int gooutRoom(MyChatroomListDTO mylist);

	/*
	 * 채팅메세지
	 */

	// 채팅메세지 최근날짜부터 20개씩 뿌려주기
	public List<ChatMessageDTO> selectChatMessageList(int CHATROOM_CODE, int MEMBER_CODE, int startNo);

	// 메세지 전송하기
	public int sendMessage(ChatMessageDTO message);

	// 어떤 채팅방의 메세지 갯수 (상대방 mylist에 insert하기 위함)
	public int getMessageCount(int CHATROOM_CODE);

	// 채팅방 닫은 순간에 OUTDATE 수정 (안 읽은 메세지 갯수 출력하기 위함)
	public int updateRoomOutDate(ChatRoomDTO dto);

	// 채팅방마다 안 읽은 메세지 갯수
	public int unreadMsgCount(ChatRoomDTO dto);
}
