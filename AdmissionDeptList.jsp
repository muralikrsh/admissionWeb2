<% response.addHeader("Refresh","60"); %>
<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>

<html>
<head><title>Vacancy Report</title>

</head>
<body>
<form name="form1">
<table>
<%@ page import="java.util.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintStream" %>
<%@ page import="java.text.*" %>

<% 

java.sql.Connection con;
java.sql.ResultSet rs;
java.sql.PreparedStatement pst;

con=null;
pst=null;
rs=null;

int count=0;
try{
con=ConnectDatabase.getConnection();
}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();

}

%>

<table id="" align="center" width=800 >
<div align=center><img src="images/Bharath_Logo_32.png" alt="Bharath University" style="height:100px;width:900px" title="Bharath University"/></div>
<tr><td  align=center><font size="1">&nbsp; </font></td></tr >
<tr><td  align=center><font size="1">&nbsp; </font></td></tr >
<tr><td  align=center colspan="3"><font size="6"><b>ADMISSION DEPARTMENT LIST</b></font></td></tr >
<tr><td  align=center><font size="1">&nbsp; </font></td></tr >

</table>
<br>
<table align=center>

<!-- start fruit -->
<% 
try{
		String sqlDeptList="SELECT course, branch, COUNT(adm_no) FROM student_admission GROUP BY course, branch ORDER BY course, branch";
	
		pst = con.prepareStatement(sqlDeptList);
		rs = pst.executeQuery(sqlDeptList);
		
%>
<tr>
<td>
		<table id="" border=1 cellpadding="1" cellspacing="1" align="center" width=700 >
		<tr>
		<th style='font-size:20px'>S.No</th>
		<th style='font-size:20px'>Course</th>
		<th style='font-size:20px'>Branch</th>
		<th style='font-size:20px'>No.of Students</th>
		
		</tr>
<%		
		int cnt=1;
		while( rs.next() )
		{	 		
%><tr>
			<td style='font-size:22px'><%= cnt %></td>
			<td style='font-size:22px'><%= rs.getString(1) %></td>
			<td style='font-size:22px'><%= rs.getString(2) %></td>
			<td style='font-size:22px'><%= rs.getString(3) %></td>
			</tr>
			
			<%
			cnt++;
		}
		%>
		</table>
		</td>

		<td>&nbsp;</td>
<%		
}
catch(Exception e){e.printStackTrace();}
finally{
if(con!=null) con.close();
}

%>

</tr>
<table>
</form>
</body>
</html>