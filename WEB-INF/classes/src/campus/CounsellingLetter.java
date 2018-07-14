/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import com.itextpdf.text.Chunk;
/*   4:    */ import com.itextpdf.text.Document;
/*   5:    */ import com.itextpdf.text.Font;
/*   6:    */ import com.itextpdf.text.FontFactory;
/*   7:    */ import com.itextpdf.text.Image;
/*   8:    */ import com.itextpdf.text.PageSize;
/*   9:    */ import com.itextpdf.text.Paragraph;
/*  10:    */ import com.itextpdf.text.Phrase;
/*  11:    */ import com.itextpdf.text.pdf.FontSelector;
/*  12:    */ import com.itextpdf.text.pdf.PdfPCell;
/*  13:    */ import com.itextpdf.text.pdf.PdfPTable;
/*  14:    */ import com.itextpdf.text.pdf.PdfWriter;
/*  15:    */ import java.io.FileOutputStream;
/*  16:    */ import java.io.PrintStream;
/*  17:    */ import java.sql.Connection;
/*  18:    */ import java.sql.PreparedStatement;
/*  19:    */ import java.sql.ResultSet;
/*  20:    */ 
/*  21:    */ public class CounsellingLetter
/*  22:    */ {
/*  23:    */   public void generatePDF(String strAnsNo)
/*  24:    */   {
/*  25: 25 */     Connection con = null;
/*  26: 26 */     PreparedStatement pst = null;
/*  27: 27 */     ResultSet rs = null;
/*  28:    */     
/*  29: 29 */     Paragraph paragraph = null;
/*  30: 30 */     String stu_name = "";
/*  31: 31 */     String ht_no = "";
/*  32: 32 */     String rank = "";
/*  33: 33 */     String mobile_no_2 = "";
/*  34: 34 */     String strCounselDate = "";
/*  35: 35 */     String strCounselTime = "";
/*  36:    */     try
/*  37:    */     {
/*  38: 37 */       con = ConnectDatabase.getConnection();
/*  39: 38 */       pst = con.prepareStatement("SELECT stu_name, ht_no, rank, mobile_no_2, counsel_date, counsel_time FROM rank_list where ans_no=?");
/*  40: 39 */       pst.setString(1, strAnsNo);
/*  41: 40 */       rs = pst.executeQuery();
/*  42: 41 */       System.out.println(pst);
/*  43:    */       
/*  44: 43 */       Document docPDF = new Document(PageSize.A4);
/*  45: 44 */       PdfWriter.getInstance(docPDF, new FileOutputStream(strAnsNo + ".pdf"));
/*  46: 45 */       docPDF.open();
/*  47:    */       
/*  48:    */ 
/*  49: 48 */       String strTitle = "COUNSELLING LETTER";
/*  50:    */       
/*  51: 50 */       FontSelector selector = new FontSelector();
/*  52: 51 */       Font f1 = FontFactory.getFont("Times-Roman", 10.0F);
/*  53: 52 */       Font f2 = FontFactory.getFont("MSung-Light", "UniCNS-UCS2-H", false);
/*  54: 53 */       selector.addFont(f1);
/*  55: 54 */       selector.addFont(f2);
/*  56:    */       
/*  57: 56 */       Image image = Image.getInstance("C:\\tools\\itext\\bharath_31.jpg");
/*  58: 57 */       image.scaleAbsolute(500.0F, 150.0F);
/*  59: 58 */       docPDF.add(image);
/*  60: 59 */       paragraph = new Paragraph(strTitle);
/*  61: 60 */       paragraph.setAlignment(1);
/*  62: 61 */       docPDF.add(paragraph);
/*  63:    */       
/*  64: 63 */       paragraph = new Paragraph("Ref : BU/BEEE/2015/B.TECH");
/*  65: 64 */       paragraph.setAlignment(0);
/*  66: 65 */       docPDF.add(paragraph);
/*  67:    */       
/*  68: 67 */       paragraph = new Paragraph(" ");
/*  69: 68 */       docPDF.add(paragraph);
/*  70:    */       
/*  71: 70 */       boolean data = rs.next();
/*  72: 71 */       if (data)
/*  73:    */       {
/*  74: 73 */         stu_name = rs.getString("stu_name");
/*  75: 74 */         ht_no = rs.getString("ht_no");
/*  76: 75 */         rank = rs.getString("rank");
/*  77: 76 */         mobile_no_2 = rs.getString("mobile_no_2");
/*  78: 77 */         strCounselDate = rs.getString("counsel_date");
/*  79: 78 */         strCounselTime = rs.getString("counsel_time");
/*  80:    */       }
/*  81: 81 */       Phrase ph_name = selector.process(stu_name);
/*  82: 82 */       Phrase ph_ht_no = selector.process(ht_no);
/*  83: 83 */       Phrase ph_rank = selector.process(rank);
/*  84: 84 */       Phrase ph_mobile = selector.process(mobile_no_2);
/*  85: 85 */       Phrase ph_date = selector.process(strCounselDate);
/*  86: 86 */       Phrase ph_time = selector.process(strCounselTime);
/*  87:    */       
/*  88:    */ 
/*  89:    */ 
/*  90:    */ 
/*  91:    */ 
/*  92: 92 */       PdfPTable table = new PdfPTable(2);
/*  93:    */       
/*  94: 94 */       table.getDefaultCell().setBorder(15);
/*  95: 95 */       table.getDefaultCell().setHorizontalAlignment(0);
/*  96: 96 */       table.getDefaultCell().setVerticalAlignment(5);
/*  97:    */       
/*  98: 98 */       table.addCell("Candidate Name:");
/*  99: 99 */       table.addCell(ph_name);
/* 100:100 */       table.addCell(new Phrase(new Chunk("Hall Ticket No")));
/* 101:101 */       table.addCell(ph_ht_no);
/* 102:102 */       table.addCell(new Phrase(new Chunk("Rank")));
/* 103:103 */       table.addCell(ph_rank);
/* 104:104 */       table.addCell(new Phrase(new Chunk("Mobile No")));
/* 105:105 */       table.addCell(ph_mobile);
/* 106:106 */       table.addCell(new Phrase(new Chunk("Counselling Date")));
/* 107:107 */       table.addCell(ph_date);
/* 108:108 */       table.addCell(new Phrase(new Chunk("Counselling Time")));
/* 109:109 */       table.addCell(ph_time);
/* 110:110 */       docPDF.add(table);
/* 111:    */       
/* 112:    */ 
/* 113:    */ 
/* 114:    */ 
/* 115:    */ 
/* 116:    */ 
/* 117:    */ 
/* 118:    */ 
/* 119:    */ 
/* 120:    */ 
/* 121:    */ 
/* 122:    */ 
/* 123:    */ 
/* 124:    */ 
/* 125:    */ 
/* 126:126 */       paragraph = new Paragraph(" ");
/* 127:127 */       docPDF.add(paragraph);
/* 128:    */       
/* 129:129 */       paragraph = new Paragraph("Sub : Rank in the Common Entrance Test conducted on April / May 2015 and counselling schedule intimation.");
/* 130:130 */       paragraph.setAlignment(0);
/* 131:131 */       docPDF.add(paragraph);
/* 132:    */       
/* 133:133 */       paragraph = new Paragraph(" ");
/* 134:134 */       docPDF.add(paragraph);
/* 135:    */       
/* 136:136 */       paragraph = new Paragraph("Dear Student,");
/* 137:137 */       paragraph.setAlignment(0);
/* 138:138 */       docPDF.add(paragraph);
/* 139:    */       
/* 140:140 */       paragraph = new Paragraph("We are glad to inform you that your rank, date and time of counselling as detailed above. The counselling will be held at Bharath University, Chennai.");
/* 141:141 */       paragraph.setAlignment(0);
/* 142:142 */       docPDF.add(paragraph);
/* 143:    */       
/* 144:144 */       paragraph = new Paragraph(" ");
/* 145:145 */       docPDF.add(paragraph);
/* 146:    */       
/* 147:    */ 
/* 148:    */ 
/* 149:    */ 
/* 150:    */ 
/* 151:    */ 
/* 152:152 */       paragraph = new Paragraph("1. You are advised to report to Bharath University only on the allotted date and time.");
/* 153:153 */       paragraph.setAlignment(0);
/* 154:154 */       docPDF.add(paragraph);
/* 155:    */       
/* 156:156 */       paragraph = new Paragraph("2. You are advised to attend counselling with one set of copies of certificates along with original certificates of date of birth, qualification, community certificate for verification and demand draft for Rs. 10,000/- drawn in favour of Bharath University, Chennai (Name and HallTicket Number of the candidate to be written on the back of the demand draft), Your admission will be subject to due verification of your Certificates.");
/* 157:157 */       paragraph.setAlignment(0);
/* 158:158 */       docPDF.add(paragraph);
/* 159:    */       
/* 160:160 */       Chunk underline = new Chunk("3. The mere attending for counselling does not entitle any seat automatically, depending on availability of seats and based on ranking, allotment will be done.");
/* 161:161 */       underline.setUnderline(0.1F, -2.0F);
/* 162:162 */       docPDF.add(underline);
/* 163:    */       
/* 164:    */ 
/* 165:    */ 
/* 166:    */ 
/* 167:    */ 
/* 168:168 */       paragraph = new Paragraph("4. No request for change of date and time of counselling will be entertained.");
/* 169:169 */       paragraph.setAlignment(0);
/* 170:170 */       docPDF.add(paragraph);
/* 171:    */       
/* 172:172 */       paragraph = new Paragraph("5. Absenting in the counselling will automatically forfeit your chance.");
/* 173:173 */       paragraph.setAlignment(0);
/* 174:174 */       docPDF.add(paragraph);
/* 175:    */       
/* 176:176 */       paragraph = new Paragraph("6. You are advised to go through the Bharath University Website for all details.");
/* 177:177 */       paragraph.setAlignment(0);
/* 178:178 */       docPDF.add(paragraph);
/* 179:    */       
/* 180:180 */       paragraph = new Paragraph(" ");
/* 181:181 */       docPDF.add(paragraph);
/* 182:    */       
/* 183:183 */       paragraph = new Paragraph("Yours Faithfully, ");
/* 184:184 */       paragraph.setAlignment(2);
/* 185:185 */       docPDF.add(paragraph);
/* 186:    */       
/* 187:187 */       Image deanImage = Image.getInstance("C:\\tools\\itext\\cheif.gif");
/* 188:188 */       deanImage.scaleAbsolute(100.0F, 20.0F);
/* 189:189 */       deanImage.setAlignment(2);
/* 190:190 */       docPDF.add(deanImage);
/* 191:    */       
/* 192:192 */       paragraph = new Paragraph("DEAN (Admissions)");
/* 193:193 */       paragraph.setAlignment(2);
/* 194:194 */       docPDF.add(paragraph);
/* 195:    */       
/* 196:196 */       paragraph = new Paragraph(" ");
/* 197:197 */       docPDF.add(paragraph);
/* 198:    */       
/* 199:199 */       paragraph = new Paragraph("REACH US:");
/* 200:200 */       paragraph.setAlignment(0);
/* 201:201 */       docPDF.add(paragraph);
/* 202:    */       
/* 203:203 */       paragraph = new Paragraph(" ");
/* 204:204 */       docPDF.add(paragraph);
/* 205:    */       
/* 206:206 */       paragraph = new Paragraph("From Chennai Central To Park Station - From Park Station board a MRTS Train to Tambaram - From Tambaram Bharath University is Located at 3.8 KMS viaTambaram - Velachery Main Road - Take a right turn at Camp Road Junction travel 1.2 Kms to reach Bharath University.");
/* 207:207 */       paragraph.setAlignment(0);
/* 208:208 */       docPDF.add(paragraph);
/* 209:    */       
/* 210:210 */       paragraph = new Paragraph(" ");
/* 211:211 */       docPDF.add(paragraph);
/* 212:    */       
/* 213:213 */       paragraph = new Paragraph("Helpline Numbers: 09025167092 / 09884499302 / 1800-419-1441.");
/* 214:214 */       paragraph.setAlignment(0);
/* 215:215 */       docPDF.add(paragraph);
/* 216:    */       
/* 217:    */ 
/* 218:    */ 
/* 219:    */ 
/* 220:    */ 
/* 221:    */ 
/* 222:    */ 
/* 223:    */ 
/* 224:224 */       docPDF.close();
/* 225:225 */       rs.close();
/* 226:226 */       pst.close();
/* 227:227 */       con.close();
/* 228:228 */       docPDF.close();
/* 229:229 */       rs.close();
/* 230:230 */       pst.close();
/* 231:231 */       con.close();
/* 232:    */     }
/* 233:    */     catch (Exception e)
/* 234:    */     {
/* 235:236 */       e.printStackTrace();
/* 236:    */     }
/* 237:    */   }
/* 238:    */ }


/* Location:           C:\Tomcat 8.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.CounsellingLetter
 * JD-Core Version:    0.7.0.1
 */