package accounts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/signup")
public class Signup extends HttpServlet {
	public void doPost(HttpServletRequest request , HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		int age = Integer.parseInt(request.getParameter("age"));
		Accounts a1 = new Accounts(email,password,firstName,lastName,age);
		AccountDAO aDB =new AccountDAO();
		int result = aDB.createAccountDb(a1);
		try {
			if(result == 1) {
				out.print("<div><p>There is a account already associated with this email</p></div>");
				request.getRequestDispatcher("/signup.jsp").include(request,response);
			}else if(result == 2) {
				out.print("<div><p>Account created successfully</p></div>");
				request.getRequestDispatcher("/signup.jsp").include(request,response);
			}else {
				out.print("<div><p>Internal error occured</p></div>");
				request.getRequestDispatcher("/signup.jsp").include(request,response);
			}
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
