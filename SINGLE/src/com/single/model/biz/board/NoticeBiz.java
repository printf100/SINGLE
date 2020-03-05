package com.single.model.biz.board;

import java.util.List;

import com.single.model.dto.board.BoardDTO;

public interface NoticeBiz {

	// 공지 디테일 출력
	public BoardDTO NoticeSelectOne(int boardcode);

	// 공지 글쓰기 (관리자만 뜨게)
	public int NoticeWrite(BoardDTO boardDto);

	// 공지 첨부 파일 있을 때 수정 (관리자만 뜨게)
	public int NoticeUpdateWithFile(BoardDTO boardDTO);

	// 공지 수정 (관리자만 뜨게)
	public int NoticeUpdate(BoardDTO boardDto);

	// 공지 삭제 (관리자만 뜨게)
	public int NoticeDelete(int boardcode);

	// 공지 전체 데이터 갯수 카운팅
	public int getNoticeDataCount();

	// boardcode로 조회한 데이터(???)
	public BoardDTO getNoticeReadData(int boardcode);

	// 게시판 기본 목록
	public List<BoardDTO> NoticeSelectBoardsListData(int curPage);

	// 공지 게시판 검색어 있을 때 목록
	public List<BoardDTO> NoticeSelectSearchListData(int curPage, int how, String kwd);

	// 조회수 증가
	public int updateNoticeCountView(int boardcode);

	// 파일 업로드
	public int fileUpload(BoardDTO boardDTO);

}
