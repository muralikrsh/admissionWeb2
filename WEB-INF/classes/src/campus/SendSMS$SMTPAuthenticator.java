/*   1:    */ package campus;
/*   2:    */ 
/*   3:    */ import javax.mail.Authenticator;
/*   4:    */ import javax.mail.PasswordAuthentication;
/*   5:    */ 
/*   6:    */ class SendSMS$SMTPAuthenticator
/*   7:    */   extends Authenticator
/*   8:    */ {
/*   9:    */   private SendSMS$SMTPAuthenticator(SendSMS paramSendSMS) {}
/*  10:    */   
/*  11:    */   public PasswordAuthentication getPasswordAuthentication()
/*  12:    */   {
/*  13:103 */     String str1 = "support@campus2cubicle.com";
/*  14:104 */     String str2 = "test1234";
/*  15:105 */     return new PasswordAuthentication(str1, str2);
/*  16:    */   }
/*  17:    */ }


/* Location:           C:\Tomcat 7.0\webapps\admissionWeb2\WEB-INF\classes\
 * Qualified Name:     campus.SendSMS.SMTPAuthenticator
 * JD-Core Version:    0.7.0.1
 */