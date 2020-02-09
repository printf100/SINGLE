package com.single.model.dao;

import com.single.model.dto.KakaoMemberDTO;
import com.single.model.dto.MemberDTO;
import com.single.model.dto.NaverMemberDTO;

public interface MemberDAO {

	/*
	 * 회원가입 관련
	 */

	// 회원가입 처리
	public int memberJoin(MemberDTO member);

	// SNS 회원가입 처리 (비밀번호 없이 MEMBER 테이블에 INSERT)
	public int memberJoinWithSNS(MemberDTO member);

	// KAKAO 회원가입 처리
	public int kakaoJoin(KakaoMemberDTO kakao_member);

	// NAVER 회원가입 처리
	public int naverJoin(NaverMemberDTO naver_member);
	
	// 이메일로 회원번호 가져오기 (SNS 회원가입 시 FK인 회원번호를 넣기 위함)
	public MemberDTO getMemberCode(String MEMBER_EMAIL);

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
