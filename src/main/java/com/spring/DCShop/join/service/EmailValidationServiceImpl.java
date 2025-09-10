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
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailValidationServiceImpl implements EmailValidationService, InitializingBean {

	private JavaMailSender mailSender;

	// --- SMTP 기본 설정을 위해서 app.properties에서 값 가져오기 ---
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

	/**
	 * 
	 * @purpose 초기값설정 
	 *  
	 */
	@Override
	public void afterPropertiesSet() throws Exception {

		//JavaMail API 활용해서 gmail 서버세 요청을 보내고 stmp를 활용해서 해당 (수신자)to 주소로 메일이 전송됨

		// 기본 연결 정보와 인코딩 설정(인코딩 : UTF-8)
		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost(host);
		sender.setPort(port);
		sender.setUsername(username);
		sender.setPassword(password);
		sender.setProtocol(protocol);
		sender.setDefaultEncoding(defaultEncoding);

		
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
		props.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
		props.setProperty("mail.debug", debug);

		this.mailSender = sender;
	}
	
	/**
	 * 
	 * @purpose 받는 사람, 인증코드, 텍스트 sendTextMail 전달...
	 * 
	 */
	@Override
	public String sendValidationCode(HttpServletRequest request) {

		String to = request.getParameter("to");
		System.out.println(to);
		String code = generate6Digits();
		String subject = "[인증번호] " + code;
		String body = new StringBuilder().append("인증번호는 ").append(code).append(" 입니다.\n").append("유효시간: ")
				.append(codeTtlMillis / 1000).append("초").toString();

		sendTextMail(to, subject, body);

		long expireAt = System.currentTimeMillis() + codeTtlMillis;
		request.getSession(true).setAttribute("EMAIL_CODE", code);
		request.getSession().setAttribute("EMAIL_CODE_EXPIRE", expireAt);

		return code;
	}
	
	/**
	 * 
	 * @purpose 코드 6자리 검증
	 * 
	 */
	@Override
	public Map<String, Object> verifyCode(HttpServletRequest request) {
		Map<String, Object> res = new HashMap<String, Object>();

		Object saved = request.getSession().getAttribute("EMAIL_CODE");
		Object expObj = request.getSession().getAttribute("EMAIL_CODE_EXPIRE");
		String input = request.getParameter("code");

		if (!(saved instanceof String) || !(expObj instanceof Long)) {
			res.put("ok", false);
			res.put("reason", "NO_SESSION"); // 코드 발송 전이거나 세션 만료
			return res;
		}
		
		// 현재 : 10:00 인증 번호를 받았다면
		long now = System.currentTimeMillis();
		
		// 발급시 : 만료 시간 10:03 | 현재 10:04 이면 만료
		long exp = (Long) expObj;
		// 만료시 전달됨		
		if (now > exp) {
			res.put("ok", false);
			res.put("reason", "EXPIRED");
			return res;
		}

		// 세션에 둔, 인증번호와 일치하는지
		boolean ok = ((String) saved).equals(input);
		res.put("ok", ok);
		if (!ok) {
			res.put("reason", "MISMATCH");
		} else {
			// 일치하면, 세션에서 제거[이메일 인증 코드랑 만료시간 제거]
			request.getSession().removeAttribute("EMAIL_CODE");
			request.getSession().removeAttribute("EMAIL_CODE_EXPIRE");
		}
		return res;
	}

	private void sendTextMail(String to, String subject, String text) {
		MimeMessage mime = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(mime, false, defaultEncoding);
			InternetAddress fromAddr = parseFrom(from); // "Name <addr>" 지원
			helper.setFrom(fromAddr);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(text, false);
			mailSender.send(mime);
		} catch (MessagingException e) {
			throw new MailSendException("메일 전송 실패", e);
		}
	}

	private InternetAddress parseFrom(String fromProp) {
		try {
			String name = fromProp;
			String addr = fromProp;
			int lt = fromProp.indexOf('<');
			int gt = fromProp.indexOf('>');
			if (lt >= 0 && gt > lt) {
				name = fromProp.substring(0, lt).trim();
				addr = fromProp.substring(lt + 1, gt).trim();
			}
			return new InternetAddress(addr, name, defaultEncoding);
		} catch (Exception e) {
			// 형식이 이상하면 그대로 세팅 시도
			try {
				return new InternetAddress(fromProp);
			} catch (Exception ex) {
				throw new IllegalArgumentException("mail.from 형식 오류: " + fromProp);
			}
		}
	}

	private String generate6Digits() {
		int randomNumber = (int) (Math.random() * 899999) + 100000;
		return Integer.toString(randomNumber);
	}

}