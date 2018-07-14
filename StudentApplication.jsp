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
//ResourceBundle rb=ResourceBundle.getBundle("admission",new Locale("en", "US"));
String exam_id=request.getParameter("exam_id");
String strRole=(String)session.getAttribute("role");
String mkr_id=(String)session.getAttribute("login_id");

String full_adm_no="";
String strAppnNum="";
String strStuName="";
String strFullAdmNo="";
String strGender="";
String strAdmissionFee="";
String strAppDate="";
String strDOB="";
String strCommunity="";
String strFixedTuitionFee="";
String strConcessionAmount="";
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
String strParName="";
String strAdmissionStatus="";
String strAdmQuota="";
String strPcmMarks="";
String strConcessionType="";

String strCashAmountOne="";
String strCashReceiptDate_1="";
String strChallanAmountOne="";
String strChallanNo_1="";
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
String strChallanNo_2="";
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
String strChallanNo_3="";
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
String strChallanNo_4="";
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

String strAmountOne="0";
String strAmountTwo="0";
String strAmountThree="0";
String strAmountFour="0";

String strCashReceiptNo1="0";
String strDdReceiptNo1="0";
String strCashReceiptNo2="0";
String strDdReceiptNo2="0";
String strCashReceiptNo3="0";
String strDdReceiptNo3="0";
String strCashReceiptNo4="0";
String strDdReceiptNo4="0";

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
try{
		full_adm_no=request.getParameter("appn_no");
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("SELECT appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,std,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_status_1,challan_issue_date_1,challan_ack_date_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_status_2,challan_issue_date_2,challan_ack_date_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_status_3,challan_issue_date_3,challan_ack_date_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_status_4,challan_issue_date_4,challan_ack_date_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,(cash_amount_1+challan_amount_1+dd_amount_1) AS amount_1,(cash_amount_2+challan_amount_2+dd_amount_2) AS amount_2,(cash_amount_3+challan_amount_3+dd_amount_3) AS amount_3,(cash_amount_4+challan_amount_4+dd_amount_4) AS amount_4,total_paid,inserted_by FROM student_admission WHERE full_adm_no=?");
		pst.setString(1, full_adm_no);
		System.out.println(pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			strAppnNum=rs.getString("appn_no");
			strStuName=rs.getString("stu_name");
			strAppDate=rs.getString("app_date");
			strParName=rs.getString("par_name");
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
			
			strCashAmountOne=rs.getString("cash_amount_1");
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
			System.out.println("strCashAmountOne-->"+strCashAmountOne);
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
			
			strTotalPaid=rs.getString("total_paid");
			strUser=rs.getString("inserted_by");
			System.out.println("Before rs-->"+strCashReceiptNo1);
			strCashReceiptNo1=rs.getString("cash_receipt_no_1");
			System.out.println("After rs-->"+strCashReceiptNo1);
			strDdReceiptNo1=rs.getString("dd_receipt_no_1");
			strCashReceiptNo2=rs.getString("cash_receipt_no_2");
			strDdReceiptNo2=rs.getString("dd_receipt_no_2");
			strCashReceiptNo3=rs.getString("cash_receipt_no_3");
			strDdReceiptNo3=rs.getString("dd_receipt_no_3");
			strCashReceiptNo4=rs.getString("cash_receipt_no_4");
			strDdReceiptNo4=rs.getString("dd_receipt_no_4");
			
			strAmountOne=rs.getString("amount_1");
			strAmountTwo=rs.getString("amount_2");
			strAmountThree=rs.getString("amount_3");
			strAmountFour=rs.getString("amount_4");
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
<title>Student Admission List</title>
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
<style>
.tab{
    border-collapse: collapse;
	border: 1px solid black;
}
</style>
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
<tr>
	<td colspan=2>
							<input type='hidden' name='exam_id' id='exam_id' value='<%=exam_id%>'>
	<TR>
			<td colspan="2" class="button navy gradient">Personal Details</td>
</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
											<td class="tab"><label for="full_adm_no"  width='200px'>Admission No</td>
											<td class="tab"><%=full_adm_no %></td>
										</tr>
										<tr>
											<td class="tab"><label for="appn_no"  width='200px'>Application No</td>
											<td class="tab"><%=strAppnNum %></td>
										</tr>
										<tr>
											<td class='label tab'>Application Date</td>
											<td class="tab"><%=strAppDate %></td>
										</tr>
										<tr>
											<td class='label tab'>Candidate Name</td>
											<td class="tab"><%=strStuName %></td>
										</tr>
										<tr>
											<td class='label tab'>Parent Name</td>
											<td class="tab"><%=strParName %></td>
										</tr>
										<tr>
											<td class='label tab'>Date of Birth</td>
											<td class="tab"><%=strDOB %></td>
										</tr>
										<tr>
											<td class='label tab'>Gender</td>
											<td class="tab"><%=strGender %></td>
										</tr>
										<tr>
											<td class='label tab'>Community</td>
											<td class="tab"><%=strCommunity %></td>
										</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
							<tr>
							<td colspan="2" class="button navy gradient">Course Details</td>
							</tr>
								<tr><td colspan=2>&nbsp;</td></tr>							
								<tr>
									<td class='label tab'>Course</td>
									<td class="tab"><%=strCourse %></td>
								</tr>
								<tr>
									<td class='label tab'>Branch</td>
									<td class="tab"><%=strBranch %></td>
								</tr>
								<tr> 
									<td class='label tab'>Student Type</td>
									<td class="tab"><%=strStudentType %></td>
								</tr>
								<tr><td colspan=2>&nbsp;</td></tr>								
							<tr>
							<td colspan="2" class="button navy gradient">Address Details</td>
							</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
									<td class='label tab'>Permanent Address</td>
									<td class="tab"><%=strAddress %></td>
								</tr>
								<tr>
									<td class='label tab'>City</td>
									<td class="tab"><%=strCity %></td>
								</tr>
								<tr>
									<td class='label tab'>State</td>
									<td class="tab"><%=strState %></td>
								</tr>
								<tr>
									<td class='label tab'>Country</td>
									<td class="tab"><%=strCountry %></td>
								</tr>								
								<tr>
									<td class='label tab'>Pin Code</td>
									<td class="tab"><%=strPin %></td>
								</tr>
								<tr>
									<td class='label tab'>Phone No</td>
									<td class="tab"><%=strStd %> <%=strPhone %></td>
								</tr>
								<tr>
									<td class='label tab'>Mobile No</td>
									<td class="tab"><%=strMobile %></td>
								</tr>
								<tr>
									<td class='label tab'>Email Id</td>
									<td class="tab"><%=strEmail %></td>
								</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
							<tr>
							<td colspan="2" class="button navy gradient">Admission Details</td>
							</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
									<td class='label tab'>Admission Status</td>
									<td class="tab"><%=strAdmissionStatus %></td>
								</tr>
								<tr>
									<td class='label tab'>Admission Quota</td>
									<td class="tab"><%=strAdmQuota %></td>
								</tr>
								<tr>
									<td class='label tab'>Fixed Tuition Fee</td>
									<td class="tab"><%=strFixedTuitionFee %></td>
								</tr>
								<tr>
									<td class='label tab'>Concession Type</td>
									<td class="tab"><%=strConcessionType %></td>
								</tr>
								<tr>
									<td class='label tab'>PCM/PCB %age</td>
									<td class="tab"><%=strPcmMarks %></td>
								</tr>
								<tr>
									<td class='label tab'>Concession Amount</td>
									<td class="tab"><%=strConcessionAmount %></td>
								</tr>
								<tr>
									<td class='label tab'>Referred By</td>
									<td class="tab"><%=strReference %>
								<%
								if(strReference.intern()=="Others".intern()) {
								%>
								<%=strOtherReferenceName %>
								<%=strOtherReferenceContact %>
								<%}%>
								</td>
								</tr>
								
								<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
					<td colspan="2" class="button navy gradient">Miscellaneous</td>
					</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
								<tr>
									<td class='label tab'><b> Hostel ?</b></td>
									<td class="tab"><%=strHostel %></td>
								</tr>
								<tr>
									<td class='label tab'>Transportation ?</td>
									<td class="tab"><%=strTransport %></td>
								</tr>								
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
					<td colspan="2" class="button navy gradient">Payment</td>
					</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td class='label tab'>Total Paid</td>
						<td class="tab"><%=strTotalPaid %></td>
					</tr>
					
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
					<td colspan=2 align=center>
						<table width="100%">
						<tr>
							<td class="button1 navy gradient">Term</td>
							<td class="button1 navy gradient">Amount</td>
						</tr>
						<tr>
							<td class="tab"><b>I</b></td>
							<td class="tab"><%=strAmountOne %></td>
						</tr>
						</tr>
						<tr>
							<td class="tab"><b>II</b></td>
							<td class="tab"><%=strAmountTwo %></td>
						</tr>
						<tr>
							<td class="tab"><b>III</b></td>
							<td class="tab"><%=strAmountThree %></td>
						</tr>
						<tr>
							<td class="tab"><b>IV</b></td>
							<td class="tab"><%=strAmountFour %></td>
						</tr>						
						</table>
					</td>
					</tr>
								<tr><td colspan=2>&nbsp;</td></tr>
		</table>
</div>
</section>

	<%@include file="Footer.jsp" %>
</div>
	</body>
</html>