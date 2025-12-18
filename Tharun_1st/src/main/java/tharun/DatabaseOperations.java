package tharun;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseOperations {

	 private static Connection con;
    // INSERT & RETURN AUTO ID
    public static int insertAndGetId(String query) {
        int id = 0;
        try {
            Connection con = Database.getConnection();
            Statement stmt = con.createStatement();
            stmt.executeUpdate(query, Statement.RETURN_GENERATED_KEYS);

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    // INSERT (NO ID)
    public static int insert(String query) {
        int result = 0;
        try {
            Connection con = Database.getConnection();
            Statement stmt = con.createStatement();
            result = stmt.executeUpdate(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // UPDATE / DELETE
    public static int update(String query) {
        int result = 0;
        try {
            Connection con = Database.getConnection();
            Statement stmt = con.createStatement();
            result = stmt.executeUpdate(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // SELECT
    public static ResultSet select(String query) {
        ResultSet rs = null;
        try {
            Connection con = Database.getConnection();
            Statement stmt = con.createStatement();
            rs = stmt.executeQuery(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }
    public static void closeConnection() {
    	
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
