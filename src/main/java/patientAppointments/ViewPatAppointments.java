package patientAppointments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import appointments.AppointmentsDAO;

@WebServlet("/ViewPatAppointments")
public class ViewPatAppointments extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String email = (String)session.getAttribute("email");
		AppointmentsDAO aObj = new AppointmentsDAO();
		JSONArray res = aObj.viewPatientAppointments(email);
		out.print(res);
	}


}
