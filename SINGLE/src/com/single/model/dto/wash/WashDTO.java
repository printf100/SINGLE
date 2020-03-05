package com.single.model.dto.wash;

public class WashDTO {
	private int WASH_CODE;
	private int MEMBER_CODE;
	private String WASH_POSTCODE;
	private String WASH_ADDRESS;
	private String WASH_DETAIL_ADDRESS;
	private String WASH_TIME;
	private String WASH_REGDATE;
	private int WASH_MANAGER;

	public WashDTO() {
	}

	@Override
	public String toString() {
		return "WashDTO [WASH_CODE=" + WASH_CODE + ", MEMBER_CODE=" + MEMBER_CODE + ", WASH_POSTCODE=" + WASH_POSTCODE
				+ ", WASH_ADDRESS=" + WASH_ADDRESS + ", WASH_DETAIL_ADDRESS=" + WASH_DETAIL_ADDRESS + ", WASH_TIME="
				+ WASH_TIME + ", WASH_REGDATE=" + WASH_REGDATE + ", WASH_MANAGER=" + WASH_MANAGER + "]";
	}

	public int getWASH_CODE() {
		return WASH_CODE;
	}

	public void setWASH_CODE(int wASH_CODE) {
		WASH_CODE = wASH_CODE;
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public String getWASH_POSTCODE() {
		return WASH_POSTCODE;
	}

	public void setWASH_POSTCODE(String wASH_POSTCODE) {
		WASH_POSTCODE = wASH_POSTCODE;
	}

	public String getWASH_ADDRESS() {
		return WASH_ADDRESS;
	}

	public void setWASH_ADDRESS(String wASH_ADDRESS) {
		WASH_ADDRESS = wASH_ADDRESS;
	}

	public String getWASH_DETAIL_ADDRESS() {
		return WASH_DETAIL_ADDRESS;
	}

	public void setWASH_DETAIL_ADDRESS(String wASH_DETAIL_ADDRESS) {
		WASH_DETAIL_ADDRESS = wASH_DETAIL_ADDRESS;
	}

	public String getWASH_TIME() {
		return WASH_TIME;
	}

	public void setWASH_TIME(String wASH_TIME) {
		WASH_TIME = wASH_TIME;
	}

	public String getWASH_REGDATE() {
		return WASH_REGDATE;
	}

	public void setWASH_REGDATE(String wASH_REGDATE) {
		WASH_REGDATE = wASH_REGDATE;
	}

	public int getWASH_MANAGER() {
		return WASH_MANAGER;
	}

	public void setWASH_MANAGER(int wASH_MANAGER) {
		WASH_MANAGER = wASH_MANAGER;
	}

}
