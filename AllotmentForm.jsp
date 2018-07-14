<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, org.apache.commons.lang3.StringEscapeUtils, java.security.*"%>

<%!
public boolean empty(String s)
	{
		if(s== null || s.trim().equals(""))
			return true;
		else
			return false;
	}

public String getClientIpAddr(HttpServletRequest request) {  
        String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;  
    } 
%>
<%
String userID=(String)session.getAttribute("login_id");
System.out.println("Login ID" +session.getAttribute("login_id"));

String strRole=(String)session.getAttribute("role"); 
String strMakerId=(String)session.getAttribute("login_id");

ArrayList alCourses=null;

ArrayList alStates=(ArrayList)application.getAttribute("STATES");

session.setAttribute("strRole",strRole);

ArrayList alCourseGroup=new ArrayList();
ArrayList alCourseID=new ArrayList();
ArrayList alCourseName=new ArrayList();
ArrayList alCourseType=new ArrayList();

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

try{
	
	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("SELECT course_group, course_id, course_name, course_type from course where course_flag='A' order by course_name");
	rs=pst.executeQuery();
	alCourses=new ArrayList();

	while(rs.next()) 
	{
		alCourseGroup.add(rs.getString(1));
		alCourseID.add(rs.getString(2));
		alCourseName.add(rs.getString(3));
		alCourseType.add(rs.getString(4));
		alCourses.add( rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3)+"#"+rs.getString(4));
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
<title>Allotment Form</title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link rel="stylesheet" href="css/jquery.ui.core.css">
	<link rel="stylesheet" href="css/jquery.ui.dialog.css">
	<link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" href="css/jquery.ui.theme.css">
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.form.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
	<script type="text/javascript" src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>


<style type="text/css">

	.ui-widget-content{
	border:0px solid transparent;
	}

  .alertError .ui-dialog-titlebar
  {
      background-color:Red;
  }
</style>

	<script language="javascript">

	function removerr(obj) { $(obj).removeClass("error_input"); }

		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}

		function saveApp() {
			if($("#formPersonal").valid() ) {
				postRequest("AllotmentFormResult.jsp");
			} else 
			{
				displayAlert("You have missed some mandatory Fields");
			}
		}
		
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

		function validateMY(inputField) {
			if(inputField.value.trim()=="")
				return false;

        var isValid = /^([2][0][1]?[0-5])$/.test(inputField.value);

        if (isValid) {
            inputField.style.backgroundColor = '#fff';
        } else {
            inputField.style.backgroundColor = '#fba';
        }

        return isValid;
		}
		
        function edHost() {
  			var sel_hostel=document.getElementById("hostel_reqd").value;
			if(sel_hostel.trim()=="hostel_reqd") {
				document.getElementById("transport_reqd").disabled=false;
			} else {
				document.getElementById("transport_reqd").disabled=true;
			}
		}

		function setPaymentModeOne() {
			if ( getVal("feeFlagOne")=="CASH" )
			{
				document.getElementById('cashPay1').style.display="block";
				document.getElementById('ddPay1').style.display="none";
				document.getElementById('challaPay1').style.display="none";
			}
			else if ( getVal("feeFlagOne")=="DD" )
			{
				document.getElementById('cashPay1').style.display="none";
				document.getElementById('ddPay1').style.display="block";
				document.getElementById('challaPay1').style.display="none";
			}
			else
			{
				document.getElementById('cashPay1').style.display="none";
				document.getElementById('ddPay1').style.display="none";
				document.getElementById('challaPay1').style.display="block";
			}
		}
		
		function setPaymentModeTwo() {
			if ( getVal("feeFlagTwo")=="CASH" )
			{
				document.getElementById('cashPay2').style.display="block";
				document.getElementById('ddPay2').style.display="none";
				document.getElementById('challaPay2').style.display="none";
			}
			else if ( getVal("feeFlagTwo")=="DD" )
			{
				document.getElementById('cashPay2').style.display="none";
				document.getElementById('ddPay2').style.display="block";
				document.getElementById('challaPay2').style.display="none";
			}
			else
			{
				document.getElementById('cashPay2').style.display="none";
				document.getElementById('ddPay2').style.display="none";
				document.getElementById('challaPay2').style.display="block";
			}
		}
		
		function setPaymentModeThree() {
			if ( getVal("feeFlagThree")=="CASH" )
			{
				document.getElementById('cashPay3').style.display="block";
				document.getElementById('ddPay3').style.display="none";
				document.getElementById('challaPay3').style.display="none";
			}
			else if ( getVal("feeFlagThree")=="DD" )
			{
				document.getElementById('cashPay3').style.display="none";
				document.getElementById('ddPay3').style.display="block";
				document.getElementById('challaPay3').style.display="none";
			}
			else
			{
				document.getElementById('cashPay3').style.display="none";
				document.getElementById('ddPay3').style.display="none";
				document.getElementById('challaPay3').style.display="block";
			}
		}
				
		function loadCourseData()
		{
			var getCourseGroup=[];
			var getCourseList=[];
			var getCourseID=[];
			var getCourseType=[];
			var getCourseName=[];


			var getCourse=document.getElementById("course").value;

			<% for(int i=0;i<alCourseGroup.size();i++) { %>
			getCourseGroup.push("<%= alCourseGroup.get(i)%>")
			<% } %>

			<% for(int i=0;i<alCourseType.size();i++) { %>
			getCourseType.push("<%= alCourseType.get(i)%>")
			<% } %>

			<% for(int i=0;i<alCourseName.size();i++) { %>
			getCourseName.push("<%= alCourseName.get(i)%>")
			<% } %>

			for(var i=0;i<getCourseGroup.length;i++)
			{
			if(getCourseGroup[i]==getCourse)
			{
				getCourseID.push(getCourseType[i]);
				getCourseList.push(getCourseName[i]);
			}
			}
			document.formPersonal.branch.options.length=0
			for(var i=0;i<=getCourseID.length;i++)
			{
				document.formPersonal.branch.options[i]=new Option(getCourseList[i],getCourseList[i],false,false); // new Option(getCentre[i],getCentreCode[i],false,false) to new Option(getCentre[i],getCentre[i],false,false) by Alex on 2.4.2015
			}
			}

		function setParams() 
		{
		
			var StudentName=encodeURIComponent(document.getElementById("studentName").value);
			var ParentName=encodedVal("parentName");
			
		
			var Course=encodedVal("course");
			var Branch=encodedVal("branch");
			
			var Scholarship=encodedVal("scholarship");
			var MobileNo=encodedVal("mobileNo");
			var Email=encodedVal("email");
		
			var AdmissionFee=encodedVal("admissionFee");
			
			var PaidAmountOne=encodedVal("paidAmountOne");
			var FeeFlagOne=encodedVal("feeFlagOne");
			
			var CashReceiptNo1=encodedVal("cashReceiptNo1");
			var DraweeBank1=encodedVal("draweeBank1");
			var DdNo1=encodedVal("ddNo1");
			var DdDate1=encodedVal("ddDate1");
	//alert("1.1")
var IPAddr="<%= getClientIpAddr(request) %>";
var parameters="StudentName="+StudentName+
"&ParentName="+ParentName+
"&Course="+Course+
"&Branch="+Branch+
"&Scholarship="+Scholarship+
"&MobileNo="+MobileNo+
"&Email="+Email+
"&AdmissionFee="+AdmissionFee+
"&PaidAmountOne="+PaidAmountOne+
"&FeeFlagOne="+FeeFlagOne+
"&CashReceiptNo1="+CashReceiptNo1+
"&DraweeBank1="+DraweeBank1+
"&DdNo1="+DdNo1+
"&DdDate1="+DdDate1+
"&MakerId=<%=strMakerId%>"+
"&IPAddr="+IPAddr;

			return parameters;
		}

		function encodedVal(str) {
			return encodeURIComponent(document.getElementById(str).value);
		}
		function getVal(str) {
			return document.getElementById(str).value;
		}
		
		function postRequest(strURL) {
		//alert("1");
		var parameters=setParams();
//alert("2");
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			//alert(parameters);
			xmlHttp.open('POST', strURL, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatePage(xmlHttp.responseText);
				}
			}
		}
		
		function getAllotmentLeter() {
			//alert("alot");
				location.href='AllotmentLetterPDF.jsp?AllotNo='+document.getElementById("allotmentNo").value;
			}
		
		function updatePage(str){
			StopLoading();
			if(str.trim()=="0002".trim()) 
			{
				displayError("Result : Error while submitting Admission form. Mobile Number Exists",'goHome');
			} else if(str.trim()=="0001".trim()) 
			{
				displayError("Result : Error while submitting Admission form. Please Contact Administrator",'goHome');
			}
			else
			{
				document.getElementById("allotmentNo").value=str;
				alert("Result : Your Allotment form has been submitted. Allotment No :" + document.getElementById("allotmentNo").value);
				//generateAllotment(str);
				getAllotmentLeter();
				//location.reload();
			}			
		}
		
		function generateAllotment(allotNo) {
		//alert("1");
		
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			var url="AllotmentLetterPDF.jsp";
			xmlHttp.open('POST', url, true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send("&AllotNo="+allotNo.trim());
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					//openPdf(event, allotNo);
				}
			}
		}
		
		
		function openPdf(e, allotNo) 
		{
        // stop the browser from going to the href
        e = e || window.event; // for IE
        e.preventDefault(); 

		//var path=file:///C:/Allotment_Letter/BHA20150057.pdf;
		//alert("1"+path);
        // launch a new window with your PDF
        window.open('C:/Allotment_Letter/BHA20150057.pdf');
		//alert("c:\\Allotment_Letter\\"+allotNo+".pdf");

        // redirect current page to new location
        //window.location = redirect;
		}
	
		
		function cancel(){
			location.href='Home.jsp';
		}

		$(function() {			
			
			$( "#appDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#appDate').datepicker().trigger('change');
			
            $( "#dob" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "1985:1999",
				defaultDate: new Date(1985,01,01)	
				});
			$('#dob').datepicker().trigger('change');
			
			$( "#ddDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDate1').datepicker().trigger('change');
			
			$( "#ddDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDate2').datepicker().trigger('change');
			
			$( "#ddDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDate3').datepicker().trigger('change');

			$( "#challanDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanDate1').datepicker().trigger('change');

			$( "#challanDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanDate2').datepicker().trigger('change');

			$( "#challanDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanDate3').datepicker().trigger('change');			
	});

	function disablePayment()
	{
		document.getElementById('cashPay1').style.display="none";
		document.getElementById('ddPay1').style.display="none";
		//document.getElementById('challaPay1').style.display="none";
		
		/* document.getElementById('cashPay2').style.display="none";
		document.getElementById('ddPay2').style.display="none";
		document.getElementById('challaPay2').style.display="none";
		
		document.getElementById('cashPay3').style.display="none";
		document.getElementById('ddPay3').style.display="none";
		document.getElementById('challaPay3').style.display="none"; */
	}
</script>
<%@include file="MBHandler.jsp" %>
</head>
<!-- <td colspan=2><div id='resultCell'></div></td> -->
<body onLoad="disablePayment();">
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

	<form id="formPersonal" name="formPersonal" method="post" autocomplete="on" >
	<table id="maintab" class="formtab textbox_medium tbl_p3 textarea_normal " >
	<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty / Fields with Invalid values are highlighted in red
		</td>
	</tr>

	<tr>
	<td colspan="2" class="button navy gradient">Personal Details</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<!--
	<tr>
		<td>Application Number<font color="red">*</font></td>
		<td><input type="text" id="appNo" name="appNo" class="required" size=30 maxlength=30 value=""/>
		</td>
	</tr>
	<tr>
		<td>Applied Date<font color="red">*</font></td>
		<td><input type="text" id="appDate" name="dob" readonly="readonly" class="required" size=30 maxlength=30 value=""/>
		</td>
	</tr>
	-->
	<tr>
		<td>Candidate Name<font color="red">*</font> </td>
		<td><input type="text" id="studentName" name="studentName"  value='' size=30 maxlength=250 class="" title="As it appears in your 10th/12th Standard Mark sheet" /></td>
	</tr>
	<tr>
		<td>Father Name<font color="red">*</font></td>
		<td><input type="text" id="parentName" name="parentName" size=30 maxlength=30 value=""/>
		</td>
	</tr>
<!--
	<tr>
		<td>Date of Birth<font color="red">*</font></td>
		<td align=left nowrap>
		<input size=30 type="text" class="required" name="dob" value="" readonly="readonly" value=''  id="dob"/>
		</td>
	</tr>
	<tr>
		<td>Gender<font color="red">*</font></td>
		<td align=left nowrap>
		<select id="gender" class="required" STYLE="width: 210px">
			<option value="" >Select Gender</option>
			<option value="M">Male</option>
			<option value="F">Female</option>
			<option value="O">Others</option>
		</select>
		</td>
	</tr>
		
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Course Choices</td></tr>-->
	<tr>
	<td>Course<font color="red">*</font></td>
	<td>
	<select id="course" onChange='javascript:loadCourseData()' STYLE="width: 210px">
	
		<option value="">Select</option>
		<option value="B.Tech">B.Tech</option>
		<option value="B.Arch">B.Arch</option>
		<option value="BA">BA</option>
		<option value="B.Sc">B.Sc</option>
		<option value="B.Com">B.Com</option>
		<option value="BBA">BBA</option>
		<option value="BCA">BCA</option>
		<option value="M.Tech">M.Tech</option>
		<option value="M.Sc">M.Sc</option>
		<option value="MCA">MCA</option>
		<option value="MBA">MBA</option>
	</select>
	</td>
	</tr>


	<tr>
		<td>Branch<font color="red">*</font></td>
		<td>
		<select id="branch" name="branch" STYLE="width: 300px">
			<option value="">Select a Course</option>
		</select>
		</td>
		</tr>
<!--	
	<tr>
		<td>Student Type<font color="red">*</font></td>
		<td>
		<select id="studentType" name="studentType" STYLE="width: 110px">
			<option value="">Select</option>
			<option value="FRESH">Full Time/Fresh</option>
			<option value="LATERAL">Lateral</option>
			<option value="LATERAL">Part Time</option>
		</select>
		</td>
	</tr>					
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Address Details</td></tr>
	<tr>
		<td>Permanent Address<font color="red">*</font></td>
		<td><textarea required="required" rows="4" cols="30" maxlength=120 id="address" name="address" title="Please enter Door No, Apartment No, Street Name, Area Name"></textarea></td>
	</tr>
	<tr>
		<td>City</td>
		<td><input type="text" id="city" name="city" value=""  size="30" maxlength=20 /></td>
	</tr>
	<tr>
		<td>State<font color="red">*</font></td>
		<td>
		<select id="state" name="state" class="required" STYLE="width: 210px">
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
	</tr>
	<tr>
		<td>Country<font color="red">*</font></td>
		<td><input type="text" id="country" name="country"  value=""  class="required" size=30 maxlength=30 /></td>
	</tr>	
	
	<tr>
		<td>STD Code & Phone No</td>
		<td><input type="text" id="stdCode" name="stdCode" size='6' maxlength=5 class="number" value=""/>
		<input type="text" id="phoneNo" name="phoneNo" class="number" value="" size="18" maxlength=12 /></td>
	</tr> -->
	<tr>
		<td>Scholarship</td>
		<td><input type="text" id="scholarship" name="scholarship" value="" size="30" maxlength=6 /></td>
	</tr>
	<tr>
		<td>Mobile No<font color="red">*</font></td>
		<td><input type="text" size=30 id="mobileNo" class="required" name="mobileNo" value="" maxlength=10 /></td>
	</tr>
	<tr>
		<td>Email Address</td>
		<td><input type="text" size=30 id="email" name="email" value="" size=30 maxlength=30 /></td>
			<input type="hidden" id="allotmentNo" name="allotmentNo" value=""/>
	<tr><td colspan=2>&nbsp;</td></tr>
	<!--
	<tr>
		<td colspan="2" class="button navy gradient">Admission Details</td>
	</tr>
		<tr>
			<td class='label'><i><b>Admission Status</b></i></td>
			<td>
			<select name="admissionStatus" id="admissionStatus" STYLE="width: 100px"> 
				<option value="SELECTED">Selected</option>
			</select>
			</td>
		</tr>
		<tr>
			<td>PCM Marks<font color="red">*</font></td>
			<td><input type="text" size=10 id="pcmMarks" name="pcmMarks" value="" maxlength=10 /></td>
		</tr>		
		<tr>
			<td class='label'><i><b>Reference</b></i></td>
			<td><input id="reference" name="reference" value="" /></td>
		</tr>
		<tr>
			<td class='label'><i><b>Admission Quota</b></i></td>
			<td>
			<select id="admQuota" name="admQuota" STYLE="width: 110px">
				<option value="">Select</option>
				<option value="MANAGEMENT">Management</option>
				<option value="COUNSELLING">Counselling</option>
			</select>
			</td>
		</tr>
		<tr>
			<td class='label'><i><b>Concession Type</b></i></td>
			<td><input id="concessionType" name="concessionType" value="" /></td>
		</tr>

		<tr><td colspan=2>&nbsp;</td></tr>
		
<tr><td colspan=2 class="button navy gradient">Miscellaneous</td></tr>
	<tr>
		<td>Hostel</td>
		<td>
		<select id="hostelReqd" onChange='javascript:blockTransport()'>
			<option value="">Select</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
		</select> 
		</td>
	</tr>
		
		</td>
	</tr>

<script type="text/javascript">

		function blockTransport() 
		{
			var hostelReq=document.getElementById("hostel_reqd").value;
			if(hostelReq.trim()=="Y") 
			{
				document.getElementById("transport_reqd").disabled=true;
			}
			else if(hostelReq.trim()=="N") 
			{
				document.getElementById("transport_reqd").disabled=false;
			}
		}
		
		function blockHostel() 
		{
			var transReq=document.getElementById("transport_reqd").value;
			if(transReq.trim()=="Y") 
			{
				document.getElementById("hostel_reqd").disabled=true;
			}
			else if(transReq.trim()=="N") 
			{
				document.getElementById("hostel_reqd").disabled=false;
			}
		}
</script>
	<tr>
		<td>Transportation</td>
		<td>
		<select id="transportReqd" onChange='javascript:blockHostel()'>
			<option value="">Select</option>
			<option value="Y">Yes</option>
			<option value="N">No</option>
		</select> 

		</td>
	</tr> -->
	<tr>
		<td colspan="2" class="button navy gradient">Payment</td>
	</tr>
	<tr>
						<td class='label'><i><b>Tuition Fee Fixed</b></i></td>
						<td><input id="admissionFee" name="admissionFee" value="" /></td>
					</tr>
					<!--<tr>
						<td width=30% align=right class="button navy gradient">Payment - I</td>
						</tr>-->
					<tr>
						<td class='label'><i><b>Amount Paid</b></i></td>
						<td><input id="paidAmountOne" name="paidAmountOne" value=""/></td>
					</tr>
					
					<tr>
						<td class='label'>Payment Mode</td>
						<td>
						 <select name="feeFlagOne" id="feeFlagOne" onChange='javascript:setPaymentModeOne()' STYLE="width: 170px"> 
							
								<option value="" selected>Select Payment Mode</option>
							<!--	<option value="CHALLAN">Challan</option>-->
								<option value="CASH">Cash</option>
								<option value="DD">Demand Draft</option>
							
						</select>  
						</td>
					</tr>
					
					<tr>
						<td colspan=2>
						<!--
							<div id='challaPay1'>
							<table>
							<tr>
								<td class='label'>Bank Name</td>
								<td><input id="bankChallan1" name="bankChallan1" value="" /></td>
								<td class='label'>Challan Number</td>
								<td><input id="challanNo1" name="challanNo1" value="" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="challanDate1" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
						-->
							<div id='cashPay1'>
							<table>
							<tr>
							<td class='label'>Cash Receipt No</td>
							<td colspan=3><input id="cashReceiptNo1" name="cashReceiptNo1" value="" /></td>
							</tr>
							</table>
							</div>
							
							<div id='ddPay1'>
							<table>
							<tr>
								<td class='label'>Drawee Bank</td>
								<td><input id="draweeBank1" name="draweeBank1" value="" /></td>
								<td class='label'>DD Number</td>
								<td><input id="ddNo1" name="ddNo1" value=""/></td>
								<td class='label'>Drawn On</td>
								<td><input type="text" id="ddDate1" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							
						</td>
					</tr>
					<!--
					<tr>
						<td width=30% align=right class="button navy gradient">Payment - II</td>
						</tr>
					<tr>
						<td class='label'><i><b>Amount Paid</b></i></td>
						<td><input id="paidAmountTwo" name="paidAmountTwo" value="" /></td>
					</tr>
					
					<tr>
						<td class='label'>Payment Mode</td>
						<td>
						 <select name="feeFlagTwo" id="feeFlagTwo" onChange='javascript:setPaymentModeTwo()' STYLE="width: 170px"> 
							
								<option value="" selected>Select Payment Mode</option>
								<option value="CHALLAN">Challan</option>
								<option value="CASH">Cash</option>
								<option value="DD">Demand Draft</option>
							
						</select>  
						</td>
					</tr>
					
					<tr>
						<td colspan=2>
						
							<div id='challaPay2'>
							<table>
							<tr>
								<td class='label'>Bank Name</td>
								<td><input id="bankChallan2" name="bankChallan2" value="" /></td>
								<td class='label'>Challan Number</td>
								<td><input id="challanNo2" name="challanNo2" value="" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="challanDate2" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							
							<div id='cashPay2'>
							<table>
							<tr>
							<td class='label'>Cash Receipt No</td>
							<td colspan=3><input id="cashReceiptNo2" name="cashReceiptNo2" value="" /></td>
							</tr>
							</table>
							</div>
							
							<div id='ddPay2'>
							<table>
							<tr>
								<td class='label'>Drawee Bank</td>
								<td><input id="draweeBank2" name="draweeBank2" value="" /></td>
								<td class='label'>DD Number</td>
								<td><input id="ddNo2" name="ddNo2" value="" /></td>
								<td class='label'>Drawn On</td>
								<td><input type="text" id="ddDate2" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							
						</td>
					</tr>
					
					<tr>
						<td width=30% align=right  class="button navy gradient">Payment - III</td>
						</tr>
					<tr>
						<td class='label'><i><b>Amount Paid</b></i></td>
						<td><input id="paidAmountThree" name="paidAmountThree" value="" /></td>
					</tr>
					
					<tr>
						<td class='label'>Payment Mode</td>
						<td>
						 <select name="feeFlagThree" id="feeFlagThree" onChange='javascript:setPaymentModeThree()' STYLE="width: 170px"> 
							
								<option value="" selected>Select Payment Mode</option>
								<option value="CHALLAN">Challan</option>
								<option value="CASH">Cash</option>
								<option value="DD">Demand Draft</option>
							
						</select>  
						</td>
					</tr>
					
					<tr>
						<td colspan=2>
							<div id='challaPay3'>
							<table>
							<tr>
								<td class='label'>Bank Name</td>
								<td><input id="bankChallan3" name="bankChallan3" value="" /></td>
								<td class='label'>Challan Number</td>
								<td><input id="challanNo3" name="challanNo3" value="" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="challanDate3" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							
							<div id='cashPay3'>
							<table>
							<tr>
								<td class='label'>Cash Receipt No</td>
								<td colspan=3><input id="cashReceiptNo3" name="cashReceiptNo3" value="" /></td>
							</tr>
							</table>
							</div>
							
							<div id='ddPay3'>
							<table>
							<tr>
								<td class='label'>Drawee Bank</td>
								<td><input id="draweeBank3" name="draweeBank3" value="" /></td>
								<td class='label'>DD Number</td>
								<td><input id="ddNo3" name="ddNo3" value="" /></td>
								<td class='label'>Drawn On</td>
								<td><input type="text" id="ddDate3" value="" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							
						</td>
					</tr>
					-->

</table>
</form>
<table id="maintab2" class="formtab textbox_medium tbl_p3 textarea_normal " >
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
			
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
	<tr>
		<td align=center>
							
			<input type="button" class="clickButton" value="Generate Allotment Letter" onClick='javascript:saveApp()'/>
		</td>

<!--	 <td>
	 <input type="button" class="clickButton" value="Download Allotment" onClick="javascript:getAllotmentLeter()"/>&nbsp;
	 </td>-->
	 </tr>
	 
	<tr><td colspan=2>&nbsp;</td></tr>

	
</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
<%@include file="ToolTip.jsp" %>
  <div id="dialog-message" style="display:none;" title="Message"><p id="diaMsg" style="width:auto;"></p></div>
 
</body>
</html>