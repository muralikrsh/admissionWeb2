/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.sql.Connection;
/*  5:   */ import java.sql.PreparedStatement;
/*  6:   */ import java.sql.ResultSet;
/*  7:   */ 
/*  8:   */ public class Course
/*  9:   */ {
/* 10: 7 */   Connection con = null;
/* 11: 8 */   PreparedStatement pst = null;
/* 12: 9 */   ResultSet rs = null;
/* 13:   */   
/* 14:   */   public String getCourseName(String paramString)
/* 15:   */     throws Exception
/* 16:   */   {
/* 17:13 */     String str = "";
/* 18:   */     try
/* 19:   */     {
/* 20:15 */       this.con = ConnectDatabase.getConnection();
/* 21:16 */       this.con.setAutoCommit(false);
/* 22:17 */       System.out.println("Message 1");
/* 23:18 */       this.pst = this.con.prepareStatement("select course_name from course where course_id=?");
/* 24:19 */       this.pst.setString(1, paramString);
/* 25:20 */       this.rs = this.pst.executeQuery();
/* 26:21 */       System.out.println("Message 2");
/* 27:22 */       if (this.rs.next()) {
/* 28:23 */         str = this.rs.getString(1);
/* 29:   */       }
/* 30:25 */       System.out.println("Message 3");
/* 31:   */     }
/* 32:   */     catch (Exception localException)
/* 33:   */     {
/* 34:28 */       localException.printStackTrace();
/* 35:   */     }
/* 36:   */     finally
/* 37:   */     {
/* 38:31 */       if (this.con != null) {
/* 39:32 */         this.con.close();
/* 40:   */       }
/* 41:   */     }
/* 42:34 */     return str;
/* 43:   */   }
/* 44:   */   
/* 45:   */   public static void main(String[] paramArrayOfString)
/* 46:   */     throws Exception
/* 47:   */   {
/* 48:38 */     new Course().getCourseName("CC0001");
/* 49:   */   }
/* 50:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.Course
 * JD-Core Version:    0.7.0.1
 */