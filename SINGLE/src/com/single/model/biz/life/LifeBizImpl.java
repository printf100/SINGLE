package com.single.model.biz.life;

import java.util.List;

import com.single.model.dao.life.LifeDAO;
import com.single.model.dao.life.LifeDAOImpl;
import com.single.model.dto.clean.CleanDTO;
import com.single.model.dto.wash.WashDTO;

public class LifeBizImpl implements LifeBiz {

	LifeDAO dao = new LifeDAOImpl();

	@Override
	public int reservWash(WashDTO washdto) {
		return dao.reservWash(washdto);
	}

	@Override
	public int reservCancel(int WASH_CODE) {
		return dao.reservCancel(WASH_CODE);
	}

	@Override
	public WashDTO getWashCode(int MEMBER_CODE) {
		return dao.getWashCode(MEMBER_CODE);
	}

	@Override
	public List<WashDTO> getReservList(int MEMBER_CODE) {
		return dao.getReservList(MEMBER_CODE);
	}

	@Override
	public WashDTO getWashInfo(int WASH_CODE) {
		return dao.getWashInfo(WASH_CODE);
	}

	@Override
	public int updateWash(WashDTO washdto) {
		return dao.updateWash(washdto);
	}
	


	
	
	
	
	
	@Override
	public int reservClean(CleanDTO cleandto) {
		return dao.reservClean(cleandto);
	}

	@Override
	public int reservCancelClean(int CLEAN_CODE) {
		return dao.reservCancelClean(CLEAN_CODE);
	}

	@Override
	public CleanDTO getCleanCode(int MEMBER_CODE) {
		return dao.getCleanCode(MEMBER_CODE);
	}

	@Override
	public List<CleanDTO> getReservListClean(int MEMBER_CODE) {
		return dao.getReservListClean(MEMBER_CODE);
	}

	@Override
	public CleanDTO getCleanInfo(int CLEAN_CODE) {
		return dao.getCleanInfo(CLEAN_CODE);
	}

	@Override
	public int updateClean(CleanDTO cleandto) {
		return dao.updateClean(cleandto);
	}
	
	

}
