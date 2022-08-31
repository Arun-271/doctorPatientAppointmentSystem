/*
let nav = 0; // To keep track of the month we want to displays
let accountId;
// let clicked = null; --> useful when creating the each individual days.
let events = localStorage.getItem('events') ? JSON.parse(localStorage.getItem('events')) : [];
const calendar = document.getElementById('calendar');
const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
function load() {
	
	const dt = new Date(); // It returns the date as a object which we will be using to get
  // Date month and the year.
  if (nav !== 0) {
    dt.setMonth(new Date().getMonth() + nav);
  }

  const day = dt.getDate();
  var month = dt.getMonth();
  const year = dt.getFullYear();

  // prints the day month and the year in the console use it to verify.
  // Month will be like array 0 to 11 which represents jan - dec.
  
  const firstDayOfMonth = new Date(year, month, 1);
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  const dateString = firstDayOfMonth.toLocaleDateString('en-us', {
    weekday: 'long',
    year: 'numeric',
    month: 'numeric',
    day: 'numeric',
  });
  const paddingDays = weekdays.indexOf(dateString.split(', ')[0]); // Getting empty squares.

  document.getElementById('monthDisplay').innerText = 
    `${dt.toLocaleDateString('en-us', { month: 'long' })} ${year}`;
  calendar.innerHTML = '';
  
  for(let i = 1; i <= paddingDays + daysInMonth; i++) {
    const daySquare = document.createElement('div');
    daySquare.classList.add('day');
   let dayString;
    if(month<9){
      dayString= `${year}-0${month + 1}-${i - paddingDays}`;
    }else{
        dayString = `${year}-${month + 1}-${i - paddingDays}`;
    }
    if (i > paddingDays) {
      daySquare.innerText = i - paddingDays;
      daySquare.setAttribute('id',dayString);
      if (i - paddingDays === day && nav === 0) {
		daySquare.classList.add('currentDay');
        daySquare.id = dayString;
      }
      
      for(let i = 8 ; i <=18 ; i++){
        const hourSquare = document.createElement('div');
        hourSquare.classList.add('hours');
        hourSquare.classList.add(i);
        hourSquare.innerText = i+":00" + " - "+ (i+1)+":00";  
        daySquare.appendChild(hourSquare);

        hourSquare.addEventListener('click',()=>createModal(dayString,i));
    }

    } else {
      daySquare.classList.add('padding');
    }
    calendar.appendChild(daySquare);    
  }
  let dummy=document.getElementsByClassName('currentDay');
  if(dummy[0]!=null){
	dummy[0].scrollIntoView();
	
	}else{
		dummy=document.getElementById(year+'-0'+(month+1)+'-'+'1');
		dummy.scrollIntoView();
	}
}
function createModal(day ,hourSquare){
		check = document.getElementById(day).getElementsByClassName(hourSquare);
		ls2 = check[0].getAttribute("class");
		ls = check[0].getAttribute("id");
		ls3 = ls2.split(' ');
		//console.log(ls3[2]);
		if(ls3[2] == 'bookedbyyou'){
			alert('You booked appointment already at this time');	
		}else if(ls3[2] == "approvedForYou"){
			alert('Your appointment is accepeted at this time');
			var name = prompt("Enter the name for appointment");
          	var desc = prompt("How do you feel");
          	console.log(name + " " + desc)
         	var hour = hourSquare +":00:00";
          	var days = day;  
         	// openNewPage(days,hour,name,desc);
         	// Create a page to edit the appointment.
		}
		else{
		if(!ls){
          var name = prompt("Enter the name for appointment");
          var desc = prompt("How do you feel");
          console.log(name + " " + desc)
          var hour = hourSquare +":00:00";
          var days = day;  
         openNewPage(days,hour,name,desc);
        }else if(ls =="pending"){	
			alert("There is appointment reg but not yet approved you will be in waiting list");
			var name = prompt("Enter the name for appointment");
          	var desc = prompt("How do you feel");
          	
          	console.log(name + " " + desc)
          	var hour = hourSquare +":00:00";
          	var days = day;  
         	openNewPage(days,hour,name,desc);
		}
        else{
			alert("Already booked");
		}
		}

}
function openNewPage(dateSelected, hourSlected,name,desc){
	console.log(dateSelected);
	spec = document.getElementById("spec").innerHTML.split(' ')
	spec = spec[spec.length-1].toLowerCase();
    $.ajax({
        url:'/doctorPatientV3/PatientCreateAppointment?date='+dateSelected.toString()+"&spec="+spec+"&hour="+hourSlected+"&name="+name.toString()+"&desc="+desc.toString(),
        type:'POST',
        success: function(data){
             window.location.replace(data);
        }
    })
}

function initButtons() {
  document.getElementById('nextButton').addEventListener('click', () => {
    nav++;
    load();
    loadBookedSlots();
  });

  document.getElementById('backButton').addEventListener('click', () => {
    nav--;
    load();
    loadBookedSlots();
  });
  
}
var jsonResponse = ``;
function loadBookedSlots(){
	spec = document.getElementById("spec").innerHTML.split(' ')
	spec = spec[spec.length-1].toLowerCase();
	$.ajax({
        url:'/doctorPatientV3/BookedSlotsSer?id='+spec,
        type:'GET',
        success: function(data){
			 data = JSON.parse(data);
             for(i = 0;i <data.length;i++){
				key = parseInt(data[i].appointment_time.split(":")[0]);
				let status = data[i].status;
				let acc = data[i].account_id;
				if(status =="pending"){
					const [pending] = document.getElementById(data[i].appointment_date).getElementsByClassName(key.toString());
					pending.setAttribute('id','pending');
					if(acc == accountId){
						pending.classList.add('bookedbyyou');
					}
				}else if(status == 'Approved'){
					const [selected] = document.getElementById(data[i].appointment_date).getElementsByClassName(key.toString());
					selected.setAttribute('id','selected');
					console.log(selected);
					if(acc == accountId){
						selected.classList.add('approvedForYou');
					}
				}
			 }
        }
    })
}

function getAccountId(){
	$.ajax({
        url:'/doctorPatientV3/GetAccountId?',
        type:'GET',
        success: function(data){
             accountId = data;
        }
    })
}
function blockPreviousDays(){
	let d = document.getElementsByClassName('currentDay');
	let currentDate = d[0].getAttribute('id');
	console.log(currentDate);
}

getAccountId();
initButtons();
load();
loadBookedSlots();
blockPreviousDays();

*/

