<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, campus.CheckSumUtil"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
PreparedStatement pst1 = null;
ResultSet rs1=null;

	System.out.println("Entry");

String mesg="";
/* Personal Details */
String man_appn_no=request.getParameter("man_appn_no");
String exam_id=request.getParameter("exam_id");
String first_name=request.getParameter("first_name");
String last_name=request.getParameter("last_name");
String gender=request.getParameter("gender");
String nationality=request.getParameter("nationality");
String religion=request.getParameter("religion");
String community=request.getParameter("community");
String blood_group=request.getParameter("blood_group");
String dob=request.getParameter("dob");
String mother_tongue=request.getParameter("mother_tongue");
String quota=request.getParameter("quota");
String sports_achv=request.getParameter("sports_achv");
String parent_name=request.getParameter("parent_name");
String guardian_name=request.getParameter("guardian_name");
String relationship=request.getParameter("relationship");
String g_relationship=request.getParameter("g_relationship");
String parent_occupation=request.getParameter("parent_occupation");

/* Course Choices */
String course_type=request.getParameter("course_type");
String adm_type=request.getParameter("adm_type");
String course=request.getParameter("course");
String choice_1=request.getParameter("choice_1");
String choice_2=request.getParameter("choice_2");
String choice_3=request.getParameter("choice_3");
String valid_score_of=request.getParameter("valid_score_of");
String exam_attended=request.getParameter("exam_attended");
String medium_of_instr=request.getParameter("medium_of_instr");
String optional_subject=request.getParameter("optional_subject");
String chn_part_id=request.getParameter("chn_part_id");
String hostel_reqd=request.getParameter("hostel_reqd");
String transport_reqd=request.getParameter("transport_reqd");
if(hostel_reqd==null || hostel_reqd.equals("")){
hostel_reqd="No";}
if(transport_reqd==null || transport_reqd.equals("")){
transport_reqd="No";}

/* Address Details */
//String care_of=request.getParameter("care_of");
String email_id=request.getParameter("email_id");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String country=request.getParameter("country");
String pin_code=request.getParameter("pin_code");
String std_code=request.getParameter("std_code");
String phone_no=request.getParameter("phone_no");
String mobile_no=request.getParameter("mobile_no");


/* Academic Details */
String sslc_school=request.getParameter("sslc_school");
String sslc_city=request.getParameter("sslc_city");
String sslc_board=request.getParameter("sslc_board");
String sslc_regn_no=request.getParameter("sslc_regn_no");
String sslc_mon_yop=request.getParameter("sslc_mon_yop");
String sslc_marks=request.getParameter("sslc_marks");
String sslc_outof=request.getParameter("sslc_outof");
if(sslc_marks==null || sslc_marks.intern()=="-".intern() || sslc_marks.intern()=="".intern())  sslc_marks="0";
if(sslc_outof==null || sslc_outof.intern()=="-".intern() || sslc_outof.intern()=="".intern())  sslc_outof="0";

String hsc_school=request.getParameter("hsc_school");
String hsc_city=request.getParameter("hsc_city");
String hsc_board=request.getParameter("hsc_board");
String hsc_regn_no=request.getParameter("hsc_regn_no");
String hsc_mon_yop=request.getParameter("hsc_mon_yop");
String hsc_marks=request.getParameter("hsc_marks");
String hsc_outof=request.getParameter("hsc_outof");
if(hsc_marks==null || hsc_marks.intern()=="-".intern() || hsc_marks.intern()=="".intern())  hsc_marks="0";
if(hsc_outof==null || hsc_outof.intern()=="-".intern() || hsc_outof.intern()=="".intern())  hsc_outof="0";

String oth_exam_1=request.getParameter("oth_exam_1");
String oth_college_1=request.getParameter("oth_college_1");
String oth_city_1=request.getParameter("oth_city_1");
String oth_university_1=request.getParameter("oth_university_1");
String oth_regn_no_1=request.getParameter("oth_regn_no_1");
String oth_mon_yop_1=request.getParameter("oth_mon_yop_1");
String oth_marks_1=request.getParameter("oth_marks_1");
String oth_outof_1=request.getParameter("oth_outof_1");

