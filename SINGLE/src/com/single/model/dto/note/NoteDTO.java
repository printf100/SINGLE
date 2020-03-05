package com.single.model.dto.note;

import java.text.SimpleDateFormat;
import java.util.Date;

public class NoteDTO {

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	private int NOTE_CODE;

	private int NOTE_FROM_CODE;
	private String NOTE_FROM_NICKNAME;
	private int NOTE_TO_CODE;
	private String NOTE_TO_NICKNAME;

	private String NOTE_TITLE;
	private String NOTE_CONTENT;
	private Date NOTE_SENDDATE;
	private String NOTE_READ;

	public NoteDTO() {
	}

	public NoteDTO(int nOTE_CODE, int nOTE_FROM_CODE, String nOTE_FROM_NICKNAME, int nOTE_TO_CODE,
			String nOTE_TO_NICKNAME, String nOTE_TITLE, String nOTE_CONTENT, Date nOTE_SENDDATE, String nOTE_READ) {
		NOTE_CODE = nOTE_CODE;
		NOTE_FROM_CODE = nOTE_FROM_CODE;
		NOTE_FROM_NICKNAME = nOTE_FROM_NICKNAME;
		NOTE_TO_CODE = nOTE_TO_CODE;
		NOTE_TO_NICKNAME = nOTE_TO_NICKNAME;
		NOTE_TITLE = nOTE_TITLE;
		NOTE_CONTENT = nOTE_CONTENT;
		NOTE_SENDDATE = nOTE_SENDDATE;
		NOTE_READ = nOTE_READ;
	}

	@Override
	public String toString() {
		return "NoteDTO [NOTE_CODE=" + NOTE_CODE + ", NOTE_FROM_CODE=" + NOTE_FROM_CODE + ", NOTE_FROM_NICKNAME="
				+ NOTE_FROM_NICKNAME + ", NOTE_TO_CODE=" + NOTE_TO_CODE + ", NOTE_TO_NICKNAME=" + NOTE_TO_NICKNAME
				+ ", NOTE_TITLE=" + NOTE_TITLE + ", NOTE_CONTENT=" + NOTE_CONTENT + ", NOTE_SENDDATE=" + NOTE_SENDDATE
				+ ", NOTE_READ=" + NOTE_READ + "]";
	}

	public int getNOTE_CODE() {
		return NOTE_CODE;
	}

	public void setNOTE_CODE(int nOTE_CODE) {
		NOTE_CODE = nOTE_CODE;
	}

	public int getNOTE_FROM_CODE() {
		return NOTE_FROM_CODE;
	}

	public void setNOTE_FROM_CODE(int nOTE_FROM_CODE) {
		NOTE_FROM_CODE = nOTE_FROM_CODE;
	}

	public String getNOTE_FROM_NICKNAME() {
		return NOTE_FROM_NICKNAME;
	}

	public void setNOTE_FROM_NICKNAME(String nOTE_FROM_NICKNAME) {
		NOTE_FROM_NICKNAME = nOTE_FROM_NICKNAME;
	}

	public int getNOTE_TO_CODE() {
		return NOTE_TO_CODE;
	}

	public void setNOTE_TO_CODE(int nOTE_TO_CODE) {
		NOTE_TO_CODE = nOTE_TO_CODE;
	}

	public String getNOTE_TO_NICKNAME() {
		return NOTE_TO_NICKNAME;
	}

	public void setNOTE_TO_NICKNAME(String nOTE_TO_NICKNAME) {
		NOTE_TO_NICKNAME = nOTE_TO_NICKNAME;
	}

	public String getNOTE_TITLE() {
		return NOTE_TITLE;
	}

	public void setNOTE_TITLE(String nOTE_TITLE) {
		NOTE_TITLE = nOTE_TITLE;
	}

	public String getNOTE_CONTENT() {
		return NOTE_CONTENT;
	}

	public void setNOTE_CONTENT(String nOTE_CONTENT) {
		NOTE_CONTENT = nOTE_CONTENT;
	}

	public String getNOTE_SENDDATE() {	
		return df.format(NOTE_SENDDATE);
	}

	public void setNOTE_SENDDATE(Date nOTE_SENDDATE) {
		NOTE_SENDDATE = nOTE_SENDDATE;
	}

	public String getNOTE_READ() {
		return NOTE_READ;
	}

	public void setNOTE_READ(String nOTE_READ) {
		NOTE_READ = nOTE_READ;
	}

}
