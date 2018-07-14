<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
String flag=request.getParameter("flag");
String flagDesc="";
//System.out.println("Login ID" +session.getAttribute("login_id"));
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
if(flag==null)
	flag="BS";
System.out.println(flag);
HashMap hmHiringDetails=new HashMap();
ArrayList alState=new ArrayList();
ArrayList alCount=new ArrayList();
try {

	con=ConnectDatabase.getConnection();
	if(flag.intern()=="BS".intern()) {
		pst=con.prepareStatement("select state, count(1) from application group by state order by state");
		flagDesc="Application Count - Statewise";
	} else 	if(flag.intern()=="BM".intern()) {
		pst=con.prepareStatement("select date_format(submission_date,'%b'), count(1) from application group by 1 order by submission_date");
		flagDesc="Application Count - Monthwise";
	} else 	if(flag.intern()=="BC".intern()) {
		pst=con.prepareStatement("select course, count(1) from application group by course order by course");
		flagDesc="Application Count - Coursewise";
	} else 	if(flag.intern()=="FS".intern()) {
		pst=con.prepareStatement("select state, count(1)*750 from application where appn_status='A' group by state order by state");
		flagDesc="Fee Collected - Statewise";
	} else 	if(flag.intern()=="FM".intern()) {
		pst=con.prepareStatement("select date_format(submission_date,'%b'), count(1)*750 from application where appn_status='A'  group by 1 order by submission_date");
		flagDesc="Fee Collected - Monthwise";
	} else 	if(flag.intern()=="FC".intern()) {
		pst=con.prepareStatement("select course, count(1)*750 from application where appn_status='A'  group by course order by course");
		flagDesc="Fee Collected - Coursewise";
	}
	rs=pst.executeQuery();

	while(rs.next()) {
		//hmHiringDetails.put(rs.getString(1),rs.getString(2));
		alState.add(rs.getString(1));
		alCount.add(rs.getString(2));
	} 
	System.out.println("hmHiringDetails" +hmHiringDetails);
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if(con!=null)
			con.close();
	pst=null;
	rs=null;
	con=null;
}


%>
<!DOCTYPE html>
<html  style="height: 95%;">
<title>My Dashboard</title>
	<head>
	<meta charset="utf-8">
	
	<link rel="stylesheet" href="css/jquery.ui.all2.css">
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="css/demo_table.css" rel="stylesheet" >
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css"  />

	<link rel="stylesheet" href="css/demos.css">
	<link rel="stylesheet" href="css/demo_page.css">
	<link rel="stylesheet" href="css/demo_table.css">

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/excanvas.min.js"></script>
	<script src="ui/jquery.flot.js"></script>
	<!-- <script src="ui/jquery.dataTables.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script> -->
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script> 



	<script>
		function getData(flg) {
			location.href='ApplicationReport.jsp?flag='+flg;
		}
		$(function () {
		 

			var d2 = new Array(<%= hmHiringDetails.size() %>);
		    <%

			//Iterator it = hmHiringDetails.entrySet().iterator();
			int i=0;
			//while (it.hasNext()) {
			for(i=0; i<alState.size(); i++) {
				//Map.Entry pairs = (Map.Entry)it.next();
			%>
				d2[<%=i%>]=new Array(2);
				d2[<%=i%>][0]='<%= (i+1) %>'; // <%= alState.get(i) %>
				d2[<%=i%>][1]='<%= alCount.get(i) %>';

			<%
				//i++;
			}
			%>
			//var options = { series:{ bars:{show: true} }, bars:{ barWidth:0.8 }, grid:{ backgroundColor: { colors: ["#919191", "#141414"] } } };
			//$.plot($("#placeholder"), [d2], options);  
			
			$.plot($("#placeholder"), 
				[ 
					{ 
						label: "Applications", 
						color: 'red',
						data: d2,
						lines: {show: false},
						bars: {show: true, barWidth: 0.4, align: 'center'}
					}
				],
				{
				   xaxis: {
					 ticks: [
						<% 
						 int j=0;
							for (j=0; j<alState.size()-1 ;  j++) { %>
							[<%= (j+1) %>, "<%= alState.get(j) %>"],	
						<% } %>
							[<%= (j+1) %>, "<%= alState.get(j) %>"]
					]
				   }   
				 }
			) 
		});



    </script>

	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table>
	<tr><td>&nbsp;</td></tr>
	<tr><td>
	<input type="button" class="clickButton" value="Appn By State" onClick="javascript:getData('BS')"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Appn By Month" onClick="javascript:getData('BM')"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Appn By Course" onClick="javascript:getData('BC')"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Fee Collected By State" onClick="javascript:getData('FS')"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Fee Collected By Month" onClick="javascript:getData('FM')"/>&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Fee Collected By Course" onClick="javascript:getData('FC')"/>&nbsp;&nbsp;
	</td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td><b><%= flagDesc %></b></td></tr>
	<tr><td>&nbsp;</td></tr>
	<tr><td><div id="placeholder" style="width:800px;height:400px;"></div></td></tr>
	</table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>