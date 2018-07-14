/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.sql.Connection;
/*  5:   */ import java.sql.PreparedStatement;
/*  6:   */ import java.sql.ResultSet;
/*  7:   */ 
/*  8:   */ public class Language
/*  9:   */ {
/* 10: 7 */   Connection con = null;
/* 11: 8 */   PreparedStatement pst = null;
/* 12: 9 */   ResultSet rs = null;
/* 13:   */   
/* 14:   */   public String getLanguageName(String paramString)
/* 15:   */     throws Exception
/* 16:   */   {
/* 17:13 */     String str = "";
/* 18:   */     try
/* 19:   */     {
/* 20:15 */       this.con = ConnectDatabase.getConnection();
/* 21:16 */       System.out.println("Message 1");
/* 22:17 */       this.pst = this.con.prepareStatement("select lang_name from language where lang_code=?");
/* 23:18 */       this.pst.setString(1, paramString);
/* 24:19 */       this.rs = this.pst.executeQuery();
/* 25:20 */       System.out.println("Message 2");
/* 26:21 */       if (this.rs.next()) {
/* 27:22 */         str = this.rs.getString(1);
/* 28:   */       }
/* 29:24 */       System.out.println("Message 3");
/* 30:   */     }
/* 31:   */     catch (Exception localException)
/* 32:   */     {
/* 33:27 */       localException.printStackTrace();
/* 34:   */     }
/* 35:   */     finally
/* 36:   */     {
/* 37:30 */       if (this.con != null) {
/* 38:31 */         this.con.close();
/* 39:   */       }
/* 40:   */     }
/* 41:33 */     return str;
/* 42:   */   }
/* 43:   */   
/* 44:   */   public static void main(String[] paramArrayOfString)
/* 45:   */     throws Exception
/* 46:   */   {
/* 47:37 */     new Language().getLanguageName("TA");
/* 48:   */   }
/* 49:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.Language
 * JD-Core Version:    0.7.0.1
 */