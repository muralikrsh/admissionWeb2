<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String flag=request.getParameter("flag");
String strAllotNo=request.getParameter("AllotNo");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

String strStudentName="";
String strParentName="";
String strCourse="";
String strBranch="";

try {
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select stu_name, par_name, course, branch FROM student_admission WHERE full_adm_no=?");
		pst.setString(1,strAllotNo);
		rs=pst.executeQuery();
		if(rs.next()) {
			strStudentName=Utils.nullToString(rs.getString("stu_name"));
			strParentName=Utils.nullToString(rs.getString("par_name"));
			strCourse=Utils.nullToString(rs.getString("course"));
			strBranch=Utils.nullToString(rs.getString("branch"));
		}
}
catch(Exception e1)
{
	System.out.println(e1.toString());
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}


%>
<!DOCTYPE html>
<html  style="height: 95%;">
<title>Set up Course</title>
	<head>
	<meta charset="utf-8">
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
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

		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}
		
		function updateData() {
			var xmlHttp;
			
			var AllotNo=encodeURIComponent(document.getElementById("allotNo").value)
			var StudentName=encodeURIComponent(document.getElementById("stuName").value)
			var ParentName=encodeURIComponent(document.getElementById("parentName").value)
			
			var parameters="AllotNo="+AllotNo+"&StudentName="+StudentName+"&ParentName="+ParentName;

			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var strURL="StudentAllotmentUpdateResult.jsp?";
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					alert("Updated");
				}
			}
		}

		function cancel(){
			location.href='Home.jsp';
		}
    </script>
	<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<form>

		<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
		<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
		</tr>
			<tr><td colspan=2 class="button navy gradient">	Update Student Allotment Details</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>

			<tr>
			<td class="label">Allotment Number&nbsp;</td>
			<td><input type="text" name="allotNo" readonly="readonly" value="<%=strAllotNo%>" id="allotNo"/></td>
			</tr>
			<tr>
			<td class="label">Student Name&nbsp;</td>
			<td><input type="text" name="stuName" size="30" maxlength="100" value="<%=strStudentName%>" id="stuName"/></td>
			</tr>
			<tr>
			<td class="label">Parent Name</td>
			<td><input type="text" name="parentName" size="30" value="<%=strParentName%>" id="parentName"/></td>
			</tr>
			<tr>
			<td class="label">Course&nbsp;</td>
			<td><input type="text" name="course" readonly="readonly" size="10" maxlength="2" value="<%=strCourse%>" id="course"/> </td>
			</tr>
			<tr>
			<td class="label">Branch&nbsp;</td>
			<td><input type="text" name="branch" readonly="readonly" size="40" maxlength="6" value="<%=strBranch%>" id="branch"/></td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2><div id='resultCell'></div></td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td colspan=2 align=right>
				<input type="button" class="clickButton" value="Update" onClick="javascript:updateData()"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" class="clickButton" value="Cancel" onClick="location.href='StudentAllotmentList.jsp'"/>
			</td>
			</tr>
			</table>
	</form>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>