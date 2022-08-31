<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Appointment Calendar</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
</head>
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: antiquewhite;
}

.weekBtn {
	width: 75px;
	cursor: pointer;
	box-shadow: 0px 0px 2px gray;
	border: none;
	outline: none;
	padding: 5px;
	border-radius: 5px;
	color: white;
}

#header {
	padding: 10px;
	color: #d36c6c;
	font-size: 26px;
	font-family: sans-serif;
	display: flex;
	justify-content: space-between;
}

#header button {
	background-color: #92a1d1;
}

#container {
	width: 100%;
}

#weekdays {
	/* width: 100%;  */
	display: flex;
	color: #247BA0;
}

#weekdays div {
	width: 154px;
	padding: 9px;
	overflow: hidden;
}

#calendar {
	width: 1192px;
	display: flex;
	flex-wrap: wrap;
	overflow-y: auto;
	height: 623px;
}

.day {
	width: 150px;
	padding: 46px;
	height: 613px;
	cursor: pointer;
	box-sizing: border-box;
	background-color: white;
	margin: 5px;
	box-shadow: 0px 0px 3px #CBD4C2;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding-left: 80px;
	padding-right: 80px;
	padding-top: 10px;
	border-radius: 10px;
}

.hours {
	height: 100px;
	margin: 5px;
	width: 110px;
	background-color: #ede9e9;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 5px;
}

.hours-wrapper:hover {
	display: inline;
}

.hours-wrapper {
	width: 150px;
	padding: 46px;
	height: 613px;
	cursor: pointer;
	box-sizing: border-box;
	background-color: white;
	margin: 5px;
	box-shadow: 0px 0px 3px #CBD4C2;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding-left: 80px;
	padding-right: 80px;
	padding-top: 10px;
	border-radius: 10px;
}

.day {
	background-color: #bfebf2;
}

.day:hover {
	background-color: white;
}

.currentDay {
	background-color: #a2e8a7;
}

.event {
	font-size: 10px;
	padding: 3px;
	background-color: #58bae4;
	color: white;
	border-radius: 5px;
	max-height: 55px;
	overflow: hidden;
}

.padding {
	cursor: default !important;
	background-color: antiquewhite !important;
	box-shadow: none !important;
}

#newEventModal, #deleteEventModal {
	display: none;
	z-index: 20;
	padding: 25px;
	background-color: #e8f4fa;
	box-shadow: 0px 0px 3px black;
	border-radius: 5px;
	width: 350px;
	top: 100px;
	left: calc(50% - 175px);
	position: absolute;
	font-family: sans-serif;
}

#eventTitleInput {
	padding: 10px;
	width: 100%;
	box-sizing: border-box;
	margin-bottom: 25px;
	border-radius: 3px;
	outline: none;
	border: none;
	box-shadow: 0px 0px 3px gray;
}

#eventTitleInput.error {
	border: 2px solid red;
}

#cancelButton, #deleteButton {
	background-color: #d36c6c;
}

#saveButton, #closeButton {
	background-color: #92a1d1;
}

#eventText {
	font-size: 14px;
}

#modalBackDrop {
	display: none;
	top: 0px;
	left: 0px;
	z-index: 10;
	width: 100vw;
	height: 100vh;
	position: absolute;
	background-color: rgba(0, 0, 0, 0.8);
}

.form_button {
	width: 150px;
	margin: 2px;
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

.modalContainer {
	font-size: larger;
	height: 250;
	width: 250px;
	background-color: rgb(17, 179, 207);
}

.ip {
	margin: 10px;
}

#spec {
	display: none;
}

#selected {
	background-color: #f98388;
}

.approvedForYou {
	background-color: #22f049 !important;
}

#pending {
	background-color: yellow;
}

.pgBtns {
	display: flex;
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	padding-top: 100px;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgb(0, 0, 0);
	background-color: rgba(0, 0, 0, 0.4);
}

.modal-content {
	background-color: #fefefe;
	margin: auto;
	padding: 20px;
	border: 1px solid #888;
	width: 20%;
	text-align: center;
	border-radius: 30px;
	background-color: #ccccff
}

.modalBtns {
	background-color: #70b57d;
	height: 30px;
	width: 70px;
	border-radius: 10px;
	border: none;
	margin: 5px;
}

.rejectedForYou {
	background-color: red !important;
}

#responseModal {
	color: black;
	font-family: 'Poppins', sans-serif;
	font-size: medium;
}

#outter {
	border: 2px solid;
	width: 1207px;
	border-radius: 20px;
}
</style>
<body>
	<%
	HttpSession sessions = request.getSession();
	String specialist = (String) session.getAttribute("Sepcialist");
	out.print("<h3 id=\"spec\">Selected Sepecialist " + specialist.toUpperCase() + "</h3>");
	String email = (String) session.getAttribute("email");
	%>
	<div id="container">
		<div id="header">
			<!-- These are some dynamic stuffs loaded and displayed by the java script -->
			<div id="monthDisplay"></div>
			<div>
				<button class="weekBtn" id="backButton">Back</button>
				<button class="weekBtn" id="nextButton">Next</button>
			</div>
		</div>

		<div id="outter">
			<div id="weekdays">
				<!-- This will not change so this will be hard coded -->
				<div>Sunday</div>
				<div>Monday</div>
				<div>Tuesday</div>
				<div>Wednesday</div>
				<div>Thursday</div>
				<div>Friday</div>
				<div>Saturday</div>
			</div>
			<div id="calendar"></div>
		</div>
	</div>
	<div class="pgBtns">
		<form action="patientHome.jsp" method="get">
			<button onclick="submit" class="form_button">Back Home</button>
		</form>
		<form action="selectSpecialist.jsp" method="post">
			<button onclick="submit" class="form_button">Previous page</button>
		</form>
	</div>
	<div id="myModal" class="modal">
		<div class="modal-content">
			<h4 id='modalHeading'>Enter the details</h4>
			<label class="modalLab" for="fname">Name : </label> <input id="inp1"
				type="text" class='modalIp' required="required"><br> <br>
			<label class="modalLab" for="fname">Description : </label> <input
				id="inp2" type="text" class='modalIp' required="required"><br>
			<br>
			<div id='error'></div>
			<input type="submit" value="Submit" id="sub" class='modalBtns'>
			<input type="submit" value="Close" id="modalClose" class='modalBtns'>
		</div>
	</div>
	<div id="myModal2" class="modal">
		<div class="modal-content">
			<h3 id="responseModal"></h3>
			<input type="submit" value="Close" id="modalClose2" class='modalBtns'>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="script.js"></script>
</body>
</html>