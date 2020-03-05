package com.single.model.dao.clean;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.clean.CleanDTO;
import com.single.mybatis.SqlMapConfig;

public class CleanDAOImpl extends SqlMapConfig implements CleanDAO {

	final String namespace = "com.single.life-mapper";

	@Override
	public int reservClean(CleanDTO info) {
		
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".reservClean", info);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	@Override
	public int reservCancel(int CLEAN_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".reservCancel", CLEAN_CODE);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	@Override
	public CleanDTO getCleanCode(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		CleanDTO dto= session.selectOne(namespace + ".getCleanCode", MEMBER_CODE);
		
		
		
		session.close();
		
		return dto;
	}

	@Override
	public List<CleanDTO> getReservList(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<CleanDTO> cleanList = session.selectList(namespace + ".getReservList", MEMBER_CODE);
		
		
		session.close();
		
		return cleanList;
	}

	@Override
	public CleanDTO getCleanInfo(int CLEAN_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		CleanDTO dto= session.selectOne(namespace + ".getCleanInfo", CLEAN_CODE);
		
		session.close();
		
		return dto;
		
	}

	@Override
	public int updateClean(CleanDTO cleandto) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateClean", cleandto);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	
	
}
