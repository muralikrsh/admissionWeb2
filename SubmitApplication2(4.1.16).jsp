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
<%!
	public String hashCal(String type,String str){
		byte[] hashseq=str.getBytes();
		StringBuffer hexString = new StringBuffer();
		try{
		MessageDigest algorithm = MessageDigest.getInstance(type);
		algorithm.reset();
		algorithm.update(hashseq);
		byte messageDigest[] = algorithm.digest();
            
		

		for (int i=0;i<messageDigest.length;i++) {
			String hex=Integer.toHexString(0xFF & messageDigest[i]);
			if(hex.length()==1) hexString.append("0");
			hexString.append(hex);
		}
			
		}catch(NoSuchAlgorithmException nsae){ }
		
		return hexString.toString();


	}
%>
<%

String userID=(String)session.getAttribute("login_id");
System.out.println("Login ID" +session.getAttribute("login_id"));

// Payment Data
String merchant_key="C0Dr8m";
String salt="3sf0jURk";
String action1 ="";
String base_url="https://test.payu.in";
action1=base_url.concat("/_payment");
int error=0;
String hashString="";

// Transaction Id to be sent to payu
String txnid ="";
Random rand = new Random();
String rndm = Integer.toString(rand.nextInt())+(System.currentTimeMillis() / 1000L);
txnid=hashCal("SHA-256",rndm).substring(0,20);


String hash="";
hashString=merchant_key+"|"+txnid+"|"+"750"+ "|"+"appn_form"+"|"+"Murali"+"|"+"jaisriram108@gmail.com";
hash=hashCal("SHA-512",hashString);

String flag=request.getParameter("flag");
String category=request.getParameter("category");
String exam_id="";//request.getParameter("exam_id");
String strRole=(String)session.getAttribute("role"); 
String mkr_id=(String)session.getAttribute("login_id");
ArrayList alCourses=null;
//(ArrayList)application.getAttribute("COURSES");
ArrayList alCentres=null;
/* Temporary 
ArrayList alLangCode1=new ArrayList();
ArrayList alLangName1=new ArrayList();
alLangCode1.add("TA");
alLangName1.add("TAMIL");
alLangCode1.add("EN");
alLangName1.add("ENGLISH");

application.setAttribute("LANG_CODE",alLangCode1);
application.setAttribute("LANG_NAME",alLangName1);
*/

ArrayList alLangCode=(ArrayList)application.getAttribute("LANG_CODE");
ArrayList alLangName=(ArrayList)application.getAttribute("LANG_NAME");
ArrayList alStates=(ArrayList)application.getAttribute("STATES");

//System.out.println("alCourses"+alCourses);
session.setAttribute("category",category);
ArrayList alBoardCode=new ArrayList();
ArrayList alBoardName=new ArrayList();
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
String course="";
String adm_type="";
String course_type="";
String choice_1="";
String choice_2="";
String choice_3="";
String quota="";
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
String relationship="";
String guardian_name="";
String g_relationship="";
String parent_occupation="";

String hsc_school="";
String hsc_city="";
String hsc_board="";
String hsc_regn_no="";
String hsc_mon_yop="";
String hsc_marks="-";
String hsc_outof="-";

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
String oth_outof_1="-";

String oth_exam_2="-";
String oth_college_2="-";
String oth_city_2="-";
String oth_university_2="-";
String oth_regn_no_2="-";
String oth_mon_yop_2="-";
String oth_marks_2="-";
String oth_outof_2="-";

String oth_exam_3="-";
String oth_college_3="-";
String oth_city_3="-";
String oth_university_3="-";
String oth_regn_no_3="-";
String oth_mon_yop_3="-";
String oth_marks_3="-";
String oth_outof_3="-";

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

String state_type="";
String state_code="";
String centre="";
String centre_code="";
String exam_pref="";
String city_centre="";
ArrayList altest_type=new ArrayList();
ArrayList alState_code=new ArrayList();
ArrayList alCentre=new ArrayList();
ArrayList alCentre_code=new ArrayList();
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;

