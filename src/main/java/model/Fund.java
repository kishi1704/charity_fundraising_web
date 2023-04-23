/**
 * 
 */
package model;

import java.sql.Date;

import dao.DonationDAO;

/**
 * @author TRUONGVANTIEN
 *
 */
public class Fund {
	private int id;
	private String name;
	private String description;
	private String content;
	private String image_url;
	private int expectedAmount;
	private Date createdDate;
	private Date endDate;
	private Category category;
	private Foundation foundation;
	private String status;
	
	public Fund() {
		
	}
	
	public Fund(int id, String name) {
		this(id, name, null,  null, null, -1,  null,  null,  null,  null, null);
	}

	public Fund(int id, String name, String image_url) {
		this(id, name, null,  null, image_url, -1,  null,  null,  null,  null, null);
	}

	public Fund(String name, String description, String content, String image_url, int expectedAmount,
			Date createdDate, Date endDate,  Category category, Foundation foundation, String status) {
		this(-1, name, description, content, image_url, expectedAmount, createdDate, endDate, category, foundation, status);
	}

	public Fund(int id, String name, String description, String content, String image_url, int expectedAmount,
			Date createdDate, Date endDate, Category category, Foundation foundation, String status) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.content = content;
		this.image_url = image_url;
		this.expectedAmount = expectedAmount;
		this.createdDate = createdDate;
		this.endDate = endDate;
		this.category = category;
		this.foundation = foundation;
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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage_url() {
		return image_url;
	}

	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}

	public int getExpectedAmount() {
		return expectedAmount;
	}

	public void setExpectedAmount(int expectedAmount) {
		this.expectedAmount = expectedAmount;
	}

	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	

	public Category getCategory() {
		return category;
	}


	public void setCategory(Category category) {
		this.category = category;
	}


	public Foundation getFoundation() {
		return foundation;
	}


	public void setFoundation(Foundation foundation) {
		this.foundation = foundation;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public int getTotalDonation() {
		return new DonationDAO().getTotalDonationForFund(id);
	}

}
