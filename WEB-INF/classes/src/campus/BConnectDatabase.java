/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.PrintStream;
/*  4:   */ import java.sql.Connection;
/*  5:   */ import org.apache.tomcat.jdbc.pool.DataSource;
/*  6:   */ import org.apache.tomcat.jdbc.pool.PoolProperties;
/*  7:   */ 
/*  8:   */ public class BConnectDatabase
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
/* 37:55 */     String str1 = "jdbc:mysql://localhost:3306/bist_erp_db";
/* 38:56 */     String str2 = "com.mysql.jdbc.Driver";
/* 39:57 */     String str3 = "erpadmin";
/* 40:58 */     String str4 = "test";
/* 41:   */     
/* 42:   */ 
/* 43:61 */     PoolProperties localPoolProperties = new PoolProperties();
/* 44:62 */     localPoolProperties.setUrl(str1);
/* 45:63 */     localPoolProperties.setDriverClassName("com.mysql.jdbc.Driver");
/* 46:64 */     localPoolProperties.setUsername(str3);
/* 47:65 */     localPoolProperties.setPassword(str4);
/* 48:66 */     localPoolProperties.setJmxEnabled(true);
/* 49:67 */     localPoolProperties.setTestWhileIdle(false);
/* 50:68 */     localPoolProperties.setTestOnBorrow(true);
/* 51:69 */     localPoolProperties.setValidationQuery("SELECT 1");
/* 52:70 */     localPoolProperties.setTestOnReturn(false);
/* 53:71 */     localPoolProperties.setValidationInterval(30000L);
/* 54:72 */     localPoolProperties.setTimeBetweenEvictionRunsMillis(30000);
/* 55:73 */     localPoolProperties.setMaxActive(1);
/* 56:74 */     localPoolProperties.setInitialSize(1);
/* 57:75 */     localPoolProperties.setMaxWait(10000);
/* 58:76 */     localPoolProperties.setRemoveAbandonedTimeout(60);
/* 59:77 */     localPoolProperties.setMinEvictableIdleTimeMillis(30000);
/* 60:78 */     localPoolProperties.setMinIdle(1);
/* 61:79 */     localPoolProperties.setLogAbandoned(true);
/* 62:80 */     localPoolProperties.setRemoveAbandoned(true);
/* 63:81 */     localPoolProperties.setJdbcInterceptors("org.apache.tomcat.jdbc.pool.interceptor.ConnectionState;org.apache.tomcat.jdbc.pool.interceptor.StatementFinalizer");
/* 64:   */     
/* 65:83 */     datasource.setPoolProperties(localPoolProperties);
/* 66:84 */     System.out.println("Data Source Initialized");
/* 67:   */   }
/* 68:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.BConnectDatabase
 * JD-Core Version:    0.7.0.1
 */