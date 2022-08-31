package accounts;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;


@WebServlet("/ViewAccountDetails")
public class ViewAccountDetails extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		AccountDAO aObj = new AccountDAO();
		JSONArray res = aObj.viewAccountDetails(email);
		out.print(res);
	}


}
