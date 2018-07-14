<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, java.text.SimpleDateFormat"%>
<%@page language="java" trimDirectiveWhitespaces="true"%>

<%@page import="com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.Element"%>
<%@page import="com.itextpdf.text.Font"%>
<%@page import="com.itextpdf.text.FontFactory"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.itextpdf.text.PageSize"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="com.itextpdf.text.Phrase"%>
<%@page import="com.itextpdf.text.Rectangle"%>
<%@page import="com.itextpdf.text.pdf.BaseFont"%>
<%@page import="com.itextpdf.text.pdf.FontSelector"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Allotment Letter</title>
    </head>
    <body>
<%

try
{
			Connection con=null;
        	PreparedStatement pst=null;
        	ResultSet rs=null;
        	Paragraph paragraph=null;
        	
			String strAllotmentNo="";
        	String strStudentName="";
        	String strParentName="";
        	String strCourse="";
        	String strBranch="";
        	String strDDNumber="";
			String strCashRefNo="";
        	String strAmount="";
        	String strTuitionFee="";
        	String strMobile="";
        	String strEmail="";
			String strPaymentType="";
        
        	con = ConnectDatabase.getConnection();
        	pst=con.prepareStatement("SELECT stu_name, par_name, course, branch, tution_fee, mobile, email, pay_type_1, cash_ref_no_1, dd_no_1, amount_1, full_adm_no FROM student_admission");
        	rs=pst.executeQuery();        	
        	
        	Document docPDF = new Document(PageSize.A4);
			//PdfWriter pdf = PdfWriter.getInstance(docPDF, new FileOutputStream("C:\\Allotment_Letter\\AllotmentList.pdf"));
			response.setHeader("Content-Disposition", "attachment; filename=\"AllotmentList.pdf" + "\"");
			PdfWriter.getInstance(docPDF,response.getOutputStream());
			
			docPDF.open();
            String strMainTitle="BHARATH INSTITUTE OF SCIENCE & TECHNOLOGY";
			String strMainAddress="Chennai - 600 073, Tamil Nadu, India";
            String strTitle="ALLOTMENT LIST";
            
            FontSelector selector = new FontSelector();
            Font f1 = FontFactory.getFont(FontFactory.TIMES_ROMAN, 10);
            Font f2 = FontFactory.getFont("MSung-Light", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
            selector.addFont(f1);
            selector.addFont(f2);
            
            paragraph = new Paragraph(strMainTitle);
            paragraph.setAlignment(Element.ALIGN_CENTER);
            docPDF.add(paragraph);
			
			paragraph = new Paragraph(strMainAddress);
            paragraph.setAlignment(Element.ALIGN_CENTER);
            docPDF.add(paragraph);
            
			paragraph = new Paragraph(" ");
            docPDF.add(paragraph);
			
            paragraph = new Paragraph(strTitle);
            paragraph.setAlignment(Element.ALIGN_CENTER);
            docPDF.add(paragraph);

            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);
			
			boolean data = rs.next();

            while(data)
            {
				strStudentName = rs.getString("stu_name");
                strParentName = rs.getString("par_name");
                strCourse = rs.getString("course");
                strBranch = rs.getString("branch");
                strPaymentType = rs.getString("pay_type_1");
				strDDNumber = rs.getString("dd_no_1");
				strCashRefNo = rs.getString("cash_ref_no_1");
                strAmount = rs.getString("amount_1");
                strTuitionFee = rs.getString("tution_fee");
                strMobile = rs.getString("mobile");
                strEmail = rs.getString("email");
				strAllotmentNo= rs.getString("full_adm_no");
            }
            PdfPTable table = new PdfPTable(2);
           
            table.getDefaultCell().setBorder(Rectangle.BOX);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
           
            docPDF.add(table);
            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);
            
            Phrase ph_name = selector.process(strStudentName);
            Phrase ph_par_name = selector.process(strParentName);
            Phrase ph_course = selector.process(strCourse);
            Phrase ph_mobile = selector.process(strMobile);
            Phrase ph_email = selector.process(strEmail);
            Phrase ph_branch = selector.process(strBranch);
            
            Phrase ph_tution_fee = selector.process(strTuitionFee+"/- per year");
            Phrase ph_pay_type = selector.process(strPaymentType);
			Phrase ph_amount_paid = selector.process(strAmount);
            Phrase ph_dd_cash_no = selector.process(strDDNumber+" / "+strCashRefNo);
            

            table = new PdfPTable(11);
            
            table.getDefaultCell().setBorder(Rectangle.BOX);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);

			table.addCell("Counselling Allotment Order ");
            table.addCell("Candidate Name:");
            table.addCell(new Phrase(new Chunk("Father Name")));
            table.addCell(new Phrase(new Chunk("Course")));
            table.addCell(new Phrase(new Chunk("Branch")));
            table.addCell(new Phrase(new Chunk("Tuition Fees")));
            table.addCell(new Phrase(new Chunk("Amount Paid")));
            table.addCell(new Phrase(new Chunk("Paid By")));
            table.addCell(new Phrase(new Chunk("DD No / Cash Receipt No")));
            table.addCell(new Phrase(new Chunk("Mobile")));
            table.addCell(new Phrase(new Chunk("E-mail")));


            docPDF.add(table);
 
            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);

            table = new PdfPTable(11);
            table.setWidthPercentage(80);
            table.getDefaultCell().setBorder(Rectangle.UNDEFINED);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
            
            table.addCell(strAllotmentNo);           
            table.addCell(ph_name);
            table.addCell(ph_par_name);
            table.addCell(ph_course);
            table.addCell(ph_branch);
            table.addCell(ph_tution_fee);
            table.addCell(ph_amount_paid);
            table.addCell(ph_pay_type);
            table.addCell(ph_dd_cash_no);
            table.addCell(ph_mobile);
            table.addCell(ph_email);

            rs.close();
            pst.close(); 
            con.close();               
            docPDF.close();   
        
       }
       catch(Exception e)
       {
			out.clear(); // where out is a JspWriter 
			out = pageContext.pushBody(); 
			out.println(e);
       }
    %>

    </body>
    <script>

     </script>
</html>