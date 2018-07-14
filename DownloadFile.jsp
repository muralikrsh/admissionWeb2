<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");
	pst=con.prepareStatement("select exam_id ,exam_title, exam_date, exam_time, exam_duration from exam_master");

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
<title>Download Document</title>
	<head>
	<meta charset="utf-8">
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.position.min.js"></script>
	<script src="ui/jquery.ui.dialog.js"></script>
	<script src="ui/jquery.dataTables.js"></script>
	<script src="ui/stuHover.js" type="text/javascript"></script>

	<link rel="stylesheet" href="css/jquery.ui.all.css">
	<link rel="stylesheet" href="css/demo_table.css">
	<link rel="stylesheet" href="css/demo_page.css">
	<link rel="stylesheet" href="css/demodialog.css">
	<link rel="stylesheet" type="text/css" href="css/pro_dropdown_2.css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

		<script type="text/javascript" charset="utf-8">
			/* Data set - can contain whatever information you want */
			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (int i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(7);
				aDataSet[<%=i%>][0]='<a href=\"javascript:viewExamDetails(\'<%=alSub.get(0)%>\')\"><%=alSub.get(0)%></a>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][5]='<a href=\'AddExam.jsp?flag=U&exam_id=<%=alSub.get(0)%>\'>Update</a>&nbsp;&nbsp;<a href=\'javascript:deleteExam(\"<%=alSub.get(0)%>\")\'>Delete</a>';
			<%
			}
			alMain=null;
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Exam ID" },
						{ "sTitle": "Exam Name" },
						{ "sTitle": "Exam Date" },
						{ "sTitle": "Exam Time" },
						{ "sTitle": "Duration" },
						{ "sTitle": "Action" }
					]
				} );	
		// Modal


			// Modal

			} );
	$(function() {
		// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		

	});

		function deleteExam(exam_id) {
			strURL="DeleteExam.jsp";
			var job_id=encodeURIComponent(exam_id);
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
					showDeleteResult(xmlHttp.responseText);
				}
			}

			//xmlHttp.send(strURL);
		}

		function showDeleteResult(message) {
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		document.getElementById("dialog-confirm1").innerHTML='Exam Deleted Successfully';
		$( "#dialog-confirm1" ).dialog({
			resizable: false,
			height:140,
			modal: true,
			buttons: {
				"OK": function() {
					$( this ).dialog( "close" );
					location.href='ExamList.jsp';
				}
			}
		});

		}

		function applyJob(exam_id) {
			strURL="ApplyJob.jsp";
			var job_id=encodeURIComponent(exam_id);
			var user_id=encodeURIComponent('<%=login_id%>');
			var parameters="job_id="+job_id+"&user_id="+user_id;
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
					showApplicationResult(xmlHttp.responseText);
				}
			}

			//xmlHttp.send(strURL);
		}

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


	function hide() {
		document.getElementById("dialog-confirm1").innerHTML='';
	}
	</script>

	</head>
	<body  id="dt_example" onLoad='javascript:hide()' style="height: 95%;">
	<div id='wrapper2'>
	<%@include file="CCMenu.jsp" %>
	<div id="dialog-confirm1" title="Exam Delete Result"></div>
	<div id="dialog-modal" title="Exam Details">	</div>
	<div id="fieldset">
	<BR>
	<form name='xxx'>
	<div id="container" align='left'>
		<div id="dynamic"></div>
		<div class="spacer"></div>
	</div>
	</form>
<%@include file="Footer.jsp" %>
</div>
	</body>
</html>
