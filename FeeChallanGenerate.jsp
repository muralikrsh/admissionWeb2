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
	String strAllotmentNo=request.getParameter("AllotNo");
	
			Connection con=null;
        	PreparedStatement pst=null;
        	ResultSet rs=null;
        	Paragraph paragraph=null;
        	
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
        	pst=con.prepareStatement("SELECT stu_name, par_name, course, branch, tuition_fee, mobile, email, pay_type_1, cash_ref_no_1, dd_no_1, amount_1 FROM student_admission where full_adm_no=?");
        	pst.setString(1,strAllotmentNo);
        	rs=pst.executeQuery();        	
        	
        	Document docPDF = new Document(PageSize.A4);
			response.setHeader("Content-Disposition", "attachment; filename=\"" + strAllotmentNo+".pdf" + "\"");
			PdfWriter.getInstance(docPDF,response.getOutputStream());
			
			docPDF.open();
            String strMainTitle="BHARATH INSTITUTE OF SCIENCE & TECHNOLOGY";
			String strMainAddress="Chennai - 600 073, Tamil Nadu, India";
            String strTitle="RECEIPT";
            
            FontSelector selector = new FontSelector();
            Font f1 = FontFactory.getFont(FontFactory.TIMES_ROMAN, 10);
            Font f2 = FontFactory.getFont("MSung-Light", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
            selector.addFont(f1);
            selector.addFont(f2);
            
            Image image = Image.getInstance("C:\\tools\\itext\\Bharath_Logo_32.png");
            image.scaleAbsolute(450f, 100f);
			image.setAlignment(Element.ALIGN_CENTER);
            docPDF.add(image);
            
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

            if(data)
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
            }
			System.out.println("1");
            PdfPTable table = new PdfPTable(2);
           
            table.getDefaultCell().setBorder(Rectangle.BOX);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
           
            table.addCell("Counselling Allotment Order ");
            table.addCell(strAllotmentNo);
            docPDF.add(table);
                        System.out.println("2");
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
            

            table = new PdfPTable(2);
            
            table.getDefaultCell().setBorder(Rectangle.BOX);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
           
            table.addCell("Candidate Name:");
            table.addCell(ph_name);
            table.addCell(new Phrase(new Chunk("Father Name")));
            table.addCell(ph_par_name);
            table.addCell(new Phrase(new Chunk("Course")));
            table.addCell(ph_course);
            table.addCell(new Phrase(new Chunk("Branch")));
            table.addCell(ph_branch);
            table.addCell(new Phrase(new Chunk("Tuition Fees")));
            table.addCell(ph_tution_fee);
            table.addCell(new Phrase(new Chunk("Amount Paid")));
            table.addCell(ph_amount_paid);
            table.addCell(new Phrase(new Chunk("Paid By")));
            table.addCell(ph_pay_type);
            table.addCell(new Phrase(new Chunk("DD No / Cash Receipt No")));
            table.addCell(ph_dd_cash_no);
            table.addCell(new Phrase(new Chunk("Mobile")));
            table.addCell(ph_mobile);
            table.addCell(new Phrase(new Chunk("E-mail")));
            table.addCell(ph_email);

            docPDF.add(table);
 
            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);

            table = new PdfPTable(1);
            table.setWidthPercentage(80);
            table.getDefaultCell().setBorder(Rectangle.UNDEFINED);
            table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
            table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
            
            table.addCell("DOCUMENTS");
            table.addCell(" ");
            table.addCell("1. Bharath University Allocation Letter, if not Identity Proof of the Student.");
            table.addCell("2. Class X Board Certificate as a proof of Date of Birth.");
            table.addCell("3. XII Exam Hall Ticket (Copy).");
            table.addCell("4. Qualifying Examination Marks Statements of all attempts.");
            table.addCell("5. Transfer Certificate / School Leaving Certificate [If Passed Out].");
            table.addCell("6. Community Certificate (for SC / ST only) as specified in the information brochure.");
            table.addCell("7. Tuition Fees remaining balance to be paid by June 25th.");
            table.addCell("8. Recent Passport size color photos - 4 No's.");
            docPDF.add(table);
            
            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);

            paragraph = new Paragraph(" ");
            docPDF.add(paragraph);
			
			paragraph = new Paragraph(" ");
            docPDF.add(paragraph);

            paragraph = new Paragraph("DEAN - ADMISSIONS   ");
            paragraph.setAlignment(Element.ALIGN_RIGHT);
            docPDF.add(paragraph);

            paragraph = new Paragraph("BHARATH UNIVERSITY");
            paragraph.setAlignment(Element.ALIGN_RIGHT);
            docPDF.add(paragraph);
	
            
			System.out.println("1");
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