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
String strHallTicket="";
String strStudentName="";
String strMobileOne="";
String strMobileTwo="";
String strRank="";
String flag="";

String submitted_by=(String)session.getAttribute("login_name");

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {

	} else {
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		while (itr.hasNext()) 
		{
			FileItem item = (FileItem) itr.next();
			if (item.isFormField())
			{
			String name = item.getFieldName();
			String value = item.getString();
			System.out.println("Field "+name+ "<>"+value);
			if(name.equals("flag")) {
				flag=value;
			}
			if(name.equals("ht_no")) {
				strHallTicket=value;
			}
			if(name.equals("stu_name")) {
				strStudentName=value;
			}
			if(name.equals("mobile_1")) {
				strMobileOne=value;
			}
			if(name.equals("rank")) {
				strRank=value;
			}
			if(name.equals("mobile_2")) {
				strMobileTwo=value;
			}
			}
			else	
			{
				System.out.println("File Recd");
			}
		}
	}
	try {
		con=ConnectDatabase.getConnection();

		pst=con.prepareStatement("update rank_list set ht_no=?, stu_name=?, mobile_no_1=?, mobile_no_2=?, mkr_id=?, mkr_dt=now() where rank=?");
		
		pst.setString(1,strHallTicket);
		pst.setString(2,strStudentName);
		pst.setString(3,strMobileOne);
		pst.setString(4,strMobileTwo);
		pst.setString(5,submitted_by);
		pst.setString(6,strRank);
		
		pst.executeUpdate();
		System.out.println(pst);
		con.commit();
		message= "Details Modified Successfully";
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
<title>Student Rank Details</title>
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
		location.href='StudentRankList.jsp';
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