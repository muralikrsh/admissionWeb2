/*  1:   */ package campus;
/*  2:   */ 
/*  3:   */ import java.io.OutputStreamWriter;
/*  4:   */ import java.io.PrintStream;
/*  5:   */ import java.net.HttpURLConnection;
/*  6:   */ import java.net.URL;
/*  7:   */ import java.net.URLEncoder;
/*  8:   */ import java.sql.Connection;
/*  9:   */ import java.sql.PreparedStatement;
/* 10:   */ import java.sql.ResultSet;
/* 11:   */ import java.util.ArrayList;
/* 12:   */ 
/* 13:   */ public class SendSMS
/* 14:   */ {
/* 15:15 */   Connection con = null;
/* 16:16 */   PreparedStatement pst = null;
/* 17:17 */   ResultSet rs = null;
/* 18:18 */   ArrayList alSeqNo = new ArrayList();
/* 19:19 */   ArrayList alMobileNo = new ArrayList();
/* 20:20 */   ArrayList alMessage = new ArrayList();
/* 21:   */   
/* 22:   */   public void send()
/* 23:   */     throws Exception
/* 24:   */   {
/* 25:   */     try
/* 26:   */     {
/* 27:25 */       this.con = ConnectDatabase.getConnection();
/* 28:26 */       this.con.setAutoCommit(false);
/* 29:27 */       System.out.println("Message 1");
/* 30:28 */       this.pst = this.con.prepareStatement("select seq_no,mobile_number, msg from sms_data where status='P'");
/* 31:29 */       this.rs = this.pst.executeQuery();
/* 32:30 */       System.out.println("Message 2");
/* 33:31 */       while (this.rs.next())
/* 34:   */       {
/* 35:32 */         this.alSeqNo.add(this.rs.getString(1));
/* 36:33 */         this.alMobileNo.add(this.rs.getString(2));
/* 37:34 */         this.alMessage.add(this.rs.getString(3));
/* 38:   */       }
/* 39:36 */       System.out.println("Message 3");
/* 40:37 */       for (int i = 0; i < this.alSeqNo.size(); i++)
/* 41:   */       {
/* 42:39 */         System.out.println("Message 4");
/* 43:40 */         mesg("91" + (String)this.alMobileNo.get(i), (String)this.alMessage.get(i));
/* 44:41 */         this.pst = this.con.prepareStatement("update sms_data set status='S', send_time=now() where seq_no=?");
/* 45:42 */         this.pst.setString(1, (String)this.alSeqNo.get(i));
/* 46:43 */         this.pst.executeUpdate();
/* 47:44 */         System.out.println("Email 5");
/* 48:   */       }
/* 49:46 */       this.con.commit();
/* 50:47 */       System.out.println("Email 6");
/* 51:   */     }
/* 52:   */     catch (Exception localException)
/* 53:   */     {
/* 54:50 */       localException.printStackTrace();
/* 55:   */     }
/* 56:   */     finally
/* 57:   */     {
/* 58:53 */       if (this.con != null) {
/* 59:54 */         this.con.close();
/* 60:   */       }
/* 61:   */     }
/* 62:   */   }
/* 63:   */   
/* 64:   */   public int mesg(String paramString1, String paramString2)
/* 65:   */     throws Exception
/* 66:   */   {
/* 67:62 */     String str = "http://www.bulksmsapps.com/apisms.aspx?user=BharathUniversity&password=P2IRV3&genkey=059631998&sender=BHUNIV&number=" + paramString1 + "&message=" + URLEncoder.encode(paramString2) + "";
/* 68:   */     
/* 69:   */ 
/* 70:65 */     URL localURL = new URL(str);
/* 71:66 */     HttpURLConnection localHttpURLConnection = (HttpURLConnection)localURL.openConnection();
/* 72:67 */     localHttpURLConnection.setDoOutput(true);
/* 73:68 */     localHttpURLConnection.setRequestMethod("GET");
/* 74:69 */     OutputStreamWriter localOutputStreamWriter = new OutputStreamWriter(localHttpURLConnection.getOutputStream());
/* 75:70 */     System.out.println(localHttpURLConnection.getResponseCode());
/* 76:71 */     System.out.println(localHttpURLConnection.getResponseMessage());
/* 77:72 */     localOutputStreamWriter.close();
/* 78:73 */     return 0;
/* 79:   */   }
/* 80:   */   
/* 81:   */   public static void main(String[] paramArrayOfString)
/* 82:   */     throws Exception
/* 83:   */   {
/* 84:79 */     new SendSMS().send();
/* 85:   */   }
/* 86:   */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.SendSMS
 * JD-Core Version:    0.7.0.1
 */