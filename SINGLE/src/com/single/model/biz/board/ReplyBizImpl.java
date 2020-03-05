package com.single.model.biz.board;

import java.util.List;

import com.single.model.dao.board.ReplyDAO;
import com.single.model.dao.board.ReplyDAOImpl;
import com.single.model.dto.board.ReplyDTO;
import com.single.model.dto.board.ReplyLikesDTO;
import com.single.model.dto.member.MemberDTO;

public class ReplyBizImpl implements ReplyBiz {

	ReplyDAO dao = new ReplyDAOImpl();

	@Override
	public List<ReplyDTO> ReplySelectList(int RESALE_CODE) {
		return dao.ReplySelectList(RESALE_CODE);
	}

	@Override
	public ReplyDTO ReplySelectOne(int REPLY_CODE, int RESALE_CODE) {
		return dao.ReplySelectOne(REPLY_CODE, RESALE_CODE);
	}

	@Override
	public String getReplyNickName(int MEMBER_CODE) {

		MemberDTO dto = dao.getReplyNickName(MEMBER_CODE);

		return dto.getMEMBER_NICKNAME();
	}

	@Override
	public int ReplyWrite(ReplyDTO dto) {
		
		System.out.println("파라미터 dto :" + dto);
		int res = dao.ReplyWrite(dto);

		// 댓글 입력 성공
		if (res > 0) {
			ReplyDTO new_reply = dao.ReplyGetCode(dto.getMEMBER_CODE());
			System.out.println("new_reply : " + new_reply);
			System.out.println("비즈 : " + new_reply.getREPLY_CODE());

			return new_reply.getREPLY_CODE();
		} else {
			return res;
		}
	}
	/*
	 * @Override public int ReplyCountUpdate(int REPLY_CODE) { return
	 * dao.ReplyCountUpdate(REPLY_CODE); }
	 */

	@Override
	public int ReplyUpdate(ReplyDTO dto) {
		return dao.ReplyUpdate(dto);
	}

	@Override
	public int ReplyDelete(int REPLY_CODE) {
		return dao.ReplyDelete(REPLY_CODE);
	}

	@Override
	public int ReplyCount(int REPLY_CODE, int RESALE_CODE) {
		return dao.ReplyCount(REPLY_CODE, RESALE_CODE);
	}

	@Override
	public int ReplyLikeUpdate(int REPLY_CODE, int RESALE_CODE) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ReplyLikeDelete(int REPLY_CODE, int RESALE_CODE) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ReplyLike(int REPLY_CODE, int RESALE_CODE) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int ReplyLikeCount(ReplyLikesDTO replyDto) {
		// TODO Auto-generated method stub
		return 0;
	}

}
