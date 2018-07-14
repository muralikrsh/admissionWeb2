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
System.out.println("Response from Billdesk " +msg);
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
	//Added by Alexpandiyan. S.O.P only
	System.out.println("number: "+(String)alFields.get(14));
	System.out.println("ref_no: "+(String)alFields.get(2));
	System.out.println("app_no: "+(String)alFields.get(16));

	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("select mkr_id, role, name, dept_id from application a, adm_login b where a.appn_no=? and a.mkr_id=b.id");
	pst.setString(1,(String)alFields.get(16));
	System.out.println("Session payment: "+pst);
	rs=pst.executeQuery();
	if(rs.next()) {
		session.setAttribute("role",rs.getString(2));
		session.setAttribute("dept_id",rs.getString(4));	
		session.setAttribute("login_id",rs.getString(1));
		session.setAttribute("login_name",rs.getString(3));
		user_role=rs.getString(2);
		login_id=rs.getString(1);
	}
	pst=con.prepareStatement("update application set pay_status=?, pay_ref_no=? where appn_no=?");
	if(alFields.get(14).toString().intern()=="0300".intern())
		pst.setString(1,"C");
	else
		pst.setString(1,"N");
	pst.setString(2,(String)alFields.get(2));
	pst.setString(3,(String)alFields.get(16));
	System.out.println("Update pay_status: "+pst);
	pst.executeUpdate();
	con.commit();	
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>

<!DOCTYPE html>
<html>
<title>eUniv - Home</title>
<head>
    <meta charset="utf-8">
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="Scripts/hoverIntent.js" type="text/javascript"></script>

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />



<%@include file="MBHandler.jsp" %>
</head>
<body>
<%@include file="CCMenu.jsp" %>
<div class="content_container">	
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
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>