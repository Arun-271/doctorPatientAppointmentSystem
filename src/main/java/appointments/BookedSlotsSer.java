package appointments;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/BookedSlotsSer")
public class BookedSlotsSer extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String spec = (String)request.getParameter("id");
		int month = Integer.valueOf(request.getParameter("month"));
		String formatedM;
		if(month < 10) {
			formatedM = '0'+String.valueOf(month);
		}else {
			formatedM = String.valueOf(month);
		}
		AppointmentsDAO aObj = new AppointmentsDAO();
		HttpSession session =request.getSession();
		String email = (String)session.getAttribute("email");
		if(email == null) {
			response.sendRedirect("login.jsp");
		}else {
		PrintWriter out = response.getWriter();
		int val = (spec.equals("general"))?1:(spec.equals("dentist"))?2:3;
		out.print(aObj.bookedSlots(val,formatedM));
		}
	}

}