try{
	
	con=ConnectDatabase.getConnection();
	 pst=con.prepareStatement("SELECT course_group, course_id, course_name, course_type from course where course_flag='A' order by course_name");
	rs=pst.executeQuery();
	alCourses=new ArrayList();

	while(rs.next()) {
	alCourses.add( rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3)+"#"+rs.getString(4));
	}
	
    pst=con.prepareStatement("select board_code ,board_name from board");
    String message="<BR><BR><TABLE class='display'  WIDTH='80%' align=center>";
	rs=pst.executeQuery();
	while(rs.next()) {
	alBoardCode.add(rs.getString(1));
	alBoardName.add(rs.getString(2));
	}
	pst=con.prepareStatement("select test_type,state_code,centre,centre_code from test_city_centre order by test_type");
	rs=pst.executeQuery();
	alCentres=new ArrayList();
	while (rs.next()){
		altest_type.add(rs.getString(1));
		alState_code.add(rs.getString(2));
		alCentre.add(rs.getString(3));
		alCentre_code.add(rs.getString(4));
		alCentres.add(rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3)+"#"+rs.getString(4));
	}

	if(flag.intern()=="U".intern() || flag.intern()=="A".intern() ) {

		appn_no=request.getParameter("appn_no");

		
		//String arr[]=new String[] {"Job Id","Company Name","Job Title","Campus Schedule","Apply by","Venue","Joining Location","Salary P.A","Job Eligibility","Job Description","Education","Skill Set","Dream Job?"};

		pst=con.prepareStatement("select first_name,last_name,gender,religion,nationality,dob,community,blood_group,mother_tongue,adm_type,course_type,course,choice_1,choice_2,choice_3,quota, sports_achv,valid_score_of, exam_attended, email_id, address,city,state,country,pin_code,std_code,phone_no,mobile_no,parent_name,relationship,guardian_name, g_relationship, parent_occupation,hsc_school,hsc_city,hsc_board,hsc_regn_no,hsc_mon_yop,hsc_marks,hsc_outof,sslc_school,sslc_city,sslc_board,sslc_regn_no,sslc_mon_yop,sslc_marks,sslc_outof, oth_exam_1,oth_college_1,oth_city_1,oth_university_1,oth_regn_no_1,oth_mon_yop_1,oth_marks_1,oth_outof_1,oth_exam_2,oth_college_2,oth_city_2,oth_university_2,oth_regn_no_2,oth_mon_yop_2,oth_marks_2,oth_outof_2,oth_exam_3,oth_college_3,oth_city_3,oth_university_3,oth_regn_no_3,oth_mon_yop_3,oth_marks_3,oth_outof_3,medium_of_instr,optional_subject,hostel_reqd,transport_reqd,dd_number,dd_date,amount,drawee_bank,appn_status, exam_id,exam_pref,city_centre from application where appn_no=?");
		pst.setString(1, appn_no);
		rs=pst.executeQuery();
		System.out.println("Before IF"+appn_no);
		if(rs.next()) {
		System.out.println("After IF");
			first_name=rs.getString("first_name");
			last_name=rs.getString("last_name");
			gender=rs.getString("gender");
			religion=rs.getString("religion");
			nationality=rs.getString("nationality");
			dob=rs.getString("dob");
			community=rs.getString("community");
			blood_group=rs.getString("blood_group");
			mother_tongue=rs.getString("mother_tongue");
			adm_type=rs.getString("adm_type");
			course_type=rs.getString("course_type");
			course=rs.getString("course");
			System.out.println("Course -> "+course);
			choice_1=rs.getString("choice_1");
			choice_2=rs.getString("choice_2");
			choice_3=rs.getString("choice_3");
			quota=rs.getString("quota");
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
			relationship=rs.getString("relationship");
			guardian_name=rs.getString("guardian_name");
			g_relationship=rs.getString("g_relationship");

			parent_occupation=rs.getString("parent_occupation");

			
			hsc_school=rs.getString("hsc_school");
			hsc_city=rs.getString("hsc_city");
			hsc_board=rs.getString("hsc_board");
			hsc_regn_no=rs.getString("hsc_regn_no");
			hsc_mon_yop=rs.getString("hsc_mon_yop");
			hsc_marks=rs.getString("hsc_marks");
			hsc_outof=rs.getString("hsc_outof");
			
			sslc_school=rs.getString("sslc_school");
			sslc_city=rs.getString("sslc_city");
			sslc_board=rs.getString("sslc_board");
			sslc_regn_no=rs.getString("sslc_regn_no");
			sslc_mon_yop=rs.getString("sslc_mon_yop");
			sslc_marks=rs.getString("sslc_marks");
			sslc_outof=rs.getString("sslc_outof");

			oth_exam_1=rs.getString("oth_exam_1");
			oth_college_1=rs.getString("oth_college_1");
			oth_city_1=rs.getString("oth_city_1");
			oth_university_1=rs.getString("oth_university_1");
			oth_regn_no_1=rs.getString("oth_regn_no_1");
			oth_mon_yop_1=rs.getString("oth_mon_yop_1");
			oth_marks_1=rs.getString("oth_marks_1");
			oth_outof_1=rs.getString("oth_outof_1");

			oth_exam_2=rs.getString("oth_exam_2");
			oth_college_2=rs.getString("oth_college_2");
			oth_city_2=rs.getString("oth_city_2");
			oth_university_2=rs.getString("oth_university_2");
			oth_regn_no_2=rs.getString("oth_regn_no_2");
			oth_mon_yop_2=rs.getString("oth_mon_yop_2");
			oth_marks_2=rs.getString("oth_marks_2");
			oth_outof_2=rs.getString("oth_outof_2");

			oth_exam_3=rs.getString("oth_exam_3");
			oth_college_3=rs.getString("oth_college_3");
			oth_city_3=rs.getString("oth_city_3");
			oth_university_3=rs.getString("oth_university_3");
			oth_regn_no_3=rs.getString("oth_regn_no_3");
			oth_mon_yop_3=rs.getString("oth_mon_yop_3");
			oth_marks_3=rs.getString("oth_marks_3");
			oth_outof_3=rs.getString("oth_outof_3");

			medium_of_instr=rs.getString("medium_of_instr");
			optional_subject=rs.getString("optional_subject");
			hostel_reqd=rs.getString("hostel_reqd");
			transport_reqd=rs.getString("transport_reqd");

			dd_number=rs.getString("dd_number");
			dd_date=rs.getString("dd_date");
			amount=rs.getString("amount");
			drawee_bank=rs.getString("drawee_bank");

			dd_number=(dd_number==null)?"":dd_number;
			dd_date=(dd_date==null)?"":dd_date;
			amount=(amount==null)?"":amount;
			drawee_bank=(drawee_bank==null)?"":drawee_bank;
			
			appn_status=rs.getString("appn_status");
			exam_id=rs.getString("exam_id");
			exam_pref=rs.getString("exam_pref");
			city_centre=rs.getString("city_centre");
		}
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
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
	<!-- <link rel="stylesheet" href="css/jquery.ui.all.css"> -->
	<link rel="stylesheet" href="css/jquery.ui.core.css">
	<link rel="stylesheet" href="css/jquery.ui.dialog.css">
	<link rel="stylesheet" href="css/jquery.ui.datepicker.css">
	<link rel="stylesheet" href="css/jquery.ui.theme.css">
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

	<!-- <link rel="stylesheet" href="css/jquery.ui.datepicker.css" /> -->
	<!-- <link rel="stylesheet" href="css/style.css"/> -->

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
    <!--[if IE 8]>
    <style>
    .header_content{background:url(/images/Header-bg.png);}

	input.error
	{
    box-shadow: inset 0px 2px 5px -1px red !important;
	/*border: 1px solid red !important;*/
	background-color:rgb(235, 174, 174) !important;
	}
    </style>
    <![endif]-->
	<script language="javascript">

	function removerr(obj) { $(obj).removeClass("error_input"); }

		var arrCourses=new Array(<%=alCourses.size() %>);
		<%
		//System.out.println(alCourses);
		for (int k=0; k< alCourses.size() ; k++)
		{

			%>
			arrCourses[<%=k%>]=new Array(4);
			var val='<%=alCourses.get(k).toString()%>'.split("#");
			arrCourses[<%=k%>][0]=val[0];
			arrCourses[<%=k%>][1]=val[1];
			arrCourses[<%=k%>][2]=val[2];
			arrCourses[<%=k%>][3]=val[3];
			<%
		}
			%>

        var arrCenters=new Array(<%=alCentres.size() %>);
		<%
		for (int k=0; k< alCentres.size(); k++)
		{
			%>
			arrCenters[<%=k%>]=new Array(4);
			var val='<%=alCentres.get(k).toString()%>'.split('#');
			arrCenters[<%=k%>][0]=val[0];
			arrCenters[<%=k%>][1]=val[1];
			arrCenters[<%=k%>][2]=val[2];
			arrCenters[<%=k%>][3]=val[3];
			<%
		}
			%>
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g,"");
		}
		function openwin(flag) {
			var w=(window.open("Boardlist.jsp?cat="+flag,"Boards","toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=420,height=400,left=430,top=23"));
		}
		function admitStudent() {
			postRequest("AdmitStudent.jsp");
		}
		function saveApp() {
			//alert("in save");
			if($("#formPersonal").valid() ) {
            alert("save 2");
			// This line shows the red color ... 
				postRequest("SubmitApplicationResult2.jsp","Y");
			} else 
			{
				// Need to show alert here
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

		function submitApp(onlinePayFlag) {
			//alert("1");
			
			$("#formPersonal").validate({
				onfocusout: false,
				invalidHandler: function(form, validator) {
				var errors = validator.numberOfInvalids();
				if (errors) {                    
				validator.errorList[0].element.focus();
				}
				} 
				});
//alert("100");
			if(document.getElementById("address").value.length > 120) {
				displayAlert("Address Length is limited to 120 Characters","dummy");
				return;
			}
			
			
			if(document.getElementById("photopreview").innerHTML.indexOf("img") == -1) {
				displayAlert("Please upload Photo");
				return;
			}
			if(document.getElementById("signpreview").innerHTML.indexOf("img") == -1) {
				displayAlert("Please upload Signature");
				return;
			}				
			/*
			if(document.getElementById("updatePhotoFile").value	== "") {
				displayAlert("Please upload Photo");
				return;
			}
			if(document.getElementById("updateSignFile").value	== "") {
				displayAlert("Please upload Signature");
				return;
			}
			*/			
		document.getElementById("appfee_flag").value=onlinePayFlag;
			var sel_course=document.getElementById("course").value;
			var ch1=document.getElementById("choice_1").value;
			var ch2=document.getElementById("choice_2").value;
			var ch3=document.getElementById("choice_3").value;
            //alert("22");
			var g_name=document.getElementById("guardian_name").value;
			var g_relationship=document.getElementById("g_relationship").value;
			if(g_name!="" && g_relationship=="" ){
			 displayAlert("Enter guardian relationship");
			 return;
			}
			//alert("2");
			if(sel_course.trim()=="B.Tech") {
				if(ch1==ch2 || ch2==ch3 || ch1==ch3) {
					displayAlert("Choices 1, 2 and 3 have to be different");
					return;
				}
			} 
			// alert(ch1+":"+ch2+":"+ch3);

			if(  document.getElementById("guardian_name").value!="") {
				if( document.getElementById("g_relationship").value=="") {
					displayAlert("Guardian Relationshp needs to be filled if Guardian Name is present","dummy");
				}
			}

			if( $("#formPersonal").valid() ) {
				var dt=new Date(getDate(document.formPersonal.dob));
				var today=new Date();
				if(dt.getTime() > today.getTime()) {
					displayAlert("Date of Birth cannot be in the future");
					return;
				} 
				var age_years=((today.getTime() - dt.getTime()) / ( 365 * 24 * 3600 * 1000));
				if(age_years < 16) {

				displayAlert("Minimum Age for application is 16");
					return;
				}		


				if( ( document.getElementById("std_code").value=="" || 	document.getElementById("phone_no").value=="" ) &&	document.getElementById("mobile_no").value=="" ) {
					displayAlert("Both Phone Number and Mobile Number cannot be empty. Please input atleast one");
					return;
				}
				if(sel_course.trim()=="B.Tech"){
				if(	ch1=='CC0012' || ch1=='CC0016' || ch1=='CC0003' || ch1=='CC0021' ||
					ch2=='CC0012' || ch2=='CC0016' || ch2=='CC0003' || ch2=='CC0021' ||
					ch3=='CC0012' || ch3=='CC0016' || ch3=='CC0003' || ch3=='CC0021' ) {
					var optional_subject=encodedVal("optional_subject");
					//alert(ch1+":"+ch2+":"+ch3+":"+optional_subject);
					if(optional_subject == 'M') {
						displayAlert("Optional Subject should be Biology if you want to pursue Bio Medical / Bio Informatics / Nano Tech / Industrial Bio Tech Courses");				
						return;
					}
				}
				}
				if(sel_course.trim()=="B.Arch"){
				var optional_subject=encodedVal("optional_subject");
				//alert(optional_subject);
				if(optional_subject == "O") {
				displayAlert("Optional Subject should be Maths or Math and Bio if you want to pursue B.Arch course");				
						return;
				}}				
				/* Start Month YOP Validation by Murali */
				var sslc_mon_yop=document.getElementById("sslc_mon_yop");
				var hsc_mon_yop=document.getElementById("hsc_mon_yop");
				
				if( ! validateMY(sslc_mon_yop) ) {
				displayAlert("Date of passing must be 2010");
					return;
				}
			
				if( ! validateMY(hsc_mon_yop) ) {
				displayAlert("Date of passing must be 2010");
					return;
				}
				var category='<%=category%>';
				<% 	if(category.intern()=="PG".intern()) { %>
				if( ! validateMY(oth_mon_yop_1) ) {
					return;
				}
				<% } %>
				/* End Month YOP Validation by Murali */				
				postRequest("SubmitApplicationResult2.jsp","N");
			} else {
				// Display Alert in this place
				
				displayError("Please fill the mandatory fields that are highlighted");
				//window.scrollTo(0, 100); 
				// ok open the files which i sent at last.. ok i will download in this sytstem .. 1min

			}
		}
		function approveApp() {
			postRequest2("ApproveApplication.jsp","A");
		}
		function rejectApp() {
			postRequest2("ApproveApplication.jsp","R");
		}
		function payment() {
			document.payuForm.submit();
		}
	    /* Month YOP Validation by Murali */
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
		function edsports() {
			var sel_quota=document.getElementById("quota").value;
			if(sel_quota.trim()=="SPORTS") {
				document.getElementById("sports_achv").disabled=false;
			} else {
				document.getElementById("sports_achv").disabled=true;
			}
		}
        function edHost() {
			alert("hi");
  			var sel_hostel=document.getElementById("hostel_reqd").value;
			if(sel_hostel.trim()=="hostel_reqd") {
				document.getElementById("transport_reqd").disabled=false;
			} else {
				document.getElementById("transport_reqd").disabled=true;
			}
		}
		function edAcademics() {
			var sel_adm_type=document.getElementById("adm_type").value;
			var category='<%=category%>';

			if(category.trim()=="UG" && sel_adm_type.trim()=="FRESH") {
				//alert('Fresh');
				document.getElementById("div_academics_head").style.display="none";
				document.getElementById("div_academics_1").style.display="none";
				document.getElementById("div_academics_2").style.display="none";
				document.getElementById("div_academics_3").style.display="none";
			} else if(category.trim()=="UG" && sel_adm_type.trim()=="LATERAL") {
				document.getElementById("div_academics_head").style.display="block";
				

				document.getElementById("div_academics_1").style.display="block";
				document.getElementById("ahead1").setAttribute("width", "400px");
				document.getElementById("ahead2").setAttribute("width", "400px");

				document.getElementById("oth_exam_1").setAttribute("class", "required");
				document.getElementById("oth_college_1").setAttribute("class", "required");
				document.getElementById("oth_city_1").setAttribute("class", "required");
				document.getElementById("oth_university_1").setAttribute("class", "required");
				document.getElementById("oth_regn_no_1").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_1").setAttribute("class", "required");
				document.getElementById("oth_marks_1").setAttribute("class", "required");
				document.getElementById("oth_outof_1").setAttribute("class", "required");

				document.getElementById("div_academics_2").style.display="none";
				document.getElementById("div_academics_3").style.display="none";
			} 
			else {
				document.getElementById("div_academics_head").style.display="block";

				document.getElementById("div_academics_1").style.display="block";
				document.getElementById("div_academics_2").style.display="block";
				document.getElementById("div_academics_3").style.display="block";

				document.getElementById("oth_exam_1").setAttribute("class", "required");
				document.getElementById("oth_college_1").setAttribute("class", "required");
				document.getElementById("oth_city_1").setAttribute("class", "required");
				document.getElementById("oth_university_1").setAttribute("class", "required");
				document.getElementById("oth_regn_no_1").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_1").setAttribute("class", "required");
				document.getElementById("oth_marks_1").setAttribute("class", "required");
				document.getElementById("oth_outof_1").setAttribute("class", "required");

				document.getElementById("oth_exam_2").setAttribute("class", "required");
				document.getElementById("oth_college_2").setAttribute("class", "required");
				document.getElementById("oth_city_2").setAttribute("class", "required");
				document.getElementById("oth_university_2").setAttribute("class", "required");
				document.getElementById("oth_regn_no_2").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_2").setAttribute("class", "required");
				document.getElementById("oth_marks_2").setAttribute("class", "required");
				document.getElementById("oth_outof_2").setAttribute("class", "required");

				document.getElementById("oth_exam_3").setAttribute("class", "required");
				document.getElementById("oth_college_3").setAttribute("class", "required");
				document.getElementById("oth_city_3").setAttribute("class", "required");
				document.getElementById("oth_university_3").setAttribute("class", "required");
				document.getElementById("oth_regn_no_3").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_3").setAttribute("class", "required");
				document.getElementById("oth_marks_3").setAttribute("class", "required");
				document.getElementById("oth_outof_3").setAttribute("class", "required");

			}
		}

		function edAcademics2() {
			var category='<%=category%>';

			if(category.trim()=="PG") {
				document.getElementById("oth_exam_1").setAttribute("class", "required");
				document.getElementById("oth_college_1").setAttribute("class", "required");
				document.getElementById("oth_city_1").setAttribute("class", "required");
				document.getElementById("oth_university_1").setAttribute("class", "required");
				document.getElementById("oth_regn_no_1").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_1").setAttribute("class", "required");
				document.getElementById("oth_marks_1").setAttribute("class", "required");
				document.getElementById("oth_outof_1").setAttribute("class", "required");

				document.getElementById("oth_exam_2").setAttribute("class", "required");
				document.getElementById("oth_college_2").setAttribute("class", "required");
				document.getElementById("oth_city_2").setAttribute("class", "required");
				document.getElementById("oth_university_2").setAttribute("class", "required");
				document.getElementById("oth_regn_no_2").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_2").setAttribute("class", "required");
				document.getElementById("oth_marks_2").setAttribute("class", "required");
				document.getElementById("oth_outof_2").setAttribute("class", "required");

				document.getElementById("oth_exam_3").setAttribute("class", "required");
				document.getElementById("oth_college_3").setAttribute("class", "required");
				document.getElementById("oth_city_3").setAttribute("class", "required");
				document.getElementById("oth_university_3").setAttribute("class", "required");
				document.getElementById("oth_regn_no_3").setAttribute("class", "required");
				document.getElementById("oth_mon_yop_3").setAttribute("class", "required");
				document.getElementById("oth_marks_3").setAttribute("class", "required");
				document.getElementById("oth_outof_3").setAttribute("class", "required");

			}
		}
		function loadCourseList() {
			var fullTime=[ "M.Tech","MBA","MCA" ];
			var partTime=[ "M.Tech","MBA" ];

			var c1=document.getElementById("course");
			var ctype=document.getElementById("course_type").value;

			if(c1.options.length>0) {
				for(i=c1.options.length; i>=0; i--) {
					c1.remove(i);
				}
			}

			if(ctype=="F") {
				c1.add(new Option("Select Course", ""));
				for(i=0; i<fullTime.length; i++) {
					c1.add(new Option(fullTime[i], fullTime[i]));		
				}
			}

			if(ctype=="P") {
				c1.add(new Option("Select Course", ""));
				for(i=0; i<partTime.length; i++) {
					c1.add(new Option(partTime[i], partTime[i]));		
				}
			}

		}
      /* function loadtestcentre(obj){
			alert (obj);
		    var test_type=obj.value;
			var test_centre=document.getElementById("city_centre");
			for (int i=0;i<arrCenters.length();i++){
				if( (test_type.trim()==arrCenters[i][0].trim()) {
					test_centre.add(new Option(arrCenters[i][2], arrCenters[i][1]));
				}
			
			}
		}*/
		function loadCourseData(obj) {
			var sel_course=obj.value; //document.getElementById("course").value;
			//alert (obj);
			var course_type=document.getElementById("course_type").value;

			if(sel_course.trim()=="B.Arch" || sel_course.trim()=="MCA" || sel_course.trim()=="MBA") {
				document.getElementById("choice_1").disabled=true;
				document.getElementById("choice_2").disabled=true;
				document.getElementById("choice_3").disabled=true;
			} else {
				document.getElementById("choice_1").disabled=false;
				document.getElementById("choice_2").disabled=false;
				document.getElementById("choice_3").disabled=false;
				loadCourses(sel_course,course_type);
			}
		}


		function loadCourses(val, course_type) {
			
			var ch1=document.getElementById("choice_1");
			var ch2=document.getElementById("choice_2");
			var ch3=document.getElementById("choice_3");
			if(ch1.options.length>1) {
				for(i=ch1.options.length; i>0; i--) {
					ch1.remove(i);
					ch2.remove(i);
					ch3.remove(i);
				}
			}
			//alert(arrCourses.length);
			for(i=0; i<arrCourses.length; i++) {
				//alert(arrCourses[i][3]+":::"+course_type);
				if( (val.trim()==arrCourses[i][0].trim()) && (course_type.trim()==arrCourses[i][3].trim()) ) {
					ch1.add(new Option(arrCourses[i][2], arrCourses[i][1]));
					ch2.add(new Option(arrCourses[i][2], arrCourses[i][1]));
					ch3.add(new Option(arrCourses[i][2], arrCourses[i][1]));
				}
			}
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
			// document.getElementById("resultCell").innerHTML = "<b><FONT SIZE=2>Result : "+str+"</FONT></b>";
			displayAlert("Result : "+str);
			//alert("<b><FONT SIZE=2>Result : "+str+"</FONT></b>");

		}

		function setParams() {
			//alert("10");
			var first_name=encodeURIComponent(document.getElementById("first_name").value);
			var last_name='';//encodeURIComponent(document.getElementById("last_name").value);
			var gender='';
//alert("11");
			var gender=getVal("gender");
			var religion=getVal("religion");
			var nationality=getVal("nationality");
//alert("12");

			var hostel_reqd='';
			arr=document.formPersonal.hostel_reqd;
			for(i=0; i<arr.length; i++) {
				if(arr[i].checked==true) {
					hostel_reqd=arr[i].value;
					break
				}
			}
			
			var transport_reqd='';
			arr=document.formPersonal.transport_reqd;
			for(i=0; i<arr.length; i++) {
				if(arr[i].checked==true) {
					transport_reqd=arr[i].value;
					break
				}
			}

			var dob=encodedVal("dob");
			var blood_group='';
			blood_group=encodedVal("blood_group");
			var mother_tongue=encodedVal("mother_tongue");
			var community='';
			community=encodedVal("community");
			var course=encodedVal("course");
			var choice_1=encodedVal("choice_1");
			var choice_2=encodedVal("choice_2");
			var choice_3=encodedVal("choice_3");
			
			var quota='';//encodedVal("quota");
			var sports_achv='';//encodedVal("sports_achv");
			//alert("13");
			var valid_score_of=encodedVal("valid_score_of");
			var exam_attended=encodedVal("exam_attended");
			
			var email_id=encodedVal("email_id");
			var address=encodedVal("address");
			var city=encodedVal("city");
			var state=encodedVal("state");
			var country=encodedVal("country");
			var pin_code=encodedVal("pin_code");
			var std_code=encodedVal("std_code");
			var phone_no=encodedVal("phone_no");

			var mobile_no=encodedVal("mobile_no");
			var parent_name=encodedVal("parent_name");
			var guardian_name=encodedVal("guardian_name");
			var g_relationship=encodedVal("g_relationship");

			var relationship=encodedVal("relationship");
			var parent_occupation=encodedVal("parent_occupation");

			var hsc_school=encodedVal("hsc_school");
			var hsc_city=encodedVal("hsc_city");
			var hsc_board=encodedVal("hsc_board");
			var hsc_regn_no=encodedVal("hsc_regn_no");
			var hsc_mon_yop=encodedVal("hsc_mon_yop");
			var hsc_marks=encodedVal("hsc_marks");
			var hsc_outof=encodedVal("hsc_outof");

			var sslc_school=encodedVal("sslc_school");
			var sslc_city=encodedVal("sslc_city");
			var sslc_board=encodedVal("sslc_board");
			var sslc_regn_no=encodedVal("sslc_regn_no");
			var sslc_mon_yop=encodedVal("sslc_mon_yop");
			var sslc_marks=encodedVal("sslc_marks");
			var sslc_outof=encodedVal("sslc_outof");

			var oth_exam_1=encodedVal("oth_exam_1");
			var oth_college_1=encodedVal("oth_college_1");
			var oth_city_1=encodedVal("oth_city_1");
			var oth_university_1=encodedVal("oth_university_1");
			var oth_regn_no_1=encodedVal("oth_regn_no_1");
			var oth_mon_yop_1=encodedVal("oth_mon_yop_1");
			var oth_marks_1=encodedVal("oth_marks_1");
			var oth_outof_1=encodedVal("oth_outof_1");

			var oth_exam_2=encodedVal("oth_exam_2");
			var oth_college_2=encodedVal("oth_college_2");
			var oth_city_2=encodedVal("oth_city_2");
			var oth_university_2=encodedVal("oth_university_2");
			var oth_regn_no_2=encodedVal("oth_regn_no_2");
			var oth_mon_yop_2=encodedVal("oth_mon_yop_2");
			var oth_marks_2=encodedVal("oth_marks_2");
			var oth_outof_2=encodedVal("oth_outof_2");

			var oth_exam_3=encodedVal("oth_exam_3");
			var oth_college_3=encodedVal("oth_college_3");
			var oth_city_3=encodedVal("oth_city_3");
			var oth_university_3=encodedVal("oth_university_3");
			var oth_regn_no_3=encodedVal("oth_regn_no_3");
			var oth_mon_yop_3=encodedVal("oth_mon_yop_3");
			var oth_marks_3=encodedVal("oth_marks_3");
			var oth_outof_3=encodedVal("oth_outof_3");

			var medium_of_instr='';
			medium_of_instr=encodedVal("medium_of_instr");
			var optional_subject='';
			optional_subject=encodedVal("optional_subject");
            var exam_pref='';
			exam_pref=encodedVal("exam_pref");
			var city_centre='';
			city_centre=encodedVal("city_centre");
			var dd_number;
			var dd_date;
			var drawee_bank;
			var amount;
			var appfee_flag=encodedVal("appfee_flag");;
			var appfee_rcp_no;

			
			/*
			var dd_number=encodedVal("dd_number");
			var dd_date=encodedVal("dd_date");
			var drawee_bank=encodedVal("drawee_bank");
			var amount=encodedVal("amount");
			var appfee_flag=encodedVal("appfee_flag");
			var appfee_rcp_no=encodedVal("appfee_rcp_no");
			*/
			var exam_id=encodedVal("exam_id");


			var adm_type=encodedVal("adm_type");
			var course_type=encodedVal("course_type");
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
var ipaddr="<%= getClientIpAddr(request) %>";
var parameters="first_name="+first_name+
"&last_name="+last_name+
"&gender="+gender+
"&religion="+religion+
"&nationality="+nationality+
"&dob="+dob+
"&community="+community+
"&blood_group="+blood_group+
"&mother_tongue="+mother_tongue+
"&course="+course+
"&choice_1="+choice_1+
"&choice_2="+choice_2+
"&choice_3="+choice_3+
"&quota="+quota+
"&sports_achv="+sports_achv+
"&valid_score_of="+valid_score_of+
"&exam_attended="+exam_attended+
"&address="+address+
"&city="+city+
"&state="+state+
"&country="+country+
"&pin_code="+pin_code+
"&std_code="+std_code+
"&phone_no="+phone_no+
"&mobile_no="+mobile_no+
"&parent_name="+parent_name+
"&guardian_name="+guardian_name+
"&relationship="+relationship+
"&g_relationship="+g_relationship+
"&parent_occupation="+parent_occupation+
"&hsc_school="+hsc_school+
"&hsc_city="+hsc_city+
"&hsc_board="+hsc_board+
"&hsc_regn_no="+hsc_regn_no+
"&hsc_mon_yop="+hsc_mon_yop+
"&hsc_marks="+hsc_marks+
"&hsc_outof="+hsc_outof+
"&sslc_school="+sslc_school+
"&sslc_city="+sslc_city+
"&sslc_board="+sslc_board+
"&sslc_regn_no="+sslc_regn_no+
"&sslc_mon_yop="+sslc_mon_yop+
"&sslc_marks="+sslc_marks+
"&sslc_outof="+sslc_outof+
"&oth_exam_1="+oth_exam_1+
"&oth_college_1="+oth_college_1+
"&oth_city_1="+oth_city_1+
"&oth_university_1="+oth_university_1+
"&oth_regn_no_1="+oth_regn_no_1+
"&oth_mon_yop_1="+oth_mon_yop_1+
"&oth_marks_1="+oth_marks_1+
"&oth_outof_1="+oth_outof_1+
"&oth_exam_2="+oth_exam_2+
"&oth_college_2="+oth_college_2+
"&oth_city_2="+oth_city_2+
"&oth_university_2="+oth_university_2+
"&oth_regn_no_2="+oth_regn_no_2+
"&oth_mon_yop_2="+oth_mon_yop_2+
"&oth_marks_2="+oth_marks_2+
"&oth_outof_2="+oth_outof_2+
"&oth_exam_3="+oth_exam_3+
"&oth_college_3="+oth_college_3+
"&oth_city_3="+oth_city_3+
"&oth_university_3="+oth_university_3+
"&oth_regn_no_3="+oth_regn_no_3+
"&oth_mon_yop_3="+oth_mon_yop_3+
"&oth_marks_3="+oth_marks_3+
"&oth_outof_3="+oth_outof_3+
"&medium_of_instr="+medium_of_instr+
"&exam_pref="+exam_pref+
"&city_centre="+city_centre+
"&optional_subject="+optional_subject+
"&hostel_reqd="+hostel_reqd+
"&transport_reqd="+transport_reqd+
"&dd_number="+dd_number+
"&dd_date="+dd_date+
"&drawee_bank="+drawee_bank+
"&amount="+amount+
"&adm_course="+adm_course+
"&adm_branch="+adm_branch+
"&section="+section+
"&regn_no="+regn_no+
"&hostel_room="+hostel_room+
"&adm_remarks="+adm_remarks+
"&docs_collected="+docs_collected+
"&exam_id="+exam_id+
"&adm_type="+adm_type+
"&course_type="+course_type+
"&email_id="+email_id+
"&flag=<%=flag%>&appn_no=<%=appn_no%>&mkr_id=<%=mkr_id%>"+
"&appfee_flag="+appfee_flag+
"&appfee_rcp_no="+appfee_rcp_no+
"&trn_board_point="+trn_board_point+
"&ipaddr="+ipaddr;
				;
			// "&adm_dd_number="+adm_dd_number+"&adm_dd_date="+adm_dd_date+"&adm_drawee_bank="+adm_drawee_bank+"&adm_amount="+adm_amount+

			return parameters;
		}

		function encodedVal(str) {
			return encodeURIComponent(document.getElementById(str).value);
		}
		function getVal(str) {
			return document.getElementById(str).value;
		}
		
		function postRequest(strURL, draftFlag) {
			var parameters=setParams();
//alert("save 3");
			$('#divLoading').show();
			centerDiv('#divLoading');
			//alert("save 4");
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
					//alert("Response Recd");
				}
			}
			//xmlHttp.send(strURL);
		}
		function updatepage(str){
			// document.getElementById("resultCell").innerHTML = "<b><FONT color=red SIZE=2>"+str+"</FONT></b>";
			// alert("Result : "+str.trim());
			var arr=str.split("~");
			StopLoading();			
			//alert(arr);
			//alert(":::"+arr[0]+":::");
			if(arr[0].trim()=="0000".trim()) {
				if(document.getElementById("appfee_flag").value=="O") {
					document.payform.msg.value=arr[2].trim();
					//alert(document.payform.msg.value);
					document.payform.submit();
				} else {
				displayAlert("Result : " + "Your Application has been submitted. Application Number is "+arr[1],'goHome');
				}
			} else {
				if(arr[0].trim()=="0002".trim()) {
					displayError("Result : Error while submitting Application. Mobile Number Exists",'goHome');
				} else {
					displayError("Result : Error while submitting Application. Please Contact Administrator",'goHome');
				}
			}			
			/*	
			if(str.trim().indexOf("Submitted Successfully") != -1) {
				location.href='Home.jsp';
			}
			*/
		}
		function cancel(){
			location.href='Home.jsp';
		}

		$(function() {
			//document.getElementById('cash_pay').style.display="none";
			//document.getElementById('dd_pay').style.display="none";
			//document.getElementById('online_pay').style.display="none";


   //,fillSpace:true
			
			
			$('#updatePhotoFile').change(function()	
			{
			if (typeof console === "undefined" || typeof console.log === "undefined") {
			console = {};}
			console.log("Photo "+document.getElementById("updatePhotoFile").value);
			if(validateFileExtension(document.getElementById("updatePhotoFile"),"jpg, jpeg, gif, tiff, tng")) {			
			$("#imageform").ajaxForm(
			{
			target: '#photopreview'
			}).submit();
			}
			});
			
			$('#updateSignFile').change(function()	
			{
				if (typeof console === "undefined" || typeof console.log === "undefined") {
     console = {};
				}
			console.log("Sign "+document.getElementById("updateSignFile").value);
			if(validateFileExtension(document.getElementById("updateSignFile"),"jpg, jpeg, gif, tiff, tng")) {			
			$("#signatureform").ajaxForm(
			{
			target: '#signpreview'
			}).submit();
			}
			});
			
			
            $( "#dob" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy',
				yearRange: "1985:2005",
				defaultDate: new Date(1985,01,01)	
				});

			$('#dob').datepicker().val("<%=dob%>").trigger('change');
			$( "#dd_date" ).datepicker({
				changeMonth: true, 
				changeYear: true,  
				dateFormat: 'dd-M-yy'	,
				yearRange: "2010:2020" });

			$('#dd_date').datepicker().val("<%=dd_date%>").trigger('change');

			// loadCourses();
			edAcademics2();
			var vals=new Array();
			vals[0]= [ "F","M","G" ];
			vals[1]= [ "01","02","03","04","05","06","07","08","09","10","11" ];
			vals[2]= [ "O+","O-","A+","A-","B+","B-","AB+","AB-" ];
			vals[3]= [ "M","F" ];
			vals[4]= [ "I","N","F" ];
			vals[5]= [ "1","2","3","4","5" ];

			vals[6]= new Array(<%=alLangCode.size()%>);
			<%
			for (int u=0; u<alLangCode.size(); u++)
			{
			%>
				vals[6][<%=u%>]='<%= alLangCode.get(u) %>';
			<% } %>
			vals[7]= [ "NONE","SPORTS","ES","HC","FG","EC"];
			vals[8]= [ "M","B","O" ];
			//vals[9]= [ "FRESH","LATERAL" ];
			//vals[8]= [ "B.Tech","B.Arch","M.Tech","MBA","MCA" ];
			/*
			vals[9]=new Array(arrCourses.length);
			for(g=0; g<arrCourses.length; g++) {
				vals[9][g]=arrCourses[g][1];
			}
			vals[10]=new Array(arrCourses.length);
			for(g=0; g<arrCourses.length; g++) {
				vals[10][g]=arrCourses[g][1];
			}
			vals[11]=new Array(arrCourses.length);
			for(g=0; g<arrCourses.length; g++) {
				vals[11][g]=arrCourses[g][1];
			}
			*/
			//vals[1]= [ "TA","HI","TE","ML","BE"];
			/*

			vals[2]= [ "MECH","ECE","EEE" ];
			vals[3]= [ "MECH","ECE","EEE" ];
			vals[4]= [ "MECH","ECE","EEE" ];

			vals[6]= [ "GATE","TANCET","CAT","MAT","XAT" ];
			vals[7]= [ "GATE","TANCET","CAT","MAT","XAT" ];
			vals[8]= [ "F","M","G" ];
			vals[10]= [ "E","T" ];
			vals[11]= [ "M","B" ];

			*/
			var sel=new Array();
			sel[0]="<%= relationship %>";
			sel[1]="<%=parent_occupation %>";
			sel[2]="<%= blood_group %>";
			sel[3]="<%= gender  %>";
			sel[4]="<%= nationality  %>";
			sel[5]="<%= community  %>";
			sel[6]="<%=mother_tongue %>";
			sel[7]="<%=quota %>";
			sel[8]="<%= optional_subject  %>";
			sel[9]="<%= adm_type  %>";
			//sel[8]="<%=course %>";
			//sel[9]="<%=choice_1 %>";
			//sel[10]="<%=choice_2 %>";
			//sel[11]="<%=choice_3 %>";


			

			// sel[1]="<%= mother_tongue %>";
			/*
			sel[1]="<%= course %>";
			sel[2]="<%= choice_1 %>";
			sel[3]="<%= choice_2 %>";
			sel[4]="<%= choice_3 %>";
			sel[5]="<%= sports_achv %>";
			sel[6]="<%= valid_score_of %>";
			sel[7]="<%= exam_attended %>";

			sel[15]="<%= quota  %>";
			*/
		var arr=["relationship","parent_occupation", "blood_group", "gender","nationality", "community","mother_tongue", "quota", "optional_subject", "adm_type","course", "choice_1", "choice_2", "choice_3", "sports_achv", "valid_score_of", "exam_attended", "sslc_board", "hsc_board"];

			for (i=0; i<vals.length; i++) {
				for (j=0; j<vals[i].length; j++) {
					if(vals[i][j].trim()==sel[i].trim()) {
						//alert("Matched "+arr[i] +"::"+vals[i][j]+"::"+i+"::"+j);
						document.getElementById(arr[i]).options[j+1].selected=true;
						break;
					}
				}
			} 
			<% if(flag.intern()=="U".intern()) { 
					if(category.intern()=="UG".intern()) { 
			%>
			// alert('<%= adm_type %>');
			for(k=0; k<document.getElementById("adm_type").options.length; k++) {
				if(document.getElementById("adm_type").options[k].value=='<%= adm_type %>') {
						document.getElementById("adm_type").options[k].selected=true;
					break;
				}
			}
			<% }  else { %>
			for(k=0; k<document.getElementById("exam_attended").options.length; k++) {
				if(document.getElementById("exam_attended").options[k].value=='<%= exam_attended %>') {
						document.getElementById("exam_attended").options[k].selected=true;
					break;
				}
			}
			for(k=0; k<document.getElementById("course_type").options.length; k++) {
				if(document.getElementById("course_type").options[k].value=='<%= course_type %>') {
						document.getElementById("course_type").options[k].selected=true;
					break;
				}
			}
			<% } %>
			loadCourses("<%=course %>", "F"); //document.getElementById("course").value

			for(k=0; k<document.getElementById("state").options.length; k++) {
				if(document.getElementById("state").options[k].value=='<%= state %>') {
						document.getElementById("state").options[k].selected=true;
					break;
				}
			}
			

			for(k=0; k<document.getElementById("course").options.length; k++) {
				if(document.getElementById("course").options[k].value=='<%= course %>') {
						document.getElementById("course").options[k].selected=true;
					break;
				}
			}
			
			for(k=0; k<document.getElementById("choice_1").options.length; k++) {
				if(document.getElementById("choice_1").options[k].value=='<%= choice_1 %>') {
						document.getElementById("choice_1").options[k].selected=true;
					break;
				}
			}

			for(k=0; k<document.getElementById("choice_2").options.length; k++) {
				if(document.getElementById("choice_2").options[k].value=='<%= choice_2 %>') {
						document.getElementById("choice_2").options[k].selected=true;
					break;
				}
			}

			for(k=0; k<document.getElementById("choice_3").options.length; k++) {
				if(document.getElementById("choice_3").options[k].value=='<%= choice_3 %>') {
						document.getElementById("choice_3").options[k].selected=true;
					break;
				}
			}

			document.getElementById("address").innerHTML='<%= address %>';
			
						
			var hostel_reqd="<%=hostel_reqd%>";
			var transport_reqd="<%=transport_reqd%>";
			
			if(hostel_reqd.trim()==document.formPersonal.hostel_reqd[0].value)
				document.formPersonal.hostel_reqd[0].checked=true;
			if(hostel_reqd.trim()==document.formPersonal.hostel_reqd[1].value)
				document.formPersonal.hostel_reqd[1].checked=true;
			
			
			if(transport_reqd.trim()==document.formPersonal.transport_reqd[0].value)
				document.formPersonal.transport_reqd[0].checked=true;
			if(transport_reqd.trim()==document.formPersonal.transport_reqd[1].value)
				document.formPersonal.transport_reqd[1].checked=true;
			<% } %>				
	});

