<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, java.text.SimpleDateFormat"%>
<%
System.out.println("123");
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String submitted_by=(String)session.getAttribute("login_id");
String arrTxt[]= {"HT_NO", "CANDIDATE_NAME", "RANK", "COUNSELLING_DATE", "COUNSELLING_TIME", "MOBILE" };
ArrayList alMain=new ArrayList();
String str=null;
StringBuffer buf=new StringBuffer();
String exam_id=request.getParameter("exam_id");
String weekdays[]={ "MONDAY","TUESDAY","WEDNESDAY","THURSDAY","FRIDAY","SATURDAY","SUNDAY" };

String mesg="";
try {
	con=ConnectDatabase.getConnection();
	con.setAutoCommit(false);

	pst=con.prepareStatement("select ht_no, stu_name, rank, counsel_date, counsel_time, mobile_no_2, ans_no from rank_list");
	rs=pst.executeQuery();
		
	while(rs.next()) 
	{
		ArrayList alSub=new ArrayList();
		alSub.add(rs.getString("ht_no"));
		alSub.add(rs.getString("stu_name"));
		alSub.add(rs.getString("rank"));
		alSub.add(rs.getString("counsel_date"));
		alSub.add(rs.getString("counsel_time"));
		alSub.add(rs.getString("mobile_no_2"));
		alSub.add(rs.getString("ans_no"));
		alMain.add(alSub);
	}
	}
	catch(Exception e1){
		mesg="Error while Generating Counselling Letters "+e1.toString();
		e1.printStackTrace();
	}
	finally {
			if(con!=null)
				con.close();
			con=null; pst=null;
	}
	try {
		String TEMPLATE_PATH=(String)application.getAttribute("TEMPLATE_PATH");
		BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(TEMPLATE_PATH+"counseling.html")));
		while((str=br.readLine())!=null) {
			buf.append(str);
		}

		String COUNSELINGLETTER_PATH=(String)application.getAttribute("COUNSELINGLETTER_PATH");
		String CL_BATCH=(String)application.getAttribute("CL_BATCH");

		for(int i=0; i<alMain.size(); i++) {

			StringBuffer strBuf=new StringBuffer(buf);
			ArrayList alSub=(ArrayList)alMain.get(i);
			String strAnsNo=(String)alSub.get(6);
			int loc=0;
			//"HT_NO", "CANDIDATE_NAME", "RANK", "COUNSELLING_DATE", "COUNSELLING_TIME", "MOBILE"
			for(int j=0; j<alSub.size()-1; j++) {
				loc=strBuf.toString().indexOf("$$"+arrTxt[j]);
				System.out.println("Size "+loc+", "+arrTxt[j]+", "+(arrTxt[j].length()+2)+", "+(String)alSub.get(j));
				strBuf=strBuf.replace(loc, loc+ (arrTxt[j].length()+2), (String)alSub.get(j));
			}
			
			loc=strBuf.toString().indexOf("$$EXAM_ID");
			strBuf.replace(loc, loc+ "$$EXAM_ID".length(), exam_id);

			System.out.println(COUNSELINGLETTER_PATH+strAnsNo+".html");
			BufferedWriter bw=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(COUNSELINGLETTER_PATH+strAnsNo+".html")));
			bw.write(strBuf.toString());
			bw.flush();
			bw.close();
		}
	
	mesg="Counselling Letters (HTML) Generated Successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	out.println(mesg);
	out.flush();
	
	Runtime.getRuntime().exec(COUNSELINGLETTER_PATH+CL_BATCH);
	mesg="Counselling Letters (PDF) generated successfully&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'><br>";
	out.println(mesg);
	out.flush();
	
	/*try {
		con=ConnectDatabase.getConnection();

		pst=con.prepareStatement("update application set clgen_flag='Y' where exam_id=?");
		pst.setString(1,exam_id);
		pst.executeUpdate();
		con.commit();
		mesg="Counsel Letters ready for download&nbsp;<img src='images/tick.gif' width='15' height='15' border='0'>";

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
	mesg="Error while Generating Counselling Letter "+e1.toString();
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<%= mesg %>
