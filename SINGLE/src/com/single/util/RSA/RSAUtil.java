package com.single.util.RSA;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public class RSAUtil {

	private KeyPairGenerator generator;
	private KeyFactory keyFactory;
	private KeyPair keyPair;
	private Cipher cipher;

	// rsa2048객체 생성!
	public RSAUtil() {
		try {

			generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(2048);
			keyFactory = KeyFactory.getInstance("RSA");
			cipher = Cipher.getInstance("RSA");

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		}

	}

	/*
	 * 새로운 키값을 가진 RSA 생성
	 * 
	 * @return com.utility.rsaweb.RSA
	 */
	public RSA createRSA() {
		RSA rsa = null;

		try {
			keyPair = generator.generateKeyPair();

			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			RSAPublicKeySpec publicSpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String modulus = publicSpec.getModulus().toString(16);
			String exponent = publicSpec.getPublicExponent().toString(16);

			rsa = new RSA(privateKey, modulus, exponent);

		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}

		return rsa;
	}

	/*
	 * 개인키를 이용한 RSA 복호화
	 * 
	 * @param privateKey session에 저장된 privateKey
	 * 
	 * @param encryptedText 암호화된 문자열
	 */
	public String getDecryptText(PrivateKey privateKey, String encryptedText)
			throws InvalidKeyException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(hexToByteArray(encryptedText));

		return new String(decryptedBytes, "UTF-8");
	}

	// 16진수 문자열을 byte 배열로 변환
	private byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] bytes = new byte[hex.length() / 2];

		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		return bytes;
	}
}
