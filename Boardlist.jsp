<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
ArrayList alBoardCode=new ArrayList();
ArrayList alBoardName=new ArrayList();
String category=request.getParameter("cat");

try {
	con=ConnectDatabase.getConnection();
	String arr[]=new String[] {"Board Code","Board Name"};
	con.setAutoCommit(false);
	user_role=(String)session.getAttribute("role");
	login_id=(String)session.getAttribute("login_id");
	pst=con.prepareStatement("select board_code ,board_name from board");
    String message="<BR><BR><TABLE class='display'  WIDTH='80%' align=center>";
	rs=pst.executeQuery();
	while(rs.next()) {
	alBoardCode.add(rs.getString(1));
	alBoardName.add(rs.getString(2));
	}
}
catch(Exception e1){
	e1.printStackTrace();


%>
Error while Fetching Data
<%}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>

<html>
<head>
<link rel="stylesheet"  type="text/css" href="css/style.css">
<link rel="stylesheet" href="css/pro_dropdown_2.css" />
<link rel="stylesheet" type="text/css" href="css/button-style.css" />
<link rel="stylesheet" href="css/jquery.ui.all.css">
<link rel="stylesheet" href="css/demos.css">

<script language='Javascript'>
function setVal(val) {
var cat='<%=category%>';

if(cat=="SSLC"){
window.opener.top.document.getElementById("sslc_board").value=val;
}else
{
window.opener.top.document.getElementById("hsc_board").value=val;
}
window.close();
}
</script>

</head>
<body>
<table>
<tr>
<td colspan="2" class="button navy gradient">Board List</td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
<td class="button navy gradient">Code</td>
<td class="button navy gradient">Board Name</td>
</tr>
<%
for(int i=0; i<alBoardCode.size();i++) {
%>
<tr>
<td><a href="javascript:setVal('<%=alBoardCode.get(i) %>')"><%=alBoardCode.get(i) %></a></td>
<td><%=alBoardName.get(i) %></td>
</tr>
<%
}
%>
</table>
</body>
</html>
