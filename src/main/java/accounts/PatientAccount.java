package accounts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/PatientAccount")
public class PatientAccount extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int age = Integer.valueOf(request.getParameter("age"));
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		PrintWriter out = response.getWriter();
		AccountDAO account = new AccountDAO();
		int result = account.modifyAccountDetails(email, firstName, lastName, age);
		if(result==1) {
			out.print("<p>Account modified successfully</p>");
		}else {
			out.print("<p>Error occured</p>");
		}
	}

}
