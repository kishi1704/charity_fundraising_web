package util;

import java.security.NoSuchAlgorithmException;
import java.util.Random;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordCreation {
	public static String generateRandomPassword(int len) {
		String upperChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String lowerChars = "abcdefghijklmnopqrstuvwxyz";
		String numbers = "0123456789";
		String combination = upperChars + lowerChars + numbers;
		char password[] = new char[len];
		Random r = new Random();
		for (int i = 0; i < len; i++) {
			password[i] = combination.charAt(r.nextInt(combination.length()));
		}
		return new String(password);
	}

	public static String encodePassword(String password) throws NoSuchAlgorithmException {
		return DigestUtils.md5Hex(password);
	}
	
}
