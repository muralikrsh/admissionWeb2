/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.security.MessageDigest;
/*  5:   */ 
/*  6:   */ public class CheckSumUtil
/*  7:   */ {
/*  8:   */   public static void main(String[] paramArrayOfString)
/*  9:   */   {
/* 10:11 */     String str1 = null;
/* 11:12 */     String str2 = "5v2V1QMwY7uv";
/* 12:   */     
/* 13:   */ 
/* 14:15 */     String str3 = "BHARTUNIV|T002|NA|2.00|NA|NA|NA|NA|NA|NA|NA|NA|NA|NA|130000000001|APP|MURALIDHARAN R|NA|NA|NA|NA|http://115.249.105.5/admission/PaymentStatus.jsp";
/* 15:   */     try
/* 16:   */     {
/* 17:19 */       str1 = checkSumSHA256(str3 + "|" + str2);
/* 18:   */     }
/* 19:   */     catch (Exception localException)
/* 20:   */     {
/* 21:23 */       System.out.println(localException.toString());
/* 22:   */     }
/* 23:25 */     System.out.println("strHash===" + str1);
/* 24:   */   }
/* 25:   */   
/* 26:   */   public static String checkSumSHA256(String paramString)
/* 27:   */   {
/* 28:29 */     MessageDigest localMessageDigest = null;
/* 29:   */     try
/* 30:   */     {
/* 31:31 */       localMessageDigest = MessageDigest.getInstance("SHA-256");
/* 32:32 */       localMessageDigest.update(paramString.getBytes("UTF-8"));
/* 33:   */     }
/* 34:   */     catch (Exception localException)
/* 35:   */     {
/* 36:34 */       localMessageDigest = null;
/* 37:   */     }
/* 38:37 */     StringBuffer localStringBuffer = new StringBuffer();
/* 39:38 */     byte[] arrayOfByte = localMessageDigest.digest();
/* 40:39 */     for (int i = 0; i < arrayOfByte.length; i++) {
/* 41:40 */       localStringBuffer.append(char2hex(arrayOfByte[i]));
/* 42:   */     }
/* 43:41 */     return localStringBuffer.toString();
/* 44:   */   }
/* 45:   */   
/* 46:   */   public static String char2hex(byte paramByte)
/* 47:   */   {
/* 48:46 */     char[] arrayOfChar1 = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
/* 49:   */     
/* 50:   */ 
/* 51:   */ 
/* 52:   */ 
/* 53:   */ 
/* 54:   */ 
/* 55:   */ 
/* 56:54 */     char[] arrayOfChar2 = { arrayOfChar1[((paramByte & 0xF0) >> 4)], arrayOfChar1[(paramByte & 0xF)] };
/* 57:55 */     return new String(arrayOfChar2);
/* 58:   */   }
/* 59:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.CheckSumUtil
 * JD-Core Version:    0.7.0.1
 */