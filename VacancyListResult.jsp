<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Connection con = null;
PreparedStatement pst = null;
String strCourseName=request.getParameter("CourseName");
String strVacancy=request.getParameter("Vacancy");
	

	try {
		con=ConnectDatabase.getConnection();

			pst=con.prepareStatement("UPDATE course SET vacancy=? WHERE course_name=?");
		
		pst.setString(1,strVacancy);
		pst.setString(2,strCourseName);
		System.out.println(pst);
		pst.executeUpdate();
		con.commit();
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