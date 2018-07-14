<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
Connection con = null;
PreparedStatement pst = null;
String message="";
String exam_id="";
String itemName =""; 
String submitted_by=(String)session.getAttribute("login_id");
String EE_PATH=(String)application.getAttribute("EE_PATH"); /*  c:\\ranklist\\  */

	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {

	} else {
		System.out.println("EE 1");
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		System.out.println("EE 2");
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		System.out.println("EE 3");
		Iterator itr = items.iterator();
		while (itr.hasNext()) 
		{
			System.out.println("EE 4");
			FileItem item = (FileItem) itr.next();
			if (item.isFormField())
			{
						System.out.println("EE 5");
				String name = item.getFieldName();
				System.out.println("field name "+name);

				String value = item.getString();
				System.out.println("field value "+value);
				if(name.equals("exam_id")) {
					exam_id=value;
				}
				System.out.println("EE 6");
			} 
			else	
			{
				
				try {
					itemName = item.getName();
					
					File savedFile = new File(EE_PATH+submitted_by+".csv");
					System.out.println("Path : "+EE_PATH+submitted_by+".csv");
					item.write(savedFile);
					message="File uploaded Successfully";
				} catch (Exception e) {
					e.printStackTrace();
					message="<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;Excel upload failed "+e.toString();
				}
			}
		}

		if(message.indexOf("Successfully")!=-1) {
			
			try {
				String str=null;
				ArrayList alMarks=new ArrayList();
				ArrayList alRank=new ArrayList();
				ArrayList alAnsNo=new ArrayList();
				ArrayList alName=new ArrayList();
				ArrayList alHTNo=new ArrayList();
				ArrayList alPincode=new ArrayList();				
				ArrayList alSubject=new ArrayList();
				ArrayList alMobileNoOne=new ArrayList();
				ArrayList alMobileNoTwo=new ArrayList();
				ArrayList alCounsellingDate=new ArrayList();
				ArrayList alCounsellingTime=new ArrayList();
				
				BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(EE_PATH+submitted_by+".csv")));
				while((str=br.readLine())!=null) {
					StringTokenizer st=new StringTokenizer(str,",");
					while(st.hasMoreTokens()){
					alMarks.add(st.nextToken());
					alRank.add(st.nextToken());
					alAnsNo.add(st.nextToken());
					alName.add(st.nextToken());
					alHTNo.add(st.nextToken());
					alSubject.add(st.nextToken());
					alPincode.add(st.nextToken());
					alMobileNoOne.add(st.nextToken());
					alMobileNoTwo.add(st.nextToken());
					alCounsellingDate.add(st.nextToken());
					alCounsellingTime.add(st.nextToken());
				}}

				System.out.println("Inside");
				con=ConnectDatabase.getConnection();
				con.setAutoCommit(false);

				pst=con.prepareStatement("insert into rank_list (exam_id, marks, rank, ans_no, stu_name, ht_no, subject_name, pincode, mobile_no_1, mobile_no_2, counsel_date, counsel_time, mkr_id, mkr_dt) values (?,?,?,?,?,?,?,?,?,?,?,?,?,now())");
				for(int i=0; i<alHTNo.size(); i++) {
					pst.setString(1,exam_id);
					pst.setString(2,alMarks.get(i).toString());
					pst.setString(3,alRank.get(i).toString());
					pst.setString(4,alAnsNo.get(i).toString());
					pst.setString(5,alName.get(i).toString());
					pst.setString(6,alHTNo.get(i).toString());
					pst.setString(7,alSubject.get(i).toString());
					pst.setString(8,alPincode.get(i).toString());
					pst.setString(9,alMobileNoOne.get(i).toString());
					pst.setString(10,alMobileNoTwo.get(i).toString());
					pst.setString(11,alCounsellingDate.get(i).toString());
					pst.setString(12,alCounsellingTime.get(i).toString());
					pst.setString(13,submitted_by);
					pst.addBatch();
				}
				pst.executeBatch();
				System.out.println(pst);
				con.commit();
				message="<img src='images/tick.gif' width='15' height='15' border='0'>&nbsp;Exam Results uploaded Successfully";
			} catch(Exception e1) {
				message="<img src='images/error.gif' width='15' height='15' border='0'>&nbsp;Please verify file format before upload";
				e1.printStackTrace();
				if(con!=null)
					con.rollback();
			}
			finally {
				if(con!=null)
					con.close();
				con=null; pst=null;
			}
		}
	}

	%>
<!DOCTYPE html>
<html>
<title>Upload Entrance Exam Results</title>
	<head>
	<meta charset="utf-8">

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="Styles/superfish-native.css" />
	<link rel="stylesheet" href="css/jquery.ui.all.css">
	<link rel="stylesheet" href="css/demodialog.css">

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>


	<!--
	<link rel="stylesheet" type="text/css" href="css/button-style.css" /> -->

	<script type="text/javascript" charset="utf-8">
	$(function() {
		// $( "#dialog:ui-dialog" ).dialog( "destroy" );
		document.getElementById("dialog-confirm1").innerHTML="<%= message%>";
		$( "#dialog-confirm1" ).dialog({
			resizable: false,
			height:140,
			modal: true,
			buttons: {
				"OK": function() {
					$( this ).dialog( "close" );
					location.href='UploadEERanks.jsp?exam_id=<%=exam_id%>';
				}
			}
		});;
		

	});

	</script>
	<%@include file="MBHandler.jsp" %>
	</head>
	<body  id="dt_example">
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<div id="dialog-confirm1" title="Entrance Exam Ranks Upload Result"></div>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>