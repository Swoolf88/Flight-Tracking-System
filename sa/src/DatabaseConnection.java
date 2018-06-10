

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.ResultSet;  
import java.sql.Statement;

import javax.enterprise.context.RequestScoped;  

@RequestScoped
public class DatabaseConnection {  
Connection conn;  
Statement stmt;  
ResultSet res;  

public DatabaseConnection(){  

}  

public Connection setConnection(){  
try{  
    System.out.println("sdsadasd");  
Class.forName("org.postgresql.Driver");  
conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres","postgres","Sql");  
 System.out.println("Connected to the database");  
}catch(Exception e){  

}  
return conn;  
}  

public ResultSet getResult(String sql,Connection conn){  
this.conn=conn;  
try{  
stmt=conn.createStatement();  
res=stmt.executeQuery(sql);  
}catch(Exception e){  

}  
return res;  
}  
}