package patientAppointments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import accounts.AccountDAO;

@WebServlet("/GetAccountId")
public class GetAccountId extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AccountDAO aObj = new AccountDAO();
		HttpSession session =request.getSession();
		String email = (String)session.getAttribute("email");
		int accountId = aObj.getAccountId(email);
		PrintWriter out = response.getWriter();
		if(email == null) {
			response.sendRedirect("login.jsp");
		}else {
		out.print(accountId);
		}
	}


}
