package accounts;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogutServlet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse res) {
		HttpSession session = req.getSession();
		session.removeAttribute("email");
		session.invalidate();
		try {
			res.sendRedirect("login.jsp");
		} catch (Exception e) {
			System.out.print(e);
		}
	}
}
