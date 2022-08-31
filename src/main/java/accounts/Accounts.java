package accounts;

public class Accounts {
	private String email;
	private String password;
	private String firstName;
	private String lastName;
	private int age;
	private String admin_access;
	Accounts(String email,String password,String firstName,String lastName,int age){
		this.setEmail(email);
		this.setPassword(password);
		this.setFirstName(firstName);
		this.setLastName(lastName);
		this.setAge(age);
		this.setAdmin_access("non_admin");
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAdmin_access() {
		return admin_access;
	}
	public void setAdmin_access(String admin_access) {
		this.admin_access = admin_access;
	}
}
