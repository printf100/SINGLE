package com.single.model.dto.board;

public class ReplyLikesDTO {

	private int REPLY_CODE;
	private int RESALE_CODE;

	public ReplyLikesDTO() {
	}

	public ReplyLikesDTO(int rEPLY_CODE, int rESALE_CODE) {
		REPLY_CODE = rEPLY_CODE;
		RESALE_CODE = rESALE_CODE;
	}

	public int getREPLY_CODE() {
		return REPLY_CODE;
	}

	public void setREPLY_CODE(int rEPLY_CODE) {
		REPLY_CODE = rEPLY_CODE;
	}

	public int getRESALE_CODE() {
		return RESALE_CODE;
	}

	public void setRESALE_CODE(int rESALE_CODE) {
		RESALE_CODE = rESALE_CODE;
	}

	@Override
	public String toString() {
		return "ReplyLikesDTO [REPLY_CODE=" + REPLY_CODE + ", RESALE_CODE=" + RESALE_CODE + "]";
	}

}
