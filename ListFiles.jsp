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

if(type.intern()=="HT".intern())
	path="HALLTICKET_PATH";
if(type.intern()=="CL".intern())
	path="COUNSELINGLETTER_PATH";
if(type.intern()=="IL".intern())
	path="INTIMATIONLETTER_PATH";
if(type.intern()=="SY".intern())
	path="SYLLABUS_PATH";
if(type.intern()=="AF".intern())
	path="AF_PATH";


try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");
	if(type.intern()=="HT".intern()) {
		head="Hall Ticket No";
		pst=con.prepareStatement("select exam_title, appn_no, ht_no from application a, exam_master b where a.ht_no is not null and a.mkr_id=? and  a.exam_id=b.exam_id");
		pst.setString(1, login_id);
	}
	if(type.intern()=="CL".intern() ) {
		head="Rank";
		pst=con.prepareStatement("select exam_title, appn_no, rank from application a, exam_master b, rank_list c where a.ht_no is not null and a.ht_no=c.ht_no and a.mkr_id=? and  a.exam_id=b.exam_id and a.clgen_flag ='Y'");
		pst.setString(1, login_id);
	}
	if(type.intern()=="IL".intern() ) {
		head="Rank";
		pst=con.prepareStatement("select exam_title, appn_no, rank from application a, exam_master b, rank_list c where a.ht_no is not null and a.ht_no=c.ht_no and a.mkr_id=? and  a.exam_id=b.exam_id and a.ilgen_flag ='Y'");
		pst.setString(1, login_id);
	}	
	if(type.intern()=="AF".intern() ) {
		head="Candidate Name";
		pst=con.prepareStatement("select exam_title, appn_no, first_name from application a, exam_master b where a.mkr_id=? and  a.exam_id=b.exam_id and a.afl_flag ='Y'");
		pst.setString(1, login_id);
	}	
	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString(1));
		alSub.add(rs.getString(2));
		alSub.add(rs.getString(3));
		alMain.add(alSub);
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
<title>Download <%= (type.intern()=="HT".intern())?"Hall Ticket":(type.intern()=="CL".intern())?"Counseling Letter":(type.intern()=="IL".intern())?"Intimation Letter":"Application Form" %></title>
	<head>
	<meta charset="utf-8">

	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link rel="stylesheet" href="css/demo_table.css">
	<link rel="stylesheet" href="css/demodialog.css">
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
	<!-- <link rel="stylesheet" href="css/jquery.ui.all.css"> -->
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <!-- <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" /> -->
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" type="text/css" href="css/button-style.css" />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />


	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.position.min.js"></script>
	<script src="ui/jquery.ui.dialog.js"></script>
	<script src="ui/jquery.dataTables.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>


		<script type="text/javascript" charset="utf-8">
			/* Data set - can contain whatever information you want */
			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (int i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(4);
				aDataSet[<%=i%>][0]='<%=alSub.get(0)%>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<a href=javascript:getFile(\'<%=alSub.get(1)%>.html.pdf\')>Download</a>';
			<%
			}
			alMain=null;

			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Exam Name" },
						{ "sTitle": "Application No" },
						{ "sTitle": "<%=head%>" },
						{ "sTitle": "Download" }
					]
				} );	
		// Modal


			// Modal

			} );
	$(function() {
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		

	});

		function getFile(ht_no) {
			strURL="DownloadFile";
			var path='<%=   path %>'
			var parameters="ht_no="+ht_no+"&path="+path+"&req_id=HT";
			// var winopen=window.open(strURL+"?"+parameters);
			location.href=strURL+"?"+parameters;
			/*
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			*/
			/*
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					showApplicationResult(xmlHttp.responseText);
				}
			}
			*/
			//xmlHttp.send(strURL);
		}
/*
		function viewExamDetails(exam_id) {
			strURL="GetExamDetails.jsp";
			var exam_id=encodeURIComponent(exam_id);
			var parameters="exam_id="+exam_id;

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
			//xmlHttp.send(strURL);
		}

		function updatepage(str){
		$( "#dialog-modal" ).dialog({
			height: 500,
			width: 500,
			modal: true
		});
		document.getElementById("dialog-modal").innerHTML=	str;
		}
*/

	function hide() {
		document.getElementById("dialog-confirm1").innerHTML='';
	}
	</script>
<%@include file="MBHandler.jsp" %>
	</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
		<tr><td>&nbsp;</td></tr>	
		<tr><td class="button navy gradient">Download <%= (type.intern()=="HT".intern())?"Hall Ticket":(type.intern()=="CL".intern())?"Counseling Letter":"Intimation Letter" %></td></tr>	
		<tr><td>&nbsp;</td></tr>	
		<tr>
			<td>
				<div id="dialog-modal" title="Exam Details">	</div>
				<div id="fieldset">
				<form name='xxx'>
				<div id="container" align='left'>
					<div id="dynamic"></div>
					<div class="spacer"></div>
				</div>
				</form>
				</div>
			</td>
		</tr>
		</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>