<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String user_id=request.getParameter("user_id");

try{
	con=ConnectDatabase.getConnection();
	
	pst=con.prepareStatement("select name,password,role,status,email_id from adm_login where id=?");
	pst.setString(1,user_id);

	String message="";
	
	ResultSet rs=pst.executeQuery();
	if(rs.next()) {
		message=rs.getString(1)+"-"+rs.getString(2)+"-"+rs.getString(3)+"-"+rs.getString(4)+"-"+rs.getString(5);
	}
	%>
	<%= message %>
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
No matching records
<%
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>