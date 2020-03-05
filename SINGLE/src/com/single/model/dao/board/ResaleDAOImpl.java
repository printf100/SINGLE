package com.single.model.dao.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.board.LikeDTO;
import com.single.model.dto.board.ResaleDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.mybatis.SqlMapConfig;

public class ResaleDAOImpl extends SqlMapConfig implements ResaleDAO {

	final String namespace = "com.single.resale-mapper";

	@Override
	public List<ResaleDTO> ResaleSelectList() {

		List<ResaleDTO> list = null;
		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + ".ResaleSelectList");

		session.close();

		return list;
	}

	@Override
	public ResaleDTO ResaleSelectOne(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		ResaleDTO resaleDTO = session.selectOne(namespace + ".ResaleSelectOne", resalecode);

		session.close();

		return resaleDTO;
	}

	@Override
	public int ResaleWrite(ResaleDTO resaleDto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.insert(namespace + ".ResaleWrite", resaleDto);
		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;
	}

	@Override
	public int ResaleUpdate(ResaleDTO resaleDto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".ResaleUpdate", resaleDto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int ResaleUpdateNo(ResaleDTO resaleDto) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".ResaleUpdateNo", resaleDto);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int ResaleDelete(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.delete(namespace + ".ResaleDelete", resalecode);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int getResaleDataCount() {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.selectOne(namespace + ".getResaleDataCount");

		session.close();

		return res;
	}

	@Override
	public int getResaleDataCount(int how, String kwd) {
		List<ResaleDTO> boardList = new ArrayList<ResaleDTO>();

		HashMap<String, String> map = new HashMap();
		map.put("how", Integer.toString(how));
		map.put("kwd", kwd);

		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.selectOne(namespace + ".getResaleDataCount", map);

		session.close();

		return res;
	}

	@Override
	public List<ResaleDTO> ResaleSearchList(int how, String kwd) {
		List<ResaleDTO> resaleList = new ArrayList<ResaleDTO>();

		HashMap<String, String> map = new HashMap();
		map.put("how", Integer.toString(how));
		map.put("kwd", kwd);

		SqlSession session = getSqlSessionFactory().openSession(false);
		resaleList = session.selectList(namespace + ".ResaleSearchList", map);

		session.close();

		return resaleList;
	}

	@Override
	public int updateResaleCountView(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".updateResaleCountView", resalecode);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int updateLikeCount(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".updateLikeCount", resalecode);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public MemberDTO getResaleNickname(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		MemberDTO dto = session.selectOne(namespace + ".getResaleNickname", resalecode);

		session.close();

		return dto;
	}

	@Override
	public int updateInterest(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		int res = session.update(namespace + ".updateInterest", resalecode);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int insertInterest(LikeDTO like) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".insertInterest", like);

		if (res > 0) {
			session.commit();
		}
		session.close();

		return res;

	}

	@Override
	public List<LikeDTO> interestList(int membercode) {
		List<LikeDTO> list = null;
		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + ".interestList", membercode);

		return list;

	}

	@Override
	public ResaleDTO selectInterest(int resalecode) {
		SqlSession session = getSqlSessionFactory().openSession(false);
		ResaleDTO dto = session.selectOne(namespace + ".selectInterest", resalecode);

		session.close();

		return dto;
	}

	@Override
	public int multiDelete(String[] RESALE_CODE, int MEMBER_CODE) {
		int res = 0;

		SqlSession session = getSqlSessionFactory().openSession(false);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("MEMBER_CODE", MEMBER_CODE);
		map.put("RESALE_CODE", RESALE_CODE);

		res = session.delete(namespace + ".multiDelete", map);

		if (res == RESALE_CODE.length) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public int stopInterest(LikeDTO likedto) {
		int res = 0;

		SqlSession session = getSqlSessionFactory().openSession(false);
		res = session.selectOne(namespace + ".stopInterest", likedto);

		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	@Override
	public List<ResaleDTO> ResaleMainList() {
		List<ResaleDTO> list = null;

		SqlSession session = getSqlSessionFactory().openSession(false);
		list = session.selectList(namespace + ".ResaleMainList");

		session.close();

		return list;
	}

}
