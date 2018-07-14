<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
String exam_id=request.getParameter("exam_id");
try{
	con=ConnectDatabase.getConnection();
	String arr[]=new String[] {"Exam Id","Exam Name","Course", "Exam Date","Exam Time","Exam Duration","Exam Venue"};
	
	pst=con.prepareStatement("select exam_id, exam_title, b.course_group, exam_date, exam_time, exam_duration, exam_venue from exam_master a, course b  where exam_id=? and a.course=b.course_group");
	pst.setString(1,exam_id);

	String message="<BR><BR><TABLE class='display'  WIDTH='80%' align=center>";
	ResultSet rs=pst.executeQuery();
	if(rs.next()) {
	for(int i=0; i<arr.length; i++) {
		message+="<TR><TD>"+arr[i]+"</TD><TD>"+rs.getString(i+1)+"</TD></TR>";
	}
	message+="<TR><TD>Syllabus</TD><TD><a href='DownloadFile?req_id=HT&path=SYLLABUS_PATH&ht_no="+ exam_id.replace("/","_")+".pdf'>Download</a></TD></TR>";
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