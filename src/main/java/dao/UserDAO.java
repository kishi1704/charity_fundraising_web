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
import controller.admin.UserController;
import model.User;

public class UserDAO implements BaseDAO<User> {

	// return number of all user
	public int countU() throws Exception {
		return countU(-1, "", "");
	}

	// return number of user by role , username, email
	public int countU(int role, String username, String email) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// count user query
			if ((role == -1) && (username.equals("")) && (email.equals(""))) {

				// count all
				sql = "select count(*) as count from tblUser;";
				stmt = conn.prepareStatement(sql);

			} else if (role == -1) {

				// count by username, email
				sql = "select count(*) as count from tblUser where username like ? and user_email like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + username + "%");
				stmt.setString(2, "%" + email + "%");
			} else {

				// count role, username, email
				sql = "select count(*) as count from tblUser where user_role = ? and username like ? and user_email like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, role);
				stmt.setString(2, "%" + username + "%");
				stmt.setString(3, "%" + email + "%");
			}

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return count;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}

	}

	// return the list of all users per page
	public List<User> search(int index, int pageSize) {
		return search(-1, "", "", index, pageSize);
	}

	// return the list of user by id and name, email
	public List<User> search(int role, String username, String email, int index, int pageSize) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<User> users = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			if ((role == -1) && (username.equals("")) && (email.equals(""))) {

				// search all per page
				sql = "with x as ( select ROW_NUMBER() over (order by user_id) as r, * from tblUser)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, index * pageSize - pageSize + 1);
				stmt.setInt(2, index * pageSize);
			} else if (role == -1) {

				// count with username, email
				sql = "with x as ( select ROW_NUMBER() over (order by user_id) as r, * from tblUser where username like ? and user_email like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + username + "%");
				stmt.setString(2, "%" + email + "%");
				stmt.setInt(3, index * pageSize - pageSize + 1);
				stmt.setInt(4, index * pageSize);
			} else {
				sql = "with x as ( select ROW_NUMBER() over (order by user_id) as r, * from tblUser where user_role = ? and username like ? and user_email like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, role);
				stmt.setString(2, "%" + username + "%");
				stmt.setString(3, "%" + email + "%");
				stmt.setInt(4, index * pageSize - pageSize + 1);
				stmt.setInt(5, index * pageSize);
			}

			// Get results
			rs = stmt.executeQuery();

			// int id, String username, String password, int role, String fullName, String
			// email, String address,
			// String phoneNumber, String status
			while (rs.next()) {
				User u = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getInt("user_role"), rs.getString("user_fullname"), rs.getString("user_email"),
						rs.getString("user_address"), rs.getString("user_phone"), rs.getString("user_status"));

				users.add(u);
			}

			return users;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return users;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get user by id
	@Override
	public User get(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		User u = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select * from tblUser where user_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				u = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getInt("user_role"), rs.getString("user_fullname"), rs.getString("user_email"),
						rs.getString("user_address"), rs.getString("user_phone"), rs.getString("user_status"));

			}

			return u;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return u;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get user by username and password
	public User get(String username, String password) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		User u = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select * from tblUser where username = ? and password = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			rs = stmt.executeQuery();
			if (rs.next()) {
				u = new User(rs.getInt("user_id"), rs.getString("username"), rs.getString("password"),
						rs.getInt("user_role"), rs.getString("user_fullname"), rs.getString("user_email"),
						rs.getString("user_address"), rs.getString("user_phone"), rs.getString("user_status"));

			}

			return u;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return u;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Update user
	@Override
	public boolean update(User u) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			String sql = "update tblUser\r\n"
					+ "set username = ?, user_role = ?, user_fullname = ?, user_phone = ?, user_email = ?, user_address = ?,  user_status = ?\r\n"
					+ "where user_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, u.getUsername());
			stmt.setInt(2, u.getRole());
			stmt.setString(3, u.getFullName());
			stmt.setString(4, u.getPhoneNumber());
			stmt.setString(5, u.getEmail());
			stmt.setString(6, u.getAddress());
			stmt.setString(7, u.getStatus());
			stmt.setInt(8, u.getId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update user failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

	// Insert new user
	@Override
	public User insert(User u) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		User newU = null;
		try {
			conn = new DBContext().getConnection();
			String sql = "insert into tblUser(username, password, user_email, user_role, user_fullname, user_address, user_phone, user_status)\r\n"
					+ "values(?, ?, ?, ?, ?, ?, ?, ?)";

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, u.getUsername());
			stmt.setString(2, u.getPassword());
			stmt.setString(3, u.getEmail());
			stmt.setInt(4, u.getRole());
			stmt.setString(5, u.getFullName());
			stmt.setString(6, u.getAddress());
			stmt.setString(7, u.getPhoneNumber());
			stmt.setString(8, u.getStatus());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Insert user failed");
			}

			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				newU = new User(rs.getInt(1), u.getUsername(), u.getPassword(), u.getRole(), u.getFullName(),
						u.getEmail(), u.getAddress(), u.getPhoneNumber(), u.getStatus());
			} else {
				throw new SQLException("Insert user failed");
			}

			return newU;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return newU;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Delete user
	@Override
	public boolean delete(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();

			String sql = "delete from tblUser where user_id = ? ;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update user failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

	// Is exists user
	public boolean isExistUser(String username, String email) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();

			String sql = "select count(*) as count from tblUser where username = ? or user_email = ?;";

			stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, email);

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count != 0;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return true;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}
	
	// Update Password
	public boolean updatePassword(User u) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			String sql = "update tblUser\r\n"
					+ "set password = ?\r\n"
					+ "where username = ? and user_email = ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, u.getPassword());
			stmt.setString(2, u.getUsername());
			stmt.setString(3, u.getEmail());
			

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update password failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

}
