<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

ArrayList alStates=(ArrayList)application.getAttribute("STATES");
String flag=request.getParameter("flag");
if(flag==null)
	flag="I";
String exam_id="";
String exam_title="";
String exam_date="";
String exam_centre="";
String exam_time="";
String exam_duration="";
String exam_venue="";
String exam_course="";
String category="";
String headerLabel=(flag.intern()=="I".intern())?"Add New Exam":"Modify Exam Details";
String submitLabel=(flag.intern()=="I".intern())?"Add Exam":"Update Exam Details";
ArrayList alCourseGroup=(ArrayList)application.getAttribute("COURSE_GROUP");

try {

if(flag.intern()=="U".intern()) {

	exam_id=request.getParameter("exam_id");

	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("select exam_id, exam_title, date_format(exam_date,'%d-%b-%Y') as exam_date, exam_time, exam_duration, exam_venue, course,category from exam_master where binary exam_id=?");
	pst.setString(1,exam_id);
	rs=pst.executeQuery();
	System.out.println("1");
	if(rs.next()) {
		System.out.println("2");	
		exam_id=rs.getString("exam_id");
		exam_title=rs.getString("exam_title");
		exam_date=rs.getString("exam_date");
		exam_time=rs.getString("exam_time");
		exam_duration=rs.getString("exam_duration");
		exam_venue=rs.getString("exam_venue");
		exam_course=rs.getString("course");
		category=rs.getString("category");
	}
		System.out.println("3");
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
<title><%=headerLabel%></title>
	<head>
	<meta charset="utf-8">
    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/bootstrap-3.1.1.min.css" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap-multiselect.css" type="text/css" />


    <script type="text/javascript" src="ui/bootstrap/bootstrap-2.3.2.min.js"></script>
    <script type="text/javascript" src="ui/bootstrap/bootstrap-multiselect.js"></script>
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<style>
	.error { background:#FBE3E4; color:#8a1f11; border-color:#FBC2C4 }
	</style>
	<script>
	
	$(function() {
        $( "#exam_date" ).datepicker({
			changeMonth: true, 
			changeYear: true,  
			yearRange: "2012:2017",
			dateFormat: 'dd-M-yy'	
			});
	});
		
	
	$(function() {
		$('#chkstates').multiselect({
		includeSelectAllOption: true
		});
		
		});
	
	
		$(function() {
		alert("1");
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}
		
			var arr=["exam_course"];
			var vals=new Array();
			vals[0]= [ "B.Tech","B.Arch","M.Tech","MBA","MCA" ];
			var sel=new Array();
			sel[0]="<%= exam_course %>";
			i=0;
			for (j=0; j<vals[i].length; j++) {
				if(vals[i][j].trim()==sel[i].trim()) {
					document.getElementById(arr[i]).options[j+1].selected=true;
					break;
				}
			}
			
/* 			$( "#exam_date" ).datepicker({
			changeMonth: true, 
			changeYear: true,  
			yearRange: "2012:2017",
			dateFormat: 'dd-M-yy'	
			}); */
			
		  $( "#exam_duration").keyup(function() {
			$(this).val($(this).val().replace(/[^\d]/, ''));
		  });

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
		
		function addexam() {
			if($("#examform").valid()) {
				var dt=new Date(getDate(document.examform.exam_date));
				var today=new Date();
				if(dt.getTime() < today.getTime()) {
					alert("Exam Date must be in Future");
					return;
				}
				if( ! validateHhMm(document.examform.exam_time)) {
					alert("Exam time must be in the format HH:MM");
					return;
				}
				if( parseInt(document.examform.exam_duration.value) > 240)
				{
					alert("Duration of Exam must be less than 240 Minutes");
					return;
				}
				postRequest("AddExamResult.jsp");
			}
		}
	
	    function validateHhMm(inputField) {
			if(inputField.value.trim()=="")
				return false;

        var isValid = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(:[0-5][0-9])?$/.test(inputField.value);

        if (isValid) {
			hh=inputField.value.substring(0,inputField.value.indexOf(":"));
			mm=inputField.value.substring(inputField.value.indexOf(":")+1,inputField.value.length);
			if(hh==24 && mm!="00") {
				inputField.style.backgroundColor = '#fba';
				return false;
			}
            inputField.style.backgroundColor = '';
        } else {
            inputField.style.backgroundColor = '#fba';
        }

        return isValid;
		}

		function postRequest(strURL) {
			var xmlHttp;
			var exam_id=encodeURIComponent(document.getElementById("exam_id").value)
			var exam_title=encodeURIComponent(document.getElementById("exam_title").value)
			var exam_time=encodeURIComponent(document.getElementById("exam_time").value)
			var exam_centre=encodeURIComponent(document.getElementById("exam_centre").value)
			var exam_date=encodeURIComponent(document.getElementById("exam_date").value)
			var exam_duration=encodeURIComponent(document.getElementById("exam_duration").value)
			var exam_venue=encodeURIComponent(document.getElementById("exam_venue").value)
			var exam_course=encodeURIComponent(document.getElementById("exam_course").value)
			var category="";
			if(exam_course.trim()=="B.Tech" || exam_course.trim()=="B.Arch") 
				category="UG";
			else
				category="PG";
		
			var parameters="exam_id="+exam_id+"&exam_title="+exam_title+"&exam_course="+exam_course+"&exam_date="+exam_date+"&exam_time="+exam_time+"&exam_centre="+exam_centre+"&exam_duration="+exam_duration+"&exam_venue="+exam_venue+"&category="+category+"&flag=<%=flag%>";

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
			//xmlHttp.send(strURL);
		}

		function updatepage(str){
			document.getElementById("resultCell").innerHTML = "Result : "+str;
			  document.getElementById("exam_time").style.backgroundColor = '#fff';
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
			<form id='examform' name="examform">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
		<tr>

		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty are highlighted in red
		</td>
	</tr>
						<tr><td colspan=2 class="button navy gradient"><%=headerLabel%></td></tr>
						<tr><td colspan=2>&nbsp;</td></tr>
							<input type="hidden" id="exam_id" name="exam_id" value='<%=exam_id%>'/>
							<tr><td >Exam Title&nbsp;<font color="red">*</font></td><td><input type="text"  id="exam_title" name="exam_title" size="50" class="required" maxlength="100"  value='<%=exam_title%>'/></td></tr>
							
							<tr>
							<td >Course&nbsp;<font color="red">*</font></td>
							<td>
							<!-- <input type="text" name="exam_course" size="50" class="required" maxlength="50"  id="exam_course" value='<%=exam_course%>'/> -->
							<select name="exam_course" id="exam_course" class="required">
								<option value="">Select Course</option>
								<option value="B.Tech">B.Tech</option>
								<option value="B.Arch">B.Arch</option>
								<option value="M.Tech">M.Tech</option>
								<option value="MCA">MCA</option>
								<option value="MBA">MBA</option>
								<option value="BA">BA</option>
								<option value="B.Sc">B.Sc</option>
								<option value="B.Com">B.Com</option>
								<option value="BBA">BBA</option>
								<option value="BCA">BCA</option>
								<option value="M.Sc">M.Sc</option>
						<!-- for( int i=0; i<alCourseGroup.size(); i++) {
							<option value="alCourseGroup.get(i) ">alCourseGroup.get(i) </option>
							} -->
							</select>
							</td>
							</tr>
							<tr><td >Exam Centre&nbsp;<font color="red">*</font></td><td><input type="text" name="exam_centre" id="exam_centre" class="required" value='<%=exam_centre%>'/></td></tr>
							<tr><td >Exam Date&nbsp;<font color="red">*</font></td><td><input type="text" name="exam_date" id="exam_date" class="required" value='<%=exam_date%>'/></td></tr>
							<tr><td >Exam Time (HH24:MI)&nbsp;<font color="red">*</font></td><td><input type="text" name="exam_time"  id="exam_time" class="required" value='<%=exam_time%>' /></td></tr>
							<tr><td >Duration (Minutes)&nbsp;<font color="red">*</font></td><td><input type="text" name="exam_duration" size="10" maxlength="10"  id="exam_duration" class="required" value='<%=exam_duration%>'/></td></tr>
							<tr>
							<td >States&nbsp;<font color="red">*</font></td>
							<td>
							<!-- <input type="text" name="exam_course" size="50" class="required" maxlength="50"  id="exam_course" value='<%=exam_course%>'/> -->
							
							<select id="chkstates" multiple="multiple" class="required">
								<option value="">Select State</option>
								<%
								for (int k=0; k< alStates.size() ; k++)
								{
									%>
									<option value="<%=alStates.get(k) %>"><%=alStates.get(k) %></option>
									<%
								}
									%>
                            </select>
							
							</td>
							</tr>
							<tr><td >Exam Venue</td><td><input type="text" name="exam_venue" size="50" maxlength="150"  id="exam_venue" value='<%=exam_venue%>'/></td></tr>
							<input type="hidden" name="category" id="category">
							
							<tr><td  colspan=2>&nbsp;</td></tr>
							<tr>
			<td colspan=2 align=right>
				<input type="button" class="clickButton" value="<%= submitLabel%>" onClick="javascript:addexam()"/>
				&nbsp;&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Cancel" onClick="location.href='ExamList.jsp'"/>
			</td>
							</tr>
							<tr><td  colspan=2>&nbsp;</td></tr>
							<tr><td colspan=2><div id='resultCell'></div></td></tr>
						</table>
						</form>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>