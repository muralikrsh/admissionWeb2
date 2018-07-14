<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>

<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
String sNo="";

try {
	con=ConnectDatabase.getConnection();
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");
	pst=con.prepareStatement("SELECT act_dt,NAME,email_id,mobile_no,u_key FROM adm_login where role='student'");

	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString(1));
		alSub.add(rs.getString(2));
		alSub.add(rs.getString(3));
		alSub.add(rs.getString(4));
		alSub.add(rs.getString(5));
		alMain.add(alSub);
	}
//	System.out.println("list : "+alMain);
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
<title>Student Registration List</title>
	<head>
	<meta charset="utf-8">


	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.position.min.js"></script>
	<script src="ui/jquery.ui.dialog.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.dataTables.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>

	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/demo_table.css">
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

		<script type="text/javascript" charset="utf-8">
			var aDataSet = new Array(<%=alMain.size()%>);
			
			<%		
			for (int i=0; i<alMain.size(); i++)	
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
			
				aDataSet[<%=i%>]=new Array(5);
				aDataSet[<%=i%>][0]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][1]='<%=alSub.get(0)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(3)%>';
				<%
				if(sNo.intern()=="".intern()) {
					sNo=alSub.get(4).toString();
				} else {
					sNo+=","+alSub.get(4).toString();
				}
			}
			alMain=null;
			%>
			
			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aaSorting": [[0, 'desc']],
					"aoColumns": [
						{ "sTitle": "S.No" },
						{ "sTitle": "Reg.Date" },
						{ "sTitle": "Name" },
						{ "sTitle": "Email" },
						{ "sTitle": "Mobile" }
					]
				} );	
			} );
	$(function() {
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
	});

		function updatepage(str){
		$( "#dialog-modal" ).dialog({
			height: 500,
			width: 500,
			modal: true
		});
		document.getElementById("dialog-modal").innerHTML=	str;
		}
		
		function exportExcel() 
		{
			var strURL="servlet/RegistrationListExcel";
			var parameters="profile_id=<%=sNo%>";
			strURL+="?"+parameters;
			location.href=strURL;
			//alert(parameters);
		}
		
	</script>
<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table width=90% align="center"%>
	<tr><td>&nbsp;</td></tr>
	<tr><td class="button navy gradient">Student Registration List</td></tr>
	<tr><td>
	<div id="dialog-modal" title="Registration List">	</div>
	<div id="fieldset">
	<BR>
	<form name='xxx'>
	<div id="container" align='left'>
		<div id="dynamic"></div>
		<div class="spacer"></div>
	</div>
	<tr>
	<td align=right>
	<input type="button" class="clickButton" value="Export to Excel" onClick="javascript:exportExcel()"/>&nbsp;
	</td>
	</tr>
	</form>
	</div>
	</td>
	</tr>
	</table>
	<br>
			<br>
			<br>
			<br>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>