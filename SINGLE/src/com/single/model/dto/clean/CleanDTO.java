package com.single.model.dto.clean;

public class CleanDTO {
	private int CLEAN_CODE;
	private int MEMBER_CODE;
	private String CLEAN_POSTCODE;
	private String CLEAN_ADDRESS;
	private String CLEAN_DETAIL_ADDRESS;
	private String CLEAN_TIME;
	private String CLEAN_REGDATE;
	private int CLEAN_MANAGER;

	public CleanDTO() {
	}

	@Override
	public String toString() {
		return "CleanDTO [CLEAN_CODE=" + CLEAN_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", CLEAN_POSTCODE="
				+ CLEAN_POSTCODE + ", CLEAN_ADDRESS=" + CLEAN_ADDRESS + ", CLEAN_DETAIL_ADDRESS=" + CLEAN_DETAIL_ADDRESS
				+ ", CLEAN_TIME=" + CLEAN_TIME + ", CLEAN_REGDATE=" + CLEAN_REGDATE + ", CLEAN_MANAGER=" + CLEAN_MANAGER
				+ "]";
	}

	public int getCLEAN_CODE() {
		return CLEAN_CODE;
	}

	public void setCLEAN_CODE(int cLEAN_CODE) {
		CLEAN_CODE = cLEAN_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getCLEAN_POSTCODE() {
		return CLEAN_POSTCODE;
	}

	public void setCLEAN_POSTCODE(String cLEAN_POSTCODE) {
		CLEAN_POSTCODE = cLEAN_POSTCODE;
	}

	public String getCLEAN_ADDRESS() {
		return CLEAN_ADDRESS;
	}

	public void setCLEAN_ADDRESS(String cLEAN_ADDRESS) {
		CLEAN_ADDRESS = cLEAN_ADDRESS;
	}

	public String getCLEAN_DETAIL_ADDRESS() {
		return CLEAN_DETAIL_ADDRESS;
	}

	public void setCLEAN_DETAIL_ADDRESS(String cLEAN_DETAIL_ADDRESS) {
		CLEAN_DETAIL_ADDRESS = cLEAN_DETAIL_ADDRESS;
	}

	public String getCLEAN_TIME() {
		return CLEAN_TIME;
	}

	public void setCLEAN_TIME(String cLEAN_TIME) {
		CLEAN_TIME = cLEAN_TIME;
	}

	public String getCLEAN_REGDATE() {
		return CLEAN_REGDATE;
	}

	public void setCLEAN_REGDATE(String cLEAN_REGDATE) {
		CLEAN_REGDATE = cLEAN_REGDATE;
	}

	public int getCLEAN_MANAGER() {
		return CLEAN_MANAGER;
	}

	public void setCLEAN_MANAGER(int cLEAN_MANAGER) {
		CLEAN_MANAGER = cLEAN_MANAGER;
	}

}
