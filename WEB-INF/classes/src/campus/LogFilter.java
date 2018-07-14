/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.IOException;
/*  4:   */ import java.io.PrintStream;
/*  5:   */ import java.sql.Connection;
/*  6:   */ import java.sql.PreparedStatement;
/*  7:   */ import javax.servlet.Filter;
/*  8:   */ import javax.servlet.FilterChain;
/*  9:   */ import javax.servlet.FilterConfig;
/* 10:   */ import javax.servlet.ServletException;
/* 11:   */ import javax.servlet.ServletRequest;
/* 12:   */ import javax.servlet.ServletResponse;
/* 13:   */ import javax.servlet.http.HttpServletRequest;
/* 14:   */ import javax.servlet.http.HttpSession;
/* 15:   */ 
/* 16:   */ public class LogFilter
/* 17:   */   implements Filter
/* 18:   */ {
/* 19:   */   public void doFilter(ServletRequest paramServletRequest, ServletResponse paramServletResponse, FilterChain paramFilterChain)
/* 20:   */     throws IOException, ServletException
/* 21:   */   {
/* 22:21 */     HttpServletRequest localHttpServletRequest = (HttpServletRequest)paramServletRequest;
/* 23:   */     
/* 24:   */ 
/* 25:24 */     String str1 = localHttpServletRequest.getRequestURI().toString();
/* 26:25 */     String str2 = (String)localHttpServletRequest.getSession().getAttribute("login_id");
/* 27:26 */     Connection localConnection = null;
/* 28:27 */     PreparedStatement localPreparedStatement = null;
/* 29:   */     try
/* 30:   */     {
/* 31:31 */       if (str1.indexOf("jsp") != -1)
/* 32:   */       {
/* 33:32 */         localConnection = ConnectDatabase.getConnection();
/* 34:33 */         localConnection.setAutoCommit(false);
/* 35:34 */         localPreparedStatement = localConnection.prepareStatement("insert into user_audit (user_id, screen,reqtime) values (?,?,now())");
/* 36:35 */         localPreparedStatement.setString(1, str2);
/* 37:36 */         localPreparedStatement.setString(2, str1);
/* 38:37 */         localPreparedStatement.executeUpdate();
/* 39:38 */         localConnection.commit();
/* 40:   */       }
/* 41:   */       try
/* 42:   */       {
/* 43:49 */         if (localConnection != null) {
/* 44:50 */           localConnection.close();
/* 45:   */         }
/* 46:   */       }
/* 47:   */       catch (Exception localException1) {}
/* 48:56 */       paramFilterChain.doFilter(paramServletRequest, paramServletResponse);
/* 49:   */     }
/* 50:   */     catch (Exception localException2)
/* 51:   */     {
/* 52:43 */       localException2.printStackTrace();
/* 53:44 */       System.out.println("Unable to Audit user Action");
/* 54:   */     }
/* 55:   */     finally
/* 56:   */     {
/* 57:   */       try
/* 58:   */       {
/* 59:49 */         if (localConnection != null) {
/* 60:50 */           localConnection.close();
/* 61:   */         }
/* 62:   */       }
/* 63:   */       catch (Exception localException4) {}
/* 64:   */     }
/* 65:   */   }
/* 66:   */   
/* 67:   */   public void init(FilterConfig paramFilterConfig)
/* 68:   */     throws ServletException
/* 69:   */   {}
/* 70:   */   
/* 71:   */   public void destroy() {}
/* 72:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.LogFilter
 * JD-Core Version:    0.7.0.1
 */