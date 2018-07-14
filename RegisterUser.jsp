
<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%
Connection con = null;
PreparedStatement pst = null;
ResultSet rs=null;
String msg="";
try{

	con = ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	pst=con.prepareStatement("select name from adm_login where binary id=?");
	System.out.println("select name from adm_login where binary id=?");

	String userId=request.getParameter("txtUserID");
	String userName=request.getParameter("txtUserName");
	String email=request.getParameter("txtEmail");
	String password=request.getParameter("txtPassword");
	String degree=request.getParameter("degree");
	String sq1=request.getParameter("sq1");
	String sa1=request.getParameter("sa1");
	String sq2=request.getParameter("sq2");
	String sa2=request.getParameter("sa2");
	String mobile_no=request.getParameter("mobile_no");
	System.out.println(userId+" "+password);	
	String strRole="";
	String dept_id="";
	pst.setString(1,userId);
	rs=pst.executeQuery();
	if(rs.next()) {
		msg="USER_EXISTS";
	} else {
			System.out.println("Before Insert");
		pst=con.prepareStatement("insert into adm_login (id,name,password,role,status,email_id, act_id, act_dt,sq1,sa1,sq2,sa2,mobile_no,degree) values (?,?,?,'STUDENT','C',?,?,now(),?,?,?,?,?,?)");
		Random rand = new Random();
		int num = rand.nextInt(10000);
		String actId=num+"";
		pst.setString(1,userId);
		pst.setString(2,userName);
		pst.setString(3,password);
		pst.setString(4,email);
		pst.setString(5,actId);
		pst.setString(6,sq1);
		pst.setString(7,sa1);
		pst.setString(8,sq2);
		pst.setString(9,sa2);
		pst.setString(10,mobile_no);
		pst.setString(11,degree);
		pst.executeUpdate();
		con.commit();
		msg="USER_CREATED";
		
		String subject="Activation Link";
		String messageText="Please click the activation link to complete your registration  \n http://admission.bharathuniv.ac.in/admissionWeb2/ActivateUser.jsp?act_id="+actId+"&user_id="+userId;
		//String messageText="Please click the activation link to complete your registration \n http://localhost:8080/admission/ActivateUser.jsp?act_id="+actId+"&user_id="+userId;
		String SMSText="Please click the link in your email to complete your registration \n http://admission.bharathuniv.ac.in/admissionWeb2/ActivateUser.jsp?act_id="+actId+"&user_id="+userId;
		String host = "smtp.gmail.com";
		String from="jaisriram108@gmail.com";
		boolean sessionDebug = false;

		//Send Activation Link by Email
		
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
			InternetAddress[] address = {new InternetAddress(email)};

			msg1.setFrom(new InternetAddress(from));
			msg1.setRecipients(Message.RecipientType.TO, address);
			msg1.setSubject(subject);
			msg1.setText(messageText);
			Transport.send(msg1);
			System.out.println("Mail was sent to " + email);
		} catch(Exception e1) {
			e1.printStackTrace();	
			System.out.println("Error while sending activation link to " + email);
		}		

		int retSMS=new SendSMS2().mesg("91"+mobile_no,SMSText); 
		/* Commented SMS Activation Link
		int retSMS=new SendSMS2().mesg("91"+mobile_no,SMSText); 
		*/
	
	}	
	System.out.println(msg);	
}
catch (Exception e){
	con.rollback();
	e.printStackTrace();
	msg="USER_CREATION_ERROR";
	System.out.println(msg);	
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= msg %>