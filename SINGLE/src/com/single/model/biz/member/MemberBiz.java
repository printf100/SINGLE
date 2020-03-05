package com.single.model.biz.member;

import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;

public interface MemberBiz {

	/*
	 * 회원가입 관련
	 */

	// 회원가입 처리 + 회원 프로필 정보 NULL 셋팅
	public int memberJoin(MemberDTO dto);

	// KAKAO 회원가입 처리 + 회원 프로필 정보 NULL 셋팅
	public int kakaoJoin(KakaoMemberDTO kakao_member);

	// NAVER 회원가입 처리 + 회원 프로필 정보 NULL 셋팅
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

	// KAKAO 아이디 중복 체크
	public int kakaoIdCheck(String KAKAO_ID);

	// NAVER 아이디 중복 체크
	public int naverIdCheck(String NAVER_ID);

	// 로그인 한 회원의 정보 가져오기
	public MemberDTO loginMember(int MEMBER_CODE);

	// KAKAO 로그인 한 회원의 정보 가져오기
	public KakaoMemberDTO kakaoLoginMember(String KAKAO_ID);

	// NAVER 로그인 한 회원의 정보 가져오기
	public NaverMemberDTO naverLoginMember(String NAVER_ID);

	/*
	 * 회원 정보, 프로필 관련
	 */

	// 회원 정보, 프로필 가져오기
	public MemberProfileDTO selectMemberProfile(int MEMBER_CODE);

	// 프로필 정보 NULL 셋팅
	public int insertMemberProfile(MemberProfileDTO memberProfile);

	// 프로필 사진 수정하기
	public int updateProfileImg(MemberProfileDTO new_img);

	// 프로필 상태메세지 수정하기
	public int updateProfileIntro(MemberProfileDTO new_intro);

	// 회원 닉네임 수정하기
	public int updateNickname(MemberDTO new_nick);

	// 프로필 내위치 수정하기
	public int updateProfileLoc(MemberProfileDTO new_loc);

	// 회원 정보 수정하기
	public int updateMemberInfo(MemberDTO new_info);

	// 비밀번호 수정하기
	public int updateMemberPW(MemberDTO new_pw);
}
