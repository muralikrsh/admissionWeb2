<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;

String exam_id=request.getParameter("exam_id");
String flag=request.getParameter("flag");
String message="Exam Syllabus "+((flag.intern()=="A".intern())?"Approved":"Rejected");
try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(exam_id);
	pst=con.prepareStatement("update exam_master set status=? where binary exam_id=?");
	pst.setString(1,flag);
	pst.setString(2,exam_id);
	pst.executeUpdate();
	con.commit();
	%>
	 <%= message %>
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Approving / Rejecting Exam Syllabus
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>