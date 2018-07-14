
<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String msg="";
try{

	con = ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("select count(1) from adm_login where binary id=? and email_id=? and sq1=? and sa1=?");
	System.out.println("select count(1) from adm_login where binary id=? and email_id=? and sq1=? and sa1=?");

	String uid=request.getParameter("uid");
	String email_id=request.getParameter("email_id");
	String pwd=request.getParameter("pwd");
	String sqid1=request.getParameter("sqid1");
	String sa1=request.getParameter("sa1");
	String sqid2=request.getParameter("sqid2");
	String sa2=request.getParameter("sa2");
	String strRole="";
	String dept_id="";
	pst.setString(1,uid);
	pst.setString(2,email_id);
	pst.setString(3,sqid1);
	pst.setString(4,sa1);
	
	System.out.println(uid+"::"+email_id+"::"+sqid1+"::"+sa1+"::"+sqid2+"::"+sa2);
	rs=pst.executeQuery();
	int count=0;

	if( rs.next()) 
		count=rs.getInt(1);

	if(count==0) {
		msg="INVALID_ANS";
	} else {
			System.out.println("Before Update");
		pst=con.prepareStatement("update adm_login set password=? where binary id=? and email_id=?");
		pst.setString(2,uid);
		pst.setString(3,email_id);
		pst.setString(1,pwd);
		pst.executeUpdate();
		con.commit();
		msg="PWD_RESET";
	}	
	System.out.println(msg);	
}
catch (Exception e){
	con.rollback();
	e.printStackTrace();
	msg="SYSTEM_ERR";
	System.out.println(msg);	
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= msg %>