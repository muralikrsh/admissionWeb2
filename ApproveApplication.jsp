<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%

String login_id=(String)session.getAttribute("login_id");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;


String flag=request.getParameter("aflag");
String appn_no=request.getParameter("appn_no");
String dd_number=request.getParameter("dd_number");
String dd_date=request.getParameter("dd_date");
String drawee_bank=request.getParameter("drawee_bank");
String amount=request.getParameter("amount");
String remarks=request.getParameter("remarks");
String rej_reason=request.getParameter("rej_reason");
String mesg="";

System.out.println("appn_no->"+appn_no);
System.out.println("flag->"+flag);

try{
		con=ConnectDatabase.getConnection();
		con.setAutoCommit(false);
		//if(flag.intern() == "A".intern()) {
		//Get DD Details
		pst=con.prepareStatement("update application set appn_status=?,remarks=?, reviewed_by=?, reviewed_on=now(), rej_reason=? where appn_no=?");
		/*
		pst.setString(1,dd_number);
		pst.setString(2,dd_date);
		pst.setString(3,drawee_bank);
		pst.setString(4,amount);
		*/
		pst.setString(1,flag);
		pst.setString(2,remarks);
		pst.setString(3,login_id);
		pst.setString(4,rej_reason);
		pst.setString(5,appn_no);
		//}
		/*
		if(flag.intern()=="R".intern()) {
			//Get Reject Reason Details
			pst=con.prepareStatement("update application set status='R', remarks=? where appn_no=?");
			pst.setString(1,remarks);
			pst.setString(2,appn_no);
		}
		*/
		pst.executeUpdate();
		con.commit();
		String img_ok="&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'>";
		
		if(flag.intern() == "A".intern()) {
			mesg="Application Number "+ appn_no+" has been Approved ";
			// +img_ok+"<br>Communication sent to user"+img_ok;
		} else {
			mesg="Application Number "+ appn_no+" has been Rejected ";
			//+"<br>Communication sent to user"+img_ok;
		}
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	mesg="Error while Approving / Rejecting Application. Please contact Administrator";
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%=mesg%>