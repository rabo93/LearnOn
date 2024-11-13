package com.itwillbs.learnon.handler;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SendMailClient {
	@Autowired
	private MailAuthenticator authenticator;
	
	private final String HOST = "smtp.gmail.com";
	private final String PORT = "587";
	private final String SENDER_ADDRESS = "hem@itwillbs.com";

	public void sendMail(String receiver,String subject , String content) {
		try {
			Properties props = System.getProperties();
			
			props.put("mail.stmp.host", HOST);
			props.put("mail.stmp.port", PORT);
			props.put("mail.stmp.auth", "true");
			props.put("mail.stmp.starttls.enable", "true");
			props.put("mail.stmp.ssl.prorocols", "tLDv1.2");
			props.put("mail.stmp.ssl.trust", HOST);
			
			Session mailSession = Session.getDefaultInstance(props,authenticator);
			Message message = new MimeMessage(mailSession);
			Address senderAddress = new InternetAddress(SENDER_ADDRESS,"런온");
			
			Address receiverAddress = new InternetAddress(receiver);
			message.setHeader("content-type", "text/html; charset=UTF-8");
			message.setFrom(senderAddress);
			message.setSubject(subject);
			message.setContent("<h3>" + content + "<h3>", "text/html; charset=UTF-8");
			message.setSentDate(new Date());
			
			Transport.send(message);
			System.out.println("인증메일 발송 성공");
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}





}
