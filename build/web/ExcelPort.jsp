
<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*, com.lowagie.text.*,java.awt.Color.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>





<script language="JavaScript" type ="text/javascript">


		function Validate()
		{
                   
			//alert(opener.document.getElementById("CVOpen").value+"dd");
			opener.document.getElementById("CVOpen").value="Y";


			var aa=document.frm.file.value;
			var filename=aa.substring(aa.lastIndexOf("\\"));
			var filename1=filename.substring( filename.indexOf("."));
			var filename2=filename1.substring(1);
			var file1=filename2;
			//alert(file1+"asas"+filename1);
			//var filename2=filename1.toUpperCase();
			if(file1=='xls' )//|| file1=='docx' || file1=='pdf' )
			{
					return true;
			}
			else
			{
				alert("Please Select correct CV File Name like xyz.xls" );
				//alert(document.frm1.file.value);
				document.frm.file.value="";
							return false;
			}



		}
	</script>
    </head>
    <body aLink=#ff00ff bgcolor=#fce9c5 leftmargin=0 topmargin=0  >

<br>
<br>
<h2>File Upload </h2>

<Br>
Select a file to upload : <br />
<form action="ExcelPortXLS.jsp" method="post" name="frm" enctype="multipart/form-data">
<input type="file" name="file" size="40" />
<br><br>
<input type="submit" value="Upload File" onClick="return Validate();"/>
<br>
<br> <font face=verdana size=2 color=red><b>The size of your CV should be less then 2MB </b></font>

</form>
</body>
</html>
</html>
