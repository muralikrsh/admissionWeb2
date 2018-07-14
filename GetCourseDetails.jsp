<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
String course_id=request.getParameter("course_id");
try{
	con=ConnectDatabase.getConnection();
	String arr[]=new String[] {"Course Id","Course Name","Course Description","Course Duration","Course Fees"};
	
	pst=con.prepareStatement("select course_id, course_name, course_desc, course_duration, course_fees from course  where course_id=?");
	pst.setString(1,course_id);

	String message="<BR><BR><TABLE class='display'  WIDTH='80%' align=center>";
	ResultSet rs=pst.executeQuery();
	if(rs.next()) {
	for(int i=0; i<arr.length; i++) {
		message+="<TR><TD>"+arr[i]+"</TD><TD>"+rs.getString(i+1)+"</TD></TR>";
	}
	message+="<TR><TD>Syllabus</TD><TD><a href='DownloadFile?req_id=HT&path=COURSE_SYLLABUS_PATH&ht_no="+ course_id.replace("/","_")+".pdf'>Download</a></TD></TR>";
	message+="</TABLE>";
	}
	%>
	<%= message %>
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
	Error while Fetching Data
<%
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>