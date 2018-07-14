<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration Report</title>
</head>

<body>
    <%

	String exportToExcel = request.getParameter("exportToExcel");
	System.out.println(exportToExcel);
	if (exportToExcel != null && exportToExcel.toString().equalsIgnoreCase("YES")) 
	{
	    response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Disposition", "inline; filename=Registration_Excel_Report.xls");
	}
    %>
    
	<%@include file="RegistrationReport.jsp" %>
</body>
</html>