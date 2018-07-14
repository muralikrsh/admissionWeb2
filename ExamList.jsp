<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
String category=request.getParameter("category");
System.out.println("category="+category);

try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");
	// String category_clause=(category==null)?"":" where category=?";
	if(user_role.intern()=="STUDENT".intern() ) {
		pst=con.prepareStatement("select exam_id ,exam_title, exam_date, exam_time, exam_duration,status from exam_master where status='A' and category=?");
	} else if (user_role.intern()=="ADMIN".intern()) {
		if(category==null)
			pst=con.prepareStatement("select exam_id ,exam_title, exam_date, exam_time, exam_duration,status from exam_master where status='A' ");
		else
		pst=con.prepareStatement("select exam_id ,exam_title, exam_date, exam_time, exam_duration,status from exam_master where status='A' and category=?");
	}
	else if(user_role.intern()=="VC".intern() ) {
		pst=con.prepareStatement("select exam_id ,exam_title, exam_date, exam_time, exam_duration, status from exam_master");

	}
	if(category!=null)
		pst.setString(1,category);

	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString(1));
		alSub.add(rs.getString(2));
		alSub.add(rs.getString(3));
		alSub.add(rs.getString(4));
		alSub.add(rs.getString(5));
		alSub.add(rs.getString(6));
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
<title>Exam List</title>
	<head>
	<meta charset="utf-8">

	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="css/demo_table.css" rel="stylesheet" >
	<link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
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
				<%
				if(user_role.intern()=="VC".intern()) { 
					if(alSub.get(5).toString().intern()=="U".intern()) {
					%>
					aDataSet[<%=i%>][5]='<a href=\'AddExam.jsp?flag=U&exam_id=<%=alSub.get(0)%>\'>Update</a>&nbsp;&nbsp;<a href=\'javascript:deleteExam(\"<%=alSub.get(0)%>\")\'>Delete</a>&nbsp;&nbsp;<a href=\'javascript:approveSyllabus(\"<%=alSub.get(0)%>\",\"A\")\'>Approve Syllabus</a>&nbsp;&nbsp;<a href=\'javascript:approveSyllabus(\"<%=alSub.get(0)%>\",\"R\")\'>Reject Syllabus</a>';
				<% } else {%>
					aDataSet[<%=i%>][5]='<a href=\'AddExam.jsp?flag=U&exam_id=<%=alSub.get(0)%>\'>Update</a>&nbsp;&nbsp;<a href=\'javascript:deleteExam(\"<%=alSub.get(0)%>\")\'>Delete</a>';
				<% } 
				} else if(user_role.intern()=="STUDENT".intern() || (user_role.intern()=="ADMIN".intern() & category!=null) ) {%>
					aDataSet[<%=i%>][5]='<a href="SubmitApplication2.jsp?category=<%=category%>&exam_id=<%=alSub.get(0)%>">Apply</a>';
				<%  
				}
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
						<%	if(user_role.intern()=="VC".intern() || user_role.intern()=="STUDENT".intern() || (user_role.intern()=="ADMIN".intern() & category!=null)) { %>
						{ "sTitle": "Duration <br>(Minutes)" },
						{ "sTitle": "Action" }
						<% } else { %>
						{ "sTitle": "Duration <br>(Minutes)" }
						<% }  %>
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
			if(confirm("Are you sure you want to delete")) {
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
			}
			//xmlHttp.send(strURL);
		}

		function approveSyllabus(exam_id, flag) {
			strURL="ApproveSyllabus.jsp";
			var eid=encodeURIComponent(exam_id);
			var parameters="exam_id="+eid+"&flag="+flag;
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
					showApproveResult(xmlHttp.responseText, flag);
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

		function showApproveResult(message, flag) {
		$( "#dialog:ui-dialog" ).dialog( "destroy" );
		document.getElementById("dialog-confirm1").innerHTML=message;
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
	<%@include file="MBHandler.jsp" %>
	</head>
	<!-- <body  id="dt_example" onLoad='javascript:hide()'> -->
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

	<table width=90% align="center" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td>&nbsp;</td></tr>
	<tr><td class="button navy gradient">Exam List</td></tr>
	<tr><td>
	<div id="dialog-confirm1" title="Result"></div>
	<div id="dialog-modal" title="Exam Details">	</div>
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
	<br><br><br><br><br><br><br><br>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>