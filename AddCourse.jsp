<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String flag=request.getParameter("flag");
String course_id=request.getParameter("course_id");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

String course_name="";
String course_desc="";
String course_group="";
String course_type="";
String syllabus="";
String course_duration="";
String course_fees="";
String course_flag="";


if(flag==null)
	flag="I";

String submitLabel=(flag.intern()=="I".intern())?"Add Course":"Update Course";
try {
	if(flag.intern()=="U".intern()) {
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select course_name, course_desc, course_group, course_type, course_duration, course_fees, course_syllabus, course_flag from course where course_id=?");
		pst.setString(1,course_id);
		rs=pst.executeQuery();
		if(rs.next()) {
			course_name=Utils.nullToString(rs.getString("course_name"));
			course_desc=Utils.nullToString(rs.getString("course_desc"));
			course_group=Utils.nullToString(rs.getString("course_group"));
			course_type=Utils.nullToString(rs.getString("course_type"));
			course_duration=Utils.nullToString(rs.getString("course_duration"));
			course_fees=Utils.nullToString(rs.getString("course_fees"));
			syllabus=Utils.nullToString(rs.getString("course_syllabus"));
			course_flag=Utils.nullToString(rs.getString("course_flag"));
		}
	}	
}
catch(Exception e1){
	// e1.printStackTrace();
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


		$(function() {
		<%	if(course_flag.intern()=="A".intern()) {	%>
			document.getElementById("course_flag").checked = true;
		<%} else { %>
			document.getElementById("course_flag").checked = false;
		<% } %>

		var vals=new Array();
		vals[0]= [ "F","P" ];
		vals[1]= [ "B.Tech","M.Tech","B.Arch","MBA","MCA" ];
		var sel=new Array();		
		sel[0]="<%= course_type %>";
		sel[1]="<%= course_group %>";
		var arr=["course_type", "course_group"];

		for (i=0; i<vals.length; i++) {
			for (j=0; j<vals[i].length; j++) {
				if(vals[i][j].trim()==sel[i].trim()) {
					document.getElementById(arr[i]).options[j].selected=true;
					break;
				}
			}
		}
		});
		function addCourse() {
			if($("#courseform").valid()) {
				if(document.courseform.course_syllabus.value != '' && document.courseform.course_syllabus.value.indexOf("pdf") == -1) {
					alert("Please select a PDF File");
				} else {
					document.courseform.submit();
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
	<form id='courseform' name="courseform" method='POST' action='AddCourseResult.jsp' enctype="multipart/form-data">
		<input type="hidden" id="course_id:" name="course_id" value="<%=course_id%>" >
		<input type="hidden" id="flag" name="flag" value="<%=flag%>" >
		<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
			<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>
			<tr><td colspan=2 class="button navy gradient">	Set up Course</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label">Course Group&nbsp;<font color="red">*</font></td>
			<td>
			<select id='course_group' name='course_group' class="required">
			<option value='B.Tech'>B.Tech</option>
			<option value='B.Arch'>B.Arch</option>
			<option value='M.Tech'>M.Tech</option>
			<option value='BA'>BA</option>
			<option value='BBA'>BBA</option>
			<option value='BCA'>BCA</option>
			<option value='B.Com'>B.Com</option>
			<option value='B.Sc'>B.Sc</option>
			<option value='MA'>MA</option>
			<option value='M.Sc'>M.Sc</option>
			<option value='MBA'>MBA</option>
			<option value='MCA'>MCA</option>
			<option value='M.Com'>M.Com</option>
			</select>
			</td>
			</tr>
			<tr>
			<td class="label">Course Type&nbsp;<font color="red">*</font></td>
			<td>
			<select id='course_type' name='course_type' class="required">
			<option value='F'>Full Time</option>
			<option value='P'>Part Time</option>
			</select>
			</td>
			</tr>
			<tr>
			<td class="label">Course Name&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="course_name" class="required" size="50" maxlength="50" value="<%=course_name%>" id="course_name"/></td>
			</tr>
			<tr>
			<td class="label">Course Description&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="course_desc" class="required" size="80" maxlength="100" value="<%=course_desc%>" id="course_desc"/></td>
			</tr>
			<tr>
			<td class="label">Course Syllabus</td>
			<td><input type="file" name="course_syllabus" size="30" value="<%=syllabus%>" id="course_syllabus" onChange="javascript:checkFile()"/></td>
			</tr>
			<tr>
			<td class="label">Course Duration (Months)&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="course_duration" class="required" size="10" maxlength="2" value="<%=course_duration%>" id="course_duration"/> </td>
			</tr>
			<tr>
			<td class="label">Course Fees (INR)&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="course_fees" class="required" size="10" maxlength="6" value="<%=course_fees%>" id="course_fees"/></td>
			</tr>
			<tr>
			<td width="199" class="label">Active?</td>
			<td>
				<input type='checkbox' id='course_flag'  name='course_flag' value='A'>
			</td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2><div id='resultCell'></div></td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td colspan=2 align=right>
				<input type="button" class="clickButton" value="<%= submitLabel%>" onClick="javascript:addCourse()"/>
				&nbsp;&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Cancel" onClick="location.href='CourseList.jsp'"/>
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