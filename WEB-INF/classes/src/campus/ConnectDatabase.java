/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.sql.Connection;
/*  5:   */ import org.apache.tomcat.jdbc.pool.DataSource;
/*  6:   */ import org.apache.tomcat.jdbc.pool.PoolProperties;
/*  7:   */ 
/*  8:   */ public class ConnectDatabase
/*  9:   */ {
/* 10: 9 */   static DataSource datasource = new DataSource();
/* 11:   */   
/* 12:   */   static
/* 13:   */   {
/* 14:   */     try
/* 15:   */     {
/* 16:14 */       initialize();
/* 17:   */     }
/* 18:   */     catch (Exception localException)
/* 19:   */     {
/* 20:18 */       System.out.println("Error while initializing Data Source");
/* 21:19 */       localException.printStackTrace();
/* 22:   */     }
/* 23:   */   }
/* 24:   */   
/* 25:   */   public static Connection getConnection()
/* 26:   */     throws Exception
/* 27:   */   {
/* 28:25 */     if (datasource == null) {
/* 29:26 */       initialize();
/* 30:   */     }
/* 31:28 */     return datasource.getConnection();
/* 32:   */   }
/* 33:   */   
/* 34:   */   public static void initialize()
/* 35:   */     throws Exception
/* 36:   */   {
/* 37:48 */     String str1 = "jdbc:mysql://localhost:3306/bist_erp_db";
/* 38:49 */     String str2 = "com.mysql.jdbc.Driver";
/* 39:50 */     String str3 = "erpadmin";
/* 40:51 */     String str4 = "test";
/* 41:   */     
/* 42:   */ 
/* 43:54 */     PoolProperties localPoolProperties = new PoolProperties();
/* 44:55 */     localPoolProperties.setUrl(str1);
/* 45:56 */     localPoolProperties.setDriverClassName("com.mysql.jdbc.Driver");
/* 46:57 */     localPoolProperties.setUsername(str3);
/* 47:58 */     localPoolProperties.setPassword(str4);
/* 48:59 */     localPoolProperties.setJmxEnabled(true);
/* 49:60 */     localPoolProperties.setTestWhileIdle(false);
/* 50:61 */     localPoolProperties.setTestOnBorrow(true);
/* 51:62 */     localPoolProperties.setValidationQuery("SELECT 1");
/* 52:63 */     localPoolProperties.setTestOnReturn(false);
/* 53:64 */     localPoolProperties.setValidationInterval(30000L);
/* 54:65 */     localPoolProperties.setTimeBetweenEvictionRunsMillis(30000);
/* 55:66 */     localPoolProperties.setMaxActive(5);
/* 56:67 */     localPoolProperties.setInitialSize(5);
/* 57:68 */     localPoolProperties.setMaxWait(10000);
/* 58:69 */     localPoolProperties.setRemoveAbandonedTimeout(60);
/* 59:70 */     localPoolProperties.setMinEvictableIdleTimeMillis(30000);
/* 60:71 */     localPoolProperties.setMinIdle(10);
/* 61:72 */     localPoolProperties.setLogAbandoned(true);
/* 62:73 */     localPoolProperties.setRemoveAbandoned(true);
/* 63:74 */     localPoolProperties.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
/* 64:   */     
/* 65:76 */     datasource.setPoolProperties(localPoolProperties);
/* 66:77 */     System.out.println("Data Source Initialized");
/* 67:   */   }
/* 68:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.ConnectDatabase
 * JD-Core Version:    0.7.0.1
 */