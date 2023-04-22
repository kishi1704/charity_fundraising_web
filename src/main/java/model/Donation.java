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
	private User user;
	private Fund fund;
	
	public Donation() {
		
	}

	public Donation(int id, int donationAmount, String donationMessage, Date donationDate, User user,
			Fund fund) {
		this.id = id;
		this.donationAmount = donationAmount;
		this.donationMessage = donationMessage;
		this.donationDate = donationDate;
		this.user = user;
		this.fund = fund;
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

	

	public Date getDonationDate() {
		return donationDate;
	}

	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Fund getFund() {
		return fund;
	}

	public void setFund(Fund fund) {
		this.fund = fund;
	}

}
