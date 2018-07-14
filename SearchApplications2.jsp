<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String strRole=(String)session.getAttribute("role"); 
String strId=(String)session.getAttribute("login_id"); 
ResourceBundle rb=ResourceBundle.getBundle("admission",new Locale("en", "US"));
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String from_date="";
String to_date="";
String course="";
String appn_no="";
String flag=null;
String first_name=null;
String last_name=null;
String state=null;
String city=null;
String appn_status=null;
String appnNos="";
// String opt_sub=null;
int i=0;
ArrayList alCourseID=null; 
ArrayList alCourseName= null; 
ArrayList alStates= null; 
ArrayList alStateID=null; 
ArrayList alStateName= null; 
try {
	con=ConnectDatabase.getConnection();
	course=request.getParameter("course");
	appn_no=request.getParameter("appn_no");
	from_date=request.getParameter("from_date");
	to_date=request.getParameter("to_date");
	flag=request.getParameter("flag");
	first_name=request.getParameter("first_name");
	last_name=request.getParameter("last_name");
	state=request.getParameter("state");
	city=request.getParameter("city");
	appn_status=request.getParameter("appn_status");
	//opt_sub=request.getParameter("opt_sub");


	if(appn_no==null)  appn_no="";
	if(course==null)  course="";
	if(from_date==null)  from_date="";
	if(to_date==null)  to_date="";
	if(first_name==null)  first_name="";
	if(last_name==null)  last_name="";
	if(state==null)  state="";
	if(city==null)  city="";
	if(appn_status==null)  appn_status="";
	// if(opt_sub==null)  opt_sub="";

	alCourseID= new ArrayList();
	alCourseName= new ArrayList();	

	alCourseID.add("B.Tech");
	alCourseID.add("B.Arch");
	alCourseID.add("BA");
	alCourseID.add("B.Sc");
	alCourseID.add("B.Com");
	alCourseID.add("BBA");
	alCourseID.add("BCA");
	alCourseID.add("M.Tech");
	alCourseID.add("MBA");
	alCourseID.add("MCA");
	alCourseID.add("M.Sc");

	alCourseName.add("B.Tech");
	alCourseName.add("B.Arch");
	alCourseName.add("BA");
	alCourseName.add("B.Sc");
	alCourseName.add("B.Com");
	alCourseName.add("BBA");
	alCourseName.add("BCA");
	alCourseName.add("M.Tech");
	alCourseName.add("MBA");
	alCourseName.add("MCA");
	alCourseName.add("M.Sc");

	alStates=(ArrayList)application.getAttribute("STATES");

	if(flag!=null) {

		System.out.println(from_date+":::"+to_date+"::::"+appn_no+"::::"+course+"::::"+first_name+"::::"+last_name+"::::"+state+"....."+city+"....."+appn_status);
		//+"...."+opt_sub
		String where_clause="";
		System.out.println("1 ->"+where_clause);
		if(appn_no.intern()!="".intern()) {
			where_clause=" binary appn_no=?";
		}
		System.out.println("2 ->"+where_clause);
		if(course.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary course=?";
			else 
				where_clause+=" and binary course=?";
		}
		System.out.println("3 ->"+where_clause+"<<<<");
		if(state.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary state=?";
			else
				where_clause+=" and binary state=?";
		}
		System.out.println("4 ->"+where_clause+"<<<<");
		if(first_name.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary first_name like ? ";
			else
				where_clause+=" and binary first_name like ? ";
		}
		
		if(last_name.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary last_name like ? ";
			else
				where_clause+=" and binary last_name like ? ";
		}

		System.out.println("5 ->"+where_clause+"<<<<");
		if(appn_status.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary appn_status = ? ";
			else
				where_clause+=" and binary appn_status = ? ";
		}
		System.out.println("6 ->"+where_clause+"<<<<");
		
		/*
		if(opt_sub.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary optional_subject = ? ";
			else
				where_clause+=" and binary optional_subject = ? ";
		}
		System.out.println("7 ->"+where_clause+"<<<<");
		*/
		if(from_date.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" submission_date between adddate(str_to_date(?,'%m/%d/%Y'), interval -1 day) and adddate(str_to_date(?,'%m/%d/%Y'), interval 1 day)";
			else
				where_clause+=" and submission_date between adddate(str_to_date(?,'%m/%d/%Y'), interval -1 day) and adddate(str_to_date(?,'%m/%d/%Y'), interval 1 day)";
		}

		if(where_clause.intern()!="".intern())  {
			if(strRole.intern()=="STUDENT".intern()) {
				where_clause=" where "+where_clause+" and mkr_id = '"+strId+"'";
			} else {
				where_clause=" where "+where_clause;
			}
		} else {
			if(strRole.intern()=="STUDENT".intern()) {
				where_clause=" where mkr_id = '"+strId+"'";
			}
		}
	
		// Removed religion, community, sslc_marks
		System.out.println("select appn_no, first_name, ifnull(last_name,'') last_name, city, email_id, mobile_no, course, date_format(submission_date,'%d %b %Y'), IF(STRCMP(appn_status,'A')=0,'Approved',(if(STRCMP(appn_status,'R')=0,'Rejected','Submitted'))) from application "+where_clause+" limit 50");
		pst=con.prepareStatement("select appn_no, first_name, ifnull(last_name,'') last_name, city, email_id, mobile_no, course, date_format(submission_date,'%d %b %Y'), IF(STRCMP(appn_status,'A')=0,'Approved',(if(STRCMP(appn_status,'R')=0,'Rejected','Submitted'))) from application "+where_clause+" "); //  limit 50 removed by Alex
		int ctr=0;

		if(where_clause.indexOf("appn_no")!= -1) {
			pst.setString(++ctr, appn_no);
		}
		if(where_clause.indexOf("course")!= -1) {
			pst.setString(++ctr, course);
		}
		if(where_clause.indexOf("state")!= -1) {
			pst.setString(++ctr, state);
		}
		if(where_clause.indexOf("city")!= -1) {
			pst.setString(++ctr, city);
		}
		if(where_clause.indexOf("first_name")!= -1) {
			pst.setString(++ctr, "%"+first_name+"%");
		}
		if(where_clause.indexOf("last_name")!= -1) {
			pst.setString(++ctr, "%"+last_name+"%");
		}
		if(where_clause.indexOf("appn_status")!= -1) {
			pst.setString(++ctr, appn_status);
		}
		/*
		if(where_clause.indexOf("optional_subject")!= -1) {
			pst.setString(++ctr, opt_sub);
		}
		*/
		if(where_clause.indexOf("between")!= -1) {
			pst.setString(++ctr, from_date);
			pst.setString(++ctr, to_date);
		}

		if(from_date.intern()=="01/01/1900".intern()) {
			from_date="";
			to_date="";
		}
		System.out.println(pst);
		rs=pst.executeQuery();
		while(rs.next()) {
			ArrayList alSub=new ArrayList();
			alSub.add(rs.getString(1)); // appn_no
			alSub.add(rs.getString(2)); // first_name
			alSub.add(rs.getString(3)); // last_name
			alSub.add(rs.getString(4)); // city
			alSub.add(rs.getString(5)); // email_id
			alSub.add(rs.getString(6)); // mobile_no
			alSub.add(rs.getString(7)); // course
			alSub.add(rs.getString(8)); // Submission Date
			alSub.add(rs.getString(9)); // status
			alMain.add(alSub);
		}
	}
	//System.out.println(alMain);
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
<title>Search Applications</title>
	<head>
	<meta charset="utf-8">
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="css/demo_table.css" rel="stylesheet" >
    <!-- <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
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
		
		$(function() {
			$( "#from_date" ).datepicker();
			$( "#to_date" ).datepicker();
		});

			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(8);
			<%
				if(appnNos.intern()=="".intern()) {
					appnNos=alSub.get(0).toString();
				} else {
					appnNos+=","+alSub.get(0).toString();
				}
				if(strRole.intern()=="ADMIN".intern()) {
				%>
					aDataSet[<%=i%>][0]='<%=alSub.get(0)%>';
				<%
					} else {
					%>
					aDataSet[<%=i%>][0]='<%=alSub.get(0)%>';
				<%
					}
				%>
				
				aDataSet[<%=i%>][1]='<%=alSub.get(1)+" "+alSub.get(2)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(5)%>';
				aDataSet[<%=i%>][5]='<%=alSub.get(6)%>';
				aDataSet[<%=i%>][6]='<%=alSub.get(7)%>';
				aDataSet[<%=i%>][7]='<%=alSub.get(8)%>';
				
			<%
			}
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Appn No" },
						{ "sTitle": "Candidate Name" },
						{ "sTitle": "City" },
						{ "sTitle": "Email Id" },
						{ "sTitle": "Mobile No" },
						{ "sTitle": "Course" },
						{ "sTitle": "Submission Date" },
						{ "sTitle": "Status" }
					]
				} );	
			} );

			function getSMSData() {
				location.href='SearchApplications2.jsp?from_date='+document.getElementById("from_date").value+
				'&to_date='+document.getElementById("to_date").value+
				'&appn_no='+document.getElementById("appn_no").value+
				'&course='+document.getElementById("course").value+
				'&state='+document.getElementById("state").value+
				'&city='+document.getElementById("city").value+
				'&first_name='+document.getElementById("first_name").value+
				'&last_name='+document.getElementById("last_name").value+
				'&appn_status='+document.getElementById("appn_status").value+
				'&flag=Y';
				// '&opt_sub='+document.getElementById("opt_sub").value+
			}
			function exportExcel() {
				strURL="servlet/DownloadExcel";
				var parameters="profile_id=<%=appnNos%>";
				strURL+="?"+parameters;
				location.href=strURL;
			}
			
		</script>
