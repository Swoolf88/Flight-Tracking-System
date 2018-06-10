import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/send")
public class send extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public send() {
        super();
        System.out.println("message");
        // TODO Auto-generated constructor stub
    }
	   
    @Inject private DatabaseConnection dbconn;		
   
   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       PrintWriter out = response.getWriter();
	   /*if(request.getParameter("submit") != null)*/
	   
			String CusID = "";
			if(request.getParameter("id") != null) {
				CusID = request.getParameter("id");
			}
			Connection connect = null;
			Statement s = null;
			Connection conn = null;
			
			try {
				dbconn=new DatabaseConnection(); 
				Class.forName("org.postgresql.Driver");
				connect =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres" +
						"?user=postgres&password=Sql");
				conn=dbconn.setConnection(); 
				s = conn.createStatement();
				
				String strCustomerID = request.getParameter("txtCustomerID");
				String strName = request.getParameter("txtName");
				
				
				String sql = "INSERT INTO flight " +
						
						"VALUES ('" + strCustomerID + "','" + strName +  "') ";
		         s.execute(sql);
		        
		        // out.println("Record Inserted Successfully");
		        
			  		
				} catch (Exception e) {
					// TODO Auto-generated catch block
					out.println(e.getMessage());
					e.printStackTrace();
				}
			
				try {
					if(s!=null){
						s.close();
						conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					out.println(e.getMessage());
					e.printStackTrace();
				}
			
	   out.print("Sorry UserName or Password Error!");  
       RequestDispatcher rd = request.getRequestDispatcher("/ins.jsp");  
       rd.include(request, response);  
   }

}


