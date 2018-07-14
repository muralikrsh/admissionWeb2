<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String mesg="";
System.out.println("AllotmentFormResult");
/* Personal Details */
/*String strAppNo=request.getParameter("AppNo");
String strAppDate=request.getParameter("AppDate");
String strDOB=request.getParameter("DOB");
String strGender=request.getParameter("Gender");*/
String strStudentName=request.getParameter("StudentName");
String strParentName=request.getParameter("ParentName");

/* Course Choices */
String strCourse=request.getParameter("Course");
String strBranch=request.getParameter("Branch");
//String strStudentType=request.getParameter("StudentType");

/* Address Details */
/*String strAddress=request.getParameter("Address");
String strCity=request.getParameter("City");
String strState=request.getParameter("State");
String strCountry=request.getParameter("Country");
String strPinCode=request.getParameter("PinCode");
String strStdCode=request.getParameter("StdCode");
String strPhoneNo=request.getParameter("PhoneNo");*/
String strScholarship=request.getParameter("Scholarship");
String strMobileNo=request.getParameter("MobileNo");
String strEmail=request.getParameter("Email");

/* Admission Details */
/*String strAdmissionStatus=request.getParameter("AdmissionStatus");
String strPcmMarks=request.getParameter("PcmMarks");
String strReference=request.getParameter("Reference");
String strAdmissionQuota=request.getParameter("AdmissionQuota");
String strConcessionType=request.getParameter("ConcessionType");
*/

/* Miscellanous */
/*String strHostelReqd=request.getParameter("HostelReqd");
String strTransportReqd=request.getParameter("TransportReqd");
if(strHostelReqd==null || strHostelReqd.equals("")){
strHostelReqd="N";}
if(strTransportReqd==null || strTransportReqd.equals("")){
strTransportReqd="N";}
*/
/* Admission Payment */
String strAdmissionFee=request.getParameter("AdmissionFee");

/* Payment - I*/
	String strPaidAmountOne=request.getParameter("PaidAmountOne");
	String strFeeFlagOne=request.getParameter("FeeFlagOne");
	/*String strBankChallan1=request.getParameter("BankChallan1");
	String strChallanNo1=request.getParameter("ChallanNo1");
	String strChallanDate1=request.getParameter("ChallanDate1");*/
	String strCashReceiptNo1=request.getParameter("CashReceiptNo1");
	String strDraweeBank1=request.getParameter("DraweeBank1");
	String strDdNo1=request.getParameter("DdNo1");
	String strDdDate1=request.getParameter("DdDate1");

/* Payment - II*/
	/*String strPaidAmountTwo=request.getParameter("PaidAmountTwo");
	String strFeeFlagTwo=request.getParameter("FeeFlagTwo");
	String strBankChallan2=request.getParameter("BankChallan2");
	String strChallanNo2=request.getParameter("ChallanNo2");
	String strChallanDate2=request.getParameter("ChallanDate2");
	String strCashReceiptNo2=request.getParameter("CashReceiptNo2");
	String strDraweeBank2=request.getParameter("BankChallan2");
	String strDdNo2=request.getParameter("DdNo2");
	String strDdDate2=request.getParameter("DdDate2");*/

/* Payment - III*/
/*	String strPaidAmountThree=request.getParameter("PaidAmountThree");
	String strFeeFlagThree=request.getParameter("FeeFlagThree");
	String strBankChallan3=request.getParameter("BankChallan3");
	String strChallanNo3=request.getParameter("ChallanNo3");
	String strChallanDate3=request.getParameter("ChallanDate3");
	String strCashReceiptNo3=request.getParameter("CashReceiptNo3");
	String strDraweeBank3=request.getParameter("BankChallan3");
	String strDdNo3=request.getParameter("DdNo3");
	String strDdDate3=request.getParameter("DdDate3");
*/
String strMakerId=request.getParameter("MakerId");
String strIPAddr=request.getParameter("IPAddr");
String strAdmissionNumber="";
String strTotalPaid="";
String strAllotmentNo="";
try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);

		pst=con.prepareStatement("select count(1) from student_admission where mobile=?");
		pst.setString(1, strMobileNo);
		rs=pst.executeQuery();
		int count=0;
		if(rs.next()) 
		{
			count=rs.getInt(1);
		}
		System.out.println("count="+count);
		pst=null;
		
		pst=con.prepareStatement("SELECT CASE WHEN MAX(adm_no) IS NULL THEN 1 ELSE MAX(adm_no)+1 END AS adm_no FROM student_admission");
		rs=pst.executeQuery();
		String strAdmNo="";
		int admissionNumber=0;
		if(rs.next())
		{
			strAdmNo=rs.getString(1);
			int j = rs.getInt(1);
			
            System.out.println((new StringBuilder()).append("DB_String value-->").append(j).toString());
            int k = j;
            System.out.println((new StringBuilder()).append("Increment value-->").append(k).toString());
            if(k < 10)
            strAdmNo = (new StringBuilder()).append("BHA2015000").append(j).toString();
            else if(k < 100)
            strAdmNo = (new StringBuilder()).append("BHA201500").append(j).toString();
            else if(k < 1000)
            strAdmNo = (new StringBuilder()).append("BHA20150").append(j).toString();
            else if(k < 10000)
            strAdmNo = (new StringBuilder()).append("BHA2015").append(j).toString();
		admissionNumber=j;
        }

		pst=null;
		
		if(count==0)
		{
			pst=con.prepareStatement("INSERT INTO student_admission (stu_name, par_name, course, branch, mobile, email, tution_fee, amount_1, pay_type_1, cash_ref_no_1, dd_bank_1, dd_no_1, dd_date_1, total_paid, mkr_id, mkr_date, scholarship, full_adm_no) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),?,?)");
		} else {
			throw new Exception("MOBILE_NO_EXISTS");
		}
		
	if(pst!=null) 
	{
		strAllotmentNo=strAdmNo;
	
	pst.setString(1,strStudentName);
	pst.setString(2,strParentName);
	
	pst.setString(3,strCourse);
	pst.setString(4,strBranch);
	
	pst.setString(5,strMobileNo);
	pst.setString(6,strEmail);
	
	pst.setString(7,strAdmissionFee);
	
	pst.setString(8,strPaidAmountOne);
	pst.setString(9,strFeeFlagOne);
	pst.setString(10,strCashReceiptNo1);
	pst.setString(11,strDraweeBank1);
	pst.setString(12,strDdNo1);
	pst.setString(13,strDdDate1);
	
	pst.setString(14,strPaidAmountOne);
	pst.setString(15,strMakerId);
	pst.setString(16,strScholarship);
	pst.setString(17,strAllotmentNo);
	System.out.println("pst insert="+pst);
	
	pst.executeUpdate();
	}
	
	pst=null;
	pst=con.prepareStatement("update course set vacancy=vacancy-1 where course_name=?");
	pst.setString(1,strBranch);
	pst.executeUpdate();

	con.commit();

	mesg=strAllotmentNo;
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