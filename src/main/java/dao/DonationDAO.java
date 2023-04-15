/**
 * 
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import controller.admin.DonationController;
import model.Donation;

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
						rs.getString("donation_mess"), rs.getDate("donation_date"), rs.getInt("user_id"),
						rs.getString("username"), rs.getInt("fund_id"), rs.getString("fund_name"));

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
						rs.getDate("donation_date"), rs.getInt("user_id"), rs.getString("username"),
						rs.getInt("fund_id"), rs.getString("fund_name"));
			}

			return c;
		} catch (Exception e) {
			Logger.getLogger(DonationController.class.getName()).log(Level.SEVERE, null, e);
			return c;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	@Override
	public boolean update(Donation obj) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public Donation insert(Donation obj) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return false;
	}

}
