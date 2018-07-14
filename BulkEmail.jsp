<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String msg="";

String alEmail="";

try{

	con = ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("SELECT e_mail FROM placement_applicaton");
	rs=pst.executeQuery();
	while(rs.next()) {
	
			alEmail=rs.getString(1);		 
		
		String subject="Activation Link"; 
		String messageText=" Please update your details here. http://www.bharathuniv.ac.in/";
		String host = "smtp.gmail.com";
		String from="jaisriram108@gmail.com";
		boolean sessionDebug = false;

Properties props = System.getProperties();

		
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.user", "admission@bharathuniv.ac.in"); 
		props.put("mail.smtp.pass", "MANAGINGDIRECTOR6999"); 
		try {	
			Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
				public PasswordAuthentication getPasswordAuthentication() {
				   return new PasswordAuthentication("admission@bharathuniv.ac.in", "MANAGINGDIRECTOR6999");
				}
			});
			mailSession.setDebug(sessionDebug);
			Message msg1 = new MimeMessage(mailSession);
			InternetAddress[] address = {new InternetAddress(alEmail)};

			msg1.setFrom(new InternetAddress(from));
			msg1.setRecipients(Message.RecipientType.TO, address);
			msg1.setSubject(subject);
			msg1.setText(messageText);
			Transport.send(msg1);
			System.out.println("Mail was sent to " + alEmail);
		} catch(Exception e1) {
			e1.printStackTrace();	
			System.out.println("Error while sending activation link to " + alEmail);
		}	
	}	
	System.out.println(msg);	
}
catch (Exception e){
	
	e.printStackTrace();
	msg="error";
	System.out.println(msg);	
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= msg %>