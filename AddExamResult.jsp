<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
String login_id=(String)session.getAttribute("login_id");
String flag=request.getParameter("flag");
String exam_id=request.getParameter("exam_id");
String exam_title=request.getParameter("exam_title");
String exam_course=request.getParameter("exam_course");
String exam_date=request.getParameter("exam_date");
String exam_centre=request.getParameter("exam_centre");
String exam_time=request.getParameter("exam_time");
String exam_duration=request.getParameter("exam_duration");
String exam_venue=request.getParameter("exam_venue");
String category=request.getParameter("category");
String mesg="";
try{

	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	if(flag.intern()=="I".intern())	{
		try {
			pst=con.prepareStatement("select concat('EX', lpad(max(substring(exam_id,4))+1,4,'0')) from exam_master");
			ResultSet rs=pst.executeQuery();
			if(rs.next())
				exam_id=rs.getString(1);
			if(exam_id==null)
				exam_id="EX0001";
			rs=null;
		}
		catch(Exception e1){
			e1.printStackTrace();
			mesg="Error while generating Exam Id";
		}
		finally {
			pst=null;
		}
		pst=con.prepareStatement("insert into exam_master (exam_title,exam_date,exam_time,course, exam_duration,exam_venue,category, status, mkr_id, mkr_dt, exam_centre, exam_id) values(?,str_to_date(?,'%d-%M-%Y'),?,?,?,?,?,'O',?,now(),?,?)");
	}
	else
		pst=con.prepareStatement("update exam_master set exam_title=?, exam_date=str_to_date(?,'%d-%M-%Y'), exam_time=?,course=?, exam_duration=?, exam_venue=?, category=?, status='O', mkr_id=?, mkr_dt=now(), exam_centre=? where exam_id=?");

	pst.setString(1,exam_title);
	pst.setString(2,exam_date);
	pst.setString(3,exam_time);
	pst.setString(4,exam_course);
	pst.setString(5,exam_duration);
	pst.setString(6,exam_venue);
	pst.setString(7,category);
	pst.setString(8,login_id);
	pst.setString(9,exam_centre);
	pst.setString(10,exam_id);
	
	pst.executeUpdate();
	con.commit();
	mesg="Exam Set Up Successful&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'>";
}
catch(Exception e1){
	e1.printStackTrace();
	mesg="Exam Set Up Failed&nbsp;<img src='images/error.gif' width='15' height='15' border='0'>";
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%= mesg%>