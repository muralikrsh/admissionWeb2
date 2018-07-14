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
String strFlag=request.getParameter("flag");

if(strFlag==null)
	strFlag="I";
ArrayList alCourses=null;
ArrayList alStates=(ArrayList)application.getAttribute("STATES");
session.setAttribute("strRole",strRole);

ArrayList alCourseGroup=new ArrayList();
ArrayList alCourseDesc=new ArrayList();
ArrayList alCourseName=new ArrayList();
ArrayList alCourseType=new ArrayList();

String strFullAdmNum="";
String strAppnNum="";
String strStuName="";
String strGender="";
String strAdmissionFee="";
String strAppDate="";
String strDOB="";
String strCommunity="";
String strFixedTuitionFee="";
String strConcessionAmount="0";
String strBranch="";
String strStudentType="";
String strCourse="";
String strReference="";
String strOtherReferenceName="";
String strOtherReferenceContact="";
String strTuitionFee="";
String strEmail="";
String strAddress="";
String strCity="";
String strState="";
String strCountry="";
String strPin="";
String strStd="";
String strPhone="";
String strMobile="";
String strParentName="";
String strAdmissionStatus="";
String strAdmQuota="";
String strPcmMarks="";
String strConcessionType="";

String strCashAmountOne="";
String strCashReceiptDate_1="";
String strChallanAmountOne="";
String strChallanStatus_1="";
String strChallanIssueDate_1="";
String strChallanAckDate_1="";
String strChallanReason_1="";
String strDdAmountOne="";
String strDdDraweeBank_1="";
String strDdDrawnDate_1="";
String strDdNo_1="";
String strDdSubmitDate_1="";

String strCashAmountTwo="";
String strCashReceiptDate_2="";
String strChallanAmountTwo="";
String strChallanStatus_2="";
String strChallanIssueDate_2="";
String strChallanAckDate_2="";
String strChallanReason_2="";
String strDdAmountTwo="";
String strDdDraweeBank_2="";
String strDdDrawnDate_2="";
String strDdNo_2="";
String strDdSubmitDate_2="";

String strCashAmountThree="";
String strCashReceiptDate_3="";
String strChallanAmountThree="";
String strChallanStatus_3="";
String strChallanIssueDate_3="";
String strChallanAckDate_3="";
String strChallanReason_3="";
String strDdAmountThree="";
String strDdDraweeBank_3="";
String strDdDrawnDate_3="";
String strDdNo_3="";
String strDdSubmitDate_3="";

String strCashAmountFour="";
String strCashReceiptDate_4="";
String strChallanAmountFour="";
String strChallanStatus_4="";
String strChallanIssueDate_4="";
String strChallanAckDate_4="";
String strChallanReason_4="";
String strDdAmountFour="";
String strDdDraweeBank_4="";
String strDdDrawnDate_4="";
String strDdNo_4="";
String strDdSubmitDate_4="";

String strTotalPaid="";
String strHostel="";
String strTransport="";
String strMkrDate="";
String strUser="";

String strCashReceiptNo1="0";
String strChallanNo_1="0";
String strDdReceiptNo1="0";
String strCashReceiptNo2="0";
String strChallanNo_2="0";
String strDdReceiptNo2="0";
String strCashReceiptNo3="0";
String strChallanNo_3="0";
String strDdReceiptNo3="0";
String strCashReceiptNo4="0";
String strChallanNo_4="0";
String strDdReceiptNo4="0";

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

