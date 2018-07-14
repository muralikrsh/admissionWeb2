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
<tr><td  align=center colspan="3"><font size="6"><b>VACANCY LIST</b></font></td></tr >
<tr><td  align=center><font size="1">&nbsp; </font></td></tr >

</table>
<br>
<table align=center>

<!-- start fruit -->
<% 
try{
		String sqlVacancy="SELECT course_name, vacancy FROM course WHERE course_group='B.Tech' ORDER BY course_name ASC limit 13";
	
		pst = con.prepareStatement(sqlVacancy);
		rs = pst.executeQuery(sqlVacancy);
		
%>
<tr>
<td>
		<table id="" border=1 align="center" width=620 >
		<tr>
		<th style='font-size:20px' WIDTH="25%">Branch</th>
		<th style='font-size:20px' WIDTH="5%">Vacant Seats</th>
		
		</tr>
<%		
		while( rs.next() )
		{	 		
%><tr>
			<td style='font-size:22px'><%= rs.getString(1) %></td>
			<td style='font-size:25px' align=center><%= rs.getString(2) %></td>
			</tr>
			
			<%
		}
		%>
		</table>
		</td>
		<td>&nbsp;</td>
		
<%
pst=null;
rs=null;
		sqlVacancy="SELECT course_name, vacancy FROM course WHERE course_group='B.Tech' ORDER BY course_name DESC limit 13";
	
		pst = con.prepareStatement(sqlVacancy);
		rs = pst.executeQuery(sqlVacancy);
		
%>
<td>
		<table id="" border=1 align="center" width=620 >
		<tr>
		<th style='font-size:20px' WIDTH="25%">Branch</th>
		<th style='font-size:20px' WIDTH="5%">Vacant Seats</th>
		
		</tr>
<%		
		while( rs.next() )
		{	 		
%><tr>
			<td style='font-size:22px'><%= rs.getString(1) %></td>
			<td style='font-size:25px' align=center><%= rs.getString(2) %></td>
			</tr>
			
			<%
		}
		%>
		</table>
		</td>
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