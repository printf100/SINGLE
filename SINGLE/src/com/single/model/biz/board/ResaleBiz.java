package com.single.model.biz.board;

import java.util.List;

import com.single.model.dto.board.BoardDTO;
import com.single.model.dto.board.LikeDTO;
import com.single.model.dto.board.ResaleDTO;
import com.single.model.dto.member.MemberDTO;

public interface ResaleBiz {

	// 중고 게시판 디테일 출력
	public ResaleDTO ResaleSelectOne(int resalecode);

	// 중고 게시판 메인 출력 - 8개만 출력
	public List<ResaleDTO> ResaleMainList();

	// 중고 게시판 글쓰기
	public int ResaleWrite(ResaleDTO resaleDto);

	// 중고 게시판 파일 재첨부 후 수정
	public int ResaleUpdate(ResaleDTO resaleDto);

	// 중고 게시판 원본 파일 그대로 수정
	public int ResaleUpdateNo(ResaleDTO resaleDto);

	// 중고 게시판 삭제
	public int ResaleDelete(int resalecode);

	// 중고 게시판 기본 목록
	public List<ResaleDTO> ResaleSelectBoardsListData(int curPage);

	// 중고 게시판 검색어 있을 때 목록
	public List<ResaleDTO> ResaleSelectSearchListData(int curPage, int how, String kwd);

	// 조회수 증가
	public int updateResaleCountView(int resalecode);

	// 닉네임 가져오기
	public MemberDTO getResaleNickname(int resalecode);

	// 관심 등록하기 - LIKE 증가
	public int updateInterest(int resalecode);

	// 관심 등록하기 - 내 관심페이지 등록
	public int insertInterest(LikeDTO like);

	// 관심 리스트
	public List<LikeDTO> interestList(int membercode);

	// 관심 리스트 글 하나 보기
	public ResaleDTO selectInterest(int resalecode);

	// 관심 리스트 글 삭제
	public int multiDelete(String[] RESALE_CODE, int MEMBER_CODE);

	// 관심 중복 등록 방지
	public int stopInterest(LikeDTO likedto);

}
