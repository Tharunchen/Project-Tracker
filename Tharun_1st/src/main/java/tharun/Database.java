package tharun;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.InputStream;

public class Database {

    private static Connection connection;

    private static final String PROPERTY_FILE_PATH =
            "C:/Users/HP/OneDrive/Desktop/sampledb.txt";

    public static Connection getConnection() {

        try {
            if (connection == null || connection.isClosed()) {

                Properties props = new Properties();
                InputStream is = new FileInputStream(PROPERTY_FILE_PATH);
                props.load(is);

                Class.forName(props.getProperty("db.driver"));

                connection = DriverManager.getConnection(
                        props.getProperty("db.url"),
                        props.getProperty("db.username"),
                        props.getProperty("db.password")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
