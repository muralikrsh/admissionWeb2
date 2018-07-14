/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import java.io.IOException;
/*   4:    */ import java.io.PrintStream;
/*   5:    */ import java.sql.Connection;
/*   6:    */ import java.sql.PreparedStatement;
/*   7:    */ import java.sql.ResultSet;
/*   8:    */ import java.util.ArrayList;
/*   9:    */ import javax.servlet.ServletConfig;
/*  10:    */ import javax.servlet.ServletContext;
/*  11:    */ import javax.servlet.ServletException;
/*  12:    */ import javax.servlet.http.HttpServlet;
/*  13:    */ import javax.servlet.http.HttpServletRequest;
/*  14:    */ import javax.servlet.http.HttpServletResponse;
/*  15:    */ 
/*  16:    */ public class ServletInitializer
/*  17:    */   extends HttpServlet
/*  18:    */ {
/*  19:    */   public void init(ServletConfig paramServletConfig)
/*  20:    */     throws ServletException
/*  21:    */   {
/*  22: 17 */     System.out.println("************");
/*  23: 18 */     System.out.println("*** Servlet Initialized successfully ***..");
/*  24: 19 */     System.out.println("***********");
/*  25: 20 */     ServletContext localServletContext = paramServletConfig.getServletContext();
/*  26:    */     
/*  27: 22 */     Connection localConnection = null;
/*  28: 23 */     PreparedStatement localPreparedStatement = null;
/*  29: 24 */     ResultSet localResultSet = null;
/*  30:    */     try
/*  31:    */     {
/*  32: 30 */       localConnection = ConnectDatabase.getConnection();
/*  33: 31 */       System.out.println(localConnection);
/*  34: 32 */       localPreparedStatement = localConnection.prepareStatement("select company_id, company_name from company order by company_name");
/*  35: 33 */       localResultSet = localPreparedStatement.executeQuery();
/*  36:    */       
/*  37: 35 */       ArrayList localArrayList1 = new ArrayList();
/*  38: 36 */       ArrayList localArrayList2 = new ArrayList();
/*  39: 37 */       while (localResultSet.next())
/*  40:    */       {
/*  41: 38 */         localArrayList1.add(localResultSet.getString(1));
/*  42: 39 */         localArrayList2.add(localResultSet.getString(2));
/*  43:    */       }
/*  44: 41 */       localServletContext.setAttribute("COMPANY_ID", localArrayList1);
/*  45: 42 */       localServletContext.setAttribute("COMPANY_NAME", localArrayList2);
/*  46:    */       
/*  47: 44 */       localPreparedStatement = localConnection.prepareStatement("select quiz_id, quiz_title from quiz_master order by quiz_title");
/*  48: 45 */       localResultSet = localPreparedStatement.executeQuery();
/*  49:    */       
/*  50: 47 */       ArrayList localArrayList3 = new ArrayList();
/*  51: 48 */       ArrayList localArrayList4 = new ArrayList();
/*  52: 49 */       while (localResultSet.next())
/*  53:    */       {
/*  54: 50 */         localArrayList3.add(localResultSet.getString(1));
/*  55: 51 */         localArrayList4.add(localResultSet.getString(2));
/*  56:    */       }
/*  57: 53 */       localServletContext.setAttribute("QUIZ_ID", localArrayList3);
/*  58: 54 */       localServletContext.setAttribute("QUIZ_TITLE", localArrayList4);
/*  59:    */       
/*  60: 56 */       localPreparedStatement = localConnection.prepareStatement("SELECT lang_code, lang_name from language");
/*  61: 57 */       localResultSet = localPreparedStatement.executeQuery();
/*  62:    */       
/*  63: 59 */       ArrayList localArrayList5 = new ArrayList();
/*  64: 60 */       ArrayList localArrayList6 = new ArrayList();
/*  65: 61 */       while (localResultSet.next())
/*  66:    */       {
/*  67: 62 */         localArrayList5.add(localResultSet.getString(1));
/*  68: 63 */         localArrayList6.add(localResultSet.getString(2));
/*  69:    */       }
/*  70: 65 */       localServletContext.setAttribute("LANG_CODE", localArrayList5);
/*  71: 66 */       localServletContext.setAttribute("LANG_NAME", localArrayList6);
/*  72:    */       
/*  73: 68 */       localPreparedStatement = localConnection.prepareStatement("SELECT state_name from state");
/*  74: 69 */       localResultSet = localPreparedStatement.executeQuery();
/*  75:    */       
/*  76: 71 */       ArrayList localArrayList7 = new ArrayList();
/*  77: 73 */       while (localResultSet.next()) {
/*  78: 74 */         localArrayList7.add(localResultSet.getString(1));
/*  79:    */       }
/*  80: 76 */       localServletContext.setAttribute("STATES", localArrayList7);
/*  81:    */       
/*  82: 78 */       localPreparedStatement = localConnection.prepareStatement("SELECT distinct a.job_id, concat(b.company_name, ' - ', job_title) FROM campus_placements a, company b, campus_jobs c where a.job_id=c.job_id  and c.company_id=b.company_id");
/*  83: 79 */       localResultSet = localPreparedStatement.executeQuery();
/*  84:    */       
/*  85: 81 */       ArrayList localArrayList8 = new ArrayList();
/*  86: 82 */       ArrayList localArrayList9 = new ArrayList();
/*  87: 83 */       while (localResultSet.next())
/*  88:    */       {
/*  89: 84 */         localArrayList8.add(localResultSet.getString(1));
/*  90: 85 */         localArrayList9.add(localResultSet.getString(2));
/*  91:    */       }
/*  92: 87 */       localServletContext.setAttribute("JOB_ID", localArrayList8);
/*  93: 88 */       localServletContext.setAttribute("JOB_TITLE", localArrayList9);
/*  94:    */       
/*  95: 90 */       localPreparedStatement = localConnection.prepareStatement("SELECT course_group, course_id, course_name from course where course_flag='A' ");
/*  96: 91 */       localResultSet = localPreparedStatement.executeQuery();
/*  97: 92 */       ArrayList localArrayList10 = new ArrayList();
/*  98: 94 */       while (localResultSet.next()) {
/*  99: 95 */         localArrayList10.add(localResultSet.getString(1) + "#" + localResultSet.getString(2) + "#" + localResultSet.getString(3));
/* 100:    */       }
/* 101: 97 */       localServletContext.setAttribute("COURSES", localArrayList10);
/* 102: 98 */       System.out.println(localArrayList10);
/* 103:    */       
/* 104:100 */       localPreparedStatement = localConnection.prepareStatement("SELECT distinct course_group from course");
/* 105:101 */       localResultSet = localPreparedStatement.executeQuery();
/* 106:102 */       ArrayList localArrayList11 = new ArrayList();
/* 107:104 */       while (localResultSet.next()) {
/* 108:105 */         localArrayList11.add(localResultSet.getString(1));
/* 109:    */       }
/* 110:107 */       localServletContext.setAttribute("COURSE_GROUP", localArrayList11);
/* 111:108 */       System.out.println(localArrayList11);
/* 112:    */       
/* 113:    */ 
/* 114:111 */       ArrayList localArrayList12 = new ArrayList();
/* 115:112 */       String str = "";
/* 116:    */       
/* 117:    */ 
/* 118:    */ 
/* 119:    */ 
/* 120:    */ 
/* 121:    */ 
/* 122:    */ 
/* 123:120 */       localArrayList12.add("B.E-CSE|CSW|IT|ECE|ETE|EIE|EEE|Auto|IBT|Mechatronics|CIVIL|MECH|E&I");
/* 124:121 */       localArrayList12.add("MBA-MBA");
/* 125:122 */       localArrayList12.add("MCA-MCA");
/* 126:123 */       localArrayList12.add("BIO-BIOMED|BIOINFO");
/* 127:    */       
/* 128:    */ 
/* 129:126 */       localServletContext.setAttribute("COMPANY_ID", localArrayList1);
/* 130:127 */       localServletContext.setAttribute("COMPANY_NAME", localArrayList2);
/* 131:    */       
/* 132:    */ 
/* 133:130 */       localServletContext.setAttribute("LOGO_PATH", "c:\\tomcat\\webapps\\photos\\logos\\");
/* 134:131 */       localServletContext.setAttribute("COURSE_SYLLABUS_PATH", "c:\\syllabus\\");
/* 135:132 */       localServletContext.setAttribute("LOGO_DISP_PATH", "http://localhost/photos/logos/");
/* 136:133 */       localServletContext.setAttribute("PHOTO_PATH", "c:\\tomcat\\webapps\\photos\\");
/* 137:134 */       localServletContext.setAttribute("PHOTO_PATH_OCE", "c:\\tomcat\\webapps\\photos\\oce\\");
/* 138:135 */       localServletContext.setAttribute("PDF_PATH", "c:\\profiles\\");
/* 139:136 */       localServletContext.setAttribute("QUIZ_PATH", "c:\\tomcat\\webapps\\quiz\\");
/* 140:137 */       localServletContext.setAttribute("TEMPLATE_PATH", "c:\\templates\\");
/* 141:138 */       localServletContext.setAttribute("OCEHT_PATH", "c:\\profiles\\oce\\");
/* 142:139 */       localServletContext.setAttribute("HALLTICKET_PATH", "c:\\HallTicket\\");
/* 143:140 */       localServletContext.setAttribute("AF_PATH", "c:\\AppForm\\");
/* 144:141 */       localServletContext.setAttribute("COUNSELINGLETTER_PATH", "c:\\CounselLetter\\");
/* 145:142 */       localServletContext.setAttribute("CL_BATCH", "gencounselletters.bat");
/* 146:143 */       localServletContext.setAttribute("INTIMATIONLETTER_PATH", "c:\\IntimationLetter\\");
/* 147:144 */       localServletContext.setAttribute("IL_BATCH", "genintimationletters.bat");
/* 148:145 */       localServletContext.setAttribute("HT_BATCH", "genhallticket.bat");
/* 149:146 */       localServletContext.setAttribute("EE_PATH", "c:\\ranklist\\");
/* 150:147 */       localServletContext.setAttribute("SYLLABUS_PATH", "c:\\syllabus\\");
/* 151:148 */       localServletContext.setAttribute("HT_LINK", "http://localhost/EventRegistration.jsp?id=");
/* 152:    */       
/* 153:    */ 
/* 154:    */ 
/* 155:    */ 
/* 156:    */ 
/* 157:    */ 
/* 158:    */ 
/* 159:    */ 
/* 160:    */ 
/* 161:    */ 
/* 162:    */ 
/* 163:    */ 
/* 164:    */ 
/* 165:    */ 
/* 166:    */ 
/* 167:    */ 
/* 168:    */ 
/* 169:    */ 
/* 170:    */ 
/* 171:    */ 
/* 172:    */ 
/* 173:    */ 
/* 174:    */ 
/* 175:    */ 
/* 176:    */ 
/* 177:174 */       localServletContext.setAttribute("DEGREES", localArrayList12);
/* 178:175 */       System.out.println(localArrayList12); return;
/* 179:    */     }
/* 180:    */     catch (Exception localException2)
/* 181:    */     {
/* 182:178 */       localException2.printStackTrace();
/* 183:    */     }
/* 184:    */     finally
/* 185:    */     {
/* 186:    */       try
/* 187:    */       {
/* 188:183 */         localConnection.close();
/* 189:    */       }
/* 190:    */       catch (Exception localException4)
/* 191:    */       {
/* 192:187 */         localException4.printStackTrace();
/* 193:    */       }
/* 194:    */     }
/* 195:    */   }
/* 196:    */   
/* 197:    */   public void service(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
/* 198:    */     throws ServletException, IOException
/* 199:    */   {}
/* 200:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.ServletInitializer
 * JD-Core Version:    0.7.0.1
 */