package com.single.model.dto.board;

import java.util.Date;

public class FileDTO {

	private int FILE_CODE;
	private int BOARD_CODE;
	private int MEMBER_CODE;
	private String FILE_ORIGINAL_NAME;
	private String FILE_SERVER_NAME;
	private String FILE_PATH;
	private int FILE_SIZE;
	private Date FILE_DATE;

	public FileDTO() {
	}

	public FileDTO(int fILE_CODE, int bOARD_CODE, int mEMBER_CODE, String fILE_ORIGINAL_NAME, String fILE_SERVER_NAME,
			String fILE_PATH, int fILE_SIZE, Date fILE_DATE) {
		FILE_CODE = fILE_CODE;
		BOARD_CODE = bOARD_CODE;
		MEMBER_CODE = mEMBER_CODE;
		FILE_ORIGINAL_NAME = fILE_ORIGINAL_NAME;
		FILE_SERVER_NAME = fILE_SERVER_NAME;
		FILE_PATH = fILE_PATH;
		FILE_SIZE = fILE_SIZE;
		FILE_DATE = fILE_DATE;
	}

	@Override
	public String toString() {
		return "fileDTO [FILE_CODE=" + FILE_CODE + ", BOARD_CODE=" + BOARD_CODE + ", MEMBER_CODE=" + MEMBER_CODE
				+ ", FILE_ORIGINAL_NAME=" + FILE_ORIGINAL_NAME + ", FILE_SERVER_NAME=" + FILE_SERVER_NAME
				+ ", FILE_PATH=" + FILE_PATH + ", FILE_SIZE=" + FILE_SIZE + ", FILE_DATE=" + FILE_DATE + "]";
	}

	public int getFILE_CODE() {
		return FILE_CODE;
	}

	public void setFILE_CODE(int fILE_CODE) {
		FILE_CODE = fILE_CODE;
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

	public String getFILE_ORIGINAL_NAME() {
		return FILE_ORIGINAL_NAME;
	}

	public void setFILE_ORIGINAL_NAME(String fILE_ORIGINAL_NAME) {
		FILE_ORIGINAL_NAME = fILE_ORIGINAL_NAME;
	}

	public String getFILE_SERVER_NAME() {
		return FILE_SERVER_NAME;
	}

	public void setFILE_SERVER_NAME(String fILE_SERVER_NAME) {
		FILE_SERVER_NAME = fILE_SERVER_NAME;
	}

	public String getFILE_PATH() {
		return FILE_PATH;
	}

	public void setFILE_PATH(String fILE_PATH) {
		FILE_PATH = fILE_PATH;
	}

	public int getFILE_SIZE() {
		return FILE_SIZE;
	}

	public void setFILE_SIZE(int fILE_SIZE) {
		FILE_SIZE = fILE_SIZE;
	}

	public Date getFILE_DATE() {
		return FILE_DATE;
	}

	public void setFILE_DATE(Date fILE_DATE) {
		FILE_DATE = fILE_DATE;
	}

}
