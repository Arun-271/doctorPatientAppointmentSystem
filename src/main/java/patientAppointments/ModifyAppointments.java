package patientAppointments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import appointments.AppointmentsDAO;

@WebServlet("/ModifyAppointments")
public class ModifyAppointments extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.valueOf(request.getParameter("id"));
		PrintWriter out = response.getWriter();
		String date  = request.getParameter("date");
		String time  = request.getParameter("time");
		String endDate = request.getParameter("endDate");
		String endTime = request.getParameter("endTime");
		AppointmentsDAO appointments  = new AppointmentsDAO();
		int result = appointments.modifyAppointment(id, date, time,endDate,endTime);
		if(result == 1) {
			out.print("<div><p>Modified Successfully</p></div>");
		}else if(result == 2) {
			out.print("<div><p>The appointment is already rejected by the doctor so cant modify the appointment</p></div>");
		}else {
			out.print("<div><p>Internal error occured</p></div>");
		}
	}

}
