package com.single.model.dao.clean;

import java.util.List;

import com.single.model.dto.clean.CleanDTO;

public interface CleanDAO {

	// 빨래수거 예약하기
	public int reservClean(CleanDTO cleandto);

	// 예약 취소하기
	public int reservCancel(int CLEAN_CODE);

	// 마지막에 예약한 내역 가져오기
	public CleanDTO getCleanCode(int MEMBER_CODE);

	// 전체 예약 내역 가져오기
	public List<CleanDTO> getReservList(int MEMBER_CODE);

	// CLEAN_INFO로 예약 내역 가지고 오기
	public CleanDTO getCleanInfo(int CLEAN_CODE);

	// 예약내역 수정하기
	public int updateClean(CleanDTO cleandto);
}
