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
	String exam_id="";
	String itemName =""; 
	String submitted_by=(String)session.getAttribute("login_id");
	String SYLLABUS_PATH="c:\\syllabus\\"; // (String)application.getAttribute("SYLLABUS_PATH");
	System.out.println("Path <> "+SYLLABUS_PATH);
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

				if(name.equals("exam_id")) {
					exam_id=value;
				}
			} 
			else	
			{
				
				try {
					itemName = item.getName();
					System.out.println("Path : "+SYLLABUS_PATH+(exam_id.replace("/","_"))+".pdf");
					File savedFile = new File(SYLLABUS_PATH+(exam_id.replace("/","_"))+".pdf");
					item.write(savedFile);
					message="File uploaded Successfully";
				} catch (Exception e) {
					e.printStackTrace();
					message="<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;Excel upload failed "+e.toString();
				}
			}
		}


		try{
			con=ConnectDatabase.getConnection();
			con.setAutoCommit(false);
			pst=con.prepareStatement("update exam_master set status='U' where exam_id=?");
			pst.setString(1,exam_id);
			pst.executeUpdate();
			con.commit();
		}	
		catch(Exception e1){
			e1.printStackTrace();
			message="File Upload failed. Please retry after sometime / check with administrator";
		}
		finally {
			if(con!=null)
				con.close();
			con=null; pst=null;
		}

	}

	%>
<!DOCTYPE html>
<html  style="height: 95%;">
<title>Upload Syllabus Result</title>
	<head>
	<meta charset="utf-8">
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link rel="stylesheet" href="css/jquery.ui.all.css">
	<link rel="stylesheet" href="css/demodialog.css">

	<script type="text/javascript" charset="utf-8">
	$(function() {
		// $( "#dialog:ui-dialog" ).dialog( "destroy" );
		document.getElementById("dialog-confirm1").innerHTML="<%= message%>";
		$( "#dialog-confirm1" ).dialog({
			resizable: false,
			height:140,
			modal: true,
			buttons: {
				"OK": function() {
					$( this ).dialog( "close" );
					location.href='UploadSyllabus.jsp?exam_id=<%=exam_id%>';
				}
			}
		});;
		

	});

<%@include file="MBHandler.jsp" %>
	</head>
	<body  id="dt_example">
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<div id="dialog-confirm1" title="Entrance Exam Ranks Upload Result"></div>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>