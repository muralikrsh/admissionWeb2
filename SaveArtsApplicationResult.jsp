<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
PreparedStatement pst1 = null;
ResultSet rs1=null;

String mesg="0000";
String first_name=request.getParameter("firstName");
String appfee_flag=request.getParameter("appfee_flag");
String f_appn_no=request.getParameter("appNo");
String appn_no=request.getParameter("intAppNo");

if(appfee_flag.intern()=="O".intern()) 
{
	String name=first_name;
	
	String txnNo=System.currentTimeMillis()+"";
	String str="BHARTUNIV|"+txnNo+"|NA|500.00|NA|NA|NA|INR|NA|R|bhartuniv|NA|NA|F|"+appn_no+"|APPLN|"+first_name+"|NA|NA|NA|NA|http://admission.bharathuniv.ac.in/admissionWeb2/PaymentStatus.jsp";
	String commonstr="5v2V1QMwY7uv";
	String cksum=CheckSumUtil.checkSumSHA256 (str+"|"+commonstr);
	String fullStr=str+"|"+cksum;	
	mesg+="~"+f_appn_no+"~"+fullStr;
	System.out.println("mesg "+mesg);
 } else { 	
	mesg+="~"+f_appn_no;
} %>
<%= mesg %>