package com.single.model.biz.map;

import java.util.List;

import com.single.model.dao.map.FoodDao;
import com.single.model.dao.map.FoodDaoImpl;
import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.MemberProfileDTO;

public class FoodBizImpl implements FoodBiz {

	FoodDao dao = new FoodDaoImpl();

	@Override
	public int foodInsert(FoodDto dto) {
		// TODO Auto-generated method stub
		return dao.foodInsert(dto);
	}

	@Override
	public List<FoodDto> foodList() {
		// TODO Auto-generated method stub
		return dao.foodList();
	}

	@Override
	public FoodDto selectFood(int marker_code) {
		// TODO Auto-generated method stub
		return dao.selectFood(marker_code);
	}

	@Override
	public int update(FoodDto dto) {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}

	@Override
	public int delete(int marker_code) {
		// TODO Auto-generated method stub
		return dao.delete(marker_code);
	}

	@Override
	public List<FoodDto> MyFoodList(int MEMBER_CODE) {
		// TODO Auto-generated method stub
		return dao.MyFoodList(MEMBER_CODE);
	}

	@Override
	public List<MemberProfileDTO> memberList(int MEMBER_CODE) {
		// TODO Auto-generated method stub
		return dao.memberList(MEMBER_CODE);
	}

}