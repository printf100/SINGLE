package com.single.model.biz.member;

import com.single.model.dao.member.MemberDAO;
import com.single.model.dao.member.MemberDAOImpl;
import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.util.SHA256.SHA256_Util;

public class MemberBizImpl implements MemberBiz {

	MemberDAO dao = new MemberDAOImpl();

	/*
	 * 회원가입 관련
	 */

	// 회원가입 처리
	@Override
	public int memberJoin(MemberDTO member) {

		// 비밀번호 암호화
		SHA256_Util sha = new SHA256_Util();
		String encrypedPW = sha.encryptSHA256(member.getMEMBER_PASSWORD());
		member.setMEMBER_PASSWORD(encrypedPW);
		System.out.println("MemberBizImpl - memberJoin() 비밀번호 : " + encrypedPW);

		return dao.memberJoin(member);
	}

	// KAKAO 회원가입 처리
	@Override
	public int kakaoJoin(KakaoMemberDTO kakao_member) {

		MemberDTO member = new MemberDTO();
		KakaoMemberDTO kakao = new KakaoMemberDTO();

		member.setMEMBER_VERIFY(kakao_member.getMEMBER_VERIFY());
		member.setMEMBER_EMAIL(kakao_member.getMEMBER_EMAIL());
		member.setMEMBER_NAME(kakao_member.getMEMBER_NAME());
		member.setMEMBER_NICKNAME(kakao_member.getMEMBER_NICKNAME());
		member.setMEMBER_GENDER(kakao_member.getMEMBER_GENDER());

		int kakao_res = 0;
		int res = dao.memberJoinWithSNS(member);

		if (res > 0) {
			MemberDTO new_member = dao.getMemberCode(kakao_member.getMEMBER_EMAIL());

			kakao.setMEMBER_CODE(new_member.getMEMBER_CODE());
			kakao.setKAKAO_ID(kakao_member.getKAKAO_ID());
			kakao.setKAKAO_NICKNAME(kakao_member.getKAKAO_NICKNAME());

			kakao_res = dao.kakaoJoin(kakao);
		}

		return kakao_res;
	}

	// NAVER 회원가입 처리
	@Override
	public int naverJoin(NaverMemberDTO naver_member) {

		MemberDTO member = new MemberDTO();
		NaverMemberDTO naver = new NaverMemberDTO();

		member.setMEMBER_VERIFY(naver_member.getMEMBER_VERIFY());
		member.setMEMBER_EMAIL(naver_member.getMEMBER_EMAIL());
		member.setMEMBER_NAME(naver_member.getMEMBER_NAME());
		member.setMEMBER_NICKNAME(naver_member.getMEMBER_NICKNAME());
		member.setMEMBER_GENDER(naver_member.getMEMBER_GENDER());

		int naver_res = 0;
		int res = dao.memberJoinWithSNS(member);

		if (res > 0) {
			MemberDTO new_member = dao.getMemberCode(naver_member.getMEMBER_EMAIL());

			naver.setMEMBER_CODE(new_member.getMEMBER_CODE());
			naver.setNAVER_ID(naver_member.getNAVER_ID());
			naver.setNAVER_NICKNAME(naver_member.getNAVER_NICKNAME());

			naver_res = dao.naverJoin(naver);
		}

		return naver_res;
	}

	// 이메일 중복 체크
	@Override
	public int emailCheck(String NEW_EMAIL) {
		return dao.emailCheck(NEW_EMAIL);
	}

	// 닉네임 중복 체크
	@Override
	public int nicknameCheck(String NEW_NICKNAME) {
		return dao.nicknameCheck(NEW_NICKNAME);
	}

	/*
	 * 로그인 관련
	 */

	// 로그인 처리
	@Override
	public MemberDTO memberLogin(MemberDTO member) {

		// 비밀번호 암호화
		SHA256_Util sha = new SHA256_Util();
		String encrypedPW = sha.encryptSHA256(member.getMEMBER_PASSWORD());
		member.setMEMBER_PASSWORD(encrypedPW);
		System.out.println("MemberBizImpl - memberLogin() 비밀번호 : " + encrypedPW);
		
		return dao.memberLogin(member);
	}

	// KAKAO 아이디 중복체크
	@Override
	public int kakaoIdCheck(String KAKAO_ID) {
		return dao.kakaoIdCheck(KAKAO_ID);
	}

	// NAVER 아이디 중복체크
	@Override
	public int naverIdCheck(String NAVER_ID) {
		return dao.naverIdCheck(NAVER_ID);
	}

	// 로그인 한 회원의 정보 가져오기
	@Override
	public MemberDTO loginMember(int MEMBER_CODE) {
		return dao.loginMember(MEMBER_CODE);
	}

	// KAKAO 로그인 한 회원의 정보 가져오기
	@Override
	public KakaoMemberDTO kakaoLoginMember(String KAKAO_ID) {
		return dao.kakaoLoginMember(KAKAO_ID);
	}

	// NAVER 로그인 한 회원의 정보 가져오기
	@Override
	public NaverMemberDTO naverLoginMember(String NAVER_ID) {
		return dao.naverLoginMember(NAVER_ID);
	}

}
