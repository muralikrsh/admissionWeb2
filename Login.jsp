<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">


<head>
    <title>Bharath University | Home</title>
    <meta name="robots" content="noindex,nofollow" />


	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
	<script src="ui/jquery.validation.js" ></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>
	<script src="Scripts/password.js"></script>

	<!-- <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/jquery.validation.js" ></script>
	<script src="Scripts/jquery-ui.js"></script>
    <script src="Scripts/hoverIntent.js"></script>
    <script src="Scripts/superfish.js"></script>
    <script src="Scripts/CustomScript.js"></script>
	<script src="Scripts/password.js"></script>
 -->	
	<style type="text/css">
	.ui-widget-content{
	border:0px solid transparent;
	}
	</style>


    <!--[if IE 8]>
    <style>
    .header_content{background:url(/images/Header-bg.png);}

	input.error
	{
    box-shadow: inset 0px 2px 5px -1px red !important;
	/*border: 1px solid red !important;*/
	background-color:rgb(235, 174, 174) !important;
	}
    </style>
    <![endif]-->

<script language='JavaScript'>
String.prototype.trim = function() {
    return this.replace(/^\s+|\s+$/g,"");
}


$(function() {
	$("#lpass").keyup(function(event){     
		if(event.keyCode == 13){         
			// $("#signin").click();     
			signIn();
		}
	});
	//document.getElementById('divfp').style.display="none";
	$("#sa2").keyup(function(event){     
		if(event.keyCode == 13){         
			// $("#register").click();     
			register();
		}
	});
}); 

