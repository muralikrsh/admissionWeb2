<%@page import="org.apache.commons.lang3.text.StrTokenizer"%>
<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String mesg="";
String aflag=request.getParameter("aflag");

CashReceipt cash = new CashReceipt();
ChallanReceipt challan = new ChallanReceipt();
DdReceipt dd = new DdReceipt();

/* Personal Details */
String strAppNo=request.getParameter("AppNo");
String strAppDate=request.getParameter("AppDate");
String strStudentName=request.getParameter("StudentName");
String strParentName=request.getParameter("ParentName");
String strDOB=request.getParameter("DOB");
String strGender=request.getParameter("Gender");
String strCommunity=request.getParameter("Community");

/* Course Choices */
String strCourse=request.getParameter("Course");
String strBranch=request.getParameter("Branch");
String strStudentType=request.getParameter("StudentType");

/* Address Details */
String strAddress=request.getParameter("Address");
String strCity=request.getParameter("City");
String strState=request.getParameter("State");
String strCountry=request.getParameter("Country");
String strPinCode=request.getParameter("PinCode");
String strStdCode=request.getParameter("StdCode");
String strPhoneNo=request.getParameter("PhoneNo");
String strMobileNo=request.getParameter("MobileNo");
String strEmail=request.getParameter("Email");

/* Admission Details */
String strAdmissionStatus=request.getParameter("AdmissionStatus");
String strAdmissionQuota=request.getParameter("AdmissionQuota");
String strFixedTuitionFee=request.getParameter("FixedTuitionFee");
if(strFixedTuitionFee==null || strFixedTuitionFee.equals("")){
strFixedTuitionFee="0.00";}
String strConcessionType=request.getParameter("ConcessionType");
String strPcmMarks=request.getParameter("PcmMarks");
String strConcessionAmount=request.getParameter("ConcessionAmount");
String strReference=request.getParameter("Reference");
String strOtherReference=request.getParameter("OtherReference");
String strOtherReferenceName=request.getParameter("OtherReferenceName");
String strOtherReferenceContact=request.getParameter("OtherReferenceContact");

/* Miscellanous */
String strHostelReqd=request.getParameter("HostelReqd");
String strTransportReqd=request.getParameter("TransportReqd");
//System.out.println(strHostelReqd+", "+strTransportReqd);
if(strHostelReqd==null || strHostelReqd.equals("")){
strHostelReqd="No";}
if(strTransportReqd==null || strTransportReqd.equals("")){
strTransportReqd="No";}

/* Admission Payment */
String strAdmissionFee=request.getParameter("AdmissionFee");
if(strAdmissionFee==null || strAdmissionFee.equals(""))
{
	strAdmissionFee="0.00";
}
	
/* Payment - I*/
/* 	String strCashAmountOne=request.getParameter("CashAmountOne");
	if(strCashAmountOne==null || strCashAmountOne.equals(""))
	{
		strCashAmountOne="0.00";
	}
	String strCashReceiptDate1=request.getParameter("CashReceiptDate1");
	String strChallanAmountOne=request.getParameter("ChallanAmountOne");
	if(strChallanAmountOne==null || strChallanAmountOne.equals(""))
	{
		strChallanAmountOne="0.00";
	}
	String strChallanStatus1=request.getParameter("ChallanStatus1");
	String strChallanIssuedDate1=request.getParameter("ChallanIssuedDate1");
	String strChallanAckDate1=request.getParameter("ChallanAckDate1");
	String strChallanReason1=request.getParameter("ChallanReason1");
	String strDdAmountOne=request.getParameter("DdAmountOne");
	if(strDdAmountOne==null || strDdAmountOne.equals(""))
	{
		strDdAmountOne="0.00";
	}
	String strDraweeBank1=request.getParameter("DraweeBank1");
	String strDdDrawnDate1=request.getParameter("DdDrwanDate1");
	String strDdNo1=request.getParameter("DdNo1");
	String strDdSubmitDate1=request.getParameter("DdSubmitDate1");
 */	
