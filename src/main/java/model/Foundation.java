/**
 * 
 */
package model;

/**
 * @author TRUONGVANTIEN
 *
 */
public class Foundation {
	private int id;
	private String name;
	private String description;
	private String email;
	private String status;
	
	public Foundation() {
		
	}

	public Foundation(String name, String description, String email, String status) {
		this(-1, name, description, email, status);
	}
	
	public Foundation(int id, String name, String description, String email, String status) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.email = email;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
}
