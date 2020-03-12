package com.single.model.dao.map;

import java.util.List;

import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.MemberProfileDTO;

public interface FoodDao {

	public int foodInsert(FoodDto dto);

	public List<FoodDto> foodList();

	public FoodDto selectFood(int marker_code);

	public int update(FoodDto dto);

	public int delete(int marker_code);

	public List<FoodDto> MyFoodList(int MEMBER_CODE);

	public List<MemberProfileDTO> memberList(int MEMBER_CODE);

}