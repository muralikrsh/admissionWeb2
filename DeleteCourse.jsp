<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String exam_id=request.getParameter("course_id");

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(exam_id);
	pst=con.prepareStatement("delete from course where binary course_id=?");
	pst.setString(1,exam_id);
	pst.executeUpdate();
	con.commit();
	%>
	Course Successfully Deleted
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Deleting Course
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>