let nav = 0; // To keep track of the month we want to displays
let accountId;
// let clicked = null; --> useful when creating the each individual days.
let events = localStorage.getItem('events') ? JSON.parse(localStorage.getItem('events')) : [];
const calendar = document.getElementById('calendar');
const weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
function load() {
	
	const dt = new Date(); // It returns the date as a object which we will be using to get
  // Date month and the year.
  if (nav !== 0) {
    dt.setMonth(new Date().getMonth() + nav);
  }

  const day = dt.getDate();
  var month = dt.getMonth();
  const year = dt.getFullYear();

  // prints the day month and the year in the console use it to verify.
  // Month will be like array 0 to 11 which represents jan - dec.
  
  const firstDayOfMonth = new Date(year, month, 1);
  const daysInMonth = new Date(year, month + 1, 0).getDate();

  const dateString = firstDayOfMonth.toLocaleDateString('en-us', {
    weekday: 'long',
    year: 'numeric',
    month: 'numeric',
    day: 'numeric',
  });
  const paddingDays = weekdays.indexOf(dateString.split(', ')[0]); // Getting empty squares.

  document.getElementById('monthDisplay').innerText = 
    `${dt.toLocaleDateString('en-us', { month: 'long' })} ${year}`;
  calendar.innerHTML = '';
  
  for(let i = 1; i <= paddingDays + daysInMonth; i++) {
    const daySquare = document.createElement('div');
    daySquare.classList.add('day');
   let dayString;
    if(month<9){
      dayString= `${year}-0${month + 1}-${i - paddingDays}`;
    }else{
        dayString = `${year}-${month + 1}-${i - paddingDays}`;
    }
    if (i > paddingDays) {
      daySquare.innerText = i - paddingDays;
      daySquare.setAttribute('id',dayString);
      if (i - paddingDays === day && nav === 0) {
		daySquare.classList.add('currentDay');
        daySquare.id = dayString;
      }
      
      for(let i = 8 ; i <=18 ; i++){
        const hourSquare = document.createElement('div');
        hourSquare.classList.add('hours');
        hourSquare.classList.add(i);
        hourSquare.innerText = i+":00" + " - "+ (i+1)+":00";  
        daySquare.appendChild(hourSquare);

        hourSquare.addEventListener('click',()=>createApp(dayString,i));
    }

    } else {
      daySquare.classList.add('padding');
    }
    calendar.appendChild(daySquare);    
  }
  let dummy=document.getElementsByClassName('currentDay');
  if(dummy[0]!=null){
	dummy[0].scrollIntoView();
	
	}else{
		dummy=document.getElementById(year+'-0'+(month+1)+'-'+'1');
		dummy.scrollIntoView();
	}
}
var alertModal = document.getElementById("myModal2");

