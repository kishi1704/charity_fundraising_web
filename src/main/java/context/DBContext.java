/**
 * 
 */
package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import util.ReadProperties;

/**
 * @author TRUONGVANTIEN
 *
 */
public class DBContext {
	/**
	 * Change/update information of your database connection DO NOT change name of
	 * instance variables in this class
	 */
	private final ReadProperties readPro = ReadProperties.getInstance();
	private final String serverName = readPro.getProperty("serverName");
	private final String dbName = readPro.getProperty("dbName");
	private final String portNumber = readPro.getProperty("portNumber");
	private final String instance = readPro.getProperty("instance"); // leave this one empty if your sql is a single instace
	private final String userID = readPro.getProperty("userID");
	private final String password = readPro.getProperty("password");

	/**
	 * Get connection to database
	 */
	public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
		if (instance == null || instance.trim().isBlank()) {
			url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName
					+ ";encrypt=true;trustServerCertificate=true;";
		}

		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(url, userID, password);
	}

	/**
	 * Close connection
	 */

	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				/* Ignored */}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				/* Ignored */}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				/* Ignored */}
		}
	}
}
