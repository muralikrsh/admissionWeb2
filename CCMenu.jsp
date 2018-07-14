<%
String role=null;
String dept_id=null;
String loginName="";
try {
	role=(String)session.getAttribute("role");
	dept_id=(String)session.getAttribute("dept_id");
	loginName=(String)session.getAttribute("login_name");
} catch(Exception e) {
}
if(role==null) {
%>
<script>
	location.href='Login.jsp';
</script>
<%
}
%>
<div class="container">
<header>
<div>
<div>
<div>
<div class="fleft"><img height="110" width="100%" src="images/logo_new.png" alt="Bharath University" title="Bharath University" /></div>
<div class="fright"><img height="110" width="110" src="images/bu_excellence_logo.jpg" alt="33 Years" title="" /></div>
</div>
</div>
</header>
<section>

<!-- <header>
<div class="header_holder">
<div class="header_content">
<div class="fleft"><img src="images/euniv-bist.png" alt="Bharath University" title="Bharath University" /></div>
<div><img width="110" src="images/bharath29.jpg" alt="29 Years" title="" /></div>
</div>
</div>
</header>
 -->
 
 <section>
<div class="navigation_menu">
<% if (role!=null) { %>
<% if (role.intern()=="STUDENT".intern()) { %>
<ul class="nav sf-menu"  style="position: relative;z-index:10000;">
	<li><a href="Home.jsp" class="top_link"><span>Home</span></a></li>
	
	<!--<li><a href="#nogo2" id="products" class="top_link"><span class="down">Application&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
		<ul class="sub">
			<li><a href="SearchApplications.jsp">Check Application Status</a></li>
			<li><a href="SubmitApplication2.jsp?category=UG">Online Appn Form - UG</a></li>
			<li><a href="SubmitApplication2.jsp?category=PG">Online Appn Form - PG</a></li>
			<li><a href="ListFiles.jsp?type=HT">Hall Ticket</a></li>
			<li><a href="ListFiles.jsp?type=CL">Download Counseling Letter</a></li>
			<li><a href="ListFiles.jsp?type=IL">Download Intimation Letter</a></li>
			<!--<li><a href="UploadPhoto.jsp">Upload Photo</a></li>-->
		</ul>
	</li>
	<!--<li><a href="#nogo2" id="products" class="top_link"><span class="down">Events&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
		<ul>
			<li><a href="EventList.jsp">List Events</a></li>
		</ul>
	</li>-->

</ul>
<% } else if (role.intern()=="ADMIN".intern()) { %>
<ul class="nav sf-menu"  style="position: relative;z-index:10000;">
	<li><a href="Home.jsp" class="top_link"><span>Home</span></a></li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Application</span></a>
		<ul>
			<li><a href="SearchApplications.jsp">Review & Approve</a></li>
			<li><a href="SearchApplications2.jsp">Applications - Report</a></li>
			<li><a href="RegistrationReport.jsp">Registration - Report</a></li>
			<li><a href="ManualApplicationList.jsp">Manual Application - List</a></li>
			<!--<li><a href="ApplicationReport.jsp">Applications - Report (G)</a></li>
			<li><a href="SubmitApplication2.jsp?category=UG">Manual Application - UG</a></li>
			<li><a href="SubmitApplication2.jsp?category=PG">Manual Application - PG</a></li>
			<li><a href="UploadApplications.jsp">Bulk upload-Application</a></li>-->
			
		</ul>
	</li>
	<!--<li><a href="#nogo2" id="products" class="top_link"><span class="down">Exam</span></a>
		<ul>
			<li><a href="ExamList.jsp">Exam List</a></li>
			<li><a href="UploadSyllabus.jsp">Upload Syllabus</a></li>
		</ul>
	</li>
	<li>
	<a href="#nogo2" id="products" class="top_link"><span class="down">Entrance Results</span></a>
		<ul>
			<li><a href="UploadEERanks.jsp"> Upload Results</a></li>
			<li><a href="EntranceExamResults.jsp">View Results</a></li>
		</ul>
	</li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Student Communication</span></a>
		<ul>
			<li><a href="GenerateHallTicket.jsp">Generate HallTickets</a></li>
			<li><a href="GenerateCounselLetter.jsp">Generate Counselling Letters</a></li>
			<li><a href="GenerateIntimationLetter.jsp">Generate Intimation Letters</a></li>
		</ul>
	</li>-->
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Admissions</span></a>
		<ul>
			<li><a href="AllotmentForm.jsp">Allotment Form</a></li>
			<li><a href="StudentAllotmentList.jsp">Allotment List</a></li>
			<!--<li><a href="AdmissionForm.jsp">Admission Form</a></li>
			<li><a href="CounselingList.jsp">Admit Student</a></li>-->
		</ul>
	</li>
		<li><a href="#nogo2" id="vacancy" class="top_link"><span class="down">Vacancy</span></a>
		<ul>
			<li><a href="VacancyList.jsp">Vacancy Set up </a></li>
			<li><a href="VacancyReport.jsp">Vacancy Report</a></li>
		</ul>
	</li>
	<!--<li><a href="#nogo2" id="products" class="top_link"><span class="down">Events&nbsp;&nbsp;&nbsp;&nbsp;</span></a>
		<ul>
			<li><a href="AddEvent.jsp">Add Event</a></li>
			<li><a href="EventList.jsp">List Events</a></li>
		</ul>
	</li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Admin Options</span></a>
		<ul>
			<li><a href="ChangePassword.jsp">Change Password</a></li>
			<li><a href="AddUser.jsp">Setup new User</a></li>
			<li><a href="RefreshCache.jsp">Refresh Cache</a></li>
		</ul>
	</li>-->

</ul>
<% } else if (role.intern()=="VC".intern()) { %>
<ul class="nav sf-menu">
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Courses & Exams</span></a>
		<ul>
			<li><a href="AddCourse.jsp">Create Course</a></li>
			<li><a href="CourseList.jsp">Course List</a></li>
			<li><a href="AddExam.jsp">Create Exam</a></li>
			<li><a href="ExamList.jsp">Exam List</a></li>
		</ul>
	</li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Entrance Results</span></a>
		<ul>
			<li><a href="EntranceExamResults.jsp">View Results</a></li>
		</ul>
	</li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Admin Options</span></a>
		<ul>
			<li><a href="ChangePassword.jsp">Change Password</a></li>
		</ul>
	</li>
</ul>
<% } else if (role.intern()=="ACCOUNT".intern()) { %>
<ul class="nav sf-menu">
	<li><a href="AdmissionForm.jsp">Admission Form</a></li>
	<li><a href="AdmissionReport.jsp">Admission - Report</a></li>
	<li><a href="AdmissionDeptList.jsp">Admission Department - List</a></li>
</ul>
<% } else if (role.intern()=="FINANCE".intern()) { %>
<ul class="nav sf-menu">
	<li><a href="AdmissionForm.jsp">Admission Form</a></li>
	<li><a href="AdmissionReport.jsp">Admission - Report</a></li>
</ul>
<% } else if (role.intern()=="OFFLINE".intern()) { %>
<ul class="nav sf-menu"  style="position: relative;z-index:10000;">
	<li><a href="Home.jsp" class="top_link"><span>Home</span></a></li>
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">Application</span></a>
		<ul>
			<li><a href="ManualApplicationList.jsp">Manual Application - List</a></li>
		</ul>
	</li>
	</ul>
<% } else if (role.intern()=="EXAM".intern()) { %>
<ul class="nav sf-menu">
	<li><a href="#nogo2" id="products" class="top_link"><span class="down">STUDENT DETAILS</span></a>
		<ul>
			<li><a href="StudentRankList.jsp">Student Rank List</a></li>
		</ul>
	</li>

</ul>
<%
	}
}
%>
<div class="fright" style="font-size:15pt;"><strong><%=loginName%>.!</strong>&nbsp;&nbsp;<a class="logout_link" href="Logout.jsp">Logout</a></div>
</div>
<% System.out.println("CCMENU END"); %>