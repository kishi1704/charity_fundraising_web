package util;

import java.io.File;

import model.User;

public class UserAction {
	public static boolean sendRegisterMail(User u, String newPassword, File registerForm ) {
		MailAction mailAction = new MailAction(MailAction.SMTP_GMAIL_USERNAME, MailAction.SMTP_GMAIL_PASSWORD);
		try {
			String content = FileAction.readFile(registerForm);
			content = content.replaceAll("@username", u.getUsername());
			content = content.replaceAll("@password", newPassword);
			content = content.replaceAll("@sdt", u.getPhoneNumber());
			content = content.replaceAll("@address", u.getAddress());
			content = content.replaceFirst("@fullname", u.getFullName());
			content = content.replaceAll("@email", u.getEmail());
			mailAction.sendMessage(MailAction.SMTP_GMAIL_USERNAME, u.getEmail(), "Thư xem thông tin tài khoản đăng ký", content);
			return true;
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public static boolean sendPasswordResetMail(User u, String newPassword) {
		MailAction mailAction = new MailAction(MailAction.SMTP_GMAIL_USERNAME, MailAction.SMTP_GMAIL_PASSWORD);
		String content="Xin chào ,mật khẩu mới cho tài khoản " + u.getUsername() + " là :" + newPassword;
		mailAction.sendMessage(MailAction.SMTP_GMAIL_USERNAME, u.getEmail(), "Thay đổi mật khẩu", content);
		return true;
	}
}