function createApp(day ,hourSquare){
		check = document.getElementById(day).getElementsByClassName(hourSquare);
		ls2 = check[0].getAttribute("class");
		ls = check[0].getAttribute("id");
		ls3 = ls2.split(' ');
		//console.log(ls3[2]);
		if(ls3[2] == 'bookedbyyou'){
			alertModal.style.display = "block";
			var message = document.getElementById("responseModal");
			message.innerText = "You booked appointment already at this time";
			//  alert('You booked appointment already at this time');	
		}else if(ls3[2] == "approvedForYou"){
			alertModal.style.display = "block";
			var message = document.getElementById("responseModal");
			message.innerText = "Your appointment is accepeted at this time";
			// alert('Your appointment is accepeted at this time');
		}else if(ls3[2] == "rejectedForYou"){
			alertModal.style.display = "block";
			var message = document.getElementById("responseModal");
			message.innerText = "Your Appointment rejected";
			// alert("Your appointment rejected");
		}
		else{
		if(!ls){
          var hour = hourSquare +":00:00";
          var days = day; 
          openMo(days,hour); 
        }else if(ls =="pending"){	
			alertModal.style.display = "block";
			var message = document.getElementById("responseModal");
			message.innerText = "There is appointment at that time you will be in waiting list";
          	var hour = hourSquare +":00:00";
          	var days = day;  
         	openMo(days,hour);
		}
        else{
			alertModal.style.display = "block";
			var message = document.getElementById("responseModal");
			message.innerText = "Already booked by others";
		}
		}

}

var modal = document.getElementById("myModal");

modalClose.onclick = function() {
      modal.style.display = "none";
      inp1.value = '';
      inp2.value='';
      const err = document.getElementById('error');
	err.innerHTML="";
      console.log("modal is closed");
}
modalClose2.onclick = function() {
      alertModal.style.display = "none";
      var message = document.getElementById("responseModal");
		message.innerText = "";
      console.log("modal is closed");
}


function closeModal(){
	modal.style.display = "none";
      inp1.value = '';
      inp2.value='';
      const err = document.getElementById('error');
	err.innerHTML="";
      console.log("modal is closed");
}

function openMo(days,hour){
	modal.style.display = "block";
	sub.onclick = function(){
		let name = inp1.value;
       	let desc = inp2.value;
       	if(name=="" || desc ==""){
			const err = document.getElementById('error');
			err.innerHTML=`<p style='color:red'>Enter the required field</p>`;
		}else{
       	openNewPage(days,hour,name,desc);
       	closeModal();
       	}
	}
	
}
function openNewPage(dateSelected, hourSlected,name,desc){
	console.log(dateSelected);
	spec = document.getElementById("spec").innerHTML.split(' ')
	spec = spec[spec.length-1].toLowerCase();
    $.ajax({
        url:'/doctorPatientV3/PatientCreateAppointment?date='+dateSelected.toString()+"&spec="+spec+"&hour="+hourSlected+"&name="+name.toString()+"&desc="+desc.toString(),
        type:'POST',
        success: function(data){
			console.log(data);
             if(data==2){	
				alert("Appointment created");
				loadBookedSlots();
			}
        }
    })
}

function initButtons() {
  document.getElementById('nextButton').addEventListener('click', () => {
    nav++;
    load();
    loadBookedSlots();
  });

  document.getElementById('backButton').addEventListener('click', () => {
    nav--;
    load();
    loadBookedSlots();
  });
  
}
var jsonResponse = ``;
function loadBookedSlots(){
	spec = document.getElementById("spec").innerHTML.split(' ')
	spec = spec[spec.length-1].toLowerCase();
	$.ajax({
        url:'/doctorPatientV3/BookedSlotsSer?id='+spec,
        type:'GET',
        success: function(data){
			 data = JSON.parse(data);
             for(i = 0;i <data.length;i++){
				key = parseInt(data[i].appointment_time.split(":")[0]);
				let status = data[i].status;
				let acc = data[i].account_id;
				if(status =="pending"){
					const [pending] = document.getElementById(data[i].appointment_date).getElementsByClassName(key.toString());
					pending.setAttribute('id','pending');
					if(acc == accountId){
						pending.classList.add('bookedbyyou');
					}
				}else if(status == 'Approved'){
					const [selected] = document.getElementById(data[i].appointment_date).getElementsByClassName(key.toString());
					selected.setAttribute('id','selected');
					console.log(selected);
					if(acc == accountId){
						selected.classList.add('approvedForYou');
					}
				}else if(status == 'Rejected'){
					const [selected] = document.getElementById(data[i].appointment_date).getElementsByClassName(key.toString());
					if(acc == accountId){
						selected.classList.add('rejectedForYou');
					}
				}
			 }
        }
    })
};

function getAccountId(){
	$.ajax({
        url:'/doctorPatientV3/GetAccountId?',
        type:'GET',
        success: function(data){
             accountId = data;
        }
    })
}
function blockPreviousDays(){
	let d = document.getElementsByClassName('currentDay');
	let currentDate = d[0].getAttribute('id');
	console.log(currentDate);
}

getAccountId();
initButtons();
load();
loadBookedSlots();
blockPreviousDays();





