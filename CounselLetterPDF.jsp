<%@page import="java.sql.*, java.io.*, campus.*, java.util.*, java.text.SimpleDateFormat"%>

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
        <title>JSP Page</title>
    </head>
    <body>
<%

try
{
	String strAnsNo=request.getParameter("AnswerNo");
	
	Connection con=null;
	PreparedStatement pst=null;
	ResultSet rs=null;
	//String strAnsNo="200886";
	Paragraph paragraph=null;
	String stu_name="";
	String ht_no="";
	String rank="";
	String mobile_no_2="";
	String strCounselDate="";
	String strCounselTime="";
	
	con = ConnectDatabase.getConnection();
	pst=con.prepareStatement("SELECT stu_name, ht_no, rank, mobile_no_2, counsel_date, counsel_time FROM rank_list where ans_no=?");
	pst.setString(1,strAnsNo);
	rs=pst.executeQuery();
	System.out.println(pst);
	
	Document docPDF = new Document(PageSize.A4);
    response.setHeader("Content-Disposition", "attachment; filename=\"" + strAnsNo+".pdf" + "\"");
    PdfWriter.getInstance(docPDF,response.getOutputStream());
    docPDF.open();
        
    String strTitle="COUNSELLING LETTER";
    
    FontSelector selector = new FontSelector();
    Font f1 = FontFactory.getFont(FontFactory.TIMES_ROMAN, 10);
    Font f2 = FontFactory.getFont("MSung-Light", "UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
    selector.addFont(f1);
    selector.addFont(f2);
    
    Image image = Image.getInstance("C:\\tools\\itext\\Bharath_Logo_32.png");
    image.scaleAbsolute(500f, 150f);
    docPDF.add(image);
	
    paragraph = new Paragraph(strTitle);
    paragraph.setAlignment(Element.ALIGN_CENTER);
    docPDF.add(paragraph);

    paragraph = new Paragraph("Ref : BU/BEEE/2015/B.TECH");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);

    boolean data=rs.next();
    if (data) 
    {
        stu_name = rs.getString("stu_name");
        ht_no=rs.getString("ht_no");
        rank=rs.getString("rank");
        mobile_no_2=rs.getString("mobile_no_2");
        strCounselDate=rs.getString("counsel_date");
        strCounselTime=rs.getString("counsel_time");
    }
System.out.println("after "+pst);
    Phrase ph_name = selector.process(stu_name);
    Phrase ph_ht_no = selector.process(ht_no);
    Phrase ph_rank = selector.process(rank);
    Phrase ph_mobile = selector.process(mobile_no_2);
    Phrase ph_date = selector.process(strCounselDate);
    Phrase ph_time = selector.process(strCounselTime);
    
    PdfPTable table = new PdfPTable(2);
   
    table.getDefaultCell().setBorder(Rectangle.BOX);
    table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_LEFT);
    table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
   
    table.addCell("Candidate Name:");
    table.addCell(ph_name);
    table.addCell(new Phrase(new Chunk("Hall Ticket No")));
    table.addCell(ph_ht_no);
    table.addCell(new Phrase(new Chunk("Rank")));
    table.addCell(ph_rank);
    table.addCell(new Phrase(new Chunk("Mobile No")));
    table.addCell(ph_mobile);
    table.addCell(new Phrase(new Chunk("Counselling Date")));
    table.addCell(ph_date);
    table.addCell(new Phrase(new Chunk("Counselling Time")));
    table.addCell(ph_time);
    docPDF.add(table);

    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);

    paragraph = new Paragraph("Sub : Rank in the Common Entrance Test conducted on April / May 2015 and counselling schedule intimation.");
	paragraph.setAlignment(Element.ALIGN_LEFT);
	docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);

    paragraph = new Paragraph("Dear Student,");
	paragraph.setAlignment(Element.ALIGN_LEFT);
	docPDF.add(paragraph);

    paragraph = new Paragraph("We are glad to inform you that your rank, date and time of counselling as detailed above. The counselling will be held at Bharath University, Chennai.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);
            
    paragraph = new Paragraph("1. You are advised to report to Bharath University only on the allotted date and time.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);

    paragraph = new Paragraph("2. You are advised to attend counselling with one set of copies of certificates along with original certificates of date of birth, qualification, community certificate for verification and demand draft for Rs. 10,000/- drawn in favour of Bharath University, Chennai (Name and HallTicket Number of the candidate to be written on the back of the demand draft), Your admission will be subject to due verification of your Certificates.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    Chunk underline = new Chunk("3. The mere attending for counselling does not entitle any seat automatically, depending on availability of seats and based on ranking, allotment will be done.");
    underline.setUnderline(0.1f, -2f); //0.1 thick, -2 y-location
    docPDF.add(underline);
    
    paragraph = new Paragraph("4. No request for change of date and time of counselling will be entertained.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph("5. Absenting in the counselling will automatically forfeit your chance.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);

    paragraph = new Paragraph("6. You are advised to go through the Bharath University Website for all details.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);

    paragraph = new Paragraph("Yours Faithfully, ");
    paragraph.setAlignment(Element.ALIGN_RIGHT);
    docPDF.add(paragraph);
    
    Image deanImage = Image.getInstance("C:\\tools\\itext\\cheif.gif");
    deanImage.scaleAbsolute(100f, 20f);
    deanImage.setAlignment(Element.ALIGN_RIGHT);
    docPDF.add(deanImage);
    
    paragraph = new Paragraph("DEAN (Admissions)");
    paragraph.setAlignment(Element.ALIGN_RIGHT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);

    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);    

    paragraph = new Paragraph("REACH US:");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);
    
    paragraph = new Paragraph("From Chennai Central To Park Station - From Park Station board a MRTS Train to Tambaram - From Tambaram Bharath University is Located at 3.8 KMS viaTambaram - Velachery Main Road - Take a right turn at Camp Road Junction travel 1.2 Kms to reach Bharath University.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    paragraph = new Paragraph(" ");
    docPDF.add(paragraph);
    
    paragraph = new Paragraph("Helpline Numbers: 09025167092 / 09884499302 / 1800-419-1441.");
    paragraph.setAlignment(Element.ALIGN_LEFT);
    docPDF.add(paragraph);
    
    docPDF.close();
    rs.close();
    pst.close(); 
    con.close();               
        
       }
       catch(Exception e)
       {
           out.println(e);
       }
    %>

    </body>
    <script>

     </script>
</html>