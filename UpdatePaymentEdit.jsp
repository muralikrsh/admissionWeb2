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

String flag=request.getParameter("flag");
String strRole=(String)session.getAttribute("role");
String mkr_id=(String)session.getAttribute("login_id");
String strMakerId=(String)session.getAttribute("login_id");

String strAppnNum="";
String strStuName="";
String strFullAdmNo="";
String strConcessionAmount="";
String strCertificationFee="";
String strCertificationPayMode="";

String strTotalPaid="";
String mkr_date="";
String strUser="";
String strFixedTuitionFee="";

Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
try{
		strFullAdmNo=request.getParameter("appn_no");
		con=ConnectDatabase.getConnection();
		pst=con.prepareStatement("select stu_name, (cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, fixed_tuition_fee, concession_amt, inserted_by, cert_verify_fee, cert_pay_mode from student_admission where full_adm_no=?");
		pst.setString(1, strFullAdmNo);
		System.out.println(pst);
		rs=pst.executeQuery();
		if(rs.next()) {
			strStuName=rs.getString("stu_name");
			strTotalPaid=rs.getString("tot_paid");
			strFixedTuitionFee=rs.getString("fixed_tuition_fee");
			strConcessionAmount=rs.getString("concession_amt");
			strUser=rs.getString("inserted_by");
			strCertificationFee=rs.getString("cert_verify_fee");
			strCertificationPayMode=rs.getString("cert_pay_mode");
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
<title>Update Payment</title>
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

		function updateApp() {
			if($("#formPersonal").valid() ) {
				postRequest("UpdatePaymentEditResult.jsp");
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
		
		
		function setParams() 
		{
			var CertificationFee=document.getElementById("certificationFee").value;
			var CertificationPayMode=encodedVal("certificationPayMode");
			if(CertificationPayMode=="" && CertificationFee!=""){
				alert("Please Choose the Payment Mode");
				document.getElementById("certificationPayMode").focus();
			}
			else{
			var certFee="<%=strCertificationFee %>";
			var certFeePayMode="<%=strCertificationPayMode %>";
			var CertPrint="No";
			var FullAdmissionNum=document.getElementById("fullAdmNum").value;
			
			if(certFee==0.00 && CertificationFee!="")
			{
				CertPrint="Yes";
			}
			alert("1 "+certFee+" "+CertPrint+". "+CertificationFee+" "+CertificationPayMode);
			var CashAmount=encodedVal("cashAmount");
			var CashReceiptDate=encodedVal("cashReceiptDate");
			var ChallanAmount=encodedVal("challanAmount");
			var ChallanStatus=encodedVal("challanStatus");
			var ChallanIssuedDate=encodedVal("challanIssuedDate");
			var ChallanAckDate=encodedVal("challanAckDate");
			var ChallanReason=encodedVal("challanReason");
			var DdAmount=encodedVal("ddAmount");
			var DraweeBank=encodedVal("draweeBank");
			var DdDrwanDate=encodedVal("ddDrwanDate");
			var DdNo=encodedVal("ddNo");
			var DdSubmitDate=encodedVal("ddSubmitDate");
			var FixedTuitionFee=encodedVal("fixedTuitionFee");
			
	//alert("4");
var IPAddr="<%= getClientIpAddr(request) %>";
var parameters="FullAdmissionNum="+FullAdmissionNum+
"&StudentName="+"<%=strStuName%>"+
"&CertificationFee="+CertificationFee+
"&CertificationPayMode="+CertificationPayMode+
"&CertPrint="+CertPrint+
"&CashAmount="+CashAmount+
"&CashReceiptDate="+CashReceiptDate+
"&ChallanAmount="+ChallanAmount+
"&ChallanIssuedDate="+ChallanIssuedDate+
"&ChallanStatus="+ChallanStatus+
"&ChallanAckDate="+ChallanAckDate+
"&ChallanReason="+ChallanReason+
"&DdAmount="+DdAmount+
"&DraweeBank="+DraweeBank+
"&DdDrwanDate="+DdDrwanDate+
"&DdNo="+DdNo+
"&DdSubmitDate="+DdSubmitDate+
"&FixedTuitionFee="+FixedTuitionFee+
"&TotalPaid="+"<%=strTotalPaid%>"+
"&ConcessionAmount="+"<%=strConcessionAmount%>"+
"&MakerId="+"<%=strMakerId%>"+
"&Flag="+"<%=flag%>"+
"&IPAddr="+IPAddr;
//alert("5");
			return parameters;
		}
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
				alert("Admission form has been Updated.");
				//displayAlert("Result : " + "Admission form has been updated.",'goAdmissionReport');
				window.location=arr[1];
			}
		}
		
		function cancel(){
			location.href='Home.jsp';
		}
		
		function chooseChallanStatus() {
			if ( getVal("challanStatus")=="Issued" )
			{
				document.getElementById('challanIssuedDate').style.display="block";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="none";
			}
			else if ( getVal("challanStatus")=="Ack.Received" )
			{
				document.getElementById('challanIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="block";
				document.getElementById('challanReason').style.display="none";
			}
			else if ( getVal("challanStatus")=="Cancelled" )
			{
				document.getElementById('challanIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="block";
			}
			else if ( getVal("challanStatus")=="Re-Issued" )
			{
				document.getElementById('challanIssuedDate').style.display="block";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="block";
			}
			else
			{
				document.getElementById('challanIssuedDate').style.display="none";
				document.getElementById('challanAckDate').style.display="none";
				document.getElementById('challanReason').style.display="none";
			}
		}

		$(function() {			

			$( "#cashReceiptDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#cashReceiptDate').datepicker().trigger('change');
			
			$( "#challanIssuedDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanIssuedDate').datepicker().trigger('change');
			
			$( "#challanAckDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#challanAckDate').datepicker().trigger('change');

			$( "#ddDrwanDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddDrwanDate').datepicker().trigger('change');

			$( "#ddSubmitDate" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "2010:2020" });
			$('#ddSubmitDate').datepicker().trigger('change');
			
	});

	function disablePayment()
	{
		document.getElementById('challanIssuedDate').style.display="none";
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
	<form id="formPersonal" name="formPersonal" action="" method="post">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<TR><td >&nbsp;</td></tr>
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
		<td colspan="2" width=30% align=center class="button pink gradient">Payment - <%=flag %></td>
		</tr>
	<tr>
		<td class='label'><i><b>Fixed Tuition Fee</b></i></td>
		<td><%=strFixedTuitionFee%><input type="hidden" id="fixedTuitionFee" name="fixedTuitionFee" value="<%=strFixedTuitionFee%>"/></td>
	</tr>
	<tr>
		<td class='label'><i><b>Total Paid</b></i></td>
		<td><%=strTotalPaid%><input type="hidden" id="totalPaid" name="totalPaid" value="<%=strTotalPaid%>"/></td>
	</tr>

	<tr>
		<td class='label'><i><b>Scholarship</b></i></td>
		<td><%=strConcessionAmount%></td>
	</tr>

	<tr>
<%if(strCertificationFee.equals("0.00")){ %>
		<td class='label'><i><b>Certification Verifcation Fee</b></i></td>
		<td><input type="text" id="certificationFee" name="certificationFee"/>
		<select id="certificationPayMode" style="width:170px">
			<option value="">Mode</option>
			<option value="Cash">Cash</option>
			<option value="Challan">Challan</option>
			<option value="DD">DD</option>
		</select>
<%}
else
{
%>
		<input type="hidden" id="certificationFee" name="certificationFee" value=<%=strCertificationFee %> />
		<input type="hidden" id="certificationPayMode" name="certificationPayMode" value=<%=strCertificationPayMode %> />
<%} %>
		</td>
	</tr>
		<tr><td colspan=2>&nbsp;</td></tr>
		<tr>
			<td width=30% align=right class="button navy">Challan</td>
		</tr>
							
		<tr>
			<td colspan=2>
			
				<div id='challanPay'>
				<table>
				<tr>
					<td class='label'><i><b>Challan Amount</b></i></td>
					<td><input type="text" id="challanAmount" name="challanAmount" STYLE="width:170px"/></td>
					<td class='label'>Status</td>
					<td>
					<select id="challanStatus" STYLE="width:170px" onChange='javascript:chooseChallanStatus()'>
						<option value="">Select</option>
						<option value="Issued">Issued</option>
						<option value="Ack.Received">Ack.Received</option>
						<option value="Cancelled">Cancelled</option>
						<option value="Re-Issued">Re-Issued</option>
					</select>
					<br>&nbsp;
					<input type="text" id="challanIssuedDate" readonly="readonly" name="dob" placeholder='Challan Issuing Date?' />
					<input type="text" id="challanAckDate" readonly="readonly" name="dob" placeholder='Acknowledgement Date?'/>&nbsp;
					<input type="text" id="challanReason" name="challanReason" placeholder='Reason for Cancellation (or) Re-Issue?'  STYLE="width:230px"/>
					</td>
				</tr>
				</table>
				</div>
		</tr>
		<tr>
			<td width=30% align=right class="button navy">Cash</td>
		</tr>
							
		<tr>
			<td colspan=2>
				<div id='cashPay'>
				<table>
				<tr>
					<td class='label'><i><b>Cash Amount</b></i></td>
					<td><input type="text" id="cashAmount" name="cashAmount" STYLE="width:170px"/></td>
					<td class='label'>Date</td>
					<td><input type="text" id="cashReceiptDate" readonly="readonly" name="dob"/></td>							
				</tr>
				</table>
				</div>
		</tr>
		<tr>
			<td width=30% align=right class="button navy">DD</td>
		</tr>
							
		<tr>
			<td colspan=2>
				<div id='ddPay'>
				<table>
				<tr>
					<td class='label'><i><b>DD Amount</b></i></td>
					<td><input type="text" id="ddAmount" name="ddAmount" STYLE="width:170px"/></td>
					<td class='label'>Drawee Bank</td>
					<td><input type="text" id="draweeBank" name="draweeBank" /></td>
					<td class='label'>DD Dated (Drawn On)</td>
					<td><input type="text" id="ddDrwanDate" readonly="readonly" name="dob"/></td>
					<tr>
					</tr>
					<td class='label'>DD Number</td>
					<td><input type="text" id="ddNo" name="ddNo" /></td>
					<td class='label'>Date</td>
					<td><input type="text" id="ddSubmitDate" readonly="readonly" name="dob"/></td>
				</tr>
				</table>
				</div>
		</tr>	
		</td>
		</tr>

		</table>
		</form>
		<table id="maintab2" class="formtab textbox_medium tbl_p3 textarea_normal " >
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
			
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
	<tr>
		<td colspan=2 align=center>				
			 <input type="button" class="clickButton" value="Update Application" onClick='javascript:updateApp()'/>
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