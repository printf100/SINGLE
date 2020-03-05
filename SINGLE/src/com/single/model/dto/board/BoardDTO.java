package com.single.model.dto.board;

import java.sql.Date;

public class BoardDTO {

	private int BOARD_CODE;
	private int MEMBER_CODE;
	private int BOARD_VERIFY; // 1 공지사항 / 2 동네게시판 / 3 중고장터
	private String BOARD_TITLE;
	private String BOARD_CONTENT;
	private Date BOARD_REGDATE;
	private int COUNT_VIEW;
	private int COUNT_REPLY;
	private String FILE_ORIGINAL;
	private String FILE_SERVER;

	public BoardDTO() {
	}

	public BoardDTO(int bOARD_CODE, int mEMBER_CODE, int bOARD_VERIFY, String bOARD_TITLE, String bOARD_CONTENT,
			Date bOARD_REGDATE, int cOUNT_VIEW, int cOUNT_REPLY, String fILE_ORIGINAL, String fILE_SERVER) {
		BOARD_CODE = bOARD_CODE;
		MEMBER_CODE = mEMBER_CODE;
		BOARD_VERIFY = bOARD_VERIFY;
		BOARD_TITLE = bOARD_TITLE;
		BOARD_CONTENT = bOARD_CONTENT;
		BOARD_REGDATE = bOARD_REGDATE;
		COUNT_VIEW = cOUNT_VIEW;
		COUNT_REPLY = cOUNT_REPLY;
		FILE_ORIGINAL = fILE_ORIGINAL;
		FILE_SERVER = fILE_SERVER;
	}

	// 관리자측 글 수정 이용(첨부파일 있을 때)
	public BoardDTO(String bOARD_TITLE, String bOARD_CONTENT, int bOARD_CODE, String fILE_ORIGINAL,
			String fILE_SERVER) {
		BOARD_TITLE = bOARD_TITLE;
		BOARD_CONTENT = bOARD_CONTENT;
		BOARD_CODE = bOARD_CODE;
		FILE_ORIGINAL = fILE_ORIGINAL;
		FILE_SERVER = fILE_SERVER;
	}

	// 관리자측 글 수정 이용(첨부파일 없을 때)
	public BoardDTO(String bOARD_TITLE, String bOARD_CONTENT, int bOARD_CODE) {
		BOARD_TITLE = bOARD_TITLE;
		BOARD_CONTENT = bOARD_CONTENT;
		BOARD_CODE = bOARD_CODE;

	}

	// 관리자측 글 쓰기 이용
	public BoardDTO(int mEMBER_CODE, String bOARD_TITLE, String bOARD_CONTENT) {
		BOARD_TITLE = bOARD_TITLE;
		BOARD_CONTENT = bOARD_CONTENT;
		MEMBER_CODE = mEMBER_CODE;
	}

	// 관리자측 첨부파일 있을 때 글 쓰기 이용
	public BoardDTO(int mEMBER_CODE, String bOARD_TITLE, String bOARD_CONTENT, String fILE_ORIGINAL,
			String fILE_SERVER) {
		MEMBER_CODE = mEMBER_CODE;
		BOARD_TITLE = bOARD_TITLE;
		BOARD_CONTENT = bOARD_CONTENT;
		FILE_ORIGINAL = fILE_ORIGINAL;
		FILE_SERVER = fILE_SERVER;
	}

	@Override
	public String toString() {
		return "BoardDTO [BOARD_CODE=" + BOARD_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", BOARD_VERIFY=" + BOARD_VERIFY
				+ ", BOARD_TITLE=" + BOARD_TITLE + ", BOARD_CONTENT=" + BOARD_CONTENT + ", BOARD_REGDATE="
				+ BOARD_REGDATE + ", COUNT_VIEW=" + COUNT_VIEW + ", COUNT_REPLY=" + COUNT_REPLY + ", FILE_ORIGINAL="
				+ FILE_ORIGINAL + ", FILE_SERVER=" + FILE_SERVER + "]";
	}

	public int getBOARD_CODE() {
		return BOARD_CODE;
	}

	public void setBOARD_CODE(int bOARD_CODE) {
		BOARD_CODE = bOARD_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getBOARD_VERIFY() {
		return BOARD_VERIFY;
	}

	public void setBOARD_VERIFY(int bOARD_VERIFY) {
		BOARD_VERIFY = bOARD_VERIFY;
	}

	public String getBOARD_TITLE() {
		return BOARD_TITLE;
	}

	public void setBOARD_TITLE(String bOARD_TITLE) {
		BOARD_TITLE = bOARD_TITLE;
	}

	public String getBOARD_CONTENT() {
		return BOARD_CONTENT;
	}

	public void setBOARD_CONTENT(String bOARD_CONTENT) {
		BOARD_CONTENT = bOARD_CONTENT;
	}

	public Date getBOARD_REGDATE() {
		return BOARD_REGDATE;
	}

	public void setBOARD_REGDATE(Date bOARD_REGDATE) {
		BOARD_REGDATE = bOARD_REGDATE;
	}

	public int getCOUNT_VIEW() {
		return COUNT_VIEW;
	}

	public void setCOUNT_VIEW(int cOUNT_VIEW) {
		COUNT_VIEW = cOUNT_VIEW;
	}

	public int getCOUNT_REPLY() {
		return COUNT_REPLY;
	}

	public void setCOUNT_REPLY(int cOUNT_REPLY) {
		COUNT_REPLY = cOUNT_REPLY;
	}

	public String getFILE_ORIGINAL() {
		return FILE_ORIGINAL;
	}

	public void setFILE_ORIGINAL(String fILE_ORIGINAL) {
		FILE_ORIGINAL = fILE_ORIGINAL;
	}

	public String getFILE_SERVER() {
		return FILE_SERVER;
	}

	public void setFILE_SERVER(String fILE_SERVER) {
		FILE_SERVER = fILE_SERVER;
	}

}
