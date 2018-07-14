/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import java.io.BufferedReader;
/*   4:    */ import java.io.BufferedWriter;
/*   5:    */ import java.io.FileInputStream;
/*   6:    */ import java.io.FileOutputStream;
/*   7:    */ import java.io.InputStreamReader;
/*   8:    */ import java.io.OutputStreamWriter;
/*   9:    */ import java.io.PrintStream;
/*  10:    */ import java.sql.Connection;
/*  11:    */ import java.sql.PreparedStatement;
/*  12:    */ import java.sql.ResultSet;
/*  13:    */ import java.util.ArrayList;
/*  14:    */ import java.util.Locale;
/*  15:    */ import java.util.ResourceBundle;
/*  16:    */ 
/*  17:    */ public class GenerateAFPDF
/*  18:    */ {
/*  19:    */   public String isNull(String paramString)
/*  20:    */   {
/*  21: 11 */     return paramString == null ? "" : paramString;
/*  22:    */   }
/*  23:    */   
/*  24:    */   public void generateAF()
/*  25:    */     throws Exception
/*  26:    */   {
/*  27: 15 */     Connection localConnection = null;
/*  28: 16 */     PreparedStatement localPreparedStatement = null;
/*  29: 17 */     ResultSet localResultSet = null;
/*  30:    */     
/*  31: 19 */     String[] arrayOfString = { "APPN_NO", "FIRST_NAME", "FIRST_NAME", "LAST_NAME", "LAST_NAME", "GENDER", "RELIGION", "NATIONALITY", "DOB", "COMMUNITY", "BLOOD_GROUP", "MOTHER_TONGUE", "COURSE", "CHOICE_1", "CHOICE_2", "CHOICE_3", "SPORTS_ACHV", "VALID_SCORE_OF", "EXAM_ATTENDED", "EMAIL_ID", "ADDRESS", "CITY", "STATE", "COUNTRY", "PIN_CODE", "STD_CODE", "PHONE_NO", "MOBILE_NO", "PARENT_NAME", "RELATIONSHIP", "GUARDIAN_NAME", "GUARDIAN_RELATIONSHIP", "PARENT_OCCUPATION", "HSC_SCHOOL", "HSC_BOARD", "HSC_REGN_NO", "HSC_MON_YOP", "HSC_PERCENTAGE", "SSLC_SCHOOL", "SSLC_BOARD", "SSLC_REGN_NO", "SSLC_MON_YOP", "SSLC_PERCENTAGE", "OTH_EXAM_1", "OTH_COLLEGE_1", "OTH_UNIVERSITY_1", "OTH_REGN_NO_1", "OTH_MON_YOP_1", "OTH_PERCENTAGE_1", "OTH_EXAM_2", "OTH_COLLEGE_2", "OTH_UNIVERSITY_2", "OTH_REGN_NO_2", "OTH_MON_YOP_2", "OTH_PERCENTAGE_2", "MEDIUM_OF_INSTR", "OPTIONAL_SUBJECT", "HOSTEL_REQD", "TRANSPORT_REQD", "USER" };
/*  32: 20 */     ArrayList localArrayList1 = new ArrayList();
/*  33: 21 */     ArrayList localArrayList2 = new ArrayList();
/*  34: 22 */     ResourceBundle localResourceBundle = ResourceBundle.getBundle("admission", new Locale("en", "US"));
/*  35: 23 */     String str1 = "";
/*  36: 24 */     String str2 = "";
/*  37: 25 */     Course localCourse = new Course();
/*  38: 26 */     Language localLanguage = new Language();
/*  39:    */     try
/*  40:    */     {
/*  41: 28 */       localConnection = BConnectDatabase.getConnection();
/*  42: 29 */       localConnection.setAutoCommit(false);
/*  43: 30 */       localPreparedStatement = localConnection.prepareStatement("select appn_no,first_name,ifnull(last_name,'') last_name,gender,religion,nationality,dob,community,blood_group,mother_tongue,adm_type,course_type,course,choice_1,choice_2,choice_3,quota,sports_achv,valid_score_of,exam_attended,email_id,address,city,state,country,pin_code,std_code,phone_no,mobile_no,parent_name,relationship,if(relationship='G',parent_name,'') guardian_name, if(relationship='G','Guardian','') guardian_relationship, parent_occupation,hsc_school,hsc_city,hsc_board,hsc_regn_no,hsc_mon_yop,hsc_marks,hsc_outof,sslc_school,sslc_city,sslc_board,sslc_regn_no,sslc_mon_yop,sslc_marks,sslc_outof,oth_exam_1,oth_college_1,oth_city_1,oth_university_1,oth_regn_no_1,oth_mon_yop_1,oth_marks_1,oth_outof_1,oth_exam_2,oth_college_2,oth_city_2,oth_university_2,oth_regn_no_2,oth_mon_yop_2,oth_marks_2,oth_outof_2,oth_exam_3,oth_college_3,oth_city_3,oth_university_3,oth_regn_no_3,oth_mon_yop_3,oth_marks_3,oth_outof_3,medium_of_instr,optional_subject,hostel_reqd,transport_reqd,mkr_id from application where afl_flag is null");
/*  44: 31 */       localResultSet = localPreparedStatement.executeQuery();
/*  45: 33 */       while (localResultSet.next())
/*  46:    */       {
/*  47: 34 */         ArrayList localArrayList3 = new ArrayList();
/*  48: 35 */         localArrayList3.add(isNull(localResultSet.getString("appn_no")));
/*  49: 36 */         localArrayList3.add(isNull(localResultSet.getString("first_name")));
/*  50: 37 */         localArrayList3.add(isNull(localResultSet.getString("first_name")));
/*  51: 38 */         localArrayList3.add(isNull(localResultSet.getString("last_name")));
/*  52: 39 */         localArrayList3.add(isNull(localResultSet.getString("last_name")));
/*  53:    */         
/*  54: 41 */         localArrayList3.add(localResourceBundle.getString("GEND_" + localResultSet.getString("gender")));
/*  55: 42 */         localArrayList3.add(isNull(localResultSet.getString("religion")));
/*  56: 43 */         localArrayList3.add(localResourceBundle.getString("NAT_" + localResultSet.getString("nationality")));
/*  57: 44 */         localArrayList3.add(isNull(localResultSet.getString("dob")));
/*  58: 45 */         localArrayList3.add(localResourceBundle.getString("COMM_" + localResultSet.getString("community")));
/*  59: 46 */         localArrayList3.add(isNull(localResultSet.getString("blood_group")));
/*  60: 47 */         localArrayList3.add(localLanguage.getLanguageName(isNull(localResultSet.getString("mother_tongue"))));
/*  61:    */         
/*  62:    */ 
/*  63: 50 */         localArrayList3.add(isNull(localResultSet.getString("course")));
/*  64: 51 */         localArrayList3.add(localCourse.getCourseName(isNull(localResultSet.getString("choice_1"))));
/*  65: 52 */         localArrayList3.add(localCourse.getCourseName(isNull(localResultSet.getString("choice_2"))));
/*  66: 53 */         localArrayList3.add(localCourse.getCourseName(isNull(localResultSet.getString("choice_3"))));
/*  67:    */         
/*  68: 55 */         localArrayList3.add(isNull(localResultSet.getString("sports_achv")));
/*  69: 56 */         localArrayList3.add(isNull(localResultSet.getString("valid_score_of")));
/*  70: 57 */         localArrayList3.add(isNull(localResultSet.getString("exam_attended")));
/*  71: 58 */         localArrayList3.add(isNull(localResultSet.getString("email_id")));
/*  72: 59 */         localArrayList3.add(isNull(localResultSet.getString("address")));
/*  73: 60 */         localArrayList3.add(isNull(localResultSet.getString("city")));
/*  74: 61 */         localArrayList3.add(isNull(localResultSet.getString("state")));
/*  75: 62 */         localArrayList3.add(isNull(localResultSet.getString("country")));
/*  76: 63 */         localArrayList3.add(isNull(localResultSet.getString("pin_code")));
/*  77: 64 */         localArrayList3.add(isNull(localResultSet.getString("std_code")));
/*  78: 65 */         localArrayList3.add(isNull(localResultSet.getString("phone_no")));
/*  79: 66 */         localArrayList3.add(isNull(localResultSet.getString("mobile_no")));
/*  80: 67 */         localArrayList3.add(isNull(localResultSet.getString("parent_name")));
/*  81: 68 */         localArrayList3.add(localResourceBundle.getString("RELN_" + localResultSet.getString("relationship")));
/*  82: 69 */         localArrayList3.add(isNull(localResultSet.getString("guardian_name")));
/*  83: 70 */         localArrayList3.add(localResourceBundle.getString("RELN_" + localResultSet.getString("guardian_relationship")));
/*  84: 71 */         localArrayList3.add(localResourceBundle.getString("OCCUPATION_" + localResultSet.getString("parent_occupation")));
/*  85: 72 */         localArrayList3.add(isNull(localResultSet.getString("hsc_school")));
/*  86:    */         
/*  87: 74 */         localArrayList3.add(isNull(localResultSet.getString("hsc_board")));
/*  88: 75 */         localArrayList3.add(isNull(localResultSet.getString("hsc_regn_no")));
/*  89: 76 */         localArrayList3.add(isNull(localResultSet.getString("hsc_mon_yop")));
/*  90: 77 */         localArrayList3.add(isNull(localResultSet.getString("hsc_marks")));
/*  91:    */         
/*  92: 79 */         localArrayList3.add(isNull(localResultSet.getString("sslc_school")));
/*  93:    */         
/*  94: 81 */         localArrayList3.add(isNull(localResultSet.getString("sslc_board")));
/*  95: 82 */         localArrayList3.add(isNull(localResultSet.getString("sslc_regn_no")));
/*  96: 83 */         localArrayList3.add(isNull(localResultSet.getString("sslc_mon_yop")));
/*  97: 84 */         localArrayList3.add(isNull(localResultSet.getString("sslc_marks")));
/*  98:    */         
/*  99: 86 */         localArrayList3.add(isNull(localResultSet.getString("oth_exam_1")));
/* 100: 87 */         localArrayList3.add(isNull(localResultSet.getString("oth_college_1")));
/* 101:    */         
/* 102: 89 */         localArrayList3.add(isNull(localResultSet.getString("oth_university_1")));
/* 103: 90 */         localArrayList3.add(isNull(localResultSet.getString("oth_regn_no_1")));
/* 104: 91 */         localArrayList3.add(isNull(localResultSet.getString("oth_mon_yop_1")));
/* 105: 92 */         localArrayList3.add(isNull(localResultSet.getString("oth_marks_1")));
/* 106:    */         
/* 107: 94 */         localArrayList3.add(isNull(localResultSet.getString("oth_exam_2")));
/* 108: 95 */         localArrayList3.add(isNull(localResultSet.getString("oth_college_2")));
/* 109:    */         
/* 110: 97 */         localArrayList3.add(isNull(localResultSet.getString("oth_university_2")));
/* 111: 98 */         localArrayList3.add(isNull(localResultSet.getString("oth_regn_no_2")));
/* 112: 99 */         localArrayList3.add(isNull(localResultSet.getString("oth_mon_yop_2")));
/* 113:100 */         localArrayList3.add(isNull(localResultSet.getString("oth_marks_2")));
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
/* 125:112 */         localArrayList3.add(localResultSet.getString("medium_of_instr"));
/* 126:113 */         localArrayList3.add(localResourceBundle.getString("OS_" + localResultSet.getString("optional_subject")));
/* 127:114 */         localArrayList3.add(localResourceBundle.getString("HOSTEL_" + localResultSet.getString("hostel_reqd")));
/* 128:115 */         localArrayList3.add(localResourceBundle.getString("TRANS_" + localResultSet.getString("transport_reqd")));
/* 129:    */         
/* 130:117 */         localArrayList3.add(isNull(localResultSet.getString("mkr_id")));
/* 131:118 */         localArrayList1.add(localArrayList3);
/* 132:    */       }
/* 133:    */     }
/* 134:    */     catch (Exception localException2)
/* 135:    */     {
/* 136:122 */       str1 = "Error while Generating Application Forms " + localException2.toString();
/* 137:123 */       localException2.printStackTrace();
/* 138:    */     }
/* 139:    */     finally
/* 140:    */     {
/* 141:    */       try
/* 142:    */       {
/* 143:128 */         if (localConnection != null) {
/* 144:129 */           localConnection.close();
/* 145:    */         }
/* 146:    */       }
/* 147:    */       catch (Exception localException5)
/* 148:    */       {
/* 149:133 */         localException5.printStackTrace();
/* 150:    */       }
/* 151:135 */       localConnection = null;localPreparedStatement = null;
/* 152:    */     }
/* 153:    */     try
/* 154:    */     {
/* 155:139 */       String str3 = localResourceBundle.getString("TEMPLATE_PATH");
/* 156:140 */       BufferedReader localBufferedReader = new BufferedReader(new InputStreamReader(new FileInputStream(str3 + "AppForm.html")));
/* 157:141 */       StringBuffer localStringBuffer1 = new StringBuffer();
/* 158:142 */       while ((str2 = localBufferedReader.readLine()) != null) {
/* 159:143 */         localStringBuffer1.append(str2);
/* 160:    */       }
/* 161:145 */       String str4 = localResourceBundle.getString("AF_PATH");
/* 162:146 */       String str5 = localResourceBundle.getString("AF_BATCH");
/* 163:148 */       for (int i = 0; i < localArrayList1.size(); i++)
/* 164:    */       {
/* 165:150 */         StringBuffer localStringBuffer2 = new StringBuffer(localStringBuffer1);
/* 166:151 */         ArrayList localArrayList4 = (ArrayList)localArrayList1.get(i);
/* 167:152 */         System.out.println("ALSUB -> " + localArrayList4);
/* 168:153 */         String str6 = (String)localArrayList4.get(0);
/* 169:154 */         int j = 0;
/* 170:155 */         for (int k = 0; k < localArrayList4.size(); k++)
/* 171:    */         {
/* 172:156 */           System.out.println("Search " + arrayOfString[k]);
/* 173:157 */           j = localStringBuffer2.toString().indexOf("$$" + arrayOfString[k]);
/* 174:158 */           System.out.println("Found " + arrayOfString[k] + j + ":::" + localArrayList4.get(k));
/* 175:    */           
/* 176:160 */           localStringBuffer2 = localStringBuffer2.replace(j, j + (arrayOfString[k].length() + 2), (String)localArrayList4.get(k));
/* 177:    */         }
/* 178:163 */         System.out.println(str4 + str6 + ".html");
/* 179:164 */         BufferedWriter localBufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(str4 + str6 + ".html")));
/* 180:165 */         localBufferedWriter.write(localStringBuffer2.toString());
/* 181:166 */         localBufferedWriter.flush();
/* 182:167 */         localBufferedWriter.close();
/* 183:    */       }
/* 184:169 */       str1 = "Application Form (HTML) generated successfully";
/* 185:170 */       System.out.println(str1);
/* 186:    */       
/* 187:172 */       Runtime.getRuntime().exec(str4 + str5);
/* 188:173 */       str1 = "Application Form (PDF) generated successfully";
/* 189:    */     }
/* 190:    */     catch (Exception localException4)
/* 191:    */     {
/* 192:176 */       str1 = "Error while Generating Application Forms " + localException4.toString();
/* 193:177 */       localException4.printStackTrace();
/* 194:    */     }
/* 195:    */     finally
/* 196:    */     {
/* 197:180 */       if (localConnection != null) {
/* 198:181 */         localConnection.close();
/* 199:    */       }
/* 200:182 */       localConnection = null;localPreparedStatement = null;
/* 201:    */     }
/* 202:    */   }
/* 203:    */   
/* 204:    */   public static void main(String[] paramArrayOfString)
/* 205:    */     throws Exception
/* 206:    */   {
/* 207:187 */     new GenerateAFPDF().generateAF();
/* 208:    */   }
/* 209:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.GenerateAFPDF
 * JD-Core Version:    0.7.0.1
 */