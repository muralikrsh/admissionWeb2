<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String flag=request.getParameter("flag");
String strAnsNo=request.getParameter("ans_no");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

String strHallTicket="";
String strStudentName="";
String strMobileOne="";
String strMobileTwo="";
String strRank="";

if(flag==null)
	flag="I";

String submitLabel=(flag.intern()=="I".intern())?"Add Course":"Update";
try {
	if(flag.intern()=="U".intern()) {
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select ht_no, stu_name, mobile_no_1, mobile_no_2, rank from rank_list where ans_no=? order by rank");
		pst.setString(1,strAnsNo);
		System.out.println(pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			strHallTicket=Utils.nullToString(rs.getString("ht_no"));
			strStudentName=Utils.nullToString(rs.getString("stu_name"));
			strMobileOne=Utils.nullToString(rs.getString("mobile_no_1"));
			strMobileTwo=Utils.nullToString(rs.getString("mobile_no_2"));
			strRank=Utils.nullToString(rs.getString("rank"));
		}
	}	
}
catch(Exception e1){
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
<title>Update Student Details</title>
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

		function updateDetails() {
			if($("#studentForm").valid()) {
					document.studentForm.submit();
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
	<form id='studentForm' name="studentForm" method='POST' action='StudentDetailsResult.jsp' enctype="multipart/form-data">
		<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
			<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>
			<tr><td colspan=2 class="button navy gradient">	Rank List</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label">Hall Ticket No&nbsp;<font color="red">*</font></td>
			
			<td><input type="text" name="ht_no" class="required" size="10" maxlength="100" value="<%=strHallTicket%>" id="ht_no"/>
	
			</td>

			</select>
			</td>
			</tr>
			<tr>
			<td class="label">Name&nbsp;<font color="red">*</font></td>
		
			<td><input type="text" name="stu_name" class="required" size="30" maxlength="100" value="<%=strStudentName%>" id="stu_name"/></td>
			</select>
			</td>
			</tr>
			<tr>
			<td class="label">Rank&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="rank" readonly="readonly" size="15" maxlength="25" value="<%=strRank%>" id="rank"/></td>
			</tr>
			<tr>
			<td class="label">Mobile 1&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="mobile_1" class="required" size="15" maxlength="50" value="<%=strMobileOne%>" id="mobile_1"/></td>
			</tr>
			<tr>
			<td class="label">Mobile 2&nbsp;<font color="red">*</font></td>
			<td><input type="text" name="mobile_2" class="required" size="15" maxlength="100" value="<%=strMobileTwo%>" id="mobile_2"/></td>
			</tr>

			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2><div id='resultCell'></div></td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td colspan=2 align=right>
				<input type="button" class="clickButton" value="<%= submitLabel%>" onClick="javascript:updateDetails()"/>
				&nbsp;&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Cancel" onClick="location.href='StudentRankList.jsp'"/>
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