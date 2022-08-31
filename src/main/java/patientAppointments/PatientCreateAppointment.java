package patientAppointments;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import appointments.Appointments;
import appointments.AppointmentsDAO;

@WebServlet("/PatientCreateAppointment")
public class PatientCreateAppointment extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session =request.getSession();
		String email = (String)session.getAttribute("email");
		String name = request.getParameter("name");
		String details = request.getParameter("desc");
		String date = request.getParameter("date");
		String time = request.getParameter("hour");
		String specialist = request.getParameter("spec");
		if(email == null) {
			response.sendRedirect("login.jsp");
		}else {
		Appointments ap = new Appointments(email,name,details,date,time,specialist);
		AppointmentsDAO aDAO = new AppointmentsDAO();
		int result = aDAO.createAppointmentDB(ap);
		session.setAttribute("appointmentResult", result);
		out.print(result);
		}
	}

}
