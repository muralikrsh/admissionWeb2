<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String mesg="";
StudentPayment sp=new StudentPayment();

NumberToWord numToWord = new NumberToWord();
CashReceipt cash = new CashReceipt();
ChallanReceipt challan = new ChallanReceipt();
DdReceipt dd = new DdReceipt();

/* Personal Details */
String strFullAdmissionNum=request.getParameter("FullAdmissionNum");
String strStudentName=request.getParameter("StudentName");
String strFixedTuitionFee=request.getParameter("FixedTuitionFee");
String strConcessionAmount=request.getParameter("ConcessionAmount");
String strCertificationFee=request.getParameter("CertificationFee");
String strCourse=request.getParameter("Course");
if(strCertificationFee==null || strCertificationFee.equals(""))
{
	strCertificationFee="0.00";
}
String strCertificationPayMode=request.getParameter("CertificationPayMode");
String strCertPrint=request.getParameter("CertPrint").trim();
System.out.println("strCertPrint= "+strCertPrint);

String strCashReceiptNo="0";
String strDdReceiptNo="0";
String strChallanNo="0";

/* Payment*/
	String strMakerId=request.getParameter("MakerId");
	String strIPAddr=request.getParameter("IPAddr");
	double totalPaid=Double.parseDouble(request.getParameter("TotalPaid"));
	String strFlag=request.getParameter("Flag");

	String strCashAmount=request.getParameter("CashAmount");
	if(strCashAmount==null || strCashAmount.equals(""))
	{
		strCashAmount="0.00";
	}
	else{
		sp.generatePaymentID("cash_"+strFlag, strMakerId, strFullAdmissionNum);
		strCashReceiptNo=sp.getPaymentID("cash_"+strFlag, strFullAdmissionNum);
		System.out.println("Inside. strCashAmount="+strCashAmount+", strCashReceiptNo= "+strCashReceiptNo);

	}
	String strCashReceiptDate=request.getParameter("CashReceiptDate");
	String strChallanAmount=request.getParameter("ChallanAmount");

	if(strChallanAmount==null || strChallanAmount.equals(""))
	{
		strChallanAmount="0.00";
	}
	else{
		sp.generatePaymentID("challan_"+strFlag, strMakerId, strFullAdmissionNum);
		strChallanNo=sp.getPaymentID("challan_"+strFlag, strFullAdmissionNum);
	}
	String strChallanStatus=request.getParameter("ChallanStatus");
	String strChallanIssuedDate=request.getParameter("ChallanIssuedDate");
	String strChallanAckDate=request.getParameter("ChallanAckDate");
	String strChallanReason=request.getParameter("ChallanReason");
	String strDdAmount=request.getParameter("DdAmount");
	if(strDdAmount==null || strDdAmount.equals(""))
	{
		strDdAmount="0.00";
	}
	else
	{
		sp.generatePaymentID("dd_"+strFlag, strMakerId, strFullAdmissionNum);
		strDdReceiptNo=sp.getPaymentID("dd_"+strFlag, strFullAdmissionNum);
	}
	String strDraweeBank=request.getParameter("DraweeBank");
	String strDdDrawnDate=request.getParameter("DdDrwanDate");
	String strDdNo=request.getParameter("DdNo");
	String strDdSubmitDate=request.getParameter("DdSubmitDate");
	
