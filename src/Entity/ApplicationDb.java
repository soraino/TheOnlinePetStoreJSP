package Entity;

import java.sql.Connection;
import java.sql.DriverManager;

public class ApplicationDb {
    protected String URL = System.getenv("DbConnectionString");
    protected String USER = System.getenv("DbUser");
    protected String PASSWORD = System.getenv("DbPassword");
    public Connection _con;

    public Connection getConnection(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            _con = DriverManager.getConnection(URL,USER,PASSWORD);
            return _con;
        }catch(Exception e){
            throw new IllegalStateException("Connection Problem");
        }
    }
    public void closeConnection(){
        try{
            _con.close();
        }catch(Exception e){
            throw new IllegalStateException("Cannot close connection");
        }

    }
}
