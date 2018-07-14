<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String strRole=(String)session.getAttribute("role"); 
String strId=(String)session.getAttribute("login_id"); 
ArrayList alStates=(ArrayList)application.getAttribute("STATES");
ResourceBundle rb=ResourceBundle.getBundle("admission",new Locale("en", "US"));
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String from_date="";
String to_date="";
String exam_id="";
String appn_no="";
String flag=null;
String first_name=null;
String last_name=null;
String state=null;
String appfee_flag=null;
String pay_status=null;
int i=0;
ArrayList alExamID=null; 
ArrayList alExamName= null; 

ArrayList alStateID=null; 
ArrayList alStateName= null; 
try {
	con=ConnectDatabase.getConnection();
	exam_id=request.getParameter("exam_id");
	appn_no=request.getParameter("appn_no");
	from_date=request.getParameter("from_date");
	to_date=request.getParameter("to_date");
	flag=request.getParameter("flag");
	first_name=request.getParameter("first_name");
	last_name=request.getParameter("last_name");
	state=request.getParameter("state");
	appfee_flag=request.getParameter("appfee_flag");
	pay_status=request.getParameter("pay_status");

	if(appn_no==null)  appn_no="";
	if(exam_id==null)  exam_id="";
	if(from_date==null)  from_date="";
	if(to_date==null)  to_date="";
	if(first_name==null)  first_name="";
	if(last_name==null)  last_name="";
	if(state==null)  state="";
	if(appfee_flag==null)  appfee_flag="";
	if(pay_status==null)  pay_status="";

	pst=con.prepareStatement("select exam_id, exam_title from exam_master");
	rs=pst.executeQuery();
	alExamID= new ArrayList();
	alExamName= new ArrayList();	

	while(rs.next()) {
		alExamID.add(rs.getString(1));
		alExamName.add(rs.getString(2));
	}

/*
	pst=con.prepareStatement("select state_name, state_name from state order by state_name");
	rs=pst.executeQuery();
	alStateID= new ArrayList();
	alStateName= new ArrayList();	

	while(rs.next()) {
		alStateID.add(rs.getString(1));
		alStateName.add(rs.getString(2));
	}
*/

	if(flag!=null) {

		System.out.println(from_date+":::"+to_date+"::::"+appn_no+"::::"+exam_id+"::::"+first_name+"::::"+last_name+"::::"+state+"....."+appfee_flag);
		//+"...."+opt_sub
		String where_clause="appn_status='s'";
		System.out.println("1 ->"+where_clause);
		if(appn_no.intern()!="".intern()) {
			where_clause=" and binary appn_no=?";
		}
		System.out.println("2 ->"+where_clause);
		if(exam_id.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary exam_id=?";
			else 
				where_clause+=" and binary exam_id=?";
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
		if(appfee_flag.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary appfee_flag = ? ";
			else
				where_clause+=" and binary appfee_flag = ? ";
		}
		System.out.println("6 ->"+where_clause+"<<<<");
		
		if(pay_status.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary pay_status= ? ";
			else
				where_clause+=" and binary pay_status= ? ";
		}
		System.out.println("7 ->"+where_clause+"<<<<");
		
		if(from_date.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" submission_date between str_to_date(?,'%m/%d/%Y') and str_to_date(?,'%m/%d/%Y')";
			else
				where_clause+=" and submission_date between str_to_date(?,'%m/%d/%Y') and str_to_date(?,'%m/%d/%Y')";
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
		System.out.println("select appn_no, first_name, ifnull(last_name,'') last_name, dob, gender, hsc_marks, date_format(submission_date,'%d %b %Y'), IF(STRCMP(appn_status,'A')=0,'Approved',(if(STRCMP(appn_status,'R')=0,'Rejected','Submitted'))) from application "+where_clause);
		pst=con.prepareStatement("select appn_no, first_name, ifnull(last_name,'') last_name, dob, gender, hsc_marks, date_format(submission_date,'%d %b %Y'), IF(STRCMP(appn_status,'A')=0,'Approved',(if(STRCMP(appn_status,'R')=0,'Rejected',if(STRCMP(appn_status,'D')=0,'Draft','Submitted')))), remarks,course, pay_status from application "+where_clause+" ");
		int ctr=0;

		if(where_clause.indexOf("appn_no")!= -1) {
			pst.setString(++ctr, appn_no);
		}
		if(where_clause.indexOf("exam_id")!= -1) {
			pst.setString(++ctr, exam_id);
		}
		if(where_clause.indexOf("state")!= -1) {
			pst.setString(++ctr, state);
		}
		if(where_clause.indexOf("first_name")!= -1) {
			pst.setString(++ctr, "%"+first_name+"%");
		}
		if(where_clause.indexOf("last_name")!= -1) {
			pst.setString(++ctr, "%"+last_name+"%");
		}
		if(where_clause.indexOf("appfee_flag")!= -1) {
			pst.setString(++ctr, appfee_flag);
		}
		
		if(where_clause.indexOf("pay_status")!= -1) {
			pst.setString(++ctr, pay_status);
		}
		
		if(where_clause.indexOf("between")!= -1) {
			pst.setString(++ctr, from_date);
			pst.setString(++ctr, to_date);
		}

		if(from_date.intern()=="01/01/1900".intern()) {
			from_date="";
			to_date="";
		}
		System.out.println("pst search= "+pst);
		rs=pst.executeQuery();
		while(rs.next()) {
			ArrayList alSub=new ArrayList();
			alSub.add(rs.getString(1));
			alSub.add(rs.getString(2));
			alSub.add(rs.getString(3));
			alSub.add(rs.getString(4));
			alSub.add(rs.getString(5));  //alSub.add(rb.getString("GEND_"+rs.getString(5)));
			//alSub.add(rs.getString(6));
			//alSub.add(rb.getString("COMM_"+rs.getString(7)));
			//alSub.add(rs.getString(8));
			alSub.add(rs.getString(6));
			alSub.add(rs.getString(7));
			alSub.add(rs.getString(8));
			alSub.add(rs.getString(9));
			alSub.add(rs.getString(10));
			alSub.add(rs.getString(11));
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
				if(strRole.intern()=="ADMIN".intern()) {
				%>
					aDataSet[<%=i%>][0]='<a href="ApproveApplication2.jsp?appn_no=<%=alSub.get(0)%>&flag=U"><%=alSub.get(0)%></a>&nbsp;<!--<a href="DownloadFile?ht_no=<%=alSub.get(0)%>.html.pdf&path=AF_PATH&req_id=HT">PDF</a>-->';
				<%
					} else {
					String category="PG";
					if(alSub.get(7).toString().intern()=="Draft".intern()) {
						//System.out.println(alSub.get(9));
						if(alSub.get(9).toString().intern()=="B.Tech".intern() || alSub.get(9).toString().intern()=="B.Arch".intern() || alSub.get(9).toString().intern()=="BA".intern() || alSub.get(9).toString().intern()=="B.Sc".intern() || alSub.get(9).toString().intern()=="BBA".intern() || alSub.get(9).toString().intern()=="BCA".intern() || alSub.get(9).toString().intern()=="B.Com".intern())
							category="UG";
						System.out.println(category);
					%>
						aDataSet[<%=i%>][0]='<a href="SubmitArtsApplication.jsp?flag=U&appn_no=<%=alSub.get(0)%>&category=<%=category%>"><%=alSub.get(0)%></a>&nbsp;<a href="SubmitArtsApplication.jsp?ht_no=<%=alSub.get(0)%>.html.pdf&path=AF_PATH&req_id=HT">PDF</a>';
					<% } else { %>
						aDataSet[<%=i%>][0]='<%=alSub.get(0)%>&nbsp;<!--<a href="DownloadFile?ht_no=<%=alSub.get(0)%>.html.pdf&path=AF_PATH&req_id=HT">PDF</a>-->';
					<% } 
					}
				%>
				aDataSet[<%=i%>][1]='<%=alSub.get(1)+" "+alSub.get(2)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(5)%>';
				aDataSet[<%=i%>][5]='<%=alSub.get(6)%>';
				aDataSet[<%=i%>][6]='<%=alSub.get(10)%>';
				aDataSet[<%=i%>][7]='<%=alSub.get(7)%>';
				if(aDataSet[<%=i%>][7]=="Rejected" || aDataSet[<%=i%>][6]=="Draft") {
					aDataSet[<%=i%>][7]+= "&nbsp;&nbsp;<a href=#' title='<%=alSub.get(8)%>'>Reason</a>";
				}
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
						{ "sTitle": "Date of Birth" },
						{ "sTitle": "Gender" },
						{ "sTitle": "HSC Marks" },
						{ "sTitle": "Submission Date" },
						{ "sTitle": "Pay_Status" },
						{ "sTitle": "App Status" }
					]
				} );	
			} );

			function getSMSData() {
				location.href='SearchApplications.jsp?from_date='+document.getElementById("from_date").value+'&to_date='+document.getElementById("to_date").value+'&appn_no='+document.getElementById("appn_no").value+'&state='+document.getElementById("state").value+'&first_name='+document.getElementById("first_name").value+'&pay_status='+document.getElementById("pay_status").value+'&last_name='+document.getElementById("last_name").value+'&appfee_flag='+document.getElementById("appfee_flag").value+'&flag=Y';
				// '&opt_sub='+document.getElementById("opt_sub").value+
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
	<tr><td colspan=4 class="button navy gradient">Search Applications</td></tr>
	<tr><td colspan=4>&nbsp;	</td>	</tr>
	 <tr>
	<!-- <td>Exam Name</td>
	 <td>
		<select name="exam_id" id='exam_id' style="width: 250px">
					<option value="">Select Examination Name</option>
					<%
					for(i =0;i<alExamID.size(); i++) {
						%>
							<option value="<%=alExamID.get(i)%>"><%=alExamName.get(i)%></option>
						<%  
					}			
					%>
		</select>
	 </td> -->
	 <td>Appn No</td>
	 <td><input type="text" name="appn_no" value="<%=appn_no%>"  id="appn_no"/></td>
 	<td>Payment Status</td>
	<td>
	<select name="pay_status" id='pay_status' style="width: 155px">
				<option value="">Select</option>
				<option value="C">Paid</option>
			</select>
	 </td>

	 </tr>

	 <tr>
	 <td>From Date</td>
	<td><input type="text" name="from_date" value="<%=from_date%>"  id="from_date"/></td>
	 <td>To Date</td>
	<td><input type="text" name="to_date" value="<%=to_date%>"  id="to_date"/></td>
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
	<select name="state" id='state' style="width: 250px">
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
	<td>Payment Mode</td>
	 <!-- <td class='label'>Optional Subject</td> -->
	 <td>
	<select name="appfee_flag" id='appfee_flag' style="width: 155px">
				<option value="">Select</option>
				<option value="CASH">Cash</option>
				<option value="DD">DD</option>
			</select>
	 </td>
	</tr>
	<tr>
	 <td colspan=4 align="right">
	 <input type="button" class="clickButton" value="Search" onClick="javascript:getSMSData()"/>&nbsp;
	 </td>
	 </tr>
 	<tr><td colspan=4>&nbsp;	</td>	</tr>
	<%
	if(alMain.size()>0) {
	%>
	<tr>
	<td colspan=7>
	<div id="container" align='left'>
		<div id="dynamic"></div>
		<div class="spacer"></div>
	</div>
	</td>
	</tr>
	<%
	} else {
	%>
	<tr><td colspan=4><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/><BR/></td></tr>
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