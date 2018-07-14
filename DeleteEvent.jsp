<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String strEventID=request.getParameter("event_id");

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("delete from event where event_id=?");
	pst.setString(1,strEventID);
	pst.executeUpdate();
	con.commit();
	%>
	Event Successfully Deleted
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Deleting Event
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>