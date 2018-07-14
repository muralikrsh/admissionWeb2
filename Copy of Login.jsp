
<html>
<title>
eUniv - Login
</title>
<head>
<link rel="stylesheet" type="text/css" href="css/button-style.css" />
<style type="text/css">
table {
background: #FFFFFF;
color: white;
border: 0px;
font-family: Trebuchet MS, verdana, arial, ms sans serif;
font-weight: regular;
font-size: 12pt
}
table.login {
background: #6699CC;
color: white;
border: 0px;
font-family: Trebuchet MS, verdana, arial, ms sans serif;
font-weight: regular;
font-size: 10pt
}
td.login {
background: #6699CC;
color: #FFFFFF;
border: 0px;
font-family: Trebuchet MS, verdana, arial, ms sans serif;
font-weight: regular;
font-size: 10pt
}
td.head {
background: #6699CC;
color: #FFFFFF;
border: 0px;
font-family: Trebuchet MS, verdana, arial, ms sans serif;
font-weight: bold;
font-size: 16pt
}
td.foot {
background: #6699CC;
color: #FFFFFF;
border: 0px;
font-family: Trebuchet MS, verdana, arial, ms sans serif;
font-weight: normal;
}
</style>
<script src="ui/minified/jquery-1.7.2.min.js"></script>
<script src="ui/jquery.validation.js"></script>
<script language='JavaScript'>
String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g,"");
}


$(function() {
	$("#lpass").keyup(function(event){     
		if(event.keyCode == 13){         
			$("#signin").click();     
		}
	});
	document.getElementById('divfp').style.display="none";
}); 

function signIn() {
location.href='Home.jsp';
}
function signIn() {
	  postRequest("ValidateAdmLogin.jsp?txtUserID="+encodeURIComponent(document.frmLogin.txtUserID.value)+"&txtPassword="+encodeURIComponent(document.frmLogin.lpass.value));
}
function register() {
	if($("#frmRegister").valid()) {  
	url="RegisterUser.jsp?txtUserID="+encodeURIComponent(document.frmRegister.txtUserID.value)+"&txtUserName="+encodeURIComponent(document.frmRegister.txtUserName.value)+"&txtPassword="+encodeURIComponent(document.frmRegister.txtPassword.value)+"&txtEmail="+encodeURIComponent(document.frmRegister.txtEmail.value);
	//alert(url);
  postRequest3(url);
	}
}
function resetPass() {
  postRequest2("ResetPassword.jsp?txtUserID="+document.frmLogin.txtUserID.value+"&txtEmail="+document.frmLogin.txtEmail.value);
}
 function postRequest(strURL) {
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
	       searchResult(xmlHttp.responseText);
	      }
	   }
	 xmlHttp.send(strURL);
        }

 function postRequest2(strURL) {
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
	       resetResult(xmlHttp.responseText);
	      }
	   }
	 xmlHttp.send(strURL);
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

	function searchResult(str) {
		if(str.trim()=='INVALID_LOGIN') {
			document.getElementById("resultCell").innerHTML = "<font color='white'>Invalid Login. Please try again</font>";
		} else {
			location.href="Home.jsp";
		}
	}
	function registerResult(str) {
		if(str.trim()=='USER_EXISTS') {
			document.getElementById("resultCell2").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;<font color='white'>User ID already exists. Please try with a different ID</font>";
		} else if(str.trim()=='USER_CREATED') { 
			document.getElementById("resultCell2").innerHTML = "<img src='images/tick2.png' width='15' height='15' border='0'>&nbsp;<font color='white'><b>User ID created successfully. Please proceed to Login</b></font>";
			document.frmRegister.reset();
		}else {
			document.getElementById("resultCell2").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;<font color='white'>Error while creating User ID. Please try after some time</font>";
		}
	}
	function resetResult(str) {
		if(str.trim()=='PASS_RESET') {
			document.getElementById("resultCell").innerHTML = "<img src='images/tick2.png' width='15' height='15' border='0'>&nbsp;<font color='white'>Password sent to your registered Email ID</font>";
		}
		else if(str.trim()=='EMAIL_NO_MATCH') {
			document.getElementById("resultCell").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;<font color='white'>Email ID entered does not match with email ID  registered with us</font>";
		} else {
			document.getElementById("resultCell").innerHTML ="<font color='white'>"+str+"</font>";
		}
	}

function resetDetails() {
document.frmLogin.reset();
}
function forgotPass() {
	document.getElementById('divfp').style.display="block";
}

