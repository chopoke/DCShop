package com.spring.DCShop.join.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailSendException;

// JavaMail API
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import org.springframework.stereotype.Service;

@Service
public class EmailValidationServiceImpl implements EmailValidationService, InitializingBean {

	
	
	private JavaMailSender mailSender;

	// --- SMTP 기본 설정을 @Value로 주입 ---
	@Value("${mail.host}")
	private String host;

	@Value("${mail.port}")
	private int port;

	@Value("${mail.username}")
	private String username;

	@Value("${mail.password}")
	private String password;

	@Value("${mail.protocol}")
	private String protocol;

	@Value("${mail.defaultEncoding}")
	private String defaultEncoding;

	@Value("${mail.from}")
	private String from;

	@Value("${mail.smtp.auth}")
	private String smtpAuth;
	@Value("${mail.smtp.starttls.enable}")
	private String starttlsEnable;
	@Value("${mail.smtp.starttls.required}")
	private String starttlsRequired;
	@Value("${mail.smtp.connectiontimeout}")
	private String connTimeout;
	@Value("${mail.smtp.timeout}")
	private String readTimeout;
	@Value("${mail.smtp.writetimeout}")
	private String writeTimeout;
	@Value("${mail.debug}")
	private String debug;

	@Value("${email.code.ttl.millis}")
	private long codeTtlMillis;

	@Override
	public void afterPropertiesSet() throws Exception {
		System.out.println("EmailValidationServiceImpl - afterPropertiesSet");
		
		//JavaMail API 활용해서 gmail 서버세 요청을 보내고 stmp를 활용해서 해당 (수신자)to 주소로 메일이 전송됨

		// 기본 연결 정보와 인코딩 설정(인코딩 : UTF-8)
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(host);
		sender.setPort(port);
		sender.setUsername(username);
		sender.setPassword(password);
		sender.setProtocol(protocol);
		sender.setDefaultEncoding(defaultEncoding);

		// ✅ STARTTLS 등 필수 속성 주입
		Properties props = sender.getJavaMailProperties();
		props.setProperty("mail.smtp.auth", smtpAuth); // "true"
		props.setProperty("mail.smtp.starttls.enable", starttlsEnable); // "true" (587일 때)
		props.setProperty("mail.smtp.starttls.required", starttlsRequired); // "true"
		
		// 587에서는 TLS 사용, 465에서는 SSL 사용 해야하는데, 현재 587이여서... 
		// 참고 사이트 https://shanepark.tistory.com/426
		// TLS는 인터넷 커뮤니케이션을 위한 개인 정보와 데이터 무결성을 제공하는 보안 프로토콜[전송 계층에서 보안]
		
		props.setProperty("mail.smtp.ssl.enable", "false");
		props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
		props.setProperty("mail.smtp.connectiontimeout", connTimeout);
		props.setProperty("mail.smtp.timeout", readTimeout);
		props.setProperty("mail.smtp.writetimeout", writeTimeout);
		props.setProperty("mail.mime.charset", defaultEncoding);
		// 필요 시 신뢰 호스트
		props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
		// 임시 디버그
		props.setProperty("mail.debug", debug);

		this.mailSender = sender;

		// (선택) 실제 적용값 로그로 눈으로 확인
		System.out.println("[MAIL] host=" + sender.getHost() + ", port=" + sender.getPort() + ", starttls="
				+ props.getProperty("mail.smtp.starttls.enable") + ", ssl="
				+ props.getProperty("mail.smtp.ssl.enable"));
	}

	/**
	 * 
	 * @purpose 받는 사람, 인증코드, 텍스트 sendTextMail 전달...
	 * 
	 */
	@Override
	public void sendValidationCode(HttpServletRequest request) {
		System.out.println("EmailValidationServiceImpl - sendValidationCode");
		
		String to = request.getParameter("to");
		String code = generate6Digits();
		String subject = "[인증번호] " + code;
		String body = new StringBuilder().append("인증번호는 ").append(code).append(" 입니다.\n").toString();

		// sendTextMail로 매개변수 전달
		sendTextMail(to, subject, body);

		// 성공적으로 보냈다면, 세션에 저장 : 검증을 위해
		long expireAt = System.currentTimeMillis() + codeTtlMillis;
		request.getSession(true).setAttribute("EMAIL_CODE", code);
		request.getSession().setAttribute("EMAIL_CODE_EXPIRE", expireAt);

	}

	/**
	 * 
	 * @purpose 코드 6자리 검증
	 * 
	 */
	@Override
	public Map<String, Object> verifyCode(HttpServletRequest request) {
		System.out.println("EmailValidationServiceImpl - verifyCode");
		
		Map<String, Object> res = new HashMap<String, Object>();

		// 비교할 세션에 저장된 6자리 코드 및 만료 시간
		Object saved = request.getSession().getAttribute("EMAIL_CODE");
		Object expObj = request.getSession().getAttribute("EMAIL_CODE_EXPIRE");
		
		// 사용자가 이메일 보고 입력한 코드
		String input = request.getParameter("code");
		
		// 코드가 불일치 여부
		boolean ok = ((String) saved).equals(input);
		res.put("ok", ok);
		// 일치하지 않으면, 인증 실패, 코드를 확인하세요.
		if (!ok) {
			res.put("reason", "MISMATCH");
		} else {
			// 성공 후 세션 제거
			request.getSession().removeAttribute("EMAIL_CODE");
			request.getSession().removeAttribute("EMAIL_CODE_EXPIRE");
		}
		return res;
	}

	/**
	 * 
	 * @purpose 메일 보내는 메서드
	 * 
	 */
	private void sendTextMail(String to, String subject, String text) {
		System.out.println("EmailValidationServiceImpl - sendTextMail");
		
		MimeMessage mail  = mailSender.createMimeMessage();
		try {
			System.out.println(from);
			// MimeMessageHelper는 내부적으로 위에서 수동으로 한 일을 “편하게” 해 주는 래퍼이며, 인코딩(UTP-8), HTML 여부, 멀티파트 경계(boundary), 첨부/인라인 파트
			MimeMessageHelper helper = new MimeMessageHelper(mail, false, defaultEncoding);
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(text, false);
			mailSender.send(mail);
		} catch (MessagingException e) {
			throw new MailSendException("메일 전송 실패", e);
		}
	}

	/**
	 * 
	 * @purpose 6자리 난수 생성
	 * 
	 */
	private String generate6Digits() {
		System.out.println("EmailValidationServiceImpl - generate6Digits");
		int randomNumber = (int) (Math.random() * 899999) + 100000;
		return Integer.toString(randomNumber);
	}

}