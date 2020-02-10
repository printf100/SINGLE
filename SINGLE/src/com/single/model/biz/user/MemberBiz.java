package com.single.model.biz.user;

import com.single.model.dto.user.KakaoMemberDTO;
import com.single.model.dto.user.MemberDTO;
import com.single.model.dto.user.NaverMemberDTO;

public interface MemberBiz {

	/*
	 * 회원가입 관련
	 */
	
	// 회원가입 처리
	public int memberJoin(MemberDTO dto);

	// KAKAO 회원가입 처리
	public int kakaoJoin(KakaoMemberDTO kakao_member);

	// NAVER 회원가입 처리
	public int naverJoin(NaverMemberDTO naver_member);
	
	// 이메일 중복 체크
	public int emailCheck(String NEW_EMAIL);
	
	// 별명 중복 체크
	public int nicknameCheck(String NEW_NICKNAME);
	
	
	/*
	 * 로그인 관련
	 */
	
	// 로그인 처리
	public MemberDTO memberLogin(MemberDTO member);
	
	// 로그인 한 회원의 정보 조회
	public MemberDTO loginMember(int MEMBER_CODE);
}
