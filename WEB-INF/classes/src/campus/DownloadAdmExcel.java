/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import java.io.ByteArrayOutputStream;
/*   4:    */ import java.io.IOException;
/*   5:    */ import java.io.PrintStream;
/*   6:    */ import java.sql.Connection;
/*   7:    */ import java.sql.PreparedStatement;
/*   8:    */ import java.sql.ResultSet;
/*   9:    */ import java.sql.ResultSetMetaData;
/*  10:    */ import java.text.DateFormat;
/*  11:    */ import java.text.SimpleDateFormat;
/*  12:    */ import java.util.ArrayList;
/*  13:    */ import java.util.Calendar;
/*  14:    */ import java.util.Date;
/*  15:    */ import java.util.StringTokenizer;
/*  16:    */ import javax.servlet.ServletConfig;
/*  17:    */ import javax.servlet.ServletException;
/*  18:    */ import javax.servlet.ServletOutputStream;
/*  19:    */ import javax.servlet.http.HttpServlet;
/*  20:    */ import javax.servlet.http.HttpServletRequest;
/*  21:    */ import javax.servlet.http.HttpServletResponse;
/*  22:    */ import javax.servlet.http.HttpSession;
/*  23:    */ import org.apache.poi.hssf.usermodel.HSSFCell;
/*  24:    */ import org.apache.poi.hssf.usermodel.HSSFCellStyle;
/*  25:    */ import org.apache.poi.hssf.usermodel.HSSFFont;
/*  26:    */ import org.apache.poi.hssf.usermodel.HSSFRow;
/*  27:    */ import org.apache.poi.hssf.usermodel.HSSFSheet;
/*  28:    */ import org.apache.poi.hssf.usermodel.HSSFWorkbook;
/*  29:    */ 
/*  30:    */ public class DownloadAdmExcel
/*  31:    */   extends HttpServlet
/*  32:    */ {
/*  33:    */   public void init(ServletConfig paramServletConfig)
/*  34:    */     throws ServletException
/*  35:    */   {
/*  36: 40 */     super.init(paramServletConfig);
/*  37:    */   }
/*  38:    */   
/*  39:    */   public void service(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
/*  40:    */     throws ServletException, IOException
/*  41:    */   {
/*  42: 46 */     ArrayList localArrayList1 = new ArrayList();
/*  43: 47 */     ArrayList localObject1 = new ArrayList();
/*  44: 48 */     ArrayList localArrayList2 = new ArrayList();
/*  45: 49 */     ArrayList arrColumn = new ArrayList();
/*  46: 50 */     ArrayList arrObj = new ArrayList();
/*  47: 51 */     ArrayList arrCol = new ArrayList();
/*  48: 52 */     Connection localConnection = null;
/*  49: 53 */     PreparedStatement localPreparedStatement = null;PreparedStatement pst = null;
/*  50: 54 */     ResultSet localResultSet = null;ResultSet rs = null;
/*  51:    */     
/*  52: 56 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  53:    */     
/*  54: 58 */     Date date = new Date();
/*  55: 59 */     System.out.println(dateFormat.format(date));
/*  56:    */     
/*  57:    */ 
/*  58: 62 */     Calendar cal = Calendar.getInstance();
/*  59:    */     
/*  60: 64 */     String str1 = (String)paramHttpServletRequest.getSession().getAttribute("login_id");
/*  61: 65 */     String str2 = paramHttpServletRequest.getParameter("profile_id");
/*  62: 66 */     String str3 = "details_" + str1 + "_" + dateFormat.format(cal.getTime()) + ".xls";
/*  63: 67 */     ServletOutputStream localServletOutputStream = null;
/*  64:    */     try
/*  65:    */     {
/*  66: 70 */       StringTokenizer localStringTokenizer = new StringTokenizer(str2, ",");
/*  67: 71 */       ArrayList localArrayList3 = new ArrayList();
/*  68: 72 */       while (localStringTokenizer.hasMoreTokens()) {
/*  69: 73 */         localArrayList3.add(localStringTokenizer.nextToken());
/*  70:    */       }
/*  71: 75 */       localConnection = ConnectDatabase.getConnection();
					//pst = localConnection.prepareStatement("SELECT full_adm_no AS Allotment_No, appn_no AS App_Num, app_date AS App_Date, stu_name AS Student_Name, par_name AS Parent_Name, course AS Course, branch AS Branch, tution_fee AS Tuition_Fee, mobile AS Mobile, email AS Email, pay_type_1 AS Paid_By, cash_ref_no_1 AS Cash_Ref_No, dd_no_1 AS DD_No, amount_1 AS Paid_Amount FROM student_admission WHERE full_adm_no=1");
/*  71: 69 */       pst = localConnection.prepareStatement("SELECT adm_no,full_adm_no,appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,std,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_status_1,challan_issue_date_1,challan_ack_date_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_status_2,challan_issue_date_2,challan_ack_date_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_status_3,challan_issue_date_3,challan_ack_date_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_status_4,challan_issue_date_4,challan_ack_date_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,total_paid,inserted_by,inserted_time,updated_by,updated_time FROM student_admission WHERE full_adm_no=1");
/*  72:    */       //localPreparedStatement = localConnection.prepareStatement("SELECT full_adm_no AS Allotment_No, appn_no AS App_Num, app_date AS App_Date, stu_name AS Student_Name, par_name AS Parent_Name, course AS Course, branch AS Branch, tution_fee AS Tuition_Fee, mobile AS Mobile, email AS Email, pay_type_1 AS Paid_By, cash_ref_no_1 AS Cash_Ref_No, dd_no_1 AS DD_No, amount_1 AS Paid_Amount FROM student_admission WHERE full_adm_no=?");
/*  73: 71 */       localPreparedStatement = localConnection.prepareStatement("SELECT adm_no,full_adm_no,appn_no,app_date,stu_name,par_name,dob,gender,community,course,branch,student_type,address,city,state,country,pin,std,phone,mobile,email,adm_status,adm_quota,fixed_tuition_fee,concession_type,pcm_marks,concession_amt,reference,other_reference_name,other_reference_contact,hostel,transport,admission_fee,cash_receipt_no_1,cash_amount_1,cash_receipt_date_1,challan_no_1,challan_amount_1,challan_status_1,challan_issue_date_1,challan_ack_date_1,challan_reason_1,dd_receipt_no_1,dd_amount_1,dd_bank_1,dd_drawn_date_1,dd_no_1,dd_submit_date_1,cash_receipt_no_2,cash_amount_2,cash_receipt_date_2,challan_no_2,challan_amount_2,challan_status_2,challan_issue_date_2,challan_ack_date_2,challan_reason_2,dd_receipt_no_2,dd_amount_2,dd_bank_2,dd_drawn_date_2,dd_no_2,dd_submit_date_2,cash_receipt_no_3,cash_amount_3,cash_receipt_date_3,challan_no_3,challan_amount_3,challan_status_3,challan_issue_date_3,challan_ack_date_3,challan_reason_3,dd_receipt_no_3,dd_amount_3,dd_bank_3,dd_drawn_date_3,dd_no_3,dd_submit_date_3,cash_receipt_no_4,cash_amount_4,cash_receipt_date_4,challan_no_4,challan_amount_4,challan_status_4,challan_issue_date_4,challan_ack_date_4,challan_reason_4,dd_receipt_no_4,dd_amount_4,dd_bank_4,dd_drawn_date_4,dd_no_4,dd_submit_date_4,total_paid,inserted_by,inserted_time,updated_by,updated_time FROM student_admission WHERE full_adm_no=?");
/*  76: 80 */       int i = 0;
/*  77: 81 */       int z = 0;
/*  78: 82 */       for (int j = 0; j < localArrayList3.size(); j++)
/*  79:    */       {
/*  80: 84 */         System.out.println("Appn No " + localArrayList3.get(j));
/*  81: 85 */         localPreparedStatement.setString(1, (String)localArrayList3.get(j));
/*  82: 86 */         rs = pst.executeQuery();
/*  83: 87 */         localResultSet = localPreparedStatement.executeQuery();
/*  84: 88 */         if (j == 0)
/*  85:    */         {
/*  86: 90 */           ResultSetMetaData localResultSetMetaData = localResultSet.getMetaData();
/*  87: 91 */           ResultSetMetaData rsm = rs.getMetaData();
/*  88: 92 */           localArrayList2 = new ArrayList();
/*  89: 93 */           arrColumn = new ArrayList();
/*  90: 94 */           i = localResultSetMetaData.getColumnCount();
/*  91: 95 */           z = rsm.getColumnCount();
/*  92: 96 */           for (int m = 0; m < localResultSetMetaData.getColumnCount(); m++) {
/*  93: 97 */             localArrayList2.add(localResultSetMetaData.getColumnName(m + 1));
/*  94:    */           }
/*  95: 99 */           for (int m = 0; m < rsm.getColumnCount(); m++) {
/*  96:101 */             arrColumn.add(rsm.getColumnName(m + 1));
/*  97:    */           }
/*  98:103 */           localArrayList1.add(localArrayList2);
/*  99:104 */           arrCol.add(arrColumn);
/* 100:    */         }
/* 101:106 */         if (localResultSet.next())
/* 102:    */         {
/* 103:108 */           localArrayList2 = new ArrayList();
/* 104:109 */           for (int k = 0; k < i; k++) {
/* 105:110 */             localArrayList2.add(localResultSet.getString(k + 1));
/* 106:    */           }
/* 107:    */         }
/* 108:113 */         if (rs.next())
/* 109:    */         {
/* 110:115 */           localArrayList2 = new ArrayList();
/* 111:116 */           for (int k = 0; k < i; k++) {
/* 112:118 */             arrColumn.add(rs.getString(k + 1));
/* 113:    */           }
/* 114:    */         }
/* 115:121 */         localResultSet = null;
/* 116:122 */         rs = null;
/* 117:123 */         localArrayList1.add(localArrayList2);
/* 118:124 */         arrCol.add(arrColumn);
/* 119:    */       }
/* 120:126 */       System.out.println("alRows -> " + localArrayList1);
/* 121:127 */       HSSFWorkbook localHSSFWorkbook = new HSSFWorkbook();
/* 122:128 */       HSSFSheet localHSSFSheet = localHSSFWorkbook.createSheet();
/* 123:129 */       HSSFCellStyle myStyle = localHSSFWorkbook.createCellStyle();
/* 124:130 */       HSSFCellStyle fontStyle = localHSSFWorkbook.createCellStyle();
/* 125:131 */       HSSFFont font = localHSSFWorkbook.createFont();
/* 126:132 */       HSSFRow localHSSFRow = null;
/* 127:133 */       HSSFCell localHSSFCell = null;
/* 128:    */       
/* 129:    */ 
/* 130:    */ 
/* 131:137 */       font.setBoldweight((short)700);
/* 132:138 */       fontStyle.setFont(font);
/* 133:    */       
/* 134:140 */       myStyle.setAlignment((short)5);
/* 135:141 */       myStyle.setVerticalAlignment((short)1);
/* 136:143 */       for (int n = 0; n < arrCol.size(); n++)
/* 137:    */       {
/* 138:145 */         arrObj = (ArrayList)arrCol.get(n);
/* 139:146 */         localHSSFRow = localHSSFSheet.createRow(n);
/* 140:148 */         for (int i1 = 0; i1 < arrObj.size(); i1++)
/* 141:    */         {
/* 142:150 */           localHSSFCell = localHSSFRow.createCell(i1);
/* 143:151 */           localHSSFCell.setCellValue((String)arrObj.get(i1));
/* 144:152 */           localHSSFCell.setCellStyle(fontStyle);
/* 145:    */         }
/* 146:    */       }
/* 147:155 */       localHSSFSheet.autoSizeColumn(0);
/* 148:157 */       for (int n = 1; n < localArrayList1.size(); n++)
/* 149:    */       {
/* 150:159 */         localObject1 = (ArrayList)localArrayList1.get(n);
/* 151:160 */         localHSSFRow = localHSSFSheet.createRow(n);
/* 152:162 */         for (int i1 = 0; i1 < localObject1.size(); i1++)
/* 153:    */         {
/* 154:164 */           localHSSFCell = localHSSFRow.createCell(i1);
/* 155:165 */           localHSSFCell.setCellValue((String)localObject1.get(i1));
/* 156:166 */           localHSSFCell.setCellStyle(myStyle);
/* 157:    */         }
/* 158:    */       }
/* 159:169 */       localHSSFSheet.autoSizeColumn(0);
/* 160:170 */       localHSSFSheet.autoSizeColumn(1);
/* 161:171 */       localHSSFSheet.autoSizeColumn(2);
/* 162:172 */       localHSSFSheet.autoSizeColumn(3);
/* 163:173 */       localHSSFSheet.autoSizeColumn(4);
/* 164:174 */       localHSSFSheet.autoSizeColumn(5);
/* 165:175 */       localHSSFSheet.autoSizeColumn(6);
/* 166:176 */       localHSSFSheet.autoSizeColumn(7);
/* 167:177 */       localHSSFSheet.autoSizeColumn(8);
/* 168:178 */       localHSSFSheet.autoSizeColumn(9);
/* 169:179 */       localHSSFSheet.autoSizeColumn(10);
/* 170:180 */       localHSSFSheet.autoSizeColumn(11);
/* 171:181 */       localHSSFSheet.autoSizeColumn(12);
/* 172:182 */       localHSSFSheet.autoSizeColumn(13);
/* 173:183 */       localHSSFSheet.autoSizeColumn(14);
/* 174:184 */       localHSSFSheet.autoSizeColumn(15);
/* 175:185 */       ByteArrayOutputStream localByteArrayOutputStream = new ByteArrayOutputStream();
/* 176:186 */       localHSSFWorkbook.write(localByteArrayOutputStream);
/* 177:187 */       Object localObjects = localByteArrayOutputStream.toByteArray();
/* 178:188 */       paramHttpServletResponse.setContentType("application/ms-excel");
/* 179:    */       
/* 180:190 */       paramHttpServletResponse.setHeader("Expires:", "0");
/* 181:191 */       paramHttpServletResponse.setHeader("Content-Disposition", "attachment; filename=" + str3);
/* 182:192 */       localServletOutputStream = paramHttpServletResponse.getOutputStream();
/* 183:193 */       localServletOutputStream.write((byte[])localObjects);
/* 184:194 */       localServletOutputStream.flush();
/* 185:195 */       localServletOutputStream.close();
/* 186:    */     }
/* 187:    */     catch (Exception localException2)
/* 188:    */     {
/* 189:199 */       System.out.println("Download Excel " + localException2.toString());
/* 190:    */     }
/* 191:    */     finally
/* 192:    */     {
/* 193:    */       try
/* 194:    */       {
/* 195:205 */         if (localConnection != null) {
/* 196:206 */           localConnection.close();
/* 197:    */         }
/* 198:    */       }
/* 199:    */       catch (Exception localException4)
/* 200:    */       {
/* 201:211 */         localException4.printStackTrace();
/* 202:    */       }
/* 203:213 */       localConnection = null;localPreparedStatement = null;
/* 204:    */     }
/* 205:    */   }
/* 206:    */ }


/* Location:           C:\Tomcat 8.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.DownloadExcel
 * JD-Core Version:    0.7.0.1
 */