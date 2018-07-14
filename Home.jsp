<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null, pstMaker=null;
ResultSet rs=null, rsMaker=null;
String user_role="";
String login_id="";
String type=request.getParameter("type");
String head="";
String path="";
String htcount="0";
String clcount="0";
String ilcount="0";
String appcount="0";

String strAppNo="";
String strPaymentStatus="";
String strFirstName="";
String strIntAppNo="";
String pay_status="";
String strCourse="";
String strDegree="";

if(session.getAttribute("role")==null)
		session.setAttribute("role",request.getParameter("role"));

try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");

	pstMaker=con.prepareStatement(" SELECT degree FROM adm_login WHERE id=? ");
	
	pstMaker.setString(1, login_id);
	rsMaker=pstMaker.executeQuery();
	
	while(rsMaker.next())
	{
		strDegree=rsMaker.getString(1);
	}
	System.out.println(strDegree);
	pstMaker=null;
	System.out.println("login_id="+login_id);
	pstMaker=con.prepareStatement(" SELECT f_appn_no, pay_status, first_name, appn_no, course FROM application ap, adm_login al WHERE ap. mkr_id=al.id AND BINARY mkr_id=? ");
	
	pstMaker.setString(1, login_id);
		System.out.println("Home pstMaker= "+pstMaker);
	rsMaker=pstMaker.executeQuery();
	
	while(rsMaker.next())
	{
		strAppNo=rsMaker.getString(1);
		strPaymentStatus=rsMaker.getString(2);
		strFirstName=rsMaker.getString(3);
		strIntAppNo=rsMaker.getString(4);
		strCourse=rsMaker.getString(5);
	}
