package accounts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		PrintWriter out = res.getWriter();
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		AccountDAO aDAO = new AccountDAO();
		int result = aDAO.loginDB(email, password);
		HttpSession session =req.getSession();
		session.setAttribute("email", email);
		if (result == 1) {
			try {
				res.sendRedirect("adminHome.jsp");
			} catch (Exception e) {
				System.out.println(e);
			}
		} else if (result == 2) {
			try {
				res.sendRedirect("patientHome.jsp");
			} catch (Exception e) {
				System.out.println(e);
			}
			
		} else {
			out.print("<div><p>Invalid Username and Password</p></div>");
			try {
				req.getRequestDispatcher("/login.jsp").include(req, res);
			} catch (Exception e) {
				System.out.println(e);
			}
		}
	}

}
