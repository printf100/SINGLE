package com.single.model.dao.member;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.member.KakaoMemberDTO;
import com.single.model.dto.member.MemberDTO;
import com.single.model.dto.member.MemberProfileDTO;
import com.single.model.dto.member.NaverMemberDTO;
import com.single.mybatis.SqlMapConfig;

public class MemberDAOImpl extends SqlMapConfig implements MemberDAO {

	final String namespace = "com.single.member-mapper";

	/*
	 * 회원가입 관련
	 */

	// 회원가입 처리
	@Override
	public int memberJoin(MemberDTO member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".join", member);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// SNS 회원가입 처리 (비밀번호 없이 MEMBER 테이블에 INSERT)
	@Override
	public int memberJoinWithSNS(MemberDTO member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".joinWithSns", member);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// KAKAO 회원가입 처리
	@Override
	public int kakaoJoin(KakaoMemberDTO kakao_member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".kakaojoin", kakao_member);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// NAVER 회원가입 처리
	@Override
	public int naverJoin(NaverMemberDTO naver_member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".naverjoin", naver_member);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 이메일로 회원번호 가져오기 (SNS 회원가입 시 FK인 회원번호를 넣기 위함)
	@Override
	public MemberDTO getMemberCode(String MEMBER_EMAIL) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberDTO memberCode = session.selectOne(namespace + ".getMemberCode", MEMBER_EMAIL);

		session.close();

		return memberCode;
	}

	// 이메일 중복 체크
	@Override
	public int emailCheck(String NEW_EMAIL) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int email = session.selectOne(namespace + ".getEmail", NEW_EMAIL);

		session.close();

		return email;
	}

	// 별명 중복 체크
	@Override
	public int nicknameCheck(String NEW_NICKNAME) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int nickname = session.selectOne(namespace + ".getNick", NEW_NICKNAME);

		session.close();

		return nickname;
	}

	/*
	 * 로그인 관련
	 */

	// 로그인 처리
	@Override
	public MemberDTO memberLogin(MemberDTO member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberDTO loginMember = session.selectOne(namespace + ".login", member);

		session.close();

		return loginMember;
	}

	// KAKAO 아이디 중복체크
	@Override
	public int kakaoIdCheck(String KAKAO_ID) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int kakao_id = session.selectOne(namespace + ".getKakaoId", KAKAO_ID);

		session.close();

		return kakao_id;
	}

	// NAVER 아이디 중복체크
	@Override
	public int naverIdCheck(String NAVER_ID) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int naver_id = session.selectOne(namespace + ".getNaverId", NAVER_ID);

		session.close();

		return naver_id;
	}

	// 로그인 한 회원의 정보 조회
	@Override
	public MemberDTO loginMember(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberDTO loginMember = session.selectOne(namespace + ".getLoginMember", MEMBER_CODE);

		session.close();

		return loginMember;
	}

	// KAKAO 로그인 한 회원의 정보 가져오기
	@Override
	public KakaoMemberDTO kakaoLoginMember(String KAKAO_ID) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		KakaoMemberDTO kakaoLoginMember = session.selectOne(namespace + ".getKakaoLoginMember", KAKAO_ID);

		session.close();

		return kakaoLoginMember;
	}

	// NAVER 로그인 한 회원의 정보 가져오기
	@Override
	public NaverMemberDTO naverLoginMember(String NAVER_ID) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		NaverMemberDTO naverLoginMember = session.selectOne(namespace + ".getNaverLoginMember", NAVER_ID);

		session.close();

		return naverLoginMember;
	}

	/*
	 * 회원 정보, 프로필 관련
	 */

	// 회원 정보, 프로필 가져오기
	@Override
	public MemberProfileDTO selectMemberProfile(int MEMBER_CODE) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		MemberProfileDTO memberProfile = session.selectOne(namespace + ".getMemberProfile", MEMBER_CODE);

		session.close();

		return memberProfile;
	}

	// 프로필 정보 NULL 셋팅
	@Override
	public int insertMemberProfile(MemberProfileDTO memberProfile) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.insert(namespace + ".insertMemberProfile", memberProfile);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 프로필 사진 수정하기
	@Override
	public int updateProfileImg(MemberProfileDTO new_img) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateProfileImg", new_img);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 프로필 상태메세지 수정하기
	@Override
	public int updateProfileIntro(MemberProfileDTO new_intro) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateProfileIntro", new_intro);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 회원 닉네임 수정하기
	@Override
	public int updateNickname(MemberDTO new_nick) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateNickname", new_nick);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 프로필 내위치 수정하기
	@Override
	public int updateProfileLoc(MemberProfileDTO new_loc) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateProfileLoc", new_loc);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 회원 정보 수정하기
	@Override
	public int updateMemberInfo(MemberDTO member) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberInfo", member);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

	// 비밀번호 수정하기
	@Override
	public int updateMemberPW(MemberDTO new_pw) {

		SqlSession session = getSqlSessionFactory().openSession(false);

		int res = session.update(namespace + ".updateMemberPW", new_pw);
		if (res > 0) {
			session.commit();
		}

		session.close();

		return res;
	}

}
