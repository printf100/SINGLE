package com.single.model.dto.chat;

public class ChatDTO {

	private int CHAT_ROOM_CODE;
	private int CHAT_FROM_MEMBER;
	private int CHAT_TO_MEMBER;
	private String CHAT_CONTENT;
	private String CHAT_TIME;

	public ChatDTO() {
	}

	public ChatDTO(int cHAT_ROOM_CODE, int cHAT_FROM_MEMBER, int cHAT_TO_MEMBER, String cHAT_CONTENT,
			String cHAT_TIME) {
		super();
		CHAT_ROOM_CODE = cHAT_ROOM_CODE;
		CHAT_FROM_MEMBER = cHAT_FROM_MEMBER;
		CHAT_TO_MEMBER = cHAT_TO_MEMBER;
		CHAT_CONTENT = cHAT_CONTENT;
		CHAT_TIME = cHAT_TIME;
	}

	@Override
	public String toString() {
		return "ChatDTO [CHAT_ROOM_CODE=" + CHAT_ROOM_CODE + ", CHAT_FROM_MEMBER=" + CHAT_FROM_MEMBER
				+ ", CHAT_TO_MEMBER=" + CHAT_TO_MEMBER + ", CHAT_CONTENT=" + CHAT_CONTENT + ", CHAT_TIME=" + CHAT_TIME
				+ "]";
	}

	public int getCHAT_ROOM_CODE() {
		return CHAT_ROOM_CODE;
	}

	public void setCHAT_ROOM_CODE(int cHAT_ROOM_CODE) {
		CHAT_ROOM_CODE = cHAT_ROOM_CODE;
	}

	public int getCHAT_FROM_MEMBER() {
		return CHAT_FROM_MEMBER;
	}

	public void setCHAT_FROM_MEMBER(int cHAT_FROM_MEMBER) {
		CHAT_FROM_MEMBER = cHAT_FROM_MEMBER;
	}

	public int getCHAT_TO_MEMBER() {
		return CHAT_TO_MEMBER;
	}

	public void setCHAT_TO_MEMBER(int cHAT_TO_MEMBER) {
		CHAT_TO_MEMBER = cHAT_TO_MEMBER;
	}

	public String getCHAT_CONTENT() {
		return CHAT_CONTENT;
	}

	public void setCHAT_CONTENT(String cHAT_CONTENT) {
		CHAT_CONTENT = cHAT_CONTENT;
	}

	public String getCHAT_TIME() {
		return CHAT_TIME;
	}

	public void setCHAT_TIME(String cHAT_TIME) {
		CHAT_TIME = cHAT_TIME;
	}

}
