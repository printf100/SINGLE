package com.single.model.dao.note;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.note.MyNoteListDTO;
import com.single.model.dto.note.NoteDTO;
import com.single.mybatis.SqlMapConfig;

public class NoteDAOImpl extends SqlMapConfig implements NoteDAO {

	final String namespace = "com.single.note-mapper";

	// 쪽지 전송하기
	@Override
	public int sendNote(NoteDTO note) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".sendNote", note);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 쪽지 번호 가져오기
	@Override
	public NoteDTO getNoteCode(int MEMBER_CODE) {
		
		SqlSession session = getSqlSessionFactory().openSession(false);

		NoteDTO note_code = session.selectOne(namespace + ".getNoteCode", MEMBER_CODE);
		
		session.close();

		return note_code;
	}

	// mylist에 insert
	@Override
	public int insertMyList(MyNoteListDTO dto) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".addMyNote", dto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 받은 쪽지함
	@Override
	public List<NoteDTO> selectNoteInList(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<NoteDTO> in_list = session.selectList(namespace + ".noteInList", MEMBER_CODE);

		session.close();

		return in_list;
	}

	// 받은 쪽지 총 갯수
	@Override
	public int noteInCount(int MEMBER_CODE) {
		
		SqlSession session = getSqlSessionFactory().openSession(false);
		
		int res = session.selectOne(namespace + ".noteInCount", MEMBER_CODE);
		
		session.close();
		
		return res;
	}

	// 안읽은 받은 쪽지 갯수
	@Override
	public int noteInUnreadCount(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		
		int res = session.selectOne(namespace + ".noteInUnreadCount", MEMBER_CODE);
		
		session.close();
		
		return res;
	}


	// 받은 쪽지 내용
	@Override
	public NoteDTO selectNoteInDetail(int NOTE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		NoteDTO in_detail = session.selectOne(namespace + ".noteInDetail", NOTE_CODE);

		session.close();

		return in_detail;
	}

	// 보낸 쪽지함
	@Override
	public List<NoteDTO> selectNoteOutList(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		List<NoteDTO> out_list = session.selectList(namespace + ".noteOutList", MEMBER_CODE);

		session.close();

		return out_list;
	}

	// 보낸 쪽지 총 갯수
	@Override
	public int noteOutCount(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		
		int res = session.selectOne(namespace + ".noteOutCount", MEMBER_CODE);
		
		session.close();
		
		return res;
	}

	// 보낸 쪽지 내용
	@Override
	public NoteDTO selectNoteOutDetail(int NOTE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		NoteDTO out_detail = session.selectOne(namespace + ".noteOutDetail", NOTE_CODE);

		session.close();

		return out_detail;
	}

	// 쪽지 읽음 상태 가져오기
	@Override
	public String getReadStatus(int NOTE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		String status = session.selectOne(namespace + ".getReadStatus", NOTE_CODE);

		session.close();

		return status;
	}

	// 쪽지 읽음 처리
	@Override
	public int updateReadStatus(int NOTE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateReadStatus", NOTE_CODE);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 쪽지 삭제하기
	@Override
	public int deleteNote(int NOTE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".deleteNote", NOTE_CODE);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}
}
