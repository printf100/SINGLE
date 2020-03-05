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

	/*
	 * 중고 게시판 댓글수 업데이트 public int ReplyCountUpdate(int REPLY_CODE, int RESALE_CODE);
	 */

	// 중고 게시판 댓글 수정
	public int ReplyUpdate(ReplyDTO dto);

	// 중고 게시판 댓글 삭제
	public int ReplyDelete(int REPLY_CODE);

	// 중고 게시판 댓글 수 출력
	public int ReplyCount(int REPLY_CODE, int RESALE_CODE);

	// 중고 게시판 댓글 좋아요 증가
	public int ReplyLikeUpdate(int REPLY_CODE, int RESALE_CODE);

	// 중고 게시판 댓글 좋아요 삭제
	public int ReplyLikeDelete(int REPLY_CODE, int RESALE_CODE);

	// 중고 게시판 댓글 좋아요 클릭
	public int ReplyLike(int REPLY_CODE, int RESALE_CODE);

	// 중고 게시판 좋아요 수 카운트 출력
	public int ReplyLikeCount(ReplyLikesDTO replyDto);

}