/* Payment - II*/
/* 	String strCashAmountTwo=request.getParameter("CashAmountTwo");
	if(strCashAmountTwo==null || strCashAmountTwo.equals(""))
	{
		strCashAmountTwo="0.00";
	}
	String strCashReceiptDate2=request.getParameter("CashReceiptDate2");
	String strChallanAmountTwo=request.getParameter("ChallanAmountTwo");
	if(strChallanAmountTwo==null || strChallanAmountTwo.equals(""))
	{
		strChallanAmountTwo="0.00";
	}
	String strChallanStatus2=request.getParameter("ChallanStatus2");
	String strChallanIssuedDate2=request.getParameter("ChallanIssuedDate2");
	String strChallanAckDate2=request.getParameter("ChallanAckDate2");
	String strChallanReason2=request.getParameter("ChallanReason2");
	String strDdAmountTwo=request.getParameter("DdAmountTwo");
	if(strDdAmountTwo==null || strDdAmountTwo.equals(""))
	{
		strDdAmountTwo="0.00";
	}
	String strDraweeBank2=request.getParameter("DraweeBank2");
	String strDdDrawnDate2=request.getParameter("DdDrwanDate2");
	String strDdNo2=request.getParameter("DdNo2");
	String strDdSubmitDate2=request.getParameter("DdSubmitDate2");
 */
/* Payment - III*/
/* 	String strCashAmountThree=request.getParameter("CashAmountThree");
	if(strCashAmountThree==null || strCashAmountThree.equals(""))
	{
		strCashAmountThree="0.00";
	}
	String strCashReceiptDate3=request.getParameter("CashReceiptDate3");
	String strChallanAmountThree=request.getParameter("ChallanAmountThree");
	if(strChallanAmountThree==null || strChallanAmountThree.equals(""))
	{
		strChallanAmountThree="0.00";
	}
	String strChallanStatus3=request.getParameter("ChallanStatus3");
	String strChallanIssuedDate3=request.getParameter("ChallanIssuedDate3");
	String strChallanAckDate3=request.getParameter("ChallanAckDate3");
	String strChallanReason3=request.getParameter("ChallanReason3");
	String strDdAmountThree=request.getParameter("DdAmountThree");
	if(strDdAmountThree==null || strDdAmountThree.equals(""))
	{
		strDdAmountThree="0.00";
	}
	String strDraweeBank3=request.getParameter("DraweeBank3");
	String strDdDrawnDate3=request.getParameter("DdDrwanDate3");
	String strDdNo3=request.getParameter("DdNo3");
	String strDdSubmitDate3=request.getParameter("DdSubmitDate3");
 */
/* Payment - III*/
/* 	String strCashAmountFour=request.getParameter("CashAmountFour");
	if(strCashAmountFour==null || strCashAmountFour.equals(""))
	{
		strCashAmountFour="0.00";
	}
	String strCashReceiptDate4=request.getParameter("CashReceiptDate4");
	String strChallanAmountFour=request.getParameter("ChallanAmountFour");
	if(strChallanAmountFour==null || strChallanAmountFour.equals(""))
	{
		strChallanAmountFour="0.00";
	}
	String strChallanStatus4=request.getParameter("ChallanStatus4");
	String strChallanIssuedDate4=request.getParameter("ChallanIssuedDate4");
	String strChallanAckDate4=request.getParameter("ChallanAckDate4");
	String strChallanReason4=request.getParameter("ChallanReason4");
	String strDdAmountFour=request.getParameter("DdAmountFour");
	if(strDdAmountFour==null || strDdAmountFour.equals(""))
	{
		strDdAmountFour="0.00";
	}
	String strDraweeBank4=request.getParameter("DraweeBank4");
	String strDdDrawnDate4=request.getParameter("DdDrwanDate4");
	String strDdNo4=request.getParameter("DdNo4");
	String strDdSubmitDate4=request.getParameter("DdSubmitDate4");
 */
	String strMakerId=request.getParameter("MakerId");
	String strIPAddr=request.getParameter("IPAddr");
	String strAdmissionNumber=request.getParameter("full_adm_no");
	if(strAdmissionNumber==null)
		strAdmissionNumber="";
	String strAdmNo="1";
	