//function signIn() {
//location.href='Home.jsp';
//}
function signIn() {
	$("#frmLogin").validate({
    onfocusout: false,
    invalidHandler: function(form, validator) {
        var errors = validator.numberOfInvalids();
        if (errors) {                    
            validator.errorList[0].element.focus();
        }
    } 
	});
	 if($("#frmLogin").valid() ) {
		  postRequest("ValidateAdmLogin.jsp?txtUserID="+encodeURIComponent(document.frmLogin.txtUserID.value)+"&txtPassword="+encodeURIComponent(document.frmLogin.lpass.value));
	 }
	 
}
function register() {
    
    var userid=document.frmRegister.txtUserID.value;
	var pattern = /^[0-9]$/gi;
	//if (pattern.test(userid)) {
      //      displayAlert("Enter alphanumeric value");
        //    return ;
		//	}

	if($("#frmRegister").valid()) { 
		//if(! validateAlphaNum(document.frmRegister.txtUserID.value)) {
			//displayAlert("User Id must be alpha numeric");
			//return;
		//}
		//if(! validateAlphaNum(document.frmRegister.txtPassword.value)) {
			//displayAlert("Password must have a minimum of 6 characters with atleast One alphabet, One number");
			//return;
		//}  
		if(document.frmRegister.txtPassword.value != document.frmRegister.txtRePassword.value) {
			displayAlert("Password and Confirm Passwords should match");
			return;
		}
		
		var email=document.frmRegister.txtEmail.value;
		
		
		if (email.indexOf("@")== -1 || email.indexOf(".") == -1) 
		{
		displayAlert("Please enter a valid email address");
		return;
		}
		var y=document.frmRegister.mobile_no.value;
		
		 if(isNaN(y))
           {
              displayAlert("Please enter 10 digit valid mobile number")
              return; 
           }
		   var l=y.length;
		if(l!=10){
		displayAlert("Please enter 10 digit valid mobile number");
		return;
		}
		if(document.frmRegister.sq1.value==document.frmRegister.sq2.value) {
			displayAlert("Please select different security questions");
			return;
		}
		
		
		

		$('#divLoading').show();
		centerDiv('#divLoading');

		url="RegisterUser.jsp?"+
		"txtUserID="+encodeURIComponent(document.frmRegister.txtUserID.value)+
		"&txtUserName="+encodeURIComponent(document.frmRegister.txtUserName.value)+
		"&txtPassword="+encodeURIComponent(document.frmRegister.txtPassword.value)+
		"&txtEmail="+encodeURIComponent(document.frmRegister.txtEmail.value)+
		"&mobile_no="+encodeURIComponent(document.frmRegister.mobile_no.value)+
		"&degree="+encodeURIComponent(document.frmRegister.degree.value)+
		"&sq1="+encodeURIComponent(document.frmRegister.sq1.value)+
		"&sa1="+encodeURIComponent(document.frmRegister.sa1.value)+
		"&sq2="+encodeURIComponent(document.frmRegister.sq2.value)+
		"&sa2="+encodeURIComponent(document.frmRegister.sa2.value);
		//alert(url); // Need to show processing gif here ......
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
			// document.getElementById("SignInResultCell").innerHTML = "Invalid Login. Please try again";
			displayAlert("Invalid Login. Please try again");
		} else {
			location.href="Home.jsp";
		}
	}
	function registerResult(str) {
		StopLoading();
		if(str.trim()=='USER_EXISTS') {
			//document.getElementById("RegisterResultCell").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;User ID already exists. Please try with a different ID";
			displayAlert("User ID already exists. Please try with a different ID");
		} else if(str.trim()=='USER_CREATED') { 
			//document.getElementById("RegisterResultCell").innerHTML = "<img src='images/tick2.png' width='15' height='15' border='0'>&nbsp;<b>Activation Link sent to your email Id. Please click on Activation Link to complete registration</b>";
			displayAlert("Activation Link sent to your email Id. Please click on Activation Link to complete registration","doLogin");
			document.frmRegister.reset();
		}else {
			//document.getElementById("RegisterResultCell").innerHTML = "<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;Error while creating User ID. Please try after some time";
			displayAlert("Error while creating User ID. Please try after some time");
		}
	}
	function resetResult(str) {
		if(str.trim()=='PASS_RESET') {
			document.getElementById("resultCell").innerHTML = "<img src='images/tick2.png' width='15' height='15' border='0'>&nbsp;Password sent to your registered Email ID</font>";
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
	// document.getElementById('divfp').style.display="block";
	if(document.getElementById("txtUserID").value=="") {
		displayError("Please enter your User Id, and press Forgot Password link");
		return;
	}
	location.href='ForgotPassword.jsp?txtUserId='+encodeURIComponent(document.frmLogin.txtUserID.value);

}

</script>
<%@include file="MBHandler.jsp" %>
</head>


<body>
<div class="container">

<header>
<div>
<div>
<div>
<div class="fleft"><img height="110" width="100%" src="images/logo_new.png" alt="Bharath University" title="Bharath University" /></div>
<div class="fright"><img height="110" width="110" src="images/bu_excellence_logo.jpg" alt="33 Years" title="" /></div>
</div>
</div>
</header>
<section>
<div><img height="10px" width="100%" src="images/dark-red-line.png"/>
</div>
<div class="content_container">
<!-- <h1 class="title">Online Application to Bharath University</h1> -->
<div class="intro_home">
<table style="width:100%; height:424px;">
<tr><td style="text-align:center;vertical-align:middle;height:352px;"><img src="images/bist.png" alt="" title="" /></td></tr>
<tr><td style="text-align:justify;">
Bharath University was established under the aegis of Sri Lakshmi Ammal Educational Trust with the aim of imparting higher knowledge in Science and Technology to the aspiring boys and girls so that they can emerge as competent scientists, engineers and technologists of repute.
</td></tr>
</table>
	
<br />
<br />
<br />
<p></p>
</div>
<div class="login_signup_container">
<div id="tabs" style="width:450px;">
  <ul>
    <li><a href="#tabs-1">Login</a></li>
    <li><a href="#tabs-2"> New User - Sign Up</a></li>
    
  </ul>
  <div id="tabs-1">
  <div class="logindiv textbox_medium fontbold">
<!-- <h1>Login Here</h1> -->
<form name='frmLogin' id='frmLogin' >
<table class="tbl_p5" id="maintab">
	<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty / Fields with Invalid values are highlighted in red</td></tr>
	<tr><td style="width:100px;">User ID&nbsp;<font color="red">*</font></td><td><input id="txtUserID" name="txtUserID" class="required" value=""  style="width:200px;" type="text" onclick="this.value='';" onfocus="this.select()"  value="" placeholder='Enter your registered user Id '/></td></tr>
	<tr><td>Password&nbsp;<font color="red">*</font></td><td><input id="lpass" class="required" name="lpass"  value="" type="password" style="width:200px;"   onclick="this.value='';" onfocus="this.select()"  value="" placeholder='Your password'/></td></tr>
	<tr><td></td><td nowrap><input type="button" value="Login &raquo;" onclick="javaScript:signIn()" class="clickButton" />&nbsp;&nbsp;&nbsp;<a  href="javascript:forgotPass()">Forgot Password?</a></td></tr>
	<tr><td colspan=2>&nbsp;</td>
	<tr><td colspan=2><div id="SignInResultCell"></div></td>
</table>
	</form>
</div>
  </div>
  <div id="tabs-2">
 <div class="signupdiv textbox_medium fontbold">
 <div id="divLoading" style="position:absolute; text-align:center; vertical-align:middle; display:none;">
 <img id="imgloading" src="images/loading.gif"  alt="loading..."  style="position:absolute;"/>
 </div>
<!-- <h1>Register Yourself</h1> -->
<form name='frmRegister' id='frmRegister'>
<table class="tbl_p3" id='maintab'>
<tr><td colspan="2"></td></tr>
<!--  -->
<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red</td></tr>
<tr><td style="width:150px;">User ID&nbsp;<font color="red">*</font></td><td><input name="txtUserID" class="required" style="width:200px;" value="" type="text" onclick="this.value='';" onfocus="this.select()" /></td></tr>
<tr><td>Name&nbsp;<font color="red">*</font></td><td><input name="txtUserName" class="required" style="width:200px;" value="" type="text" onclick="this.value='';" /></td></tr>
<tr><td>Password&nbsp;<font color="red">*</font></td><td><input name="txtPassword"  class="required" value="" style="width:200px;" type="password"  onclick="this.value='';" onfocus="this.select()" /></td></tr>
<tr><td nowrap>Confirm Password&nbsp;<font color="red">*</font></td><td><input name="txtRePassword"  style="width:200px;" class="required" value="" type="password"  onclick="this.value='';" onfocus="this.select()"  /></td></tr>
<tr><td>Email ID&nbsp;<font color="red">*</font></td><td><input name="txtEmail"  value="" type="text" style="width:200px;" class="required" title='Activation Link would be sent to this Id' placeholder='Eg:one@gmail.com'/></td></tr>
<tr><td>Mobile No (10 Digits)&nbsp;<font color="red">*</font></td><td><input name="mobile_no"  value="" type="text" style="width:200px;" class="numeric required" maxlength=10 placeholder='Eg:9999999999'/></td></tr>
<tr><td>Degree&nbsp;<font color="red">*</font></td><td>
<select id="degree" name="degree" class="required" style="width:200px;" >
<option value="">Select Degree</option>
<option value="1">Engineering</option>
<option value="2">Architecture</option>
<option value="3">Arts & Science</option>
<option value="4">Management</option>
<option value="5">Hospitality</option>
</select>
</td>
</tr>
<tr><td>Question #1&nbsp;<font color="red">*</font></td><td>
<select id="sq1" name="sq1" class="required" style="width:200px;" >
<option value="">Select Question</option>
<option value="1">What is your favorite Color </option>
<option value="2">Which is your favorite Sports Team </option>
<option value="3">What is the name of your first Car </option>
<option value="4">Who is your favorite teacher </option>
<option value="5">What is your Mothers Maiden Name </option>
</select>
</td>
</tr>
<tr><td>Answer 1&nbsp;<font color="red">*</font></td><td><input id="sa1" name="sa1"  value="" type="text" style="width:200px;"  class="required" title='Secret Q&A would be used to retrieve lost password'/></td></tr>
<!-- <tr><td>Question #2&nbsp;<font color="red">*</font></td><td>
<select id="sq2" name="sq2" class="required" style="width:200px;" > 
<option value="">Select Question</option>
<option value="1">What is your favorite Color </option>
<option value="2">Which is your favorite Sports Team </option>
<option value="3">What is the name of your first Car </option>
<option value="4">Who is your favorite teacher </option>
<option value="5">What is your Mothers Maiden Name </option>
</select>
</td></tr>
<tr><td>Answer 2&nbsp;<font color="red">*</font></td><td><input id="sa2" name="sa2"  value="" type="text" style="width:200px;" class="required" title='Secret Q&A would be used to retrieve lost password'/></td></tr>
-->
<tr><td></td><td><input type="button" onclick="javaScript:register()" value="Register" class="clickButton" /></td></tr>
<!-- <tr><td colspan=2>&nbsp;</td> -->
<tr><td colspan=2><div id="RegisterResultCell"></div></td>
<input type="hidden"  id="sq2" name="sq2" value="NA" />
<input type="hidden"  id="sa2" name="sa2" value="NA" />

</table>
</form>
</div>
</div>
  <div class="clearfix"></div>
</div>
</div>

<div class="clearfix"></div>
  <div id="dialog-message" style="display:none;" title="Message"><p id="diaMsg" style="width:auto;"></p></div>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
<%@include file="ToolTip.jsp" %>
<script type="text/javascript">

    jQuery(document).ready(function () {
        
        $("#tabs").tabs();
    });

</script>
</body>

</html>