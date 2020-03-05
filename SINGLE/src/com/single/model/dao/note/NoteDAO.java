package com.single.model.dao.note;

import java.util.List;

import com.single.model.dto.note.MyNoteListDTO;
import com.single.model.dto.note.NoteDTO;

public interface NoteDAO {

	// 쪽지 전송
	public int sendNote(NoteDTO note);

	// 쪽지 번호 가져오기
	public NoteDTO getNoteCode(int MEMBER_CODE);

	// mylist에 insert
	public int insertMyList(MyNoteListDTO dto);

	// 받은 쪽지함
	public List<NoteDTO> selectNoteInList(int MEMBER_CODE);

	// 받은 쪽지 총 갯수
	public int noteInCount(int MEMBER_CODE);

	// 안 읽은 받은 쪽지 갯수
	public int noteInUnreadCount(int MEMBER_CODE);

	// 받은 쪽지 내용
	public NoteDTO selectNoteInDetail(int NOTE_CODE);

	// 보낸 쪽지함
	public List<NoteDTO> selectNoteOutList(int MEMBER_CODE);

	// 보낸 쪽지 총 갯수
	public int noteOutCount(int MEMBER_CODE);

	// 보낸 쪽지 내용
	public NoteDTO selectNoteOutDetail(int NOTE_CODE);

	// 쪽지 읽음 상태 가져오기
	public String getReadStatus(int NOTE_CODE);

	// 쪽지 읽음 처리
	public int updateReadStatus(int NOTE_CODE);

	// 쪽지 삭제하기
	public int deleteNote(int NOTE_CODE);
}
