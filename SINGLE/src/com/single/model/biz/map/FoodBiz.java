package com.single.model.biz.map;

import java.util.List;

import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.MemberProfileDTO;

public interface FoodBiz {

	public int foodInsert(FoodDto dto);

	public List<FoodDto> foodList();

	public FoodDto selectFood(int marker_code);

	public int update(FoodDto dto);

	public int delete(int marker_code);

	public List<FoodDto> MyFoodList(int MEMBER_CODE);

	public List<MemberProfileDTO> memberList(int MEMBER_CODE);

}