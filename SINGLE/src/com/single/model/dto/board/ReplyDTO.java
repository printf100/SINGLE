package com.single.model.dto.board;

import java.sql.Date;

public class ReplyDTO {

	private int REPLY_CODE;
	private int MEMBER_CODE;
	private int RESALE_CODE;
	private String REPLY_CONTENT;
	private int REPLY_COUNT;
	private int REPLY_LIKE;
	private Date REPLY_REGDATE;
	private String MEMBER_NICKNAME;

	public ReplyDTO() {
	}

	public ReplyDTO(int rEPLY_CODE, int mEMBER_CODE, int rESALE_CODE, String rEPLY_CONTENT, int rEPLY_LIKE,
			Date rEPLY_REGDATE, String mEMBER_NICKNAME) {
		REPLY_CODE = rEPLY_CODE;
		MEMBER_CODE = mEMBER_CODE;
		RESALE_CODE = rESALE_CODE;
		REPLY_CONTENT = rEPLY_CONTENT;
		REPLY_LIKE = rEPLY_LIKE;
		REPLY_REGDATE = rEPLY_REGDATE;
		MEMBER_NICKNAME = mEMBER_NICKNAME;
	}

	// 중고 게시판 댓글 입력
	public ReplyDTO(int rESALE_CODE, int mEMBER_CODE, String rEPLY_CONTENT) {
		MEMBER_CODE = mEMBER_CODE;
		RESALE_CODE = rESALE_CODE;
		REPLY_CONTENT = rEPLY_CONTENT;
	}

	public int getREPLY_CODE() {
		return REPLY_CODE;
	}

	public void setREPLY_CODE(int rEPLY_CODE) {
		REPLY_CODE = rEPLY_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getRESALE_CODE() {
		return RESALE_CODE;
	}

	public void setRESALE_CODE(int rESALE_CODE) {
		RESALE_CODE = rESALE_CODE;
	}

	public String getREPLY_CONTENT() {
		return REPLY_CONTENT;
	}

	public void setREPLY_CONTENT(String rEPLY_CONTENT) {
		REPLY_CONTENT = rEPLY_CONTENT;
	}

	public int getREPLY_COUNT() {
		return REPLY_COUNT;
	}

	public void setREPLY_COUNT(int rEPLY_COUNT) {
		REPLY_COUNT = rEPLY_COUNT;
	}

	public int getREPLY_LIKE() {
		return REPLY_LIKE;
	}

	public void setREPLY_LIKE(int rEPLY_LIKE) {
		REPLY_LIKE = rEPLY_LIKE;
	}

	public Date getREPLY_REGDATE() {
		return REPLY_REGDATE;
	}

	public void setREPLY_REGDATE(Date rEPLY_REGDATE) {
		REPLY_REGDATE = rEPLY_REGDATE;
	}

	public String getMEMBER_NICKNAME() {
		return MEMBER_NICKNAME;
	}

	public void setMEMBER_NICKNAME(String mEMBER_NICKNAME) {
		MEMBER_NICKNAME = mEMBER_NICKNAME;
	}

	@Override
	public String toString() {
		return "ReplyDTO [REPLY_CODE=" + REPLY_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", RESALE_CODE=" + RESALE_CODE
				+ ", REPLY_CONTENT=" + REPLY_CONTENT + ", REPLY_COUNT=" + REPLY_COUNT + ", REPLY_LIKE=" + REPLY_LIKE
				+ ", REPLY_REGDATE=" + REPLY_REGDATE + ", MEMBER_NICKNAME=" + MEMBER_NICKNAME + "]";
	}

}
