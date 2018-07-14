<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="java.sql.*, java.io.*, campus.*, java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String message="";
String strStudentAdmNo="";
String submitted_by=(String)session.getAttribute("login_name");
String imgLink="";

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
				System.out.println("field name "+name);

				String value = item.getString();
				System.out.println("field value "+value);
				if(name.equals("student_adm_no")) {
					strStudentAdmNo=value;
				}
			} 
			else	
			{				
				try {
					String itemName = item.getName();
					String PHOTO_PATH=(String)application.getAttribute("PHOTO_PATH");
					System.out.println("Path : "+PHOTO_PATH+strStudentAdmNo+".jpg");
					
					File savedFile = new File(PHOTO_PATH+strStudentAdmNo+".jpg");
					item.write(savedFile);
					message="Photo uploaded Successfully";
					imgLink="<img width='100' height='100' src='/photos/"+strStudentAdmNo+".jpg"+"'>";
				} catch (Exception e) {
					e.printStackTrace();
					message="Photo upload failed";
				}
			}
		}
	}

	%>
<%
if(message.intern()=="Photo uploaded Successfully".intern()) {
%>
<%= imgLink %>
<%} else { %>
<%= message %>
<% } %>