<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
try {

	con=ConnectDatabase.getConnection();

	//String query="select a.ht_no, b.appn_no, concat(first_name, concat(' ', b.last_name)) as candidate_name, rank from rank_list a, application b where a.ht_no=b.ht_no and a.exam_id=? order by rank asc";
	String query="select ht_no, mobile_no_2, stu_name, rank, mobile_no_1 from rank_list";
	pst=con.prepareStatement(query);
	//pst.setString(1,exam_id);
	
		rs=pst.executeQuery();
		while(rs.next()) {
			ArrayList alSub=new ArrayList();
			alSub.add(rs.getString(1));
			alSub.add(rs.getString(2));
			alSub.add(rs.getString(3));
			alSub.add(rs.getString(4));
			alSub.add(rs.getString(5));
			alMain.add(alSub);
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
<title>Exam Results</title>
	<head>
	<meta charset="utf-8">

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="ui/minified/jquery.ui.datepicker.min.js"></script>
	<script src="ui/jquery.dataTables.js"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>

	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="css/demo_table.css">
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/button-style.css" />

		<script type="text/javascript" charset="utf-8">

			/* Data set - can contain whatever information you want */
			var aDataSet = new Array(<%=alMain.size()%>);
			<%		
			for (int i=0; i<alMain.size(); i++)
			{
				ArrayList alSub=(ArrayList)alMain.get(i);
			%>
				aDataSet[<%=i%>]=new Array(5);
				aDataSet[<%=i%>][0]='<%=alSub.get(0)%>';
				aDataSet[<%=i%>][1]='<%=alSub.get(1)%>';
				aDataSet[<%=i%>][2]='<%=alSub.get(2)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(3)%>';
				aDataSet[<%=i%>][3]='<%=alSub.get(4)%>';
			<%
			}
			alMain=null;
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Hall Tkt No", "sClass": "alignCenter" },
						{ "sTitle": "Mobile No 2", "sClass": "alignCenter" },
						{ "sTitle": "Candidate Name", "sClass": "alignCenter" },
						{ "sTitle": "Rank", "sClass": "alignRight" },
						{ "sTitle": "Mobile No 1", "sClass": "alignRight" }
					]
					} );	
			} );

			function getExamData() {
				location.href='EntranceExamResults.jsp;
			}
			var boolSelected=false;
			
		</script>
<%@include file="MBHandler.jsp" %>
	</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
				<tr>
				<td colspan=5 >&nbsp;</td>
				</tr>
				<tr>
				<td colspan=5 class="button navy gradient">Entrance Exam Results</td>
				</tr>
				<tr>
				<td colspan=5>
				&nbsp;
				</td>
				</tr>
				
				<input type="button" class="clickButton" value="Search" onClick="javascript:getExamData()"/>&nbsp;
				</td>
				</tr>
				<tr>
				<td colspan=5>
				<form name='xxx'>
				<div id="container" align='left'>
					<div id="dynamic"></div>
					<div class="spacer"></div>
				</div>
				<div id='resultCell'></div>
				</form>
				</td>
				</tr>
			</table>
			</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>