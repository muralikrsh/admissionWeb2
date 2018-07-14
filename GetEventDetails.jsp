<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
String event_id=request.getParameter("event_id");
try{
	
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(con);
	String arr[]=new String[] {"Event ID","Event Name","From Date","To Date","Event Time", "Guests","Venue","Presentation", "Description","Status"};
	
	pst=con.prepareStatement("select event_id,event_name,from_date,to_date,event_time,event_guest,event_venue,event_presentation,event_description,status from event where event_id=?");
	pst.setString(1,event_id);

	String message="<BR><BR><TABLE class='display'  WIDTH='80%' align=center>";
	ResultSet rs=pst.executeQuery();
	if(rs.next()) {
	for(int i=0; i<arr.length; i++) {
		message+="<TR><TD>"+arr[i]+"</TD><TD>"+rs.getString(i+1)+"</TD></TR>";
	}
	message+="</TABLE>";
	}
	%>
	<%= message %>
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Fetching Data
<%
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>