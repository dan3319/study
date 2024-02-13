package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
	private static final String JDBC_URL = "jdbc:oracle:thin:@1.220.247.78:1522:orcl";
	private static final String USER = "semi_project2";
	private static final String PASSWORD = "123452";
	
	public static Connection getConnection() throws SQLException{
		return DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
	}	
}