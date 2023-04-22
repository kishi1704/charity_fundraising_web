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
import controller.admin.CategoryController;
import model.Category;

/**
 * @author TRUONGVANTIEN
 *
 */
public class CategoryDAO implements BaseDAO<Category> {
	
	private static final String ENABLE_STATUS = "Enable";

	// return number of all category
	public int countC() throws Exception {
		return countC(-1, "");
	}

	// return number of category by id, name
	public int countC(int id, String name) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// count category query
			if ((id == -1) && (name.equals(""))) {
				sql = "select count(*) as count from tblCategory;";
				stmt = conn.prepareStatement(sql);
			} else if (id == -1) {
				sql = "select count(*) as count from tblCategory where category_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
			} else {
				sql = "select count(*) as count from tblCategory where category_id = ? and category_name like ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
			}

			rs = stmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

			return count;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return count;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}

	}

	// return the list of all category per page
	public List<Category> search(int index, int pageSize) {
		return search(-1, "", index, pageSize);
	}

	// return the list of category by id and name
	public List<Category> search(int id, String name, int index, int pageSize) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Category> categories = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			if ((id == -1) && (name.equals(""))) {

				// get all category per page
				sql = "with x as ( select ROW_NUMBER() over (order by category_id) as r, * from tblCategory)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, index * pageSize - pageSize + 1);
				stmt.setInt(2, index * pageSize);
			} else if (id == -1) {

				// get all category with search name per page
				sql = "with x as ( select ROW_NUMBER() over (order by category_id) as r, * from tblCategory where category_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, "%" + name + "%");
				stmt.setInt(2, index * pageSize - pageSize + 1);
				stmt.setInt(3, index * pageSize);
			} else {

				// get all category with id, name per page
				sql = "with x as ( select ROW_NUMBER() over (order by category_id) as r, * from tblCategory where category_id = ? and category_name like ?)\r\n"
						+ "select * from x where r between ? and ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, id);
				stmt.setString(2, "%" + name + "%");
				stmt.setInt(3, index * pageSize - pageSize + 1);
				stmt.setInt(4, index * pageSize);
			}

			// Get results
			rs = stmt.executeQuery();

			while (rs.next()) {
				Category c = new Category(rs.getInt("category_id"), rs.getString("category_name"),
						rs.getString("category_des"), rs.getString("category_status"));

				categories.add(c);
			}

			return categories;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return categories;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get category
	@Override
	public Category get(int id) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Category c = null;

		try {
			conn = new DBContext().getConnection();
			String sql = "select * from tblCategory where category_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, id);
			rs = stmt.executeQuery();
			if (rs.next()) {
				c = new Category(rs.getInt("category_id"), rs.getString("category_name"), rs.getString("category_des"),
						rs.getString("category_status"));
			}

			return c;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return c;
		} finally {
			DBContext.close(conn, stmt, rs);
		}
	}

	// Get list of category
	public List<Category> get() {
		return get("");
	}
	
	
	public List<Category> get(String status) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		List<Category> categories = new ArrayList<>();
		try {
			conn = new DBContext().getConnection();
			String sql = "";

			// search category query
			if (status != null && status.equals(ENABLE_STATUS)) {
				// get all enable category
				sql = "select * from tblCategory where category_status = ?;";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, status);
			} else {

				// get all category
				sql = "select * from tblCategory;";
				stmt = conn.prepareStatement(sql);
			} 

			// Get results
			rs = stmt.executeQuery();

			while (rs.next()) {
				Category c = new Category(rs.getInt("category_id"), rs.getString("category_name"),
						rs.getString("category_des"), rs.getString("category_status"));

				categories.add(c);
			}

			return categories;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return categories;
		} finally {
			// close connection
			DBContext.close(conn, stmt, rs);
		}
	}

	// Update category
	@Override
	public boolean update(Category c) {
		Connection conn = null;
		PreparedStatement stmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			String sql = "update tblCategory\r\n" + "set category_name = ?, category_des = ?, category_status = ?\r\n"
					+ "where category_id = ?;";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, c.getName());
			stmt.setString(2, c.getDescription());
			stmt.setString(3, c.getStatus());
			stmt.setInt(4, c.getId());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Update category failed");
			} else {
				flag = true;
			}

			return flag;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, stmt, null);
		}
	}

	// Insert new category
	@Override
	public Category insert(Category c) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		Category newC = null;
		try {
			conn = new DBContext().getConnection();
			String sql = "insert into tblCategory(category_name, category_des, category_status)\r\n"
					+ "values(?, ?, ?);";

			stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			stmt.setString(1, c.getName());
			stmt.setString(2, c.getDescription());
			stmt.setString(3, c.getStatus());

			int affectedRows = stmt.executeUpdate();

			if (affectedRows == 0) {
				throw new SQLException("Insert category failed");
			}

			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				newC = new Category(rs.getInt(1), c.getName(), c.getDescription(), c.getStatus());
			} else {
				throw new SQLException("Insert category failed");
			}

			return newC;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return newC;
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

	public boolean delete(String idStr) {
		Connection conn = null;
		CallableStatement cstmt = null;

		boolean flag = false;
		try {
			conn = new DBContext().getConnection();
			cstmt = conn.prepareCall("{call DeleteCategories(?, ?)}");

			cstmt.setString(1, idStr);
			cstmt.registerOutParameter(2, Types.INTEGER);

			// Executing the CallableStatement
			cstmt.executeUpdate();

			int status = cstmt.getInt(2);

			flag = status == 1 ? true : false;

			return flag;
		} catch (Exception e) {
			Logger.getLogger(CategoryController.class.getName()).log(Level.SEVERE, null, e);
			return flag;
		} finally {
			DBContext.close(conn, cstmt, null);
		}
	}

}
