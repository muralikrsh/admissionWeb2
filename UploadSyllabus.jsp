<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String filename=request.getParameter("filename");
if(filename==null)
	filename="";

ArrayList alExamID=null; 
ArrayList alExamName= null; 

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

try{
	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("select exam_id, exam_title from exam_master");
	rs=pst.executeQuery();

	alExamID= new ArrayList();
	alExamName= new ArrayList();	
	while(rs.next()) {
		alExamID.add(rs.getString(1));
		alExamName.add(rs.getString(2));
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
<title>Upload Syllabus for Exam</title>
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

	<script>
	function submitData() {
		if($("#form1").valid() ) {
			document.form1.submit();
		}
	}
 </script>
 <%@include file="MBHandler.jsp" %>
 </HEAD>
 
	<body>
	
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
<form action="UploadSyllabusResult.jsp" method="post" enctype="multipart/form-data" name="form1" id="form1">

	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
	 <tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2 class="button navy gradient">Upload Syllabus</td></tr>
	 <tr><td colspan=2>&nbsp;</td></tr>
	 <tr>
	 <td class='label'>Exam Name</td>
	 <td>
	<select name="exam_id" id='exam_id'  class='required'>
				<option value="">--Please Select--</option>
				<%
				for(int i =0;i<alExamID.size(); i++) {
					%>
						<option value="<%=alExamID.get(i)%>"><%=alExamName.get(i)%></option>
					<%  
				}			
				%>
	</select>
	 </td>
	 </tr>
	 <tr>
	 <td class='label'>Please Select File to Upload</td>
	 <td><INPUT TYPE="file" NAME="file_name" class='required'></td>
	 </tr>
	 <tr>
	 <td class='label' colspan=2>&nbsp;</td>
	 </tr>

	  <tr>
	 <td class='label' colspan=2><b>Note</b> : Please ensure that syllabus matches with the exam selected</td>
	 </tr>

	  <tr>
	 <td colspan=2>&nbsp;</td>
	  </tr>
	 <tr>
	 <td colspan=2>
	 <input type="button" class="clickButton" value="Upload Syllabus" onClick="javascript:submitData()"/>
	 </td>
	  </tr>
	  <tr><td colspan=2 id="resultCell"></td></tr>
	  </table>
	</form>

  </div>  


</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>
