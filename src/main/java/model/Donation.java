/**
 * 
 */
package model;

import java.sql.Date;

/**
 * @author TRUONGVANTIEN
 *
 */
public class Donation {
	private int id;
	private int donationAmount;
	private String donationMessage;
	private Date donationDate;
	private int userId;
	private String username;
	private int fundId;
	private String fundname;
	
	public Donation() {
		
	}

	
	

	public Donation(int id, int donationAmount, String donationMessage, Date donationDate, int userId, int fundId) {
		this(id, donationAmount, donationMessage, donationDate, userId, null, fundId, null);
	}




	public Donation(int id, int donationAmount, String donationMessage, Date donationDate, int userId, String username,
			int fundId, String fundname) {
		this.id = id;
		this.donationAmount = donationAmount;
		this.donationMessage = donationMessage;
		this.donationDate = donationDate;
		this.userId = userId;
		this.username = username;
		this.fundId = fundId;
		this.fundname = fundname;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getDonationAmount() {
		return donationAmount;
	}

	public void setDonationAmount(int donationAmount) {
		this.donationAmount = donationAmount;
	}

	public String getDonationMessage() {
		return donationMessage;
	}

	public void setDonationMessage(String donationMessage) {
		this.donationMessage = donationMessage;
	}

	public int getFundId() {
		return fundId;
	}

	public void setFundId(int fundId) {
		this.fundId = fundId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public Date getDonationDate() {
		return donationDate;
	}

	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}




	public String getUsername() {
		return username;
	}




	public void setUsername(String username) {
		this.username = username;
	}




	public String getFundname() {
		return fundname;
	}




	public void setFundname(String fundname) {
		this.fundname = fundname;
	}
	
	
	
}
