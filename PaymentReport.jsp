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
String strFlag=request.getParameter("flag");
String strRole=(String)session.getAttribute("role");
String strMakerId=(String)session.getAttribute("login_id");

String strFullAdmNo="";
String strStuName="";
String strFixedTuitionFee="";
String strConcessionAmount="";

String strCashReceiptNo="";
String strCashAmount="";
String strCashReceiptDate="";
String strChallanAmount="";
String strChallanNo="";
String strChallanStatus="";
String strChallanIssueDate="";
String strChallanAckDate="";
String strChallanReason="";
String strChallanReceivedAmount="";
String strDdReceiptNo="";
String strDdAmount="";
String strDdDraweeBank="";
String strDdDrawnDate="";
String strDdNo="";
String strDdSubmitDate="";

String strTotalPaid="";

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
try{
	strFullAdmNo=request.getParameter("appn_no");
	con=ConnectDatabase.getConnection();

	if(strFlag.equals("1"))
	{
		pst=con.prepareStatement("SELECT stu_name,fixed_tuition_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_issue_date_1,challan_ack_date_1,challan_status_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, concession_amt FROM student_admission WHERE full_adm_no=?");
	}
	else if(strFlag.equals("2"))
	{
		pst=con.prepareStatement("SELECT stu_name,fixed_tuition_fee,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_issue_date_2,challan_ack_date_2,challan_status_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, concession_amt FROM student_admission WHERE full_adm_no=?");
	} 
	else if(strFlag.equals("3"))
	{
		pst=con.prepareStatement("SELECT stu_name,fixed_tuition_fee,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_issue_date_3,challan_ack_date_3,challan_status_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, concession_amt FROM student_admission WHERE full_adm_no=?");
	}
	else if(strFlag.equals("4"))
	{
		pst=con.prepareStatement("SELECT stu_name,fixed_tuition_fee,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_issue_date_4,challan_ack_date_4,challan_status_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, concession_amt FROM student_admission WHERE full_adm_no=?");
	}
		pst.setString(1, strFullAdmNo);
		System.out.println(pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			strStuName=rs.getString(1);
			strFixedTuitionFee=rs.getString(2);
			
			strCashReceiptNo=rs.getString(3);
			strCashAmount=rs.getString(4);
			strCashReceiptDate=rs.getString(5);
			
			strChallanNo=rs.getString(6);
			strChallanAmount=rs.getString(7);
			strChallanIssueDate=rs.getString(8);
			strChallanAckDate=rs.getString(9);
			strChallanStatus=rs.getString(10);
			strChallanReason=rs.getString(11);
			
			strDdReceiptNo=rs.getString(12);
			strDdAmount=rs.getString(13);
			strDdDraweeBank=rs.getString(14);
			strDdDrawnDate=rs.getString(15);
			strDdNo=rs.getString(16);
			strDdSubmitDate=rs.getString(17);
			
			strTotalPaid=rs.getString(18);
			strConcessionAmount=rs.getString(19);
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
<title>Payment Report</title>
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

	$(function() {			
		
		$( "#challanReIssuedDate" ).datepicker({
			changeMonth: true, 
			changeYear: true,  
			dateFormat: 'dd-M-yy',
			yearRange: "2010:2020" });
		$('#challanReIssuedDate').datepicker().trigger('change');
		
		$( "#challanAckDate" ).datepicker({
			changeMonth: true, 
			changeYear: true,  
			dateFormat: 'dd-M-yy',
			yearRange: "2010:2020" });
		$('#challanAckDate').datepicker().trigger('change');

});

	function removerr(obj) { $(obj).removeClass("error_input"); }

		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}

		function updateChallanStatus() {
			if(document.formPayment.challanStatus.value=="")
			{
				alert("Please Choose the Status.");
			} else 
			{
				postRequest("UpdateChallanStatus.jsp");
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
		
		
		function setParams() 
		{
			var FullAdmissionNum=document.getElementById("fullAdmNum").value;

			var ChallanAmount=encodedVal("challanAmount");
			var ChallanStatus=encodedVal("challanStatus");
			var ChallanAckDate=encodedVal("challanAckDate");
			
	//alert("4");
var IPAddr="<%= getClientIpAddr(request) %>";
var parameters="FullAdmissionNum="+FullAdmissionNum+
"&ChallanAmount="+ChallanAmount+
"&ChallanStatus="+ChallanStatus+
"&ChallanAckDate="+ChallanAckDate+
"&TotalPaid="+"<%=strTotalPaid%>"+
"&MakerId=<%=strMakerId%>"+
"&Flag="+"<%=strFlag%>"+
"&IPAddr="+IPAddr;
//alert("5");
			return parameters;
		}

		function encodedVal(str) {
			return encodeURIComponent(document.getElementById(str).value);
		}
		function getVal(str) {
			return document.getElementById(str).value;
		}
		
		function postRequest(strURL) {
			
			var parameters=setParams();
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
		
		function updatePage(str){
			var arr=str.split("~");
			if(arr[0].trim()=="0000".trim())
			{
					alert("Result : " + "Payment form has been updated.");
					window.location=arr[1];
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
		
		function printCash() {
			//alert("all");
			strURL="servlet/PrintReceipt";
			var parameters="ReceiptNo="+document.getElementById("cashReceiptNo").value;
			strURL+="?"+parameters;
			//alert(strURL);
			location.href=strURL;
		}
		
		function printChallan() {
			//alert("all");
			strURL="servlet/PrintReceipt";
			var parameters="ReceiptNo="+document.getElementById("challanReceiptNo").value;
			strURL+="?"+parameters;
			//alert(strURL);
			location.href=strURL;
		}
		
		function printDemandDraft() {
			//alert("all");
			strURL="servlet/PrintReceipt";
			var parameters="ReceiptNo="+document.getElementById("ddReceiptNo").value;
			strURL+="?"+parameters;
			//alert(strURL);
			location.href=strURL;
		}

		function updatePayment() {
			strURL="UpdatePaymentEdit.jsp";
			var parameters="appn_no="+document.getElementById("fullAdmNum").value+"&flag="+"<%=strFlag %>";
			strURL+="?"+parameters;
			//alert(strURL);
			location.href=strURL;
		}

		function chooseChallanStatus() {
			if ( getVal("challanStatus")=="Ack.Received" )
			{
				document.getElementById('challanReIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="block";
				document.getElementById('challanReason').style.display="none";
			}
			else if ( getVal("challanStatus")=="Cancelled" )
			{
				document.getElementById('challanReIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="block";
			}
			else if ( getVal("challanStatus")=="Re-Issued" )
			{
				document.getElementById('challanReIssuedDate').style.display="block";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="block";
			}
			else
			{
				document.getElementById('challanReIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="none";
			}
		}
		
		function disablePayment()
		{
			document.getElementById('challanReIssuedDate').style.display="none";
			document.getElementById('challanAckDate').style.display="none";
			document.getElementById('challanReason').style.display="none";
		}
		
</script>

<%@include file="MBHandler.jsp" %>
</head>
<body onLoad="disablePayment();">
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
    <!-- <table width="90%" align="center"> -->
	<form id="formPayment" name="formPayment" action="" method="post">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td colspan="2" align=center class="button pink gradient">Student Data</td>
	</tr>
					<tr>
						<td><label for="fullAdmNum" style="width:200px">Admission No</label></td>
						<td><%=strFullAdmNo%><input type="hidden" id="fullAdmNum" name="fullAdmNum" value="<%=strFullAdmNo%>" /></td>
					</tr>
					<tr>
						<td class='label'>Name</td>
						<td><%=strStuName %></td>
					</tr>

					<tr>
						<td colspan="2" width=30% align=center class="button pink gradient">Payment - <%=strFlag %></td>
						</tr>
					<tr>
						<td class='label'><i><b>Fixed Tuition Fee</b></i></td>
						<td><%=strFixedTuitionFee%><input type="hidden" id="fixedTuitionFee" name="fixedTuitionFee" value="<%=strFixedTuitionFee%>"/></td>
					</tr>
					<tr>
						<td class='label'><i><b>Concession Amount</b></i></td>
						<td><%=strConcessionAmount%><input type="hidden" id="totalPaid" name="totalPaid" value="<%=strTotalPaid%>"/></td>
					</tr>
					<tr>
						<td class='label'><i><b>Total Paid</b></i></td>
						<td><%=strTotalPaid%><input type="hidden" id="totalPaid" name="totalPaid" value="<%=strTotalPaid %>" /></td>
					</tr>
					<tr><td colspan=2>&nbsp;</td></tr>
<%
if(!strChallanNo.equals("0")){
%>
					<tr>
						<td width=30% align=right class="button green">Challan</td>
					</tr>
										
					<tr>
						<td colspan=2>
						
							<div id='challanPay'>
							<table>
							<tr>
								<td class='label'><i><b>Challan Amount</b></i></td>
								<td>:</td>
								<td><%=strChallanAmount%><input type="hidden" id="challanAmount" name="challanAmount" value="<%=strChallanAmount%>"/></td>
							</tr>
							<tr>
								<td class='label'>Challan Number</td>
								<td>:</td>
								<td><%=strChallanNo%><input type="hidden" id="challanReceiptNo" name="challanReceiptNo" value="<%=strChallanNo%>"/></td>
							</tr>
<%
if(!strChallanStatus.equals("Ack.Received")){
%>
							<tr>
							<td class='label'>Status</td>
							<td>:</td>
							<td>
							<select id="challanStatus" STYLE="width:170px" onChange='javascript:chooseChallanStatus()'>
								<option value="">Select</option>
								<option value="Ack.Received">Ack.Received</option>
<!-- 								<option value="Cancelled">Cancelled</option>
								<option value="Re-Issued">Re-Issued</option>
 -->							</select>
							<br>&nbsp;
							<input type="text" id="challanReIssuedDate" readonly="readonly" name="dob" placeholder='Challan Re-Issuing Date?' />
							<input type="text" id="challanAckDate" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
							<input type="text" id="challanReason" name="challanReason" placeholder='Reason for Cancellation (or) Re-Issue?'  STYLE="width:230px"/>
							</td>
							</tr>
							<tr>
							<td colspan=2>
								<input type="button" class="clickButton" value="CHALLAN PRINT" onclick="javascript:printChallan()"/>
							</td>
							<td colspan=2>
								<input type="button" class="clickButton" value="UPDATE STATUS" onclick="javascript:updateChallanStatus()"/>
							</td>
							</tr>							
<%
}
else
{
%>							
							<tr>
							<td colspan=3>
								<input type="button" class="clickButton" value="CHALLAN PRINT" onclick="javascript:printChallan()"/>
							</td>
							</tr>
<%
}
%>

							</table>
							</div>
							</td>
					</tr>
<%
}
if(!strCashReceiptNo.equals("0")){
%>
					<tr>
						<td width=30% align=right class="button green">Cash</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='cashPay'>
							<table>
							<tr>
								<td class='label'><i><b>Cash Amount</b></i></td>
								<td>:</td>
								<td><%=strCashAmount%></td>
								</tr>
								<tr>
								<td class='label'>Cash Receipt No</td>
								<td>:</td>
								<td><%=strCashReceiptNo%><input type="hidden" id="cashReceiptNo" name="cashReceiptNo" value="<%=strCashReceiptNo %>"/></td>
							</tr>
								<tr>
								<td class='label'>Date</td>
								<td>:</td>
								<td><%=strCashReceiptDate%></td>
							</tr>
							<tr>
							<td colspan=3>
								<input type="button" class="clickButton" value="CASH RECEIPT PRINT" onclick="javascript:printCash()"/>
							</td>
							</tr>
							</table>
							</div>
							</td>
					</tr>
<%
}
if(!strDdReceiptNo.equals("0")){
%>					<tr>
						<td width=30% align=right class="button green">DD</td>
					</tr>
										
					<tr>
						<td colspan=2>
							<div id='ddPay'>
							<table>
							<tr>
								<td class='label'><i><b>DD Receipt No</b></i></td>
								<td>:</td>
								<td><%=strDdReceiptNo%><input type="hidden" id="ddReceiptNo" name="ddReceiptNo" value="<%=strDdReceiptNo %>"/></td>
								</tr>
							<tr>
								<td class='label'><i><b>DD Amount</b></i></td>
								<td>:</td>
								<td><%=strDdAmount%></td>
								</tr>
								<tr>
								<td class='label'>Drawee Bank</td>
								<td>:</td>
								<td><%=strDdDraweeBank%></td>
								</tr>
								<tr>
								<td class='label'>DD Dated (Drawn On)</td>
								<td>:</td>
								<td><%=strDdDrawnDate%></td>
								</tr>
								<tr>
								<td class='label'>DD Number</td>
								<td>:</td>
								<td><%=strDdNo%></td>
								</tr>
								<tr>
								<td class='label'>Submit Date</td>
								<td>:</td>
								<td><%=strDdSubmitDate%></td>
								</tr>
							<tr>
							<td colspan=3>
								<input class="clickButton" type="button" value="DD RECEIPT PRINT" onclick="javascript:printDemandDraft()"/>
							</td>
							</tr>
							</table>
							</div>
							</td>
					</tr>
<%
}
%>					
<!-- 							<tr>
							<td colspan=3>
								<input class="clickButton" type="button" value="Update Payment" onclick="javascript:updatePayment()"/>
							</td>
							</tr>
 -->		</table>
		</form>
</div>
	<%@include file="Footer.jsp" %>
</body>
</html>