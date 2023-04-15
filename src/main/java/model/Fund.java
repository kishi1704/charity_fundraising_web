/**
 * 
 */
package model;

import java.sql.Date;

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
	private int categoryId;
	private String categoryName;
	private int foundationId;
	private String foundationName;
	private String status;
	
	public Fund() {
		
	}

	public Fund(String name, String description, String content, String image_url, int expectedAmount,
			Date createdDate, Date endDate, int categoryId, int foundationId, String status) {
		this(-1, name, description, content, image_url, expectedAmount, createdDate, endDate, categoryId, "", foundationId, "", status);
	}

	public Fund(int id, String name, String description, String content, String image_url, int expectedAmount,
			Date createdDate, Date endDate, int categoryId, int foundationId, String status) {
		this(id, name, description, content, image_url, expectedAmount, createdDate, endDate, categoryId, "", foundationId, "", status);
	}



	public Fund(int id, String name, String description, String content, String image_url, int expectedAmount,
			Date createdDate, Date endDate, int categoryId, String categoryName, int foundationId,
			String foundationName, String status) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.content = content;
		this.image_url = image_url;
		this.expectedAmount = expectedAmount;
		this.createdDate = createdDate;
		this.endDate = endDate;
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.foundationId = foundationId;
		this.foundationName = foundationName;
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

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getFoundationId() {
		return foundationId;
	}

	public void setFoundationId(int foundationId) {
		this.foundationId = foundationId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}



	public String getCategoryName() {
		return categoryName;
	}



	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}



	public String getFoundationName() {
		return foundationName;
	}



	public void setFoundationName(String foundationName) {
		this.foundationName = foundationName;
	}
	
	
	
}
