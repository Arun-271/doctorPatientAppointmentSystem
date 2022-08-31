package patientAppointments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import appointments.AppointmentsDAO;

@WebServlet("/DeleteAppointment")
public class DeleteAppointment extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		PrintWriter out = response.getWriter();
		String email = (String) session.getAttribute("email");
		int id = Integer.valueOf(request.getParameter("id"));
		AppointmentsDAO appointments = new AppointmentsDAO();
		int result = appointments.deleteAppointment(id, email);
		if(result == 1) {
			out.print("<div><p>Deleted Successfully</p></div>");
		}else {
			out.print("<div><p>Internal error occured</p></div>");
		}
	}

}
