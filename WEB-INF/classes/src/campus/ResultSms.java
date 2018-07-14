package campus;

import java.sql.*;

public class ResultSms {
	Connection con = null;

public String sendSMS(String startNum, String endNum){

	String msg="";
	String alHtNo="";
	String alStuName="";
	String alRank="";
	String alMobileNo="";

	try{
		PreparedStatement pst = null;
		ResultSet rsSms=null;

		con = ConnectDatabase.getConnection();
		pst=con.prepareStatement("SELECT ht_no, first_name, mobile_no FROM hall_ticket_2016 WHERE LENGTH(mobile_no)=10 and ht_no>=? AND ht_no<? ");
		pst.setString(1, startNum);
		pst.setString(2, endNum);
		System.out.println(pst);
		rsSms=pst.executeQuery();
		
		int ctr=1;
		while(rsSms.next())
		{
			alHtNo=rsSms.getString(1);
			alStuName=rsSms.getString(2);
			alMobileNo=rsSms.getString(3);
			
			String SMSText="Dear "+alStuName+", Download Your Bharath Engineering Entrance Exam(BEEE 2016) Hall Ticket (No:"+alHtNo+") from www.bharathuniv.ac.in. Exam date : 30-04-2016.";
			
			new SendSMS2().mesg("91"+alMobileNo,SMSText); 
			msg="SMS sent successfully";
			System.out.println(ctr++ +" - "+alMobileNo+", "+alHtNo);
		}
		pst=null; rsSms=null;
		System.out.println(msg);
	}
	catch (Exception e){
		
		e.printStackTrace();
		msg="error";
		System.out.println(msg);	
	}
	finally {
			if(con!=null)
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		con=null;
	}
	return msg;
}
}