try{
	
	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("SELECT course_group, course_desc, course_name, course_type from course where course_flag='A' group by course_name order by course_name");
	rs=pst.executeQuery();
	alCourses=new ArrayList();

	while(rs.next()) 
	{
		alCourseGroup.add(rs.getString(1));
		alCourseDesc.add(rs.getString(2));
		alCourseName.add(rs.getString(3));
		alCourseType.add(rs.getString(4));
		alCourses.add( rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3)+"#"+rs.getString(4));
	}
	
	pst=null;
	rs=null;
	
		strFullAdmNum=request.getParameter("appn_no");
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("SELECT appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,std,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_status_1,challan_issue_date_1,challan_ack_date_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_status_2,challan_issue_date_2,challan_ack_date_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_status_3,challan_issue_date_3,challan_ack_date_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_status_4,challan_issue_date_4,challan_ack_date_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,total_paid,inserted_by FROM student_admission WHERE full_adm_no=?");
		pst.setString(1, strFullAdmNum);
		System.out.println(pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			strAppnNum=rs.getString("appn_no");
			strStuName=rs.getString("stu_name");
			strAppDate=rs.getString("app_date");
			strParentName=rs.getString("par_name");
			strDOB=rs.getString("dob");
			strGender=rs.getString("gender");
			strCommunity=rs.getString("community");
			strCourse=rs.getString("course");
			strBranch=rs.getString("branch");
			
			strStudentType=rs.getString("student_type");
			strAddress=rs.getString("address");
			strCity=rs.getString("city");
			strState=rs.getString("state");
			strCountry=rs.getString("country");
			strPin=rs.getString("pin");
			strStd=rs.getString("std");
			strPhone=rs.getString("phone");
			strMobile=rs.getString("mobile");
			strEmail=rs.getString("email");
			
			strAdmissionStatus=rs.getString("adm_status");
			strAdmQuota=rs.getString("adm_quota");
			strFixedTuitionFee=rs.getString("fixed_tuition_fee");
			strConcessionType=rs.getString("concession_type");
			strPcmMarks=rs.getString("pcm_marks");
			strConcessionAmount=rs.getString("concession_amt");
 			strReference=rs.getString("reference");
			strOtherReferenceName=rs.getString("other_reference_name");
			strOtherReferenceContact=rs.getString("other_reference_contact");

			strHostel=rs.getString("hostel");
			strTransport=rs.getString("transport");
			strAdmissionFee=rs.getString("admission_fee");
			
/* 			strCashAmountOne=rs.getString("cash_amount_1");
			strCashReceiptDate_1=rs.getString("cash_receipt_date_1");
			strChallanAmountOne=rs.getString("challan_amount_1");
			strChallanNo_1=rs.getString("challan_no_1");
			strChallanStatus_1=rs.getString("challan_status_1");
			strChallanIssueDate_1=rs.getString("challan_issue_date_1");
			strChallanAckDate_1=rs.getString("challan_ack_date_1");
			strChallanReason_1=rs.getString("challan_reason_1");
			strDdAmountOne=rs.getString("dd_amount_1");
			strDdDraweeBank_1=rs.getString("dd_bank_1");
			strDdDrawnDate_1=rs.getString("dd_drawn_date_1");
			strDdNo_1=rs.getString("dd_no_1");
			strDdSubmitDate_1=rs.getString("dd_submit_date_1");

			strCashAmountTwo=rs.getString("cash_amount_2");
			strCashReceiptDate_2=rs.getString("cash_receipt_date_2");
			strChallanAmountTwo=rs.getString("challan_amount_2");
			strChallanNo_2=rs.getString("challan_no_2");
			strChallanStatus_2=rs.getString("challan_status_2");
			strChallanIssueDate_2=rs.getString("challan_issue_date_2");
			strChallanAckDate_2=rs.getString("challan_ack_date_2");
			strChallanReason_2=rs.getString("challan_reason_2");
			strDdAmountTwo=rs.getString("dd_amount_2");
			strDdDraweeBank_2=rs.getString("dd_bank_2");
			strDdDrawnDate_2=rs.getString("dd_drawn_date_2");
			strDdNo_2=rs.getString("dd_no_2");
			strDdSubmitDate_2=rs.getString("dd_submit_date_2");
			
			strCashAmountThree=rs.getString("cash_amount_3");
			strCashReceiptDate_3=rs.getString("cash_receipt_date_3");
			strChallanAmountThree=rs.getString("challan_amount_3");
			strChallanNo_3=rs.getString("challan_no_3");
			strChallanStatus_3=rs.getString("challan_status_3");
			strChallanIssueDate_3=rs.getString("challan_issue_date_3");
			strChallanAckDate_3=rs.getString("challan_ack_date_3");
			strChallanReason_3=rs.getString("challan_reason_3");
			strDdAmountThree=rs.getString("dd_amount_3");
			strDdDraweeBank_3=rs.getString("dd_bank_3");
			strDdDrawnDate_3=rs.getString("dd_drawn_date_3");
			strDdNo_3=rs.getString("dd_no_3");
			strDdSubmitDate_3=rs.getString("dd_submit_date_3");
			
			strCashAmountFour=rs.getString("cash_amount_4");
			strCashReceiptDate_4=rs.getString("cash_receipt_date_4");
			strChallanAmountFour=rs.getString("challan_amount_4");
			strChallanNo_4=rs.getString("challan_no_4");
			strChallanStatus_4=rs.getString("challan_status_4");
			strChallanIssueDate_4=rs.getString("challan_issue_date_4");
			strChallanAckDate_4=rs.getString("challan_ack_date_4");
			strChallanReason_4=rs.getString("challan_reason_4");
			strDdAmountFour=rs.getString("dd_amount_4");
			strDdDraweeBank_4=rs.getString("dd_bank_4");
			strDdDrawnDate_4=rs.getString("dd_drawn_date_4");
			strDdNo_4=rs.getString("dd_no_4");
			strDdSubmitDate_4=rs.getString("dd_submit_date_4");

			strCashReceiptNo1=rs.getString("cash_receipt_no_1");
			strDdReceiptNo1=rs.getString("dd_receipt_no_1");
			strCashReceiptNo2=rs.getString("cash_receipt_no_2");
			strDdReceiptNo2=rs.getString("dd_receipt_no_2");
			strCashReceiptNo3=rs.getString("cash_receipt_no_3");
			strDdReceiptNo3=rs.getString("dd_receipt_no_3");
			strCashReceiptNo4=rs.getString("cash_receipt_no_4");
			strDdReceiptNo4=rs.getString("dd_receipt_no_4");			
			strTotalPaid=rs.getString("total_paid");
 */
			strUser=rs.getString("inserted_by");
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
<title><%=(strFlag.intern()=="U".intern())?"Update Admission Form":"Admission Form"%></title>
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
				postRequest("AdmissionFormResult.jsp", "I");
			} else 
			{
				displayAlert("You have missed some mandatory Fields");
			}
		}
		
		function updateApp() {
			if($("#formPersonal").valid() ) {
				postRequest("AdmissionFormResult.jsp", "U");
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

		function selectReference() {
			if ( getVal("reference")=="Others" )
			{
				document.getElementById('other_reference_name').style.display="block";
				document.getElementById('other_reference_contact').style.display="block";
			}
			else
			{
				document.getElementById('other_reference_name').style.display="none";
				document.getElementById('other_reference_contact').style.display="none";
			}
		}
		
/* 		function chooseChallanStatusOne() {
			if ( getVal("challanStatus1")=="Issued" )
			{
				document.getElementById('challanIssuedDate1').style.display="block";
				document.getElementById('challanAckDate1').style.display="none";
				document.getElementById('challanReason1').style.display="none";
			}
			else if ( getVal("challanStatus1")=="Ack.Received" )
			{
				document.getElementById('challanIssuedDate1').style.display="none";
				document.getElementById('challanAckDate1').style.display="block";
				document.getElementById('challanReason1').style.display="none";
			}
			else if ( getVal("challanStatus1")=="Cancelled" )
			{
				document.getElementById('challanIssuedDate1').style.display="none";
				document.getElementById('challanAckDate1').style.display="none";
				document.getElementById('challanReason1').style.display="block";
			}
			else if ( getVal("challanStatus1")=="Re-Issued" )
			{
				document.getElementById('challanIssuedDate1').style.display="block";
				document.getElementById('challanAckDate1').style.display="none";
				document.getElementById('challanReason1').style.display="block";
			}
			else
			{
				document.getElementById('challanIssuedDate1').style.display="none";
				document.getElementById('challanAckDate1').style.display="none";
				document.getElementById('challanReason1').style.display="none";
			}
		}
		
				function chooseChallanStatusTwo() {
			if ( getVal("challanStatus2")=="Issued" )
			{
				document.getElementById('challanIssuedDate2').style.display="block";
				document.getElementById('challanAckDate2').style.display="none";
				document.getElementById('challanReason2').style.display="none";
			}
			else if ( getVal("challanStatus2")=="Ack.Received" )
			{
				document.getElementById('challanIssuedDate2').style.display="none";
				document.getElementById('challanAckDate2').style.display="block";
				document.getElementById('challanReason2').style.display="none";
			}
			else if ( getVal("challanStatus2")=="Cancelled" )
			{
				document.getElementById('challanIssuedDate2').style.display="none";
				document.getElementById('challanAckDate2').style.display="none";
				document.getElementById('challanReason2').style.display="block";
			}
			else if ( getVal("challanStatus2")=="Re-Issued" )
			{
				document.getElementById('challanIssuedDate2').style.display="block";
				document.getElementById('challanAckDate2').style.display="none";
				document.getElementById('challanReason2').style.display="block";
			}
			else
			{
				document.getElementById('challanIssuedDate2').style.display="none";
				document.getElementById('challanAckDate2').style.display="none";
				document.getElementById('challanReason2').style.display="none";
			}
		}
		
		function chooseChallanStatusThree() {
			if ( getVal("challanStatus3")=="Issued" )
			{
				document.getElementById('challanIssuedDate3').style.display="block";
				document.getElementById('challanAckDate3').style.display="none";
				document.getElementById('challanReason3').style.display="none";
			}
			else if ( getVal("challanStatus3")=="Ack.Received" )
			{
				document.getElementById('challanIssuedDate3').style.display="none";
				document.getElementById('challanAckDate3').style.display="block";
				document.getElementById('challanReason3').style.display="none";
			}
			else if ( getVal("challanStatus3")=="Cancelled" )
			{
				document.getElementById('challanIssuedDate3').style.display="none";
				document.getElementById('challanAckDate3').style.display="none";
				document.getElementById('challanReason3').style.display="block";
			}
			else if ( getVal("challanStatus3")=="Re-Issued" )
			{
				document.getElementById('challanIssuedDate3').style.display="block";
				document.getElementById('challanAckDate3').style.display="none";
				document.getElementById('challanReason3').style.display="block";
			}
			else
			{
				document.getElementById('challanIssuedDate3').style.display="none";
				document.getElementById('challanAckDate3').style.display="none";
				document.getElementById('challanReason3').style.display="none";
			}
		}
		
		function chooseChallanStatusFour() {
			if ( getVal("challanStatus4")=="Issued" )
			{
				document.getElementById('challanIssuedDate4').style.display="block";
				document.getElementById('challanAckDate4').style.display="none";
				document.getElementById('challanReason4').style.display="none";
			}
			else if ( getVal("challanStatus4")=="Ack.Received" )
			{
				document.getElementById('challanIssuedDate4').style.display="none";
				document.getElementById('challanAckDate4').style.display="block";
				document.getElementById('challanReason4').style.display="none";
			}
			else if ( getVal("challanStatus4")=="Cancelled" )
			{
				document.getElementById('challanIssuedDate4').style.display="none";
				document.getElementById('challanAckDate4').style.display="none";
				document.getElementById('challanReason4').style.display="block";
			}
			else if ( getVal("challanStatus4")=="Re-Issued" )
			{
				document.getElementById('challanIssuedDate4').style.display="block";
				document.getElementById('challanAckDate4').style.display="none";
				document.getElementById('challanReason4').style.display="block";
			}
			else
			{
				document.getElementById('challanIssuedDate4').style.display="none";
				document.getElementById('challanAckDate4').style.display="none";
				document.getElementById('challanReason4').style.display="none";
			}
		}
 */				
		function loadCourseData()
		{
			var getCourseGroup=[];
			var getCourseList=[];
			var getCourseID=[];
			var getCourseType=[];
			var getCourseName=[];
			var getCourseDesc=[];


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

			<% for(int i=0;i<alCourseDesc.size();i++) { %>
			getCourseDesc.push("<%= alCourseDesc.get(i)%>")
			<% } %>

			for(var i=0;i<getCourseGroup.length;i++)
			{
			if(getCourseGroup[i]==getCourse)
			{
				getCourseID.push(getCourseDesc[i]);
				getCourseList.push(getCourseName[i]);
			}
			}
			document.formPersonal.branch.options.length=0
			for(var i=0;i<=getCourseID.length;i++)
			{
				document.formPersonal.branch.options[i]=new Option(getCourseList[i],getCourseID[i],false,false); // new Option(getCentre[i],getCentreCode[i],false,false) to new Option(getCentre[i],getCentre[i],false,false) by Alex on 2.4.2015
			}
			}

		function setParams() 
		{
		//alert("3");
			var AppNo=encodeURIComponent(document.getElementById("appNo").value);
			var AppDate=encodedVal("appDate");
			var StudentName=encodeURIComponent(document.getElementById("studentName").value);
			var ParentName=encodedVal("parentName");
			var DOB=encodedVal("dob");
			var Gender=getVal("gender");
			var Community=getVal("community");
		
			var Course=encodedVal("course");
			var Branch=encodedVal("branch");
			var StudentType=encodedVal("studentType");

			var Address=encodedVal("address");
			var City=encodedVal("city");
			var State=encodedVal("state");
			var Country=encodedVal("country");
			var PinCode=encodedVal("pinCode");
			var StdCode=encodedVal("stdCode");
			var PhoneNo=encodedVal("phoneNo");
			var MobileNo=encodedVal("mobileNo");
			var Email=encodedVal("email");

			var AdmissionStatus=encodedVal("admissionStatus");
			var AdmissionQuota=encodedVal("admQuota");
			var FixedTuitionFee=encodedVal("fixedTuitionFee");
			var ConcessionType=encodedVal("concessionType");
			var PcmMarks=encodedVal("pcmMarks");
			var ConcessionAmount=encodedVal("concessionAmount");
			var Reference=encodedVal("reference");
			var OtherReferenceName=encodedVal("other_reference_name");
			var OtherReferenceContact=encodedVal("other_reference_contact");

			var HostelReqd=encodedVal("hostelReqd");
			var TransportReqd=encodedVal("transportReqd");

			var AdmissionFee="<%= strAdmissionFee %>";

	/* 		var CashAmountOne=encodedVal("cashAmountOne");
			var CashReceiptDate1=encodedVal("cashReceiptDate1");
			var ChallanAmountOne=encodedVal("challanAmountOne");
			var ChallanStatus1=encodedVal("challanStatus1");
			var ChallanIssuedDate1=encodedVal("challanIssuedDate1");
			var ChallanAckDate1=encodedVal("challanAckDate1");
			var ChallanReason1=encodedVal("challanReason1");
			var DdAmountOne=encodedVal("ddAmountOne");
			var DraweeBank1=encodedVal("draweeBank1");
			var DdDrwanDate1=encodedVal("ddDrwanDate1");
			var DdNo1=encodedVal("ddNo1");
			var DdSubmitDate1=encodedVal("ddSubmitDate1");

			var CashAmountTwo=encodedVal("cashAmountTwo");
			var CashReceiptDate2=encodedVal("cashReceiptDate2");
			var ChallanAmountTwo=encodedVal("challanAmountTwo");
			var ChallanStatus2=encodedVal("challanStatus2");
			var ChallanIssuedDate2=encodedVal("challanIssuedDate2");
			var ChallanAckDate2=encodedVal("challanAckDate2");
			var ChallanReason2=encodedVal("challanReason2");
			var DdAmountTwo=encodedVal("ddAmountTwo");
			var DraweeBank2=encodedVal("draweeBank2");
			var DdDrwanDate2=encodedVal("ddDrwanDate2");
			var DdNo2=encodedVal("ddNo2");
			var DdSubmitDate2=encodedVal("ddSubmitDate2");
//alert("3.3");	
			var CashAmountThree=encodedVal("cashAmountThree");
			var CashReceiptDate3=encodedVal("cashReceiptDate3");
			var ChallanAmountThree=encodedVal("challanAmountThree");
			var ChallanStatus3=encodedVal("challanStatus3");
			var ChallanIssuedDate3=encodedVal("challanIssuedDate3");
			var ChallanAckDate3=encodedVal("challanAckDate3");
			var ChallanReason3=encodedVal("challanReason3");
			var DdAmountThree=encodedVal("ddAmountThree");
			var DraweeBank3=encodedVal("draweeBank3");
			var DdDrwanDate3=encodedVal("ddDrwanDate3");
			var DdNo3=encodedVal("ddNo3");
			var DdSubmitDate3=encodedVal("ddSubmitDate3");
			
			var CashAmountFour=encodedVal("cashAmountFour");
			var CashReceiptDate4=encodedVal("cashReceiptDate4");
			var ChallanAmountFour=encodedVal("challanAmountFour");
			var ChallanStatus4=encodedVal("challanStatus4");
			var ChallanIssuedDate4=encodedVal("challanIssuedDate4");
			var ChallanAckDate4=encodedVal("challanAckDate4");
			var ChallanReason4=encodedVal("challanReason4");
			var DdAmountFour=encodedVal("ddAmountFour");
			var DraweeBank4=encodedVal("draweeBank4");
			var DdDrwanDate4=encodedVal("ddDrwanDate4");
			var DdNo4=encodedVal("ddNo4");
			var DdSubmitDate4=encodedVal("ddSubmitDate4");
 */	//alert("4");
var IPAddr="<%= getClientIpAddr(request) %>";
var FullAdmNum="<%= strFullAdmNum %>";
var parameters="AppNo="+AppNo+
"&AppDate="+AppDate+
"&StudentName="+StudentName+
"&ParentName="+ParentName+
"&DOB="+DOB+
"&Gender="+Gender+
"&Community="+Community+
"&Course="+Course+
"&Branch="+Branch+
"&StudentType="+StudentType+
"&Address="+Address+
"&City="+City+
"&State="+State+
"&Country="+Country+
"&PinCode="+PinCode+
"&StdCode="+StdCode+
"&PhoneNo="+PhoneNo+
"&MobileNo="+MobileNo+
"&Email="+Email+
"&AdmissionStatus="+AdmissionStatus+
"&AdmissionQuota="+AdmissionQuota+
"&FixedTuitionFee="+FixedTuitionFee+
"&ConcessionType="+ConcessionType+
"&PcmMarks="+PcmMarks+
"&ConcessionAmount="+ConcessionAmount+
"&Reference="+Reference+
"&OtherReferenceName="+OtherReferenceName+
"&OtherReferenceContact="+OtherReferenceContact+
"&HostelReqd="+HostelReqd+
"&TransportReqd="+TransportReqd+
"&AdmissionFee="+AdmissionFee+
<%-- "&CashAmountOne="+CashAmountOne+
"&CashReceiptDate1="+CashReceiptDate1+
"&ChallanAmountOne="+ChallanAmountOne+
"&ChallanIssuedDate1="+ChallanIssuedDate1+
"&ChallanStatus1="+ChallanStatus1+
"&ChallanAckDate1="+ChallanAckDate1+
"&ChallanReason1="+ChallanReason1+
"&DdAmountOne="+DdAmountOne+
"&DraweeBank1="+DraweeBank1+
"&DdDrwanDate1="+DdDrwanDate1+
"&DdNo1="+DdNo1+
"&DdSubmitDate1="+DdSubmitDate1+
"&CashAmountTwo="+CashAmountTwo+
"&CashReceiptDate2="+CashReceiptDate2+
"&ChallanAmountTwo="+ChallanAmountTwo+
"&ChallanIssuedDate2="+ChallanIssuedDate2+
"&ChallanStatus2="+ChallanStatus2+
"&ChallanAckDate2="+ChallanAckDate2+
"&ChallanReason2="+ChallanReason2+
"&DdAmountTwo="+DdAmountTwo+
"&DraweeBank2="+DraweeBank2+
"&DdDrwanDate2="+DdDrwanDate2+
"&DdNo2="+DdNo2+
"&DdSubmitDate2="+DdSubmitDate2+
"&CashAmountThree="+CashAmountThree+
"&CashReceiptDate3="+CashReceiptDate3+
"&ChallanAmountThree="+ChallanAmountThree+
"&ChallanIssuedDate3="+ChallanIssuedDate3+
"&ChallanStatus3="+ChallanStatus3+
"&ChallanAckDate3="+ChallanAckDate3+
"&ChallanReason3="+ChallanReason3+
"&DdAmountThree="+DdAmountThree+
"&DraweeBank3="+DraweeBank3+
"&DdDrwanDate3="+DdDrwanDate3+
"&DdNo3="+DdNo3+
"&DdSubmitDate3="+DdSubmitDate3+
"&CashAmountFour="+CashAmountFour+
"&CashReceiptDate4="+CashReceiptDate4+
"&ChallanAmountFour="+ChallanAmountFour+
"&ChallanIssuedDate4="+ChallanIssuedDate4+
"&ChallanStatus4="+ChallanStatus4+
"&ChallanAckDate4="+ChallanAckDate4+
"&ChallanReason4="+ChallanReason4+
"&DdAmountFour="+DdAmountFour+
"&DraweeBank4="+DraweeBank4+
"&DdDrwanDate4="+DdDrwanDate4+
"&DdNo4="+DdNo4+
"&DdSubmitDate4="+DdSubmitDate4+
 --%>
 "&MakerId=<%=strMakerId%>"+
"&IPAddr="+IPAddr+
<%-- "&CashReceiptNo1=<%=strCashReceiptNo1%>"+
"&ChallanNo1=<%=strChallanNo_1%>"+
"&DdReceiptNo1=<%=strDdReceiptNo1%>"+
"&CashReceiptNo2=<%=strCashReceiptNo2%>"+
"&ChallanNo2=<%=strChallanNo_2%>"+
"&DdReceiptNo2=<%=strDdReceiptNo2%>"+
"&CashReceiptNo3=<%=strCashReceiptNo3%>"+
"&ChallanNo3=<%=strChallanNo_3%>"+
"&DdReceiptNo3=<%=strDdReceiptNo3%>"+
"&CashReceiptNo4=<%=strCashReceiptNo4%>"+
"&ChallanNo4=<%=strChallanNo_4%>"+
"&DdReceiptNo4=<%=strDdReceiptNo4%>"+
 --%>
 "&full_adm_no="+FullAdmNum;
//alert("5 -> "+parameters);
			return parameters;
		}

		function encodedVal(str) {
			return encodeURIComponent(document.getElementById(str).value);
		}
		function getVal(str) {
			return document.getElementById(str).value;
		}
		
		function postRequest(strURL, aflag) {
			var parameters=setParams();
			parameters+="&aflag="+aflag;
			//alert(parameters);
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
					updatePage(xmlHttp.responseText, aflag);
				}
			}
		}
		
		function updatePage(str, aflag){
			var arr=str.split("~");
			if(arr[0].trim()=="0000".trim())
			{
				if(aflag.trim()=="U".trim())
				{
					alert("Result : " + "Admission form has been updated.");
					window.location=arr[1];
				}
				else if(aflag.trim()=="I".trim())
				{
					alert("Result : " + "Admission form has been submitted.");
					window.location=arr[1];
				}
			}
			else {
				if(str.trim()=="0002".trim()) {
					displayError("Result : Error while submitting Admission form. Mobile Number Exists",'goHome');
				} else {
					displayError("Result : Error while submitting Admission form. Please Contact Administrator",'goHome');
				}
			}			
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

			$( "#cashReceiptDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#cashReceiptDate1').datepicker().trigger('change');
			
			$( "#cashReceiptDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#cashReceiptDate2').datepicker().trigger('change');

			$( "#cashReceiptDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#cashReceiptDate3').datepicker().trigger('change');

			$( "#cashReceiptDate4" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#cashReceiptDate4').datepicker().trigger('change');

			$( "#ddDrwanDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDrwanDate1').datepicker().trigger('change');
			
			$( "#ddDrwanDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDrwanDate2').datepicker().trigger('change');
			
			$( "#ddDrwanDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDrwanDate3').datepicker().trigger('change');

			$( "#ddDrwanDate4" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDrwanDate4').datepicker().trigger('change');

			$( "#ddSubmitDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddSubmitDate1').datepicker().trigger('change');
			
			$( "#ddSubmitDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddSubmitDate2').datepicker().trigger('change');
			
			$( "#ddSubmitDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddSubmitDate3').datepicker().trigger('change');

			$( "#ddSubmitDate4" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddSubmitDate4').datepicker().trigger('change');
			
			$( "#challanIssuedDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanIssuedDate1').datepicker().trigger('change');

			$( "#challanIssuedDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanIssuedDate2').datepicker().trigger('change');

			$( "#challanIssuedDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanIssuedDate3').datepicker().trigger('change');
			
			$( "#challanIssuedDate4" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanIssuedDate4').datepicker().trigger('change');

			$( "#challanAckDate1" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanAckDate1').datepicker().trigger('change');
			
			$( "#challanAckDate2" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanAckDate2').datepicker().trigger('change');

			$( "#challanAckDate3" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanAckDate3').datepicker().trigger('change');

			$( "#challanAckDate4" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanAckDate4').datepicker().trigger('change');

			$('#gender').val("<%= strGender %>");
			$('#community').val("<%= strCommunity %>");
			$('#course').val("<%= strCourse %>");
			$('#branch').val("<%= strBranch %>");
			$('#studentType').val("<%= strStudentType %>");
			$('#address').val("<%= strAddress %>");
			$('#state').val("<%= strState %>");
			$('#admissionStatus').val("<%= strAdmissionStatus %>");
			$('#admQuota').val("<%= strAdmQuota %>");
			$('#concessionType').val("<%= strConcessionType %>");
			$('#reference').val("<%= strReference %>");
			$('#hostelReqd').val("<%= strHostel %>");
			$('#transportReqd').val("<%= strTransport %>");
			$('#challanStatus1').val("<%= strChallanStatus_1 %>");
			$('#challanStatus2').val("<%= strChallanStatus_2 %>");
			$('#challanStatus3').val("<%= strChallanStatus_3 %>");
			$('#challanStatus4').val("<%= strChallanStatus_4 %>");
	});
	
			$('#updatePhotoFile').change(function()	
			{
			if (typeof console === "undefined" || typeof console.log === "undefined") {
			console = {};}
			console.log("Photo "+document.getElementById("updatePhotoFile").value);
			if(validateFileExtension(document.getElementById("updatePhotoFile"),"jpg, jpeg, gif, tiff, tng")) {			
			$("#admission_profile").ajaxForm(
			{
			target: '#photopreview'
			}).submit();
			}
			});

	function disablePayment()
	{
/* 		document.getElementById('cashPay1').style.display="none";
		document.getElementById('ddPay1').style.display="none";
		document.getElementById('challanPay1').style.display="none";
		
		document.getElementById('cashPay2').style.display="none";
		document.getElementById('ddPay2').style.display="none";
		document.getElementById('challanPay2').style.display="none";
		
		document.getElementById('cashPay3').style.display="none";
		document.getElementById('ddPay3').style.display="none";
		document.getElementById('challanPay3').style.display="none";
		
		document.getElementById('cashPay4').style.display="none";
		document.getElementById('ddPay4').style.display="none";
		document.getElementById('challanPay4').style.display="none"; */
		document.getElementById('other_reference_name').style.display="none";
		document.getElementById('other_reference_contact').style.display="none";

		document.getElementById('challanIssuedDate1').style.display="none";
		document.getElementById('challanAckDate1').style.display="none";
		document.getElementById('challanReason1').style.display="none";
		
		document.getElementById('challanIssuedDate2').style.display="none";
		document.getElementById('challanAckDate2').style.display="none";
		document.getElementById('challanReason2').style.display="none";
		
		document.getElementById('challanIssuedDate3').style.display="none";
		document.getElementById('challanAckDate3').style.display="none";
		document.getElementById('challanReason3').style.display="none";
		
		document.getElementById('challanIssuedDate4').style.display="none";
		document.getElementById('challanAckDate4').style.display="none";
		document.getElementById('challanReason4').style.display="none";
		}
</script>
<%@include file="MBHandler.jsp" %>
</head>
<!-- <td colspan=2><div id='resultCell'></div></td> -->
<body onLoad="disablePayment();">
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

	<form id="formPersonal" name="formPersonal" method="post" autocomplete="on">
	<table id="maintab" class="formtab textbox_medium tbl_p3 textarea_normal " >
<!--	<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty / Fields with Invalid values are highlighted in red
		</td>
	</tr>
-->
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
	<td colspan="2" class="button navy gradient">Personal Details</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td>Application Number</td>
		<td><input type="text" id="appNo" name="appNo" size=30 maxlength=30 value="<%=strAppnNum %>" STYLE="width:210px"/>
		</td>
	</tr>
	<tr>
		<td>Applied Date</td>
		<td><input type="text" id="appDate" name="dob" readonly="readonly" size=30 maxlength=30 value="<%=strAppDate %>" STYLE="width:210px"/>
		</td>
	</tr>
	<tr>
		<td>Candidate Name</td>
		<td><input type="text" id="studentName" name="studentName"  value="<%=strStuName %>" size=30 maxlength=30 class="" title="As it appears in your 10th/12th Standard Mark sheet" STYLE="width:210px"/></td>
	</tr>
	<tr>
		<td>Father Name</td>
		<td><input type="text" id="parentName" name="parentName"  size=30 maxlength=30 value="<%=strParentName %>" STYLE="width:210px"/>
		</td>
	</tr>
	
	<tr>
		<td>Date of Birth</td>
		<td align=left nowrap>
		<input size=30 type="text" name="dob" value="<%=strDOB %>" readonly="readonly" id="dob" STYLE="width:210px"/>
		</td>
	</tr>
	<tr>
		<td>Gender</td>
		<td align=left nowrap>
		<select id="gender" STYLE="width: 210px">
			<option value='' >Select Gender</option>
			<option value="Male">Male</option>
			<option value="Female">Female</option>
			<option value="Others">Others</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Community</td>
		<td align=left nowrap>
		<select id="community" name="community" STYLE="width: 210px" >
		<option value="">Select Community</option>
		<option value="General">General</option>
		<option value="OBC">OBC</option>
		<option value="SC">SC</option>
		<option value="ST">ST</option>
		</select>
		</td>
	</tr>
		
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Course Choices</td></tr>
	<tr>
	<td>Course</td>
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
		<option value="MA">MA</option>
		<option value="M.Sc">M.Sc</option>
		<option value="MCA">MCA</option>
		<option value="MBA">MBA</option>
	</select>
	</td>
	</tr>

	<tr>
		<td>Branch</td>
		<td>
			<%
				if(strFlag.intern()=="U".intern()) {
			%>
			<select id="branch" name="branch" STYLE="width: 210px">
			<option value="">Select a branch</option>
			<%
			for (int k=0; k< alCourseName.size() ; k++)
			{
			%>
				<option value="<%=alCourseDesc.get(k) %>"><%=alCourseName.get(k) %></option>
			<%
			}
			%>
		</select>
		<%
		}
		else {
		%>
		<select id="branch" name="branch" STYLE="width: 210px">
		<option value="">Select a branch</option>
		</select>
		<%}%>
		</td>
		</tr>
		<tr>
		<td>Student Type</td>
		<td>
		<select id="studentType" name="studentType" STYLE="width: 210px">
			<option value="">Select</option>
			<option value="FRESH">Full Time/Fresh</option>
			<option value="LATERAL">Lateral</option>
			<option value="PART_TIME">Part Time</option>
		</select>
		</td>
	</tr>					
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Address Details</td></tr>
	<tr>
		<td>Permanent Address</td>
		<td><textarea rows="4" cols="30" maxlength=120 id="address" value="<%=strAddress %>" name="address" title="Please enter Door No, Apartment No, Street Name, Area Name"></textarea></td>
	</tr>
	<tr>
		<td>City</td>
		<td><input type="text" id="city" name="city" value="<%=strCity %>"  size="30" maxlength=20 STYLE="width:210px"/></td>
	</tr>
	<tr>
		<td>State</td>
		<td>
		<select id="state" name="state" STYLE="width: 210px">
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
		<td>Country</td>
		<td><input type="text" id="country" name="country" value="<%=strCountry %>"  size=30 maxlength=30 STYLE="width:210px"/></td>
	</tr>	
	<tr>
		<td>Pin Code</td>
		<td><input type="text" id="pinCode" name="pinCode" value="<%=strPin %>" size="30" maxlength=6 STYLE="width:210px"/></td>
	</tr>
	<tr>
		<td>STD Code & Phone No</td>
		<td><input type="text" id="stdCode" name="stdCode" size='6' maxlength=5 value="<%=strStd %>" STYLE="width:70px"/>
		<input type="text" id="phoneNo" name="phoneNo" value="<%=strPhone %>" size="18" maxlength=12 STYLE="width:135px"/></td>
	</tr>
	<tr>
		<td>Mobile No</td>
		<td><input type="text" size=30 id="mobileNo" name="mobileNo" value="<%=strMobile %>" maxlength=10 STYLE="width:210px"/></td>
	</tr>
	<tr>
		<td>Email Address</td>
		<td><input type="text" size=30 id="email" name="email" value="<%=strEmail %>" size=30 maxlength=30 STYLE="width:210px"/></td>
	
	<tr><td colspan=2>&nbsp;</td></tr>
	
	<tr>
		<td colspan="2" class="button navy gradient">Admission Details</td>
	</tr>
		<tr>
			<td class='label'><i><b>Admission Status</b></i></td>
			<td>
			<select name="admissionStatus" id="admissionStatus" STYLE="width:210px"> 
				<option value="">Select Status</option>
				<option value="Selected">Selected</option>
				<option value="Not_Selected">Not Selected</option>
			</select>
			</td>
		</tr>
		<tr>
			<td class='label'><i><b>Admission Quota</b></i></td>
			<td>
			<select id="admQuota" name="admQuota" STYLE="width:210px">
				<option value="">Select</option>
				<option value="MANAGEMENT">Management</option>
				<option value="COUNSELLING">Counselling</option>
			</select>
			</td>
		</tr>
		<tr>
		<td>Tuition Fee Fixed</td>
			<td><input type="text" size=10 id="fixedTuitionFee" name="fixedTuitionFee" value="<%=strFixedTuitionFee %>" maxlength=10 STYLE="width:210px"/></td>
		</tr>

		<tr>
			<td class='label'><i><b>Concession Type</b></i></td>
			<td>
			<select id="concessionType" name="concessionType" STYLE="width: 210px">
				<option value="">Select</option>
				<option value="Merit Concession">Merit Concession</option>
				<option value="First Graduate">First Graduate</option>
				<option value="Sports">Sports</option>
				<option value="Ex-Service Men">Ex-Service Men</option>
				<option value="SC">SC</option>
				<option value="ST">ST</option>
				<option value="Others">Others</option>
			</select>
			</td>
		</tr>

		<tr>
			<td>PCM/PCB %age</td>
			<td><input type="text" size=10 id="pcmMarks" name="pcmMarks" value="<%=strPcmMarks %>" maxlength=10 onkeyup="choosePercentage()" STYLE="width:210px"/></td>
		</tr>

		<tr>
			<td class='label'><i><b>Concession Amount</b></i></td>
			<td><input type="text" id="concessionAmount" name="concessionAmount" value="<%=strConcessionAmount%>" STYLE="width:210px"/></td>
		</tr>

		<tr>
			<td class='label'><i><b>Reference</b></i></td>
			<td>
			<select id="reference" name="reference" STYLE="width:210px" onChange='javascript:selectReference()'>
				<option value="">Select</option>
				<option value="University">University</option>
				<option value="Corporate_Office">Corporate Office</option>
				<option value="Mr.Reddy">Mr.Reddy</option>
				<option value="Others">Others</option>
			</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="other_reference_name" name="other_reference_name" value="<%=strOtherReferenceName %>" placeholder='Other Reference Name' STYLE="width:210px"/></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="text" id="other_reference_contact" name="other_reference_contact" value="<%=strOtherReferenceName %>" placeholder='Other Reference Contact Number' STYLE="width:210px"/></td>
		</tr>

		<tr><td colspan=2>&nbsp;</td></tr>
		
<tr><td colspan=2 class="button navy gradient">Miscellaneous</td></tr>
	<tr>
		<td>Hostel</td>
		<td>
		<select id="hostelReqd" onChange='javascript:blockTransport()' STYLE="width:210px">
			<option value="">Select</option>
			<option value="Yes">Yes</option>
			<option value="No">No</option>
		</select> 
		</td>
	</tr>

<script type="text/javascript">

		function choosePercentage()
		{
			//alert("%%");
			var AdmQuota=document.getElementById("admQuota").value;
			var ConcessionType=document.getElementById("concessionType").value;
			var PcmMarks=document.getElementById("pcmMarks").value;

			if(AdmQuota=="MANAGEMENT" && ConcessionType=="Merit Concession" && PcmMarks>=parseInt("95"))
			{
				document.getElementById("concessionAmount").value=45000;
			}
			
			else if(AdmQuota=="MANAGEMENT" && ConcessionType=="Merit Concession" && PcmMarks>=parseInt("90"))
			{
				document.getElementById("concessionAmount").value=30000;
			}

			else if(AdmQuota=="MANAGEMENT" && ConcessionType=="Merit Concession" && PcmMarks>=parseInt("80"))
			{
				document.getElementById("concessionAmount").value=15000;
			}

			else if(AdmQuota=="COUNSELLING" && ConcessionType=="Merit Concession" && PcmMarks>=parseInt("95"))
			{
				document.getElementById("concessionAmount").value=37500;
			}

			else if(AdmQuota=="COUNSELLING" && ConcessionType=="Merit Concession" && PcmMarks>=parseInt("90"))
			{
				document.getElementById("concessionAmount").value=15000;
			}
			else{
				document.getElementById("concessionAmount").value=0;
			}
		}
		
 		function blockTransport() 
		{
			var hostelReq=document.getElementById("hostelReqd").value;
			if(hostelReq.trim()=="Yes") 
			{
				document.getElementById("transportReqd").disabled=true;
			}
			else if(hostelReq.trim()=="No") 
			{
				document.getElementById("transportReqd").disabled=false;
			}
		}
		
		function blockHostel() 
		{
			var transReq=document.getElementById("transportReqd").value;
			if(transReq.trim()=="Yes") 
			{
				document.getElementById("hostelReqd").disabled=true;
			}
			else if(transReq.trim()=="No") 
			{
				document.getElementById("hostelReqd").disabled=false;
			}
		}
</script>
	<tr>
		<td>Transportation</td>
		<td>
		<select id="transportReqd" onChange='javascript:blockHostel()' STYLE="width:210px">
			<option value="">Select</option>
			<option value="Yes">Yes</option>
			<option value="No">No</option>
		</select> 

		</td>
	</tr>
<!--	<tr>
		<td colspan="2" class="button navy gradient">Payment Details</td>
	</tr>-->
<!--
	<tr>
					<td class='label'><i><b>Admission Fee / Tuition Fee Advance</b></i></td>
						<td><input id="admissionFee" name="admissionFee" value="<%=strAdmissionFee %>" STYLE="width:210px"/></td>
					</tr>
					-->
<!--					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td colspan=2 width=30% align=center class="button pink gradient">Payment - I</td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td width=30% align=right class="button navy">Challan - I</td>
					</tr>
										
					<tr>
						<td colspan=2>
						
							<div id='challanPay1'>
							<table>
							<tr>
								<td class='label'><i><b>Challan Amount</b></i></td>
								<td><input type="text" id="challanAmountOne" name="challanAmountOne" value="<%=strChallanAmountOne %>" STYLE="width:170px"/></td>
								<td class='label'>Status</td>
								<td>
								<select id="challanStatus1" STYLE="width:170px" onChange='javascript:chooseChallanStatusOne()'>
									<option value="">Select</option>
									<option value="Issued">Issued</option>
									<option value="Ack.Received">Ack.Received</option>
									<option value="Cancelled">Cancelled</option>
									<option value="Re-Issued">Re-Issued</option>
								</select>
								<br>&nbsp;
								<input type="text" id="challanIssuedDate1" value="<%=strChallanIssueDate_1 %>" readonly="readonly" name="dob" placeholder='Challan Issuing Date?' />
								<input type="text" id="challanAckDate1" value="<%=strChallanAckDate_1 %>" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
								<input type="text" id="challanReason1" name="challanReason1" value="<%=strChallanReason_1 %>" placeholder='Reason for Cancellation (or) Re-Issue?' STYLE="width:230px"/>
								</td>
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">Cash - I</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='cashPay1'>
							<table>
							<tr>
								<td class='label'><i><b>Cash Amount</b></i></td>
								<td><input type="text" id="cashAmountOne" name="cashAmountOne" value="<%=strCashAmountOne %>" STYLE="width:170px"/></td>
								<td class='label'>Date</td>
								<td><input type="text" id="cashReceiptDate1" value="<%=strCashReceiptDate_1 %>" readonly="readonly" name="dob"/></td>							
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">DD - I</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='ddPay1'>
							<table>
							<tr>
								<td class='label'><i><b>DD Amount</b></i></td>
								<td><input type="text" id="ddAmountOne" name="ddAmountOne" value="<%=strDdAmountOne %>" STYLE="width:170px"/></td>
								<td class='label'>Drawee Bank</td>
								<td><input type="text" id="draweeBank1" name="draweeBank1" value="<%=strDdDraweeBank_1 %>" /></td>
								<td class='label'>DD Dated (Drawn On)</td>
								<td><input type="text" id="ddDrwanDate1" value="<%=strDdDrawnDate_1 %>" readonly="readonly" name="dob"/></td>
								</tr>
								<tr>
								<td class='label'>DD Number</td>
								<td><input type="text" id="ddNo1" name="ddNo1" value="<%=strDdNo_1 %>" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="ddSubmitDate1" value="<%=strDdSubmitDate_1 %>" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
					</tr>

					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td colspan=2 width=30% align=center class="button pink gradient">Payment - II</td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td width=30% align=right class="button navy">Challan - II</td>
					</tr>
										
					<tr>
						<td colspan=2>
						
							<div id='challanPay2'>
							<table>
							<tr>
								<td class='label'><i><b>Challan Amount</b></i></td>
								<td><input type="text" id="challanAmountTwo" name="challanAmountTwo" value="<%=strChallanAmountTwo %>" STYLE="width:170px"/></td>
								<td class='label'>Status</td>
								<td>
								<select id="challanStatus2" STYLE="width:170px" onChange='javascript:chooseChallanStatusTwo()'>
									<option value="">Select</option>
									<option value="Issued">Issued</option>
									<option value="Ack.Received">Ack.Received</option>
									<option value="Cancelled">Cancelled</option>
									<option value="Re-Issued">Re-Issued</option>
								</select>
								<br>&nbsp;
								<input type="text" id="challanIssuedDate2" value="<%=strChallanIssueDate_2 %>" readonly="readonly" name="dob" placeholder='Challan Issuing Date?' />
								<input type="text" id="challanAckDate2" value="<%=strChallanAckDate_2 %>" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
								<input type="text" id="challanReason2" name="challanReason2" value="<%=strChallanReason_2 %>" placeholder='Reason for Cancellation (or) Re-Issue?' STYLE="width:230px"/>
								</td>
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">Cash - II</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='cashPay2'>
							<table>
							<tr>
								<td class='label'><i><b>Cash Amount</b></i></td>
								<td><input type="text" id="cashAmountTwo" name="cashAmountTwo" value="<%=strCashAmountTwo %>" STYLE="width:170px"/></td>
								<td class='label'>Date</td>
								<td><input type="text" id="cashReceiptDate2" value="<%=strCashReceiptDate_2 %>" readonly="readonly" name="dob"/></td>							
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">DD - II</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='ddPay2'>
							<table>
							<tr>
								<td class='label'><i><b>DD Amount</b></i></td>
								<td><input type="text" id="ddAmountTwo" name="ddAmountTwo" value="<%=strDdAmountTwo %>" STYLE="width:170px"/></td>
								<td class='label'>Drawee Bank</td>
								<td><input type="text" id="draweeBank2" name="draweeBank2" value="<%=strDdDraweeBank_2 %>" /></td>
								<td class='label'>DD Dated (Drawn On)</td>
								<td><input type="text" id="ddDrwanDate2" value="<%=strDdDrawnDate_2 %>" readonly="readonly" name="dob"/></td>
								</tr>
								<tr>
								<td class='label'>DD Number</td>
								<td><input type="text" id="ddNo2" name="ddNo2" value="<%=strDdNo_2 %>" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="ddSubmitDate2" value="<%=strDdSubmitDate_2 %>" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td colspan=2 width=30% align=center class="button pink gradient">Payment - III</td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td width=30% align=right class="button navy">Challan - III</td>
					</tr>
										
					<tr>
						<td colspan=2>
						
							<div id='challanPay3'>
							<table>
							<tr>
								<td class='label'><i><b>Challan Amount</b></i></td>
								<td><input type="text" id="challanAmountThree" name="challanAmountThree" value="<%=strChallanAmountThree %>" STYLE="width:170px"/></td>
								<td class='label'>Status</td>
								<td>
								<select id="challanStatus3" STYLE="width:170px" onChange='javascript:chooseChallanStatusThree()'>
									<option value="">Select</option>
									<option value="Issued">Issued</option>
									<option value="Ack.Received">Ack.Received</option>
									<option value="Cancelled">Cancelled</option>
									<option value="Re-Issued">Re-Issued</option>
								</select>
								<br>&nbsp;
								<input type="text" id="challanIssuedDate3" value="<%=strChallanIssueDate_3 %>" readonly="readonly" name="dob" placeholder='Challan Issuing Date?' />
								<input type="text" id="challanAckDate3" value="<%=strChallanAckDate_3 %>" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
								<input type="text" id="challanReason3" name="challanReason3" value="<%=strChallanReason_3 %>" placeholder='Reason for Cancellation (or) Re-Issue?' STYLE="width:230px"/>
								</td>
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">Cash - III</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='cashPay3'>
							<table>
							<tr>
								<td class='label'><i><b>Cash Amount</b></i></td>
								<td><input type="text" id="cashAmountThree" name="cashAmountThree" value="<%=strCashAmountThree %>" STYLE="width:170px"/></td>
								<td class='label'>Date</td>
								<td><input type="text" id="cashReceiptDate3" value="<%=strCashReceiptDate_3 %>" readonly="readonly" name="dob"/></td>							
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">DD - III</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='ddPay3'>
							<table>
							<tr>
								<td class='label'><i><b>DD Amount</b></i></td>
								<td><input type="text" id="ddAmountThree" name="ddAmountThree" value="<%=strDdAmountThree %>" STYLE="width:170px"/></td>
								<td class='label'>Drawee Bank</td>
								<td><input type="text" id="draweeBank3" name="draweeBank3" value="<%=strDdDraweeBank_3 %>" /></td>
								<td class='label'>DD Dated (Drawn On)</td>
								<td><input type="text" id="ddDrwanDate3" value="<%=strDdDrawnDate_3 %>" readonly="readonly" name="dob"/></td>
								</tr>
								<tr>
								<td class='label'>DD Number</td>
								<td><input type="text" id="ddNo3" name="ddNo3" value="<%=strDdNo_3 %>" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="ddSubmitDate3" value="<%=strDdSubmitDate_3 %>" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td colspan=2 width=30% align=center class="button pink gradient">Payment - IV</td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td width=30% align=right class="button navy">Challan - IV</td>
					</tr>
										
					<tr>
						<td colspan=2>
						
							<div id='challanPay4'>
							<table>
							<tr>
								<td class='label'><i><b>Challan Amount</b></i></td>
								<td><input type="text" id="challanAmountFour" name="challanAmountFour" value="<%=strChallanAmountFour %>" STYLE="width:170px"/></td>
								<td class='label'>Status</td>
								<td>
								<select id="challanStatus4" STYLE="width:170px" onChange='javascript:chooseChallanStatusFour()'>
									<option value="">Select</option>
									<option value="Issued">Issued</option>
									<option value="Ack.Received">Ack.Received</option>
									<option value="Cancelled">Cancelled</option>
									<option value="Re-Issued">Re-Issued</option>
								</select>
								<br>&nbsp;
								<input type="text" id="challanIssuedDate4" value="<%=strChallanIssueDate_4 %>" readonly="readonly" name="dob" placeholder='Challan Issuing Date?' />
								<input type="text" id="challanAckDate4" value="<%=strChallanAckDate_4 %>" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
								<input type="text" id="challanReason4" name="challanReason4" value="<%=strChallanReason_4 %>" placeholder='Reason for Cancellation (or) Re-Issue?'  STYLE="width:230px"/>
								</td>
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">Cash - IV</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='cashPay4'>
							<table>
							<tr>
								<td class='label'><i><b>Cash Amount</b></i></td>
								<td><input type="text" id="cashAmountFour" name="cashAmountFour" value="<%=strCashAmountFour %>" STYLE="width:170px"/></td>
								<td class='label'>Date</td>
								<td><input type="text" id="cashReceiptDate4" value="<%=strCashReceiptDate_4 %>" readonly="readonly" name="dob"/></td>							
							</tr>
							</table>
							</div>
					</tr>
					<tr>
						<td width=30% align=right class="button navy">DD - IV</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='ddPay4'>
							<table>
							<tr>
								<td class='label'><i><b>DD Amount</b></i></td>
								<td><input type="text" id="ddAmountFour" name="ddAmountFour" value="<%=strDdAmountFour %>" STYLE="width:170px"/></td>
								<td class='label'>Drawee Bank</td>
								<td><input type="text" id="draweeBank4" name="draweeBank4" value="<%=strDdDraweeBank_4 %>" /></td>
								<td class='label'>DD Dated (Drawn On)</td>
								<td><input type="text" id="ddDrwanDate4" value="<%=strDdDrawnDate_4 %>" readonly="readonly" name="dob"/></td>
								</tr>
								<tr>
								<td class='label'>DD Number</td>
								<td><input type="text" id="ddNo4" name="ddNo4" value="<%=strDdNo_4 %>" /></td>
								<td class='label'>Date</td>
								<td><input type="text" id="ddSubmitDate4" value="<%=strDdSubmitDate_4 %>" readonly="readonly" name="dob"/></td>
							</tr>
							</table>
							</div>
							</tr>
							-->
							</table>
							</form>
							</div>
<table id="maintab2" class="formtab textbox_medium tbl_p3 textarea_normal " >
<!-- <tr><td colspan=2>&nbsp;</td></tr>
<%
	if(strFlag.intern()=="U".intern()) {
%>
	<tr><td colspan=2 class="button navy gradient">Photo</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td colspan=2>
			<form action="UploadAdmissionProfile.jsp" method="post" enctype="multipart/form-data" name="admission_profile" id="admission_profile">
			<input type="hidden" id="student_adm_no" name="student_adm_no" value="<%=strFullAdmNum %>">
			Upload Photo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" name="updatePhotoFile" size="20" value="Upload Photo" id="updatePhotoFile" class='rounded-corners' />
			</form>
			<div id='photopreview'></div>
		</td>
	
</tr>

<%}%>
 -->
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
			
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
	<tr>
		<td colspan=2 align=center>
			<%
				if(strFlag.intern()=="U".intern()) {
			%>
			<input type="button" class="clickButton" value="Update Application" onClick='javascript:updateApp()'/>
			<%
				}else{
			%>
				<input type="button" class="clickButton" value="Save Application" onClick='javascript:saveApp()'/>
			<%}%>
		</td>
	</tr>

	<tr><td colspan=2>&nbsp;</td></tr>
</table>
<%@include file="Footer.jsp" %>

<%@include file="ToolTip.jsp" %>
  <div id="dialog-message" style="display:none;" title="Message"><p id="diaMsg" style="width:auto;"></p></div>
 
</body>
</html>