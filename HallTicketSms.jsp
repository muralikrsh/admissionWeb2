<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String msg="";
String alhtno="";
String alappn_no="";
String alf_name="";
String alf_appn_no="";
String almob_no="";
String alcity_centre="";
try{

	con = ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("SELECT ht_no, appn_no, first_name, f_appn_no, mobile_no, city_centre FROM application a,exam_master e WHERE a.appn_status='A' AND a.course=e.course AND e.exam_id='EX0001' AND ht_no BETWEEN 205501 AND 205523 ORDER BY ht_no");
	rs=pst.executeQuery();
	while(rs.next()) {
	
			alhtno=rs.getString(1);
			alappn_no=rs.getString(2);
			alf_name=rs.getString(3);
			alf_appn_no=rs.getString(4);
			almob_no=rs.getString(5);
			alcity_centre=rs.getString(6);	
		 
		
		String SMSText="Dear "+alf_name+", Bharath Engineering Entrance Exam(BEEE 2015) to be held on April 25th Saturday at 10AM.Exam venue:"+alcity_centre+".Hall ticket number:"+alhtno+".Kindly download the hallticket from http://www.bharathuniv.ac.in/";
		
		boolean sessionDebug = false;

		int retSMS=new SendSMS2().mesg("91"+almob_no,SMSText); 
		/* Commented SMS Activation Link
		int retSMS=new SendSMS2().mesg("91"+almob_no,SMSText); 
		*/
		
		msg="SMS sent successfully";
	
	}	
	System.out.println(msg);	
}
catch (Exception e){
	
	e.printStackTrace();
	msg="error";
	System.out.println(msg);	
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= msg %>