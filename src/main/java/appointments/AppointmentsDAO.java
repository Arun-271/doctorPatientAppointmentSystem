package appointments;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Objects;
import org.json.JSONArray;
import org.json.JSONObject;

import mail.Mail;

public class AppointmentsDAO {
	String url = "jdbc:mysql://localhost:3306/appointment_database";
    String userName = "root";
    String password = "passwordGoesHere";
	String checkQuery = "select * from accounts where email = ?";
	public int createAppointmentDB(Appointments appointment) {
		String specialist = appointment.getSpecialList();
		int doctor_id = 0;
		if(specialist.equals("general")) {
			doctor_id = 1;
		}else if(specialist.equals("dermatologist")) {
			doctor_id = 3;
		}else if(specialist.equals("dentist")) {
			doctor_id = 2;
		}
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
			String accountIdQuery = "select account_id from accounts where email = ?";
            PreparedStatement prt = con.prepareStatement(accountIdQuery);
            prt.setString(1, appointment.getEmail());
            ResultSet rs = prt.executeQuery();
            rs.next();
            int account_id = rs.getInt(1);
            String addAppQuery = "insert into appointments(name,details,appointment_date , appointment_time , account_id,doctor_id) values (?,?,?,?,?,?)";
            PreparedStatement prt2 = con.prepareStatement(addAppQuery);
            prt2.setString(1, appointment.getName());
            prt2.setString(2, appointment.getDetails());
            prt2.setString(3, appointment.getDate());
            prt2.setString(4, appointment.getTime());
            prt2.setInt(5, account_id);
            prt2.setInt(6,doctor_id);
            // Checking for any approved appointment at that time.
            String checkQuery = "select status from appointments where appointment_date = ? AND appointment_time = ? and doctor_id = ?";
            PreparedStatement preparedStatement3 = con.prepareStatement(checkQuery);
            preparedStatement3.setString(1, appointment.getDate());
            preparedStatement3.setString(2, appointment.getTime());
            preparedStatement3.setInt(3, doctor_id);
            ResultSet res2 = preparedStatement3.executeQuery();
            while (res2.next()) {
                String _status = res2.getString("status");
                if (Objects.equals(_status, "Approved")) {
                	System.out.println("There is appointment at that time");
                    return 1; 
                }
            }
            prt2.executeUpdate();
            System.out.println("Appointment Created");
            return 2;
			
		}catch(Exception e) {
			System.out.println(e);
		}return 0;
	}
	public JSONArray viewAllAppointments() {
		JSONArray jsonArray = new JSONArray();
		try {
		Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, userName, password);
        String query = "select account_id ,appointment_id , name ,details,appointment_date , appointment_time , status , doctor_id from appointments";
        PreparedStatement preparedStatement = con.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next()){
        	int columns = resultSet.getMetaData().getColumnCount();
            JSONObject obj = new JSONObject();
            for (int i = 0; i < columns; i++)
                obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));

            jsonArray.put(obj);
        }
        return jsonArray;
        }catch(Exception e) {
        	System.out.println(e);
        }
		return jsonArray;
        }
	public ArrayList<String> viewParticularAppointment(int id){
		ArrayList<String> resultList = new ArrayList<String>();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
	        String query = "select appointment_id , name ,details,appointment_date , appointment_time , status, doctor_id from appointments where appointment_id = ?";
	        PreparedStatement preparedStatement = con.prepareStatement(query);
	        preparedStatement.setInt(1,id);
	        ResultSet resultSet = preparedStatement.executeQuery();
	        java.sql.ResultSetMetaData rsMd = resultSet.getMetaData();
	        int col = rsMd.getColumnCount();
	        int appointments = 0;
	        while(resultSet.next()){
	            appointments++;
	            for(int i=1;i<=col;i++) {
	            	resultList.add(resultSet.getString(i));
	            }
	        }
	        if(appointments == 0){
	            System.out.println("No appointments currently!");
	        }
	        }catch(Exception e) {
	        	System.out.println(e);
	        }
			return resultList;
	      }
	public int approveAppointment(int id,String status) {
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
	        if(status.equals("Approved")){
	            String getDateAndTime = "select appointment_date , appointment_time ,doctor_id from appointments where appointment_id = ?";
	            PreparedStatement preparedStatement1 = con.prepareStatement(getDateAndTime);
	            preparedStatement1.setInt(1,id);
	            ResultSet dateAndTime = preparedStatement1.executeQuery();
	            dateAndTime.next();
	            String date = dateAndTime.getString("appointment_date");
	            String time = dateAndTime.getString("appointment_time");
	            int docId = dateAndTime.getInt("doctor_id");
	            String getOtherApp = "select account_id from appointments where appointment_date = ? AND appointment_time = ? AND doctor_id = ? AND appointment_id != ? ";
	            PreparedStatement preparedStatement2 = con.prepareStatement(getOtherApp);
	            preparedStatement2.setString(1,date);
	            preparedStatement2.setString(2,time);
	            preparedStatement2.setInt(3,docId);
	            preparedStatement2.setInt(4,id);
	            ResultSet rejectedAppointMents  = preparedStatement2.executeQuery();
	            while (rejectedAppointMents.next()){
//	            	System.out.println(rejectedAppointMents.getString(1));
	                int rejectAppEmails  = rejectedAppointMents.getInt("account_id");
	                String getEmail = "select email from accounts where account_id = ?";
	                PreparedStatement preparedStatement4 = con.prepareStatement(getEmail);
	                preparedStatement4.setInt(1,rejectAppEmails);
	                ResultSet emails = preparedStatement4.executeQuery();
	                emails.next();
	                System.out.println(emails.getString("email"));
	                String rejectedEmail =  emails.getString("email");
	                String message = "Your appointment at " + date + " " + time + " is rejected by the doctor";
	                Mail.Message(rejectedEmail,message);
	            }
	            String rejectOtherAppointment = "update appointments set status = 'Rejected' where appointment_date = ? AND appointment_time = ?  and doctor_id = ? AND appointment_id != ? ";
	            PreparedStatement preparedStatement3 = con.prepareStatement(rejectOtherAppointment);
	            preparedStatement3.setString(1,date);
	            preparedStatement3.setString(2,time);
	            preparedStatement3.setInt(3,docId);
	            preparedStatement3.setInt(4,id);
	            System.out.println(date+ " timee : " + time + " doc " + docId + " id " + id );
	            preparedStatement3.executeUpdate();
	        }
	        String updateTheAppointment = "update appointments set status = ? where appointment_id = ? ";
	        PreparedStatement preparedStatement5 = con.prepareStatement(updateTheAppointment);
	        preparedStatement5.setString(1,status);
	        preparedStatement5.setInt(2,id);
	        preparedStatement5.executeUpdate();
	        String getAccountId = "select account_id from appointments where appointment_id = ?";
	        PreparedStatement preparedStatement6 = con.prepareStatement(getAccountId);
	        preparedStatement6.setInt(1,id);
	        ResultSet resultSet = preparedStatement6.executeQuery();
	        resultSet.next();
	        int account_id = resultSet.getInt(1);
	        String emailQuery = "select email from accounts where account_id = ?";
	        PreparedStatement preparedStatement7 = con.prepareStatement(emailQuery);
	        preparedStatement7.setInt(1,account_id);
	        ResultSet resultSet2 = preparedStatement7.executeQuery();
	        resultSet2.next();
	        String Approvedemail = resultSet2.getString("email");
	        String message = "Your appointment with  " +id + " has been " + status + " by the doctor";
	        Mail.Message(Approvedemail,message);
	        return 1;
	        
	    }catch(Exception e){
	            System.out.println(e);
	    }
		return 0;
	}
	public JSONArray viewPatientAppointments(String email){
		JSONArray jsonArray = new JSONArray();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
	        String accountIdQuery = "select account_id from accounts where email = ?";
	        PreparedStatement prt = con.prepareStatement(accountIdQuery);
	        prt.setString(1,email);
	        ResultSet rs = prt.executeQuery();
	        rs.next();
	        int account_id = rs.getInt(1);
	        String query = "select appointment_id , name ,details,appointment_date , appointment_time , status,doctor_id from appointments where account_id = ?";
	        PreparedStatement preparedStatement = con.prepareStatement(query);
	        preparedStatement.setInt(1,account_id);
	        ResultSet resultSet = preparedStatement.executeQuery();
	        while(resultSet.next()){
	        	int columns = resultSet.getMetaData().getColumnCount();
	            JSONObject obj = new JSONObject();
	            for (int i = 0; i < columns; i++)
	                obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));

	            jsonArray.put(obj);
	        }
	        }catch(Exception e) {
	        	System.out.println(e);
	        }return jsonArray;

	}
	public int modifyAppointment(int id, String date , String time,String endDate,String endTime) {
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
	        String checkQuerry = "select status from appointments where appointment_id = ?";
	        PreparedStatement checkStatement = con.prepareStatement(checkQuerry);
	        checkStatement.setInt(1, id);
	        ResultSet rs = checkStatement.executeQuery();
	        rs.next();
	        String status = rs.getString("status");
	        System.out.print(status);
	        if(status.equals("pending") || status.equals("Approved")) {
	        		String updateQuery  = "update appointments set appointment_date = ? , appointment_time = ? , end_date = ? , end_time = ? where appointment_id  = ?";
	    	        PreparedStatement preparedStatement1 = con.prepareStatement(updateQuery);
	    	        preparedStatement1.setString(1,date);
	    	        preparedStatement1.setString(2,time);
	    	        preparedStatement1.setString(3,endDate);
	    	        preparedStatement1.setString(4,endTime);
	    	        preparedStatement1.setInt(5,id);
	    	        preparedStatement1.executeUpdate();
	    	        System.out.println("Appointment updated");
	    	        return 1;
	        	}else if(status.equals("Rejected")){
	        		return 2;
	        	}else {
	        		return 0;
	        	}
	    }catch(Exception e){
	            System.out.println(e);
	    }
		return 0;
	    }
	public int deleteAppointment(int id,String email) {
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
	        Connection con = DriverManager.getConnection(url, userName, password);
	        String accountIdQuery = "select account_id from accounts where email = ?";
	        PreparedStatement prt = con.prepareStatement(accountIdQuery);
	        prt.setString(1,email);
	        ResultSet rs = prt.executeQuery();
	        rs.next();
	        int account_id = rs.getInt(1);
	        String deleteAppQuery = "delete from appointments where appointment_id = ? AND account_id =?";
	        PreparedStatement preparedStatement2 = con.prepareStatement(deleteAppQuery);
	        preparedStatement2.setInt(1,id);
	        preparedStatement2.setInt(2,account_id);
	        int result = preparedStatement2.executeUpdate();
	        if(result == 1){
	            System.out.println("Appointment Deleted Successfully");
	        }else{
	            System.out.println("Appointment Not Deleted / Not found");
	        }
	        return result;
	    }catch (Exception e){
	            System.out.println(e);
	        }
		return 0;
	}
	public JSONArray bookedSlots(int id){
        String url = "jdbc:mysql://localhost:3306/appointment_database";
        String userName = "root";
        String password = "arun1234";
        JSONArray jsonArray = new JSONArray();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, userName, password);
            String querry = "select appointment_time , appointment_date,status,account_id from appointments where doctor_id = ? ";
            PreparedStatement prt = con.prepareStatement(querry);
            prt.setInt(1, id);
            ResultSet resultSet = prt.executeQuery();
            while (resultSet.next()) {
                int columns = resultSet.getMetaData().getColumnCount();
                JSONObject obj = new JSONObject();
                for (int i = 0; i < columns; i++)
                    obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));

                jsonArray.put(obj);
            }
            return jsonArray;
        }catch (Exception e){
            System.out.println(e);
        }
        return jsonArray;
    }
	
}
