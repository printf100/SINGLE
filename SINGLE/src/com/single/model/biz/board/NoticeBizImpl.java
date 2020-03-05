package com.single.model.biz.board;

import java.util.ArrayList;
import java.util.List;
import com.single.model.dao.board.NoticeDAO;
import com.single.model.dao.board.NoticeDAOImpl;
import com.single.model.dto.board.BoardDTO;

public class NoticeBizImpl implements NoticeBiz {

	NoticeDAO dao = new NoticeDAOImpl();

	@Override
	public BoardDTO NoticeSelectOne(int boardcode) {
		return dao.NoticeSelectOne(boardcode);
	}

	@Override
	public int NoticeWrite(BoardDTO boardDto) {
		return dao.NoticeWrite(boardDto);
	}

	@Override
	public int NoticeUpdateWithFile(BoardDTO boardDto) {
		return dao.NoticeUpdateWithFile(boardDto);
	}

	@Override
	public int NoticeUpdate(BoardDTO boardDto) {
		return dao.NoticeUpdate(boardDto);
	}

	@Override
	public int NoticeDelete(int boardcode) {
		return dao.NoticeDelete(boardcode);
	}

	@Override
	public int getNoticeDataCount() {
		return dao.getNoticeDataCount();
	}

	@Override
	public BoardDTO getNoticeReadData(int boardcode) {
		return null;
	}

	@Override
	public List<BoardDTO> NoticeSelectBoardsListData(int curPage) {
		List<BoardDTO> res = new ArrayList<BoardDTO>();
		List<BoardDTO> boardList = null;

		boardList = dao.NoticeSelectList();

		for (int i = ((curPage * 10) - 10); i < (curPage * 10); i++) {
			if (boardList.size() <= i)
				break;
			res.add(boardList.get(i));
		}

		return res;
	}

	@Override
	public List<BoardDTO> NoticeSelectSearchListData(int curPage, int how, String kwd) {
		List<BoardDTO> res = new ArrayList<BoardDTO>();
		List<BoardDTO> boardList = null;

		boardList = dao.NoticeSearchList(how, kwd);

		for (int i = ((curPage * 10) - 10); i < (curPage * 10); i++) {
			if (boardList.size() <= i)
				break;
			res.add(boardList.get(i));
		}

		return res;
	}

	@Override
	public int updateNoticeCountView(int boardcode) {
		return dao.updateNoticeCountView(boardcode);
	}

	@Override
	public int fileUpload(BoardDTO boardDTO) {
		return dao.fileUpload(boardDTO);
	}

}
