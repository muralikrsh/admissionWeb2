<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String exam_id="";
String appn_no="";
String degrees="CSE|CSW|IT|ECE|ETE|EIE|EEE|Auto|IBT|Mechatronics|CIVIL|MECH|E&I|MCA|MBA|BIOMED|BIOINFO";
String dept="";
ArrayList alExamId=new ArrayList(); //(ArrayList)application.getAttribute("JOB_ID");
ArrayList alExamTitle=new ArrayList(); //(ArrayList)application.getAttribute("JOB_TITLE");
try {

	
	con=ConnectDatabase.getConnection();
	pst=con.prepareStatement("select exam_id, exam_title from exam_master");
	rs=pst.executeQuery();

	while(rs.next()) {
			alExamId.add(rs.getString(1));
			alExamTitle.add(rs.getString(2));
		}
	exam_id=request.getParameter("exam_id");
	exam_id=(exam_id==null)?"":exam_id;
	appn_no=request.getParameter("appn_no");
	appn_no=(appn_no==null)?"":appn_no;

	String query="select appn_no,candidate_name, city, state, mobile_no,marks, rank,adm_status from application a, rank_list b where a.appn_status='A' and a.ht_no is not null and a.ht_no=b.ht_no";

	pst=con.prepareStatement(query);


	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString("appn_no"));
		alSub.add(rs.getString("candidate_name"));
		alSub.add(rs.getString("city"));
		alSub.add(rs.getString("state"));
		alSub.add(rs.getString("mobile_no"));
		alSub.add(rs.getString("marks"));
		alSub.add(rs.getString("rank"));
		alSub.add(rs.getString("adm_status"));
		alMain.add(alSub);
	}


	if(exam_id==null)
		exam_id="";
	if(dept==null)
		dept="";

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
<title>Counseling List</title>
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
				String applink="";
				String rejlink="";
				if(alSub.get(7).toString().intern()=="P".intern())  {
					applink="<a href=javascript:admitStudent('"+ alSub.get(0).toString()+"','A')>Admit Student</a>";
					rejlink="<a href=javascript:rejectStudent(\'"+ alSub.get(0).toString()+"','R')>Reject Student</a>";
				}
				else {
					applink="";
					rejlink="";
				}
				String adm_status="Pending";
				if(alSub.get(7).toString().intern()=="A".intern())
					adm_status="Admitted";

			%>
				aDataSet[<%=i%>]=new Array(10);
				aDataSet[<%=i%>][0]="<%=alSub.get(0)%>";
				aDataSet[<%=i%>][1]="<%=alSub.get(1)%>";
				aDataSet[<%=i%>][2]="<%=alSub.get(2)%>";
				aDataSet[<%=i%>][3]="<%=alSub.get(3)%>";
				aDataSet[<%=i%>][4]="<%=alSub.get(4)%>";
				aDataSet[<%=i%>][5]="<%=alSub.get(5)%>";
				aDataSet[<%=i%>][6]="<%=alSub.get(6)%>";
				aDataSet[<%=i%>][7]="<%=adm_status%>";
				aDataSet[<%=i%>][8]="<%=applink%>";
				aDataSet[<%=i%>][9]="<%=rejlink%>";
			<%
			}
			alMain=null;
			%>

			$(document).ready(function() {
					
				$('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
				$('#example').dataTable( {
					"aaData": aDataSet,
					"aoColumns": [
						{ "sTitle": "Appn No" },
						{ "sTitle": "Candidate Name" },
						{ "sTitle": "City" },
						{ "sTitle": "State" },
						{ "sTitle": "Mobile No" },
						{ "sTitle": "Marks" },
						{ "sTitle": "Rank" },
						{ "sTitle": "Adm. Status" },
						{ "sTitle": "Admit" },
						{ "sTitle": "Reject" }
					]
				} );	
			} );

			function getCounselingList() {
				location.href='CounselingList.jsp?exam_id='+document.getElementById("exam_id").value+'&appn_no='+document.getElementById("appn_no").value;
			}
			var boolSelected=false;

			function updateStatus() {
				var elLength = document.xxx.elements.length;
				var param='';
				var param2='';
				for(i=0; i< elLength; i++) {
					var type = document.xxx.elements[i].type;
					//alert(type);
					if (type=="checkbox" && document.xxx.elements[i].checked){
						boolSelected=true;
						//alert(document.xxx.elements[i].id);
						var val=document.xxx.elements[i].id;

						if(param=='') {
							param+=val;
							param2+=eval('document.xxx.sel_'+val).value;
						}
						else {
							param+=","+val;
							param2+=","+eval('document.xxx.sel_'+val).value;
						}
					} else if (type=="checkbox" && !(document.xxx.elements[i].checked)){
						boolSelected=false;
					}

				}
			var strURL="UpdatePlacementStatus.jsp";
			var parameters="student_id="+param+"&status="+param2+"&exam_id=<%=exam_id%>";
			var xmlHttp;
			if (window.XMLHttpRequest) { // Mozilla, Safari, ...
				var xmlHttp = new XMLHttpRequest();
			}else if (window.ActiveXObject) { // IE
				var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlHttp.open('POST',strURL , true);
			xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlHttp.send(parameters);
			xmlHttp.onreadystatechange = function() {
				if (xmlHttp.readyState == 4) {
					updatepage(xmlHttp.responseText);
				}
			}

			xmlHttp.send(strURL);
		}


		function admitStudent(appn_no, flag) {
			var strURL="SubmitApplication2.jsp";
			var parameters="appn_no="+appn_no+"&flag="+flag;
			location.href=strURL+"?"+parameters;
		}

		function updatepage(str){
			document.getElementById("resultCell").innerHTML = "<b>Result : "+str+"</b>";
		}

			
		</script>
<%@include file="MBHandler.jsp" %>
	</head>
<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal" width="90%">
	<tr><td colspan=5>	&nbsp;	</td>	</tr>
	<tr><td colspan=5 class="button navy gradient">Counseling List</td></tr>
	<tr><td colspan=5>	&nbsp;	</td>	</tr>
	<tr>
	<td>Exam&nbsp;&nbsp;&nbsp;
	<select id='exam_id' STYLE="width: 250px">
		<option value='SEL'>Select an Exam</option>
	<%
	int i=0;
	for(i=0; i<alExamId.size(); i++) {
		if(exam_id.intern()==alExamId.get(i).toString().intern()) {
	%>
	<option value='<%= alExamId.get(i).toString() %>' selected><%= alExamTitle.get(i).toString() %></option>
	<%

		} else {
	%>
	<option value='<%= alExamId.get(i).toString() %>'><%= alExamTitle.get(i).toString() %></option>
	<%
		}
	}
	%>
	</select>
	</td>
	<td class='label'>Application No&nbsp;&nbsp;&nbsp;
	<input type="text" name="appn_no" id="appn_no" name="<%=appn_no%>">
	</td>
	<td>
	<input type="button" class="clickButton" value="Search" onClick="javascript:getCounselingList()"/>&nbsp;&nbsp;&nbsp;
	<input type="button" class="clickButton" value="Update Status" onClick="javascript:updateStatus()"/>
	</td>
	</tr>
	<tr><td colspan=5>&nbsp;</td></tr>
	<tr><td colspan=5>
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