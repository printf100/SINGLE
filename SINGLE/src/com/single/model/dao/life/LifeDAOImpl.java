package com.single.model.dao.life;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.clean.CleanDTO;
import com.single.model.dto.wash.WashDTO;
import com.single.mybatis.SqlMapConfig;

public class LifeDAOImpl extends SqlMapConfig implements LifeDAO {

	final String namespace = "com.single.life-mapper";

	@Override
	public int reservWash(WashDTO info) {
		
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".reservWash", info);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	@Override
	public int reservCancel(int WASH_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".reservCancel", WASH_CODE);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	@Override
	public WashDTO getWashCode(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		WashDTO dto= session.selectOne(namespace + ".getWashCode", MEMBER_CODE);
		
		
		
		session.close();
		
		return dto;
	}

	@Override
	public List<WashDTO> getReservList(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<WashDTO> washList = session.selectList(namespace + ".getReservList", MEMBER_CODE);
		
		
		session.close();
		
		return washList;
	}

	@Override
	public WashDTO getWashInfo(int WASH_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		WashDTO dto= session.selectOne(namespace + ".getWashInfo", WASH_CODE);
		
		session.close();
		
		return dto;
		
	}

	@Override
	public int updateWash(WashDTO washdto) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateWash", washdto);
		
		if (res > 0) {
			session.commit();
		}
		
		session.close();
		
		return res;
	}

	
	
	
	
	
	
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
	public int reservCancelClean(int CLEAN_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.delete(namespace + ".reservCancelClean", CLEAN_CODE);
		
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
	public List<CleanDTO> getReservListClean(int MEMBER_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		List<CleanDTO> cleanList = session.selectList(namespace + ".getReservListClean", MEMBER_CODE);
		
		
		session.close();
		
		return cleanList;
	}

	@Override
	public CleanDTO getCleanInfo(int Clean_CODE) {
		SqlSession session = getSqlSessionFactory().openSession(false);

		CleanDTO dto= session.selectOne(namespace + ".getCleanInfo", Clean_CODE);
		
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