if(oth_marks_1==null || oth_marks_1.intern()=="-".intern() || oth_marks_1.intern()=="".intern())  oth_marks_1="0";
if(oth_outof_1==null || oth_outof_1.intern()=="-".intern() || oth_outof_1.intern()=="".intern())  oth_outof_1="0";

String oth_exam_2=request.getParameter("oth_exam_2");
String oth_college_2=request.getParameter("oth_college_2");
String oth_city_2=request.getParameter("oth_city_2");
String oth_university_2=request.getParameter("oth_university_2");
String oth_regn_no_2=request.getParameter("oth_regn_no_2");
String oth_mon_yop_2=request.getParameter("oth_mon_yop_2");
String oth_marks_2=request.getParameter("oth_marks_2");
String oth_outof_2=request.getParameter("oth_outof_2");

if(oth_marks_2==null || oth_marks_2.intern()=="-".intern() || oth_marks_2.intern()=="".intern())  oth_marks_2="0";
if(oth_outof_2==null || oth_outof_2.intern()=="-".intern() || oth_outof_2.intern()=="".intern())  oth_outof_2="0";

String oth_exam_3=request.getParameter("oth_exam_3");
String oth_college_3=request.getParameter("oth_college_3");
String oth_city_3=request.getParameter("oth_city_3");
String oth_university_3=request.getParameter("oth_university_3");
String oth_regn_no_3=request.getParameter("oth_regn_no_3");
String oth_mon_yop_3=request.getParameter("oth_mon_yop_3");
String oth_marks_3=request.getParameter("oth_marks_3");
String oth_outof_3=request.getParameter("oth_outof_3");

if(oth_marks_3==null || oth_marks_3.intern()=="-".intern() || oth_marks_3.intern()=="".intern())  oth_marks_3="0";
if(oth_outof_3==null || oth_outof_3.intern()=="-".intern() || oth_outof_3.intern()=="".intern())  oth_outof_3="0";

/* Fee Details */
String appfee_flag=request.getParameter("appfee_flag");
if(appfee_flag.intern()=="undefined".intern())
appfee_flag="";
String appfee_rcp_no=request.getParameter("appfee_rcp_no");
String dd_number=request.getParameter("dd_number");
String dd_date="01-Jan-1999"; // request.getParameter("dd_date");
String amount="0"; // request.getParameter("amount");
String drawee_bank=request.getParameter("drawee_bank");

String exam_pref=request.getParameter("exam_pref");
String city_centre=request.getParameter("city_centre");

if(amount==null || amount.intern()=="".intern()) 
	amount="0";

String flag=request.getParameter("flag");
String appn_no=request.getParameter("appn_no");
if(appn_no==null)
	appn_no="";
String mkr_id=request.getParameter("mkr_id");
String ipaddr=request.getParameter("ipaddr");
String strFullAppNumber=request.getParameter("f_appn_no");
if(strFullAppNumber==null)
{strFullAppNumber="";}

