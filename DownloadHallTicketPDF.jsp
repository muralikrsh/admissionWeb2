<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String dob="";
String ht_no="";
String name="";
String mobile_no=null;
String hall=null;
int i=0;
String flag=null;
String strRole=null;

try {
	con=ConnectDatabase.getConnection();

	dob=request.getParameter("dob");
	ht_no=request.getParameter("ht_no");
	mobile_no=request.getParameter("mobile_no");
	name="%"+request.getParameter("name")+"%";
	flag=request.getParameter("flag");
	
	if(ht_no==null)  ht_no="";
	if(dob==null)  dob="";
	if(mobile_no==null)  mobile_no="";
	if(name==null)  name="";
	
	if(flag!=null) {

		System.out.println(dob+":::"+ht_no+"::::"+mobile_no+":::"+name);
		
		String where_clause="";
		System.out.println("1 ->"+where_clause);
		if(dob.intern()!="".intern()) 
		{
			if(where_clause.intern()=="".intern())
				where_clause=" binary dob=?";
			else
				where_clause+=" and binary dob=?";
		}
		
		System.out.println("2 ->"+where_clause);
		if(ht_no.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary ht_no=?";
			else
				where_clause+=" and binary ht_no=?";
		}
		
		System.out.println("3 ->"+where_clause+"<<<<");
		if(mobile_no.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary mobile_no=?";
			else
				where_clause+=" and binary mobile_no=?";
		}
	
		System.out.println("4 ->"+where_clause+"<<<<");
		if(name.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" first_name like ? ";
			else
				where_clause+=" and first_name like ? ";
		}
		// Removed religion, community, sslc_marks
		pst=con.prepareStatement("select ht_no, appn_no, first_name, dob, gender, course, mobile_no from hall_ticket_2016 where "+where_clause+" ");
		//pst=con.prepareStatement("select ht_no, first_name, ifnull(last_name,'') last_name, dob, gender, hsc_marks, date_format(submission_date,'%d %b %Y'),remarks,course from application "+where_clause+" limit 50");
		int ctr=0;
		
		if(where_clause.indexOf("dob")!= -1) {
			pst.setString(++ctr, dob);
		}
		if(where_clause.indexOf("ht_no")!= -1) {
			pst.setString(++ctr, ht_no);
		}
		if(where_clause.indexOf("mobile_no")!= -1) {
			pst.setString(++ctr, mobile_no);
		}
		if(where_clause.indexOf("first_name")!= -1) {
			pst.setString(++ctr, name);
		}

		System.out.println(pst);
		rs=pst.executeQuery();
		while(rs.next()) {
			ArrayList alSub=new ArrayList();
			alSub.add(rs.getString(1));
			alSub.add(rs.getString(2));
			alSub.add(rs.getString(3));
			alSub.add(rs.getString(4));
			alSub.add(rs.getString(5));
			alSub.add(rs.getString(6));
			alSub.add(rs.getString(7));
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
<title>Download Hall Ticket</title>
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

			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(8);
				
				aDataSet[<%=i%>][0]='<%=alSub.get(0)%>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][4]='<%=alSub.get(4)%>';
				aDataSet[<%=i%>][5]='<%=alSub.get(5)%>';
				aDataSet[<%=i%>][6]='<%=alSub.get(6)%>';
				aDataSet[<%=i%>][7]='&nbsp;<a href="DownloadFile?ht_no=<%=alSub.get(0)%>.html.pdf&path=HALLTICKET_PATH&req_id=HT">Download</a>';
			<%
			}
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Hall Ticket No" },
						{ "sTitle": "Appn No" },
						{ "sTitle": "Candidate Name" },
						{ "sTitle": "Date of Birth" },
						{ "sTitle": "Gender" },
						{ "sTitle": "Course" },
						{ "sTitle": "Mobile" },
						{ "sTitle": "" }
					]
				} );	
			} );

			function getSMSData() {
				if( (document.getElementById("dob").value!="" ) || (document.getElementById("mobile_no").value!="" ) || (document.getElementById("ht_no").value!="" ) || (document.getElementById("name").value!="" ) )
					{
						location.href='DownloadHallTicketPDF.jsp?dob='+document.getElementById("dob").value+'&mobile_no='+document.getElementById("mobile_no").value+'&ht_no='+document.getElementById("ht_no").value+'&name='+document.getElementById("name").value+'&flag=Y';
					}
				else
					{
						alert("Please fill any one field..??");
					}
			}
			
	$(function() {
        $( "#dob" ).datepicker({
            dateFormat: 'dd-M-y',
            changeMonth : true,
            changeYear : true,
            yearRange: '-100y:c+nn',
            maxDate: '-1d'
        });
    });
</script>
</HEAD>
 
<body>
<header>
<div>
<div class="header_content">
<div align='center'><img src="images/bu_logo.jpg" alt="Bharath University" style="height:120px;width:40%;" title="Bharath University"/></div>

</div>
</div>
</header>
<div class="content_container">
	<div id="formdiv"><BR>
	<table width="90%" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td colspan=4>
		<tr><td colspan=4 style="font-size:12pt" class="button navy gradient"> BHARATH ENGINEERING ENTRANCE EXAMINATION - 2016 HALL TICKET DOWNLOAD</td></tr>
	<tr><td colspan=4>&nbsp;	</td>	</tr>
	 
	
	<tr>
	 <td>Hall Ticket Number</td>
	<td><input type="text" name="ht_no"  id="ht_no"/></td>
	 </tr>
	
	 <tr>
	 <td></td>
	 <td><b>(OR)</b></td>
	<tr>
	<td>Mobile Number</td>
	<td>
	<input type="text" name="mobile_no" id="mobile_no"/>
	</td>
	</tr>
	<tr>
	<td></td>
	<td><b>(OR)</b></td>
	</tr>
	<tr>
	<td>Date of Birth</td>
	<td><input type="text" name="dob" id="dob" readonly='readonly' /></td>
	</tr>
<!--	<tr>
	<td></td>
	<td><b>(OR)</b></td>
	</tr>
	<tr>
	<td>Name</td>
	<td><input type="text" name="name" id="name"/></td>
	</tr>
-->
<td><input type="hidden" name="name" id="name"/></td>
	<tr>
	 <td colspan=4 align="right">
	 <input type="button" class="clickButton" value="Search" onClick="javascript:getSMSData()"/>&nbsp;
	 </td>
	 </tr>
 	<tr><td colspan=4>&nbsp;	</td>	</tr>
	<tr>
	<td style='color:blue; font-size:15px' colspan=2>
	<strong>Note:</strong>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;CANDIDATES WHO HAVE NOT RECEIVED SMS ON THEIR REGISTERED MOBILE NUMBER TO DOWNLOAD HALL TICKET FOR BEEE 2016 MAY RECEIVE SMS SHORTLY STATING THE INSTRUCTIONS TO DOWNLOAD HALL TICKET FOR BEEE 2016 ONLINE EXAM ALONG WITH DATE AND VENUE FOR THE SAME.
	<td>
	</tr>
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
<%@include file="Footer.jsp" %>
</div>
</body>
</html>