try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);

	if(strFlag.equals("1"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET cash_receipt_no_1=?, cash_amount_1=?, cash_receipt_date_1=?, challan_no_1=?, challan_amount_1=?, challan_issue_date_1=?, challan_ack_date_1=?, challan_reason_1=?, dd_receipt_no_1=?, dd_amount_1=?, dd_bank_1=?, dd_drawn_date_1=?, dd_no_1=?, dd_submit_date_1=?, total_paid=?, cert_verify_fee=?, cert_pay_mode=? WHERE full_adm_no=?");
	}
	else if(strFlag.equals("2"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET cash_receipt_no_2=?, cash_amount_2=?, cash_receipt_date_2=?, challan_no_2=?, challan_amount_2=?, challan_issue_date_2=?, challan_ack_date_2=?, challan_reason_2=?, dd_receipt_no_2=?, dd_amount_2=?, dd_bank_2=?, dd_drawn_date_2=?, dd_no_2=?, dd_submit_date_2=?, total_paid=?, cert_verify_fee=?, cert_pay_mode=? WHERE full_adm_no=?");
	} 
	else if(strFlag.equals("3"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET cash_receipt_no_3=?, cash_amount_3=?, cash_receipt_date_3=?, challan_no_3=?, challan_amount_3=?, challan_issue_date_3=?, challan_ack_date_3=?, challan_reason_3=?, dd_receipt_no_3=?, dd_amount_3=?, dd_bank_3=?, dd_drawn_date_3=?, dd_no_3=?, dd_submit_date_3=?, total_paid=?, cert_verify_fee=?, cert_pay_mode=? WHERE full_adm_no=?");
	}
	else if(strFlag.equals("4"))
	{
		pst=con.prepareStatement("UPDATE student_admission SET cash_receipt_no_4=?, cash_amount_4=?, cash_receipt_date_4=?, challan_no_4=?, challan_amount_4=?, challan_issue_date_4=?, challan_ack_date_4=?, challan_reason_4=?, dd_receipt_no_4=?, dd_amount_4=?, dd_bank_4=?, dd_drawn_date_4=?, dd_no_4=?, dd_submit_date_4=?, total_paid=?, cert_verify_fee=?, cert_pay_mode=? WHERE full_adm_no=?");
	}
	if(pst!=null) {
	pst.setString(1,strCashReceiptNo);
	pst.setString(2,strCashAmount);
	pst.setString(3,strCashReceiptDate);
	pst.setString(4,strChallanNo);
	pst.setString(5,strChallanAmount);
	pst.setString(6,strChallanIssuedDate);
	pst.setString(7,strChallanAckDate);
	pst.setString(8,strChallanReason);
	pst.setString(9,strDdReceiptNo);
	pst.setString(10,strDdAmount);
	pst.setString(11,strDraweeBank);
	pst.setString(12,strDdDrawnDate);
	pst.setString(13,strDdNo);
	pst.setString(14,strDdSubmitDate);
		totalPaid=totalPaid+Double.parseDouble(strCashAmount)+Double.parseDouble(strDdAmount);
	pst.setDouble(15,totalPaid);
	pst.setString(16,strCertificationFee);
	pst.setString(17,strCertificationPayMode);
	pst.setString(18,strFullAdmissionNum);
	
	System.out.println(pst);
	pst.executeUpdate();
	}
		
	con.commit();
	String strStudent=strStudentName+"  ( "+strFullAdmissionNum+" )";

		if( strCertPrint.equals("Yes") && strCertificationPayMode.equals("Cash"))
		{
			cash.genReceiptWithCertFee(strCashReceiptNo, strStudent, strFullAdmissionNum, strCashAmount, strCashReceiptDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCertificationFee, strCourse);
		}
		else if( !strCashReceiptNo.equals("0") )
		{
			cash.genReceipt(strCashReceiptNo, strStudent, strFullAdmissionNum, strCashAmount, strCashReceiptDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCourse);
		}

	
		if( strCertPrint.equals("Yes") && strCertificationPayMode.equals("DD"))
		{
			dd.genReceiptWithCertFee(strDdReceiptNo, strStudent, strFullAdmissionNum, strDdAmount, strDdNo, strDraweeBank, strDdDrawnDate, strDdSubmitDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCertificationFee, strCourse);
		}
		else if( !strDdReceiptNo.equals("0"))
		{
			dd.genReceipt(strDdReceiptNo, strStudent, strFullAdmissionNum, strDdAmount, strDdNo, strDraweeBank, strDdDrawnDate, strDdSubmitDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCourse);
		}
	
	
		if( strCertPrint.equals("Yes") && strCertificationPayMode.equals("Challan"))
		{
			challan.genReceiptWithCertFee(strChallanNo, strStudentName, strFullAdmissionNum, strChallanAmount, strChallanIssuedDate, strCertificationFee, strCourse);
		}
		else if( !strChallanNo.equals("0") )
		{
			challan.genReceipt(strChallanNo, strStudentName, strFullAdmissionNum, strChallanAmount, strChallanIssuedDate, strCourse);
		}

/* 	
	if( strCertPrint.equals("Yes")){
		if( !strCashReceiptNo.equals("0") && strCertificationPayMode.equals("Cash"))
		{
			//System.out.println(strCertificationPayMode);
			cash.genReceiptWithCertFee(strCashReceiptNo, strStudent, strFullAdmissionNum, strCashAmount, strCashReceiptDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCertificationFee);
		}
	
		if( !strDdReceiptNo.equals("0") && strCertificationPayMode.equals("DD"))
		{
			dd.genReceiptWithCertFee(strDdReceiptNo, strStudent, strFullAdmissionNum, strDdAmount, strDdNo, strDraweeBank, strDdDrawnDate, strDdSubmitDate, strFixedTuitionFee, totalPaid, strConcessionAmount, strCertificationFee);
		}
	
		if( !strChallanNo.equals("0") && strCertificationPayMode.equals("Challan"))
		{
			challan.genReceiptWithCertFee(strChallanNo, strStudentName, strFullAdmissionNum, strChallanAmount, strChallanIssuedDate, strCertificationFee);
		}
	}
	else
	{
		if( !strCashReceiptNo.equals("0") )
		{
			cash.genReceipt(strCashReceiptNo, strStudent, strFullAdmissionNum, strCashAmount, strCashReceiptDate, strFixedTuitionFee, totalPaid, strConcessionAmount);
		}

		if( !strDdReceiptNo.equals("0") )
		{
			dd.genReceipt(strDdReceiptNo, strStudent, strFullAdmissionNum, strDdAmount, strDdNo, strDraweeBank, strDdDrawnDate, strDdSubmitDate, strFixedTuitionFee, totalPaid, strConcessionAmount);
		}

		if( !strChallanNo.equals("0") )
		{
			challan.genReceipt(strChallanNo, strStudentName, strFullAdmissionNum, strChallanAmount, strChallanIssuedDate);
		}
	}
 */
 	mesg="0000"+"~"+"PaymentReport.jsp?appn_no="+strFullAdmissionNum+"&flag="+strFlag;
	System.out.println("Successfully Submitted");
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	System.out.println("Error while submitting Admission form. Please contact Administrator "+e1.toString());
}
finally {
System.out.println("mesg :: "+mesg);
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%= mesg %>