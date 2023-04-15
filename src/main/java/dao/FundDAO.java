/**
 * 
 */
package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import context.DBContext;
import controller.admin.FoundationController;
import controller.admin.FundController;
import model.Fund;

/**
 * @author TRUONGVANTIEN
 *
 */
public class FundDAO implements BaseDAO<Fund>{

	// return number of all fund
	public int countF() throws Exception {
		return countF(-1, "", "", "");
	}

	// return number of fund by id, name, foundation, category
	public int countF(int id, String name, String foundation, String category) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// count fund query
			if ((id == -1) && (name.equals("")) && (foundation.equals("")) && (category.equals(""))) {

				// count all
				sql = "select count(?) as count from fundExtend;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "*");
			} else if (id == -1) {

				// count name, category, foundation
				sql = "select count(*) as count from fundExtend where fund_name like ? and foundation_name like ? and category_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
				stmt.setString(2, "%" + foundation + "%");
				stmt.setString(3, "%" + category + "%");
			} else {

				// count id, name, foundation, category
				sql = "select count(*) as count from fundExtend where fund_id = ? and fund_name like ? and foundation_name like ? and category_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
				stmt.setString(3, "%" + foundation + "%");
				stmt.setString(4, "%" + category + "%");
			}

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count;
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
			return count;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}

	}

	// return the list of all fund
	public List<Fund> search(int index, int pageSize) throws Exception {
		return search(-1, "", "", "", index, pageSize);
	}

	// return the list of fund by id and name, foundation, category
	public List<Fund> search(int id, String name, String foundation, String category, int index, int pageSize) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Fund> funds = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// search fund query
			if ((id == -1) && (name.equals("")) && (foundation.equals("")) && (category.equals(""))) {

				// search all
				sql = "with x as ( select ROW_NUMBER() over (order by fund_id) as r, * from fundExtend)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, index * pageSize - pageSize + 1);
				stmt.setInt(2, index * pageSize);
			} else if (id == -1) {

				// count with name, foundation, category
				sql = "with x as ( select ROW_NUMBER() over (order by fund_id) as r, * from fundExtend where fund_name like ? and foundation_name like ? and category_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
				stmt.setString(2, "%" + foundation + "%");
				stmt.setString(3, "%" + category + "%");
				stmt.setInt(4, index * pageSize - pageSize + 1);
				stmt.setInt(5, index * pageSize);
			} else {
				sql = "with x as ( select ROW_NUMBER() over (order by fund_id) as r, * from fundExtend where fund_id = ? and fund_name like ? and foundation_name like ? and category_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
				stmt.setString(3, "%" + foundation + "%");
				stmt.setString(4, "%" + category + "%");
				stmt.setInt(5, index * pageSize - pageSize + 1);
				stmt.setInt(6, index * pageSize);
			}

			// Get results
			rs = stmt.executeQuery();

			while (rs.next()) {
				Fund f = new Fund(rs.getInt("fund_id"), rs.getString("fund_name"), rs.getString("fund_des"),
						rs.getString("fund_content"), rs.getString("image_url"), rs.getInt("expected_amount"),
						rs.getDate("start_date"), rs.getDate("end_date"), rs.getInt("category_id"),
						rs.getString("category_name"), rs.getInt("foundation_id"), rs.getString("foundation_name"),
						rs.getString("fund_status"));

				funds.add(f);
			}

			return funds;
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
			return funds;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get fund
	@Override
	public Fund get(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Fund f = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select * from fundExtend where fund_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				f = new Fund(rs.getInt("fund_id"), rs.getString("fund_name"), rs.getString("fund_des"),
						rs.getString("fund_content"), rs.getString("image_url"), rs.getInt("expected_amount"),
						rs.getDate("start_date"), rs.getDate("end_date"), rs.getInt("category_id"),
						rs.getString("category_name"), rs.getInt("foundation_id"), rs.getString("foundation_name"),
						rs.getString("fund_status"));
			}

			return f;
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
			return f;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Update fund
	@Override
	public boolean update(Fund f) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			// id, name, description, content, image_url, expectedAmount, createdDate,
			// endDate, categoryId, "", foundationId, "", status
			String sql = "update tblFund\r\n"
					+ "set fund_name = ?, fund_des = ?, fund_content = ?, image_url = ?, expected_amount = ?, start_date = ?, end_date = ?, category_id = ?, foundation_id = ?, fund_status = ? \r\n"
					+ "where fund_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, f.getName());
			stmt.setString(2, f.getDescription());
			stmt.setString(3, f.getContent());
			stmt.setString(4, f.getImage_url());
			stmt.setInt(5, f.getExpectedAmount());
			stmt.setDate(6, f.getCreatedDate());
			stmt.setDate(7, f.getEndDate());
			stmt.setInt(8, f.getCategoryId());
			stmt.setInt(9, f.getFoundationId());
			stmt.setString(10, f.getStatus());
			stmt.setInt(11, f.getId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update fund failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

	// Insert new fund
	@Override
	public Fund insert(Fund f) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Fund newF = null;
		try {
			conn = new DBContext().getConnection();
			String sql = "insert into tblFund(fund_name,fund_des, fund_content, image_url, expected_amount, start_date, end_date, category_id, foundation_id, fund_status)\r\n"
					+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, f.getName());
			stmt.setString(2, f.getDescription());
			stmt.setString(3, f.getContent());
			stmt.setString(4, f.getImage_url());
			stmt.setInt(5, f.getExpectedAmount());
			stmt.setDate(6, f.getCreatedDate());
			stmt.setDate(7, f.getEndDate());
			stmt.setInt(8, f.getCategoryId());
			stmt.setInt(9, f.getFoundationId());
			stmt.setString(10, f.getStatus());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Insert fund failed");
			}

			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				newF = new Fund(rs.getInt(1), f.getName(), f.getDescription(), f.getContent(), f.getImage_url(),
						f.getExpectedAmount(), f.getCreatedDate(), f.getEndDate(), f.getCategoryId(),
						f.getFoundationId(), f.getStatus());
			} else {
				throw new SQLException("Insert fund failed");
			}

			return newF;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return newF;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Delete category
	@Override
	public boolean delete(int id) {
		return delete(Integer.toString(id));
	}
	
	public boolean delete(String idStr){
		Connection conn = null;
		CallableStatement cstmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			cstmt = conn.prepareCall("{call DeleteFunds(?, ?)}");

			cstmt.setString(1, idStr);
			cstmt.registerOutParameter(2, Types.INTEGER);

			// Executing the CallableStatement
			cstmt.executeUpdate();

			int status = cstmt.getInt(2);

			flag = status == 1 ? true : false;

			return flag;
		} catch (Exception e) {
			Logger.getLogger(FundController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, cstmt, null);
		}
	}

}
