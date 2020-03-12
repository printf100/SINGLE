package com.single.util.email;

import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

public class SendEmail {

	// 회원가입 시 이메일 인증 메일 보내기
	public void sendEmail(String MEMBER_EMAIL, String auth) {

		String host = "smtp.gmail.com";
		String subject = "[SINGLE] 회원가입 인증번호 안내 메일";
		String fromName = "SINGLE";
		String from = "seungah1994@gmail.com"; // 보내는 메일
		String to = MEMBER_EMAIL;

		String content = "<p style='font-size:12pt'>인증번호 [ " + auth + " ] 를 팝업창에 입력해주세요.</p>";

		Properties props = new Properties();

		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");

		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("seungah1994@gmail.com", "movvrsweqbseurra");
			}
		});

		Message msg = new MimeMessage(mailSession);
		try {
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));

			InternetAddress[] address = { new InternetAddress(to) };

			msg.setRecipients(Message.RecipientType.TO, address); // 받는 사람 설정
			msg.setSubject(subject); // 제목 설정
			msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
			msg.setContent(content, "text/html; charset=utf-8");

			Transport.send(msg); // 메일 보내기
		} catch (UnsupportedEncodingException | MessagingException e) {
			e.printStackTrace();
		}

	}
	
	// 비밀번호 잊어버렸을 때 재설정 이메일 보내기
	public void sendPwEmail(String CONFIRM_EMAIL, String MEMBER_NAME) {
		
		String host = "smtp.gmail.com";
		String subject = "[SINGLE] 비밀번호 재설정 안내 메일";
		String fromName = "SINGLE";
		String from = "seungah1994@gmail.com"; // 보내는 메일
		String to = CONFIRM_EMAIL;

		 String content = "<div>"
					            + "<h2>비밀번호 재설정 안내</h2>"
					            + "<p style='font-size:10pt'>안녕하세요 " + MEMBER_NAME + "님</p>"
					            + "<p style='font-size:10pt'>본 메일은 비밀번호 재설정을 위해 SINGLE에서 발송하는 메일입니다.</p>"
					            + "<p style='font-size:10pt'>본인이 요청한 메일이 아니라면 개인정보 보호를 위해 비밀번호를 재설정해주세요.</p>"
					            + "<p style='font-size:10pt'>비밀번호를 다시 설정하려면 '비밀번호 재설정' 링크를 클릭해주세요.</p><br><br>"
					            + "<a href='http://qclass.iptime.org:8787/SINGLE/member/pwResetEmailpage.do' style='color: white; text-decoration: none; border-radius: 3px; background-color: #46b8da; padding: 10px 14px; border: none;'>비밀번호 재설정</a>"
					            + "</div>";


		Properties props = new Properties();

		// G-Mail SMTP 사용시
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.user", from);
		props.put("mail.smtp.auth", "true");

		Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("seungah1994@gmail.com", "movvrsweqbseurra");
			}
		});

		Message msg = new MimeMessage(mailSession);
		try {
			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));

			InternetAddress[] address = { new InternetAddress(to) };

			msg.setRecipients(Message.RecipientType.TO, address); // 받는 사람 설정
			msg.setSubject(subject); // 제목 설정
			msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
			msg.setContent(content, "text/html; charset=utf-8");

			Transport.send(msg); // 메일 보내기
		} catch (UnsupportedEncodingException | MessagingException e) {
			e.printStackTrace();
		}
	}
}
