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
                <td width=20%>
					<table>
					<tr><td align='middle'><img src="images/BIST.jpg" vspace="10" hspace="10" align="left" style="padding: 0px 12x;"></td></tr>
					</table>
				</td>
				<td width=70%>
					Sorry, The requested Resource is not Found
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