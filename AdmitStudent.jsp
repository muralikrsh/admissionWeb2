<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
PreparedStatement pst1 = null;
PreparedStatement pst2 = null;
PreparedStatement pst3 = null;

String mesg="";
/* Personal Details */
String candidate_name=request.getParameter("first_name")+" "+request.getParameter("last_name");
String gender=request.getParameter("gender");
String nationality=request.getParameter("nationality");
String religion=request.getParameter("religion");
String community=request.getParameter("community");
String blood_group=request.getParameter("blood_group");
String dob=request.getParameter("dob");
String mother_tongue=request.getParameter("mother_tongue");
String sports_achv=request.getParameter("sports_achv");
String parent_name=request.getParameter("parent_name");
String relationship=request.getParameter("relationship");
String parent_occupation=request.getParameter("parent_occupation");

/* Course Choices */
String course=request.getParameter("course");
String choice_1=request.getParameter("choice_1");
String choice_2=request.getParameter("choice_2");
String choice_3=request.getParameter("choice_3");
String valid_score_of=request.getParameter("valid_score_of");
String exam_attended=request.getParameter("exam_attended");
String medium_of_instr=request.getParameter("medium_of_instr");
String optional_subject=request.getParameter("optional_subject");
String hostel_reqd=request.getParameter("hostel_reqd");
String transport_reqd=request.getParameter("transport_reqd");

/* Address Details */
String care_of=request.getParameter("care_of");
String address=request.getParameter("address");
String city=request.getParameter("city");
String state=request.getParameter("state");
String pin_code=request.getParameter("pin_code");
String std_code=request.getParameter("std_code");
String phone_no=request.getParameter("phone_no");
String mobile_no=request.getParameter("mobile_no");


/* Academic Details */
String sslc_school=request.getParameter("sslc_school");
String sslc_board=request.getParameter("sslc_board");
String sslc_regn_no=request.getParameter("sslc_regn_no");
String sslc_mon_yop=request.getParameter("sslc_mon_yop");
String sslc_percentage=request.getParameter("sslc_percentage");

String hsc_school=request.getParameter("hsc_school");
String hsc_board=request.getParameter("hsc_board");
String hsc_regn_no=request.getParameter("hsc_regn_no");
String hsc_mon_yop=request.getParameter("hsc_mon_yop");
String hsc_percentage=request.getParameter("hsc_percentage");


String oth_exam_1=request.getParameter("oth_exam_1");
String oth_college_1=request.getParameter("oth_college_1");
String oth_university_1=request.getParameter("oth_university_1");
String oth_regn_no_1=request.getParameter("oth_regn_no_1");
String oth_mon_yop_1=request.getParameter("oth_mon_yop_1");
String oth_percentage_1=request.getParameter("oth_percentage_1");

String oth_exam_2=request.getParameter("oth_exam_2");
String oth_college_2=request.getParameter("oth_college_2");
String oth_university_2=request.getParameter("oth_university_2");
String oth_regn_no_2=request.getParameter("oth_regn_no_2");
String oth_mon_yop_2=request.getParameter("oth_mon_yop_2");
String oth_percentage_2=request.getParameter("oth_percentage_2");

String oth_exam_3=request.getParameter("oth_exam_3");
String oth_college_3=request.getParameter("oth_college_3");
String oth_university_3=request.getParameter("oth_university_3");
String oth_regn_no_3=request.getParameter("oth_regn_no_3");
String oth_mon_yop_3=request.getParameter("oth_mon_yop_3");
String oth_percentage_3=request.getParameter("oth_percentage_3");

/* Fee Details */
String dd_number=request.getParameter("dd_number");
String dd_date=request.getParameter("dd_date");
String amount=request.getParameter("amount");
String drawee_bank=request.getParameter("drawee_bank");

String adm_dd_number=request.getParameter("adm_dd_number");
String adm_dd_date=request.getParameter("adm_dd_date");
String adm_amount=request.getParameter("adm_amount");
String adm_drawee_bank=request.getParameter("adm_drawee_bank");

/* Admission Details */
String adm_course=request.getParameter("adm_course");
String adm_branch=request.getParameter("adm_branch");
String section=request.getParameter("section");
String regn_no=request.getParameter("regn_no");
String hostel_room=request.getParameter("hostel_room");
 String docs_collected=request.getParameter("docs_collected");
 String adm_remarks=request.getParameter("adm_remarks");
 String trn_board_point=request.getParameter("trn_board_point");

String flag=request.getParameter("flag");
String appn_no=request.getParameter("appn_no");
String mkr_id=request.getParameter("mkr_id");

if(appn_no==null) 
	appn_no="";

try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println("FLAG::::::::::::::::"+flag+":::::");
	pst=con.prepareStatement("insert into admission (regn_no, appn_no, adm_course, adm_branch, section, hostel_room, docs_collected, remarks, adm_dd_number, adm_dd_date, adm_dd_bank, adm_dd_amount,trn_board_point ) values (?,?,?,?,?,?,?,?,?,?,?,?,?)");

	pst.setString(1,regn_no);
	pst.setString(2,appn_no);
	pst.setString(3,adm_course);
	pst.setString(4,adm_branch);
	pst.setString(5,section);
	pst.setString(6,hostel_room);
	pst.setString(7,docs_collected);
	pst.setString(8,adm_remarks);
	pst.setString(9,adm_dd_number);
	pst.setString(10,adm_dd_date);
	pst.setString(11,adm_drawee_bank);
	pst.setString(12,adm_amount);
	pst.setString(13,trn_board_point);
	
	pst.executeUpdate();

	pst1=con.prepareStatement("insert into login (id, name, password, role, status, dept_id) values (?,?,?,?,?,?)");

	pst1.setString(1,regn_no);
	pst1.setString(2,candidate_name);
	pst1.setString(3,"India123");
	pst1.setString(4,"STUDENT");
	pst1.setString(5,"O");
	pst1.setString(6,adm_branch);

	pst1.executeUpdate();


	pst2=con.prepareStatement("insert into student_profile (regn_no, name, mobile, sslc_qualification, sslc_institution, sslc_yop, sslc_percentage, hsc_qualification, hsc_institution, hsc_yop, hsc_percentage, father_name, dob, gender, nationality, address, city, state, pincode) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

	pst2.setString(1,regn_no);
	pst2.setString(2,candidate_name);
	pst2.setString(3,mobile_no);
	pst2.setString(4,"SSLC");
	pst2.setString(5,sslc_school);
	pst2.setString(6,sslc_mon_yop.substring(3,7));
	pst2.setString(7,sslc_percentage);
	pst2.setString(8,"HSC");
	pst2.setString(9,hsc_school);
	pst2.setString(10,hsc_mon_yop.substring(3,7));
	pst2.setString(11,hsc_percentage);
	pst2.setString(12,parent_name);
	pst2.setString(13,dob);
	pst2.setString(14,gender);
	pst2.setString(15,nationality);
	pst2.setString(16,address);
	pst2.setString(17,city);
	pst2.setString(18,state);
	pst2.setString(19,pin_code);

	pst2.executeUpdate();

	pst3=con.prepareStatement("update application set adm_status='A' where appn_no=?");
	pst3.setString(1,appn_no);
	pst3.executeUpdate();

	con.commit();
	mesg="Student admitted successfully. Click <a href='javascript:printReceipt()'>Here</a> to print admission confirmation sheet";
}
catch(Exception e1){
	con.rollback();
	e1.printStackTrace();
	mesg="Error in Admission Process. Please contact Administrator";
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>
<%=mesg%>