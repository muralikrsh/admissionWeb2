<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String userID=(String)session.getAttribute("login_id");
System.out.println("Login ID" +session.getAttribute("login_id"));
%>
<!DOCTYPE html>
<html>
<title>Upload Photo</title>
	<head>
	<meta charset="utf-8">

    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>

	<!-- <script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.accordion.min.js"></script>

	<link rel="stylesheet" type="text/css" href="css/jquery.ui.all.css">
	<link rel="stylesheet" type="text/css" href="css/pro_dropdown_2.css" />
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/demos.css">
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />
 -->
	<script language='JavaScript'>

		function updateProfile() {
			postRequest("UpdateProfileResult.jsp");
		}
		function test_photoType() {
		}

		function updatepage(str){
			document.getElementById("resultCell").innerHTML = "<B>"+str+"</B>";
		}

    </script>
	<%@include file="MBHandler.jsp" %>
	</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" >
		<tr><td>&nbsp;</td></tr>	
		<tr><td class="button navy gradient">Photo Upload - Please upload your latest passport photograph</td></tr>	
		<tr><td>&nbsp;</td></tr>	
		<TR>
		<td>
						<table>
							<tr>
								<td><img width="320" height="240" src='/photos/<%=userID%>.jpg'>&nbsp;</td>
								<td>
									<form action="UpdatePhotoResult.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1"> 
									<input type="hidden" id="student_id" name="student_id" value="<%=userID%>">
									<input type="file" name="updatedPhotoFile" size="20" value="" id="updatedPhotoFile" class='rounded-corners' onchange="test_photoType()"/>
									 <input type="button" class="clickButton" value="Upload Photo" onClick="JavaScript:document.form1.submit()"/>
									</form>
									<br><br><font>(Please click Upload Photo button after uploading your image to view the image)</font>
								</td>
							</tr>
						</table>
	</td>
	</tr>							
	</table>

   </div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>