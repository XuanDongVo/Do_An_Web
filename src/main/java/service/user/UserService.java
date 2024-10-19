package service.user;

import entity.User;
import repository.user.UserRepository;

public class UserService {
	private UserRepository userRepository = new UserRepository();

	// lấy ra thông tin người dùng bằng sdt
	public User getInformationUserByPhone(String phone) {
		User user = userRepository.getUserByPhone(phone);
		if (user == null) {
			throw new RuntimeException("User not found");
		}
		return user;
	}

	// thay đổi mật khẩu người dùng
	public void changePassword(String password, String phone) {
		User user = getInformationUserByPhone(phone);
		userRepository.changePassword(user, password);
	}

	// thay đổi thông tin người dùng
	public void changeInformationUser(User user, String name, String address) {
		if (user == null) {
			throw new RuntimeException("user not found");
		}
		userRepository.changeInformationUser(user.getId(), name, address);
	}

	// thay đổi email người dùng
	public void changeEmailUser(User user, String newEmail) {
		if (user == null) {
			throw new RuntimeException("User not found");
		}
		userRepository.changeEmailUser(user, newEmail);
	}
	
	
}
