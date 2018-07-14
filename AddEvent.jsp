<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String flag=request.getParameter("flag");
String event_id=request.getParameter("event_id");
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String event_title="";
String event_time="";
String event_guest="";
String event_venue="";
String event_desc="";
String event_presentation="";
String from_date="";
String to_date="";

if(flag==null)
	flag="I";

try {
	if(flag.intern()=="U".intern()) {
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select event_name, event_time, event_guest, event_venue, event_description, event_presentation, date_format(from_date,'%d-%b-%Y') as ffrom_date, date_format(to_date,'%d-%b-%Y') as fto_date from event where status='O' and binary event_id=?");
		pst.setString(1,event_id);
		rs=pst.executeQuery();
		if(rs.next()) {
			event_title=Utils.nullToString(rs.getString("event_name"));
			event_time=Utils.nullToString(rs.getString("event_time"));
			event_guest=Utils.nullToString(rs.getString("event_guest"));
			event_venue=Utils.nullToString(rs.getString("event_venue"));
			event_desc=Utils.nullToString(rs.getString("event_description"));
			event_presentation=Utils.nullToString(rs.getString("event_presentation"));
			from_date=Utils.nullToString(rs.getString("ffrom_date"));
			to_date=Utils.nullToString(rs.getString("fto_date"));
			System.out.println(from_date+":::"+to_date);
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
<html>
<title>Add / Update Event</title>
	<head>
	<meta charset="utf-8">

    <!-- <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" /> -->

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
	<!-- <link rel="stylesheet" href="css/jquery.ui.all.css"> -->

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />
	
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>

	<!-- <link rel="stylesheet" href="css/jquery.ui.core.css">
	<link rel="stylesheet" href="css/jquery.ui.dialog.css">
	<link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" href="css/jquery.ui.theme.css">
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
 -->	<script>
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}

		$(function() {

			$( "#from_date" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				yearRange: "2012:2017",
				dateFormat: 'dd-M-yy'	
			});
			$('#from_date').datepicker().val("<%=from_date%>").trigger('change');

			$( "#to_date" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				yearRange: "2012:2017",
				dateFormat: 'dd-M-yy'	
			});
			$('#to_date').datepicker().val("<%=to_date%>").trigger('change');

			//$( "#to_date" ).datepicker();
		});

		function getDate(val) {
			i=0;
			var arr=val.value.split("-");
			var months= ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			for(i=0; i<months.length; i++) {
				if(months[i]==arr[1]) {
					break;
				}
			}
			if(i<9) 
				mon= "0"+(i+1);
			else
				mon= (i+1)+"";

			return mon+"/"+arr[0]+"/"+arr[2];
		}

	    function validateHhMm(inputField) {
			if(inputField.value.trim()=="")
				return false;

        var isValid = /^([0-1]?[0-9]|2[0-4]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField.value);

        if (isValid) {
            inputField.style.backgroundColor = '#bfa';
        } else {
            inputField.style.backgroundColor = '#fba';
        }

        return isValid;
		}

	
		function addEvent() {
			if($("#eventform").valid()) {
				var from_dt=new Date(getDate(document.eventform.from_date));
				var to_dt=new Date(getDate(document.eventform.from_date));
				var today=new Date();
				if(from_dt.getTime() < today.getTime()) {
					alert("Event Date must be in Future");
					return;
				}
				if(to_dt.getTime() < from_dt.getTime()) {
					alert("Event End Date cannot be less than start date");
					return;
				}
				if( ! validateHhMm(document.eventform.event_time)) {
					alert("Event time must be in the format HH:MM");
					return;
				}
				postRequest("AddEventResult.jsp");
			}
		}
	
		function postRequest(strURL) {
			var xmlHttp;
			var event_title=encodeURIComponent(document.getElementById("event_title").value)
			var event_time=encodeURIComponent(document.getElementById("event_time").value)
			var event_guest=encodeURIComponent(document.getElementById("event_guest").value)
			var event_venue=encodeURIComponent(document.getElementById("event_venue").value)
			var event_desc=encodeURIComponent(document.getElementById("event_desc").value)
			var event_presentation=encodeURIComponent(document.getElementById("event_presentation").value)
			var from_date=encodeURIComponent(document.getElementById("from_date").value)
			var to_date=encodeURIComponent(document.getElementById("to_date").value);
			var flag=encodeURIComponent(document.getElementById("flag").value);
			
			var parameters="event_title="+event_title+"&event_time="+event_time+"&event_guest="+event_guest+"&event_desc="+event_desc+"&event_venue="+event_venue+"&event_presentation="+event_presentation+"&from_date="+from_date+"&to_date="+to_date+"&flag="+flag+"&event_id=<%=event_id%>";


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
			// xmlHttp.send(strURL);
		}

		function updatepage(str){
			// document.getElementById("resultCell").innerHTML = "<b><FONT SIZE=2>Result : "+str+"</FONT></b>";
			displayAlert("Result : "+str.trim(),goHome);
			/*
			if(str.trim().indexOf("Event Successfully") != -1 )
				location.href="Home.jsp";
			*/
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
	<form id='eventform' name='eventform'>
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
	<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>
			<tr><td colspan=2 class="button navy gradient">	Set up Event</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td>Event Title<em>&nbsp;*</em></td><td><input type="text" name="event_title" size="30" class="required" maxlength="150" value="<%=event_title%>" id="event_title"/></td></tr>
			<tr><td>From Date<em>&nbsp;*</em></td><td><input type="text" name="from_date" value="<%=from_date%>" readonly="readonly" id="from_date" class="required"/></td></tr>
			<tr><td>To Date<em>&nbsp;*</em></td><td><input type="text" name="to_date" value="<%=to_date%>" readonly="readonly" id="to_date" class="required"/></td></tr>
			<tr><td class="required">Event Time</td><td><input type="text" name="event_time" size="30" maxlength="150" value="<%=event_time%>" id="event_time"/></td></tr>
			<tr><td>Event Guest</td><td><input type="text" name="event_guest" size="30" maxlength="150" value="<%=event_guest%>" id="event_guest"/></td></tr>
			<tr><td class="required">Event Venue</td><td><input type="text" name="event_venue" size="30" maxlength="150" value="<%=event_venue%>" id="event_venue"/></td></tr>
			<tr><td>Event Presentation</td><td><input type="text" name="event_presentation" size="30"maxlength="40" value="<%=event_presentation%>" id="event_presentation"/> </td></tr>
			<tr><td>Event Description</td><td><input type="text" name="event_desc" size="30" maxlength="40" value="<%=event_desc%>" id="event_desc"/> </td></tr>
			<input type="hidden" name="flag" value="<%=flag%>" id="flag"/>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
				<td colspan=2 align="right">
					<input type="button" class="clickButton" value="Create / Update Event" onClick="javascript:addEvent()"/>
					&nbsp;&nbsp;&nbsp;
						<input type="button" class="clickButton" value="Cancel" onClick="javascript:cancel()"/>
				</td>
			</tr>
			<tr><td colspan=2>&nbsp;</td></tr>
			<tr>
				<td colspan=2>
						<div id='resultCell'></div>
				</td>
			</tr>
	</table>
			</form>	 
	   <div id="dialog-message" style="display:none;" title="Add / Modify Event"><p id="diaMsg" style="width:auto;"></p></div>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>