<%@include file="MBHandler.jsp" %>
	</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<div id="formdiv"><BR>
	<!-- <table class=" valign_top textbox_medium tbl_p5 textarea_normal"> -->
	<table width="90%" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td colspan=4>
	<tr><td colspan=4 class="button navy gradient">Application List</td></tr>
	<tr><td colspan=4>&nbsp;	</td>	</tr>
	<tr>
	 <td>Course Name</td>
	 <td>
		<select name="course" id='course'>
					<option value="">Select</option>
					<%
					for(i =0;i<alCourseID.size(); i++) {
						%>
							<option value="<%=alCourseID.get(i)%>"><%=alCourseName.get(i)%></option>
						<%  
					}			
					%>
		</select>
	 </td>
	 <td>Appn No</td>
	<td><input type="text" name="appn_no" value="<%=appn_no%>"  id="appn_no"/></td>
	 </tr>
	 </tr>

	 <tr>
	 <td>From Date</td>
	<td><input type="text" name="from_date" value="<%=from_date%>" readonly="readonly" id="from_date"/></td>
	 <td>To Date</td>
	<td><input type="text" name="to_date" value="<%=to_date%>" readonly="readonly" id="to_date"/></td>
	</tr>
 
	 <tr>
	 <td>First Name</td>
	<td>
	<input type="text" name="first_name" value="<%=first_name%>" id="first_name"/>
	</td>
	<td>Last Name</td>
	<td>
	<input type="text" name="last_name" value="<%=last_name%>" id="last_name"/>
	</td>
	</tr>
	<tr>

	<td>State</td>
	 <td>
	<select name="state" id='state'>
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
	<td>City</td>
	 <!-- <td class='label'>Optional Subject</td> -->
	 <td>
<input type="text" name="city" value="<%=city%>" id="city"/>	 </td>
	</tr>
	 <tr>
	<td>Appn Status</td>
	 <td>
	<select name="appn_status" id='appn_status'>
				<option value="">Select</option>
				<option value="S">Submitted</option>
				<option value="A">Approved</option>
				<option value="R">Rejected</option>
			</select>
	 </td>
	 <td>&nbsp;</td>
	 <td>&nbsp;</td>
	</tr>

	<tr>
	 <td colspan=4 align="right">
	 <input type="button" class="clickButton" value="Search" onClick="javascript:getSMSData()"/>&nbsp;&nbsp;
	 <input type="button" class="clickButton" value="Export to Excel" onClick="javascript:exportExcel()"/>&nbsp;
	 </td>
	 </tr>
 	<tr><td colspan=4>&nbsp;	</td>	</tr>
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
	<tr><td colspan=4><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/></td></tr>
	<%
	}
	%>
	</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>