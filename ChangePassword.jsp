<!DOCTYPE html>
<html>
<title>Change Password</title>
	<head>
	<meta charset="utf-8">

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />


	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>
	<script src="Scripts/password.js"></script>


	<!-- <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<!-- <link href="css/demo_table.css" rel="stylesheet"> -->
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
	<!-- <link href="css/button-style.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script> -->

	<script>

		function changePass() {
			if($("#cpform").valid()) {
				if(! validatePassword(document.getElementById("new_pass").value)) {
					displayAlert("Password must have a minimum of 6 characters with One alphabet, One number and One Special Character");
					return;
				}
				postRequest("ChangePasswordResult.jsp");
			}
		}
	
		function postRequest(strURL) {
			var xmlHttp;
			var login_id=encodeURIComponent('<%=session.getAttribute("login_id")%>');
			var old_pass=encodeURIComponent(document.getElementById("old_pass").value);
			var new_pass=encodeURIComponent(document.getElementById("new_pass").value);
			var re_new_pass=encodeURIComponent(document.getElementById("re_new_pass").value);
			if(new_pass!=re_new_pass) {
				displayError("Passwords do not match");
				return;
			}

			var parameters="login_id="+login_id+"&old_pass="+old_pass+"&new_pass="+new_pass;

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
			//document.getElementById("resultCell").innerHTML = str;
			displayAlert(str);
		}

    </script>
	<%@include file="MBHandler.jsp" %>
	</head>

	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

	<form id='cpform' name='cpform'>
	<table width="90%" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td colspan=2>&nbsp;	</td>	</tr>
	<tr><td colspan=2 class="button navy gradient">Change Password</td></tr>
	<tr><td colspan=2>&nbsp;	</td>	</tr>
	<tr>
	<td class="label">Old Password</td>
	<td><input type="password" name="old_pass" size="20" maxlength="20" value="" id="old_pass" class="required"/></td>
	</tr>

	<tr>
	<td class="label">New Password</td>
	<td><input type="password" name="new_pass" size="20" maxlength="20" value="" id="new_pass" class="required"/></td>
	</tr>
	<tr>
	<td class="label">Reconfirm New Password</td>
	<td><input type="password" name="re_new_pass" size="20" maxlength="20" value="" id="re_new_pass" class="required"/> </td>
	</tr>
	<tr>
	<tr>	
	<td class="label" colspan=2>&nbsp;</td>
	</tr>
	<tr>
	<td class="label" colspan=2 >
	<!-- <a href="javascript:changePass()" class="button3 grey gradient">Change Password</a> -->
	<input type="button" class="clickButton" value="Change Password" onClick="javascript:changePass()"/>
	</td>
	</tr>
	<tr>
	<td class="label" colspan=2>
	&nbsp;
	</td>
	</tr>
	<tr>
	<td class="label" colspan=2>
	<div id='resultCell'></div>
	</td>
	</tr>

	</table>
	</form>
</div>
<div id="dialog-message" style="display:none;" title="Change Password"><p id="diaMsg" style="width:auto;"></p></div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>