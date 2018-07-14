<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
String event_id="EV00001";
String event_title=request.getParameter("event_title");
String from_date=request.getParameter("from_date");
String to_date=request.getParameter("to_date");
String event_time=request.getParameter("event_time");
String event_guest=request.getParameter("event_guest");
String event_venue=request.getParameter("event_venue");
String event_presentation=request.getParameter("event_presentation");
String event_desc=request.getParameter("event_desc");
String flag=request.getParameter("flag");

try{

	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	System.out.println(con);
	
	if(flag.intern()=="I".intern()) {

		pst=con.prepareStatement("select concat('EV', lpad(max(substring(event_id,3))+1,5,'0')) from  event");
		ResultSet rs=pst.executeQuery();
		if(rs.next()) 
			event_id=rs.getString(1);
		else
			event_id="EV00001";
		if(event_id==null)
			event_id="EV00001";

		pst=con.prepareStatement("insert into event (event_name, from_date, to_date, event_time, event_guest, event_venue, event_presentation, event_description, status, event_id) values(?,str_to_date(?,'%d-%M-%Y'),str_to_date(?,'%d-%M-%Y'),?,?,?,?,?,?,?)");
	}
	else {
		event_id=request.getParameter("event_id");
		System.out.println("update event set event_name=?, from_date=str_to_date(?,'%d-%M-%Y'), to_date=str_to_date(?,'%d-%M-%Y'), event_time=?, event_guest=?, event_venue=?, event_presentation=?, event_description=?, status=? where binary event_id=?");
		pst=con.prepareStatement("update event set event_name=?, from_date=str_to_date(?,'%d-%M-%Y'), to_date=str_to_date(?,'%d-%M-%Y'), event_time=?, event_guest=?, event_venue=?, event_presentation=?, event_description=?, status=? where binary event_id=?");
	}


	pst.setString(1,event_title);
	pst.setString(2,from_date);
	pst.setString(3,to_date);
	pst.setString(4,event_time);
	pst.setString(5,event_guest);
	pst.setString(6,event_venue);
	pst.setString(7,event_presentation);
	pst.setString(8,event_desc);
	pst.setString(9,"O");
	pst.setString(10,event_id);

	pst.executeUpdate();
	con.commit();
	%>
	Event Successfully Created / Updated
	<%
}
catch(Exception e1){
	e1.printStackTrace();
%>
Error while Creating Event
<%
}
finally {
	if(con!=null)
		con.close();
	con=null; pst=null;
}
%>