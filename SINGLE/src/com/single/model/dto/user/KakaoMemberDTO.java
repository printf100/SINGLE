package com.single.model.dto.user;

import java.sql.Date;

public class KakaoMemberDTO {
	private int MEMBER_CODE;

	private int MEMBER_VERIFY;
	private String MEMBER_EMAIL;
	private String MEMBER_PASSWORD;
	private String MEMBER_NAME;
	private String MEMBER_NICKNAME;
	private String MEMBER_GENDER;

	private Date MEMBER_REGDATE;
	private String MEMBER_ENABLED;

	private String KAKAO_ID;
	private String KAKAO_NICKNAME;

	public KakaoMemberDTO() {
	}

	// 카카오 회원가입 시 이용
	public KakaoMemberDTO(int mEMBER_VERIFY, String mEMBER_EMAIL, String mEMBER_NAME, String mEMBER_NICKNAME,
			String mEMBER_GENDER, String kAKAO_ID, String kAKAO_NICKNAME) {
		super();
		MEMBER_VERIFY = mEMBER_VERIFY;
		MEMBER_EMAIL = mEMBER_EMAIL;
		MEMBER_NAME = mEMBER_NAME;
		MEMBER_NICKNAME = mEMBER_NICKNAME;
		MEMBER_GENDER = mEMBER_GENDER;
		KAKAO_ID = kAKAO_ID;
		KAKAO_NICKNAME = kAKAO_NICKNAME;
	}

	public KakaoMemberDTO(int mEMBER_CODE, int mEMBER_VERIFY, String mEMBER_EMAIL, String mEMBER_PASSWORD,
			String mEMBER_NAME, String mEMBER_NICKNAME, String mEMBER_GENDER, Date mEMBER_REGDATE,
			String mEMBER_ENABLED, String kAKAO_ID, String kAKAO_NICKNAME) {
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
		KAKAO_ID = kAKAO_ID;
		KAKAO_NICKNAME = kAKAO_NICKNAME;
	}

	@Override
	public String toString() {
		return "KakaoMemberDTO [MEMBER_CODE=" + MEMBER_CODE + ", MEMBER_VERIFY=" + MEMBER_VERIFY + ", MEMBER_EMAIL="
				+ MEMBER_EMAIL + ", MEMBER_PASSWORD=" + MEMBER_PASSWORD + ", MEMBER_NAME=" + MEMBER_NAME
				+ ", MEMBER_NICKNAME=" + MEMBER_NICKNAME + ", MEMBER_GENDER=" + MEMBER_GENDER + ", MEMBER_REGDATE="
				+ MEMBER_REGDATE + ", MEMBER_ENABLED=" + MEMBER_ENABLED + ", KAKAO_ID=" + KAKAO_ID + ", KAKAO_NICKNAME="
				+ KAKAO_NICKNAME + "]";
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

	public String getKAKAO_ID() {
		return KAKAO_ID;
	}

	public void setKAKAO_ID(String kAKAO_ID) {
		KAKAO_ID = kAKAO_ID;
	}

	public String getKAKAO_NICKNAME() {
		return KAKAO_NICKNAME;
	}

	public void setKAKAO_NICKNAME(String kAKAO_NICKNAME) {
		KAKAO_NICKNAME = kAKAO_NICKNAME;
	}

}
