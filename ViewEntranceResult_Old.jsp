<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ResourceBundle rb=ResourceBundle.getBundle("admission",new Locale("en", "US"));
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String strHallTicketNumber="";
String strAppnNo="";
String strMobileNo=null;
String hall=null;
int i=0;
String flag=null;
String strRole=null;

try {
	con=ConnectDatabase.getConnection();

	strHallTicketNumber=request.getParameter("HallTicNo");
	strAppnNo=request.getParameter("AppnNo");
	strMobileNo=request.getParameter("MobileNo");
	flag=request.getParameter("flag");
	
	if(strAppnNo==null)  strAppnNo="";
	if(strHallTicketNumber==null)  strHallTicketNumber="";
	if(strMobileNo==null)  strMobileNo="";
	
	if(flag!=null) {

		//System.out.println(strHallTicketNumber+":::"+strAppnNo+"::::"+strMobileNo);
		
		String where_clause="";
		//System.out.println("11 ->"+where_clause);
		if(strHallTicketNumber.intern()!="".intern()) 
		{
			if(where_clause.intern()=="".intern())
				where_clause=" binary ht_no=?";
			else
				where_clause+=" and binary ht_no=?";
		}
		
		//System.out.println("2 ->"+where_clause);
		if(strAppnNo.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary mobile_no_2=?";
			else
				where_clause+=" and binary mobile_no_2=?";
		}
		
		//System.out.println("3 ->"+where_clause+"<<<<");
		if(strMobileNo.intern()!="".intern()) {
			if(where_clause.intern()=="".intern())
				where_clause=" binary mobile_no_1=?";
			else
				where_clause+=" and binary mobile_no_1=?";
		}
	
		// Removed religion, community, sslc_marks
		pst=con.prepareStatement("select ht_no, mobile_no_2, stu_name, rank, mobile_no_1, counsel_date, counsel_time, ans_no from rank_list where "+where_clause+" ");
		int ctr=0;
		
		if(where_clause.indexOf("ht_no")!= -1) {
			pst.setString(++ctr, strHallTicketNumber);
		}
		if(where_clause.indexOf("mobile_no_2")!= -1) {
			pst.setString(++ctr, strAppnNo);
		}
		if(where_clause.indexOf("mobile_no_1")!= -1) {
			pst.setString(++ctr, strMobileNo);
		}

		//System.out.println(pst);
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
			alSub.add(rs.getString(8));
			
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
<title>Results</title>
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
				aDataSet[<%=i%>][4]='<%=alSub.get(4)%>';

				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';			
				aDataSet[<%=i%>][5]='<%=alSub.get(5)%>';
				aDataSet[<%=i%>][6]='<%=alSub.get(6)%>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][7]='&nbsp;<a href="DownloadFile?ht_no=<%=alSub.get(7)%>.html.pdf&path=HALLTICKET_PATH&req_id=HT">Download</a>';

			<%
			}
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Hall Ticket No" },
						{ "sTitle": "Mobile No 2" },
						{ "sTitle": "Candidate Name" },
						{ "sTitle": "Rank" },
						{ "sTitle": "Miobile No 1" },
						{ "sTitle": "Counselling Date" },
						{ "sTitle": "Counselling Time" },
						{ "sTitle": "Counselling Letter" }
					]
				} );
			} );

			function getSMSData() {
				location.href='ViewEntranceResult.jsp?HallTicNo='+document.getElementById("HallTicNo").value+'&MobileNo='+document.getElementById("MobileNo").value+'&AppnNo='+document.getElementById("AppnNo").value+'&flag=Y';
			}
			
		</script>
<%@include file="MBHandler.jsp" %>
	</head>
<body>
<div class="container">
<header>
<div class="header_holder">
<div class="header_content">
<div class="fleft"><img src="images/bharath-logo.png" alt="Bharath University" style="height:69px;" title="Bharath University" /></div>
<div class="fright">&nbsp;&nbsp;&nbsp;</a>&nbsp;&nbsp;
<img height="110" width="110" src="images/bharath32.png" alt="31 Years" title="" /></div>

</div>
</header>
	<div class="content_container">
	<div id="formdiv"><BR>
	<!-- <table class=" valign_top textbox_medium tbl_p5 textarea_normal"> -->
	<table width="90%" class=" valign_top textbox_medium tbl_p5 textarea_normal">
	<tr><td colspan=4>
		<tr><td colspan=4 class="button navy gradient">Bharath Engineering Entrance Exam (BEEE) 2015 Results</td></tr>
	<tr><td colspan=4>&nbsp;	</td>	</tr>
	<tr>
	<td>Hall Ticket Number</td>
	<td><input type="text" name="HallTicNo" value="<%=strHallTicketNumber%>" id="HallTicNo"/></td>
	</tr>
 
	<tr>
	 <td></td>
	 <td>(OR)</td>
	 </tr>
	 
	<tr>
	 <td>Mobile Number 1</td>
	<td>
	<input type="text" name="MobileNo" value="<%=strMobileNo%>" id="MobileNo"/>

	 </tr>
	
	 <tr>
	 <td></td>
	 <td>(OR)</td>
 	 </tr>
	 
	<tr>
	 <td>Mobile Number 2</td>
	<td><input type="text" name="AppnNo" value="<%=strAppnNo%>"  id="AppnNo"/></td>
	<tr>
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
	<table>
	<td style='font-size:20px;'><b>Helpline Numbers: 09025167092 / 09884499302 / 1800-419-1441</b></td>
	</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</div>
</body>
</html>