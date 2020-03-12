package com.single.model.dao.board;

import java.util.List;

import com.single.model.dto.board.ReplyDTO;
import com.single.model.dto.board.ReplyLikesDTO;
import com.single.model.dto.member.MemberDTO;

public interface ReplyDAO {

	// 중고 게시판 댓글 리스트 출력
	public List<ReplyDTO> ReplySelectList(int RESALE_CODE);

	// 중고 게시판 댓글 하나 출력
	public ReplyDTO ReplySelectOne(int REPLY_CODE, int RESALE_CODE);

	// 중고 게시판 댓글 쓰기
	public int ReplyWrite(ReplyDTO dto);

	// 중고 게시판 댓글 수 카운트 위한 reply_code 가져오기
	public ReplyDTO ReplyGetCode(int MEMBER_CODE);

	// 중고 게시판 닉네임 가져오기
	public MemberDTO getReplyNickName(int MEMBER_CODE);

	// 중고 게시판 댓글 삭제
	public int ReplyDelete(int REPLY_CODE);

}
