<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String msg="";
try{

	con = ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("select count(1) from adm_login where binary id=? and act_id=?");
	System.out.println("select count(1) from adm_login where binary id=? and act_id=?");

	String userId=request.getParameter("user_id");
	String actId=request.getParameter("act_id");
	pst.setString(1,userId);
	pst.setString(2,actId);
	rs=pst.executeQuery();
	int count=0;
	if(rs.next()) {
		count=rs.getInt(1);
	}
	if(count==0) {
		msg="Invalid Activation Link";
	} else {
		pst=con.prepareStatement("update adm_login set status='O' where binary id=? and act_id=?");
		pst.setString(1,userId);
		pst.setString(2,actId);
		pst.executeUpdate();

		msg="Congratulations. Your login has been activated. Please login to <a href='Login.jsp'>Bharath University</a>";
	}
} catch (Exception e) {
	e.printStackTrace();
}
finally {
	try {
		con.close();
	} catch (Exception e1) {
	}
}
%>
<html>
<title>
Bharath University - Activate User
</title>
<head>
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
<%@include file="MBHandler.jsp" %>
</head>

<body>
<div class="container">
<header>
<div class="header_holder">
<div align='center'><img src="images/bu_logo.jpg" alt="Bharath University" style="height:120px;width:40%;" title="Bharath University"/></div>

</div>
</header>

<section>

<div class="content_container fontbold">
<table style="width:100%; height:70%">
<tr><td align="center">
<br><br><br><br><br>
<b><%=msg %></b>
</td></tr>
</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>

</html>