<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@page import="appointments.AppointmentsDAO" %>
    <%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment detail</title>
<style>
tr:nth-child(even){background-color: #9cf5ff}
     tr:nth-child(odd){background-color: #bdf8ff}
	 th {
  		background-color:#00203FFF ;
  		color: white;
	  }
      th, td {
          padding: 10px;
          text-align: left;
      }
      table {
          border-collapse: collapse;
  			width: 100%;
      }
</style>
</head>
<body>
<%
int id =Integer.valueOf(request.getParameter("apoint_id"));
AppointmentsDAO a1 = new AppointmentsDAO();
ArrayList<String> aList = a1.viewParticularAppointment(id);
request.setAttribute("appointment_id", id);
%>
<form action="adminHome.jsp">
<button onclick="submit">Back Home</button>
</form>
<h3>Appointment Details</h3>
<TABLE border='1'>
      <TR>
      <TH>Appointment ID</TH>
      <TH>Name</TH>
      <th>Details</th>
      <th>Appointment Date</th>
      <th>Appointment time</th>
      <th>Status</th>
      <th>Specialist</th>
      </TR>
      <tr>
        <%
      	if(aList.isEmpty()){
      		out.print("No appointments");
      	}
	   %>
      <%for(int j=1;j<=aList.size();j++) {%>
      <td><% out.print(aList.get(j-1)); %></td>
      <% if(j%7==0)%></tr>
      <% }%>
</table>
</body>
</html>