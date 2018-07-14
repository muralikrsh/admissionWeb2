package campus;

import java.sql.*;

public class StudentPayment {

	Connection con;
	PreparedStatement pst;
	ResultSet rs;
	
	public StudentPayment() {
		con=null;
		pst=null;
		rs=null;
	}
	
	public void generatePaymentID(String strPayTerm, String strUser, String strAdmissionNumber){
		try{
			con=ConnectDatabase.getConnection();
			con.setAutoCommit(false);
			String strPayment="insert into student_payment( student_id,amount_term,created_by,created_time ) values( ?,?,?,now() )";
			pst=con.prepareStatement(strPayment);
			pst.setString(1, strAdmissionNumber);
			pst.setString(2, strPayTerm);
			pst.setString(3, strUser);
			pst.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try{
				con.close();
			}catch(Exception ex){}
		}
	}
	
	public String getPaymentID(String strPayTerm, String strAdmissionNumber){
		String strPaymentID="";
		try{
			con=ConnectDatabase.getConnection();
			String strPayment="select payment_id from student_payment where student_id=? and amount_term=? ";
			pst=con.prepareStatement(strPayment);
			pst.setString(1, strAdmissionNumber);
			pst.setString(2, strPayTerm);
			rs=pst.executeQuery();
			if(rs.next()){
				strPaymentID=rs.getString(1);
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			try{
				con.close();
			}catch(Exception ex){}
		}
		return strPaymentID;
	}
}