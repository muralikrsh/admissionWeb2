<%@page import="java.sql.*, campus.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String strEmpID="";
String str="";

try{

con = ConnectDatabase.getConnection();
pst=con.prepareStatement("select name, role, dept_id, email_id, mobile_no from adm_login where binary id=? and binary password=? and binary status='O'");

String userId=request.getParameter("txtUserID");
System.out.println(userId+" tried to Login");	
String strRole="";
String dept_id="";
pst.setString(1,userId);
pst.setString(2,request.getParameter("txtPassword"));
System.out.println("pst login -> "+pst);
rs=pst.executeQuery();
//System.out.println("Here 4"+request.getParameter("txtPassword"));	
if(rs.next()) {
System.out.println(userId+" login success");	
str=rs.getString(1);
strRole=rs.getString(2);
dept_id=rs.getString(3);
session.setAttribute("login_id", userId);
session.setAttribute("login_name", str);
session.setAttribute("role", strRole);
session.setAttribute("dept_id", dept_id);
session.setAttribute("email_id", rs.getString("email_id"));
session.setAttribute("mobile_no", rs.getString("mobile_no"));
//int i=new SessionHandler().loginSession(request);
System.out.println(strRole+" strRole");	
} else {
System.out.println(userId+" login failure");	
throw new Exception("INVALID LOGIN");
}
%>
<%= str %>
<%
}
catch (Exception e){
%>INVALID_LOGIN<%
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>