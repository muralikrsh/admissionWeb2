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
	pst=con.prepareStatement("select course_id ,concat(course_group,concat(' - ',course_name)), course_duration, course_fees from course order by course_id");

	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString(1));
		alSub.add(rs.getString(2));
		alSub.add(rs.getString(3));
		alSub.add(rs.getString(4));
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
<title>Course List</title>
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
	<!-- <link rel="stylesheet" href="css/demodialog.css"> -->
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

		<script type="text/javascript" charset="utf-8">
			/* Data set - can contain whatever information you want */
			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (int i=0; i<alMain.size(); i++)	
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(5);
				aDataSet[<%=i%>][0]='<a href=\"javascript:viewCourseDetails(\'<%=alSub.get(0)%>\')\"><%=alSub.get(0)%></a>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';
				<%
				if(user_role.intern()=="ADMIN".intern() || user_role.intern()=="VC".intern()) { %>
					aDataSet[<%=i%>][4]='<a href=\'AddCourse.jsp?flag=U&course_id=<%=alSub.get(0)%>\'>Update</a>&nbsp;&nbsp;<a href=\'javascript:deleteCourse(\"<%=alSub.get(0)%>\")\'>Delete</a>';
				<% } 
			}
			alMain=null;
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Course ID" },
						{ "sTitle": "Course Name" },
						{ "sTitle": "Course Duration" },
						{ "sTitle": "Course Fees" },
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

		function deleteCourse(course_id) {
			if(confirm("Are you sure you want to delete")) {
			strURL="DeleteCourse.jsp";
			var job_id=encodeURIComponent(course_id);
			var parameters="course_id="+course_id;
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
			}
			//xmlHttp.send(strURL);
		}

		function showDeleteResult(message) {
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		document.getElementById("dialog-confirm1").innerHTML='Course Deleted Successfully';
		$( "#dialog-confirm1" ).dialog({
			resizable: false,
			height:140,
			modal: true,
			buttons: {
				"OK": function() {
					$( this ).dialog( "close" );
					location.href='CourseList.jsp';
				}
			}
		});

		}

		function viewCourseDetails(course_id) {
			strURL="GetCourseDetails.jsp";
			var course_id=encodeURIComponent(course_id);
			var parameters="course_id="+course_id;
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
<%@include file="MBHandler.jsp" %>
	</head>
	<!-- <body  id="dt_example" onLoad='javascript:hide()'> -->
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table width=90% align="center"%>
	<tr><td>&nbsp;</td></tr>
	<tr><td class="button navy gradient">Course List</td></tr>
	<tr><td>
	<div id="dialog-confirm1" title="Course Delete Result"></div>
	<div id="dialog-modal" title="Course Details">	</div>
	<div id="fieldset">
	<BR>
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