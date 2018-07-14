<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String submitted_by=(String)session.getAttribute("login_id");
String arrTxt[]= {"APPN_NO","HT_NO","CANDIDATE_NAME","PARENT_NAME","MOBILE_NO","COURSE","ADDRESS","CITY","STATE","PINCODE","EXAM_VENUE"};
ArrayList alMain=new ArrayList();
String str=null;
StringBuffer buf=new StringBuffer();

String mesg="";
String exam_venue="";
try {
	con=ConnectDatabase.getConnection();

	pst=con.prepareStatement("SELECT appn_no, man_appn_no, ht_no, first_name, parent_name, mobile_no, course, address, city, state, pincode, CONCAT(centre_address_1,' ',centre_address_2) AS exam_centre FROM hall_ticket_2016 ");
	rs=pst.executeQuery();
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString("appn_no"));
		alSub.add(rs.getString("man_appn_no"));
		alSub.add(rs.getString("ht_no"));
		alSub.add(rs.getString("first_name"));
		alSub.add(rs.getString("parent_name"));
		alSub.add(rs.getString("mobile_no"));
		alSub.add(rs.getString("course"));
		alSub.add(rs.getString("address"));
		alSub.add(rs.getString("city"));
		alSub.add(rs.getString("state"));
		alSub.add(rs.getString("pincode"));
		alSub.add(rs.getString("exam_centre"));
		alMain.add(alSub);
	}
	}
	catch(Exception e1){
		mesg="Error while Generating Hall Tickets "+e1.toString();
//		e1.printStackTrace();
	}
	finally {
			if(con!=null)
				con.close();
			con=null; pst=null;
	}
	try {
		String TEMPLATE_PATH=(String)application.getAttribute("TEMPLATE_PATH");
		BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(TEMPLATE_PATH+"hallticket.txt")));
				
		while((str=br.readLine())!=null) {
			buf.append(str);

		}
		String HALLTICKET_PATH=(String)application.getAttribute("HALLTICKET_PATH");
		String HT_BATCH=(String)application.getAttribute("HT_BATCH");

		for(int i=0; i<alMain.size(); i++) {

			StringBuffer strBuf=new StringBuffer(buf);
			ArrayList alSub=(ArrayList)alMain.get(i);

			int loc=0;
			for(int j=0; j<alSub.size()-1; j++)
			{
				loc=strBuf.toString().indexOf("$$"+arrTxt[j]);
				System.out.println("Size "+loc+", "+(String)alSub.get(j+1)+", "+j+" - "+arrTxt[j]+", "+loc+ (arrTxt[j].length()+2));
				strBuf=strBuf.replace(loc, loc+ (arrTxt[j].length()+2), (String)alSub.get(j+1));
			}
			
			String appn_no=(String)alSub.get(2);
			System.out.println(HALLTICKET_PATH+appn_no+".html");
			BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(HALLTICKET_PATH+appn_no+".html")));
			bw.write(strBuf.toString());
			bw.flush();
			bw.close();
		}
	mesg="Hall Tickets (HTML) generated successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	out.println(mesg);
	out.flush();
    String execpath="cmd.exe /c start "+HALLTICKET_PATH+HT_BATCH;
	
	Runtime.getRuntime().exec(execpath);
	System.out.println(HALLTICKET_PATH+HT_BATCH);
	mesg="Hall Tickets (PDF) generated successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	/*
	try {
		con=ConnectDatabase.getConnection();

		pst=con.prepareStatement("insert into hall_ticket (exam_id, appn_no, mkr_id, mkr_dt) values (?,?,?,now())");
		for(int i=0; i<alMain.size(); i++) {
			ArrayList alSub=(ArrayList)alMain.get(i);

			pst.setString(1,exam_id);
			pst.setString(2,alSub.get(0).toString());
			pst.setString(3,submitted_by);
			pst.addBatch();
		}
		pst.executeBatch();
		con.commit();
		mesg="Hall Ticket Templates Generated Successfully";

	} catch(Exception e1) {
		e1.printStackTrace();
		con.rollback();
	}
	finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
	}
	*/
}
catch(Exception e1){
	mesg="Error while Generating Hall Tickets "+e1.toString();
	//e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= mesg %>
