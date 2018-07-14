<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<!DOCTYPE html>
<html  style="height: 95%;">
<title>Add User</title>
	<head>
	<meta charset="utf-8">
	<link rel="stylesheet" href="css/jquery.ui.all.css">

    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>


	<script>
		var flag='I';
	
		function addUser() {
			if($("#userform").valid() ) {
				postRequest("AddUserResult.jsp");
			}
		}
		function searchUser() {
			postRequest2("GetUserDetails.jsp");
		}
		function postRequest2(strURL) {
			var user_id=encodeURIComponent(document.getElementById("user_id").value)

			var parameters="user_id="+user_id;
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatepage2(xmlHttp.responseText);
				}
			}

			xmlHttp.send(strURL);
		}

		function postRequest(strURL) {
			var user_id=encodeURIComponent(document.getElementById("user_id").value)
			var user_name=encodeURIComponent(document.getElementById("user_name").value)
			var email_id=encodeURIComponent(document.getElementById("email_id").value)
			var password=encodeURIComponent(document.getElementById("password").value)
			var role=encodeURIComponent(document.getElementById("role").value)
			var enable=encodeURIComponent(document.getElementById("enable").value);
			


			var parameters="user_id="+user_id+"&user_name="+user_name+"&email_id="+email_id+"&password="+password+"&role="+role+"&enable="+enable+"&flag="+flag;
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatepage(xmlHttp.responseText);
				}
			}

			xmlHttp.send(strURL);
		}

		function updatepage(str){
			document.getElementById("resultCell").innerHTML = "<b>"+str+"</b>";
		}

		function updatepage2(str){
			if(str=='No matching records') {
			document.getElementById("resultCell").innerHTML = "<b>"+str+"</b>";
			} else {
				flag='U';
				var arr=str.split('-');

				document.getElementById("user_name").value=arr[0].trim();
				document.getElementById("password").value=arr[1].trim();
				document.getElementById("email_id").value=(arr[4].trim()=="null")?"":arr[4].trim();
				if(arr[2].trim()=='ADMIN') {
					document.getElementById("role").options[1].selected=true;
				} else if(arr[2].trim()=='STUDENT')  {
					document.getElementById("role").options[2].selected=true;
				} else {
					document.getElementById("role").options[3].selected=true;
				}
				if(arr[4].trim()=='O') {
					document.getElementById("status").options[1].selected=true;
				} else {
					document.getElementById("status").options[2].selected=true;
				}
			}
		}
    </script>
	<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<div id="formdiv"><BR>
	<form id="userform" name="userform">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
		<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>

	<tr><td colspan=2 class="button navy gradient">Create / Update User Details</td></tr>
	<tr><td colspan=2>&nbsp;	</td>	</tr>
	<tr>
	<td>User ID</td>
	<td><input type="text" name="user_id" size="30" maxlength="30" value="" id="user_id" class="required"/>&nbsp;&nbsp;<input type="button"  class="clickButton" value="Search" onclick="searchUser();"  /></td>
	</tr>
	<tr>
	<td>User Name</td>
	<td><input type="text" name="user_name" size="30" maxlength="30" value="" id="user_name" class="required"/></td>
	</tr>

	<tr>
	<td>Email</td>
	<td><input type="text" name="email_id" size="30" maxlength="30" id="email_id" class="required email" /></td>
	</tr>


	<tr>
	<td>Password</td>
	<td><input type="password" name="password" size="30" maxlength="30" value="" id="password" class="required" /></td>
	</tr>
	<tr>
	<td>Role</td>
	<td>
		<select name="role" id="role" class="required">
			<option value="">--Please Select--</option>
			<option value="ADMIN">Admin</option>
			<option value="STUDENT">Student</option>
			<option value="VC">Vice Chancellor</option>
		</select>
	</td>
	</tr>
	<tr>
	<td width="199">Enable / Disable</td>
	<td>
		<select name="enable" id="enable" class="required">
			<option value="">--Please Select--</option>
			<option value="O" selected>Enabled</option>
			<option value="C">Disabled</option>
		</select>
	</td>
	</tr>
	<tr>
	<td colspan=2>&nbsp;</td>
	</tr>
	<tr>
	<td colspan=2>
	<input type="button" class="clickButton" value="Create /Update User Details" onClick="javascript:addUser()"/>
	</td>
	</tr>
	<tr>
	<td colspan=2>
	&nbsp;
	</td>
	</tr>
	<tr>
	<td colspan=2>
	<div id='resultCell'></div>
	</td>
	</tr>
	
	</table>
	</form>
	</div>


</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>