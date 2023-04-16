/**
 * 
 */
package model;

/**
 * @author TRUONGVANTIEN
 *
 */
public class User {
	private int id;
	private String username;
	private String password;
	private int role;
	private String fullName;
	private String email;
	private String address;
	private String phoneNumber;
	private String status;
	
	public User() {
		
	}
	
	

	public User(int id, String username, int role, String fullName, String email, String address, String phoneNumber,
			String status) {
		this(id, username, null, role, fullName, email, address, phoneNumber, status);
	}
	

	public User(String username, String password, int role, String fullName, String email, String address, String phoneNumber,
			String status) {
		this(-1, username, password, role, fullName, email, address, phoneNumber, status);
	}
	
	public User(String username, int role, String fullName, String email, String address, String phoneNumber,
			String status) {
		this(-1, username, null, role, fullName, email, address, phoneNumber, status);
	}
	
	public User(String username, String password, String email) {
		this(-1, username, password, -1, null, email, null, null, null);
	}

	public User(int id, String username, String password, int role, String fullName, String email, String address,
			String phoneNumber, String status) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.role = role;
		this.fullName = fullName;
		this.email = email;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
