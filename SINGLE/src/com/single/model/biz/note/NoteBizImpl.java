package com.single.model.biz.note;

import java.util.List;

import com.single.model.dao.note.NoteDAO;
import com.single.model.dao.note.NoteDAOImpl;
import com.single.model.dto.note.MyNoteListDTO;
import com.single.model.dto.note.NoteDTO;

public class NoteBizImpl implements NoteBiz {

	NoteDAO dao = new NoteDAOImpl();

	// 쪽지 전송하고 쪽지 번호 리턴
	@Override
	public int sendNote(NoteDTO note) {

		int send_res = dao.sendNote(note);
		int add_res = 0;
		int note_code = 0;

		if (send_res > 0) {
			NoteDTO new_note = dao.getNoteCode(note.getNOTE_FROM_CODE());
			MyNoteListDTO addNote = new MyNoteListDTO();

			// 보낸 사람만 일단 mylist에 insert
			addNote.setMEMBER_CODE(note.getNOTE_FROM_CODE());
			addNote.setNOTE_CODE(new_note.getNOTE_CODE());
			addNote.setNOTE_VERIFY("OUT");

			add_res = dao.insertMyList(addNote);
			if (add_res > 0) {
				// 쪽지 번호 가져오기
				note_code = addNote.getNOTE_CODE();
				System.out.println("NoteBizImpl - 새로 생성된 쪽지 번호 : " + note_code);

				return note_code;

			} else {
				return add_res;
			}

		} else {
			return send_res;
		}
	}

	// mylist에 insert
	@Override
	public int insertMyList(MyNoteListDTO dto) {
		return dao.insertMyList(dto);
	}

	// 받은 쪽지함
	@Override
	public List<NoteDTO> selectNoteInList(int MEMBER_CODE) {
		return dao.selectNoteInList(MEMBER_CODE);
	}

	// 받은 쪽지 총 갯수
	@Override
	public int noteInCount(int MEMBER_CODE) {
		return dao.noteInCount(MEMBER_CODE);
	}

	// 안 읽은 받은 쪽지 갯수
	@Override
	public int noteInUnreadCount(int MEMBER_CODE) {
		return dao.noteInUnreadCount(MEMBER_CODE);
	}

	// 받은 쪽지 내용
	@Override
	public NoteDTO selectNoteInDetail(int NOTE_CODE) {

		String status = dao.getReadStatus(NOTE_CODE);

		if (status.equals("N")) { // 읽음 처리하기
			dao.updateReadStatus(NOTE_CODE);
		}

		return dao.selectNoteInDetail(NOTE_CODE);
	}

	// 보낸 쪽지함
	@Override
	public List<NoteDTO> selectNoteOutList(int MEMBER_CODE) {
		return dao.selectNoteOutList(MEMBER_CODE);
	}

	// 보낸 쪽지 총 갯수
	@Override
	public int noteOutCount(int MEMBER_CODE) {
		return dao.noteOutCount(MEMBER_CODE);
	}

	// 보낸 쪽지 내용
	@Override
	public NoteDTO selectNoteOutDetail(int NOTE_CODE) {
		return dao.selectNoteOutDetail(NOTE_CODE);
	}

	// 쪽지 삭제하기
	@Override
	public int deleteNote(int NOTE_CODE) {
		return dao.deleteNote(NOTE_CODE);
	}

}
