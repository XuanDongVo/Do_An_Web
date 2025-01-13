package controller.user.profile;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.user.UserRepository;
import service.stringeeCall.StringeeCallService;
@WebServlet("/sendOtpProfile")
public class SendOtpChangeProfilePhoneController extends HttpServlet{
	UserRepository userRespository = new UserRepository();
	StringeeCallService stringee = new StringeeCallService();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	// Xử lý POST request từ form gửi OTP
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String phone = (String) session.getAttribute("phone");
		String name = (String) session.getAttribute("name");
		String email = (String) session.getAttribute("email");
		String address = (String) session.getAttribute("address");
		String userId = (String) session.getAttribute("userId");
		session.setMaxInactiveInterval(24 * 3600); // 24 giờ

		try {
			// Tạo OTP
			int otp = StringeeCallService.generateRandomOtp();
			String otpConvertString = StringeeCallService.convertOtpToWords(otp);

			// Gửi OTP qua Stringee
			StringeeCallService.makeCall(phone, otpConvertString);
			System.out.println(otpConvertString);

			// Lưu OTP và số điện thoại vào session
			session.setAttribute("otp", otp);
			session.setAttribute("userId", userId);
			session.setAttribute("name", name);
			session.setAttribute("phone", phone);
			session.setAttribute("email", email);
			session.setAttribute("address", address);

			response.sendRedirect("view/user/verify_profile.jsp"); // Chuyển hướng sang trang xác thực
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().write("Error sending OTP: " + e.getMessage());
		}
	}
}
