package campus;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.StringTokenizer;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class RegistrationListExcel extends HttpServlet
{
  public void init(ServletConfig paramServletConfig) throws ServletException
  {
    super.init(paramServletConfig);
  }
  
  public void service(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException
  {
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

	    String str1 = "Registration_List";
	    String str2 = paramHttpServletRequest.getParameter("profile_id");
	    String str3 = str1 + "_" + dateFormat.format(cal.getTime()) + ".xls";
	    ServletOutputStream localServletOutputStream = null;
	    try
	    {
	      StringTokenizer localStringTokenizer = new StringTokenizer(str2, ",");
	      ArrayList localArrayList3 = new ArrayList();
	      while (localStringTokenizer.hasMoreTokens()) {
	        localArrayList3.add(localStringTokenizer.nextToken());
	      }
	      localConnection = ConnectDatabase.getConnection();

	      pst = localConnection.prepareStatement("SELECT act_dt,NAME,email_id,mobile_no FROM adm_login where role='1'");

	      localPreparedStatement = localConnection.prepareStatement("SELECT date(act_dt),NAME,email_id,mobile_no FROM adm_login where role='student' and email_id=? order by act_dt desc");
	      int i = 0;
	      int z = 0;
	      for (int j = 0; j < localArrayList3.size(); j++)
	      {
	    	localPreparedStatement.setString(1, (String)localArrayList3.get(j));
	        rs = pst.executeQuery();
	        localResultSet = localPreparedStatement.executeQuery();
	        //System.out.println("localPreparedStatement== "+localPreparedStatement+""+(String)localArrayList3.get(j));
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

	      font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
	      fontStyle.setFont(font);

	      myStyle.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);
	      myStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

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
    catch (Exception localException2)
    {
      System.out.println("Download Excel " + localException2.toString());
    }
    finally
    {
      try
      {
        if (localConnection != null) {
          localConnection.close();
        }
      }
      catch (Exception localException4)
      {
        localException4.printStackTrace();
      }
      localConnection = null;localPreparedStatement = null;
    }
  }
}