</script>
<%@include file="MBHandler.jsp" %>
</head>
<!-- <td colspan=2><div id='resultCell'></div></td> -->
<body >
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">

	<form id="formPersonal" name="formPersonal" method="post" autocomplete="on" >		
	<input type='hidden' name='exam_id' id='exam_id' value='<%=exam_id%>'/>
	<table id="maintab" class="formtab textbox_medium tbl_p3 textarea_normal " >
	<tr>
		<td colspan="2" align="left" class="common-content">Note:An asterisk (<font color="red">*</font>) indicates a required field. On submission, mandatory fields which are empty / Fields with Invalid values are highlighted in red
		</td>
	</tr>

	<tr>
	<td colspan="2" class="button navy gradient">Personal Details</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td>First Name<font color="red">*</font> </td>
		<td><input type="text" class="required" id="first_name" name="first_name"  value='<%=first_name%>' size=30 maxlength=30 class="" title="First Name ex:  'Ramesh'" /></td>
	
	
		<td><input type="hidden" id="last_name" name="last_name"  value=''/></td>
	</tr>
	<tr>
		<td>Parent Name & Relationship<font color="red">*</font></td>
		<td><input type="text" id="parent_name" name="parent_name" class="required"  size=30 maxlength=30 value="<%=parent_name%>"  />&nbsp;&nbsp;
		<select class="required" id="relationship" name="relationship" STYLE="width: 200px"> 
			<option value="">Relationship  of Parent with you</option>
			<option value="F">Father</option>
			<option value="M">Mother</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Parent's Occupation<font color="red">*</font></td>
		<td>
		<select id="parent_occupation" name="parent_occupation"  class="required"  STYLE="width: 210px">
			<option value="">Parent Occupation</option>
			<option value="01">Agriculture</option>
			<option value="02">Business</option>
			<option value="03">Defence Services</option>
			<option value="04">Engineering Services</option>
			<option value="05">Public / Govt Services</option>
			<option value="06">Law</option>
			<option value="07">Medical  Services</option>
			<option value="08">Private</option>
			<option value="09">Self Employed</option>
			<option value="10">Teaching / research</option>
			<option value="11">Others</option>
		</select>
		</td>
	</tr>


	<tr>
		<td>Gender<font color="red">*</font></td>
		<td align=left nowrap>
		<select id="gender" class="required" STYLE="width: 210px">
			<option value="" >Select Gender</option>
			<option value="M">Male</option>
			<option value="F">Female</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Date of Birth<font color="red">*</font></td>
		<td align=left nowrap>
		<input size=30 type="text"  class="required" name="dob" value=""  readonly="readonly" value='<%=dob%>'  id="dob"/>
		</td>
	</tr>
	<tr>
		<td>Nationality<font color="red">*</font></td>
		<td align=left nowrap>
		<select id="nationality" name="nationality" class="required" STYLE="width: 210px">
			<option value="">Select Nationality</option>
			<option value="I">Indian</option>
			<option value="N">NRI/PIO/OCI</option>
			<option value="F">Foreign / Others</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Religion<font color="red">*</font></td>
		<td align=left nowrap>
		<input type="text" id="religion" name="religion" value="<%=religion%>"  class="required" size=30 maxlength=20 />
		&nbsp;&nbsp;
		
		</td>
	</tr>
	<tr>
		<td>Community</td>
		<td align=left nowrap>
		<select id="community" name="community" STYLE="width: 210px" >
		<option value="">Select Community</option>
		<option value="1">General / OC</option>
		<option value="2">OBC / BC</option>
		<option value="3">MBC</option>
		<option value="4">SC</option>
		<option value="5">ST</option>
		</select>
		</td>
	</tr>

	<tr>
		<td>Blood Group</td>
		<td>
		<select id="blood_group" name="blood_group"  STYLE="width: 210px" >
			<option value="">Select Blood Group</option>
			<option value="O+">O+</option>
			<option value="O-">O-</option>
			<option value="A+">A+</option>
			<option value="A-">A-</option>
			<option value="B+">B+</option>
			<option value="B-">B-</option>
			<option value="AB+">AB+</option>
			<option value="AB-">AB-</option>
		</select>
		</td>
		
	</tr>

	<tr>
		<td>Mother Tongue<font color="red">*</font></td>
		<td>
		<select id="mother_tongue" name="mother_tongue" class="required" STYLE="width: 210px">
			<option value="">Select Mother Tongue</option>
			<%
			for (int k=0; k< alLangCode.size() ; k++)
			{
				%>
				<option value="<%=alLangCode.get(k) %>"><%=alLangName.get(k) %></option>
				<%
			}
				%>
		</select>
		<!-- <input id="mother_tongue" name="mother_tongue" value="<%=mother_tongue%>" class="required" size=20 length=20> -->
		</td>
		
	</tr>
	
	
	<input type="hidden"  id="quota" name="quota" value="NA" />
	<input type="hidden"  id="sports_achv" name="sports_achv" value="NA" />

	<input type="hidden" id="guardian_name" name="guardian_name" value="NA" />
	<input type="hidden" id="g_relationship" name="g_relationship" value="NA" />

	
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Course Choices</td></tr>
	<% if (category.intern()=="UG".intern()) { %>
	<tr>
		<td>Admission Type<font color="red">*</font></td>
		<td>
		<select id="adm_type" name="adm_type" class="required" onChange='javascript:edAcademics()' STYLE="width: 210px">
			<option value="">Select</option>
			<option value="FRESH">Full Time/Fresh</option>
			<option value="LATERAL">Lateral</option>
			<option value="LATERAL">Part Time</option>
		</select>
		</td>
		<input type="hidden"  id="course_type" name="course_type" value="F" />
	</tr>
	<% } else { %>
	<tr>
		<td>Course Type<font color="red">*</font></td>
		<td>
		<select id="course_type" name="course_type" class="required" onChange='javascript:loadCourseList()' STYLE="width: 210px" >
			<option value="">Select</option>
			<option value="F">Full Time</option>
			<option value="P">Part Time</option>
		</select>
		</td>
		</tr>
		<input type="hidden"  id="adm_type" name="adm_type" value="F" />
	<% } %>
	<tr>
	<td>Course<font color="red">*</font></td>
	<td>
	<select id="course" name="course" class="required" onChange='javascript:loadCourseData(this)' STYLE="width: 210px">
	<% if (category.intern()=="UG".intern()) { %>
		<option value="">Select</option>
		<option value="B.Tech">B.Tech</option>
		<option value="B.Arch">B.Arch</option>
		<option value="B.A">B.A</option>
		<option value="B.Sc">B.Sc</option>
		<option value="B.Com">B.Com</option>
		<option value="BBA">BBA</option>
		<option value="BCA">BCA</option>
	<% } else{ %>	
		<option value="M.Tech">M.Tech</option>
		<option value="MCA">MCA</option>
		<option value="MBA">MBA</option>
		<% } %>
	</select>
	</td>
	</tr>


	<tr>
		<td>Choice 1<font color="red">*</font></td>
		<td>
		<select id="choice_1" name="choice_1" class="required" STYLE="width: 300px">
			<option value="">Select a Course</option>
		</select>
		</td>
		</tr>
	<tr>
		<td>Choice 2<font color="red">*</font></td>
		<td>
		<select id="choice_2" name="choice_2" class="required" STYLE="width: 300px">
			<option value="">Select a Course</option>
		</select>
		</td>
		</tr>
	<tr>
		<td>Choice 3</td>
		<td>
		<select id="choice_3" name="choice_3"  STYLE="width: 300px">
			<option value="">Select a Course</option>
		</select>
		</td>
	</tr>
	<% if (category.intern()=="PG".intern()) { %>
	<tr>
		<!-- <td>Attended</td> -->
		<td>Other Qualifying Exams</td>
		<td>
		<select id="exam_attended" STYLE="width: 210px">
			<option value="">Select</option>
			<option value="GATE">GATE</option>
			<option value="TANCET">TANCET</option>
			<option value="CAT">CAT</option>
			<option value="MAT">MAT</option>
			<option value="XAT">XAT</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Valid Score</td>
		<td>
		<input id="valid_score_of" name="valid_score_of" value="<%=valid_score_of%>" size=30/>	
		</td>
	</tr>
	<% } else { %>
		<input type="hidden"  id="exam_attended" name="exam_attended" value="NA" />
		<input type="hidden"  id="valid_score_of" name="valid_score_of" value="NA" />
	<% } %>
	<tr>
		<td>Medium of Instruction<font color="red">*</font></td>
		<td>
 <select id="medium_of_instr">
			<option value="">Select</option>
			<option value="E">English</option>
			<option value="O">Others</option>
		</select> 
		
		</td>

	</tr>
	
		<input type="hidden"  id="optional_subject" name="optional_subject" value="N" />
	
							
	<tr><td colspan=2>&nbsp;</td></tr>

	<tr><td colspan=2 class="button navy gradient">Address Details</td></tr>
	<tr>
		<td>Permanent Address<font color="red">*</font></td>
		<td><textarea required="required" rows="4" cols="30" maxlength=120 id="address" name="address"  ></textarea></td>
	</tr>
	<tr>
		<td>City</td>
		<td><input type="text" id="city" name="city" value="<%=city%>"  size="30" maxlength=20 /></td>
	</tr>
	<tr>
		<td>State<font color="red">*</font></td>
		<td>
		<select id="state" name="state" class="required" STYLE="width: 210px">
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
		<td>Country<font color="red">*</font></td>
		<td><input type="text" id="country" name="country"  value="<%=country%>"  class="required" size=30 maxlength=30 /></td>
	</tr>	
	<tr>
		<td>Pin Code<font color="red">*</font></td>
		<td><input type="text" id="pin_code" name="pin_code" value="<%=pin_code%>"  class="required number" size="30" maxlength=6 /></td>
	</tr>
	<tr>
		<td>STD Code & Phone No</td>
		<td><input type="text" id="std_code" name="std_code" size='6'   maxlength=5 class="number" value="<%=std_code%>"/>
		<input type="text" id="phone_no" name="phone_no" class="number" value="<%=phone_no%>" size="18" maxlength=12 /></td>
	</tr>
	<tr>
		<td>Mobile No<font color="red">*</font></td>
		<td><input type="text" size=30 id="mobile_no" name="mobile_no" value="<%=mobile_no%>" class="required" maxlength=10 /></td>
	</tr>
	<tr>
		<td>Email Address<font color="red">*</font></td>
		<td><input type="text" size=30 id="email_id" name="email_id" value="<%=email_id%>" class="required email" size=30 maxlength=30 /></td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>


