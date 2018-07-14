<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String login_id=request.getParameter("login_id");
String old_pass=request.getParameter("old_pass");
String new_pass=request.getParameter("new_pass");

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(con);
	pst=con.prepareStatement("update adm_login set password=? where id=? and password=?");
	pst.setString(1,new_pass);
	pst.setString(2,login_id);
	pst.setString(3,old_pass);
	int i=pst.executeUpdate();
	con.commit();
	if(i==1) {
	%>
	Password updated successfully
	<%
	} else {
	%>
	Please provide the correct password
	<%
	}
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Creating Data
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>