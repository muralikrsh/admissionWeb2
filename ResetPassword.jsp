<%@page import="java.sql.*, java.io.*, java.util.*, campus.*"%>

<%
	Connection con = null;
	PreparedStatement pst = null;
	ResultSet rs=null;
	
String strEmailId=request.getParameter("txtEmail");
boolean flag=false;
int num=0;
String str="";

    try{
      con = ConnectDatabase.getConnection();
	  con.setAutoCommit(false);
	  // pst=con.prepareStatement("select email from student_profile where binary regn_no=? and binary email=?");
	  pst=con.prepareStatement("select email_id from adm_login where binary id=? and binary email_id=?");
		String userId=request.getParameter("txtUserID");
		
		String strRole="";
		String dept_id="";
			pst.setString(1,userId);
			pst.setString(2,strEmailId);
			rs=pst.executeQuery();
			if(rs.next()) {
					Random rand = new Random();
				    num = rand.nextInt(10000);
					flag=true;
			} else {
					throw new Exception("EMAIL_NO_MATCH");
			}
			rs=null;
			pst=null;
			pst=con.prepareStatement("insert into messages");
			if(flag) {
				pst=con.prepareStatement("update adm_login set password=? where id=?");
				pst.setString(1,num+"");
				pst.setString(2,userId);
				pst.executeUpdate();

				pst=con.prepareStatement("select max(message_id)+1 from messages");
				rs=pst.executeQuery();
				String msg_id="1";
				if(rs.next())
					msg_id=rs.getString(1);
				if(msg_id==null)
					msg_id="1";
				System.out.println("Email 2");
				pst=con.prepareStatement("insert into messages values(?,?,?)");
				pst.setString(1,msg_id);
				pst.setString(2,"Your eUniv password has been reset\n The new password is "+num);
				pst.setString(3,"Password Reset");
				pst.executeUpdate();
				System.out.println("Email 3");
				pst=null;
				pst=con.prepareStatement("insert into email_data (email_id, msg_id, recv_time, send_time, status)  values(?,?,now(),null,?)");
				System.out.println("Email "+strEmailId);
				pst.setString(1,strEmailId);
				pst.setString(2,msg_id);
				pst.setString(3,"P");
				pst.executeUpdate();
				System.out.println("Email 4");

				con.commit();
			}

		System.out.println("Here 3 "+str);	
		%>
		<%= "PASS_RESET" %>
		<%
    }
	catch (Exception e){
			System.out.println(e.toString());
		if(e.toString().indexOf("EMAIL_NO_MATCH")!= -1) {
		%>
		EMAIL_NO_MATCH
		<% } else { %>
		INVALID_LOGIN
		<%
		}
    }
	finally {
		if(con!=null)
			con.close();
		con=null; pst=null; rs=null;
	}
%>