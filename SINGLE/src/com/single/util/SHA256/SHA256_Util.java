package com.single.util.SHA256;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class SHA256_Util {
	/*
	 * sha-256 암호화 방법
	 * 
	 * 개요
	 *  SHA-256 해시 함수는 어떤 길이의 값을 입력하더라도 256비트의 고정된 결과값을 출력한다.[2] 일반적으로 입력값이 조금만
	 * 변동하여도 출력값이 완전히 달라지기 때문에 출력값을 토대로 입력값을 유추하는 것은 거의 불가능하다. 아주 작은 확률로 입력값이 다름에도
	 * 불구하고 출력값이 같은 경우가 발생하는데 이것을 충돌이라고 한다. 이러한 충돌의 발생 확률이 낮을수록 좋은 함수라고 평가된다. SHA-1은
	 * 
	 * 특징
	 *  SHA-256은 현재 블록체인에서 가장 많이 채택하여 사용되고 있는 암호 방식이다. 출력 속도가 빠르다는 장점을 갖고 있다. 또한
	 * 단방향성의 성질을 띄고 있는 암호화 방법으로 복호화가 불가능하다. 	 * 
	 * SHA 함수들 중 가장 많이 쓰이며, TLS, SSL, PGP, SSH,
	 * IPSec 등 많은 보안 프로토콜과 프로그램에서 사용되고 있다. SHA-1은 이전에 널리 사용되던 MD5를 대신해서 쓰이기도 한다. 혹자는
	 * 좀 더 중요한 기술에는 SHA-256이나 그 이상의 알고리즘을 사용할 것을 권장한다.
	 * 
	 * 
	 * 사용계획...
	 * 회원 가입 시 - 사용자가 정한 pw를 sha-256 를 통해 암호화 하여 DB에 저장한다.
	 * 로그인 시 - 사용자로부터 입력된 pw 값을 암호화 하여 DB에 존재하는 암호문과 비교한다.
	 * 		   DB에 존재하는 암호문과 사용자가 입력한 비밀번호의 암호문이 일치하면 로그인 처리
	 * 
	 * 
	 */
	public String encryptSHA256(String str) {
		String sha = "";

		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");

			sh.update(str.getBytes());
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			sha = sb.toString();

		} catch (NoSuchAlgorithmException e) {
			// e.printStackTrace();
			System.out.println("Encrypt Error : No Such Algorithm Exception");
			sha = null;
		}

		return sha;
	}
}
