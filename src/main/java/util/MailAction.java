package util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailAction {
	public static final String SMTP_HOST = "smtp.gmail.com";
	public static final int SMTP_PORT = 587;
	public static final String SMTP_GMAIL_USERNAME = "duantuthien38@gmail.com";
	public static final String SMTP_GMAIL_PASSWORD = "spgxihxebioqzwnr";
	
	private String username;
	private String password;
	private Properties prop;
	private Session session;
	
	public MailAction(String username, String pwd) {
		this.username = username;
		this.password = pwd;
		prop = new Properties();
		prop.put("mail.smtp.host", SMTP_HOST);
		prop.put("mail.smtp.port", SMTP_PORT);
		prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.starttls.enable", "true"); // TLS
		session = Session.getInstance(prop, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(MailAction.this.username, MailAction.this.password);
			}
		});
	}
	
	public void sendMessage(String from, String to, String subject, String msg) {
		try {
			Message message = new MimeMessage(this.session);
			message.setFrom(new InternetAddress(from));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setText(msg);
			message.setContent(msg, "text/html; charset=UTF-8");
			Transport.send(message);
			System.out.println("Send Email Success");
		
		}catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
}
