package com.single.model.biz.map;

import java.util.List;

import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.MemberProfileDTO;

public interface FoodBiz {
	// 占쏙옙占쏙옙占� 占쏙옙占�(insert)
	public int foodInsert(FoodDto dto);

	// 占쏙옙占쏙옙占� 占쏙옙占쏙옙트(select)
	public List<FoodDto> foodList();

	// 占쏙옙占쏙옙占� 占쏙옙占쏙옙(select)
	public FoodDto selectFood(int marker_code);

	// 占쏙옙占쏙옙占� 占쏙옙占쏙옙占쏙옙트(update)
	public int update(FoodDto dto);

	// 占쏙옙占쏙옙占� 占쏙옙占쏙옙(delete)
	public int delete(int marker_code);

	public List<FoodDto> MyFoodList(int MEMBER_CODE);

	public List<MemberProfileDTO> memberList(int MEMBER_CODE);
}
