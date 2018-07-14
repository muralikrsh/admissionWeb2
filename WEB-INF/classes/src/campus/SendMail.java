/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import java.io.PrintStream;
/*   4:    */ import java.sql.Connection;
/*   5:    */ import java.sql.PreparedStatement;
/*   6:    */ import java.sql.ResultSet;
/*   7:    */ import java.util.ArrayList;
/*   8:    */ import java.util.HashMap;
/*   9:    */ import java.util.Properties;
/*  10:    */ import javax.mail.Authenticator;
/*  11:    */ import javax.mail.Message;
/*  12:    */ import javax.mail.Message.RecipientType;
/*  13:    */ import javax.mail.PasswordAuthentication;
/*  14:    */ import javax.mail.Session;
/*  15:    */ import javax.mail.Transport;
/*  16:    */ import javax.mail.internet.AddressException;
/*  17:    */ import javax.mail.internet.InternetAddress;
/*  18:    */ import javax.mail.internet.MimeMessage;
/*  19:    */ 
/*  20:    */ public class SendMail
/*  21:    */ {
/*  22:    */   Connection con;
/*  23:    */   PreparedStatement pst;
/*  24:    */   ResultSet rs;
/*  25:    */   ArrayList alSeqNo;
/*  26:    */   ArrayList alEmailId;
/*  27:    */   ArrayList alSubject;
/*  28:    */   ArrayList alMessage;
/*  29:    */   HashMap hmStatus;
/*  30:    */   Properties props;
/*  31:    */   Authenticator auth;
/*  32:    */   Session mailSession;
/*  33:    */   
/*  34:    */   public SendMail()
/*  35:    */   {
/*  36: 18 */     this.con = null;
/*  37: 19 */     this.pst = null;
/*  38: 20 */     this.rs = null;
/*  39: 21 */     this.alSeqNo = new ArrayList();
/*  40: 22 */     this.alEmailId = new ArrayList();
/*  41: 23 */     this.alSubject = new ArrayList();
/*  42: 24 */     this.alMessage = new ArrayList();
/*  43: 25 */     this.hmStatus = new HashMap();
/*  44: 26 */     this.props = new Properties();
/*  45: 27 */     this.auth = null;
/*  46: 28 */     this.mailSession = null;
/*  47:    */   }
/*  48:    */   
/*  49:    */   public void send()
/*  50:    */     throws Exception
/*  51:    */   {
/*  52:    */     try
/*  53:    */     {
/*  54: 33 */       this.props.put("mail.smtp.host", "mail.euniv.in");
/*  55: 34 */       this.props.put("mail.smtp.port", "2525");
/*  56: 35 */       this.props.put("mail.smtp.auth", "true");
/*  57: 36 */       this.props.put("mail.smtp.user", "support");
/*  58: 37 */       this.props.put("mail.smtp.pass", "India123$");
/*  59: 38 */       System.out.println("Properties " + this.props);
/*  60: 39 */       //this.auth = new SMTPAuthenticator(null);
/*  61: 40 */       System.out.println("Auth " + this.auth);
/*  62: 41 */       this.mailSession = Session.getDefaultInstance(this.props, this.auth);
/*  63: 42 */       System.out.println("MailSession " + this.mailSession);
/*  64:    */       
/*  65:    */ 
/*  66:    */ 
/*  67:    */ 
/*  68:    */ 
/*  69:    */ 
/*  70: 49 */       this.con = BConnectDatabase.getConnection();
/*  71: 50 */       this.pst = this.con.prepareStatement("select distinct a.seq_no,a.email_id, b.subject, b.message from email_data a, messages b where a.msg_id=b.message_id and a.status='P' and a.email_id is not null");
/*  72: 51 */       this.rs = this.pst.executeQuery();
/*  73: 53 */       while (this.rs.next())
/*  74:    */       {
/*  75: 54 */         this.alSeqNo.add(this.rs.getString(1));
/*  76: 55 */         this.alEmailId.add(this.rs.getString(2));
/*  77: 56 */         this.alSubject.add(this.rs.getString(3));
/*  78: 57 */         this.alMessage.add(this.rs.getString(4));
/*  79:    */       }
/*  80: 59 */       this.con.close();
/*  81: 60 */       System.out.println("Identified Mailing List");
/*  82: 61 */       for (int i = 0; i < this.alSeqNo.size(); i++) {
/*  83: 63 */         mail((String)this.alSeqNo.get(i), (String)this.alEmailId.get(i), (String)this.alSubject.get(i), (String)this.alMessage.get(i));
/*  84:    */       }
/*  85: 66 */       this.con = ConnectDatabase.getConnection();
/*  86: 67 */       this.con.setAutoCommit(false);
/*  87:    */       
/*  88: 69 */       this.pst = this.con.prepareStatement("update email_data set status='S', send_time=now() where seq_no=?");
/*  89: 70 */       for (int i = 0; i < this.alSeqNo.size(); i++)
/*  90:    */       {
/*  91: 72 */         String str = (String)this.alSeqNo.get(i);
/*  92: 73 */         if (this.hmStatus.get(str).toString().intern() == "S".intern())
/*  93:    */         {
/*  94: 74 */           this.pst.setString(1, str);
/*  95: 75 */           this.pst.addBatch();
/*  96: 76 */           System.out.println("Email Status Updated for Seq No " + str);
/*  97:    */         }
/*  98:    */       }
/*  99: 80 */       this.pst.executeBatch();
/* 100: 81 */       this.con.commit();
/* 101: 82 */       System.out.println("Email Batch Completed");
/* 102:    */     }
/* 103:    */     catch (Exception localException)
/* 104:    */     {
/* 105: 85 */       localException.printStackTrace();
/* 106:    */     }
/* 107:    */     finally
/* 108:    */     {
/* 109: 88 */       if (this.con != null) {
/* 110: 89 */         this.con.close();
/* 111:    */       }
/* 112:    */     }
/* 113:    */   }
/* 114:    */   
/* 115:    */   public void mail(String paramString1, String paramString2, String paramString3, String paramString4)
/* 116:    */   {
/* 117: 94 */     System.out.println("Sending Mail to " + paramString2);
/* 118: 95 */     MimeMessage localMimeMessage = new MimeMessage(this.mailSession);
/* 119:    */     
/* 120: 97 */     InternetAddress localInternetAddress1 = null;
/* 121: 98 */     InternetAddress localInternetAddress2 = null;
/* 122:    */     try
/* 123:    */     {
/* 124:100 */       localInternetAddress1 = new InternetAddress("support@campus2cubicle.com");
/* 125:101 */       localInternetAddress2 = new InternetAddress(paramString2);
/* 126:    */     }
/* 127:    */     catch (AddressException localAddressException)
/* 128:    */     {
/* 129:104 */       localAddressException.printStackTrace();
/* 130:    */     }
/* 131:    */     try
/* 132:    */     {
/* 133:108 */       localMimeMessage.setFrom(localInternetAddress1);
/* 134:109 */       localMimeMessage.setRecipient(Message.RecipientType.TO, localInternetAddress2);
/* 135:110 */       localMimeMessage.setSubject(paramString3);
/* 136:111 */       localMimeMessage.setText(paramString4);
/* 137:    */       
/* 138:113 */       Transport.send(localMimeMessage);
/* 139:114 */       this.hmStatus.put(paramString1, "S");
/* 140:115 */       System.out.println("Mail sent to " + paramString2);
/* 141:    */     }
/* 142:    */     catch (Exception localException)
/* 143:    */     {
/* 144:118 */       this.hmStatus.put(paramString1, "F");
/* 145:119 */       System.out.println("Error while sending mail to " + paramString2);
/* 146:120 */       localException.printStackTrace();
/* 147:    */     }
/* 148:    */   }
/* 149:    */   
/* 150:    */   public static void main(String[] paramArrayOfString)
/* 151:    */     throws Exception
/* 152:    */   {
/* 153:125 */     new SendMail().send();
/* 154:    */   }
/* 155:    */   
/* 156:    */   private class SMTPAuthenticator
/* 157:    */     extends Authenticator
/* 158:    */   {
/* 159:    */     private SMTPAuthenticator() {}
/* 160:    */     
/* 161:    */     public PasswordAuthentication getPasswordAuthentication()
/* 162:    */     {
/* 163:130 */       String str1 = "support";
/* 164:131 */       String str2 = "teju1984";
/* 165:    */       
/* 166:    */ 
/* 167:134 */       return new PasswordAuthentication(str1, str2);
/* 168:    */     }
/* 169:    */   }
/* 170:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.SendMail
 * JD-Core Version:    0.7.0.1
 */