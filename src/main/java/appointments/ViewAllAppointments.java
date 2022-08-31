package appointments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
/**
 * Servlet implementation class ViewAllAppointments
 */
@WebServlet("/ViewAllAppointments")
public class ViewAllAppointments extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		AppointmentsDAO aObj = new AppointmentsDAO();
		JSONArray res = aObj.viewAllAppointments();
		out.print(res);
	}

}
