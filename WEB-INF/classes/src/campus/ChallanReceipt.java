package campus;

import java.io.File;
import java.util.HashMap;

import javax.print.attribute.PrintRequestAttributeSet;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

public class ChallanReceipt
{
String check="";
PrintRequestAttributeSet printRequestAttributeSet;
JasperPrint print;
net.sf.jasperreports.engine.export.JRPrintServiceExporter exporter;
NumberToWord numToWord = new NumberToWord();

HashMap<String, Object> paramMap = new HashMap<String, Object>();

public String genReceiptWithCertFee(String strReceiptNo, String strStudentName, String strAdmissionNum, String strAmount, String strPaymentDate,String strCertificationFee, String strCourse)
{
	try {
		System.out.println("ReceiptNo :: "+strReceiptNo);
        
        File file = new File("C:/admission/receipts/"+strReceiptNo+".pdf");    	
		boolean status=file.delete();
        if(status){
			System.out.println(file.getName() + " is deleted!");
		}else{
			System.out.println("Delete operation is failed.");
		}
        double feePaid=Double.parseDouble(strAmount);
        double certFeePaid=Double.parseDouble(strCertificationFee);
        double totalPaid=Double.parseDouble(strAmount)+Double.parseDouble(strCertificationFee);
        String strWordAmount=numToWord.convert(totalPaid);
        System.out.println("feePaid="+feePaid+", certFeePaid="+certFeePaid+", totalPaid="+totalPaid+", strWordAmount="+strWordAmount);
        paramMap.put("Receipt_No", strReceiptNo);
        paramMap.put("Student_Name", strStudentName);
        paramMap.put("Admission_Num", strAdmissionNum);
        paramMap.put("Amount", feePaid);
        paramMap.put("Word_Amount", strWordAmount);
        paramMap.put("Payment_Date", strPaymentDate);
        paramMap.put("Cert_Fee", certFeePaid);
        paramMap.put("Total_Paid", totalPaid);
        paramMap.put("Course", strCourse);
        
        paramMap.put("IS_IGNORE_PAGINATION", true);
    	print = JasperFillManager.fillReport("C:/tools/Reports/ChallanReceiptWithCertFee.jasper", paramMap, new JREmptyDataSource());
   
        JasperExportManager.exportReportToPdfFile(print, "C:/admission/receipts/"+strReceiptNo+".pdf");

    } catch (JRException ex) {
        ex.printStackTrace();
    } catch (Exception e) {
		e.printStackTrace();
	}
finally
{
try{
    exporter = null;
    print =null;
    printRequestAttributeSet = null;
}
catch(Exception ex){}
}
	return check;
}

public String genReceipt(String strReceiptNo, String strStudentName, String strAdmissionNum, String strAmount, String strPaymentDate, String strCourse)
{
	try {
		System.out.println("ReceiptNo :: "+strReceiptNo);
        
        File file = new File("C:/admission/receipts/"+strReceiptNo+".pdf");    	
		boolean status=file.delete();
        if(status){
			System.out.println(file.getName() + " is deleted!");
		}else{
			System.out.println("Delete operation is failed.");
		}
        double feePaid=Double.parseDouble(strAmount);
        String strWordAmount=numToWord.convert(feePaid);
		
        paramMap.put("Receipt_No", strReceiptNo);
        paramMap.put("Student_Name", strStudentName);
        paramMap.put("Admission_Num", strAdmissionNum);
        paramMap.put("Amount", feePaid);
        paramMap.put("Word_Amount", strWordAmount);
        paramMap.put("Payment_Date", strPaymentDate);
        paramMap.put("Course", strCourse);

        paramMap.put("IS_IGNORE_PAGINATION", true);
    	print = JasperFillManager.fillReport("C:/tools/Reports/ChallanReceipt.jasper", paramMap, new JREmptyDataSource());
   
        JasperExportManager.exportReportToPdfFile(print, "C:/admission/receipts/"+strReceiptNo+".pdf");

    } catch (JRException ex) {
        ex.printStackTrace();
    } catch (Exception e) {
		e.printStackTrace();
	}
finally
{
try{
    exporter = null;
    print =null;
    printRequestAttributeSet = null;
}
catch(Exception ex){}
}
	return check;
}

}