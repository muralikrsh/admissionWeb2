<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
String msg=request.getParameter("msg");
String head="";
String path="";
String htcount="0";
String clcount="0";
String ilcount="0";
String appcount="0";
// String[] arr=msg.split("|");;
ArrayList alFields=new ArrayList();
StringTokenizer st=new StringTokenizer(msg,"|");
while(st.hasMoreTokens()) {
	alFields.add(st.nextToken());
}
try {
	
	// BHARTUNIV|1363718371523|MCIT2948070451|122313-724785|2.00|CIT|22270726|NA|NA|DIRECT|NA|NA|NA|20-03-2013 00:10:31|0300|NA|46|APP|Manoj|NA|NA|NA|NA|NA|Success|DAF94FD200094038D277E3E20AAB5AD6BB1C2BCBC0B9BDEA5C68E5446B9B75F9
	//for(int i=0; i< arr.length; i++) {
	//	System.out.println("arr["+i+"] -> "+arr[i]);
	//}
	

	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("select mkr_id, role, name, dept_id from application a, adm_login b where a.appn_no=? and a.mkr_id=b.id");
	pst.setString(1,(String)alFields.get(16));
	rs=pst.executeQuery();
	if(rs.next()) {
		session.setAttribute("role",rs.getString(2));
		session.setAttribute("dept_id",rs.getString(4));	
		session.setAttribute("login_id",rs.getString(1));
		session.setAttribute("login_name",rs.getString(3));
		user_role=rs.getString(2);
		login_id=rs.getString(1);
	}
	
}
catch(Exception e1){
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>

<html>
<title>eUniv - Home</title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="css/style.css" />
	<link rel="stylesheet" type="text/css" href="css/pro_dropdown_2.css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />
	<script src="ui/stuHover.js" type="text/javascript"></script>
	<script src="ui/jquery-latest.pack.js"></script>
</head>
<body>
	<div id='wrapper2'>
	<%@include file="CCMenu.jsp" %>
        <table width="100%"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
				<td colspan=2 width=90%>
					<table align=center>
					<tr>
						<td colspan=2>Transaction Status : <%= (alFields.get(14).toString().intern()=="0300".intern())?"SUCCESS":"FAILURE" %></td>
					</tr>
					<tr>
						<td colspan=2>Application Number :  <%= alFields.get(16).toString() %></td>
					</tr>
					<tr>
						<td colspan=2>Transaction Ref No : <%= alFields.get(2).toString() %></td>
					</tr>
				</table>

                </td>
				<td width=10%>&nbsp;</td>
            </tr>
        </table>
		<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
	<%@include file="Footer.jsp" %>
	</div>
</body>
</html>