package com.single.model.biz.life;

import java.util.List;

import com.single.model.dto.clean.CleanDTO;
import com.single.model.dto.wash.WashDTO;

public interface LifeBiz {

	// 빨래수거 예약하기
	public int reservWash(WashDTO washdto);

	// 예약 취소하기
	public int reservCancel(int WASH_CODE);

	// 마지막에 예약한 내역 가져오기
	public WashDTO getWashCode(int MEMBER_CODE);

	// 전체 예약 내역 가져오기
	public List<WashDTO> getReservList(int MEMBER_CODE);

	// WASH_INFO로 예약 내역 가지고 오기
	public WashDTO getWashInfo(int WASH_CODE);

	// 예약내역 수정하기
	public int updateWash(WashDTO washdto);

	// 청소 예약하기
	public int reservClean(CleanDTO cleandto);

	// 청소예약 취소하기
	public int reservCancelClean(int CLEAN_CODE);

	// 마지막에 예약한 내역 가져오기
	public CleanDTO getCleanCode(int MEMBER_CODE);

	// 전체 예약 내역 가져오기
	public List<CleanDTO> getReservListClean(int MEMBER_CODE);

	// CLEAN_INFO로 예약 내역 가지고 오기
	public CleanDTO getCleanInfo(int CLEAN_CODE);

	// 예약내역 수정하기
	public int updateClean(CleanDTO cleandto);

}
