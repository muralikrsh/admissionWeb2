package campus;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrintReceipt extends HttpServlet
{
	private static final long serialVersionUID = -6884380753797365866L;
	String strFileName = "";
  
  public void init(ServletConfig paramServletConfig)
    throws ServletException
  {
    super.init(paramServletConfig);
  }
  
  public void doGet(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
    doPost(paramHttpServletRequest, paramHttpServletResponse);
  }
  
  public void doPost(HttpServletRequest paramHttpServletRequest, HttpServletResponse paramHttpServletResponse)
    throws ServletException, IOException
  {
	  //System.out.println("1");
    ServletOutputStream localServletOutputStream = paramHttpServletResponse.getOutputStream();
    this.strFileName = (paramHttpServletRequest.getParameter("ReceiptNo") + ".pdf");
    //System.out.println("Filename:" + this.strFileName);
    String str1 = "C:/admission/receipts";
    File localFile = new File(str1, this.strFileName);
    String str2 = this.strFileName.substring(this.strFileName.indexOf(".") + 1, this.strFileName.length());
    //System.out.println("Filetype:" + str2 + ";" + localFile.length());
    
    paramHttpServletResponse.setContentType("application/pdf");
    paramHttpServletResponse.setContentLength((int)localFile.length());
    
    paramHttpServletResponse.setHeader("Cache-Control", "no-cache");
    byte[] arrayOfByte = new byte[8192];
    FileInputStream localFileInputStream = new FileInputStream(localFile);
    int i = 0;
    while ((i = localFileInputStream.read(arrayOfByte, 0, arrayOfByte.length)) > 0)
    {
      //System.out.println("size:" + i);
      localServletOutputStream.write(arrayOfByte, 0, i);
    }
    localFileInputStream.close();
    localServletOutputStream.close();
  }
  
  public String getServletInfo()
  {
    return "DownloadFile Information";
  }
}