<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, java.text.SimpleDateFormat"%>
<%
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String submitted_by=(String)session.getAttribute("login_id");
String arrTxt[]= {"APPN_NO", "CANDIDATE_NAME","ADDRESS","CITY","STATE","PINCODE","REGN_NO", "COURSE","BRANCH","SECTION","HOSTEL_ROOM","BOARDING_POINT"  };
ArrayList alMain=new ArrayList();
ArrayList alHTNo=new ArrayList();
String str=null;
StringBuffer buf=new StringBuffer();
String exam_id=request.getParameter("exam_id");
String weekdays[]={ "MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY" };

String mesg="";

try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);
	String query="select a.appn_no,first_name, last_name, address, city, state, pin_code, regn_no, adm_course, adm_branch, section, hostel_room, IFNULL(trn_board_point,'Not Requested') as board_point from application a, admission b where a.exam_id=? and a.adm_status='A' and a.appn_no=b.appn_no";
	System.out.println(query);
	pst=con.prepareStatement(query);
	pst.setString(1,exam_id);
	rs=pst.executeQuery();

	while(rs.next()) {
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString("appn_no"));
		alSub.add(rs.getString("first_name")+" "+rs.getString("last_name"));
		alSub.add(rs.getString("address"));
		alSub.add(rs.getString("city"));
		alSub.add(rs.getString("state"));
		alSub.add(rs.getString("pin_code"));
		alSub.add(rs.getString("regn_no"));
		alSub.add(rs.getString("adm_course"));
		alSub.add(rs.getString("adm_branch"));
		alSub.add(rs.getString("section"));
		alSub.add(rs.getString("hostel_room"));
		alSub.add(rs.getString("board_point"));
		alMain.add(alSub);
	}


	}
	catch(Exception e1){
		mesg="Error while Generating Intimation Letters "+e1.toString();
		e1.printStackTrace();
	}
	finally {
			if(con!=null)
				con.close();
			con=null; pst=null;
	}
	try {
		String TEMPLATE_PATH=(String)application.getAttribute("TEMPLATE_PATH");
		BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(TEMPLATE_PATH+"intimation.html")));
		while((str=br.readLine())!=null) {
			buf.append(str);
		}

		Calendar currentDate = Calendar.getInstance(); 
		SimpleDateFormat formatter=  new SimpleDateFormat("dd-MMM-yyyy");
		String dateNow = formatter.format(currentDate.getTime());
		String INTIMATIONLETTER_PATH=(String)application.getAttribute("INTIMATIONLETTER_PATH");
		String IL_BATCH=(String)application.getAttribute("IL_BATCH");

		for(int i=0; i<alMain.size(); i++) {

			StringBuffer strBuf=new StringBuffer(buf);
			ArrayList alSub=(ArrayList)alMain.get(i);
			String appn_no=(String)alSub.get(0);
			int loc=0;
			for(int j=0; j<alSub.size(); j++) {
				loc=strBuf.toString().indexOf("$$"+arrTxt[j]);
				System.out.println(loc+"<>"+arrTxt[j]+"<>"+((String)alSub.get(j)));
				System.out.println(loc);
				strBuf=strBuf.replace(loc, loc+ (arrTxt[j].length()+2), (String)alSub.get(j));
			}
			
			System.out.println(INTIMATIONLETTER_PATH+appn_no+".html");
			BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(INTIMATIONLETTER_PATH+appn_no+".html")));
			bw.write(strBuf.toString());
			bw.flush();
			bw.close();
		}
	
	mesg="Intimation Letters (HTML) Generated Successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	out.println(mesg);
	out.flush();
	
	Runtime.getRuntime().exec(INTIMATIONLETTER_PATH+IL_BATCH);
	mesg="Intimation Letters (PDF) generated successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	out.println(mesg);
	out.flush();
	
	try {
		con=ConnectDatabase.getConnection();

		pst=con.prepareStatement("update application set ilgen_flag='Y' where exam_id=?");
		pst.setString(1,exam_id);
		pst.executeUpdate();
		con.commit();
		mesg="Intimation Letters ready for download&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'>";

	} catch(Exception e1) {
		e1.printStackTrace();
		con.rollback();
	}
	finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
	}
	
	
}
catch(Exception e1){
	mesg="Error while Generating Intimation Letters "+e1.toString();
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= mesg %>
