/**
 * 
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import controller.admin.DonationController;
import model.Donation;
import model.Fund;
import model.User;

/**
 * @author TRUONGVANTIEN
 *
 */
public class DonationDAO implements BaseDAO<Donation> {

	// return number of all donation
	public int countD() throws Exception {
		return countD(-1, "", "");
	}

	// return number of donation by id, username, fundname
	public int countD(int id, String username, String fundname) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// count donation query
			if ((id == -1) && (username.equals("")) && (fundname.equals(""))) {

				// count all
				sql = "select count(*) as count from donationExtend;";
				stmt = conn.prepareStatement(sql);
			} else if (id == -1) {

				// count username, fundname
				sql = "select count(*) as count from donationExtend where username like ? and fund_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + username + "%");
				stmt.setString(2, "%" + fundname + "%");
			} else {

				// count id, username, fundname
				sql = "select count(*) as count from donationExtend where donation_id = ? and username like ? and fund_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + username + "%");
				stmt.setString(3, "%" + fundname + "%");
			}

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return count;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}

	}

	// return the list of all donation
	public List<Donation> search(int index, int pageSize) throws Exception {
		return search(-1, "", "", index, pageSize);
	}

	// return the list of donation by id and name, email
	public List<Donation> search(int id, String username, String fundname, int index, int pageSize) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Donation> donations = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// search donation query
			if ((id == -1) && (username.equals("")) && (fundname.equals(""))) {

				// search all
				sql = "with x as ( select ROW_NUMBER() over (order by donation_id) as r, * from donationExtend)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, index * pageSize - pageSize + 1);
				stmt.setInt(2, index * pageSize);
			} else if (id == -1) {

				// count with username, fundname
				sql = "with x as ( select ROW_NUMBER() over (order by donation_id) as r, *  from donationExtend where username like ? and fund_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + username + "%");
				stmt.setString(2, "%" + fundname + "%");
				stmt.setInt(3, index * pageSize - pageSize + 1);
				stmt.setInt(4, index * pageSize);
			} else {
				sql = "with x as ( select ROW_NUMBER() over (order by donation_id) as r, * from donationExtend where donation_id = ? and username like ? and fund_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + username + "%");
				stmt.setString(3, "%" + fundname + "%");
				stmt.setInt(4, index * pageSize - pageSize + 1);
				stmt.setInt(5, index * pageSize);
			}

			// Get results
			rs = stmt.executeQuery();

			while (rs.next()) {
				Donation c = new Donation(rs.getInt("donation_id"), rs.getInt("donation_amount"),
						rs.getString("donation_mess"), rs.getDate("donation_date"),
						new User(rs.getInt("user_id"), rs.getString("username")),
						new Fund(rs.getInt("fund_id"), rs.getString("fund_name")));

				donations.add(c);
			}

			return donations;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return donations;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get Donation
	@Override
	public Donation get(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Donation c = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select *  from donationExtend  where donation_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				c = new Donation(rs.getInt("donation_id"), rs.getInt("donation_amount"), rs.getString("donation_mess"),
						rs.getDate("donation_date"), new User(rs.getInt("user_id"), rs.getString("username")),
						new Fund(rs.getInt("fund_id"), rs.getString("fund_name")));
			}

			return c;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return c;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Return the donation list by user_id
	public List<Donation> getUserDonation(int userId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Donation> donations = new ArrayList<>();

		try {
			conn = new DBContext().getConnection();
			String sql = "select *  from donationExtend  where user_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();
			Donation c = null;
			while (rs.next()) {
				c = new Donation(rs.getInt("donation_id"), rs.getInt("donation_amount"), rs.getString("donation_mess"),
						rs.getDate("donation_date"), new User(rs.getInt("user_id"), rs.getString("username")),
						new Fund(rs.getInt("fund_id"), rs.getString("fund_name")));
				donations.add(c);
			}

			return donations;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return donations;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get recently donation
	public List<Donation> getRecentDonation(int num) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Donation> donations = new ArrayList<>();

		try {
			conn = new DBContext().getConnection();
			String sql = "select top " + num + " * from donationExtend order by donation_id desc;";
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			Donation c = null;
			while (rs.next()) {
				c = new Donation(rs.getInt("donation_id"), rs.getInt("donation_amount"), rs.getString("donation_mess"),
						rs.getDate("donation_date"), new User(rs.getInt("user_id"), rs.getString("username")),
						new Fund(rs.getInt("fund_id"), rs.getString("fund_name"), rs.getString("image_url")));
				donations.add(c);
			}

			return donations;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return donations;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	public int getTotalDonationForFund(int fundId) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int total = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "select sum(donation_amount) as total_d_amount from tblDonation where fund_id = ?";

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, fundId);

			rs = stmt.executeQuery();

			if (rs.next()) {
				total = rs.getInt("total_d_amount");
			}

			return total;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return total;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	@Override
	public boolean update(Donation obj) {
		return false;
	}

	@Override
	public Donation insert(Donation d) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Donation newD = null;
		try {
			conn = new DBContext().getConnection();
			String sql = "insert into tblDonation(donation_amount, donation_mess, donation_date, user_id, fund_id)\r\n"
					+ "values(?, ?, ?, ?, ?)";

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setInt(1, d.getDonationAmount());
			stmt.setString(2, d.getDonationMessage());
			stmt.setDate(3, d.getDonationDate());
			stmt.setInt(4, d.getUser().getId());
			stmt.setInt(5, d.getFund().getId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Insert donation failed");
			}

			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				newD = new Donation(rs.getInt(1), d.getDonationAmount(), d.getDonationMessage(), d.getDonationDate(), d.getUser(), d.getFund());
			} else {
				throw new SQLException("Insert donation failed");
			}

			return newD;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return newD;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	@Override
	public boolean delete(int id) {
		return false;
	}

}
