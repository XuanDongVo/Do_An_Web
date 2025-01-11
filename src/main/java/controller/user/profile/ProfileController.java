package controller.user.profile;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.user.UserRepository;

@WebServlet("/edit_profile")
public class ProfileController extends HttpServlet {
	UserRepository userRepo = new UserRepository();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession();
		String name = req.getParameter("username");
		String phone = req.getParameter("phone");
		String email = req.getParameter("email");
		String address = req.getParameter("address");
//		Long idUser = (Long) session.getAttribute("userId");
		String idUser = req.getParameter("userId");
		try {
			long idUser_convert = Long.parseLong(idUser);
			
			if (phone != null && !phone.startsWith("84")) {
				phone = "84" + phone; // Thêm mã vùng 84
			}
			System.out.println(idUser);
			System.out.println(phone);
			

			userRepo.changeInformationUserById(name, email, phone, address, idUser_convert);

			User user = userRepo.getUserById(idUser_convert);
			session.setAttribute("user", user);
			
			resp.sendRedirect(req.getContextPath() + "/profile");
//			req.getRequestDispatcher(req.getContextPath() + "/profile").forward(req, resp);
		}catch(NumberFormatException nfe) {
			nfe.printStackTrace();
		}
	}
}