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
import model.Foundation;

/**
 * @author TRUONGVANTIEN
 *
 */
public class FoundationDAO implements BaseDAO<Foundation> {

	// return number of all foundation
	public int countF() throws Exception {
		return countF(-1, "", "");
	}

	// return number of foundation by id, name, email
	public int countF(int id, String name, String email) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// count foundation query
			if ((id == -1) && (name.equals("")) && (email.equals(""))) {

				// count all
				sql = "select count(*) as count from tblFoundation;";
				stmt = conn.prepareStatement(sql);

			} else if (id == -1) {

				// count name, email
				sql = "select count(*) as count from tblFoundation where foundation_name like ? and foundation_email like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
				stmt.setString(2, "%" + email + "%");
			} else {

				// count id, name, email
				sql = "select count(*) as count from tblFoundation where foundation_id = ? and foundation_name like ? and foundation_email like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
				stmt.setString(3, "%" + email + "%");
			}

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return count;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}

	}

	// return the list of all foundation
	public List<Foundation> search() throws Exception {
		return search(-1, "", "", -1, -1);
	}

	// return the list of all foundation per page
	public List<Foundation> search(int index, int pageSize) {
		return search(-1, "", "", index, pageSize);
	}

	// return the list of foundation by id and name, email
	public List<Foundation> search(int id, String name, String email, int index, int pageSize) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Foundation> foundations = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// search foundation query
			if ((id == -1) && (index == -1)) {
				// search all
				sql = "select * from tblFoundation;";
				stmt = conn.prepareStatement(sql);
			} else if ((id == -1) && (name.equals("")) && (email.equals(""))) {

				// search all per page
				sql = "with x as ( select ROW_NUMBER() over (order by foundation_id) as r, * from tblFoundation)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, index * pageSize - pageSize + 1);
				stmt.setInt(2, index * pageSize);
			} else if (id == -1) {

				// count with name, email
				sql = "with x as ( select ROW_NUMBER() over (order by foundation_id) as r, * from tblFoundation where foundation_name like ? and foundation_email like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
				stmt.setString(2, "%" + email + "%");
				stmt.setInt(3, index * pageSize - pageSize + 1);
				stmt.setInt(4, index * pageSize);
			} else {
				sql = "with x as ( select ROW_NUMBER() over (order by foundation_id) as r, * from tblFoundation where foundation_id = ? and foundation_name like ? and foundation_email like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
				stmt.setString(3, "%" + email + "%");
				stmt.setInt(4, index * pageSize - pageSize + 1);
				stmt.setInt(5, index * pageSize);
			}

			// Get results
			rs = stmt.executeQuery();

			while (rs.next()) {
				Foundation f = new Foundation(rs.getInt("foundation_id"), rs.getString("foundation_name"),
						rs.getString("foundation_des"), rs.getString("foundation_email"),
						rs.getString("foundation_status"));

				foundations.add(f);
			}

			return foundations;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return foundations;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get foundation
	@Override
	public Foundation get(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Foundation f = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select * from tblFoundation where foundation_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				f = new Foundation(rs.getInt("foundation_id"), rs.getString("foundation_name"),
						rs.getString("foundation_des"), rs.getString("foundation_email"),
						rs.getString("foundation_status"));
			}

			return f;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return f;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Update foundation
	@Override
	public boolean update(Foundation f) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			String sql = "update tblFoundation\r\n"
					+ "set foundation_name = ?, foundation_des = ?, foundation_email = ?, foundation_status = ?\r\n"
					+ "where foundation_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, f.getName());
			stmt.setString(2, f.getDescription());
			stmt.setString(3, f.getEmail());
			stmt.setString(4, f.getStatus());
			stmt.setInt(5, f.getId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update foundation failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

	// Insert new foundation
	@Override
	public Foundation insert(Foundation f) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Foundation newF = null;
		try {
			conn = new DBContext().getConnection();
			String sql = "insert into tblFoundation(foundation_name, foundation_des, foundation_email, foundation_status)\r\n"
					+ "values(?, ?, ?, ?);";

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, f.getName());
			stmt.setString(2, f.getDescription());
			stmt.setString(3, f.getEmail());
			stmt.setString(4, f.getStatus());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Insert foundation failed");
			}

			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				newF = new Foundation(rs.getInt(1), f.getName(), f.getDescription(), f.getEmail(), f.getStatus());
			} else {
				throw new SQLException("Insert foundation failed");
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

	// Delete foundation
	@Override
	public boolean delete(int id) {
		return delete(Integer.toString(id));
	}
	
	
	
	public boolean delete(String idStr) {
		Connection conn = null;
		CallableStatement cstmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			cstmt = conn.prepareCall("{call DeleteFoundations(?, ?)}");

			cstmt.setString(1, idStr);
			cstmt.registerOutParameter(2, Types.INTEGER);

			// Executing the CallableStatement
			cstmt.executeUpdate();

			int status = cstmt.getInt(2);

			flag = status == 1 ? true : false;

			return flag;
		} catch (Exception e) {
			Logger.getLogger(FoundationController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, cstmt, null);
		}
	}

}
