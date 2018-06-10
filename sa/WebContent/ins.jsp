<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<html>
<head>
	<title>Flight handle program</title>
</head>
<body>

	<form name="frmAdd" method="post" action="">	
	Add Form
	<table width="374" border="1">	
  <tr>
	<th width="140">
    <div align="left">CustomerID </div></th>
		<td width="272"><input type="text" name="txtCustomerID" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Departure </div></th>
		<td><input type="text" name="txtName" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">Start </div></th>
		<td><input type="text" name="txtStart" size="20"></td>
	</tr>
  <tr>
	<th width="140">
    <div align="left">End </div></th>
		<td><input type="text" name="txtEnd" size="20"></td>
	</tr>
	</table>
	<input type="submit" value="Add" name="submit">	
	<input type="submit" value="Delete" name="delete">
	<input type="submit" value="Edit" name="edit">
	<input type="submit" value="Filter" name="filter">
	</form>
	<%
	//insert value to database
	if(request.getParameter("submit") != null){
	  
		String CusID1 = "";
		if(request.getParameter("id") != null) {
			CusID1 = request.getParameter("id");
		}
		Connection connect1 = null;
		Statement s = null;
			
		try {
			Class.forName("org.postgresql.Driver");
			connect1 =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres" +
					"?user=postgres&password=Sql");
			s = connect1.createStatement();
				
			String strCustomerID = request.getParameter("txtCustomerID");
			String strName = request.getParameter("txtName");				
				
			String sql = "INSERT INTO flight " +						
						"VALUES ('" + strCustomerID + "','" + strName +  "') ";
		       s.execute(sql);
		        
			} catch (Exception e) {
				out.println(e.getMessage());
				e.printStackTrace();
			}
			
			try {
				if(s!=null){
					s.close();
					connect1.close();
				}
			} catch (SQLException e) {
				out.println(e.getMessage());
				e.printStackTrace();
			}
			}
	
	//delete value to database
	if(request.getParameter("delete") != null){
	String CusID = "";
	if(request.getParameter("id") != null) {
		CusID = request.getParameter("id");
	}
	
	Connection connect = null;
	Statement s = null;
	
	try {		
		Class.forName("org.postgresql.Driver");
		connect =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres" +
				"?user=postgres&password=Sql");
		
		s = connect.createStatement();
		
		String strCustomerID = request.getParameter("txtCustomerID");
		
		String sql = "delete from flight " +				
				"where \"ID\"=" + strCustomerID;
         s.execute(sql);
        
		} catch (Exception e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				connect.close();
			}
		} catch (SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	//update value to database
	if(request.getParameter("edit") != null){
	String CusID = "";
	if(request.getParameter("id") != null) {
		CusID = request.getParameter("id");
	}
	
	Connection connect = null;
	Statement s = null;
	
	try {
		
		Class.forName("org.postgresql.Driver");
		connect =  DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres" +
				"?user=postgres&password=Sql");
		
		s = connect.createStatement();
		
		String strName = request.getParameter("txtName");
		String strCustomerID = request.getParameter("txtCustomerID");
		
		String sql = "update flight set departure= " +				
				strName + "where \"ID\"=" + strCustomerID;
         s.execute(sql);
       		
		} catch (Exception e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
	
		try {
			if(s!=null){
				s.close();
				connect.close();
			}
		} catch (SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
	}

String id = request.getParameter("ID");
String driverName = "org.postgresql.Driver";
String connectionUrl = "jdbc:postgresql://localhost:5432/";
String dbName = "postgres";
String userId = "postgres";
String password = "Sql";

try {
	Class.forName(driverName);
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<h2 align="center"><font><strong>Retrieve data from database in jsp</strong></font></h2>
<table align="left" cellpadding="5" cellspacing="5" border="1">
<tr>

</tr>
<tr bgcolor="#A52A2A">
<td><b>id</b></td>
<td><b>departure</b></td>

</tr>
<%
try{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql ="SELECT * FROM flight";

//filter value from database
if(request.getParameter("filter") != null){
	String strStart = request.getParameter("txtStart");
	String strEnd = request.getParameter("txtEnd");

	sql = "select * from flight where \"ID\"  > " +
			
			  strStart + " and \"ID\" < " + strEnd ;
}

resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr bgcolor="#DEB887">

<td><%=resultSet.getString("id") %></td>
<td><%=resultSet.getString("departure") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>
</body>
</html>