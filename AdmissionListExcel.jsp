<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>

<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="javax.servlet.ServletConfig"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFCellStyle"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Allotment List</title>
    </head>
    <body>
<%
	HttpServletRequest paramHttpServletRequest=null;
	HttpServletResponse paramHttpServletResponse=null;
    ArrayList localArrayList1 = new ArrayList();
    ArrayList localObject1 = new ArrayList();
    ArrayList localArrayList2 = new ArrayList();
    ArrayList arrColumn = new ArrayList();
    ArrayList arrObj = new ArrayList();
    ArrayList arrCol = new ArrayList();

    Connection localConnection = null;
    PreparedStatement localPreparedStatement = null; PreparedStatement pst = null;
    ResultSet localResultSet = null; ResultSet rs = null;

    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

    Date date = new Date();
    System.out.println(dateFormat.format(date));

    Calendar cal = Calendar.getInstance();

    String str1 = "Admin";
    String str2 = "Profile";
    String str3 = "details_" + str1 + "_" + dateFormat.format(cal.getTime()) + ".xls";
    ServletOutputStream localServletOutputStream = null;
    try
    {
      StringTokenizer localStringTokenizer = new StringTokenizer(str2, ",");
      ArrayList localArrayList3 = new ArrayList();
      while (localStringTokenizer.hasMoreTokens()) {
        localArrayList3.add(localStringTokenizer.nextToken());
      }
      localConnection = ConnectDatabase.getConnection();

      pst = localConnection.prepareStatement("SELECT full_adm_no, stu_name, par_name, course, branch, tution_fee, mobile, email, pay_type_1, cash_ref_no_1, dd_no_1, amount_1 FROM student_admission");

      localPreparedStatement = localConnection.prepareStatement("SELECT full_adm_no, stu_name, par_name, course, branch, tution_fee, mobile, email, pay_type_1, cash_ref_no_1, dd_no_1, amount_1 FROM student_admission");
      int i = 0;
      int z = 0;
      for (int j = 0; j < localArrayList3.size(); j++)
      {
        localPreparedStatement.setString(1, (String)localArrayList3.get(j));
        rs = pst.executeQuery();
        localResultSet = localPreparedStatement.executeQuery();
        if (j == 0)
        {
          ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
          ResultSetMetaData rsm = rs.getMetaData();
          localArrayList2 = new ArrayList();
          arrColumn = new ArrayList();
          i = localResultSetMetaData.getColumnCount();
          z = rsm.getColumnCount();
          for (int m = 0; m < localResultSetMetaData.getColumnCount(); m++) {
            localArrayList2.add(localResultSetMetaData.getColumnName(m + 1));
          }
          for (int m = 0; m < rsm.getColumnCount(); m++)
          {
            arrColumn.add(rsm.getColumnName(m + 1));
          }
          localArrayList1.add(localArrayList2);
          arrCol.add(arrColumn);
        }
        if (localResultSet.next())
        {
          localArrayList2 = new ArrayList();
          for (int k = 0; k < i; k++) {
            localArrayList2.add(localResultSet.getString(k + 1));
          }
        }
        if (rs.next())
        {
          localArrayList2 = new ArrayList();
          for (int k = 0; k < i; k++)
          {
            arrColumn.add(rs.getString(k + 1));
          }
        }
        localResultSet = null;
        rs = null;
        localArrayList1.add(localArrayList2);
        arrCol.add(arrColumn);
      }
      HSSFWorkbook localHSSFWorkbook = new HSSFWorkbook();
      HSSFSheet localHSSFSheet = localHSSFWorkbook.createSheet();
      HSSFCellStyle myStyle = localHSSFWorkbook.createCellStyle();
      HSSFCellStyle fontStyle = localHSSFWorkbook.createCellStyle();
      HSSFFont font = localHSSFWorkbook.createFont();
      HSSFRow localHSSFRow = null;
      HSSFCell localHSSFCell = null;

      //font.setBoldweight(700);
      fontStyle.setFont(font);

      //myStyle.setAlignment(5);
      //myStyle.setVerticalAlignment(1);

      for (int n = 0; n < arrCol.size(); n++)
      {
        arrObj = (ArrayList)arrCol.get(n);
        localHSSFRow = localHSSFSheet.createRow(n);

        for (int i1 = 0; i1 < arrObj.size(); i1++)
        {
          localHSSFCell = localHSSFRow.createCell(i1);
          localHSSFCell.setCellValue((String)arrObj.get(i1));
          localHSSFCell.setCellStyle(fontStyle);
        }
      }
      localHSSFSheet.autoSizeColumn(0);

      for (int n = 1; n < localArrayList1.size(); n++)
      {
        localObject1 = (ArrayList)localArrayList1.get(n);
        localHSSFRow = localHSSFSheet.createRow(n);

        for (int i1 = 0; i1 < localObject1.size(); i1++)
        {
          localHSSFCell = localHSSFRow.createCell(i1);
          localHSSFCell.setCellValue((String)localObject1.get(i1));
          localHSSFCell.setCellStyle(myStyle);
        }
      }
      localHSSFSheet.autoSizeColumn(0);
      localHSSFSheet.autoSizeColumn(1);
      localHSSFSheet.autoSizeColumn(2);
      localHSSFSheet.autoSizeColumn(3);
      localHSSFSheet.autoSizeColumn(4);
      localHSSFSheet.autoSizeColumn(5);
      localHSSFSheet.autoSizeColumn(6);
      localHSSFSheet.autoSizeColumn(7);
      localHSSFSheet.autoSizeColumn(8);
      localHSSFSheet.autoSizeColumn(9);
      localHSSFSheet.autoSizeColumn(10);
      localHSSFSheet.autoSizeColumn(11);
      localHSSFSheet.autoSizeColumn(12);
      localHSSFSheet.autoSizeColumn(13);
      localHSSFSheet.autoSizeColumn(14);
      localHSSFSheet.autoSizeColumn(15);
      ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
      localHSSFWorkbook.write(localByteArrayOutputStream);
      Object localObjects = localByteArrayOutputStream.toByteArray();
      paramHttpServletResponse.setContentType("application/ms-excel");

      paramHttpServletResponse.setHeader("Expires:", "0");
      paramHttpServletResponse.setHeader("Content-Disposition", "attachment; filename=" + str3);
      localServletOutputStream = paramHttpServletResponse.getOutputStream();
      localServletOutputStream.write((byte[])localObjects);
      localServletOutputStream.flush();
      localServletOutputStream.close();
	}
	catch(Exception e1){
		e1.printStackTrace();
	}
	finally {
		if(localConnection!=null)
			localConnection.close();
		localConnection=null; pst=null;
	}
	%>
    </body>
    <script>

     </script>
</html>