System.out.println(strPaymentStatus);
if (strPaymentStatus.intern()=="N".intern() || strPaymentStatus.intern()=="I".intern() || strPaymentStatus.intern()=="S".intern()){
pay_status="Not paid";
}
else{
	pay_status="Paid";
}
	if(user_role.intern()=="ADMIN".intern()) {
		pst=con.prepareStatement("select count(1) from application where appn_status='S'");
		rs=pst.executeQuery();
		if(rs.next()) 
			appcount=rs.getString(1);
	} else {
		pst=con.prepareStatement("SELECT (select count(1) from application where binary mkr_id=? and ht_no is not null),(select count(1) from application where binary mkr_id=?  and ht_no is not null and clgen_flag='Y'),(select count(1) from application where binary mkr_id=? and ht_no is not null and ilgen_flag='Y') from dual");
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
<title>Bharath Uiversity - Home</title>
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
		function onlineAppUG() 
		{
			window.location("SubmitApplication2.jsp?category=UG");
		}
		
		function onlineAppPG() 
		{
			postRequest("SubmitApplication2.jsp?category=PG");
		}
		
		function submitApp()
		{
			postRequest("SaveApplicationResult.jsp");
		}
		
		function submitArtsApp()
		{
			postRequest("SaveArtsApplicationResult.jsp");
		}

	
		function postRequest(strURL) 
		{
			
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			
			
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			
			xmlHttp.send("&appNo="+document.getElementById("appNo").value+"&appfee_flag="+document.getElementById("appfee_flag").value+"&firstName="+document.getElementById("firstName").value+"&intAppNo="+document.getElementById("intAppNo").value);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatePage(xmlHttp.responseText);
				}
			}
		}
		
		function updatePage(str)
		{
						var arr=str.split("~");
			
					document.payform.msg.value=arr[2].trim();
					//alert(document.payform.msg.value);
					document.payform.submit();

			document.payform.submit();
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
			<input name="appNo" id="appNo" type="hidden" value="<%=strAppNo%>"/>
			<input name="appfee_flag" id="appfee_flag" type="hidden" value="O"/>
			<input name="firstName" id="firstName" type="hidden" value="<%=strFirstName%>"/>
			<input name="intAppNo" id="intAppNo" type="hidden" value="<%=strIntAppNo%>"/>

            <tr>
				<table align=center>
				<% if(user_role.intern()=="STUDENT".intern())
					{
						if( strAppNo=="" )
						{
							if(strDegree.equals("1"))  { %>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center; font-size:25px">ENGINEERING APPLICATION</td>
					</tr>
					<tr><td><br></td></tr>
					<tr align="center">
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ONLINE
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitApplication2.jsp?degree=Engr&category=UG">Click Here</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG</a></td><td class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitApplication2.jsp?degree=Engr&category=PG">Click Here</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> OFFLINE
						<tr>
						<td class="gradient" style="text-align:center;font-size:18px">PDF</a><td colspan=3 class="button gradient" style="text-align:center;font-size:18px"><a href="engineering_appn_form.pdf">DOWNLOAD</a>
						</tr>
					</td>
					</tr>
					<% }
					else if(strDegree.equals("2")) { %>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center; font-size:25px">ARCHITECTURE APPLICATION</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ONLINE
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitApplication2.jsp?degree=Arch&category=UG">CLICK HERE</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitApplication2.jsp?degree=Arch&category=PG">CLICK HERE</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> OFFLINE
						<tr>
						<td class="gradient" style="text-align:center;font-size:18px">PDF</a><td colspan=3 class="button gradient" style="text-align:center;font-size:18px"><a href="architecture_appn_form.pdf">DOWNLOAD</a>
						</tr>
					</td>
					</tr>
					<%} else if(strDegree.equals("3")) { %>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center; font-size:25px">ARTS & SCIENCE APPLICATION</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ONLINE
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitApplication2.jsp?degree=Arts&category=UG">CLICK HERE</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG & M.Phil</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitApplication2.jsp?degree=Arts&category=PG">CLICK HERE</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> OFFLINE
						<tr>
						<td class="gradient" style="text-align:center;font-size:18px">PDF</a><td colspan=3 class="button gradient" style="text-align:center;font-size:18px"><a href="arts_science_appn_form.pdf">DOWNLOAD</a>
						</tr>
					</td>
					</tr>
					<% } else if(strDegree.equals("4")) {%>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center; font-size:25px">MBA / MCA APPLICATION</td>
					</tr>
					<tr><td><br></td></tr>
					<tr align="center">
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ONLINE
						<tr><td colspan=4 class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitApplication2.jsp?degree=Mgmt&category=PG">Click Here</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> OFFLINE
						<tr>
						<td class="gradient" style="text-align:center;font-size:18px">PDF</a><td colspan=3 class="button gradient" style="text-align:center;font-size:18px"><a href="management_appn_form.pdf">DOWNLOAD</a>
						</tr>
					</td>
					</tr>

					<% }
					}
					else if(strPaymentStatus.intern()=="C".intern())
					{
					%>
					<table class="valign_top textbox_medium tbl_p5 textarea_normal" width="50%">
                   <tr><td colspan=2 class="button navy gradient">	Application details</td></tr>
        			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label"><font color="red">Application number </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=strAppNo%> </td>
			<tr>
			<td class="label"><font color="red">Payment status </font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=pay_status%></td>
			<tr><td></td></tr>
			</tr>
			<td  style="font-size:15px"><a href="ApproveApplication2.jsp?appn_no=<%=strIntAppNo%>&flag=U">View Application</a></td>
			</tr>
			</table>
			<%	}	else {	%>
			<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="50%">
            <tr><td colspan=2 class="button navy gradient">	Application details</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label"><font color="red">Application number</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=strAppNo%> </td>
			<tr>
			<td class="label"><font color="red">Payment status </font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<%=pay_status%> </td>
			</tr>
			<% if( strCourse.intern()=="BA" || strCourse.intern()=="B.Sc" || strCourse.intern()=="B.Com" || strCourse.intern()=="BBA" || strCourse.intern()=="BCA" || strCourse.intern()=="M.Sc" || strCourse.intern()=="MCA" || strCourse.intern()=="MBA" || strCourse.intern()=="M.Phil" ) { %>
			<tr><td><input type="button" class="clickButton" value="Make Payment" onClick="javascript:submitArtsApp()"/><td>
			<td class="clickButton" ><a href="ApproveApplication2.jsp?appn_no=<%=strIntAppNo%>&flag=U">View Application</a></td>
			</tr>
			<%	}	else {	%>
			<tr><td><input type="button" class="clickButton" value="Make Payment" onClick="javascript:submitApp()"/><td>
			<td class="clickButton" ><a href="ApproveApplication2.jsp?appn_no=<%=strIntAppNo%>&flag=U">View Application</a></td>
			</tr>
			<%	}%>
			</table>
					<%
					}}
					else if(user_role.intern()=="ADMIN".intern()) { %>
				              
					<table align=center>
					<tr><td class="button navy gradient" colspan=2>Notifications</td></tr>
					<tr>
						<td colspan=2>&nbsp;</td>
					</tr>
					
					<tr><td colspan=2>You have <%=appcount%> applications to review and approve</td></tr>
					<tr><td class="button" style='font-size:20px'><a href="SearchApplications.jsp">Review & Approve</a></td>
					</tr>
					</table>
					<%}
						else if(user_role.intern()=="OFFLINE".intern()) {
						%>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center; font-size:25px">OFFLINE APPLICATION</td>
					</tr>
					<tr><td><br></td></tr>
					<tr align="center">
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ENGINEERING
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitManualApplication2.jsp?degree=Engr&category=UG">Click Here</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG</a></td><td class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitManualApplication2.jsp?degree=Engr&category=PG">Click Here</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ARCHITECTURE
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitManualApplication2.jsp?degree=Arch&category=UG">CLICK HERE</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitManualApplication2.jsp?degree=Arch&category=PG">CLICK HERE</a></td></tr>
					</td>
					<tr><td><br></td></tr>
					<tr>
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> ARTS & SCIENCE
						<tr><td class="gradient" style="text-align:center;font-size:18px">UG</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitManualApplication2.jsp?degree=Arts&category=UG">CLICK HERE</a></td></tr>
						<tr><td class="gradient" style="text-align:center;font-size:18px">PG & M.Phil</a></td><td class="button gradient" style="text-align:center;font-size:20px"><a href="SubmitManualApplication2.jsp?degree=Arts&category=PG">CLICK HERE</a></td></tr>
					</td>
					</tr>
					<tr><td><br></td></tr>
					<tr align="center">
					<td colspan=4 class="button navy gradient" style="text-align:center;font-size:18px"> MBA / MCA
						<tr><td colspan=4 class="button gradient" style="text-align:center;font-size:25px"><a href="SubmitManualApplication2.jsp?degree=Mgmt&category=PG">Click Here</a></td></tr>
					</td>
					</tr>
					<%}%>
                </td>

				<!-- <td width=10%>&nbsp;</td> -->
            </tr>
			
			<form name='payform' id='payform' action="https://www.billdesk.com/pgidsk/PGIMerchantPayment" method="POST">
			<input type="hidden" name="msg" id="msg"/>
			</form>

        </table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>