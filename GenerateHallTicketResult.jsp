	<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String submitted_by=(String)session.getAttribute("login_id");
String arrTxt[]= {"CANDIDATE_NAME","PARENT_NAME","HT_NO","LOGIN_ID","F_APPN_NO","MOBILE_NO", "EXAM_VENUE"};
ArrayList alMain=new ArrayList();
ArrayList alAppNo=new ArrayList();
String str=null;
StringBuffer buf=new StringBuffer();
String exam_id=request.getParameter("exam_id");
String course=request.getParameter("exam_name");
String weekdays[]={ "MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY" };

String mesg="";
String exam_name="";
String exam_date="";
String exam_day="";
String exam_time="";
String exam_venue="";
String exam_duration="";
String exam_course="";
try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	
	pst=con.prepareStatement("select appn_no from application where appn_status='A' AND course=? AND ht_no IS NULL");
	pst.setString(1,course);
	System.out.println("pst status update--> "+pst);
	rs=pst.executeQuery();

	while(rs.next()) 
		alAppNo.add(rs.getString(1));

	pst=con.prepareStatement("select max(ht_no) from application");
	rs=pst.executeQuery();
	int ht_no=19000;
	if(rs.next()) {
		if( rs.getString(1) != null) {
			ht_no=rs.getInt(1);
		}
	}
System.out.println("ht_no="+ht_no);
	pst=con.prepareStatement("update application set ht_no=? where appn_no=?");
	for(int i=0; i<alAppNo.size(); i++) {
		pst.setString(1, (++ht_no)+"");
		pst.setString(2, alAppNo.get(i).toString());
		pst.addBatch();
	}
	pst.executeBatch();
	con.commit();

	//pst=con.prepareStatement("select ht_no, appn_no,first_name, last_name, parent_name, address, city, state, pin_code,mkr_id from application where appn_status='A' and exam_id=?");
	pst=con.prepareStatement("SELECT ht_no, appn_no, first_name, last_name, parent_name, a.mkr_id, f_appn_no, mobile_no, city_centre FROM application a,exam_master e WHERE a.appn_status='A' AND a.course=e.course and e.exam_id=?");
	pst.setString(1,exam_id);
	rs=pst.executeQuery();
	System.out.println(pst);
	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString("appn_no"));
		alSub.add(rs.getString("first_name"));
		alSub.add(rs.getString("parent_name"));
		alSub.add(rs.getString("ht_no"));
		alSub.add(rs.getString("mkr_id"));
		alSub.add(rs.getString("f_appn_no"));
		alSub.add(rs.getString("mobile_no"));
		alSub.add(rs.getString("city_centre"));
		alMain.add(alSub);
	}
//	System.out.println("AL MAIN="+alMain);

	pst=con.prepareStatement("select exam_title, exam_date, course, exam_time, exam_duration, weekday(exam_date) from exam_master where exam_id=?");
	pst.setString(1,exam_id);
	rs=pst.executeQuery();
	if(rs.next()) {
		exam_name=rs.getString("exam_title");
		exam_date=(String)rs.getString("exam_date");
		exam_time=rs.getString("exam_time");
		exam_duration=rs.getString("exam_duration");
		exam_course=rs.getString("course");
		exam_day=weekdays[rs.getInt(6)];
	}

	}
	catch(Exception e1){
		mesg="Error while Generating Hall Tickets "+e1.toString();
		e1.printStackTrace();
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
			System.out.println("ALSUB -> " +alSub);
			String appn_no=(String)alSub.get(0);
			int loc=0;
			for(int j=0; j<alSub.size()-1; j++) 
			{	
				loc=strBuf.toString().indexOf("$$"+arrTxt[j]);
		System.out.println("Size "+loc+", "+(String)alSub.get(j+1));
				
				strBuf=strBuf.replace(loc, loc+ (arrTxt[j].length()+2), (String)alSub.get(j+1));
			}
			loc=strBuf.toString().indexOf("$$EXAM_NAME");
			strBuf.replace(loc, loc+ "$$EXAM_NAME".length(), exam_name);

			loc=strBuf.toString().indexOf("$$EXAM_DATE");
			strBuf.replace(loc, loc+ "$$EXAM_DATE".length(), exam_date);

			loc=strBuf.toString().indexOf("$$EXAM_TIME");
			strBuf.replace(loc, loc+ "$$EXAM_TIME".length(), exam_time);

			loc=strBuf.toString().indexOf("$$EXAM_DAY");
			strBuf.replace(loc, loc+ "$$EXAM_DAY".length(), exam_day);

			loc=strBuf.toString().indexOf("$$COURSE");
			strBuf.replace(loc, loc+ "$$COURSE".length(), exam_course);

			
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
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= mesg %>
