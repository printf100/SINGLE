package com.single.model.dao.map;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.map.FoodDto;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.mybatis.SqlMapConfig;

public class FoodDaoImpl extends SqlMapConfig implements FoodDao {

	final String namespace = "com.single.food-mapper";
	final String namespace2 = "com.single.search-mapper";

	@Override
	public int foodInsert(FoodDto FOOD) {
		int res = 0;
		SqlSession session = null;

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(namespace + ".foodInsert", FOOD);

			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] : foodInsert");
			e.printStackTrace();
		}
		session.close();

		return res;
	}

	@Override
	public List<FoodDto> foodList() {

		List<FoodDto> list = new ArrayList<>();

		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + ".selectFoodList");

		session.close();

		return list;
	}

	@Override
	public FoodDto selectFood(int marker_code) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		FoodDto dto = session.selectOne(namespace + ".selectOneFood", marker_code);

		session.close();

		return dto;
	}

	@Override
	public int update(FoodDto FOOD) {

		int res = 0;
		SqlSession session = null;

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(namespace + ".myFoodUpdate", FOOD);

			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] : foodInsert");
			e.printStackTrace();
		}

		session.close();

		return res;
	}

	@Override
	public int delete(int marker_code) {

		int res = 0;
		SqlSession session = null;

		try {
			session = getSqlSessionFactory().openSession(false);
			res = session.insert(namespace + ".myFoodDelete", marker_code);

			if (res > 0) {
				session.commit();
			}
		} catch (Exception e) {
			System.out.println("[error] : foodDelete");
			e.printStackTrace();
		}

		session.close();

		return res;

	}

	@Override
	public List<FoodDto> MyFoodList(int MEMBER_CODE) {

		List<FoodDto> list = new ArrayList<>();

		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace + ".myFoodList", MEMBER_CODE);

		session.close();

		return list;

	}

	@Override
	public List<MemberProfileDTO> memberList(int MEMBER_CODE) {

		List<MemberProfileDTO> list = new ArrayList<>();

		SqlSession session = getSqlSessionFactory().openSession(false);

		list = session.selectList(namespace2 + ".memberList", MEMBER_CODE);

		session.close();

		return list;
	}

}