<tr><td colspan=2 class="button navy gradient">Academics</td></tr>
	<tr>
	<td align=center colspan=2>
	<table width="90%">
		<tr>
			<td class="button1 navy gradient" width='10%'>Qual. Exam</td>
			<td class="button1 navy gradient" width='20%'>School</td>
			<td class="button1 navy gradient" width='10%'>Board</td>
			<td class="button1 navy gradient" width='10%'>Regn No</td>
			<td class="button1 navy gradient" width='20%'>Year Of Passing<br>YYYY</td>
			<td class="button1 navy gradient" width='10%'>Marks</td>
			<td class="button1 navy gradient" width='10%'>Out of</td>
		</tr>
		<tr>
			<td width='10%'><b>SSLC/10th</b></td>
			<td width='20%'><input type="text" size=25  maxlength=30 id="sslc_school" name="sslc_school" value="<%=sslc_school%>"  class="required"/></td>
			<input type="hidden" id="sslc_city" name="sslc_city" value="" /></td>
			<td width='10%' nowrap valign="middle">
			<select id="sslc_board" name="sslc_board" class="required" STYLE="width: 210px">
			<option value="">Select board</option>
			<%
			for (int k=0; k< alBoardCode.size() ; k++)
			{
				%>
				<option value="<%=alBoardCode.get(k) %>"><%=alBoardName.get(k) %></option>
				<%
			}
				%>
		</select>
			</td>
			<td width='10%'><input type="text" size=10  maxlength=20 id="sslc_regn_no" name="sslc_regn_no" value="<%=sslc_regn_no%>"  class="required"/></td>
			<td width='20%'><input type="text" size=15  maxlength=7 id="sslc_mon_yop" name="sslc_mon_yop" value="<%=sslc_mon_yop%>"  class="required"/></td>
			<td width='10%'><input type="text" size=8  maxlength=4 id="sslc_marks" name="sslc_marks" value="<%=sslc_marks%>"  class="required number"/></td>
			<td width='10%'><input type="text" size=8  maxlength=4 id="sslc_outof" name="sslc_outof" value="<%=sslc_outof%>"  class="required number"/></td>
		</tr>
		<tr>
			<td width='10%'><b>HSC/12th</b></td>
			<td width='20%'><input type="text" size=25 maxlength=30  id="hsc_school" name="hsc_school" value="<%=hsc_school%>"  class="required" /></td>
			<input type="hidden" id="hsc_city" name="hsc_city" value="">
			<td>
			<select id="hsc_board" name="hsc_board" class="required" STYLE="width: 210px">
			<option value="">Select board</option>
			<%
			for (int k=0; k< alBoardCode.size() ; k++)
			{
				%>
				<option value="<%=alBoardCode.get(k) %>"><%=alBoardName.get(k) %></option>
				<%
			}
				%>
		</select>
			</td>
			<td width='10%'><input type="text" size=10  maxlength=20 id="hsc_regn_no" name="hsc_regn_no" value="<%=hsc_regn_no%>"   class="required"/></td>
			<td width='20%'><input type="text" size=15  maxlength=7 id="hsc_mon_yop" name="hsc_mon_yop" value="<%=hsc_mon_yop%>"  class="required"/></td>
			<td width='10%'><input type="text" size=8  maxlength=4 id="hsc_marks" name="hsc_marks" value="<%=hsc_marks%>"  /></td>
			<td width='10%'><input type="text" size=8  maxlength=4 id="hsc_outof" name="hsc_outof" value="<%=hsc_outof%>"  /></td>
		</tr>
	</table>
	</td>
	</tr>

