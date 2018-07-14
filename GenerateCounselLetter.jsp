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
<title>Generate Counselling Letters</title>
	<head>
	<meta charset="utf-8">
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" href="css/jquery.ui.core.css">
	<link rel="stylesheet" href="css/jquery.ui.dialog.css">
	<link rel="stylesheet" href="css/jquery.ui.theme.css">
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
    <script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	
	<script>
		
 function generateCL() {
	 
	if($("#frmupload").valid()) {
	 var url="GenerateCounselLetterResult.jsp?exam_id="+encodeURIComponent(document.frmupload.exam_id.value);
	 postRequest(url);
	}
 }

function postRequest(strURL) {

	var xmlHttp;
          if (window.XMLHttpRequest) { // Mozilla, Safari, ...
		 var xmlHttp = new XMLHttpRequest();
	    }else if (window.ActiveXObject) { // IE
		var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	      }
	    xmlHttp.open('POST', strURL, true);
	    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
		xmlHttp.onreadystatechange = function() {
	if (xmlHttp.readyState == 4) {
	       updatepage(xmlHttp.responseText);
	      }
	   }
	   alert("3 "+strURL);
	 xmlHttp.send(strURL);
        }

     function updatepage(str)
	 {
	//	 alert(str);
		document.getElementById("resultCell").innerHTML = "<b>"+str+"</b>";
     }

 </script>
 <%@include file="MBHandler.jsp" %>
 </HEAD>
 
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

<form name="frmupload" id="frmupload">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
 <tr><td colspan=2>&nbsp;</td></tr>
 <tr><td colspan=2 class="button navy gradient">Generate Counselling Letter</td></tr>
 <tr><td colspan=2>&nbsp;</td></tr>
 <tr>
 <td class='label'>Exam Name</td>
 <td>
<select  class="required" name="exam_id" id='exam_id' STYLE="width: 250px">
			<option value="">--Please Select--</option>
			<%
			for(int i =0;i<alExamID.size(); i++) {
				%>
					<option value="<%=alExamName.get(i)%>"><%=alExamName.get(i)%></option>
				<%  
			}			
			%>
</select>
 </td>
 </tr>
 <tr>
	 <td colspan=2 align=right><input type="button" class="clickButton" value="Generate Counselling Letters" onClick="JavaScript:generateCL()"/></td>
  </tr>
<tr><td colspan=2>&nbsp;</td></tr>
 <tr><td colspan=2 id="resultCell"></td></tr>
 </table>
 </form>

   </div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>