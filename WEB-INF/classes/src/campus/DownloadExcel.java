/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import java.io.ByteArrayOutputStream;
/*   4:    */ import java.io.IOException;
/*   7:    */ import java.sql.Connection;
/*   8:    */ import java.sql.PreparedStatement;
/*   9:    */ import java.sql.ResultSet;
/*  10:    */ import java.sql.ResultSetMetaData;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
/*  11:    */ import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
/*  12:    */ import java.util.StringTokenizer;

/*  13:    */ import javax.servlet.ServletConfig;
/*  14:    */ import javax.servlet.ServletException;
/*  15:    */ import javax.servlet.ServletOutputStream;
/*  16:    */ import javax.servlet.http.HttpServlet;
/*  17:    */ import javax.servlet.http.HttpServletRequest;
/*  18:    */ import javax.servlet.http.HttpServletResponse;

/*  20:    */ import org.apache.poi.hssf.usermodel.HSSFCell;
/*  23:    */ import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
/*  21:    */ import org.apache.poi.hssf.usermodel.HSSFRow;
/*  22:    */ import org.apache.poi.hssf.usermodel.HSSFSheet;
/*  23:    */ import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/*  25:    */ public class DownloadExcel extends HttpServlet
/*  27:    */ {
/*  28:    */   public void init(ServletConfig paramServletConfig) throws ServletException
/*  30:    */   {
/*  31: 21 */     super.init(paramServletConfig);
/*  32:    */   }
/*  33:    */   
/*  34:    */   public void service(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse) throws ServletException, IOException
/*  36:    */   {
/*  37: 26 */     ArrayList localArrayList1 = new ArrayList();
				  ArrayList localObject1 = new ArrayList();
/*  38: 27 */     ArrayList localArrayList2 = new ArrayList();
					ArrayList arrColumn = new ArrayList();
					ArrayList arrObj= new ArrayList();
					ArrayList arrCol = new ArrayList();
					
/*  39: 28 */     Connection localConnection = null;
/*  40: 29 */     PreparedStatement localPreparedStatement = null, pst=null;
/*  41: 30 */     ResultSet localResultSet = null, rs=null;

					DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
					Date date = new Date();
					System.out.println(dateFormat.format(date));
					
					Calendar cal = Calendar.getInstance();
					
/*  42: 31 */     String str1 = (String)paramHttpServletRequest.getSession().getAttribute("login_id");
/*  43: 32 */     String str2 = paramHttpServletRequest.getParameter("profile_id");
/*  44: 33 */     String str3 = "details_" + str1 +"_"+dateFormat.format(cal.getTime())+".xls";
/*  45: 34 */     ServletOutputStream localServletOutputStream = null;
/*  46:    */     try
/*  47:    */     {
/*  48: 37 */       StringTokenizer localStringTokenizer = new StringTokenizer(str2, ",");
/*  49: 38 */       ArrayList localArrayList3 = new ArrayList();
/*  50: 39 */       while (localStringTokenizer.hasMoreTokens()){
/*  51: 40 */         localArrayList3.add(localStringTokenizer.nextToken());
/*  52:    */       }
/*  53: 42 */       localConnection = ConnectDatabase.getConnection();

pst = localConnection.prepareStatement("SELECT DATE_FORMAT(submission_date,'%d/%m/%Y') AS Applied_Date, f_appn_no AS Application_No, exam_pref AS Exam_Type, city_centre AS Exam_Center, IF(STRCMP(pay_status,'C')=0,'Paid','Not Paid') Application_Fees_Paid, first_name AS Candidate_Name, city AS City, state AS State, course AS Course, choice_1 AS 1st_PREFERENCE, choice_2 AS 2nd_PREFERENCE, choice_3 AS 3rd_PREFERENCE, mobile_no AS Mobile, email_id AS Email_ID, parent_name AS Parent_Name, address AS Address FROM application WHERE appn_no=1");

/*  54: 43 */       localPreparedStatement = localConnection.prepareStatement("SELECT DATE_FORMAT(submission_date,'%d/%m/%Y') AS Applied_Date, f_appn_no AS Application_No, exam_pref AS Exam_Type, (SELECT t.centre FROM application AS a LEFT JOIN test_city_centre AS t ON a.city_centre = t.centre_code WHERE a.appn_no=?) AS Exam_Center, IF(STRCMP(pay_status,'C')=0,'Paid','Not Paid') Application_Fees_Paid, first_name AS Candidate_Name, city AS City, state AS State, course AS Course, (SELECT c.course_name FROM application AS a LEFT JOIN course AS c ON a.choice_1 = c.course_id WHERE a.appn_no=?) AS 1st_PREFERENCE, (SELECT c.course_name FROM application AS a LEFT JOIN course AS c ON a.choice_2 = c.course_id WHERE a.appn_no=?) AS 2nd_PREFERENCE, (SELECT c.course_name FROM application AS a LEFT JOIN course AS c ON a.choice_3 = c.course_id WHERE a.appn_no=?) AS 3rd_PREFERENCE, mobile_no AS Mobile, email_id AS Email_ID, parent_name AS Parent_Name, address AS Address FROM application WHERE appn_no=?");
/*  55: 44 */       int i = 0;
int z = 0;
for (int j = 0; j < localArrayList3.size(); j++)
{
localPreparedStatement.setString(1, (String)localArrayList3.get(j));
localPreparedStatement.setString(2, (String)localArrayList3.get(j));
localPreparedStatement.setString(3, (String)localArrayList3.get(j));
localPreparedStatement.setString(4, (String)localArrayList3.get(j));
localPreparedStatement.setString(5, (String)localArrayList3.get(j));
rs = pst.executeQuery();
localResultSet = localPreparedStatement.executeQuery();
/*  61: 50 */         if (j == 0)
/*  62:    */         {
/*  63: 51 */           ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
ResultSetMetaData rsm = rs.getMetaData();
/*  64: 52 */           localArrayList2 = new ArrayList();
arrColumn = new ArrayList();
/*  65: 53 */           i = localResultSetMetaData.getColumnCount();
z = rsm.getColumnCount();
/*  66: 54 */           for (int m = 0; m < localResultSetMetaData.getColumnCount(); m++) {
/*  67: 55 */             localArrayList2.add(localResultSetMetaData.getColumnName(m + 1));
/*  68:    */           }
for (int m = 0; m < rsm.getColumnCount(); m++) 
{
	arrColumn.add(rsm.getColumnName(m + 1));
}
/*  69: 57 */           localArrayList1.add(localArrayList2);
arrCol.add(arrColumn);
/*  70:    */         }
/*  71: 59 */         if (localResultSet.next())
/*  72:    */         {
/*  73: 60 */           localArrayList2 = new ArrayList();
/*  74: 61 */           for (int k = 0; k < i; k++) {
/*  75: 62 */             localArrayList2.add(localResultSet.getString(k + 1));
/*  76:    */           }
/*  77:    */         }
if (rs.next())
{
	localArrayList2 = new ArrayList();
	for (int k = 0; k < i; k++) 
	{
		arrColumn.add(rs.getString(k + 1));
	}
}
/*  78: 64 */         localResultSet = null;
rs = null;
/*  79: 65 */         localArrayList1.add(localArrayList2);
arrCol.add(arrColumn);
/*  80:    */       }
/*  82: 68 */       HSSFWorkbook localHSSFWorkbook = new HSSFWorkbook();
/*  83: 69 */       HSSFSheet localHSSFSheet = localHSSFWorkbook.createSheet();
					HSSFCellStyle myStyle = localHSSFWorkbook.createCellStyle();
					HSSFCellStyle fontStyle = localHSSFWorkbook.createCellStyle();
					HSSFFont font=localHSSFWorkbook.createFont();
/*  84: 70 */       HSSFRow localHSSFRow = null;
/*  85: 71 */       HSSFCell localHSSFCell = null;

font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
fontStyle.setFont(font);

myStyle.setAlignment(HSSFCellStyle.ALIGN_JUSTIFY);
myStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

for (int n = 0; n < arrCol.size(); n++)
{
	arrObj = (ArrayList)arrCol.get(n);
	localHSSFRow = localHSSFSheet.createRow(n);
						
	for (int i1 = 0; i1 < ((ArrayList)arrObj).size(); i1++)
	{
		localHSSFCell = localHSSFRow.createCell(i1);
		localHSSFCell.setCellValue((String)((ArrayList)arrObj).get(i1));
		localHSSFCell.setCellStyle(fontStyle);
	}
}
localHSSFSheet.autoSizeColumn(0);

/*  86: 72 */       for (int n = 1; n < localArrayList1.size(); n++)
/*  87:    */       {
/*  88: 73 */         localObject1 = (ArrayList)localArrayList1.get(n);
/*  89: 74 */         localHSSFRow = localHSSFSheet.createRow(n);
					
/*  90: 75 */         for (int i1 = 0; i1 < ((ArrayList)localObject1).size(); i1++)
/*  91:    */         {
/*  92: 76 */           localHSSFCell = localHSSFRow.createCell(i1);
/*  93: 77 */           localHSSFCell.setCellValue((String)((ArrayList)localObject1).get(i1));
						localHSSFCell.setCellStyle(myStyle);
/*  94:    */         }
/*  95:    */       }
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
/*  96: 82 */       ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
/*  97: 83 */       localHSSFWorkbook.write(localByteArrayOutputStream);
/*  98: 84 */       Object localObjects = localByteArrayOutputStream.toByteArray();
/*  99: 85 */       paramHttpServletResponse.setContentType("application/ms-excel");
/* 100: 86 */       //paramHttpServletResponse.setContentLength(localObjects.length());
/* 101: 87 */       paramHttpServletResponse.setHeader("Expires:", "0");
/* 102: 88 */       paramHttpServletResponse.setHeader("Content-Disposition", "attachment; filename=" + str3);
/* 103: 89 */       localServletOutputStream = paramHttpServletResponse.getOutputStream();
/* 104: 90 */       localServletOutputStream.write((byte[])localObjects);
/* 105: 91 */       localServletOutputStream.flush();
/* 106: 92 */       localServletOutputStream.close();
/* 107:    */     }
/* 108:    */     catch (Exception localException2)
/* 109:    */     {
/* 110: 94 */       System.out.println("Download Excel " + localException2.toString());
/* 111:    */     }
/* 112:    */     finally
/* 113:    */     {
/* 114:    */       try
/* 115:    */       {
/* 116: 98 */         if (localConnection != null) {
/* 117: 99 */           localConnection.close();
/* 118:    */         }
/* 119:    */       }
/* 120:    */       catch (Exception localException4)
/* 121:    */       {
/* 122:103 */         localException4.printStackTrace();
/* 123:    */       }
/* 124:105 */       localConnection = null;localPreparedStatement = null;
/* 125:    */     }
/* 126:    */   }
/* 127:    */ }