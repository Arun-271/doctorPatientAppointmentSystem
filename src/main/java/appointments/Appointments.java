package appointments;

public class Appointments {
	private String email;
	private String name;
	private String details;
	private String date;
	private String time;
	private String status;
	private String specialList;
	public Appointments(String email,String name,String details,String date,String time,String specialList){
		this.setEmail(email);
		this.setName(name);
		this.setDetails(details);
		this.setDate(date);
		this.setTime(time);
		this.setStatus("pending");
		this.setSpecialList(specialList);
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSpecialList() {
		return specialList;
	}
	public void setSpecialList(String specialList) {
		this.specialList = specialList;
	}
}