/* 	String strCashReceiptNo1=request.getParameter("CashReceiptNo1").trim();
	String strChallanNo1=request.getParameter("ChallanNo1").trim();
	String strDdReceiptNo1=request.getParameter("DdReceiptNo1").trim();
	String strCashReceiptNo2=request.getParameter("CashReceiptNo2").trim();
	String strChallanNo2=request.getParameter("ChallanNo2").trim();
	String strDdReceiptNo2=request.getParameter("DdReceiptNo2").trim();
	String strCashReceiptNo3=request.getParameter("CashReceiptNo3").trim();
	String strChallanNo3=request.getParameter("ChallanNo3").trim();
	String strDdReceiptNo3=request.getParameter("DdReceiptNo3").trim();
	String strCashReceiptNo4=request.getParameter("CashReceiptNo4").trim();
	String strChallanNo4=request.getParameter("ChallanNo4").trim();
	String strDdReceiptNo4=request.getParameter("DdReceiptNo4").trim();
 */

try{
	System.out.println(strAdmissionNumber);	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);

		if(aflag.intern()=="I".intern()) {
		Calendar now = Calendar.getInstance();
		int year = now.get(Calendar.YEAR);
		String strYear=String.valueOf(year);
		//pst=null;
		
		pst=con.prepareStatement("SELECT CASE WHEN MAX(adm_no) IS NULL THEN 1 ELSE MAX(adm_no) END AS adm_no FROM student_admission");
		
		rs=pst.executeQuery();

		if(rs.next())        
		{
            int j = rs.getInt(1);
            System.out.println((new StringBuilder()).append("dbString value-->").append(j).toString());
            int k = ++j;
            System.out.println((new StringBuilder()).append("increment-->").append(k).toString());
            if(k < 10)
                strAdmNo = (new StringBuilder()).append("0000").append(j).toString();
            else if(k < 100)
                strAdmNo = (new StringBuilder()).append("000").append(j).toString();
            else if(k < 1000)
                strAdmNo = (new StringBuilder()).append("00").append(j).toString();
            else if(k < 10000)
                strAdmNo = (new StringBuilder()).append("0").append(j).toString();
        }
		pst=null;
		strAdmissionNumber="BU"+strYear+"AD"+strAdmNo;
		System.out.println(strAdmissionNumber);
		}
