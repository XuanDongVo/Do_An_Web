package controller.admin.authenticate;

import java.io.IOException;

import entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/adminLogin")
public class AdminLoginController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    String phone = req.getParameter("phone");
	    String password = req.getParameter("password");
	    
	    

	    User user = new User(); 
	    req.getSession().setAttribute("user", user);

	    // Forward đến trang admin
	    resp.sendRedirect(req.getContextPath() + "/view/admin/admin.jsp");
	}

}
