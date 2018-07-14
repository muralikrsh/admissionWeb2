<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String message="";
String student_id="";
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
				System.out.println("field name "+name);

				String value = item.getString();
				System.out.println("field value "+value);
				if(name.equals("student_id")) {
					student_id=value;
				}
			} 
			else	
			{
				
				try {
					String itemName = item.getName();
					String PHOTO_PATH=(String)application.getAttribute("PHOTO_PATH");
					System.out.println("Path : "+PHOTO_PATH+student_id+".jpg");
					//File savedFile = new File(config.getServletContext().getRealPath("/")+"students\\photos\\"+student_id+".jpg");
					File savedFile = new File(PHOTO_PATH+student_id+".jpg");
					item.write(savedFile);
					message="Photo uploaded Successfully";
				} catch (Exception e) {
					e.printStackTrace();
					message="Photo upload failed";
				}
			}
		}
	}

	%>
<!DOCTYPE html>
<html>
<title>Upload Photo Result</title>
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
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
	<link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />

	<!-- <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.widget.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
 -->
	<script type="text/javascript" charset="utf-8">
		displayAlert('<%= message%>', 'goHome');
	</script>
<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
   <div id="dialog-message" style="display:none;" title="Photo Upload Result"><p id="diaMsg" style="width:auto;"></p></div>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>