package com.single.model.dao.board;

import java.util.List;
import com.single.model.dto.board.BoardDTO;

public interface NoticeDAO {

	// 공지 목록 출력 - 글 제목 옆에 댓글 수 나오게
	public List<BoardDTO> NoticeSelectList();

	// 공지 디테일 출력
	public BoardDTO NoticeSelectOne(int boardcode);

	// 공지 글쓰기 (관리자만 뜨게)
	public int NoticeWrite(BoardDTO boardDto);

	// 공지 수정 (관리자만 뜨게)
	public int NoticeUpdate(BoardDTO boardDto);

	// 공지 수정 파일 첨부시 (관리자만 뜨게)
	public int NoticeUpdateWithFile(BoardDTO boardDTO);

	// 공지 삭제 (관리자만 뜨게)
	public int NoticeDelete(int boardcode);

	// 공지 데이터 전체 갯수
	public int getNoticeDataCount();

	// 공지 검색했을 때 전체 데이터 갯수 카운팅
	public int getNoticeDataCount(int how, String kwd);

	// 공지 검색 리스트
	public List<BoardDTO> NoticeSearchList(int how, String kwd);

	// 조회수 증가
	public int updateNoticeCountView(int boardcode);

	// 파일 첨부 글쓰기
	public int fileUpload(BoardDTO boardDTO);

	// 파일 첨부 서버 네임 가져오기
	public BoardDTO NoticeSelectOneFile(String FILE_SERVER);

}
