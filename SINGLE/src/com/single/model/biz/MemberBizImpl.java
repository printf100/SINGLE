package com.single.model.biz;

import com.single.model.dao.MemberDAO;
import com.single.model.dao.MemberDAOImpl;
import com.single.model.dto.KakaoMemberDTO;
import com.single.model.dto.MemberDTO;
import com.single.model.dto.NaverMemberDTO;

public class MemberBizImpl implements MemberBiz {
	
	MemberDAO dao = new MemberDAOImpl();

	@Override
	public int memberJoin(MemberDTO member) {
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
		
		if(res > 0) {
			MemberDTO new_member = dao.getMemberCode(kakao_member.getMEMBER_EMAIL());

			kakao.setMEMBER_CODE(new_member.getMEMBER_CODE());
			kakao.setKAKAO_ID(kakao_member.getKAKAO_ID());
			kakao.setKAKAO_NICKNAME(kakao_member.getKAKAO_NICKNAME());
			
			kakao_res = dao.kakaoJoin(kakao);
		}
		
		return kakao_res;
	}
	
	@Override
	public int naverJoin(NaverMemberDTO naver_member) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int emailCheck(String NEW_EMAIL) {
		return 0;
	}

	@Override
	public int nicknameCheck(String NEW_NICKNAME) {
		return 0;
	}
	
	@Override
	public MemberDTO memberLogin(MemberDTO member) {
		return dao.memberLogin(member);
	}

	@Override
	public MemberDTO loginMember(int MEMBER_CODE) {
		return null;
	}

}