<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td align=center colspan=2>
			<table id='xxx'  width=90% >
			<tr  id='div_academics_head'>
				<td id='ahead1' class="button1 navy gradient" width='10%'>Qualifying Exam</td>
				<td id='ahead2' class="button1 navy gradient" width='20%'>College</td>
				<td id='ahead4' class="button1 navy gradient" width='10%'>University</td>
				<td id='ahead5' class="button1 navy gradient" width='10%'>Regn No</td>
				<td id='ahead6' class="button1 navy gradient" width='20%'>Year Of passing<br>(YYYY)</td>
				<td id='ahead7' class="button1 navy gradient" width='10%'>Marks</td>
				<td id='ahead8' class="button1 navy gradient" width='10%'>Out of</td>
			</tr>
			<tr id='div_academics_1'>
			<td><input id="oth_exam_1" type="text" size=10  maxlength=20 name="oth_exam_1" value="<%=oth_exam_1%>"/></td>
			<td><input id="oth_college_1" type="text" size=20  maxlength=20 name="oth_college_1"  value="<%=oth_college_1%>"/></td>
			<input id="oth_city_1" type="hidden" name="oth_city_1"  value=""/>
			<td><input id="oth_university_1" type="text" size=15 name="oth_university_1"  maxlength=20 value="<%=oth_university_1%>" /></td>
			<td><input type="text" size=10 id="oth_regn_no_1" name="oth_regn_no_1"  maxlength=20 value="<%=oth_regn_no_1%>"/></td>
			<td><input type="text" size=15 id="oth_mon_yop_1" name="oth_mon_yop_1"  maxlength=7 value="<%=oth_mon_yop_1%>" /></td>
			<td><input type="text" size=8 id="oth_marks_1" name="oth_marks_1"  maxlength=4 value="<%=oth_marks_1%>" /></td>
			<td><input type="text" size=8 id="oth_outof_1" name="oth_outof_1"  maxlength=4 value="<%=oth_outof_1%>" /></td>
			</tr>
			<tr id='div_academics_2'>
			<td  width='10%'><input type="text" id="oth_exam_2"  size=10  maxlength=20 name="oth_exam_2" value="<%=oth_exam_2%>"/></td>
			<td  width='20%'><input type="text" id="oth_college_2" size=20  maxlength=20 name="oth_college_2"  value="<%=oth_college_2%>"/></td>
			<input type="hidden" id="oth_city_2" name="oth_city_2"  value=""/></td>
			<td  width='10%'><input type="text" id="oth_university_2"  size=15  maxlength=30 name="oth_university_2" value="<%=oth_university_2%>" /></td>
			<td  width='10%'><input type="text" size=10  maxlength=20 id="oth_regn_no_2" name="oth_regn_no_2" value="<%=oth_regn_no_2%>"/></td>
			<td  width='20%'><input type="text" size=15  maxlength=7 id="oth_mon_yop_2" name="oth_mon_yop_2" value="<%=oth_mon_yop_2%>" /></td>
			<td  width='10%'><input type="text" size=8  maxlength=4 id="oth_marks_2" name="oth_marks_2" value="<%=oth_marks_2%>" /></td>
			<td  width='10%'><input type="text" size=8  maxlength=4 id="oth_outof_2" name="oth_outof_2" value="<%=oth_outof_2%>" /></td>
			</tr>
			<tr id='div_academics_3'>
			<td  width='10%'><input type="text" id="oth_exam_3" size=10  maxlength=20 name="oth_exam_3" value="<%=oth_exam_3%>"/></td>
			<td  width='20%'><input type="text" id="oth_college_3"  size=20  maxlength=20 name="oth_college_3"  value="<%=oth_college_3%>"/></td>
			<input type="hidden" id="oth_city_3" name="oth_city_3"  value=""/></td>
			<td  width='10%'><input type="text" id="oth_university_3"   maxlength=20 size=15 name="oth_university_3" value="<%=oth_university_3%>" /></td>
			<td  width='10%'><input type="text" size=10  maxlength=20 id="oth_regn_no_3" name="oth_regn_no_3" value="<%=oth_regn_no_3%>"/></td>
			<td  width='20%'><input type="text" size=15  maxlength=4 id="oth_mon_yop_3" name="oth_mon_yop_3" value="<%=oth_mon_yop_3%>" /></td>
			<td  width='10%'><input type="text" size=8  maxlength=4 id="oth_marks_3" name="oth_marks_3" value="<%=oth_marks_3%>" /></td>
			<td  width='10%'><input type="text" size=8  maxlength=4 id="oth_outof_3" name="oth_outof_3" value="<%=oth_outof_3%>" /></td>
			</tr>
			</table>
		</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>

