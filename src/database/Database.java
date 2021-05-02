package database;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Database {

	public Database() {

	}

	public Connection getConnection() throws IOException {
		String connectionUrl = "jdbc:mysql://localhost:3306/buyme?autoReconnect=true&useSSL=false";
		Connection connection = null;

		Properties properties =new Properties();
		InputStream in = getClass().getResourceAsStream("db.properties");
		String username = null;
		String password = null;
		if (in != null) {
			properties.load(in);
			username = properties.getProperty("username");
			password = properties.getProperty("password");
			in.close();
		} else {
			System.out.println("Error with reading in the properties file");
		}


		try {
			Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(connectionUrl, username, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) throws IOException {
		Database db = new Database();
		Connection conn = db.getConnection();
		System.out.println(conn);
		db.closeConnection(conn);
	}

}
