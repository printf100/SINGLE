package com.single.model.biz.member;

import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;

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