<tr><td colspan=2 class="button navy gradient">Miscellaneous</td></tr>
    <tr>
		<td>Hostel / Transportation?</td>
		<td>
		<input type="radio" name="hostel_reqd" value="Y" >Yes</input>
		<input type="radio" name="hostel_reqd" value="N">No</input>
		</td>

	</tr>
		<td>
		<input type="hidden" id="transport_reqd" name="transport_reqd" value="NA"></input>
		
		</td>
	
	<tr>
		<td>Examination preferred</td>
		<td>
 <select id="exam_pref" name="exam_pref" STYLE="width: 210px">
			<option value="">Select</option>
			<option value="W">Written</option>
			<option value="O">Online</option>
		</select> 
		
		</td>
	</tr>
	<tr>
		<td>Test City Centre</td>
		<td>
 <select id="city_centre" name="city_centre" STYLE="width: 210px">
			<option value="">Select centre</option>
			<%
			for (int k=0; k< alCentre_code.size() ; k++)
			{
				%>
				<option value="<%=alCentre_code.get(k) %>"><%=alCentre.get(k) %></option>
				<%
			}
				%>
			
		</select>		
		</td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2 class="button navy gradient">Application Fee</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2>You can either pay the fee online or by Cash / DD directly in the college</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<input name="appfee_flag" id="appfee_flag" type="hidden" value="S"/>
	<!-- <tr>
		<td>Payment Mode</td>
		<td>
		<select name="appfee_flag" id="appfee_flag" onChange='javascript:setPaymentMode()'>
			<option value="" selected>Select Payment Mode</option>
			<option value="CASH">Cash</option>
			<option value="DD">Demand Draft</option>
			<option value="ONLINE">Online Payment</option>
		</select>
		</td>
	</tr>
					<tr>
						<td colspan=2>
						<table>
						<tr>
						<td>
							 <div id='cash_pay'>
							<table>
							<tr>
							<td>Cash Receipt No</td>
							<td><input id="appfee_rcp_no" name="appfee_rcp_no" value="" /></td>
							</tr>
							</table>
							</div>

							<div id='dd_pay'>
							<table>
							<tr>
								<td>DD Number</td>
								<td><input id="dd_number" name="dd_number" value="<%=dd_number%>" /></td>
								<td>Drawn On</td>
								<td><input type="text" id="dd_date" value="" readonly="readonly" name="dd_date"/></td>
							</tr>
							<tr>
								<td>Drawee Bank</td>
								<td><input id="drawee_bank" name="drawee_bank" value="<%=drawee_bank%>" /></td>
								<td>Amount</td>
								<td><input id="amount" name="amount"  value="<%=amount%>"/></td>
							</tr>
							</table>
							</div>
                     

						</td>
					</tr>
					</table>
					</td>
					</tr> -->
				<!-- <tr>
					<td colspan=4><i><b>Admission Fee</b></i></td>
				</tr>
				  <tr>
						<td>DD Number</td>
						<td><input id="adm_dd_number" name="adm_dd_number" class="nm"/></td>
						<td>Drawn On</td>
						<td><input id="adm_dd_date" id="adm_dd_date"  class="nm"/></td>
					</tr>
					<tr>
						<td>Drawee Bank</td>
						<td><input id="adm_drawee_bank" name="adm_drawee_bank"  class="nm"/></td>
						<td>Amount</td>
						<td><input id="adm_amount" name="adm_amount"   class="nm" /></td>
					</tr> -->
					<tr>
					<td colspan=2>* Your Application will be accepted only upon realisation of the money.  Till such time it will not be considered for enrollment.
					</td>
					</tr>
				<%  if(role.intern()=="ADMIN".intern() && flag.intern()=="A".intern()) { %>
					<tr><td colspan=2 class="button navy gradient">Admission</td></tr>
					<div>
					<!-- <legend>Admission</legend> -->
					<table>
					<tr><td colspan=2>&nbsp;</td></tr>
					<tr>
						<td>Course Admitted</td>
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
						<td>Admitted Branch</td>
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
						<td>Section</td>
						<td><select name="section" id="section">
							<option value="A">A</option>
							<option value="B">B</option>
							<option value="C">C</option>
							<option value="D">D</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>Registration No</td>
						<td><input id="regn_no" name="regn_no" /></td>
					</tr>
					<tr>
						<td>Hostel Room Allocated</td>
						<td><input id="hostel_room" name="hostel_room"  /></td>
					</tr>
					<tr>
						<td>Boarding Point</td>
						<td><input id="trn_board_point" name="trn_board_point"  /></td>
					</tr>
					<tr>
						<td>Documents Collected</td>
						<td>
						<input type="checkbox" name="ssl_marks" id="ssl_marks" value='SSLCM'>&nbsp;SSLC Marksheet&nbsp;
						<input type="checkbox" name="hsc_marks" id="hsc_marks" value='HSCM'>&nbsp;HSC Marksheet&nbsp;
						<input type="checkbox" name="conduct_cert" id="conduct_cert"  value='CONC'>&nbsp;Conduct Certificate
						</td>
					</tr>
					<tr>
						<td>Remarks</td>
						<td><input id="adm_remarks" name="adm_remarks" value="" /></td>
					</tr>
					<tr>
					<td colspan=2>&nbsp;</td>
					</tr>
					</table>
					</div>
				<% 	} %>
	<!-- <tr>
	<td colspan=2>&nbsp;</td>
	</tr> -->
