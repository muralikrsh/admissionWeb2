/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import com.lowagie.text.Chunk;
/*   4:    */ import com.lowagie.text.Document;
/*   5:    */ import com.lowagie.text.Image;
/*   6:    */ import com.lowagie.text.PageSize;
/*   7:    */ import com.lowagie.text.Paragraph;
/*   8:    */ import com.lowagie.text.pdf.PdfPCell;
/*   9:    */ import com.lowagie.text.pdf.PdfPTable;
/*  10:    */ import com.lowagie.text.pdf.PdfWriter;
/*  11:    */ import java.io.FileOutputStream;
/*  12:    */ import java.io.PrintStream;
/*  13:    */ import java.sql.Connection;
/*  14:    */ import java.sql.PreparedStatement;
/*  15:    */ import java.sql.ResultSet;
/*  16:    */ import java.util.ArrayList;
/*  17:    */ 
/*  18:    */ public class CVGenerator
/*  19:    */ {
/*  20: 12 */   Connection con = null;
/*  21: 13 */   PreparedStatement pst = null;
/*  22: 14 */   ResultSet rs = null;
/*  23: 15 */   ArrayList alMain = new ArrayList();
/*  24:    */   public static final String PDF_PATH = "/home/phnx1234/data/profiles/";
/*  25:    */   public static final String PHOTO_PATH = "/home/phnx1234/data/photos/";
/*  26:    */   
/*  27:    */   public void generateCV()
/*  28:    */     throws Exception
/*  29:    */   {
/*  30:    */     try
/*  31:    */     {
/*  32: 22 */       this.con = ConnectDatabase.getConnection();
/*  33: 23 */       this.con.setAutoCommit(false);
/*  34: 24 */       this.pst = this.con.prepareStatement("select regn_no, name, email, mobile, objective, skillset, achievements, ug_qualification, ug_institution, ug_yop, ug_percentage, pg_qualification, pg_institution, pg_yop, pg_percentage, sslc_qualification, sslc_institution, sslc_yop, sslc_percentage, hsc_qualification, hsc_institution, hsc_yop, hsc_percentage, project_title, project_duration, project_description, father_name, dob, gender, nationality, address, city, state, country, pincode, languages, certification from student_profile");
/*  35:    */       
/*  36: 26 */       this.rs = this.pst.executeQuery();
/*  37: 27 */       while (this.rs.next())
/*  38:    */       {
/*  39: 28 */         StudentProfileVO localStudentProfileVO1 = new StudentProfileVO();
/*  40: 29 */         localStudentProfileVO1.setRegNo(this.rs.getString("REGN_NO"));
/*  41: 30 */         localStudentProfileVO1.setName(this.rs.getString("NAME"));
/*  42: 31 */         localStudentProfileVO1.setEmail(this.rs.getString("EMAIL"));
/*  43: 32 */         localStudentProfileVO1.setMobile(this.rs.getString("MOBILE"));
/*  44: 33 */         localStudentProfileVO1.setObjective(this.rs.getString("OBJECTIVE"));
/*  45: 34 */         localStudentProfileVO1.setSkillset(this.rs.getString("SKILLSET"));
/*  46: 35 */         localStudentProfileVO1.setAchievements(this.rs.getString("ACHIEVEMENTS"));
/*  47: 36 */         localStudentProfileVO1.setUGQualification(this.rs.getString("UG_QUALIFICATION"));
/*  48: 37 */         localStudentProfileVO1.setUGInstitution(this.rs.getString("UG_INSTITUTION"));
/*  49: 38 */         localStudentProfileVO1.setUGYOP(this.rs.getString("UG_YOP"));
/*  50: 39 */         localStudentProfileVO1.setUGPercentage(this.rs.getString("UG_PERCENTAGE"));
/*  51: 40 */         localStudentProfileVO1.setPGQualification(this.rs.getString("PG_QUALIFICATION"));
/*  52: 41 */         localStudentProfileVO1.setPGInstitution(this.rs.getString("PG_INSTITUTION"));
/*  53: 42 */         localStudentProfileVO1.setPGYOP(this.rs.getString("PG_YOP"));
/*  54: 43 */         localStudentProfileVO1.setPGPercentage(this.rs.getString("PG_PERCENTAGE"));
/*  55: 44 */         localStudentProfileVO1.setSSLCQualification(this.rs.getString("SSLC_QUALIFICATION"));
/*  56: 45 */         localStudentProfileVO1.setSSLCInstitution(this.rs.getString("SSLC_INSTITUTION"));
/*  57: 46 */         localStudentProfileVO1.setSSLCYOP(this.rs.getString("SSLC_YOP"));
/*  58: 47 */         localStudentProfileVO1.setSSLCPercentage(this.rs.getString("SSLC_PERCENTAGE"));
/*  59: 48 */         localStudentProfileVO1.setHSCQualification(this.rs.getString("HSC_QUALIFICATION"));
/*  60: 49 */         localStudentProfileVO1.setHSCInstitution(this.rs.getString("HSC_INSTITUTION"));
/*  61: 50 */         localStudentProfileVO1.setHSCYOP(this.rs.getString("HSC_YOP"));
/*  62: 51 */         localStudentProfileVO1.setHSCPercentage(this.rs.getString("HSC_PERCENTAGE"));
/*  63: 52 */         localStudentProfileVO1.setProjectTitle(this.rs.getString("PROJECT_TITLE"));
/*  64: 53 */         localStudentProfileVO1.setProjectDuration(this.rs.getString("PROJECT_DURATION"));
/*  65: 54 */         localStudentProfileVO1.setProjectDescription(this.rs.getString("PROJECT_DESCRIPTION"));
/*  66: 55 */         localStudentProfileVO1.setFatherName(this.rs.getString("FATHER_NAME"));
/*  67: 56 */         localStudentProfileVO1.setDOB(this.rs.getString("DOB"));
/*  68: 57 */         localStudentProfileVO1.setGender(this.rs.getString("GENDER"));
/*  69: 58 */         localStudentProfileVO1.setNationality(this.rs.getString("NATIONALITY"));
/*  70: 59 */         localStudentProfileVO1.setAddress(this.rs.getString("ADDRESS"));
/*  71: 60 */         localStudentProfileVO1.setCity(this.rs.getString("CITY"));
/*  72: 61 */         localStudentProfileVO1.setState(this.rs.getString("STATE"));
/*  73: 62 */         localStudentProfileVO1.setCountry(this.rs.getString("COUNTRY"));
/*  74: 63 */         localStudentProfileVO1.setPincode(this.rs.getString("PINCODE"));
/*  75: 64 */         localStudentProfileVO1.setLanguages(this.rs.getString("LANGUAGES"));
/*  76: 65 */         localStudentProfileVO1.setCertification(this.rs.getString("CERTIFICATION"));
/*  77:    */         
/*  78:    */ 
/*  79: 68 */         this.alMain.add(localStudentProfileVO1);
/*  80:    */       }
/*  81: 70 */       System.out.println(this.alMain);
/*  82:    */     }
/*  83:    */     catch (Exception localException1)
/*  84:    */     {
/*  85: 73 */       localException1.printStackTrace();
/*  86:    */     }
/*  87:    */     finally
/*  88:    */     {
/*  89: 76 */       this.con.close();
/*  90:    */     }
/*  91: 78 */     for (int i = 0; i < this.alMain.size(); i++)
/*  92:    */     {
/*  93: 80 */       StudentProfileVO localStudentProfileVO2 = (StudentProfileVO)this.alMain.get(i);
/*  94:    */       
/*  95: 82 */       Document localDocument = new Document(PageSize.A4);
/*  96: 83 */       PdfWriter.getInstance(localDocument, new FileOutputStream("/home/phnx1234/data/profiles/" + localStudentProfileVO2.getRegNo() + ".pdf"));
/*  97:    */       
/*  98: 85 */       Image localImage = null;
/*  99:    */       try
/* 100:    */       {
/* 101: 88 */         localImage = Image.getInstance("/home/phnx1234/data/photos/" + localStudentProfileVO2.getRegNo() + ".jpg");
/* 102:    */       }
/* 103:    */       catch (Exception localException2)
/* 104:    */       {
/* 105: 92 */         localImage = Image.getInstance("/home/phnx1234/data/photos/dummy.jpg");
/* 106:    */       }
/* 107: 95 */       localDocument.open();
/* 108:    */       
/* 109: 97 */       PdfPTable localPdfPTable1 = new PdfPTable(2);
/* 110: 98 */       localPdfPTable1.getDefaultCell().setBorder(0);
/* 111: 99 */       localPdfPTable1.addCell("");
/* 112:100 */       localPdfPTable1.addCell(localImage);
/* 113:101 */       localPdfPTable1.addCell("Registration No");
/* 114:102 */       localPdfPTable1.addCell(localStudentProfileVO2.getRegNo());
/* 115:103 */       localPdfPTable1.addCell("");
/* 116:104 */       localPdfPTable1.addCell("");
/* 117:105 */       localPdfPTable1.addCell("Name");
/* 118:106 */       localPdfPTable1.addCell(localStudentProfileVO2.getName());
/* 119:107 */       localPdfPTable1.addCell("");
/* 120:108 */       localPdfPTable1.addCell("");
/* 121:109 */       localPdfPTable1.addCell("Email ID");
/* 122:110 */       localPdfPTable1.addCell(localStudentProfileVO2.getEmail());
/* 123:111 */       localPdfPTable1.addCell("");
/* 124:112 */       localPdfPTable1.addCell("");
/* 125:113 */       localPdfPTable1.addCell("Mobile");
/* 126:114 */       localPdfPTable1.addCell(localStudentProfileVO2.getMobile());
/* 127:    */       
/* 128:116 */       localDocument.add(localPdfPTable1);
/* 129:117 */       PdfPTable localPdfPTable2 = new PdfPTable(4);
/* 130:    */       
/* 131:119 */       localPdfPTable2.addCell(localStudentProfileVO2.getUGQualification());
/* 132:120 */       localPdfPTable2.addCell(localStudentProfileVO2.getUGInstitution());
/* 133:121 */       localPdfPTable2.addCell(localStudentProfileVO2.getUGYOP());
/* 134:122 */       localPdfPTable2.addCell(localStudentProfileVO2.getUGPercentage() + " %");
/* 135:    */       
/* 136:124 */       localPdfPTable2.addCell(localStudentProfileVO2.getPGQualification());
/* 137:125 */       localPdfPTable2.addCell(localStudentProfileVO2.getPGInstitution());
/* 138:126 */       localPdfPTable2.addCell(localStudentProfileVO2.getPGYOP());
/* 139:127 */       localPdfPTable2.addCell(localStudentProfileVO2.getPGPercentage() + " %");
/* 140:    */       
/* 141:    */ 
/* 142:130 */       localPdfPTable2.addCell(localStudentProfileVO2.getHSCQualification());
/* 143:131 */       localPdfPTable2.addCell(localStudentProfileVO2.getHSCInstitution());
/* 144:132 */       localPdfPTable2.addCell(localStudentProfileVO2.getHSCYOP());
/* 145:133 */       localPdfPTable2.addCell(localStudentProfileVO2.getHSCPercentage() + " %");
/* 146:    */       
/* 147:    */ 
/* 148:136 */       localPdfPTable2.addCell(localStudentProfileVO2.getSSLCQualification());
/* 149:137 */       localPdfPTable2.addCell(localStudentProfileVO2.getSSLCInstitution());
/* 150:138 */       localPdfPTable2.addCell(localStudentProfileVO2.getSSLCYOP());
/* 151:139 */       localPdfPTable2.addCell(localStudentProfileVO2.getSSLCPercentage() + " %");
/* 152:140 */       localDocument.add(localPdfPTable2);
/* 153:    */       
/* 154:    */ 
/* 155:    */ 
/* 156:    */ 
/* 157:145 */       Chunk localChunk = new Chunk("Objective");
/* 158:146 */       localChunk.setUnderline(0.2F, -2.0F);
/* 159:147 */       Paragraph localParagraph = new Paragraph("");
/* 160:148 */       localParagraph.add(localChunk);
/* 161:149 */       localDocument.add(localParagraph);
/* 162:    */       
/* 163:151 */       localDocument.add(new Paragraph(localStudentProfileVO2.getObjective()));
/* 164:    */       
/* 165:153 */       localDocument.add(new Paragraph("Skillset -> " + localStudentProfileVO2.getSkillset()));
/* 166:154 */       localDocument.add(new Paragraph("Achievements -> " + localStudentProfileVO2.getAchievements()));
/* 167:155 */       localDocument.add(new Paragraph("UGQualification -> " + localStudentProfileVO2.getUGQualification()));
/* 168:156 */       localDocument.add(new Paragraph("UGInstitution -> " + localStudentProfileVO2.getUGInstitution()));
/* 169:157 */       localDocument.add(new Paragraph("UGYOP -> " + localStudentProfileVO2.getUGYOP()));
/* 170:158 */       localDocument.add(new Paragraph("UGPercentage -> " + localStudentProfileVO2.getUGPercentage()));
/* 171:159 */       localDocument.add(new Paragraph("PGQualification -> " + localStudentProfileVO2.getPGQualification()));
/* 172:160 */       localDocument.add(new Paragraph("PGInstitution -> " + localStudentProfileVO2.getPGInstitution()));
/* 173:161 */       localDocument.add(new Paragraph("PGYOP -> " + localStudentProfileVO2.getPGYOP()));
/* 174:162 */       localDocument.add(new Paragraph("PGPercentage -> " + localStudentProfileVO2.getPGPercentage()));
/* 175:163 */       localDocument.add(new Paragraph("SSLCQualification -> " + localStudentProfileVO2.getSSLCQualification()));
/* 176:164 */       localDocument.add(new Paragraph("SSLCInstitution -> " + localStudentProfileVO2.getSSLCInstitution()));
/* 177:165 */       localDocument.add(new Paragraph("SSLCYOP -> " + localStudentProfileVO2.getSSLCYOP()));
/* 178:166 */       localDocument.add(new Paragraph("SSLCPercentage -> " + localStudentProfileVO2.getSSLCPercentage()));
/* 179:167 */       localDocument.add(new Paragraph("HSCQualification -> " + localStudentProfileVO2.getHSCQualification()));
/* 180:168 */       localDocument.add(new Paragraph("HSCInstitution -> " + localStudentProfileVO2.getHSCInstitution()));
/* 181:169 */       localDocument.add(new Paragraph("HSCYOP -> " + localStudentProfileVO2.getHSCYOP()));
/* 182:170 */       localDocument.add(new Paragraph("HSCPercentage -> " + localStudentProfileVO2.getHSCPercentage()));
/* 183:171 */       localDocument.add(new Paragraph("ProjectTitle -> " + localStudentProfileVO2.getProjectTitle()));
/* 184:172 */       localDocument.add(new Paragraph("ProjectDuration -> " + localStudentProfileVO2.getProjectDuration()));
/* 185:173 */       localDocument.add(new Paragraph("ProjectDescription -> " + localStudentProfileVO2.getProjectDescription()));
/* 186:174 */       localDocument.add(new Paragraph("FatherName -> " + localStudentProfileVO2.getFatherName()));
/* 187:175 */       localDocument.add(new Paragraph("DOB -> " + localStudentProfileVO2.getDOB()));
/* 188:176 */       localDocument.add(new Paragraph("Gender -> " + localStudentProfileVO2.getGender()));
/* 189:177 */       localDocument.add(new Paragraph("Nationality -> " + localStudentProfileVO2.getNationality()));
/* 190:178 */       localDocument.add(new Paragraph("Address -> " + localStudentProfileVO2.getAddress()));
/* 191:179 */       localDocument.add(new Paragraph("City -> " + localStudentProfileVO2.getCity()));
/* 192:180 */       localDocument.add(new Paragraph("State -> " + localStudentProfileVO2.getState()));
/* 193:181 */       localDocument.add(new Paragraph("Country -> " + localStudentProfileVO2.getCountry()));
/* 194:182 */       localDocument.add(new Paragraph("Pincode -> " + localStudentProfileVO2.getPincode()));
/* 195:183 */       localDocument.add(new Paragraph("Languages -> " + localStudentProfileVO2.getLanguages()));
/* 196:184 */       localDocument.add(new Paragraph("Certification -> " + localStudentProfileVO2.getCertification()));
/* 197:    */       
/* 198:186 */       localDocument.close();
/* 199:    */     }
/* 200:    */   }
/* 201:    */   
/* 202:    */   public static void main(String[] paramArrayOfString)
/* 203:    */     throws Exception
/* 204:    */   {
/* 205:191 */     new CVGenerator().generateCV();
/* 206:    */   }
/* 207:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.CVGenerator
 * JD-Core Version:    0.7.0.1
 */