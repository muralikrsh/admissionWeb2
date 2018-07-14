<%@page import="campus.*"%>
<% 
new SessionHandler().logout(request);
%>
<script>
location.href='Login.jsp';
</script>