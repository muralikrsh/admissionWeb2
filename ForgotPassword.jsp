<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String uid=request.getParameter("txtUserId");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

String sq1="";
String sqid1="";
String sq2="";
String sqid2="";

try {
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select qid,qdesc from security_questions where qid in (select sq1 from adm_login where binary id=? union  select sq2 from adm_login where binary id=?)");
		pst.setString(1,uid);
		pst.setString(2,uid);
		rs=pst.executeQuery();
		if(rs.next()) {
			sqid1=rs.getString(1);
			sq1=rs.getString(2);
			rs.next();
			sqid2=rs.getString(1);
			sq2=rs.getString(2);
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
<title>Bharath University | Forgot Password</title>
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
	<script src="Scripts/password.js"></script>
	<script>

	function resetPass() {
		if($("#pwdform").valid()) {  
			if(! validateAlphaNum(document.pwdform.pwd.value)) {
				alert("Password must have a minimum of 6 characters with One alphabet, One number");
				return;
			}
			if(document.pwdform.pwd.value != document.pwdform.repwd.value) {
				alert("Password and Confirm Passwords should match");
				return;
			}
			url="ForgotPasswordResult.jsp?"+
			"uid="+encodeURIComponent(document.pwdform.uid.value)+
			"&email_id="+encodeURIComponent(document.pwdform.email_id.value)+
			"&pwd="+encodeURIComponent(document.pwdform.pwd.value)+
			"&sqid1="+encodeURIComponent(document.pwdform.sqid1.value)+
			"&sa1="+encodeURIComponent(document.pwdform.sa1.value)+
			"&sqid2="+encodeURIComponent(document.pwdform.sqid2.value)+
			"&sa2="+encodeURIComponent(document.pwdform.sa2.value);
			//alert(url);
			postRequest3(url);
		}
	}

 function postRequest3(strURL) {
	var xmlHttp;
          if (window.XMLHttpRequest) { // Mozilla, Safari, ...
		 var xmlHttp = new XMLHttpRequest();
	    }else if (window.ActiveXObject) { // IE
		var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	      }
	    xmlHttp.open('POST', strURL, true);
	    xmlHttp.setRequestHeader
              ('Content-Type', 'application/x-www-form-urlencoded');
		xmlHttp.onreadystatechange = function() {
	if (xmlHttp.readyState == 4) {
	       registerResult(xmlHttp.responseText);
	      }
	   }
	 xmlHttp.send(strURL);
        }

	function registerResult(str) {
		if(str.trim()=='INVALID_ANS') {
			document.getElementById("resultCell").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;You  have provided invalid answers. Please try again";
		} else if(str.trim()=='PWD_RESET') 
		{
			alert("Password Changed successfully. Please proceed to Login");
			location.href="Login.jsp";
/* 			Commented by Alexpandiyan on 24.3.15
			document.getElementById("resultCell").innerHTML = "<img src='images/tick2.png' width='15' height='15' border='0'>&nbsp;Password Changed successfully. Please proceed to Login";
			document.frmRegister.reset(); */
		}else {
			document.getElementById("resultCell").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;Error while changing password. Please try after some time";
		}
	}

		function cancel(){
			location.href='Home.jsp';
		}
    </script>
<%@include file="MBHandler.jsp" %>
</head>

<body>
<div class="content_container">

<header>
<div>
<div class="header_holder">
<div class="header_content">
<div align='center'><img src="images/bu_logo.jpg" alt="Bharath University" style="height:120px;width:40%;" title="Bharath University"/></div>

</div>
</div>
</header>

<section>

	<div class="content_container">
		<form id='pwdform' name="pwdform" method='POST' action='ForgotPasswordResult.jsp' >
			<input type="hidden" id="uid" name="uid" value="<%=uid%>" >
			<input type="hidden" id="sqid1" name="sqid1" value="<%=sqid1%>" >
			<input type="hidden" id="sqid2" name="sqid2" value="<%=sqid2%>" >
		<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
		<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>
			<tr><td colspan=2 class="button navy gradient">	Reset your Password by answering the Secret Questions</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td class="label">Email Id<em>&nbsp;*</em></td>
			<td><input type="text" name="email_id" class="required" size="30" maxlength="30"  id="email_id"/></td>
			</tr>
			<tr>
			<td class="label"><%= sq1%><em>&nbsp;*</em></td>
			<td><input type="text" name="sa1" class="required" size="30" maxlength="30"  id="sa1"/></td>
			</tr>
			<!-- <tr>
			<td class="label"><%= sq2 %><em>&nbsp;*</em></td>
			<td><input type="text" name="sa2" class="required" size="30" maxlength="30"  id="sa2"/></td>
			</tr>-->
			<td class="label">New Password<em>&nbsp;*</em></td>
			<td><input type="password" name="pwd" class="required" size="30" maxlength="30"  id="pwd"/></td>
			</tr>
			<td class="label">Confirm Password<em>&nbsp;*</em></td>
			<td><input type="password" name="repwd" class="required" size="30" maxlength="30"  id="repwd"/></td>
			</tr>
			<input type="hidden"  id="sq2" name="sq2" value="NA" />
            <input type="hidden"  id="sa2" name="sa2" value="NA" />
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2><div id='resultCell'></div></td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td colspan=2 align=right>
				<input type="button" class="clickButton" value="Reset Password" onClick="javascript:resetPass()"/>
				&nbsp;&nbsp;&nbsp;
				<input type="button" class="clickButton" value="Cancel" onClick="location.href='Login.jsp'"/>
			</td>
			</tr>

			</table>
		</div>
	</form>

</div>
</div>

</section>
<%@include file="Footer.jsp" %>
</div>
<%@include file="ToolTip.jsp" %>
</body>

</html>