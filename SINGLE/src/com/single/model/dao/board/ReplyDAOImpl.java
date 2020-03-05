package com.single.model.dao.board;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.board.ReplyDTO;
import com.single.model.dto.board.ReplyLikesDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.mybatis.SqlMapConfig;

public class ReplyDAOImpl extends SqlMapConfig implements ReplyDAO {

	final String namespace = "com.single.reply-mapper";

	@Override
	public List<ReplyDTO> ReplySelectList(int RESALE_CODE) {

		List<ReplyDTO> replyList = null;
		SqlSession session = getSqlSessionFactory().openSession(false);

		replyList = session.selectList(namespace + ".ReplySelectList", RESALE_CODE);

		session.close();

		return replyList;

	}

	@Override
	public ReplyDTO ReplySelectOne(int REPLY_CODE, int RESALE_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		HashMap<String, Integer> map = new HashMap();
		map.put("REPLY_CODE", REPLY_CODE);
		map.put("RESALE_CODE", RESALE_CODE);
		ReplyDTO replyDto = session.selectOne(namespace + ".ReplySelectOne", map);

		session.close();

		return replyDto;
	}

	@Override
	public int ReplyWrite(ReplyDTO dto) {

		int res = 0;
		SqlSession session = getSqlSessionFactory().openSession(false);

		res = session.insert(namespace + ".ReplyWrite", dto);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public ReplyDTO ReplyGetCode(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		ReplyDTO dto = session.selectOne(namespace + ".ReplyGetCode", MEMBER_CODE);

		session.close();

		return dto;
	}

	@Override
	public MemberDTO getReplyNickName(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberDTO dto = session.selectOne(namespace + ".getReplyNickName", MEMBER_CODE);

		session.close();

		return dto;
	}

	@Override
	public int ReplyUpdate(ReplyDTO dto) {

		int res = 0;
		SqlSession session = getSqlSessionFactory().openSession(false);

		res = session.update(namespace + ".ReplyUpdate", dto);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int ReplyDelete(int REPLY_CODE) {

		int res = 0;
		SqlSession session = getSqlSessionFactory().openSession(false);

		res = session.delete(namespace + ".ReplyDelete", REPLY_CODE);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
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

	@Override
	public int ReplyCount(int REPLY_CODE, int RESALE_CODE) {
		// TODO Auto-generated method stub
		return 0;
	}

}