<!-- Footer -->
<tr>
 <td colspan=2>
     <div id="divLoading" style="position:relative; text-align:center; vertical-align:middle; display:none;">
	 <img id="imgloading" src="images/loading.gif"  alt="loading..."  style="position:absolute;"/>
	 </div>
 &nbsp;</td>
</tr>
</table>
</form>
<table id="maintab2" class="formtab textbox_medium tbl_p3 textarea_normal " >
<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2 class="button navy gradient">Photo & Signature</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td colspan=2>
			<form action="UpdatePhotoResult2.jsp" method="post" enctype="multipart/form-data" name="imageform" id="imageform"> 
			<input type="hidden" id="student_id" name="student_id" value="<%=userID%>">
			Upload Photo&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" class="required" name="updatePhotoFile" size="20" value="Upload Photo" id="updatePhotoFile" class='rounded-corners' />
			</form>
			<div id='photopreview'></div>
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<form action="UpdateSignatureResult.jsp" method="post" enctype="multipart/form-data" name="signatureform" id="signatureform"> 
			<input type="hidden" id="student_id" name="student_id" value="<%=userID%>">
			Upload Signature&nbsp;<font color="red">*</font>&nbsp;&nbsp;<input type="file" class="required" name="updateSignFile" size="20" value="Upload Signature" id="updateSignFile" class='rounded-corners' />
			</form>
			<div id='signpreview'></div>
		</td>
	</tr>	
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
			<tr>
				<td colspan=2 align=left>
				<input type='checkbox' id='chkonline'/>&nbsp;Please accept the <a href="javascript:window.open('OnlinePaymentTandC.jsp')">Terms & Conditions</a> before you can make the online payment
				</td>
		</tr>
		<tr><td colspan=2 align=left>&nbsp;</td></tr>
	<tr>
				<td colspan=2 align=right>
							<%
							role=(String)session.getAttribute("role"); 
							if(role.intern()=="ADMIN".intern()) {
								if(flag.intern()=="A".intern()) {
							%>
								<input type="button" class="clickButton" value="Admit Student" onClick="javascript:admitStudent()"/>&nbsp;&nbsp;&nbsp;
								<input type="button" class="clickButton" value="Reject Student" onClick="javascript:rejectStudent()"/>
							 <%
								} else  {
							  %>	
					<!--  <input type="button" class="clickButton" value="Submit Application" onClick="javascript:submitApp('O')"/>   &nbsp;&nbsp;&nbsp; -->
								 <input type="button" class="clickButton" value="Submit Application & Pay Online" onClick="javascript:submitApp('O')"/> 
								<%
								} 
								} else { 
								if(appn_status.intern()=="A".intern() || appn_status.intern()=="S".intern() ) {
									String dispMessage=(appn_status.intern()=="A".intern())?"Your application is already approved.":"You have already submitted the application. Please check the approval status later.";
									System.out.println(dispMessage);
									%>
									<button id="registerButton" type="button"><%=dispMessage%></button>&nbsp;&nbsp;&nbsp;
							<%} else { %>
						<!--  		<input type="button" class="clickButton" value="Submit Application" onClick="javascript:submitApp('O')"/>&nbsp;&nbsp;&nbsp;  -->
								<!-- <input type="button" class="saveButton" value="Save Application & Pay later" onClick='javascript:saveApp()'/>&nbsp;&nbsp;&nbsp; -->
								 <input type="button" class="clickButton" value="Submit Application & Pay Online" onClick="javascript:submitApp('O')"/> 
							<% } 
								}
							%>
							</td>
	</tr>


	<tr><td colspan=2>&nbsp;</td></tr>

<form name='payform' id='payform' action="https://www.billdesk.com/pgidsk/PGIMerchantPayment" method="POST">
<input type="hidden" name="msg" id="msg"/>
</form>
	
	</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
<%@include file="ToolTip.jsp" %>
  <div id="dialog-message" style="display:none;" title="Message"><p id="diaMsg" style="width:auto;"></p></div>
 
</body>
</html>