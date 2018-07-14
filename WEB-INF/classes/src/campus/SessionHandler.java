/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.sql.Connection;
/*  5:   */ import java.sql.PreparedStatement;
/*  6:   */ import java.util.Enumeration;
/*  7:   */ import javax.servlet.http.HttpServletRequest;
/*  8:   */ import javax.servlet.http.HttpSession;
/*  9:   */ 
/* 10:   */ public class SessionHandler
/* 11:   */ {
/* 12: 9 */   Connection con = null;
/* 13:10 */   PreparedStatement pst = null;
/* 14:   */   
/* 15:   */   public int loginSession(HttpServletRequest paramHttpServletRequest)
/* 16:   */     throws Exception
/* 17:   */   {
/* 18:   */     try
/* 19:   */     {
/* 20:14 */       this.con = ConnectDatabase.getConnection();
/* 21:15 */       this.con.setAutoCommit(false);
/* 22:16 */       this.pst = this.con.prepareStatement("insert into user_session values (?,?,now(),null)");
/* 23:17 */       HttpSession localHttpSession = paramHttpServletRequest.getSession();
/* 24:18 */       this.pst.setString(1, (String)localHttpSession.getAttribute("login_id"));
/* 25:19 */       this.pst.setString(2, localHttpSession.getId());
/* 26:20 */       this.pst.executeUpdate();
/* 27:21 */       this.con.commit();
/* 28:22 */       return 0;
/* 29:   */     }
/* 30:   */     catch (Exception localException)
/* 31:   */     {
/* 32:   */       int i;
/* 33:25 */       localException.printStackTrace();
/* 34:26 */       return 1;
/* 35:   */     }
/* 36:   */     finally
/* 37:   */     {
/* 38:29 */       if (this.con != null) {
/* 39:30 */         this.con.close();
/* 40:   */       }
/* 41:   */     }
/* 42:   */   }
/* 43:   */   
/* 44:   */   public void logout(HttpServletRequest paramHttpServletRequest)
/* 45:   */     throws Exception
/* 46:   */   {
/* 47:   */     try
/* 48:   */     {
/* 49:38 */       HttpSession localHttpSession = paramHttpServletRequest.getSession(false);
/* 50:   */       
/* 51:40 */       this.con = ConnectDatabase.getConnection();
/* 52:41 */       this.con.setAutoCommit(false);
/* 53:42 */       this.pst = this.con.prepareStatement("update user_session set logout_time=now() where login_id=? and session_id=?");
/* 54:43 */       System.out.println((String)localHttpSession.getAttribute("login_id") + "<>" + localHttpSession.getId() + "<>");
/* 55:44 */       this.pst.setString(1, (String)localHttpSession.getAttribute("login_id"));
/* 56:45 */       this.pst.setString(2, localHttpSession.getId());
/* 57:46 */       int i = this.pst.executeUpdate();
/* 58:47 */       System.out.println("Update Count " + i);
/* 59:48 */       this.con.commit();
/* 60:49 */       if (localHttpSession != null)
/* 61:   */       {
/* 62:51 */         Enumeration localEnumeration = localHttpSession.getAttributeNames();
/* 63:52 */         while (localEnumeration.hasMoreElements())
/* 64:   */         {
/* 65:54 */           String str = localEnumeration.nextElement().toString();
/* 66:55 */           localHttpSession.removeAttribute(str);
/* 67:   */         }
/* 68:57 */         localHttpSession.invalidate();
/* 69:   */       }
/* 70:   */     }
/* 71:   */     catch (Exception localException)
/* 72:   */     {
/* 73:61 */       localException.printStackTrace();
/* 74:   */     }
/* 75:   */     finally
/* 76:   */     {
/* 77:64 */       if (this.con != null) {
/* 78:65 */         this.con.close();
/* 79:   */       }
/* 80:   */     }
/* 81:   */   }
/* 82:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.SessionHandler
 * JD-Core Version:    0.7.0.1
 */