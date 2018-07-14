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
		pst=con.prepareStatement("SELECT s_no, mobile_no FROM ht_mobile_nos WHERE LENGTH(mobile_no)=10 and s_no>=? AND s_no<? ");
		pst.setString(1, startNum);
		pst.setString(2, endNum);
		System.out.println(pst);
		rsSms=pst.executeQuery();
		
		int ctr=1;
		while(rsSms.next())
		{
			alHtNo=rsSms.getString(1);
			alMobileNo=rsSms.getString(2);
			
			String SMSText="BEEE 2016: Bharath Engineering Entrance Exam shall be announced soon. Await instructions for fresh date of exam (online/offline).";
			
			boolean sessionDebug = false;

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