package utils;

import org.mindrot.jbcrypt.BCrypt;

public class EncryptAndDencrypt {
	public String encrypt(String password) {
		return BCrypt.hashpw(password, BCrypt.gensalt());
	}

	public Boolean checkPassword(String password, String encryptedPassword) {
		return BCrypt.checkpw(password, encryptedPassword);
	}
}
