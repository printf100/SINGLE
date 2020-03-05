package com.single.model.dao.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.board.BoardDTO;
import com.single.mybatis.SqlMapConfig;

public class NoticeDAOImpl extends SqlMapConfig implements NoticeDAO {

	final String namespace = "com.single.notice-mapper";

	@Override
	public List<BoardDTO> NoticeSelectList() {

		List<BoardDTO> list = null;
		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + ".NoticeSelectList");

		return list;
	}

	@Override
	public BoardDTO NoticeSelectOne(int boardcode) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		BoardDTO boardDTO = session.selectOne(namespace + ".NoticeSelectOne", boardcode);

		session.close();

		return boardDTO;
	}

	@Override
	public int NoticeWrite(BoardDTO boardDto) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace + ".NoticeWrite", boardDto);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	@Override
	public int NoticeUpdate(BoardDTO boardDto) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".NoticeUpdate", boardDto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int NoticeUpdateWithFile(BoardDTO boardDTO) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".NoticeUpdateWithFile", boardDTO);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	@Override
	public int NoticeDelete(int boardcode) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace + ".NoticeDelete", boardcode);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int getNoticeDataCount() {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".getNoticeDataCount");

		session.close();

		return res;
	}

	public int getNoticeDataCount(int how, String kwd) {

		List<BoardDTO> boardList = new ArrayList<BoardDTO>();

		HashMap<String, String> map = new HashMap();
		map.put("how", Integer.toString(how));
		map.put("kwd", kwd);

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.selectOne(namespace + ".getNoticeDataCountWithMap", map);

		session.close();

		return res;
	}

	@Override
	public List<BoardDTO> NoticeSearchList(int how, String kwd) {

		List<BoardDTO> boardList = new ArrayList<BoardDTO>();

		HashMap<String, String> map = new HashMap();
		map.put("how", Integer.toString(how));
		map.put("kwd", kwd);

		SqlSession session = getSqlSessionFactory().openSession(false);
		boardList = session.selectList(namespace + ".NoticeSearchList", map);

		session.close();

		return boardList;

	}

	@Override
	public int updateNoticeCountView(int boardcode) {

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".updateNoticeCountView", boardcode);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int fileUpload(BoardDTO boardDTO) {
		int res = 0;

		SqlSession session = getSqlSessionFactory().openSession(false);
		res = session.update(namespace + ".fileUpload", boardDTO);

		if (res > 0) {
			session.commit();
		}

		session.close();
		return res;
	}

	@Override
	public BoardDTO NoticeSelectOneFile(String FILE_SERVER) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		BoardDTO boardDTO = session.selectOne(namespace + ".NoticeSelectOneFile", FILE_SERVER);

		session.close();

		return boardDTO;
	}

}
