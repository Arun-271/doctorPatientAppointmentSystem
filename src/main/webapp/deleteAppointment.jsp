<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Appointment</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	text-align: center;
}

h3 {
	text-align: center;
	font-family: 'Poppins', sans-serif;
	font-weight: 300;
	font-size: 25px;
	text-decoration-line: underline;
}

button {
	width: 68px;
	margin: 15px;
	height: 33px;
	border-radius: 8px;
	border: 1px solid;
}

div {
	margin: 10px;
}

button:hover {
	color: black;
	cursor: pointer;
	background: #fd8383;
	transition: 0.4s;
	transform: scale(1.1);
	color: black;
}
</style>
</head>
<body>
	<div>
		<h3>Enter the appointment id to be deleted.</h3>
		<form action="DeleteAppointment" method="post">
			Enter the appointment id : <input type="text" name="id"><br>
			<button onclick="submit">Submit</button>
		</form>
	</div>
	<div id="container">
		</div>
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