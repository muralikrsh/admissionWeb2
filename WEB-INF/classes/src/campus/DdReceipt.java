package campus;

import java.io.File;
import java.util.HashMap;

import javax.print.attribute.PrintRequestAttributeSet;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;

public class DdReceipt
{
String check="";
PrintRequestAttributeSet printRequestAttributeSet;
JasperPrint print;
NumberToWord numToWord = new NumberToWord();
net.sf.jasperreports.engine.export.JRPrintServiceExporter exporter;

HashMap<String, Object> paramMap = new HashMap<String, Object>();

public String genReceiptWithCertFee(String strReceiptNo,String strStudent,String strAdmissionNum,String strAmount,String strDdNo,String strDraweeBank,String strDdDrawnDate,String strDdSubmitDate,String strFixedTuitionFee,Double totalPaid,String strConcessionAmount,String strCertificationFee,String strCourse)
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
        double certFeePaid=Double.parseDouble(strCertificationFee);
        double tuitionFeePaid=Double.parseDouble(strAmount);
        double paidAmount=Double.parseDouble(strAmount)+certFeePaid;
        String strWordAmount=numToWord.convert(paidAmount);
        double fixedTuitionFee=Double.parseDouble(strFixedTuitionFee);
        double scholarshipAmount=Double.parseDouble(strConcessionAmount);
        double dueAmount=Double.parseDouble(strFixedTuitionFee)-totalPaid-scholarshipAmount;        

        paramMap.put("receipt_no", strReceiptNo);
        paramMap.put("student", strStudent);
        paramMap.put("admission_Num", strAdmissionNum);
        paramMap.put("dd_no", strDdNo);
        paramMap.put("drawee_bank", strDraweeBank);
        paramMap.put("paid_amount", paidAmount);
        paramMap.put("dd_drawn_date", strDdDrawnDate);
        paramMap.put("dd_submit_date", strDdSubmitDate);
        paramMap.put("word_amount", strWordAmount);
        paramMap.put("total_fee", fixedTuitionFee);
        paramMap.put("total_paid", totalPaid);
        paramMap.put("due_amount", dueAmount);
        paramMap.put("scholarship", scholarshipAmount);
        paramMap.put("cert_fee", certFeePaid);
        paramMap.put("tuition_fee", tuitionFeePaid);
        paramMap.put("course", strCourse);

        paramMap.put("IS_IGNORE_PAGINATION", true);
    	print = JasperFillManager.fillReport("C:/tools/Reports/DdReceiptWithCertFee.jasper", paramMap, new JREmptyDataSource());
   
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


public String genReceipt(String strReceiptNo,String strStudent,String strAdmissionNum,String strAmount,String strDdNo,String strDraweeBank,String strDdDrawnDate,String strDdSubmitDate,String strFixedTuitionFee,Double totalPaid,String strConcessionAmount,String strCourse)
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
        String strWordAmount=numToWord.convert(Double.parseDouble(strAmount));
        double paidAmount=Double.parseDouble(strAmount);
        double fixedTuitionFee=Double.parseDouble(strFixedTuitionFee);
        double scholarshipAmount=Double.parseDouble(strConcessionAmount);
        double dueAmount=Double.parseDouble(strFixedTuitionFee)-totalPaid-scholarshipAmount;

        paramMap.put("receipt_no", strReceiptNo);
        paramMap.put("student", strStudent);
        paramMap.put("admission_Num", strAdmissionNum);
        paramMap.put("dd_no", strDdNo);
        paramMap.put("drawee_bank", strDraweeBank);
        paramMap.put("paid_amount", paidAmount);
        paramMap.put("dd_drawn_date", strDdDrawnDate);
        paramMap.put("dd_submit_date", strDdSubmitDate);
        paramMap.put("word_amount", strWordAmount);
        paramMap.put("total_fee", fixedTuitionFee);
        paramMap.put("total_paid", totalPaid);
        paramMap.put("due_amount", dueAmount);
        paramMap.put("scholarship", scholarshipAmount);
        paramMap.put("course", strCourse);

        paramMap.put("IS_IGNORE_PAGINATION", true);
    	print = JasperFillManager.fillReport("C:/tools/Reports/DdReceipt.jasper", paramMap, new JREmptyDataSource());
   
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