</script>
</head>
<body>
<table width=100% height=100%>
	<tr height=10%>
	<td colspan=3>&nbsp;</td>
	<td align=right>&nbsp;
	<!-- <img src='close_but.gif' width=20 height=20 onClick='javascript:window.close()'/> -->
	</td>
	
	</tr>
	<tr height=10%>
	<td width=10%>&nbsp;</td>
	<td colspan=3 align=center class=head>e Univ</td>
	<td width=10% align=right>&nbsp;</td>
	</tr>	
	<tr height=10%>
	<td colspan=4>&nbsp;</td>
	</tr>

	<tr height=40%>
	<td width=10%>&nbsp;</td>
	<td width=20%><img src='training_placement.jpg' width=100% height=100%/></td>

	<td class=login width=30%>
			<form name='frmRegister' id='frmRegister'>
			<table class=login align=center>
			<tr><td colspan=2><b>Please Sign Up if you are new to the site</b></td></tr>

			<tr>
			<td colspan=2 id=resultCell2>&nbsp;</td>
			</tr>
			<tr>
			<td align=right>&nbsp;</td>
			<td align=right>&nbsp;</td>
			</tr>


			<tr>
			<td>User ID</td>
			<td width=50><input name="txtUserID" value="" type="text/css" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'':this.value;"  value="" class="required"/></td>
			</tr>
			<tr>
			<td>Name</td>
			<td width=50><input name="txtUserName" value="" type="text/css" onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'UserName':this.value;" value="UserName" class="required"/></td>
			</tr>
			<tr>
			<td>Password</td>
			<td><input name="txtPassword"  value="" type="password"  onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'':this.value;" value="" class="required"/></td>
			</tr>

			<tr>
			<td>Re Enter Password</td>
			<td><input name="txtRePassword"  value="" type="password"  onclick="this.value='';" onfocus="this.select()" onblur="this.value=!this.value?'':this.value;" value=" "class="required" /></td>
			</tr>


			<tr>
			<td>Email ID</td>
			<td><input name="txtEmail"  value="" type="text/css" class="required" /></td>
			</tr>

			<tr><td  class=login align=right>&nbsp;</td><td align=right>&nbsp;</td></tr>
			<tr>
			<td  class=login align=right colspan=2>
			<!-- <input type=button value="Sign Up" text="Sign Up" onClick="javaScript:register()">&nbsp;&nbsp;&nbsp;
			<input type=button value="Reset" text="Reset" onClick="javaScript:resetDetails()"> -->
			<a href="javaScript:register()" class="button green gradient">Sign Up</a>&nbsp;&nbsp;&nbsp;
			<a href="javaScript:resetDetails()" class="button green gradient">Reset</a>
			</td>
			 </tr>
			</table>
			<!-- </div> -->
			</form>
	</td>
	<td class=login width=30%>
			<form name='frmLogin'>
			<table class=login align=center>
			<tr><td colspan=2><b>Sign In if you already have a login</b></td></tr>
			<tr>
			<td colspan=2 id=resultCell>&nbsp;</td>
			</tr>
			<!-- <tr>
			<td align=right>&nbsp;</td>
			</tr>
 -->			<tr>
			<td>User ID</td>
			<td><input name="txtUserID" value="" type="text/css" onclick="this.value='';" onfocus="this.select()"  value="" /></td>
			</tr>
			<tr>
			<td>Password</td>
			<td><input id="lpass" name="lpass"  value="" type="password"  onclick="this.value='';" onfocus="this.select()"  value="" /></td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
			<td  class=login align=right colspan=2>
			<!-- <input type=button id="signin" value="Sign In" text="Sign In" onClick="javaScript:signIn()">&nbsp;&nbsp;&nbsp;
			<input type=button value="Reset" text="Reset" onClick="javaScript:resetDetails()">&nbsp;&nbsp;&nbsp;
 -->
 <a href="javaScript:signIn()" class="button green gradient">Login</a>&nbsp;&nbsp;&nbsp;
 <a href="javaScript:resetDetails()" class="button green gradient">Reset</a>&nbsp;&nbsp;&nbsp;
 <a href='javascript:forgotPass()' class="button blue gradient">Forgot Password?</a>

			</td>
			 </tr>
			
			<tr><td colspan=2>
			<div id='divfp'>
			<br>Enter Your mail Id and Click Reset</b>
			<br><br>Email ID&nbsp;&nbsp;<input name="txtEmail"  value="" type="text/css"  />&nbsp;&nbsp;<img valign=bottom src="images/question.png" width="18" height="20" border="0" title="Students can enter the registered Email ID and use Reset Password option if you forget your password">
			<br><br>
			<!-- <input type=button value="Reset Password" text="Reset" onClick="javaScript:resetPass()"> -->
			 <a href="javaScript:resetPass()" class="button green gradient">Reset Password</a>
			</div>
			</td>
			</tr>
			<tr>
			<td  class=login align=right colspan=2>
			
			</td>
			 </tr>
			</table>
			<!-- </div> -->
			</form>
	</td>
	<td width=10%>&nbsp;</td>
	</tr>

	<tr height=10%>
	<td>&nbsp;</td>	</tr>
	<tr height=10%>
	<td width=10%>&nbsp;</td>
	<!-- <td colspan=3 align=center class=head>&nbsp;</td> -->
	<td colspan=3 class=foot align=center><font color="#FFFFFF" name='Trebuchet MS' size='2px'>
		Note : Incase of any issues in accessing the portal or working with specific screens please drop a note to <b>support@campus2cubicle.com</b> with your login id and details about the issue. We will respond to you at the earliest.
	&nbsp;
	</font>
	</td>
	<td width=10%>&nbsp;</td>
	</tr>
	<tr height=10%>
	<td>&nbsp;</td>
	</tr>

</table>
</body>
</html>