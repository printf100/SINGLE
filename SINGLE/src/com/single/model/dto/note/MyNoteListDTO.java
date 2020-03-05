package com.single.model.dto.note;

public class MyNoteListDTO {

	private int MEMBER_CODE;
	private int NOTE_CODE;
	private String NOTE_VERIFY;
	
	public MyNoteListDTO() {
	}

	public MyNoteListDTO(int mEMBER_CODE, int nOTE_CODE, String nOTE_VERIFY) {
		MEMBER_CODE = mEMBER_CODE;
		NOTE_CODE = nOTE_CODE;
		NOTE_VERIFY = nOTE_VERIFY;
	}

	@Override
	public String toString() {
		return "MyNoteListDTO [MEMBER_CODE=" + MEMBER_CODE + ", NOTE_CODE=" + NOTE_CODE + ", NOTE_VERIFY=" + NOTE_VERIFY
				+ "]";
	}

	public int getMEMBER_CODE() {
		return MEMBER_CODE;
	}

	public void setMEMBER_CODE(int mEMBER_CODE) {
		MEMBER_CODE = mEMBER_CODE;
	}

	public int getNOTE_CODE() {
		return NOTE_CODE;
	}

	public void setNOTE_CODE(int nOTE_CODE) {
		NOTE_CODE = nOTE_CODE;
	}

	public String getNOTE_VERIFY() {
		return NOTE_VERIFY;
	}

	public void setNOTE_VERIFY(String nOTE_VERIFY) {
		NOTE_VERIFY = nOTE_VERIFY;
	}
	
}
