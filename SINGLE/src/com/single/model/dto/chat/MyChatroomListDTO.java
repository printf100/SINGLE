package com.single.model.dto.chat;

import java.util.Date;

public class MyChatroomListDTO {

	private int CHATROOM_CODE;
	private int MEMBER_CODE;
	private Date CHATMESSAGE_READDATE;

	public MyChatroomListDTO() {
	}

	public MyChatroomListDTO(int cHATROOM_CODE, int mEMBER_CODE, Date cHATMESSAGE_READDATE) {
		CHATROOM_CODE = cHATROOM_CODE;
		MEMBER_CODE = mEMBER_CODE;
		CHATMESSAGE_READDATE = cHATMESSAGE_READDATE;
	}

	@Override
	public String toString() {
		return "MyChatroomListDTO [CHATROOM_CODE=" + CHATROOM_CODE + ", MEMBER_CODE=" + MEMBER_CODE
				+ ", CHATMESSAGE_READDATE=" + CHATMESSAGE_READDATE + "]";
	}

	public int getCHATROOM_CODE() {
		return CHATROOM_CODE;
	}

	public void setCHATROOM_CODE(int cHATROOM_CODE) {
		CHATROOM_CODE = cHATROOM_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public Date getCHATMESSAGE_READDATE() {
		return CHATMESSAGE_READDATE;
	}

	public void setCHATMESSAGE_READDATE(Date cHATMESSAGE_READDATE) {
		CHATMESSAGE_READDATE = cHATMESSAGE_READDATE;
	}

}
