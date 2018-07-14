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
String APP_PATH="c://APP_PATH/";

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
					System.out.println("Path : "+APP_PATH+submitted_by+".csv");
					File savedFile = new File(APP_PATH+submitted_by+".csv");
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
				ArrayList alFAPPLNO=new ArrayList();
				ArrayList alAPPLNO=new ArrayList();
				ArrayList alNAME=new ArrayList();
				ArrayList alGENDER=new ArrayList();
				ArrayList alRELIGION=new ArrayList();
				ArrayList alNATION=new ArrayList();
				ArrayList alDOB=new ArrayList();
				ArrayList alCOMMUNITY=new ArrayList();
				ArrayList alBLOODGROUP=new ArrayList();
				ArrayList alMOTHERT=new ArrayList();
				ArrayList alCOURSE=new ArrayList();
				ArrayList alCHOICE1=new ArrayList();
				ArrayList alCHOICE2=new ArrayList();
				ArrayList alCHOICE3=new ArrayList();
				ArrayList alSPORT1=new ArrayList();
				ArrayList alATGATE=new ArrayList();
				ArrayList alATTANCET=new ArrayList();
				ArrayList alATCAT=new ArrayList();
				ArrayList alATMAT=new ArrayList();
				ArrayList alXAT=new ArrayList();
				ArrayList alGMAT=new ArrayList();
				ArrayList alPATH1=new ArrayList();
				ArrayList alPTNAME=new ArrayList();
				ArrayList alRELATIONSHIP=new ArrayList();
				ArrayList alPTOCC=new ArrayList();
				ArrayList alMEDIUM=new ArrayList();
				ArrayList alOPSUB=new ArrayList();
				ArrayList alHOSTEL=new ArrayList();
				ArrayList alTRANSPORT=new ArrayList();
				ArrayList alONEXAM=new ArrayList();
				ArrayList alCITYONLINE=new ArrayList();
				ArrayList alTESTCTYPAPER=new ArrayList();
				ArrayList alSTCODE=new ArrayList();
				ArrayList alPINCODE=new ArrayList();
				ArrayList alMOBNO=new ArrayList();
				ArrayList alPATH2=new ArrayList();
				ArrayList alFOLDER=new ArrayList();
				ArrayList alVERIFIED=new ArrayList();
				ArrayList alDATAUPLOAD=new ArrayList();
				ArrayList alEMAILID=new ArrayList();
				ArrayList alADDRESS=new ArrayList();
				ArrayList alHSCSCHOOL=new ArrayList();
				
				
				BufferedReader br=new BufferedReader(new InputStreamReader(new FileInputStream(APP_PATH+submitted_by+".csv")));
				while((str=br.readLine())!=null) {
					StringTokenizer st=new StringTokenizer(str,",");
					while(st.hasMoreTokens()){
					alFAPPLNO.add(st.nextToken());
					alAPPLNO.add(st.nextToken());
					alNAME.add(st.nextToken());
					alGENDER.add(st.nextToken());
					alRELIGION.add(st.nextToken());
					alNATION.add(st.nextToken());
					alDOB.add(st.nextToken());
					alPATH1.add(st.nextToken());
					alPTNAME.add(st.nextToken());
					alPINCODE.add(st.nextToken());
					alMOBNO.add(st.nextToken());
					alFOLDER.add(st.nextToken());
					alVERIFIED.add(st.nextToken());
					alDATAUPLOAD.add(st.nextToken());
					alEMAILID.add(st.nextToken());
					alCITYONLINE.add(st.nextToken());
					alSTCODE.add(st.nextToken());
					alHSCSCHOOL.add(st.nextToken());
					alADDRESS.add(st.nextToken());
					
					
				}}

				con=ConnectDatabase.getConnection();
				con.setAutoCommit(false);
				pst=con.prepareStatement("insert into application (exam_id, f_appn_no, appn_no, first_name, gender, religion, nationality, dob, path1, parent_name, pin_code, mobile_no, folder, verified, data_upload, city_centre, hsc_school, address) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				for(int i=0; i<alAPPLNO.size(); i++) {
					pst.setString(1,exam_id);
					pst.setString(2,(String)alFAPPLNO.get(i));
					pst.setString(3,(String)alAPPLNO.get(i).toString());
					pst.setString(4,(String)alNAME.get(i));
					pst.setString(5,(String)alGENDER.get(i));
					pst.setString(6,(String)alRELIGION.get(i));
					pst.setString(7,(String)alNATION.get(i));
					pst.setString(8,(String)alDOB.get(i));
					pst.setString(9,(String)alPATH1.get(i));
					pst.setString(10,(String)alPTNAME.get(i));
					pst.setString(11,(String)alPINCODE.get(i));
					pst.setString(12,(String)alMOBNO.get(i));
					pst.setString(13,(String)alFOLDER.get(i));
					pst.setString(14,(String)alVERIFIED.get(i));
					pst.setString(15,(String)alDATAUPLOAD.get(i));
					pst.setString(16,(String)alCITYONLINE.get(i));
					pst.setString(17,(String)alHSCSCHOOL.get(i));
					pst.setString(18,(String)alADDRESS.get(i));
					
					
					
					pst.addBatch();
				}
				pst.executeBatch();
				con.commit();
				message="<img src='images/tick.gif' width='15' height='15' border='0'>&nbsp;Application Results uploaded Successfully";
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