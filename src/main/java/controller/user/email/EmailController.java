package controller.user.email;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.mail.MailService;

@WebServlet("/email")
public class EmailController extends HttpServlet {

	private MailService mailService = new MailService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		
		if ("verify".equals(action)) {
			verifyEmail(req, resp);
		} else if ("send".equals(action)) {
			sendEmail(req, resp);
		} else {
			resp.getWriter().write("Invalid action.");
		}
	}

	// xác thực email người dùng
	private void verifyEmail(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String token = req.getParameter("code");
		String email = req.getParameter("to");
		
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		String verifyToken = (String) session.getAttribute("verifyToken");
		
		// kiểm tra token 
		if (token.equals(verifyToken)) {
			resp.getWriter().write("Verification successful.");
			mailService.updateEmail(email, user);
		} else {
			resp.getWriter().write("Verification failed.");
		}
	}

	// gửi email cho người dùng 
	private void sendEmail(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String emailTo = req.getParameter("to");
		
		HttpSession session = req.getSession();
		String verifyToken = mailService.generateVerificationCode();
		session.setAttribute("verifyToken", verifyToken);
		
		// gửi email cho người dừng để xác thực mail
		mailService.sendVerificationEmail(emailTo, verifyToken);
		resp.getWriter().write("Verification email sent to " + emailTo);
	}
}
