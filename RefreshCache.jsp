<%@page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%
ArrayList alMain=new ArrayList();
Connection con=null;
PreparedStatement pst=null;
ResultSet rs=null;
String user_role="";
String login_id="";
String type=request.getParameter("type");
String head="";
String path="";
String htcount="0";
String clcount="0";
String ilcount="0";
String appcount="0";
ArrayList alEventName=new ArrayList();
ArrayList alEventDate=new ArrayList();

if(session.getAttribute("role")==null)
		session.setAttribute("role",request.getParameter("role"));
String mesg="";
try {
			con=ConnectDatabase.getConnection();
			con.setAutoCommit(false);
			user_role=(String)session.getAttribute("role");
			login_id=(String)session.getAttribute("login_id");

			pst=con.prepareStatement("SELECT lang_code, lang_name from language");
			rs=pst.executeQuery();

			ArrayList alLangCode= new ArrayList();
			ArrayList alLangName= new ArrayList();	
			while(rs.next()) {
				alLangCode.add(rs.getString(1));
				alLangName.add(rs.getString(2));
			}


			pst=con.prepareStatement("SELECT course_group, course_id, course_name from course where course_flag='A' ");
			rs=pst.executeQuery();
			ArrayList alCourses=new ArrayList();

			while(rs.next()) {
				alCourses.add( rs.getString(1)+"#"+rs.getString(2)+"#"+rs.getString(3));
			}
			
			System.out.println(alCourses);

			pst=con.prepareStatement("SELECT distinct course_group from course");
			rs=pst.executeQuery();
			ArrayList alCourseGroup=new ArrayList();

			while(rs.next()) {
				alCourseGroup.add( rs.getString(1));
			}
			System.out.println(alCourseGroup);

			synchronized(application) {
				application.setAttribute("LANG_CODE",alLangCode);
				application.setAttribute("LANG_NAME",alLangName);
				application.setAttribute("COURSES",alCourses);
				application.setAttribute("COURSE_GROUP",alCourseGroup);
			}
			mesg="Success";


}
catch(Exception e1){
	mesg="Failure";
	e1.printStackTrace();
}
finally {
		if(con!=null)
			con.close();
		con=null; pst=null;
}
%>
<!DOCTYPE html>
<html>
<title>eUniv - Refresh Cache</title>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="Scripts/hoverIntent.js" type="text/javascript"></script>
    <script src="Scripts/superfish.js" type="text/javascript"></script>
    <script src="Scripts/CustomScript.js" type="text/javascript"></script>

	<link href="Styles/superfish-native.css" rel="stylesheet" type="text/css"  />
	<link href="Styles/Style.css" rel="stylesheet" type="text/css" />
    <link href="Styles/jquery-ui.css" rel="stylesheet" type="text/css" />
	<link href="css/button-style.css" rel="stylesheet" type="text/css" />

</head>
	<body>
	<%@include file="CCMenu.jsp" %>
	<div class="content_container">
	<table class=" valign_top textbox_medium tbl_p5 textarea_normal">
            <tr>
                <td width=20%>
					<table>
					<tr><td align='middle'><img src="images/BIST.jpg" vspace="10" hspace="10" align="left" style="padding: 0px 12x;"></td></tr>
					</table>
				</td>
				<td width=70% valign="middle">
					<table align=center  valign="middle">
					<tr>
						<td colspan=2 class="button navy gradient"  valign="middle">Cache Refresh - <%= mesg %></td>
					</tr>
				</table>

                </td>
				<td width=10%>&nbsp;</td>
            </tr>
        </table>
</div>
</section>
<%@include file="Footer.jsp" %>
</div>
</body>
</html>