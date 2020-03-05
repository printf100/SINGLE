package com.single.model.dto.board;

public class LikeDTO {

	private int MEMBER_CODE;
	private int RESALE_CODE;
	private String RESALE_TITLE;

	public LikeDTO() {
	}

	public LikeDTO(int mEMBER_CODE, int rESALE_CODE) {
		MEMBER_CODE = mEMBER_CODE;
		RESALE_CODE = rESALE_CODE;
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

	public String getRESALE_TITLE() {
		return RESALE_TITLE;
	}

	public void setRESALE_TITLE(String rESALE_TITLE) {
		RESALE_TITLE = rESALE_TITLE;
	}

	@Override
	public String toString() {
		return "LikeDTO [MEMBER_CODE=" + MEMBER_CODE + ", RESALE_CODE=" + RESALE_CODE + ", RESALE_TITLE=" + RESALE_TITLE
				+ "]";
	}

}
