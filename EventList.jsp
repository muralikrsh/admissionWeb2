<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String role2=(String)session.getAttribute("role");
try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	String query="select event_id , event_name, date_format(from_date,'%d-%b-%Y'), date_format(to_date,'%d-%b-%Y'), event_time, event_venue,date_format(from_date,'%Y-%m-%d') from event order by from_date desc";
	System.out.println(con);
	pst=con.prepareStatement(query);
	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString(1));
		alSub.add(rs.getString(2));
		alSub.add(rs.getString(3));
		alSub.add(rs.getString(4));
		alSub.add(rs.getString(5));
		alSub.add(rs.getString(6));
		alSub.add(rs.getString(7));
		alMain.add(alSub);
	}
}
catch(Exception e1){
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null; rs=null;
}
%>
<!DOCTYPE html>
<html>
<title>Event List</title>
	<head>
	<meta charset="utf-8">
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/demo_table.css">
	<!-- <link rel="stylesheet" href="css/demodialog.css"> -->
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <!-- <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" /> -->
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

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



	<script type="text/javascript" charset="utf-8">

		var aDataSet = new Array(<%=alMain.size()%>);
		<%		
		for (int i=0; i<alMain.size(); i++)
		{
			ArrayList alSub=(ArrayList)alMain.get(i);
			System.out.println(alSub.get(0));
		%>
			aDataSet[<%=i%>]=new Array(7);
			aDataSet[<%=i%>][0]='<a href="javascript:viewEventDetails(\'<%=alSub.get(0)%>\')"><%=alSub.get(1)%></a>';
			aDataSet[<%=i%>][1]='<%=alSub.get(2)%>';
			aDataSet[<%=i%>][2]='<%=alSub.get(3)%>';
			aDataSet[<%=i%>][3]='<%=alSub.get(4)%>';
			aDataSet[<%=i%>][4]='<%=alSub.get(5)%>';
			<% if(role2.intern()=="ADMIN".intern()) { %>
			aDataSet[<%=i%>][5]='<a href=\'javascript:updateEvent(\"<%=alSub.get(0)%>\")\'>Update</a>&nbsp;<a href=\'javascript:deleteEvent(\"<%=alSub.get(0)%>\")\'>Delete</a>';
			<% } else { %>
			aDataSet[<%=i%>][5]='N.A';
			<% } %>
			aDataSet[<%=i%>][6]='<%=alSub.get(6)%>';
		<%
		}
		%>

		$(document).ready(function() {
				
			$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
			$('#example').dataTable( {
				"aaData": aDataSet,
				"aoColumns": [
					{ "sTitle": "Event Title" },
					{ "sTitle": "From Date", "bSortable": false  },
					{ "sTitle": "To Date", "bSortable": false },
					{ "sTitle": "Event Time" },
					{ "sTitle": "Venue" },
					{ "sTitle": "Action" },
					{"bVisible": false}
				],
				"aaSorting": [[ 6, "desc" ]]

			} );	
		} );
		$(function() {
			$( "#dialog:ui-dialog" ).dialog( "destroy" );
		});
		function viewEventDetails(ev_id) {
			strURL="GetEventDetails.jsp";
			var event_id=encodeURIComponent(ev_id);
			var parameters="event_id="+event_id;
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatepage(xmlHttp.responseText);
				}
			}

			xmlHttp.send(strURL);
		}

		function updatepage(str){
			$( "#dialog-modal" ).dialog({
				height: 500,
				width: 500,
				top: 300,
				modal: true
			});
			document.getElementById("dialog-modal").innerHTML=	str;
		}
		function deleteEvent(eventid) {
			strURL="DeleteEvent.jsp";
			var event_id=encodeURIComponent(eventid);
			var parameters="event_id="+event_id;
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					showDeleteResult(xmlHttp.responseText);
				}
			}

			//xmlHttp.send(strURL);
		}

		function updateEvent(eventid) {
			strURL="AddEvent.jsp?";
			var event_id=encodeURIComponent(eventid);
			var parameters="event_id="+event_id+"&flag=U";
			location.href=strURL+parameters;
		}

		function showDeleteResult(message) {
			$( "#dialog:ui-dialog" ).dialog( "destroy" );
			document.getElementById("dialog-confirm1").innerHTML='Event Deleted Successfully';
			$( "#dialog-confirm1" ).dialog({
				resizable: false,
				height:140,
				modal: true,
				buttons: {
					"OK": function() {
						$( this ).dialog( "close" );
						location.href='EventList.jsp';
					}
				}
			});
		}

	</script>
	<%@include file="MBHandler.jsp" %>
	</head>

	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p10 textarea_normal" style="width: 90%">
	<tr><td>&nbsp;</td></tr>
	<tr><td class="button navy gradient">Event List</td></tr>
	<tr><td>
	<div id="dialog-confirm1" title="Result"></div>
	<div id="dialog-modal" title="Event Details">	</div>
	<div id="fieldset">
	<BR>
	<form name='xxx'>
	<div id="container" align='left'>
		<div id="dynamic"></div>
		<div class="spacer"></div>
	</div>
	</form>
	</td>
	</tr>
	</table>
	<br><br><br><br><br>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>