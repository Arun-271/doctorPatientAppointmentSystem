package accounts;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.JSONArray;
import org.json.JSONObject;

public class AccountDAO {
	String url = "jdbc:mysql://localhost:3306/appointment_database";
	String userName = "root";
	String password = "arun1234";
	String checkQuery = "select * from accounts where email = ?";

	public int createAccountDb(Accounts a) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, userName, password);
			String checkQuery = "select * from accounts where email = ?";
			PreparedStatement prt = con.prepareStatement(checkQuery);
			prt.setString(1, a.getEmail());
			ResultSet rs = prt.executeQuery();
			if (rs.next()) {
				System.out.println("There is a account already associated with this email ");
				return 1;
			}
			String querry = "insert into accounts(email,pass,first_name ,last_name,age,admin_access)values(?,?,?,?,?,?)";
			PreparedStatement st = con.prepareStatement(querry);
			st.setString(1, a.getEmail());
			st.setString(2, a.getPassword());
			st.setString(3, a.getFirstName());
			st.setString(4, a.getLastName());
			st.setInt(5, a.getAge());
			st.setString(6, a.getAdmin_access());
			st.executeUpdate();
			System.out.println("Account created ");
			return 2;
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public JSONArray viewAccountDetails(String logmail) {
		JSONArray jsonArray = new JSONArray();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, userName, password);
			String account = "select email,first_name,last_name,age from accounts where email = ?";
			PreparedStatement prt = con.prepareStatement(account);
			prt.setString(1, logmail);
			ResultSet resultSet = prt.executeQuery();
			while (resultSet.next()) {
				int columns = resultSet.getMetaData().getColumnCount();
				JSONObject obj = new JSONObject();
				for (int i = 0; i < columns; i++)
					obj.put(resultSet.getMetaData().getColumnLabel(i + 1).toLowerCase(), resultSet.getObject(i + 1));

				jsonArray.put(obj);
			}
			return jsonArray;
		} catch (Exception e) {
			System.out.println(e);
		}
		return jsonArray;
	}

	public int loginDB(String email, String pass) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, userName, password);
			String checkQuery = "select * from accounts where email = ? AND pass = ?";
			PreparedStatement prt = con.prepareStatement(checkQuery);
			prt.setString(1, email);
			prt.setString(2, pass);
			ResultSet rs = prt.executeQuery();
			if (rs.next()) {
				if (rs.getString("admin_access").equals("admin")) {
					return 1;
				} else {
					return 2;
				}
			} else {
				return 0;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int modifyAccountDetails(String email, String firstName, String lastName, int age) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, userName, password);
			String updateQuery = "update accounts set first_name = ? , last_name = ? , age = ?  where email = ?";
			PreparedStatement preparedStatement1 = con.prepareStatement(updateQuery);
			preparedStatement1.setString(1, firstName);
			preparedStatement1.setString(2, lastName);
			preparedStatement1.setInt(3, age);
			preparedStatement1.setString(4, email);
			preparedStatement1.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int getAccountId(String email) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, userName, password);
			String updateQuery = "select account_id from accounts where email = ?";
			PreparedStatement preparedStatement1 = con.prepareStatement(updateQuery);
			preparedStatement1.setString(1, email);
			ResultSet rs = preparedStatement1.executeQuery();
			rs.next();
			int result = rs.getInt(1);
			return result;
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
}
