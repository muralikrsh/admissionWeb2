<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String strRole=(String)session.getAttribute("role"); 
String strId=(String)session.getAttribute("login_id"); 
ArrayList alStates=(ArrayList)application.getAttribute("STATES");

Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;

ArrayList alCourses=null;

ArrayList alMain=new ArrayList();
ArrayList alCourseGroup=new ArrayList();
ArrayList alCourseID=new ArrayList();
ArrayList alCourseName=new ArrayList();
ArrayList alCourseType=new ArrayList();

String update="Update";
String strFromDate="";
String strToDate="";
String strAdmsnNo="";
String strApplnNo="";
String strFlag=null;
String appnNos="";

String strState="";
String strGender="";
String strCourse="";
String strStudentType="";
String strBranch="";
String strCommunity="";
String strAdmissionQuota="";
String strConcessionType="";
String strTutionFeeFrom="";
String strTutionFeeTo="";
String strInsertedBy="";
String strReference="";

int i=0;
try {
	con=ConnectDatabase.getConnection();
	
	pst=con.prepareStatement("SELECT course_group, course_id, course_name, course_type from course where course_flag='A' order by course_name");
	rs=pst.executeQuery();
	alCourses=new ArrayList();

	while(rs.next()) 
	{
		alCourseGroup.add(rs.getString(1));
		alCourseID.add(rs.getString(2));
		alCourseName.add(rs.getString(3));
		alCourseType.add(rs.getString(4));
		alCourses.add( rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3)+"#"+rs.getString(4));
	}
	
	strAdmsnNo=request.getParameter("admNo");
	strApplnNo=request.getParameter("appn_no");

	strFromDate=request.getParameter("from_date");
	strToDate=request.getParameter("to_date");

	strState=request.getParameter("state");
	strGender=request.getParameter("gender");

	strCourse=request.getParameter("course");
	strBranch=request.getParameter("branch");

	strStudentType=request.getParameter("studentType");
	strCommunity=request.getParameter("community");

	strAdmissionQuota=request.getParameter("admQuota");
	strConcessionType=request.getParameter("concessionType");

	strTutionFeeFrom=request.getParameter("tuitionFeeFrom");
	strTutionFeeTo=request.getParameter("tuitionFeeTo");

	strInsertedBy=request.getParameter("insertedBy")+"%";
	strReference=request.getParameter("reference");
	
	strFlag=request.getParameter("flag");
	
	System.out.println("strInsertedBy ->"+strInsertedBy);
	
	if(strAdmsnNo==null)  strAdmsnNo="";
	if(strApplnNo==null)  strApplnNo="";

	if(strFromDate==null)  strFromDate="";
	if(strToDate==null)  strToDate="";

	if(strState==null)  strState="";
	if(strGender==null)  strGender="";

	if(strCourse==null)  strCourse="";
	if(strBranch==null)  strBranch="";

	if(strStudentType==null)  strStudentType="";
	if(strCommunity==null)  strCommunity="";

	if(strAdmissionQuota==null)  strAdmissionQuota="";
	if(strConcessionType==null)  strConcessionType="";

	if(strTutionFeeFrom==null)  strTutionFeeFrom="";
	if(strTutionFeeTo==null)  strTutionFeeTo="";

	if(strInsertedBy==null)  strInsertedBy="";
	if(strReference==null)  strReference="";
	
	if(strFlag!=null) {

		String where_clause="";
		
		System.out.println("0 ->"+where_clause);
		if(strAdmsnNo.intern()!="".intern()) {
			where_clause=" binary full_adm_no=?";
		}
		System.out.println("1 ->"+where_clause);
		if(strApplnNo.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary appn_no=?";
			else
				where_clause+=" and binary appn_no=?";
		}
		System.out.println("2 ->"+where_clause);
		if(strState.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" state=?";
			else
				where_clause+=" and state=?";
		}
		System.out.println("3 ->"+where_clause);
		if(strGender.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" gender=?";
			else
				where_clause+=" and gender=?";
		}
		System.out.println("4 ->"+where_clause);
		if(strCourse.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" course=?";
			else
				where_clause+=" and course=?";
		}
		System.out.println("5 ->"+where_clause);
		if(strBranch.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" branch=?";
			else
				where_clause+=" and branch=?";
		}
		System.out.println("6 ->"+where_clause);
		if(strStudentType.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" student_type=?";
			else
				where_clause+=" and student_type=?";
		}
		System.out.println("7 ->"+where_clause);
		if(strCommunity.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" community=?";
			else
				where_clause+=" and community=?";
		}
		System.out.println("8 ->"+where_clause);
		if(strAdmissionQuota.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" adm_quota=?";
			else
				where_clause+=" and adm_quota=?";
		}
		System.out.println("9 ->"+where_clause);
		if(strConcessionType.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" concession_type=?";
			else
				where_clause+=" and concession_type=?";
		}
		System.out.println("10 ->"+where_clause);
		if(strFromDate.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" app_date between adddate(str_to_date(?,'%m/%d/%Y'), interval -1 day) and adddate(str_to_date(?,'%m/%d/%Y'), interval 1 day)";
			else
				where_clause+=" and app_date between adddate(str_to_date(?,'%m/%d/%Y'), interval -1 day) and adddate(str_to_date(?,'%m/%d/%Y'), interval 1 day)";
		}
		System.out.println("11 ->"+where_clause);
		if(strTutionFeeFrom.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" (cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)>=?";
			else
				where_clause+=" and (cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)>=?";
		}
		System.out.println("12 ->"+where_clause);
		if(strTutionFeeTo.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" (cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)<=?";
			else
				where_clause+=" and (cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)<=?";
		}
		System.out.println("13 ->"+where_clause);
		if(strReference.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" reference=?";
			else
				where_clause+=" and reference=?";
		}
		System.out.println("14 ->"+where_clause);
		if(strInsertedBy.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause="inserted_by LIKE ?";
			else
				where_clause+=" and inserted_by LIKE ?";
		}
		System.out.println("15 ->"+where_clause);
		if(where_clause.intern()!="".intern())  {
				where_clause=" where "+where_clause;
		}
		pst=con.prepareStatement("SELECT full_adm_no, stu_name, state, adm_quota, course, DATE_FORMAT(app_date,'%d %b %Y') AS app_date, gender, reference,(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4) as tot_paid, (cash_amount_1+challan_amount_1+dd_amount_1) AS amount_1, (cash_amount_2+challan_amount_2+dd_amount_2) AS amount_2, (cash_amount_3+challan_amount_3+dd_amount_3) AS amount_3, (cash_amount_4+challan_amount_4+dd_amount_4) AS amount_4, fixed_tuition_fee-total_paid-concession_amt AS deficit, CONCAT('Cas-',cash_receipt_no_1) AS ca_1, CONCAT('Chal-',challan_no_1) AS ch_1, CONCAT('DD-',dd_receipt_no_1) AS dd_1, CONCAT('Cas-',cash_receipt_no_2) AS ca_2, CONCAT('Chal-',challan_no_2) AS ch_2, CONCAT('DD-',dd_receipt_no_2) AS dd_2, CONCAT('Cas-',cash_receipt_no_3) AS ca_3, CONCAT('Chal-',challan_no_3) AS ch_3, CONCAT('DD-',dd_receipt_no_3) AS dd_3, CONCAT('Cas-',cash_receipt_no_4) AS ca_4, CONCAT('Chal-',challan_no_4) AS ch_4, CONCAT('DD-',dd_receipt_no_4) AS dd_4 FROM student_admission "+where_clause+" ");
		System.out.println("before pst ->"+pst);
		int ctr=0;
		
		if(where_clause.indexOf("full_adm_no")!= -1) {
			pst.setString(++ctr, strAdmsnNo);
		}
		if(where_clause.indexOf("appn_no")!= -1) {
			pst.setString(++ctr, strApplnNo);
		}
		if(where_clause.indexOf("state")!= -1) {
			pst.setString(++ctr, strState);
		}
		if(where_clause.indexOf("gender")!= -1) {
			pst.setString(++ctr, strGender);
		}
		if(where_clause.indexOf("course")!= -1) {
			pst.setString(++ctr, strCourse);
		}
		if(where_clause.indexOf("branch")!= -1) {
			pst.setString(++ctr, strBranch);
		}
		if(where_clause.indexOf("student_type")!= -1) {
			pst.setString(++ctr, strStudentType);
		}
		if(where_clause.indexOf("community")!= -1) {
			pst.setString(++ctr, strCommunity);
		}
		if(where_clause.indexOf("adm_quota")!= -1) {
			pst.setString(++ctr, strAdmissionQuota);
		}
		if(where_clause.indexOf("concession_type")!= -1) {
			pst.setString(++ctr, strConcessionType);
		}		
		if(where_clause.indexOf("between")!= -1) {
			pst.setString(++ctr, strFromDate);
			pst.setString(++ctr, strToDate);
		}
		if(where_clause.indexOf("(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)>")!= -1) {
			pst.setString(++ctr, strTutionFeeFrom);
		}
		if(where_clause.indexOf("(cash_amount_1+dd_amount_1+chal_recd_amt_1+cash_amount_2+dd_amount_2+chal_recd_amt_2+cash_amount_3+dd_amount_3+chal_recd_amt_3+cash_amount_4+dd_amount_4+chal_recd_amt_4)<")!= -1) {
			pst.setString(++ctr, strTutionFeeTo);
		}
		if(where_clause.indexOf("reference")!= -1) {
			pst.setString(++ctr, strReference);
		}
		if(where_clause.indexOf("inserted_by")!= -1) {
			System.out.println("strInsertedBy1= "+strInsertedBy);
			try{
			pst.setString(++ctr, strInsertedBy);
			}
			catch(Exception e){System.out.println(e);}
			System.out.println("strInsertedBy2= "+strInsertedBy);
		}
		if(strFromDate.intern()=="01/01/1900".intern()) {
			strFromDate="";
			strToDate="";
		}
		System.out.println("Admission Report :: "+pst);
		rs=pst.executeQuery();
		while(rs.next()) {
			ArrayList alSub=new ArrayList();
			alSub.add(rs.getString("full_adm_no")); // adm_no
			alSub.add(rs.getString("stu_name")); // name
			alSub.add(rs.getString("app_date")); // Submission Date
			alSub.add(rs.getString("gender")); // Gender
			alSub.add(rs.getString("state")); // State
			alSub.add(rs.getString("adm_quota")); // Adm_Quota
			alSub.add(rs.getString("course")); // course
			alSub.add(rs.getString("tot_paid")); // total_paid
			alSub.add(rs.getString("amount_1")); // amount_1
			alSub.add(rs.getString("amount_2")); // amount_2
			alSub.add(rs.getString("amount_3")); // amount_3
			alSub.add(rs.getString("amount_4")); // amount_4
			alSub.add(rs.getString("deficit")); // deficit
			alSub.add(rs.getString("ca_1")); // ca_1
			alSub.add(rs.getString("ch_1")); // ch_1
			alSub.add(rs.getString("dd_1")); // dd_1
			alSub.add(rs.getString("ca_2")); // ca_2
			alSub.add(rs.getString("ch_2")); // ch_2
			alSub.add(rs.getString("dd_2")); // dd_2
			alSub.add(rs.getString("ca_3")); // ca_3
			alSub.add(rs.getString("ch_3")); // ch_3
			alSub.add(rs.getString("dd_3")); // dd_3
			alSub.add(rs.getString("ca_4")); // ca_4
			alSub.add(rs.getString("ch_4")); // ch_4
			alSub.add(rs.getString("dd_4")); // dd_4
			
			alMain.add(alSub);
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
<title>Admission Report</title>
	<head>
	<meta charset="utf-8">
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="css/demo_table.css" rel="stylesheet" >
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css"  />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.dataTables.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>


		<script type="text/javascript" charset="utf-8">
		function loadCourseData()
		{
			var getCourseGroup=[];
			var getCourseList=[];
			var getCourseID=[];
			var getCourseType=[];
			var getCourseName=[];

			var getCourse=document.getElementById("course").value;

			<% for(int k=0;k<alCourseGroup.size();k++) { %>
			getCourseGroup.push("<%= alCourseGroup.get(k)%>")
			<% } %>

			<% for(int k=0;k<alCourseType.size();k++) { %>
			getCourseType.push("<%= alCourseType.get(k)%>")
			<% } %>

			<% for(int k=0;k<alCourseName.size();k++) { %>
			getCourseName.push("<%= alCourseName.get(k)%>")
			<% } %>

			for(var k=0;k<getCourseGroup.length;k++)
			{
			if(getCourseGroup[k]==getCourse)
			{
				getCourseID.push(getCourseType[k]);
				getCourseList.push(getCourseName[k]);
			}
			}
			document.formReport.branch.options.length=0
			for(var k=0;k<=getCourseID.length;k++)
			{
				document.formReport.branch.options[k]=new Option(getCourseList[k],getCourseList[k],false,false); // new Option(getCentre[k],getCentreCode[k],false,false) to new Option(getCentre[k],getCentre[k],false,false) by Alex on 2.4.2015
			}
			}
		
		$(function() {
			$( "#from_date" ).datepicker();
			$( "#to_date" ).datepicker();
		});

			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
				String strTotalPaid=(String)alSub.get(12);
				String strAmount1=(String)alSub.get(8);
				String strAmount2=(String)alSub.get(9);
				String strAmount3=(String)alSub.get(10);
				String strAmount4=(String)alSub.get(11);
			%>
				aDataSet[<%=i%>]=new Array(8);
			<%
				if(appnNos.intern()=="".intern()) {
					appnNos=alSub.get(0).toString();
				} else {
					appnNos+=","+alSub.get(0).toString();
				}
				%>
				aDataSet[<%=i%>][0]='<a href="StudentApplication.jsp?appn_no=<%=alSub.get(0)%>&flag=U"><%=alSub.get(0)%></a>&nbsp;<a href="AdmissionForm.jsp?appn_no=<%=alSub.get(0)%>&flag=U">EDIT</a>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][5]='<%=alSub.get(5)%>';
				aDataSet[<%=i%>][6]='<%=alSub.get(6)%>';
				aDataSet[<%=i%>][7]='<%=alSub.get(7)%>';
				
				<%
				double feeAmount1=Double.parseDouble(strAmount1);
				if(strTotalPaid.equals("0.00") || !strAmount1.equals("0.00")){
					if(feeAmount1==0.0){
					%>
						aDataSet[<%=i%>][8]='<%=feeAmount1%>';
					<%
					}
					else
					{
					%>
						aDataSet[<%=i%>][8]='<u><strong><a href="PaymentReport.jsp?appn_no=<%=alSub.get(0)%>&flag=1"><%=alSub.get(8)%><a/></strong></u>/<br /><%=alSub.get(13)%>/<br /><%=alSub.get(14)%>/<br /><%=alSub.get(15)%>';
					<%
					}
				}
				else
				{
				%>
					aDataSet[<%=i%>][8]='<a href="UpdatePayment.jsp?appn_no=<%=alSub.get(0)%>&flag=1"/><%=update%>';
				<%
				}
				%>

				<%
				double feeAmount2=Double.parseDouble(strAmount2);
				if(strTotalPaid.equals("0.00") || !strAmount2.equals("0.00")){
					if(feeAmount2==0.0){
					%>
						aDataSet[<%=i%>][9]='<%=feeAmount2%>';
					<%
					}
					else
					{
					%>
						aDataSet[<%=i%>][9]='<u><strong><a href="PaymentReport.jsp?appn_no=<%=alSub.get(0)%>&flag=2"><%=alSub.get(9)%><a/></strong></u>/<br /><%=alSub.get(16)%>/<br /><%=alSub.get(17)%>/<br /><%=alSub.get(18)%>';
					<%
					}
				}
				else
				{
				%>
					aDataSet[<%=i%>][9]='<a href="UpdatePayment.jsp?appn_no=<%=alSub.get(0)%>&flag=2"/><%=update%>';
				<%
				}
				%>
								
				<%
				double feeAmount3=Double.parseDouble(strAmount3);
				if(strTotalPaid.equals("0.00") || !strAmount3.equals("0.00")){
					if(feeAmount3==0.0){
					%>
						aDataSet[<%=i%>][10]='<%=feeAmount3%>';
					<%
					}
					else
					{
					%>
						aDataSet[<%=i%>][10]='<u><strong><a href="PaymentReport.jsp?appn_no=<%=alSub.get(0)%>&flag=3"><%=alSub.get(10)%><a/></strong></u>/<br /><%=alSub.get(19)%>/<br /><%=alSub.get(20)%>/<br /><%=alSub.get(21)%>';
					<%					
					}
				}
				else
				{
				%>
					aDataSet[<%=i%>][10]='<a href="UpdatePayment.jsp?appn_no=<%=alSub.get(0)%>&flag=3"/><%=update%>';
				<%
				}
				%>
				
				<%
				double feeAmount4=Double.parseDouble(strAmount4);
				if(strTotalPaid.equals("0.00") || !strAmount4.equals("0.00")){
					if(feeAmount4==0.0){
					%>
						aDataSet[<%=i%>][11]='<%=feeAmount4%>';
					<%
					}
					else
					{
					%>
						aDataSet[<%=i%>][11]='<u><strong><a href="PaymentReport.jsp?appn_no=<%=alSub.get(0)%>&flag=4"><%=alSub.get(11)%><a/></strong></u>/<br /><%=alSub.get(22)%>/<br /><%=alSub.get(23)%>/<br /><%=alSub.get(24)%>';
					<%
					}
				}
				else
				{
				%>
					aDataSet[<%=i%>][11]='<a href="UpdatePayment.jsp?appn_no=<%=alSub.get(0)%>&flag=4"><%=update%>';
				<%
				}
				%>

			<%
			}
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Admission No" },
						{ "sTitle": "Name" },
						{ "sTitle": "App Date" },
						{ "sTitle": "Gender" },
						{ "sTitle": "State" },
						{ "sTitle": "Quota" },
						{ "sTitle": "Course" },
						{ "sTitle": "Total Paid" },
						{ "sTitle": "1st Payment" },
						{ "sTitle": "2nd Payment" },
						{ "sTitle": "3rd Payment" },
						{ "sTitle": "4th Payment" },
					]
				} );	
			} );

			function getSearchData() {
				location.href='AdmissionReport.jsp?from_date='+document.getElementById("from_date").value+
				'&to_date='+document.getElementById("to_date").value+
				'&appn_no='+document.getElementById("appn_no").value+
				'&admNo='+document.getElementById("admNo").value+
				'&state='+document.getElementById("state").value+
				'&gender='+document.getElementById("gender").value+
				'&course='+document.getElementById("course").value+
				'&branch='+document.getElementById("branch").value+
				'&studentType='+document.getElementById("studentType").value+
				'&community='+document.getElementById("community").value+
				'&admQuota='+document.getElementById("admQuota").value+
				'&concessionType='+document.getElementById("concessionType").value+
				'&tuitionFeeFrom='+document.getElementById("tuitionFeeFrom").value+
				'&tuitionFeeTo='+document.getElementById("tuitionFeeTo").value+
				'&insertedBy='+document.getElementById("insertedBy").value+
				'&reference='+document.getElementById("reference").value+
				'&flag=Y';
				//alert(location.href);
				//alert('&insertedBy='+document.getElementById("insertedBy").value);
			}

		function exportExcel() 
		{
			var strURL="servlet/DownloadAdmExcel";
			var parameters="profile_id=<%=appnNos%>";
			strURL+="?"+parameters;
			location.href=strURL;
		}

		$(function() {
			$('#state').val("<%=strState %>");
			$('#gender').val("<%=strGender %>");
			$('#course').val("<%=strCourse %>");
			$('#studentType').val("<%=strStudentType %>");
			$('#community').val("<%=strCommunity %>");
			$('#admQuota').val("<%=strAdmissionQuota %>");
			$('#concessionType').val("<%=strConcessionType %>");
			$('#insertedBy').val("<%=strInsertedBy %>");
			$('#reference').val("<%=strReference %>");
		});
		
	</script>
	<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<div id="formdiv"><BR>
	<form id="formReport" name="formReport">
	<table width="90%" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td colspan=4>
	<tr><td colspan=4 class="button navy gradient">Admission Report</td></tr>
	<tr><td colspan=4>&nbsp;	</td>	</tr>
	<tr>
	<td>Admission No</td>
	<td><input type="text" name="admNo" id="admNo" value="<%=strAdmsnNo%>"/></td>
	<td>Application No</td>
	<td><input type="text" name="appn_no" value="<%=strApplnNo%>"  id="appn_no"/></td>
	</tr>
	</tr>

	<tr>
	<td>From Date</td>
	<td><input type="text" name="from_date" value="<%=strFromDate%>" readonly="readonly" id="from_date"/></td>
	 <td>To Date</td>
	<td><input type="text" name="to_date" value="<%=strToDate%>" readonly="readonly" id="to_date"/></td>
	</tr>

	<tr>
	<td>State</td>
	<td>
	<select name="state" id='state' style="width: 170px">
				<option value="">Select</option>
				<%
				for(i =0;i<alStates.size(); i++) {
					%>
						<option value="<%=alStates.get(i)%>"><%=alStates.get(i)%></option>
					<%  
				}			
				%>
	</select>
	</td>
	<td>Gender</td>
	<td><select name="gender" id='gender' style="width: 170px">
				<option value="">Select</option>
				<option value="Male">Male</option>
				<option value="Female">Female</option>
				<option value="Others">Others</option>
	</select></td>
	</tr>

	<tr>	
	<td>Course</td>
	<td>
	<select id="course" class="required" onChange='javascript:loadCourseData()' STYLE="width: 170px">
	
		<option value="">Select</option>
		<option value="B.Tech">B.Tech</option>
		<option value="B.Arch">B.Arch</option>
		<option value="BA">BA</option>
		<option value="B.Sc">B.Sc</option>
		<option value="B.Com">B.Com</option>
		<option value="BBA">BBA</option>
		<option value="BCA">BCA</option>
		<option value="M.Tech">M.Tech</option>
		<option value="M.Sc">M.Sc</option>
		<option value="MCA">MCA</option>
		<option value="MBA">MBA</option>
	</select>
	</td>
		<td>Branch</td>
		<td>
		<select id="branch" name="branch" STYLE="width: 170px">
			<option value="">Select a Course</option>
		</select>
		</td>
	</tr>

	<tr>
		<td>Student Type</td>
		<td>
		<select id="studentType" name="studentType" STYLE="width: 170px">
			<option value="">Select</option>
			<option value="FRESH">Full Time/Fresh</option>
			<option value="LATERAL">Lateral</option>
			<option value="PART_TIME">Part Time</option>
		</select>
		</td>
		<td>Community</td>
		<td align=left nowrap>
		<select id="community" name="community" STYLE="width: 170px" >
		<option value="">Select Community</option>
		<option value="General">General</option>
		<option value="OBC">OBC</option>
		<option value="SC">SC</option>
		<option value="ST">ST</option>
		</select>
		</td>
	</tr>
	<tr>
		<td class='label'><i><b>Admission Quota</b></i></td>
		<td>
		<select id="admQuota" name="admQuota" STYLE="width: 170px">
			<option value="">Select</option>
			<option value="MANAGEMENT">Management</option>
			<option value="COUNSELLING">Counselling</option>
		</select>
		</td>
		<td class='label'><i><b>Concession Type</b></i></td>
		<td>
		<select id="concessionType" name="concessionType" STYLE="width: 170px">
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
	<td>Tuition Fee - From</td>
	<td><input type="text" name="tuitionFeeFrom" value="<%=strTutionFeeFrom %>" id="tuitionFeeFrom"/></td>
	<td>Tuition Fee - To</td>
	<td><input type="text" name="tuitionFeeTo" value="<%=strTutionFeeTo %>" id="tuitionFeeTo"/></td>
	</tr>
	<tr>
	<td>Admission Made at</td>
	<td>
		<select id="insertedBy" STYLE="width:170px">
			<option value="">Select</option>
			<option value="u_">University</option>
			<option value="c_">Corporate</option>
		</select>
	</td>
	<td>Reference</td>
	<td>
		<select id="reference" STYLE="width:170px">
			<option value="">Select</option>
			<option value="University">University</option>
			<option value="Corporate_Office">Corporate Office</option>
			<option value="Mr.Reddy">Mr.Reddy</option>
			<option value="Others">Others</option>
		</select>
	</td>
	</tr>	
	<tr>
	<td colspan=4 align="right">
	<input type="button" class="clickButton" value="Search" onClick="javascript:getSearchData()"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Export to Excel" onClick="javascript:exportExcel()"/>&nbsp;
	</td>
	</tr>
 	<tr><td colspan=4>&nbsp;</td></tr>
	<%
	if(alMain.size()>0) {
	%>
	<tr>
	
	<td colspan=7>
	<form name='xxx'>
	<div id="container" align='left'>
		<div id="dynamic"></div>
		<div class="spacer"></div>
	</div>
	</form>
	</td>
	</tr>
	<%
	} else {
	%>
	<tr><td colspan=4><BR/><BR/><BR/><BR/><BR/><BR/><BR/></td></tr>
	<%
	}
	%>
	</table>
	</form>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>