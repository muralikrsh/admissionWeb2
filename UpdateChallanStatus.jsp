<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String mesg="";

String strFullAdmissionNum=request.getParameter("FullAdmissionNum");

String strMakerId=request.getParameter("MakerId");
String strIPAddr=request.getParameter("IPAddr");
double totalPaid=Double.parseDouble(request.getParameter("TotalPaid"));
String strFlag=request.getParameter("Flag");

String strChallanAmount=request.getParameter("ChallanAmount");
String strChallanStatus=request.getParameter("ChallanStatus");
String strChallanAckDate=request.getParameter("ChallanAckDate");
	
try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);

	if(strFlag.equals("1"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET chal_recd_amt_1=?, challan_status_1=?, challan_ack_date_1=?, total_paid=? WHERE full_adm_no=?");
	}
	else if(strFlag.equals("2"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET chal_recd_amt_2=?, challan_status_2=?, challan_ack_date_2=?, total_paid=? WHERE full_adm_no=?");
	} 
	else if(strFlag.equals("3"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET chal_recd_amt_3=?, challan_status_3=?, challan_ack_date_3=?, total_paid=? WHERE full_adm_no=?");
	}
	else if(strFlag.equals("4"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET chal_recd_amt_4=?, challan_status_4=?, challan_ack_date_4=?, total_paid=? WHERE full_adm_no=?");
	}
	if(pst!=null) {
	pst.setString(1,strChallanAmount);
	pst.setString(2,strChallanStatus);
	pst.setString(3,strChallanAckDate);
		totalPaid=totalPaid+Double.parseDouble(strChallanAmount);
	pst.setDouble(4,totalPaid);
	pst.setString(5,strFullAdmissionNum);
	
	System.out.println(pst);
	pst.executeUpdate();
	}
		
	con.commit();
 	mesg="0000"+"~"+"PaymentReport.jsp?appn_no="+strFullAdmissionNum+"&flag="+strFlag;
	System.out.println("Successfully Submitted");
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	System.out.println("Error while submitting Admission form. Please contact Administrator "+e1.toString());
}
finally {
System.out.println("mesg :: "+mesg);
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%= mesg %>