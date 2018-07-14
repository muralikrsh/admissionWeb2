<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
String type=request.getParameter("type");
String head="";
String path="";
String htcount="0";
String clcount="0";
String ilcount="0";
String appcount="0";
ArrayList alEventName=new ArrayList();
ArrayList alEventDate=new ArrayList();

if(session.getAttribute("role")==null)
		session.setAttribute("role",request.getParameter("role"));

try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");

	pst=con.prepareStatement("select event_name, from_date from event where from_date>now() order by from_date asc limit 5");
	rs=pst.executeQuery();

	while(rs.next()) {
		alEventName.add(rs.getString(1));
		alEventDate.add(rs.getString(2));
	}	


	if(user_role.intern()=="ADMIN".intern()) {
		pst=con.prepareStatement("select count(1) from application where appn_status='S'");
		rs=pst.executeQuery();
		if(rs.next()) 
			appcount=rs.getString(1);
	} else {
		pst=con.prepareStatement("SELECT (select count(1) from application where mkr_id=? and ht_no is not null),(select count(1) from application where mkr_id=?  and ht_no is not null and clgen_flag='Y'),(select count(1) from application where mkr_id=?  and ht_no is not null and ilgen_flag='Y') from dual");
		pst.setString(1, login_id);
		pst.setString(2, login_id);
		pst.setString(3, login_id);
		rs=pst.executeQuery();
		if(rs.next()) {
			htcount=rs.getString(1);
			clcount=rs.getString(2);
			ilcount=rs.getString(3);
		}
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

<script language="javascript">
function onlineAppUG() {
	alert("hi");
			window.location("SubmitApplication2.jsp?category=UG");
		}
		
		function onlineAppPG() {
			postRequest("SubmitApplication2.jsp?category=PG");
		}
		</script>

<%@include file="MBHandler.jsp" %>
</head>
<body>
<%@include file="CCMenu.jsp" %>
<div class="content_container">
        <table width="100%">
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
            <tr>
                <!-- <td width=20%>
					<table>
					<tr><td align='middle'><img src="images/BIST.jpg" vspace="10" hspace="10" align="left" style="padding: 0px 12x;"></td></tr>
					</table>
				</td> -->
				<td width="50%" align="center" valign="middle">
				<table align=center>
				<% if(user_role.intern()=="STUDENT".intern()) { %>
					<tr>
					<td class="button navy gradient" style="text-align:center "colspan=2>APPLY ONLINE
					</td>
					</tr>
					<tr>
					<td class="button" style='font-size:20px;'><a href="SubmitApplication2.jsp?category=UG">Application - UG</a></td>
					<td class="button" style='font-size:20px'><a href="SubmitApplication2.jsp?category=PG">Application - PG</a></td>
					</tr>
				<% }else if(user_role.intern()=="ADMIN".intern()) { %>
				</table>

                </td>
				<td width=50% align="center" valign="middle">
					<table align=center>
					<tr><td class="button navy gradient" colspan=2>Notifications</td></tr>
					<tr>
						<td colspan=2>&nbsp;</td>
					</tr>
					
					<tr><td colspan=2>You have <%=appcount%> applications to review and approve</td>
					<td class="button" style='font-size:20px'><a href="SearchApplications.jsp">Review & Approve</a></td>
					</tr>
					<% } else { %>
					<tr><td colspan=2>You have <%=htcount%> Hall Ticket(s) for download</td></tr>
					<tr><td colspan=2>You have <%=clcount%> Counseling Letter(s) for download</td></tr>
					<tr><td colspan=2>You have <%=ilcount%> Intimation Letter(s) for download</td></tr>
					<% } %>					
				</table>

                </td>

				<!-- <td width=10%>&nbsp;</td> -->
            </tr>
        </table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>