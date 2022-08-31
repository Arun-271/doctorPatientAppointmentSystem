<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="appointments.AppointmentsDAO"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&display=swap"
	rel="stylesheet">
<meta charset="UTF-8">
<title>All appointments</title>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}

tr:nth-child(even) {
	background-color: #9cf5ff
}

tr:nth-child(odd) {
	background-color: #bdf8ff
}

th {
	background-color: #00203FFF;
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
.ring
{
  position:absolute;
  top:50%;
  left:50%;
  transform:translate(-50%,-50%);
  width:150px;
  height:150px;
  background:transparent;
  border:3px solid #020202;
  border-radius:50%;
  text-align:center;
  line-height:150px;
  font-family:sans-serif;
  font-size:20px;
  color:#000000;
  letter-spacing:4px;
  text-transform:uppercase;
  text-shadow:0 0 10px #000000;
  box-shadow:0 0 20px rgba(0,0,0,.5);
}
.ring:before
{
  content:'';
  position:absolute;
  top:-3px;
  left:-3px;
  width:100%;
  height:100%;
  border:3px solid transparent;
  border-top:3px solid #000000;
  border-right:3px solid #050505;
  border-radius:50%;
  animation:animateC 2s linear infinite;
}
span
{
  display:block;
  position:absolute;
  top:calc(50% - 2px);
  left:50%;
  width:50%;
  height:4px;
  background:transparent;
  transform-origin:left;
  animation:animate 2s linear infinite;
}
span:before
{
  content:'';
  position:absolute;
  width:16px;
  height:16px;
  border-radius:50%;
  background:#0c0c0c;
  top:-6px;
  right:-8px;
  box-shadow:0 0 20px #000000;
}
.ring{
    display: none;
}
.tenor-gif-embed{
    display: none;
}
@keyframes animateC
{
  0%
  {
    transform:rotate(0deg);
  }
  100%
  {
    transform:rotate(360deg);
  }
}
@keyframes animate
{
  0%
  {
    transform:rotate(45deg);
  }
  100%
  {
    transform:rotate(405deg);
  }
}
.backHome {
	width: 150px;
	margin: 2px;
	height: 33px;
	border-radius: 8px;
	border: 1px solid;
}

.backHome:hover {
	color: black;
	cursor: pointer;
	background: #c4f2c4;
	transition: 0.4s;
	transform: scale(1.1);
}
</style>
</head>
<body>
	<form action="adminHome.jsp">
		<button onclick="submit" class="backHome">Back Home</button>
	</form>
	<h3>All Appointments</h3>
	<div id="container">
		</div>
	<div class="ring" id="ring">Loading
  <span></span>
</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	function load(){
		$.ajax({
			url : '/doctorPatientV3/ViewAllAppointments?',
			type : 'GET',
			success : function(data) {
				var response = JSON.parse(data);
				var Approved = "Approved";
				var Rejected = "Rejected";
				var table = `
				<table border='1'>
					<tr>
						<th>Account Id</th>
						<th>Appointment ID</th>
						<th>Name</th>
						<th>Details</th>
						<th>Appointment Date</th>
						<th>Appointment time</th>
						<th>Status</th>
						<th>Specialist</th>
						<th>Approve</th>
						<th>Reject</th>
					</tr>`;
				for(i=0;i<response.length;i++){
					table = table + "<tr><td>"+ response[i].account_id +"</td>";
					table = table + "<td>"+ response[i].appointment_id +"</td>";
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
					table = table + '<td><button onClick="btnClicked(\'' + response[i].appointment_id + '\',\'' + Approved + '\',\'' + response[i].status + '\')">Approve</button></td>';
					table = table + '<td><button onClick="btnClicked(\'' + response[i].appointment_id + '\',\'' + Rejected + '\',\'' + response[i].status  + '\')">Reject</button></td>';
				}
				document.getElementById("container").innerHTML = table;
			}
		})
	}
	function btnClicked(id,status,currentStatus){
		if(currentStatus != 'pending'){
			alert('The appointment status already changed');
		}else{
		$('.ring').show();
		console.log(status,id);
		$.ajax({
			url: 'ApproveAppointment?status='+ status +'&id='+ id,
			type:'GET',
			success : function(data){
				if(data ==1 ){
					$('.ring').hide();
					load();
					alert('Mail sent and appointment is updated');
				}else{
					$('.ring').show();
					load();
					alert('Error occured');
				}
			}
		}) 
		}
	}
	load();
	</script>
	
</body>
</html>