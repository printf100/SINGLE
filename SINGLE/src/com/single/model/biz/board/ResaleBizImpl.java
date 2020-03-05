package com.single.model.biz.board;

import java.util.ArrayList;
import java.util.List;

import com.single.model.dao.board.ResaleDAO;
import com.single.model.dao.board.ResaleDAOImpl;
import com.single.model.dto.board.BoardDTO;
import com.single.model.dto.board.LikeDTO;
import com.single.model.dto.board.ResaleDTO;
import com.single.model.dto.member.MemberDTO;

public class ResaleBizImpl implements ResaleBiz {

	ResaleDAO dao = new ResaleDAOImpl();

	@Override
	public ResaleDTO ResaleSelectOne(int resalecode) {
		return dao.ResaleSelectOne(resalecode);
	}

	@Override
	public int ResaleWrite(ResaleDTO resaleDto) {
		return dao.ResaleWrite(resaleDto);
	}

	@Override
	public int ResaleUpdate(ResaleDTO resaleDto) {
		return dao.ResaleUpdate(resaleDto);
	}

	@Override
	public int ResaleDelete(int resalecode) {
		return dao.ResaleDelete(resalecode);
	}

	@Override
	public List<ResaleDTO> ResaleSelectBoardsListData(int curPage) {
		List<ResaleDTO> res = new ArrayList<ResaleDTO>();
		List<ResaleDTO> resaleList = null;

		resaleList = dao.ResaleSelectList();

		for (int i = ((curPage * 12) - 12); i < (curPage * 12); i++) {
			if (resaleList.size() <= i)
				break;
			res.add(resaleList.get(i));
		}

		return res;
	}

	@Override
	public List<ResaleDTO> ResaleSelectSearchListData(int curPage, int how, String kwd) {
		List<ResaleDTO> res = new ArrayList<ResaleDTO>();
		List<ResaleDTO> resaleList = null;

		resaleList = dao.ResaleSearchList(how, kwd);

		for (int i = ((curPage * 12) - 12); i < (curPage * 12); i++) {
			if (resaleList.size() <= i)
				break;
			res.add(resaleList.get(i));
		}

		return res;
	}

	@Override
	public int updateResaleCountView(int resalecode) {
		return dao.updateResaleCountView(resalecode);
	}

	@Override
	public MemberDTO getResaleNickname(int resalecode) {
		return dao.getResaleNickname(resalecode);
	}

	@Override
	public int updateInterest(int resalecode) {
		return dao.updateInterest(resalecode);
	}

	@Override
	public int insertInterest(LikeDTO like) {
		return dao.insertInterest(like);
	}

	@Override
	public List<LikeDTO> interestList(int membercode) {
		return dao.interestList(membercode);
	}

	@Override
	public ResaleDTO selectInterest(int resalecode) {
		return dao.selectInterest(resalecode);
	}

	@Override
	public int multiDelete(String[] RESALE_CODE, int MEMBER_CODE) {
		return dao.multiDelete(RESALE_CODE, MEMBER_CODE);
	}

	@Override
	public int stopInterest(LikeDTO likedto) {
		return dao.stopInterest(likedto);
	}

	@Override
	public List<ResaleDTO> ResaleMainList() {
		return dao.ResaleMainList();
	}

	@Override
	public int ResaleUpdateNo(ResaleDTO resaleDto) {
		return dao.ResaleUpdateNo(resaleDto);
	}

}
