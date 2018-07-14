<%@page import="java.sql.*, java.io.*, campus.*, java.util.*,  java.math.BigDecimal, org.apache.commons.lang3.StringEscapeUtils, java.security.*"%>
<%!
public boolean empty(String s)
	{
		if(s== null || s.trim().equals(""))
			return true;
		else
			return false;
	}

public String isNull(String s)
	{
		if(s== null || s.intern()=="null".intern())
			return "";
		else
			return s;
	}
%>
<%
ResourceBundle rb=ResourceBundle.getBundle("admission",new Locale("en", "US"));
String flag=request.getParameter("flag");
String exam_id=request.getParameter("exam_id");
String strRole=(String)session.getAttribute("role");
String mkr_id=(String)session.getAttribute("login_id");
ArrayList alCourses=(ArrayList)application.getAttribute("COURSES");
System.out.println("alCourses"+alCourses);
Board objBoard=new Board();
if(flag==null)
	flag="I";
String appn_no="";
String first_name="";
String last_name="";
String gender="";
String religion="";
String nationality="";
String dob="";
String community="";
String blood_group="";
String mother_tongue="";
String adm_type="";
String course_type="";
String course="";
String choice_1="";
String choice_2="";
String choice_3="";
String sports_achv="";
String valid_score_of="";
String exam_attended="";
String email_id="";
String address="";
String city="";
String state="";
String country="";
String pin_code="";
String std_code="";
String phone_no="";
String mobile_no="";
String parent_name="";
String guardian_name="";
String relationship="";
String g_relationship="";
String parent_occupation="";
String hsc_school="";
String hsc_city="";
String hsc_board="";
String hsc_regn_no="";
String hsc_mon_yop="";
String hsc_marks="";
String hsc_outof="";
String sslc_school="";
String sslc_city="";
String sslc_board="";
String sslc_regn_no="";
String sslc_mon_yop="";
String sslc_marks="";
String sslc_outof="";
String oth_exam_1="-";
String oth_college_1="-";
String oth_city_1="-";
String oth_university_1="-";
String oth_regn_no_1="-";
String oth_mon_yop_1="-";
String oth_marks_1="-";
String oth_outof_1="";
String oth_exam_2="-";
String oth_college_2="-";
String oth_city_2="-";
String oth_university_2="-";
String oth_regn_no_2="-";
String oth_mon_yop_2="-";
String oth_marks_2="-";
String oth_outof_2="";
String oth_exam_3="-";
String oth_college_3="-";
String oth_city_3="-";
String oth_university_3="-";
String oth_regn_no_3="-";
String oth_mon_yop_3="-";
String oth_marks_3="-";
String oth_outof_3="";
String quota="";
String medium_of_instr="";
String optional_subject="";
String hostel_reqd="";
String transport_reqd="";
String drawee_bank="";
String dd_number="";
String dd_date="";
String amount="";
String remarks="";
String appn_status="";
String pay_status="";
String payment_status="";
String userid="";
BigDecimal sslc_perc=new BigDecimal(0);
BigDecimal hsc_perc=new BigDecimal(0) ;
BigDecimal oth_per_1=new BigDecimal(0) ;
BigDecimal oth_per_2=new BigDecimal(0) ;
BigDecimal oth_per_3=new BigDecimal(0) ;
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
try{
	if(flag.intern()=="U".intern() || flag.intern()=="A".intern() ) {
		appn_no=request.getParameter("appn_no");
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select first_name,ifnull(last_name,'') last_name,gender,religion,nationality,dob,community,blood_group,lang_name,adm_type,course_type,course,choice_1,choice_2,choice_3,quota, sports_achv,valid_score_of, exam_attended, email_id, address,city,state,country,pin_code,std_code,phone_no,mobile_no,parent_name, guardian_name,relationship, ifnull(g_relationship,'') g_relationship, parent_occupation,hsc_school,hsc_city,hsc_board,hsc_regn_no,hsc_mon_yop,hsc_marks,hsc_outof,sslc_school,sslc_city,sslc_board,sslc_regn_no,sslc_mon_yop,sslc_marks,sslc_outof, oth_exam_1,oth_college_1,oth_city_1,oth_university_1,oth_regn_no_1,oth_mon_yop_1,oth_marks_1,oth_outof_1,oth_exam_2,oth_college_2,oth_city_2,oth_university_2,oth_regn_no_2,oth_mon_yop_2,oth_marks_2,oth_outof_2,oth_exam_3,oth_college_3,oth_city_3,oth_university_3,oth_regn_no_3,oth_mon_yop_3,oth_marks_3,oth_outof_3,medium_of_instr,optional_subject,hostel_reqd,transport_reqd,dd_number,dd_date,amount,drawee_bank,appn_status, exam_id,mkr_id, pay_status from application a,language l where a.mother_tongue=l.lang_code and appn_no=?");
		pst.setString(1, appn_no);
		System.out.println("appApp2="+pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			first_name=rs.getString("first_name");
			last_name=rs.getString("last_name");
			gender=rs.getString("gender");
			religion=rs.getString("religion");
			nationality=rs.getString("nationality");
			dob=rs.getString("dob");
			community=rs.getString("community"); //community=rb.getString("COMM_"+rs.getString("community"));
			blood_group=rs.getString("blood_group");
			mother_tongue=rs.getString("lang_name");
			adm_type=isNull(rs.getString("adm_type"));
			
			course_type=rs.getString("course_type");
			if(course_type==null)
				course_type="NA";
			course=rs.getString("course");
			System.out.println("Course -> "+course);
			Course objCourse=new Course();
 			choice_1=objCourse.getCourseName(rs.getString("choice_1"));
			choice_2=objCourse.getCourseName(rs.getString("choice_2"));
			choice_3=objCourse.getCourseName(rs.getString("choice_3"));
			quota=rs.getString("quota");
			if(quota==null) quota="";
			sports_achv=rs.getString("sports_achv");
			valid_score_of=rs.getString("valid_score_of");
			exam_attended=rs.getString("exam_attended");
			email_id=rs.getString("email_id");
			address=StringEscapeUtils.escapeJava(rs.getString("address"));
			System.out.println("Address "+address);
			city=rs.getString("city");
			state=rs.getString("state");
			country=rs.getString("country");
			pin_code=rs.getString("pin_code");
			std_code=rs.getString("std_code");
			phone_no=rs.getString("phone_no");
			mobile_no=rs.getString("mobile_no");
			parent_name=rs.getString("parent_name");
			guardian_name=rs.getString("guardian_name");
			System.out.println("1");
			relationship=rs.getString("relationship");
			g_relationship=rs.getString("g_relationship");
			parent_occupation=rs.getString("parent_occupation");
			System.out.println("2");
			hsc_school=rs.getString("hsc_school");
			hsc_city=isNull(rs.getString("hsc_city"));
			hsc_board=objBoard.getBoardName(rs.getString("hsc_board"));
			hsc_regn_no=rs.getString("hsc_regn_no");
			hsc_mon_yop=rs.getString("hsc_mon_yop");
			hsc_marks=rs.getString("hsc_marks");
			hsc_outof=rs.getString("hsc_outof");
			if(hsc_marks==null || hsc_marks.intern()=="-".intern() || hsc_marks.intern()=="".intern())
				hsc_marks="0";
			if(hsc_outof==null || hsc_outof.intern()=="-".intern() || hsc_outof.intern()=="".intern() || hsc_outof.intern()=="0".intern())
				hsc_outof="1";
			sslc_school=rs.getString("sslc_school");
			sslc_city=isNull(rs.getString("sslc_city"));
			sslc_board=objBoard.getBoardName(rs.getString("sslc_board"));
			sslc_regn_no=rs.getString("sslc_regn_no");
			sslc_mon_yop=rs.getString("sslc_mon_yop");
			sslc_marks=rs.getString("sslc_marks");
			sslc_outof=rs.getString("sslc_outof");
			if(sslc_marks==null || sslc_marks.intern()=="-".intern() || sslc_marks.intern()=="".intern())
				sslc_marks="0";
			if(sslc_outof==null || sslc_outof.intern()=="-".intern() || sslc_outof.intern()=="".intern()  || sslc_outof.intern()=="0".intern())
				sslc_outof="1";
			oth_exam_1=rs.getString("oth_exam_1");
			oth_college_1=rs.getString("oth_college_1");
			oth_city_1=isNull(rs.getString("oth_city_1"));
			oth_university_1=rs.getString("oth_university_1");
			oth_regn_no_1=rs.getString("oth_regn_no_1");
			oth_mon_yop_1=rs.getString("oth_mon_yop_1");
			oth_marks_1=rs.getString("oth_marks_1");
			oth_outof_1=rs.getString("oth_outof_1");
			if(oth_marks_1==null || oth_marks_1.intern()=="-".intern() || oth_marks_1.intern()=="".intern())
				oth_marks_1="0";
			if(oth_outof_1==null || oth_outof_1.intern()=="-".intern() || oth_outof_1.intern()=="".intern() || oth_outof_1.intern()=="0".intern())
				oth_outof_1="1";
			oth_exam_2=rs.getString("oth_exam_2");
			oth_college_2=rs.getString("oth_college_2");
			oth_city_2=isNull(rs.getString("oth_city_2"));
			oth_university_2=rs.getString("oth_university_2");
			oth_regn_no_2=rs.getString("oth_regn_no_2");
			oth_mon_yop_2=rs.getString("oth_mon_yop_2");
			oth_marks_2=rs.getString("oth_marks_2");
			oth_outof_2=rs.getString("oth_outof_2");
			System.out.println("hsc_perc" +oth_marks_2+"::"+oth_outof_2);
			if(oth_marks_2==null || oth_marks_2.intern()=="-".intern() || oth_marks_2.intern()=="".intern())
				oth_marks_2="0";
			if(oth_outof_2==null || oth_outof_2.intern()=="-".intern() || oth_outof_2.intern()=="".intern() || oth_outof_2.intern()=="0".intern())
				oth_outof_2="1";
			oth_exam_3=rs.getString("oth_exam_3");
			oth_college_3=rs.getString("oth_college_3");
			oth_city_3=isNull(rs.getString("oth_city_3"));
			oth_university_3=rs.getString("oth_university_3");
			oth_regn_no_3=rs.getString("oth_regn_no_3");
			oth_mon_yop_3=rs.getString("oth_mon_yop_3");
			oth_marks_3=rs.getString("oth_marks_3");
			oth_outof_3=rs.getString("oth_outof_3");
			 if(oth_marks_3==null || oth_marks_3.intern()=="-".intern() || oth_marks_3.intern()=="".intern())
				oth_marks_3="0";
			if(oth_outof_3==null || oth_outof_3.intern()=="-".intern() || oth_outof_3.intern()=="".intern() || oth_outof_3.intern()=="0".intern())
				oth_outof_3="1";
					
			medium_of_instr=rs.getString("medium_of_instr");
			optional_subject=rs.getString("optional_subject");
			hostel_reqd=rs.getString("hostel_reqd");
			transport_reqd=rs.getString("transport_reqd");
            System.out.println("Printing"+medium_of_instr+optional_subject+hostel_reqd+transport_reqd);
			dd_number=rs.getString("dd_number");
			dd_date=rs.getString("dd_date");
			amount=rs.getString("amount");
			drawee_bank=rs.getString("drawee_bank");
			dd_number=(dd_number==null)?"":dd_number;
			dd_date=(dd_date==null)?"":dd_date;
			amount=(amount==null)?"":amount;
			drawee_bank=(drawee_bank==null)?"":drawee_bank;
			appn_status=rs.getString("appn_status");
			pay_status=rs.getString("pay_status");
			exam_id=rs.getString("exam_id");
			userid=rs.getString("mkr_id");
		}
		if(pay_status==null)
			pay_status="";
		if(pay_status.intern()=="N".intern() || pay_status.intern()=="S".intern()) {
		payment_status="Not Paid";
		} else if(pay_status.intern()=="C".intern()) {
		payment_status="Application Fee Paid";
		} else if(pay_status.intern()=="I".intern()) {
		pay_status="Payment Initiated but not completed";
		}
		sslc_perc=new BigDecimal(( Double.parseDouble(sslc_marks) / Double.parseDouble(sslc_outof)) *100) ;
		System.out.println("sslc_perc" +sslc_perc);
		hsc_perc=new BigDecimal(( Double.parseDouble(hsc_marks) / Double.parseDouble(hsc_outof)) *100) ;
		System.out.println("hsc_perc" +oth_marks_1+"::"+oth_outof_1);
		oth_per_1=new BigDecimal(( Double.parseDouble(oth_marks_1) / Double.parseDouble(oth_outof_1)) *100) ;
        oth_per_2=new BigDecimal(( Double.parseDouble(oth_marks_2) / Double.parseDouble(oth_outof_2)) *100);
        oth_per_3=new BigDecimal(( Double.parseDouble(oth_marks_3) / Double.parseDouble(oth_outof_3)) *100) ;
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
<title><%= (strRole.intern()=="ADMIN".intern())?"Review and Approve Application":"Submit an Application" %></title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
    <link href="Styles/superfish-native.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="css/jquery.ui.core.css">
	<link rel="stylesheet" href="css/jquery.ui.dialog.css">
	<link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" href="css/jquery.ui.theme.css">
	
	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.validation.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
<script src="Scripts/jquery-ui.js" type="text/javascript"></script>

	<!-- <script type="text/javascript" src="ui/minified/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="ui/minified/jquery.ui.core.min.js"></script>
	<script type="text/javascript" src="ui/prettify.js"></script>
	<script type="text/javascript" src="ui/minified/jquery.ui.widget.min.js"></script>
	<script type="text/javascript" src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script type="text/javascript" src="ui/jquery.validation.js"></script>
	<script type="text/javascript" src="ui/stuHover.js"></script>

	<link rel="stylesheet" href="css/jquery.ui.all.css">
	<link rel="stylesheet" href="css/jquery.ui.multiselect.css">
	<link rel="stylesheet" href="css/demos.css">
	<link rel="stylesheet" href="css/pro_dropdown_2.css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />
 -->	<script language="javascript">
		var arrCourses=new Array(<%=alCourses.size() %>);
		<%
		for (int k=0; k< alCourses.size() ; k++)
		{
			%>
			arrCourses[<%=k%>]=new Array(3);
			var val='<%=alCourses.get(k).toString()%>'.split("#");
			arrCourses[<%=k%>][0]=val[0];
			arrCourses[<%=k%>][1]=val[1];
			arrCourses[<%=k%>][2]=val[2];
			<%
		}
			%>
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}
		function admitStudent() {
			postRequest("AdmitStudent.jsp");
		}
		function saveApp() {
			if($("#formPersonal").valid() && $("#formCourse").valid()) {
				postRequest("SubmitApplicationResult.jsp","Y");
			}
		}
		function submitApp() {
			if(! $("#formPersonal").valid() ) {
						postRequest("SubmitApplicationResult.jsp","N");
			}
		}
		function approveApp() {
			postRequest2("ApproveApplication.jsp","A");
		}
		function rejectApp() {
		    var rej_reason=document.getElementById("rej_reason").value;
		    var remarks=document.getElementById("remarks").value;
			 if (rej_reason.length==0){
				alert("Please provide Reason for Rejection");
				 return;
			 }

			 if (remarks.length==0){
				alert("Please provide remarks for Rejection");
				 return;
			 }
			else{
				if(confirm("Are you sure you want to Reject?")) {
					postRequest2("ApproveApplication.jsp","R");
				}
			}
		}
		function payment() {
			document.payuForm.submit();
		}

		function setPaymentMode() {
			if ( getVal("appfee_flag")=="CASH" )
			{
				document.getElementById('cash_pay').style.display="block";
				document.getElementById('dd_pay').style.display="none";
				document.getElementById('online_pay').style.display="none";
			}
			if ( getVal("appfee_flag")=="DD" )
			{
				document.getElementById('cash_pay').style.display="none";
				document.getElementById('dd_pay').style.display="block";
				document.getElementById('online_pay').style.display="none";
			}
			if ( getVal("appfee_flag")=="ONLINE" )
			{
				document.getElementById('cash_pay').style.display="none";
				document.getElementById('dd_pay').style.display="none";
				document.getElementById('online_pay').style.display="block";
			}
		}
		function postRequest2(strURL,aflag) {
			var parameters=setParams();
			//alert(document.getElementById('rej_reason').value);
			if(document.getElementById('rej_reason').value=="LACK_OF_INFO") {
				aflag="D";
			}
			parameters+="&aflag="+aflag;
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
			//xmlHttp.send(strURL);
		}
		function updatepage2(str){
			//document.getElementById("resultCell").innerHTML = "<b><FONT SIZE=2>Result : "+str+"</FONT></b>";
			if(confirm(str.trim()+"\n"+"Move back to Application List?")) {
				window.history.back();
			}
		}
		function addCompany() {
			location.href='AddCompany.jsp';
		}
		function setParams() {
			var dd_number=encodedVal("dd_number");
			var dd_date=encodedVal("dd_date");
			var drawee_bank=encodedVal("drawee_bank");
			var amount=encodedVal("amount");
			var exam_id=encodedVal("exam_id");
			var appfee_flag=encodedVal("appfee_flag");
			var appfee_rcp_no=encodedVal("appfee_rcp_no");
			var remarks=encodedVal("remarks");
			var rej_reason=encodedVal("rej_reason");

			var adm_dd_number='';
			var adm_dd_date='';
			var adm_drawee_bank='';
			var adm_amount='';
			var adm_course='';
			var adm_branch='';
			var section='';
			var regn_no='';
			var hostel_room='';
			var adm_remarks='';
			var docs_collected='';
			var trn_board_point="";
			<%
				if( (strRole.intern()=="ADMIN".intern()) && (flag.intern()=="A".intern()) ) {
			%>
			/*
			adm_dd_number=encodedVal("adm_dd_number");
			adm_dd_date=encodedVal("adm_dd_date");
			adm_drawee_bank=encodedVal("adm_drawee_bank");
			adm_amount=encodedVal("adm_amount");
			*/
			adm_course=encodedVal("adm_course");
			adm_branch=encodedVal("adm_branch");
			section=encodedVal("section");
			regn_no=encodedVal("regn_no");
			hostel_room=encodedVal("hostel_room");
			adm_remarks=encodedVal("adm_remarks");
			trn_board_point=encodedVal("trn_board_point");
			var docs='';
			docs=((document.getElementById("hsc_marks").checked)?document.getElementById("hsc_marks").value:'')+'|'+
			((document.getElementById("ssl_marks").checked)?document.getElementById("ssl_marks").value:'')+'|'+
			((document.getElementById("conduct_cert").checked)?document.getElementById("conduct_cert").value:'');
			docs_collected=encodeURIComponent(docs);
			<%
			}
			%>

			var parameters="dd_number="+dd_number+"&dd_date="+dd_date+"&drawee_bank="+drawee_bank+"&amount="+amount+"&adm_course="+adm_course+"&adm_branch="+adm_branch+"&section="+section+"&regn_no="+regn_no+"&hostel_room="+hostel_room+"&adm_remarks="+adm_remarks+"&docs_collected="+docs_collected+"&exam_id="+exam_id+"&flag=<%=flag%>&appn_no=<%=appn_no%>&mkr_id=<%=mkr_id%>"+"&appfee_flag="+appfee_flag+"&appfee_rcp_no="+appfee_rcp_no+"&trn_board_point="+trn_board_point+"&remarks="+remarks+"&rej_reason="+rej_reason;
			// "&adm_dd_number="+adm_dd_number+"&adm_dd_date="+adm_dd_date+"&adm_drawee_bank="+adm_drawee_bank+"&adm_amount="+adm_amount+
			return parameters;
		}
		function encodedVal(str) {
			return encodeURIComponent(document.getElementById(str).value);
		}
		function getVal(str) {
			return document.getElementById(str).value;
		}
		function postRequest(strURL, draft) {
			var parameters=setParams();
			parameters+="&draft="+draftFlag;
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
			//xmlHttp.send(strURL);
		}
		function updatepage(str){
			document.getElementById("resultCell").innerHTML = "<b><FONT SIZE=2>Result : "+str+"</FONT></b>";
		}
		function cancel(){
			location.href='Home.jsp';
		}
		$(function() {
            document.getElementById('cash_pay').style.display="none";
			document.getElementById('dd_pay').style.display="none";
			document.getElementById('online_pay').style.display="none";
		});
</script>
<%@include file="MBHandler.jsp" %>
</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
    <!-- <table width="90%" align="center"> -->
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<form id="formPersonal" name="formPersonal" action="" method="post">
	<TR>
			<td >&nbsp;</td>
</tr>
	<TR>
			<td colspan="2" class="button navy gradient">Personal Details</td>
</tr>
<tr>
	<td colspan=2>
							<input type='hidden' name='exam_id' id='exam_id' value='<%=exam_id%>'>
							<table class=" valign_top textbox_medium tbl_p5 textarea_normal" style="width: 100%">
								<tr>
								<td>
							<table class=" valign_top textbox_medium tbl_p5 textarea_normal" align="left">
										<tr>
											<td class='label'>Candidate Name</td>
											<td><%=first_name %>&nbsp;<%=last_name %></td>
										</tr>
										<tr>
											<td><label for="gender"  width='200px'>Gender</td>
											<td><%=gender %></td>
										</tr>
										<tr>
											<td class='label'>Date of Birth</td>
											<td><%=dob %></td>
										</tr>
										<tr>
											<td class='label'>Nationality</td>
											<td><%=nationality %></td>
										</tr>
										<tr>
											<td class='label'>Religion</td>
											<td><%=religion %></td>
										</tr>
										<tr>
											<td class='label'>Community</td>
											<td><%=community %></td>
										</tr>
										<tr>
											<td class='label'>Blood Group</td>
											<td><%=blood_group %></td>
										</tr>
										<tr>
											<td class='label'>Mother Tongue</td>
											<td><%=mother_tongue %></td>
										</tr>
										<% if (course_type.intern()=="NA".intern()) { %>
									   <tr>
											<td class='label'>Concessions</td>
											<td><%=quota%></td>
										</tr>
										<% if(quota.equals("SPORTS")){%>
										<tr>
											<td class='label'>Sports Achievements</td>
											<td><%=sports_achv %></td>
										</tr>
										<%}}%>
										<tr>
											<td class='label'>Parent Name & Relationship</td>
											<td><%=parent_name %>, <%=relationship %></td>
										</tr>
										<tr>
											<td class='label'>Guardian Name & Relationship</td>
											<td><%=guardian_name %>, <%=g_relationship %></td>
										</tr>
										<tr>
											<td class='label'>Parent's Occupation</td>
											<td><%=parent_occupation %></td>
										</tr>
										</table>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td>
										<img src="/photos/<%=userid%>.jpg" width="160" height="200" border="0" alt="" align="right"><BR><BR>
										<img src="/signature/<%=userid%>.jpg" width="160" height="50" border="0" alt="" align="right">
									</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
							<td colspan="2" class="button navy gradient">Course Choices</td>
								</tr>
								<% if (course.equals("B.Tech") || course.equals("B.Arch"))  { %>
								<tr>
									<td class='label' width="20%">Admission Type</td>
									<td><%=adm_type %></td>
								</tr>
								<%}%>
								<%if ( !(course.equals("B.Tech") || course.equals("B.Arch"))){%>
								<tr> 
									<td class='label' width="20%">Course Type</td>
									<td><%=course_type %></td>
								</tr>
								<%}%>
								<tr>
									<td class='label'>Course</td>
									<td><%=course %></td>
								</tr>
								<% if (course.equals("B.Tech") || course.equals("M.Tech")){%>
								<tr>
									<td class='label'>Choice 1</td>
									<td><%=choice_1 %></td>
								</tr>
								<tr>
									<td class='label'>Choice 2</td>
									<td><%=choice_2 %></td>
								</tr>
								<tr>
									<td class='label'>Choice 3</td>
									<td><%=choice_3 %></td>
								</tr>
								<%}%>
								<% if ( !(course.equals("B.Tech") || course.equals("B.Arch"))) { %>
								
								<tr>
									<td class='label'>Other Qualifying Exams</td>
									<td><%=exam_attended %></td>
								</tr>
								<tr>
									<td class='label'>Valid Score</td>
									<td><%=valid_score_of %></td>
								</tr>
								<%}%>
								<tr>
									<td class='label'>Medium of Instruction</td>
									<td><%=medium_of_instr %></td>
								</tr>
								<% if (course.equals("B.Tech") || course.equals("B.Arch")) { %>
								<tr>
									<td class='label'>Optional Subject</td>
									<td><%=optional_subject %></td>
								</tr>
								<%}%>
								<tr>
							<td colspan="2" class="button navy gradient">Address Details</td>
							</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
									<td class='label'>Permanent Address</td>
									<td><%=address.replace("\n","<BR>") %></td>
								</tr>
								<tr>
									<td class='label'>City</td>
									<td><%=city%></td>
								</tr>
								<tr>
									<td class='label'>State</td>
									<td><%=state%></td>
								</tr>
								<tr>
									<td class='label'>Country</td>
									<td><%=country%></td>
								</tr>								
								<tr>
									<td class='label'>Pin Code</td>
									<td><%=pin_code%></td>
								</tr>
								<tr>
									<td class='label'>Phone No</td>
									<td><%=std_code%><%=phone_no%></td>
								</tr>
								<tr>
									<td class='label'>Mobile No</td>
									<td><%=mobile_no%></td>
								</tr>
								<tr>
									<td class='label'>Email Id</td>
									<td><%=email_id%></td>
								</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
							<td colspan="2" class="button navy gradient">Academics</td>
								</tr>
					<tr><td>&nbsp;</td></tr>
					
					<tr>
					<td colspan=2 align=center>
						<table width="100%">
						<tr>
							<td  class="button1 navy gradient">Qualifying Exam</td>
							<td class="button1 navy gradient">School</td>
							<td class="button1 navy gradient">City</td>
							<td class="button1 navy gradient">Board</td>
							<td class="button1 navy gradient">Regn No</td>
							<td class="button1 navy gradient">Date of Passing</td>
							<td class="button1 navy gradient">Percentage</td>
						</tr>
						<tr>
							<td><b>X</b></td>
							<td><%=sslc_school%></td>
							<td><%=sslc_city%></td>
							<td><%=sslc_board%></td>
							<td><%=sslc_regn_no%></td>
							<td><%=sslc_mon_yop%></td>
							<td><%=sslc_perc.setScale(2, BigDecimal.ROUND_HALF_UP)%> %</td>
						</tr>
						</tr>
						<tr>
							<td><b>XII</b></td>
							<td><%=hsc_school%></td>
							<td><%=hsc_city%></td>
							<td><%=hsc_board%></td>
							<td><%=hsc_regn_no%></td>
							<td><%=hsc_mon_yop%></td>
							<td><%=hsc_perc.setScale(2, BigDecimal.ROUND_HALF_UP)%> %</td>
						</tr>
						</table>
					</td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<%if (adm_type.equals("LATERAL") || (course.equals("M.Tech") || course.equals("MCA") || course.equals("MBA"))){%>
					<tr>
					<td colspan=2 align=center>
						<table width="100%">
						<tr>
							<td class="button1 navy gradient">Qualifying Exam</td>
							<td class="button1 navy gradient">College</td>
							<td class="button1 navy gradient">City</td>
							<td class="button1 navy gradient">University</td>
							<td class="button1 navy gradient">Regn No</td>
							<td class="button1 navy gradient">Date of Passing</td>
							<td class="button1 navy gradient">Percentage</td>
						</tr>
						<tr>
							<td><%=oth_exam_1%></td>
							<td><%=oth_college_1%></td>
							<td><%=oth_city_1%></td>
							<td><%=oth_university_1%></td>
							<td><%=oth_regn_no_1%></td>
							<td><%=oth_mon_yop_1%></td>
							<% if(oth_per_1.toString().equals("0")){%>
							<td>-</td>
							<%}else{%>
							<td><%=oth_per_1.setScale(2, BigDecimal.ROUND_HALF_UP)%> %</td>
							<%}%>
						 </tr>
						<tr>
							<td><%=oth_exam_2%></td>
							<td><%=oth_college_2%></td>
							<td><%=oth_city_2%></td>
							<td><%=oth_university_2%></td>
							<td><%=oth_regn_no_2%></td>
							<td><%=oth_mon_yop_2%></td>
							<% if(oth_per_2.toString().equals("0")){%>
							<td>-</td>
							<%}else{%>
							<td><%=oth_per_2.setScale(2, BigDecimal.ROUND_HALF_UP)%> %</td>
							<%}%>
						</tr>
						<tr>
							<td><%=oth_exam_3%></td>
							<td><%=oth_college_3%></td>
							<td><%=oth_city_3%></td>
							<td><%=oth_university_3%></td>
							<td><%=oth_regn_no_3%></td>
							<td><%=oth_mon_yop_3%></td>
							<% if(oth_per_3.toString().equals("0")){%>
							<td>-</td>
							<%}else{%>
							<td><%=oth_per_3.setScale(2, BigDecimal.ROUND_HALF_UP)%> %</td>
							<%}%>
						</tr>
						</table>
					</td>
					</tr>
					<%}%>
					<tr colspan="2" ><td>&nbsp;</td></tr>
					<tr>
					<td colspan="2" class="button navy gradient">Miscellaneous</td>
					</tr>
					<tr>
						<td class='label'><b> Hostel ?</b></td>
							<td><%=hostel_reqd %></td>
						</tr>
						<tr>
							<td class='label'>Transportation ?</td>
							<td><%=transport_reqd %></td>
						</tr>
						<tr>
							<td colspan="2" class="button navy gradient">Fee Details</td>
						</tr>
			<% if( course.intern()=="BA" || course.intern()=="B.Sc" || course.intern()=="B.Com" || course.intern()=="BBA" || course.intern()=="BCA" || course.intern()=="M.Sc" || course.intern()=="MCA" || course.intern()=="MBA" || course.intern()=="M.Phil" ) { %>
					<tr>
						<td class='label'><i><b>Application Fee</b></i></td>
						<td>Rs.500</td>
					</tr>
			<%} else{%>				
					<tr>
						<td class='label'><i><b>Application Fee</b></i></td>
						<td>Rs.900</td>
					</tr>
			<%}%>					
					<tr>
						<td class='label'><i><b>Payment Status</b></i></td>
						<td><%= payment_status %></td>
					</tr>					
					 <% if (appn_status.equals("U") || appn_status.equals("I") || appn_status.equals("S")) { %>
					 <tr>
						<td class='label'>Payment Mode</td>
						<td>
						 <select name="appfee_flag" id="appfee_flag" onChange='javascript:setPaymentMode()' STYLE="width: 150px"> 
							
							<% 	if(pay_status.intern()=="C".intern()){%>
								<option value="ONLINE">Online Payment</option>
							<%} else{%>
								<option value="" selected>Select Payment Mode</option>
								<option value="CASH">Cash</option>
								<option value="DD">Demand Draft</option>
							<%} %>
						</select>  
						</td>
					</tr>
					<tr>
						<td colspan=2>
							<div id='cash_pay'>
							<table>
							<tr>
							<td class='label'>Cash Receipt No</td>
							<td colspan=3><input id="appfee_rcp_no" name="appfee_rcp_no" value="" /></td>
							</tr>
							</table>
							</div>
							<div id='dd_pay'>
							<table>
							<tr>
								<td class='label'>DD Number</td>
								<td><input id="dd_number" name="dd_number" value="<%=dd_number%>" /></td>
								<td class='label'>Drawn On</td>
								<td><input type="text" id="dd_date" value="<%=dd_date%>" readonly="readonly" name="dob"/></td>
							</tr>
							<tr>
								<td class='label'>Drawee Bank</td>
								<td><input id="drawee_bank" name="drawee_bank" value="<%=drawee_bank%>" /></td>
								<td class='label'>Amount</td>
								<td><input id="amount" name="amount"  value="<%=amount%>"/></td>
							</tr>
							</table>
							</div>
							<div id='online_pay'>
							<!--<table>
							<tr>
							<td colspan=4>
							<form>
							<input type=button value='Click to Pay Online' onClick='javascript:payment()'>
							</form>
							</td>
							</tr>
							</table>-->
							</div>
						</td>
					</tr>
					<%}%>
				<!-- <tr>
					<td colspan=4><i><b>Admission Fee</b></i></td>
				</tr>
				  <tr>
						<td class='label'>DD Number</td>
						<td><input id="adm_dd_number" name="adm_dd_number" class="nm"/></td>
						<td class='label'>Drawn On</td>
						<td><input id="adm_dd_date" id="adm_dd_date"  class="nm"/></td>
					</tr>
					<tr>
						<td class='label'>Drawee Bank</td>
						<td><input id="adm_drawee_bank" name="adm_drawee_bank"  class="nm"/></td>
						<td class='label'>Amount</td>
						<td><input id="adm_amount" name="adm_amount"   class="nm" /></td>
					</tr> -->
					<!-- <tr>
					<td colspan=4>* Your Application will be accepted only upon realisation of the money.  Till such time it will not be considered for enrollment.</td>
					</tr> -->
				<%  if(role.intern()=="ADMIN".intern() && flag.intern()=="A".intern()) { %>
					<td colspan="2" class="button navy gradient">Admission</td>
					<div>
					<!-- <legend>Admission</legend> -->
					<table>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td class='label'>Course Admitted</td>
						<td>
						<select id="adm_course">
							<option value="">Select</option>
							<option value="BE">B.E</option>
							<option value="MBA">M.B.A</option>
							<option value="MCA">M.C.A</option>
						</select>
						</td>
					</tr>
					<tr>
						<td class='label'>Admitted Branch</td>
						<td>
						<select id="adm_branch">
							<option value="">Select</option>
							<option value="MECH">Mechanical</option>
							<option value="ECE">Electronics & Communication Engineering</option>
							<option value="EEE">Electronics & Electrical Engineering</option>
						</select>
						</td>
					</tr>
					<tr>
						<td class='label'>Section</td>
						<td><select name="section" id="section">
							<option value="A" selected>A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
						</select>
						</td>
					</tr>
					<tr>
						<td class='label'>Registration No</td>
						<td><input id="regn_no" name="regn_no" /></td>
					</tr>
					<tr>
						<td class='label'>Hostel Room Allocated</td>
						<td><input id="hostel_room" name="hostel_room"  /></td>
					</tr>
					<tr>
						<td class='label'>Boarding Point</td>
						<td><input id="trn_board_point" name="trn_board_point"  /></td>
					</tr>
					<tr>
						<td class='label'>Documents Collected</td>
						<td>
						<input type="checkbox" name="ssl_marks" id="ssl_marks" value='SSLCM'>&nbsp;SSLC Marksheet&nbsp;
						<input type="checkbox" name="hsc_marks" id="hsc_marks" value='HSCM'>&nbsp;HSC Marksheet&nbsp;
						<input type="checkbox" name="conduct_cert" id="conduct_cert"  value='CONC'>&nbsp;Conduct Certificate
						</td>
					</tr>
					<tr>
						<td class='label'>Remarks</td>
						<td><input id="adm_remarks" name="adm_remarks" value="" /></td>
					</tr>
					<tr>
					<td colspan=2>&nbsp;</td>
					</tr>
					</table>
					</div>
				<% 	} %>
							<%
							role=(String)session.getAttribute("role");
							System.out.println("Role is "+role);
							if(role.intern()=="ADMIN".intern()) {
							System.out.println("Rolefdf is "+role);
								if ((flag.intern()=="A".intern()) || appn_status.equals("X")) {
								System.out.println("Role 6767is "+role);
							%>
							<tr>
								<td colspan=2 width="100%"  align="right">&nbsp;&nbsp;&nbsp;
								<a href="javascript:admitStudent()" class="button3 grey gradient">Admit Student</a>&nbsp;&nbsp;&nbsp;
								<a href="javascript:rejectStudent()" class="button3 grey gradient">Reject Student</a>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							 <%
								} else if(appn_status.equals("R")){ %>
							<tr>
								<td colspan=2 width="100%"  align="right">&nbsp;&nbsp;&nbsp;
								<h2 align=center><font color=red>Application has been rejected </font></h2>&nbsp;&nbsp;<a href="javascript:window.history.back()"><< Back</a>
								</td>
							</tr>
							 <%
								} else if(appn_status.equals("A")){ %>
							<tr>
								<td colspan=2 width="100%"  align="right">&nbsp;&nbsp;&nbsp;
								<h2 align=center><font color=green>Application has been Approved </font></h2>&nbsp;&nbsp;<a href="javascript:window.history.back()"><< Back</a>
								</td>
							</tr>
							<%}	else {
							%>
							<tr>
							<td colspan="2" class="button navy gradient">Admin Action</td>
								</tr>
				<tr>
					<td colspan=2>&nbsp;</td></tr>
				<tr>
					<td><label for="remarks"><b>Reason for Rejection</b></td>
					<td>
					<select id="rej_reason" name="rej_reason" STYLE="width: 150px">
					<option value="">Rejection Reason</option>
					<option value="ELIGIBILITY">Incomplete Information</option>
					<option value="LACK_OF_INFO">Fake or Wrong Information</option>
					</select>
					</td>
				</tr>
				<tr>
					<td><label for="remarks"><b>Remarks</b></td>
					<td><textarea rows=3  id="remarks" name="remarks" length=80  value="Remarks"></textarea></td>
				</tr>
				<tr>
					<td colspan=2 width="100%">
							<table width="100%">
								<tr>
								<td width="50%">
									<div id='resultCell'></div>
								</td>
								<td align="right"><input type="button" class="clickButton" value="Approve Application" onClick="javascript:approveApp()"/>&nbsp;&nbsp;&nbsp;</td>
									<td align="right"><input type="button" class="clickButton" value="Reject Application" onClick="javascript:rejectApp()"/>
								</td>
								</tr>
							</table>
					</td>
				</tr>
								<%
									}
								}
							%>
					<tr colspan="2" ><td>&nbsp;</td></tr>
		</table>
</div>
</section>

	<%@include file="Footer.jsp" %>
</div>
	</body>
</html>