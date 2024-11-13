package com.itwillbs.learnon.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MailAuthenticator extends Authenticator {
	@Value("${SENDER_MAIL_ADDRESS}")
	private String sender_mail_address;
	
	@Value("${GMAIL_APP_PASSWORD}")
	private String gmail_app_password;
	
	private PasswordAuthentication passwordAuthentication;
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		System.out.println("getPasswordAuthentication() - " + sender_mail_address + ", " + gmail_app_password);
		
		passwordAuthentication = new PasswordAuthentication(sender_mail_address, gmail_app_password);
		return passwordAuthentication;
	}
	
}