/* 	StudentPayment sp=new StudentPayment();
	System.out.println("Outside. strCashAmountOne="+strCashAmountOne+", strCashReceiptNo1= "+strCashReceiptNo1);
	
	if( !strCashAmountOne.equals("0.00") && strCashReceiptNo1.equals("0") )
	{
		sp.generatePaymentID("cash_1", strMakerId, strAdmissionNumber);	
		strCashReceiptNo1=sp.getPaymentID("cash_1", strAdmissionNumber);
		System.out.println("Inside. strCashAmountOne="+strCashAmountOne+", strCashReceiptNo1= "+strCashReceiptNo1);
	}
	if( !strCashAmountTwo.equals("0.00") && strCashReceiptNo2.equals("0"))
	{
		sp.generatePaymentID("cash_2", strMakerId, strAdmissionNumber);
		strCashReceiptNo2=sp.getPaymentID("cash_2", strAdmissionNumber);
	}	
	if( !strCashAmountThree.equals("0.00") && strCashReceiptNo3.equals("0") )
	{
		sp.generatePaymentID("cash_3", strMakerId, strAdmissionNumber);
		strCashReceiptNo3=sp.getPaymentID("cash_3", strAdmissionNumber);
	}		
	if( !strCashAmountFour.equals("0.00") && strCashReceiptNo4.equals("0") )
	{
		sp.generatePaymentID("cash_4", strMakerId, strAdmissionNumber);
		strCashReceiptNo4=sp.getPaymentID("cash_4", strAdmissionNumber);
	}

	if( !strChallanAmountOne.equals("0.00") && strChallanNo1.equals("0") )
	{
		sp.generatePaymentID("challan_1", strMakerId, strAdmissionNumber);
		strChallanNo1=sp.getPaymentID("challan_1", strAdmissionNumber);
	}
	if( !strChallanAmountTwo.equals("0.00") && strChallanNo2.equals("0") )
	{
		sp.generatePaymentID("challan_2", strMakerId, strAdmissionNumber);
		strChallanNo2=sp.getPaymentID("challan_2", strAdmissionNumber);
	}	
	if( !strChallanAmountThree.equals("0.00") && strChallanNo3.equals("0") )
	{
		sp.generatePaymentID("challan_3", strMakerId, strAdmissionNumber);
		strChallanNo3=sp.getPaymentID("challan_3", strAdmissionNumber);
	}		
	if( !strChallanAmountFour.equals("0.00") && strChallanNo4.equals("0") )
	{
		sp.generatePaymentID("challan_4", strMakerId, strAdmissionNumber);
		strChallanNo4=sp.getPaymentID("challan_4", strAdmissionNumber);
	}
	
	if( !strDdAmountOne.equals("0.00") && strDdReceiptNo1.equals("0") )
	{
		sp.generatePaymentID("dd_1", strMakerId, strAdmissionNumber);
		strDdReceiptNo1=sp.getPaymentID("dd_1", strAdmissionNumber);
	}
	if( !strDdAmountTwo.equals("0.00") && strDdReceiptNo2.equals("0") )
	{
		sp.generatePaymentID("dd_2", strMakerId, strAdmissionNumber);
		strDdReceiptNo2=sp.getPaymentID("dd_2", strAdmissionNumber);
	}	
	if( !strDdAmountThree.equals("0.00") && strDdReceiptNo3.equals("0") )
	{
		sp.generatePaymentID("dd_3", strMakerId, strAdmissionNumber);
		strDdReceiptNo3=sp.getPaymentID("dd_3", strAdmissionNumber);
	}		
	if( !strDdAmountFour.equals("0.00") && strDdReceiptNo4.equals("0") )
	{
		sp.generatePaymentID("dd_4", strMakerId, strAdmissionNumber);
		strDdReceiptNo4=sp.getPaymentID("dd_4", strAdmissionNumber);
	}
 	double totalPaid=0.00;
	double amountOne=Double.parseDouble(strCashAmountOne)+Double.parseDouble(strChallanAmountOne)+Double.parseDouble(strDdAmountOne);
	double amountTwo=Double.parseDouble(strCashAmountTwo)+Double.parseDouble(strChallanAmountTwo)+Double.parseDouble(strDdAmountTwo);
	double amountThree=Double.parseDouble(strCashAmountThree)+Double.parseDouble(strChallanAmountThree)+Double.parseDouble(strDdAmountThree);
	double amountFour=Double.parseDouble(strCashAmountFour)+Double.parseDouble(strChallanAmountFour)+Double.parseDouble(strDdAmountFour);
*/	
//	totalPaid=amountOne+amountTwo+amountThree+amountFour;
	
	if(aflag.intern()=="I".intern()) {
			//pst=con.prepareStatement("INSERT INTO student_admission(appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,STD,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_status_1,challan_issue_date_1,challan_ack_date_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_status_2,challan_issue_date_2,challan_ack_date_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_status_3,challan_issue_date_3,challan_ack_date_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_status_4,challan_issue_date_4,challan_ack_date_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,total_paid,inserted_by,inserted_time,full_adm_no) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)");	
			pst=con.prepareStatement("INSERT INTO student_admission(appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,STD,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,inserted_by,inserted_time,full_adm_no) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?)");
		}
		else {
		pst=con.prepareStatement("update student_admission set appn_no=?,app_date=?,stu_name=?,par_name=?,dob=?,gender=?,community=?,course=?,branch=?,student_type=?,address=?,city=?,state=?,country=?,pin=?,STD=?,phone=?,mobile=?,email=?,adm_status=?,adm_quota=?,fixed_tuition_fee=?,concession_type=?,pcm_marks=?,concession_amt=?,reference=?,other_reference_name=?,other_reference_contact=?,hostel=?,transport=?,admission_fee=?,updated_by=?,updated_time=now() where full_adm_no=?");
	}
	if(pst!=null) {
	System.out.println("Start:: "+pst);
	pst.setString(1,strAppNo);
	pst.setString(2,strAppDate);
	pst.setString(3,strStudentName);
	pst.setString(4,strParentName);
	pst.setString(5,strDOB);
	pst.setString(6,strGender);
	pst.setString(7,strCommunity);
	pst.setString(8,strCourse);
	pst.setString(9,strBranch);
	pst.setString(10,strStudentType);
	pst.setString(11,strAddress);
	pst.setString(12,strCity);
	pst.setString(13,strState);
	pst.setString(14,strCountry);
	pst.setString(15,strPinCode);
	pst.setString(16,strStdCode);
	pst.setString(17,strPhoneNo);
	pst.setString(18,strMobileNo);
	pst.setString(19,strEmail);
	pst.setString(20,strAdmissionStatus);
	pst.setString(21,strAdmissionQuota);
	pst.setString(22,strFixedTuitionFee);
	pst.setString(23,strConcessionType);
	pst.setString(24,strPcmMarks);
	pst.setString(25,strConcessionAmount);
	pst.setString(26,strReference);
	pst.setString(27,strOtherReferenceName);
	pst.setString(28,strOtherReferenceContact);
	pst.setString(29,strHostelReqd);
	pst.setString(30,strTransportReqd);
	pst.setString(31,strAdmissionFee);

/* 	pst.setString(32,strCashReceiptNo1);
	pst.setString(33,strCashAmountOne);
	pst.setString(34,strCashReceiptDate1);
	pst.setString(35,strChallanNo1);
	pst.setString(36,strChallanAmountOne);
	pst.setString(37,strChallanStatus1);
	pst.setString(38,strChallanIssuedDate1);
	pst.setString(39,strChallanAckDate1);
	pst.setString(40,strChallanReason1);
	pst.setString(41,strDdReceiptNo1);
	pst.setString(42,strDdAmountOne);
	pst.setString(43,strDraweeBank1);
	pst.setString(44,strDdDrawnDate1);
	pst.setString(45,strDdNo1);
	pst.setString(46,strDdSubmitDate1);

	pst.setString(47,strCashReceiptNo2);
	pst.setString(48,strCashAmountTwo);
	pst.setString(49,strCashReceiptDate2);
	pst.setString(50,strChallanNo2);
	pst.setString(51,strChallanAmountTwo);
	pst.setString(52,strChallanStatus2);
	pst.setString(53,strChallanIssuedDate2);
	pst.setString(54,strChallanAckDate2);
	pst.setString(55,strChallanReason2);
	pst.setString(56,strDdReceiptNo2);
	pst.setString(57,strDdAmountTwo);
	pst.setString(58,strDraweeBank2);
	pst.setString(59,strDdDrawnDate2);
	pst.setString(60,strDdNo2);
	pst.setString(61,strDdSubmitDate2);

	pst.setString(62,strCashReceiptNo3);
	pst.setString(63,strCashAmountThree);
	pst.setString(64,strCashReceiptDate3);
	pst.setString(65,strChallanNo3);
	pst.setString(66,strChallanAmountThree);
	pst.setString(67,strChallanStatus3);
	pst.setString(68,strChallanIssuedDate3);
	pst.setString(69,strChallanAckDate3);
	pst.setString(70,strChallanReason3);
	pst.setString(71,strDdReceiptNo3);
	pst.setString(72,strDdAmountThree);
	pst.setString(73,strDraweeBank3);
	pst.setString(74,strDdDrawnDate3);
	pst.setString(75,strDdNo3);
	pst.setString(76,strDdSubmitDate3);

	pst.setString(77,strCashReceiptNo4);
	pst.setString(78,strCashAmountFour);
	pst.setString(79,strCashReceiptDate4);
	pst.setString(80,strChallanNo4);
	pst.setString(81,strChallanAmountFour);
	pst.setString(82,strChallanStatus4);
	pst.setString(83,strChallanIssuedDate4);
	pst.setString(84,strChallanAckDate4);
	pst.setString(85,strChallanReason4);
	pst.setString(86,strDdReceiptNo4);
	pst.setString(87,strDdAmountFour);
	pst.setString(88,strDraweeBank3);
	pst.setString(89,strDdDrawnDate4);
	pst.setString(90,strDdNo4);
	pst.setString(91,strDdSubmitDate4);
	
	pst.setDouble(92,totalPaid);
 */	
 	pst.setString(32,strMakerId);
	pst.setString(33,strAdmissionNumber);
	System.out.println("Admission pst= "+pst);
	pst.executeUpdate();
	}
