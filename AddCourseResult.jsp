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
String course_id="";
String course_name="";
String course_desc="";
String course_type="";
String course_syllabus="";
String course_duration="";
String course_fees="";
String course_flag="";
String flag="";
String course_group="";

String submitted_by=(String)session.getAttribute("login_name");



	boolean isMultipart = ServletFileUpload.isMultipartContent(request);
	if (!isMultipart) {

	} else {
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		List items = null;
		try {
			items = upload.parseRequest(request);
		} catch (FileUploadException e) {
			e.printStackTrace();
		}
		Iterator itr = items.iterator();
		while (itr.hasNext()) 
		{
			FileItem item = (FileItem) itr.next();
			if (item.isFormField())
			{
			String name = item.getFieldName();
			String value = item.getString();
			System.out.println("Field "+name+ "<>"+value);
			if(name.equals("flag")) {
				flag=value;
			}
			if(name.equals("course_id")) {
				course_id=value;
			}
			if(name.equals("course_name")) {
				course_name=value;
			}
			if(name.equals("course_desc")) {
				course_desc=value;
			}
			if(name.equals("course_type")) {
				course_type=value;
			}
			if(name.equals("course_syllabus")) {
				course_syllabus=value;
			}
			if(name.equals("course_fees")) {
				course_fees=value;
			}
			if(name.equals("course_duration")) {
				course_duration=value;
			}
			if(name.equals("course_flag")) {
				course_flag=value;
			}
			if(name.equals("course_group")) {
				course_group=value;
			}
			} 
			else	
			{
				System.out.println("File Recd" +course_id);
				try {

					if(flag.intern()=="I".intern()) {
						try {
							con=ConnectDatabase.getConnection();
							con.setAutoCommit(false);
							pst=con.prepareStatement("select concat('CC', lpad(max(substring(course_id,3))+1,4,'0')) from course");
							ResultSet rs=pst.executeQuery();
							if(rs.next())
								course_id=rs.getString(1);
							if(course_id==null)
								course_id="CC00001";
							rs=null;
						}
						catch(Exception e1){
							e1.printStackTrace();
							message="Error while generating Course Id";
						}
						finally {
							if(con!=null)
								con.close();
							con=null; pst=null;
						}
					}
					course_syllabus = item.getName();
					System.out.println(">>>"+course_syllabus+"<<<");
					if(course_syllabus!=null) {
						if(course_syllabus.trim().length()>0) {
						String COURSE_SYLLABUS_PATH=(String)application.getAttribute("COURSE_SYLLABUS_PATH");
						System.out.println("Path : "+COURSE_SYLLABUS_PATH+course_id+".pdf");
						File savedFile = new File(COURSE_SYLLABUS_PATH+course_id+".pdf");
						item.write(savedFile);
						//boolean rflag=savedFile.renameTo(new File(COURSE_SYLLABUS_PATH+course_id+".pdf"));
						//System.out.println("Rename Flag ->"+rflag);
					}
				}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
	try {
		con=ConnectDatabase.getConnection();

		//pst=con.prepareStatement("delete from course where course_id=?");
		//pst.setString(1,course_id);
		//pst.executeUpdate();

		if(flag.intern()=="I".intern()) {
			pst=con.prepareStatement("insert into course (course_group, course_type, course_name,course_desc,course_syllabus,course_duration,course_fees,course_flag,mkr_id,mkr_date,auth_id,auth_date,course_id) values (?,?,?,?,?,?,?,?,?,now(),?,now(),?)");
		} else {
			pst=con.prepareStatement("update course set course_group=?, course_type=?, course_name=?, course_desc=?, course_syllabus=?, course_duration=?, course_fees=?, course_flag=?, mkr_id=?, mkr_date=now(), auth_id=?, auth_date=now() where course_id=?");
		}
		
		pst.setString(1,course_group);
		pst.setString(2,course_type);
		pst.setString(3,course_name);
		pst.setString(4,course_desc);
		pst.setString(5,course_id);
		pst.setString(6,course_duration);
		pst.setString(7,course_fees);
		pst.setString(8,course_flag);
		pst.setString(9,submitted_by);
		pst.setString(10,submitted_by);
		pst.setString(11,course_id);
		
		pst.executeUpdate();
		con.commit();
		message= (flag.intern()=="I".intern())?"Course Added Successfully":"Course Modified Successfully";
	}
	catch(Exception e1){
		e1.printStackTrace();
		message="Error while Creating Data";
	}
	finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
	}
	%>
<!DOCTYPE html>
<html>
<title>Add Course Result</title>
	<head>
	<meta charset="utf-8">

	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
	<link href="Styles/superfish-native.css"rel="stylesheet" type="text/css"  />
    <link href="css/jquery.ui.core.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.button.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.dialog.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.ui.theme.css" rel="stylesheet" type="text/css" />

	<script src="ui/minified/jquery-1.7.2.min.js"></script>
	<script src="ui/minified/jquery.ui.core.min.js"></script>
	<script src="ui/minified/jquery.ui.widget.min.js"></script>
	<script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>
	<script src="ui/jquery.effects.core.js"></script>
	<script src="ui/jquery.bgiframe-2.1.2.js"></script>


	<script type="text/javascript" charset="utf-8">
	function getCourseList() {
		location.href='CourseList.jsp';
	}

	$(document).ready(function(){
	displayAlert('<%= message%>', getCourseList);
	});
		
	</script>
<%@include file="MBHandler.jsp" %>
	</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	   <div id="dialog-message" style="display:none;" title="Add Course"><p id="diaMsg" style="width:auto;"></p></div>
	</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>