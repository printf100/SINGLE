package com.single.model.biz.clean;

import java.util.List;

import com.single.model.dao.clean.CleanDAO;
import com.single.model.dao.clean.CleanDAOImpl;
import com.single.model.dto.clean.CleanDTO;

public class CleanBizImpl implements CleanBiz {

	CleanDAO dao = new CleanDAOImpl();

	@Override
	public int reservClean(CleanDTO cleandto) {
		return dao.reservClean(cleandto);
	}

	@Override
	public int reservCancel(int CLEAN_CODE) {
		return dao.reservCancel(CLEAN_CODE);
	}

	@Override
	public CleanDTO getCleanCode(int MEMBER_CODE) {
		return dao.getCleanCode(MEMBER_CODE);
	}

	@Override
	public List<CleanDTO> getReservList(int MEMBER_CODE) {
		return dao.getReservList(MEMBER_CODE);
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