try{
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println("FLAG::::::::::::::::"+flag+":::::");
	
	/* fetch exam id for the selected course */
	pst1=con.prepareStatement("select exam_id from exam_master where course=?");
	pst1.setString(1,course);
	rs1=pst1.executeQuery();
	while (rs1.next())
	{
		exam_id=rs1.getString(1);
	}
	if(flag.intern()=="I".intern()) 
	{	
		int count=0;
		
		pst=con.prepareStatement("select count(1) from application_manual where mobile_no=?");
		pst.setString(1, mobile_no);
		rs=pst.executeQuery();
		if(rs.next()) {
			count=rs.getInt(1);
		}
		pst=null;
		if(count==0)
		{
			/* Updated by Alexpandiyan 4.1.16. */
			
			pst=con.prepareStatement("SELECT CASE WHEN MAX(appn_no) IS NULL THEN 100001 ELSE MAX(appn_no)+1 END AS appn_no FROM application_manual");
			rs=pst.executeQuery();
			if(rs.next())
			{
				appn_no = rs.getString(1);
			}
			pst=null;
			strFullAppNumber="B16"+appn_no;
			System.out.println(strFullAppNumber);
		
			pst=con.prepareStatement("insert into application_manual (first_name,last_name,gender,religion,nationality,dob,community,blood_group,mother_tongue,adm_type,course_type,course,choice_1,choice_2,choice_3,sports_achv,valid_score_of,email_id,address,city,state,pin_code,std_code,phone_no,mobile_no,parent_name,relationship,parent_occupation,hsc_school,hsc_city,hsc_board,hsc_regn_no,hsc_mon_yop,hsc_marks,hsc_outof,sslc_school,sslc_city,sslc_board,sslc_regn_no,sslc_mon_yop,sslc_marks,sslc_outof,oth_exam_1,oth_college_1,oth_city_1,oth_university_1,oth_regn_no_1,oth_mon_yop_1,oth_marks_1,oth_outof_1,oth_exam_2,oth_college_2,oth_city_2,oth_university_2,oth_regn_no_2,oth_mon_yop_2,oth_marks_2,oth_outof_2,oth_exam_3,oth_college_3,oth_city_3,oth_university_3,oth_regn_no_3,oth_mon_yop_3,oth_marks_3,oth_outof_3,medium_of_instr,optional_subject,hostel_reqd,transport_reqd,chn_part_id,exam_attended,submission_date,appn_status,dd_number,dd_date,amount,drawee_bank,mkr_id,appfee_flag,appfee_rcp_no,exam_id,quota,country,guardian_name,g_relationship,pay_status,exam_pref,city_centre,appn_no,man_appn_no,f_appn_no) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,now(),'S',?,str_to_date(?,'%d-%b-%Y'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		} else {
			throw new Exception("MOBILE_NO_EXISTS");
		}
	} else {
		pst=con.prepareStatement("update application_manual set first_name=?,last_name=?,gender=?,religion=?,nationality=?,dob=?,community=?,blood_group=?,mother_tongue=?,adm_type=?,course_type=?,course=?,choice_1=?,choice_2=?,choice_3=?,sports_achv=?,valid_score_of=?,email_id=?,address=?,city=?,state=?,pin_code=?,std_code=?,phone_no=?,mobile_no=?,parent_name=?,relationship=?,parent_occupation=?,hsc_school=?,hsc_city=?,hsc_board=?,hsc_regn_no=?,hsc_mon_yop=?,hsc_marks=?,hsc_outof=?,sslc_school=?,sslc_city=?,sslc_board=?,sslc_regn_no=?,sslc_mon_yop=?,sslc_marks=?,sslc_outof=?,oth_exam_1=?,oth_college_1=?,oth_city_1=?,oth_university_1=?,oth_regn_no_1=?,oth_mon_yop_1=?,oth_marks_1=?,oth_outof_1=?,oth_exam_2=?,oth_college_2=?,oth_city_2=?,oth_university_2=?,oth_regn_no_2=?,oth_mon_yop_2=?,oth_marks_2=?,oth_outof_2=?,oth_exam_3=?,oth_college_3=?,oth_city_1=?,oth_university_3=?,oth_regn_no_3=?,oth_mon_yop_3=?,oth_marks_3=?,oth_outof_3=?,medium_of_instr=?,optional_subject=?,hostel_reqd=?,transport_reqd=?,chn_part_id=?,exam_attended=?,submission_date=now(),appn_status='S',dd_number=?,dd_date=str_to_date(?,'%d-%b-%Y'),amount=?,drawee_bank=?,mkr_id=?,appfee_flag=?,appfee_rcp_no=?,exam_id=?,quota=?,country=?,guardian_name=?,g_relationship=?,man_appn_no=? where f_appn_no=?");
	} 

	if(pst!=null) {
	pst.setString(1,first_name);
	pst.setString(2,last_name);
	pst.setString(3,gender);
	pst.setString(4,religion);
	pst.setString(5,nationality);
	pst.setString(6,dob);
	pst.setString(7,community);
	pst.setString(8,blood_group);
	pst.setString(9,mother_tongue);
	pst.setString(10,adm_type);
	pst.setString(11,course_type);
	pst.setString(12,course);
	pst.setString(13,choice_1);
	pst.setString(14,choice_2);
	pst.setString(15,choice_3);
	pst.setString(16,sports_achv);
	pst.setString(17,valid_score_of);
	pst.setString(18,email_id); 
	pst.setString(19,address);
	pst.setString(20,city);
	pst.setString(21,state);
	pst.setString(22,pin_code);
	pst.setString(23,std_code);
	pst.setString(24,phone_no);
	pst.setString(25,mobile_no);
	pst.setString(26,parent_name);
	pst.setString(27,relationship);
	pst.setString(28,parent_occupation);
	pst.setString(29,hsc_school);
	pst.setString(30,hsc_city);
	pst.setString(31,hsc_board);
	pst.setString(32,hsc_regn_no);
	pst.setString(33,hsc_mon_yop);
	pst.setString(34,hsc_marks);
	pst.setString(35,hsc_outof);
	pst.setString(36,sslc_school);
	pst.setString(37,sslc_city);
	pst.setString(38,sslc_board);
	pst.setString(39,sslc_regn_no);
	pst.setString(40,sslc_mon_yop);
	pst.setString(41,sslc_marks);
	pst.setString(42,sslc_outof);
	pst.setString(43,oth_exam_1);
	pst.setString(44,oth_college_1);
	pst.setString(45,oth_city_1);
	pst.setString(46,oth_university_1);
	pst.setString(47,oth_regn_no_1);
	pst.setString(48,oth_mon_yop_1);
	pst.setString(49,oth_marks_1);
	pst.setString(50,oth_outof_1);
	pst.setString(51,oth_exam_2);
	pst.setString(52,oth_college_2);
	pst.setString(53,oth_city_2);
	pst.setString(54,oth_university_2);
	pst.setString(55,oth_regn_no_2);
	pst.setString(56,oth_mon_yop_2);	
	pst.setString(57,oth_marks_2);
	pst.setString(58,oth_outof_2);
	pst.setString(59,oth_exam_3);
	pst.setString(60,oth_college_3);
	pst.setString(61,oth_city_3);
	pst.setString(62,oth_university_3);
	pst.setString(63,oth_regn_no_3);
	pst.setString(64,oth_mon_yop_3);
	pst.setString(65,oth_marks_3);
	pst.setString(66,oth_outof_3);
	pst.setString(67,medium_of_instr);
	pst.setString(68,optional_subject);
	pst.setString(69,hostel_reqd);
	pst.setString(70,transport_reqd);
	pst.setString(71,chn_part_id);
	pst.setString(72,exam_attended);
	pst.setString(73,dd_number);
	pst.setString(74,dd_date);
	pst.setString(75,amount);
	pst.setString(76,drawee_bank);
	pst.setString(77,mkr_id);
	pst.setString(78,appfee_flag);
	pst.setString(79,appfee_rcp_no);
	pst.setString(80,exam_id);
	pst.setString(81,quota);
	pst.setString(82,country);
	pst.setString(83,guardian_name);
	pst.setString(84,g_relationship);
	
	if(flag.trim().intern()=="I".intern() ) {
		if(appfee_flag.intern()=="O".intern())
			pst.setString(85,"I");
		else
			pst.setString(85,"S");

	pst.setString(86,exam_pref);
	pst.setString(87,city_centre);
	pst.setString(88,appn_no);
	pst.setString(89,man_appn_no);
	pst.setString(90,strFullAppNumber);
	} 
	
	if(flag.trim().intern()=="U".intern()) {
		pst.setString(85,man_appn_no);
		pst.setString(86,strFullAppNumber);
	}
	System.out.println(pst);
	pst.executeUpdate();
	} 

	if(flag.trim().intern()=="I".intern()) {
		pst=null;
		pst=con.prepareStatement("insert into ip_tracking values(?,?,?,now())");
		pst.setString(1,appn_no);
		pst.setString(2,ipaddr);
		pst.setString(3,mkr_id);
		pst.executeUpdate();
		}

	con.commit();
	if(flag.trim().intern()=="I".intern() ) {
	String SMSText="Congratulations Mr."+first_name+". Your application has been received at Bharath University.";
	int retSMS=new SendSMS2().mesg("91"+mobile_no,SMSText);
	}
	mesg="0000"+"~"+"ManualApplicationList.jsp?from_date=&to_date=&f_appn_no="+strFullAppNumber+"&course=&state=&city=&first_name=&last_name=&appn_status=&flag=Y";
	System.out.println("Successfully Submitted");
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	if(e1.toString().indexOf("MOBILE_NO_EXISTS") != -1)
		mesg="0002"; 
	else
		mesg="0001"; 
	System.out.println("name : "+first_name+" "+last_name);
	System.out.println("Mobile No "+mobile_no);
	System.out.println("Error while submitting Application. Please contact Administrator "+e1.toString());
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%= mesg %>