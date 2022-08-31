<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="appointments.AppointmentsDAO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Appointments</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nunito&display=swap" rel="stylesheet">
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}

tr {
	background-color: #ffc4c4;
}

th {
	background-color: #0c1212;
	color: white;
}

th, td {
	padding: 10px;
	text-align: left;
}

table {
	border-collapse: collapse;
	width: 100%;
	font-family: 'Nunito', sans-serif;
}
.form_button {
	width: 120px;
	margin: 5px;
	height: 40px;
	border-radius: 8px;
	border: 1px solid;
	color: black !important;
}

.form_button:hover {
	color: black;
	cursor: pointer;
	background: #c4f2c4;
	transition: 0.4s;
	transform: scale(1.1);
}
</style>
</head>
<body>
	<h3>All Appointments</h3>
	<div>
		<form action="patientHome.jsp" method="get">
			<button onclick="submit" class="form_button">Back Home</button>
		</form>
	</div>
	<div id="container"></div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	function load(){
		$.ajax({
			url : '/doctorPatientV3/ViewPatAppointments?',
			type : 'GET',
			success : function(data) {
				var response = JSON.parse(data);
				var Approved = "Approved";
				var Rejected = "Rejected";
				var table = `
				<table border='1'>
					<tr>
						<th>Appointment ID</th>
						<th>Name</th>
						<th>Details</th>
						<th>Appointment Date</th>
						<th>Appointment time</th>
						<th>Status</th>
						<th>Specialist</th>
					</tr>`;
				for(i=0;i<response.length;i++){
					table = table + "<tr><td>"+ response[i].appointment_id +"</td>";
					table = table + "<td>"+ response[i].name +"</td>";
					table = table + "<td>"+ response[i].details +"</td>";
					table = table + "<td>"+ response[i].appointment_date +"</td>";
					table = table + "<td>"+ response[i].appointment_time +"</td>";
					table = table + "<td>"+ response[i].status +"</td>";

					if(response[i].doctor_id == 1){
						table = table + "<td>General </td>";
					}
					else if(response[i].doctor_id == 2){
						table = table + "<td> Dentist </td>";
					}
					else if(response[i].doctor_id == 3){
						table = table + "<td> Dermatalogist </td>";
					}
				}
				document.getElementById("container").innerHTML = table;
			}
		})
	}
	load();
	</script>
</body>
</html>