/* 	String strStudent=strStudentName+"  ( "+strAdmissionNumber+" )";
 	if( !strCashReceiptNo1.equals("0") )
	{
		cash.genReceipt(strCashReceiptNo1, strStudent, strAdmissionNumber, strCashAmountOne, strCashReceiptDate1, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strCashReceiptNo2.equals("0") )
	{
		cash.genReceipt(strCashReceiptNo2, strStudent, strAdmissionNumber, strCashAmountTwo, strCashReceiptDate2, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strCashReceiptNo3.equals("0") )
	{
		cash.genReceipt(strCashReceiptNo3, strStudent, strAdmissionNumber, strCashAmountThree, strCashReceiptDate3, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strCashReceiptNo4.equals("0") )
	{
		cash.genReceipt(strCashReceiptNo4, strStudent, strAdmissionNumber, strCashAmountFour, strCashReceiptDate4, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	
	if( !strChallanNo1.equals("0") )
	{
		challan.genReceipt(strChallanNo1, strStudentName, strAdmissionNumber, strChallanAmountOne, strChallanIssuedDate1);
	}
	if( !strChallanNo2.equals("0") )
	{
		challan.genReceipt(strChallanNo2, strStudentName, strAdmissionNumber, strChallanAmountTwo, strChallanIssuedDate2);
	}
	if( !strChallanNo3.equals("0") )
	{
		challan.genReceipt(strChallanNo3, strStudentName, strAdmissionNumber, strChallanAmountThree, strChallanIssuedDate3);
	}
	if( !strChallanNo4.equals("0") )
	{
		challan.genReceipt(strChallanNo4, strStudentName, strAdmissionNumber, strChallanAmountFour, strChallanIssuedDate4);
	}

	if( !strDdReceiptNo1.equals("0") )
	{
		dd.genReceipt(strDdReceiptNo1, strStudent, strAdmissionNumber, strDdAmountOne, strDdNo1, strDraweeBank1, strDdDrawnDate1, strDdSubmitDate1, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strDdReceiptNo2.equals("0") )
	{
		dd.genReceipt(strDdReceiptNo2, strStudent, strAdmissionNumber, strDdAmountTwo, strDdNo2, strDraweeBank2, strDdDrawnDate2, strDdSubmitDate2, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strDdReceiptNo3.equals("0") )
	{
		dd.genReceipt(strDdReceiptNo3, strStudent, strAdmissionNumber, strDdAmountThree, strDdNo3, strDraweeBank3, strDdDrawnDate3, strDdSubmitDate3, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
	if( !strDdReceiptNo4.equals("0") )
	{
		dd.genReceipt(strDdReceiptNo4, strStudent, strAdmissionNumber, strDdAmountFour, strDdNo4, strDraweeBank4, strDdDrawnDate4, strDdSubmitDate4, strFixedTuitionFee, totalPaid, strConcessionAmount);
	}
 */ 
	pst=null;
	pst=con.prepareStatement("insert into ip_tracking values(?,?,?,now())");
	pst.setString(1,strAdmNo);
	pst.setString(2,strIPAddr);
	pst.setString(3,strMakerId);
	pst.executeUpdate();			
				
	con.commit();

	mesg="0000"+"~"+"AdmissionReport.jsp?from_date=&to_date=&appn_no=&admNo="+strAdmissionNumber+"&state=&gender=&course=&branch=&studentType=&community=&admQuota=&concessionType=&tuitionFeeFrom=&tuitionFeeTo=&insertedBy=&reference=&flag=Y";
	System.out.println("Successfully Submitted");
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	if(e1.toString().indexOf("MOBILE_NO_EXISTS") != -1)
		mesg="0002"; 
	else
		mesg="0001"; 
	System.out.println("Error while submitting Admission form. Please contact Administrator "+e1.toString());
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%= mesg %>