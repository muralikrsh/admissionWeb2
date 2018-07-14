<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Connection con = null;
PreparedStatement pst = null;
String message="";

String strAllotNo=request.getParameter("AllotNo");
String strStuName=request.getParameter("StudentName");
String strParentName=request.getParameter("ParentName");

	try {
		con=ConnectDatabase.getConnection();

		pst=con.prepareStatement("update student_admission set stu_name=?, par_name=? where full_adm_no=?");
		
		pst.setString(1,strStuName);
		pst.setString(2,strParentName);
		pst.setString(3,strAllotNo);
		
		pst.executeUpdate();
		con.commit();
		message= "Allotment Detail Updated Successfully";
	}
	catch(Exception e1){
		e1.printStackTrace();
		message="Error while Creating Data";
	}
	finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
	}
	%>
<!DOCTYPE html>
<html>
<title>Student Allotment Update</title>
	<head>
	<meta charset="utf-8">

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>


	<script type="text/javascript" charset="utf-8">
	function getCourseList() {
		location.href='StudentAllotmentList.jsp';
	}

	$(document).ready(function(){
	displayAlert('<%= message%>', getCourseList);
	});
		
	</script>
<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	   <div id="dialog-message" style="display:none;" title="Add Course"><p id="diaMsg" style="width:auto;"></p></div>
	</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>