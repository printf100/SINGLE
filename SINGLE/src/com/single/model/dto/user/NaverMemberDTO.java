package com.single.model.dto.user;

import java.sql.Date;

public class NaverMemberDTO {
	private int MEMBER_CODE;

	private int MEMBER_VERIFY;
	private String MEMBER_EMAIL;
	private String MEMBER_PASSWORD;
	private String MEMBER_NAME;
	private String MEMBER_NICKNAME;
	private String MEMBER_GENDER;
	
	private Date MEMBER_REGDATE;
	private String MEMBER_ENABLED;
	
	private String NAVER_ID;
	private String NAVER_NICKNAME;
	
	public NaverMemberDTO() {
	}

	public NaverMemberDTO(int mEMBER_CODE, int mEMBER_VERIFY, String mEMBER_EMAIL, String mEMBER_PASSWORD,
			String mEMBER_NAME, String mEMBER_NICKNAME, String mEMBER_GENDER, Date mEMBER_REGDATE,
			String mEMBER_ENABLED, String nAVER_ID, String nAVER_NICKNAME) {
		super();
		MEMBER_CODE = mEMBER_CODE;
		MEMBER_VERIFY = mEMBER_VERIFY;
		MEMBER_EMAIL = mEMBER_EMAIL;
		MEMBER_PASSWORD = mEMBER_PASSWORD;
		MEMBER_NAME = mEMBER_NAME;
		MEMBER_NICKNAME = mEMBER_NICKNAME;
		MEMBER_GENDER = mEMBER_GENDER;
		MEMBER_REGDATE = mEMBER_REGDATE;
		MEMBER_ENABLED = mEMBER_ENABLED;
		NAVER_ID = nAVER_ID;
		NAVER_NICKNAME = nAVER_NICKNAME;
	}

	@Override
	public String toString() {
		return "NaverMemberDTO [MEMBER_CODE=" + MEMBER_CODE + ", MEMBER_VERIFY=" + MEMBER_VERIFY + ", MEMBER_EMAIL="
				+ MEMBER_EMAIL + ", MEMBER_PASSWORD=" + MEMBER_PASSWORD + ", MEMBER_NAME=" + MEMBER_NAME
				+ ", MEMBER_NICKNAME=" + MEMBER_NICKNAME + ", MEMBER_GENDER=" + MEMBER_GENDER + ", MEMBER_REGDATE="
				+ MEMBER_REGDATE + ", MEMBER_ENABLED=" + MEMBER_ENABLED + ", NAVER_ID=" + NAVER_ID + ", NAVER_NICKNAME="
				+ NAVER_NICKNAME + "]";
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getMEMBER_VERIFY() {
		return MEMBER_VERIFY;
	}

	public void setMEMBER_VERIFY(int mEMBER_VERIFY) {
		MEMBER_VERIFY = mEMBER_VERIFY;
	}

	public String getMEMBER_EMAIL() {
		return MEMBER_EMAIL;
	}

	public void setMEMBER_EMAIL(String mEMBER_EMAIL) {
		MEMBER_EMAIL = mEMBER_EMAIL;
	}

	public String getMEMBER_PASSWORD() {
		return MEMBER_PASSWORD;
	}

	public void setMEMBER_PASSWORD(String mEMBER_PASSWORD) {
		MEMBER_PASSWORD = mEMBER_PASSWORD;
	}

	public String getMEMBER_NAME() {
		return MEMBER_NAME;
	}

	public void setMEMBER_NAME(String mEMBER_NAME) {
		MEMBER_NAME = mEMBER_NAME;
	}

	public String getMEMBER_NICKNAME() {
		return MEMBER_NICKNAME;
	}

	public void setMEMBER_NICKNAME(String mEMBER_NICKNAME) {
		MEMBER_NICKNAME = mEMBER_NICKNAME;
	}

	public String getMEMBER_GENDER() {
		return MEMBER_GENDER;
	}

	public void setMEMBER_GENDER(String mEMBER_GENDER) {
		MEMBER_GENDER = mEMBER_GENDER;
	}

	public Date getMEMBER_REGDATE() {
		return MEMBER_REGDATE;
	}

	public void setMEMBER_REGDATE(Date mEMBER_REGDATE) {
		MEMBER_REGDATE = mEMBER_REGDATE;
	}

	public String getMEMBER_ENABLED() {
		return MEMBER_ENABLED;
	}

	public void setMEMBER_ENABLED(String mEMBER_ENABLED) {
		MEMBER_ENABLED = mEMBER_ENABLED;
	}

	public String getNAVER_ID() {
		return NAVER_ID;
	}

	public void setNAVER_ID(String nAVER_ID) {
		NAVER_ID = nAVER_ID;
	}

	public String getNAVER_NICKNAME() {
		return NAVER_NICKNAME;
	}

	public void setNAVER_NICKNAME(String nAVER_NICKNAME) {
		NAVER_NICKNAME = nAVER_NICKNAME;
	}
	
}
