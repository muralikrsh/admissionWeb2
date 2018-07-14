<%@page import="java.sql.*, campus.* ,java.util.* , javax.mail.* , javax.mail.internet.*,javax.activation.*"%>
<%

String msg="";
ArrayList start=new ArrayList();//pcode
ArrayList end=new ArrayList();//pname

ResultSms sms= new ResultSms();

start.add("200050");

end.add("205300");

for(int i=0;i<start.size();i++)
{
	msg=sms.sendSMS((String)start.get(i),(String)end.get(i));
	System.out.println("count="+i+" - "+msg);
}

%>
<%= msg %>