<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String exam_id=request.getParameter("exam_id");

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(exam_id);
	pst=con.prepareStatement("delete from exam_master where binary exam_id=?");
	pst.setString(1,exam_id);
	pst.executeUpdate();
	con.commit();
	%>
	Exam Successfully Deleted
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Deleting Exam
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>