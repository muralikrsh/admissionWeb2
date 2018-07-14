/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import com.lowagie.text.Document;
/*   4:    */ import com.lowagie.text.Image;
/*   5:    */ import com.lowagie.text.PageSize;
/*   6:    */ import com.lowagie.text.pdf.PdfPCell;
/*   7:    */ import com.lowagie.text.pdf.PdfPTable;
/*   8:    */ import com.lowagie.text.pdf.PdfWriter;
/*   9:    */ import java.io.FileOutputStream;
/*  10:    */ import java.io.PrintStream;
/*  11:    */ import java.sql.Connection;
/*  12:    */ import java.sql.PreparedStatement;
/*  13:    */ import java.sql.ResultSet;
/*  14:    */ import java.util.ArrayList;
/*  15:    */ import java.util.HashMap;
/*  16:    */ 
/*  17:    */ public class OCEHTGenerator
/*  18:    */ {
/*  19: 12 */   Connection con = null;
/*  20: 13 */   PreparedStatement pst = null;
/*  21: 14 */   ResultSet rs = null;
/*  22: 15 */   ArrayList alMain = new ArrayList();
/*  23:    */   public static final String PDF_PATH = "/home/phnx1234/data/oceht/";
/*  24:    */   public static final String LOGO_PATH = "/home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/logos/";
/*  25:    */   public static final String PHOTO_PATH_OCE = "/home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/oce/";
/*  26: 21 */   String candidate_name = "";
/*  27: 22 */   String education = "";
/*  28: 23 */   String gender = "";
/*  29: 24 */   String percentage = "";
/*  30: 25 */   String dob = "";
/*  31: 26 */   String college_name = "";
/*  32: 27 */   String regn_no = "";
/*  33: 28 */   String mobile_no = "";
/*  34: 29 */   String email_id = "";
/*  35: 31 */   HashMap hmDeg = new HashMap();
/*  36:    */   
/*  37:    */   public void generateOCEHT(String paramString)
/*  38:    */     throws Exception
/*  39:    */   {
/*  40:    */     try
/*  41:    */     {
/*  42: 38 */       this.hmDeg.put("CSE", "Computer Science Engineering");
/*  43: 39 */       this.hmDeg.put("CSW", "Computer Software");
/*  44: 40 */       this.hmDeg.put("IT", "Information Technology");
/*  45: 41 */       this.hmDeg.put("ECE", "Electronics & Communication Engineering");
/*  46: 42 */       this.hmDeg.put("ETE", "Electronics & Telecommunication Engineering");
/*  47: 43 */       this.hmDeg.put("EIE", "Electronics & Instrumentation Engineering");
/*  48: 44 */       this.hmDeg.put("EEE", "Electrical & Electronics Engineering");
/*  49: 45 */       this.hmDeg.put("Auto", "Automobile Engineering");
/*  50: 46 */       this.hmDeg.put("IBT", "IBT");
/*  51: 47 */       this.hmDeg.put("Mechatronics", "Mechatronics");
/*  52: 48 */       this.hmDeg.put("CIVIL", "Civil Engineering");
/*  53: 49 */       this.hmDeg.put("MECH", "Mechanical Engineering");
/*  54: 50 */       this.hmDeg.put("E&I", "Electrical &Instrumentation Engineering");
/*  55: 51 */       this.hmDeg.put("MBA", "Master of Business Administration");
/*  56: 52 */       this.hmDeg.put("MCA", "Master of Computer Applications");
/*  57: 53 */       this.hmDeg.put("BIOMED", "Bio Medcal");
/*  58: 54 */       this.hmDeg.put("BIOINFO", "Bio Informatics");
/*  59:    */       
/*  60: 56 */       this.con = ConnectDatabase.getConnection();
/*  61: 57 */       this.con.setAutoCommit(false);
/*  62: 58 */       this.pst = this.con.prepareStatement("select ht_no, candidate_name, regn_no, mobile_no, email_id, education, gender, percentage, date_format(dob,'%d-%b-%Y') as dob, college_name  from oce_application a, college b where a.college_id=b.college_id and binary ht_no=?");
/*  63: 59 */       this.pst.setString(1, paramString.trim());
/*  64:    */       
/*  65: 61 */       this.rs = this.pst.executeQuery();
/*  66: 62 */       if (this.rs.next())
/*  67:    */       {
/*  68: 63 */         this.candidate_name = this.rs.getString("candidate_name");
/*  69: 64 */         this.regn_no = this.rs.getString("regn_no");
/*  70: 65 */         this.mobile_no = this.rs.getString("mobile_no");
/*  71: 66 */         this.email_id = this.rs.getString("email_id");
/*  72: 67 */         this.education = this.rs.getString("education");
/*  73: 68 */         this.gender = this.rs.getString("gender");
/*  74: 69 */         this.percentage = this.rs.getString("percentage");
/*  75: 70 */         this.dob = this.rs.getString("dob");
/*  76: 71 */         this.college_name = this.rs.getString("college_name");
/*  77:    */       }
/*  78:    */     }
/*  79:    */     catch (Exception localException1)
/*  80:    */     {
/*  81: 76 */       localException1.printStackTrace();
/*  82:    */     }
/*  83:    */     finally
/*  84:    */     {
/*  85: 79 */       this.con.close();
/*  86:    */     }
/*  87: 82 */     Document localDocument = new Document(PageSize.A4);
/*  88: 83 */     PdfWriter.getInstance(localDocument, new FileOutputStream("/home/phnx1234/data/oceht/" + paramString + ".pdf"));
/*  89:    */     
/*  90: 85 */     Image localImage1 = null;
/*  91: 86 */     Image localImage2 = null;
/*  92:    */     try
/*  93:    */     {
/*  94: 90 */       System.out.println("PHOTO_PATH_OCE -> /home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/oce/" + paramString.trim() + ".jpg");
/*  95: 91 */       localImage1 = Image.getInstance("/home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/oce/" + paramString.trim() + ".jpg");
/*  96: 92 */       localImage2 = Image.getInstance("/home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/logos/bist.bmp");
/*  97:    */     }
/*  98:    */     catch (Exception localException2)
/*  99:    */     {
/* 100: 96 */       if (localImage1 == null) {
/* 101: 97 */         localImage1 = Image.getInstance("/home/phnx1234/jvm/apache-tomcat-7.0.27/domains/campus2cubicle.com/photos/oce/dummy.png");
/* 102:    */       }
/* 103:    */     }
/* 104:100 */     localDocument.open();
/* 105:    */     
/* 106:    */ 
/* 107:103 */     PdfPTable localPdfPTable1 = new PdfPTable(1);
/* 108:104 */     localPdfPTable1.getDefaultCell().setBorder(0);
/* 109:105 */     localPdfPTable1.addCell(localImage2);
/* 110:106 */     localPdfPTable1.addCell(" ");
/* 111:107 */     localPdfPTable1.addCell("TRAINING & PLACEMENT CELL");
/* 112:108 */     localPdfPTable1.addCell("HALL TICKET");
/* 113:109 */     localPdfPTable1.addCell(" ");
/* 114:110 */     localDocument.add(localPdfPTable1);
/* 115:    */     
/* 116:    */ 
/* 117:113 */     PdfPTable localPdfPTable2 = new PdfPTable(3);
/* 118:114 */     localPdfPTable2.getDefaultCell().setBorder(0);
/* 119:115 */     localPdfPTable2.addCell("");
/* 120:116 */     localPdfPTable2.addCell("");
/* 121:117 */     localPdfPTable2.addCell(localImage1);
/* 122:118 */     localDocument.add(localPdfPTable2);
/* 123:    */     
/* 124:120 */     PdfPTable localPdfPTable3 = new PdfPTable(2);
/* 125:121 */     localPdfPTable3.getDefaultCell().setBorder(0);
/* 126:    */     
/* 127:123 */     localPdfPTable3.addCell(" ");
/* 128:124 */     localPdfPTable3.addCell(" ");
/* 129:125 */     localPdfPTable3.addCell(" ");
/* 130:126 */     localPdfPTable3.addCell(" ");
/* 131:127 */     localPdfPTable3.addCell("Hall Ticket No");
/* 132:128 */     localPdfPTable3.addCell(paramString);
/* 133:129 */     localPdfPTable3.addCell(" ");
/* 134:130 */     localPdfPTable3.addCell(" ");
/* 135:131 */     localPdfPTable3.addCell("Name of the Student");
/* 136:132 */     localPdfPTable3.addCell(this.candidate_name);
/* 137:133 */     localPdfPTable3.addCell(" ");
/* 138:134 */     localPdfPTable3.addCell(" ");
/* 139:135 */     localPdfPTable3.addCell("Registration No");
/* 140:136 */     localPdfPTable3.addCell(this.regn_no);
/* 141:137 */     localPdfPTable3.addCell(" ");
/* 142:138 */     localPdfPTable3.addCell(" ");
/* 143:139 */     localPdfPTable3.addCell("Department");
/* 144:140 */     localPdfPTable3.addCell(this.hmDeg.get(this.education).toString());
/* 145:141 */     localPdfPTable3.addCell(" ");
/* 146:142 */     localPdfPTable3.addCell(" ");
/* 147:143 */     localPdfPTable3.addCell("Mobile No");
/* 148:144 */     localPdfPTable3.addCell(this.mobile_no);
/* 149:145 */     localPdfPTable3.addCell(" ");
/* 150:146 */     localPdfPTable3.addCell(" ");
/* 151:147 */     localPdfPTable3.addCell("Email ID");
/* 152:148 */     localPdfPTable3.addCell(this.email_id);
/* 153:149 */     localPdfPTable3.addCell(" ");
/* 154:150 */     localPdfPTable3.addCell(" ");
/* 155:151 */     localPdfPTable3.addCell("Date of Birth");
/* 156:152 */     localPdfPTable3.addCell(this.dob);
/* 157:153 */     localPdfPTable3.addCell(" ");
/* 158:154 */     localPdfPTable3.addCell(" ");
/* 159:155 */     localPdfPTable3.addCell("Name of the College");
/* 160:156 */     localPdfPTable3.addCell(this.college_name);
/* 161:157 */     localPdfPTable3.addCell(" ");
/* 162:158 */     localPdfPTable3.addCell(" ");
/* 163:159 */     localPdfPTable3.addCell("Percentage");
/* 164:160 */     localPdfPTable3.addCell(this.percentage);
/* 165:161 */     localPdfPTable3.addCell(" ");
/* 166:162 */     localPdfPTable3.addCell(" ");
/* 167:163 */     localPdfPTable3.addCell(" ");
/* 168:164 */     localPdfPTable3.addCell(" ");
/* 169:165 */     localPdfPTable3.addCell(" ");
/* 170:166 */     localPdfPTable3.addCell(" ");
/* 171:167 */     localPdfPTable3.addCell(" ");
/* 172:168 */     localPdfPTable3.addCell(" ");
/* 173:169 */     localPdfPTable3.addCell(" ");
/* 174:170 */     localPdfPTable3.addCell(" ");
/* 175:171 */     localPdfPTable3.addCell(" ");
/* 176:172 */     localPdfPTable3.addCell(" ");
/* 177:173 */     localPdfPTable3.addCell("_______________________");
/* 178:174 */     localPdfPTable3.addCell("_______________________");
/* 179:175 */     localPdfPTable3.addCell(" ");
/* 180:176 */     localPdfPTable3.addCell(" ");
/* 181:177 */     localPdfPTable3.addCell("Signature of Student");
/* 182:178 */     localPdfPTable3.addCell("Signature of Placement Officer");
/* 183:179 */     localPdfPTable3.addCell(" ");
/* 184:180 */     localPdfPTable3.addCell(" ");
/* 185:181 */     localPdfPTable3.addCell(" ");
/* 186:182 */     localPdfPTable3.addCell(" ");
/* 187:183 */     localPdfPTable3.addCell(" ");
/* 188:184 */     localPdfPTable3.addCell(" ");
/* 189:185 */     localPdfPTable3.addCell(" ");
/* 190:186 */     localPdfPTable3.addCell(" ");
/* 191:187 */     localPdfPTable3.addCell(" ");
/* 192:188 */     localPdfPTable3.addCell(" ");
/* 193:189 */     localPdfPTable3.addCell(" ");
/* 194:190 */     localPdfPTable3.addCell(" ");
/* 195:191 */     localDocument.add(localPdfPTable3);
/* 196:    */     
/* 197:193 */     PdfPTable localPdfPTable4 = new PdfPTable(1);
/* 198:194 */     localPdfPTable4.getDefaultCell().setBorder(0);
/* 199:195 */     localPdfPTable4.addCell("Seal of Bharath University");
/* 200:196 */     localDocument.add(localPdfPTable4);
/* 201:    */     
/* 202:198 */     localDocument.close();
/* 203:    */   }
/* 204:    */   
/* 205:    */   public static void main(String[] paramArrayOfString)
/* 206:    */     throws Exception
/* 207:    */   {
/* 208:203 */     new OCEHTGenerator().generateOCEHT("1001");
/* 209:    */   }
/* 210:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.OCEHTGenerator
 * JD-Core Version:    0.7.0.1
 */