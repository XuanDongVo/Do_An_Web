package controller.user.profile;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.cart.CartRepository;
import repository.user.UserRepository;
import service.cartdetail.CartDetailService;
@WebServlet("/verifyPhoneNumberProfile")
public class VerifyPhoneProfileController extends HttpServlet{
	UserRepository userRepository = new UserRepository();


	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// Lấy OTP và số điện thoại từ session
		HttpSession session = req.getSession();
		session.setMaxInactiveInterval(24 * 3600); // 24 giờ
		String otp = String.valueOf(session.getAttribute("otp"));
		String phone = (String) session.getAttribute("phone");
		String name = (String) session.getAttribute("name");
		String email = (String) session.getAttribute("email");
		String address = (String) session.getAttribute("address");
		String userId = (String) session.getAttribute("userId");

		// Lấy mã OTP người dùng nhập vào
		String otpVerify = req.getParameter("otp_verify");
//		int otpVerifyConvert = Integer.parseInt(otpVerify);

		System.out.println(otp);
		System.out.println(phone);
		System.out.println(otpVerify);

		if (otpVerify != null) {
			if (otpVerify.equals(otp)) {
				try {
					long idUser_convert = Long.parseLong(userId);
					userRepository.changeInformationUserById(name, email, phone, address, idUser_convert);

					User user = userRepository.getUserById(idUser_convert);
					session.setAttribute("user", user);
				resp.sendRedirect(req.getContextPath()+"/profile");
				}catch(NumberFormatException nfe) {
					nfe.printStackTrace();
				}
				
			} else {
				System.out.println("Lỗi mã OTP");
				req.setAttribute("errorMessage", "Mã OTP không đúng. Vui lòng thử lại.");
				req.getRequestDispatcher("view/user/verify.jsp").forward(req, resp);
				return;
			}
		} else {
			System.out.println("Lỗi ");
			req.setAttribute("errorMessage", "Vui lòng nhập mã OTP.");
			req.getRequestDispatcher("view/user/verify.jsp").forward(req, resp);
		}
	}
}
