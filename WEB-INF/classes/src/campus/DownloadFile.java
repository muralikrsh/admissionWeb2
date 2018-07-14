/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.File;
/*  4:   */ import java.io.FileInputStream;
/*  5:   */ import java.io.IOException;
/*  6:   */ import java.io.OutputStream;
/*  7:   */ import java.io.PrintStream;
/*  8:   */ import javax.servlet.RequestDispatcher;
/*  9:   */ import javax.servlet.ServletConfig;
/* 10:   */ import javax.servlet.ServletContext;
/* 11:   */ import javax.servlet.ServletException;
/* 12:   */ import javax.servlet.ServletOutputStream;
/* 13:   */ import javax.servlet.http.HttpServlet;
/* 14:   */ import javax.servlet.http.HttpServletRequest;
/* 15:   */ import javax.servlet.http.HttpServletResponse;
/* 16:   */ 
/* 17:   */ public class DownloadFile
/* 18:   */   extends HttpServlet
/* 19:   */ {
/* 20:12 */   String fileName = "";
/* 21:13 */   private ServletContext ctx = null;
/* 22:   */   
/* 23:   */   public void init(ServletConfig paramServletConfig)
/* 24:   */     throws ServletException
/* 25:   */   {
/* 26:23 */     this.ctx = paramServletConfig.getServletContext();
/* 27:   */   }
/* 28:   */   
/* 29:   */   public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
/* 30:   */     throws ServletException, IOException
/* 31:   */   {
/* 32:29 */     doPost(paramHttpServletRequest, paramHttpServletResponse);
/* 33:   */   }
/* 34:   */   
/* 35:   */   public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
/* 36:   */     throws ServletException, IOException
/* 37:   */   {
/* 38:34 */     String str = paramHttpServletRequest.getParameter("req_id");
/* 39:36 */     if (str.intern() == "HT".intern()) {
/* 40:37 */       generateHT(paramHttpServletRequest, paramHttpServletResponse);
/* 41:   */     }
/* 42:   */   }
/* 43:   */   
/* 44:   */   public void generateHT(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
/* 45:   */     throws ServletException, IOException
/* 46:   */   {
/* 47:50 */     String str1 = (String)this.ctx.getAttribute(paramHttpServletRequest.getParameter("path"));
/* 48:   */     
/* 49:52 */     this.fileName = paramHttpServletRequest.getParameter("ht_no");
/* 50:   */     
/* 51:54 */     System.out.println("Filename:" + str1 + "+" + this.fileName);
/* 52:55 */     File localFile = new File(str1, this.fileName);
/* 53:56 */     if (localFile.exists())
/* 54:   */     {
/* 55:57 */       String str2 = this.fileName.substring(this.fileName.indexOf(".") + 1, this.fileName.length());
/* 56:58 */       System.out.println("Filetype:" + str2 + ";" + localFile.length());
/* 57:   */       
/* 58:60 */       paramHttpServletResponse.setContentType("application/pdf");
/* 59:   */       
/* 60:   */ 
/* 61:63 */       paramHttpServletResponse.setContentLength((int)localFile.length());
/* 62:   */       
/* 63:   */ 
/* 64:66 */       paramHttpServletResponse.setHeader("Cache-Control", "no-cache");
/* 65:67 */       byte[] arrayOfByte = new byte[8192];
/* 66:68 */       FileInputStream localFileInputStream = new FileInputStream(localFile);
/* 67:69 */       int i = 0;
/* 68:70 */       ServletOutputStream localServletOutputStream = paramHttpServletResponse.getOutputStream();
/* 69:71 */       while ((i = localFileInputStream.read(arrayOfByte, 0, arrayOfByte.length)) > 0)
/* 70:   */       {
/* 71:72 */         System.out.println("size:" + i);
/* 72:73 */         localServletOutputStream.write(arrayOfByte, 0, i);
/* 73:   */       }
/* 74:75 */       localServletOutputStream.flush();
/* 75:76 */       localFileInputStream.close();
/* 76:77 */       localServletOutputStream.close();
/* 77:   */     }
/* 78:   */     else
/* 79:   */     {
/* 80:79 */       this.ctx.getRequestDispatcher("/Error404.jsp").forward(paramHttpServletRequest, paramHttpServletResponse);
/* 81:   */     }
/* 82:   */   }
/* 83:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.DownloadFile
 * JD-Core Version:    0.7.0.1
 */