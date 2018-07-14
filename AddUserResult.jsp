<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String user_id=request.getParameter("user_id");
String user_name=request.getParameter("user_name");
String email_id=request.getParameter("email_id");
String password=request.getParameter("password");
String role=request.getParameter("role");
String enable=request.getParameter("enable");
String flag=request.getParameter("flag");

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(con);
	if(flag.intern()=="I".intern()) {
		pst=con.prepareStatement("insert into adm_login (id,name,password, role,status,email_id) values(?,?,?,?,?,?)");
		pst.setString(1,user_id);
		pst.setString(2,user_name);
		pst.setString(3,password);
		pst.setString(4,role);
		pst.setString(5,enable);
		pst.setString(6,email_id);
	} else {
		pst=con.prepareStatement("update adm_login set name=?, password=?, role=?, status=?, email_id=? where id=?");
		pst.setString(1,user_name);
		pst.setString(2,password);
		pst.setString(3,role);
		pst.setString(4,enable);
		pst.setString(5,email_id);
		pst.setString(6,user_id);
	}

	pst.executeUpdate();
	con.commit();
	%>
	<%= (flag.intern()=="I".intern())?"User Successfully Created":"User data updated" %>
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Creating User
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>