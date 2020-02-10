package com.single.model.dao.user;

import org.apache.ibatis.session.SqlSession;

import com.single.model.dto.user.KakaoMemberDTO;
import com.single.model.dto.user.MemberDTO;
import com.single.model.dto.user.NaverMemberDTO;
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

	@Override
	public int naverJoin(NaverMemberDTO naver_member) {
		// TODO Auto-generated method stub
		return 0;
	}
	
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
		return 0;
	}

	// 별명 중복 체크
	@Override
	public int nicknameCheck(String NEW_NICKNAME) {
		return 0;
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

	// 로그인 한 회원의 정보 조회
	@Override
	public MemberDTO loginMember(int MEMBER_CODE) {
		return null;
	}

}
