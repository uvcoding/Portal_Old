<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %>
<!-- Date 19.01.2018-->
<%

String qrybankdetails="",FreezeStatus=" ";
ResultSet Bnkdtl;
OLTEncryption enc=new OLTEncryption();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";


%>
<HTML>

<head>

<TITLE>#### <%=mHead%> [ Change Password ] </TITLE>


<script language="JavaScript" type ="text/javascript" src="js/jquery.min.js"></script>


<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
<!--
  if(window.history.forward(1) != null)
  window.history.forward(1);
-->

</script>
<script>
function submitForm(id)
{

    var mholdername=document.frm.mholdername.value;
    var stdname=document.frm.Studentname.value;
    var holdername=document.frm.mholdername.value;
    var acnum=document.frm.mAcnumber.value;
    var bankname=document.frm.mbankName.value;
    var bnkaddrs=document.frm.mBAddress.value;
    var ifsc=document.frm.mifsccode.value;
        if((mholdername==null) ||(mholdername=="")||(mholdername==" ")){
            alert("Please Select mholdername!");
            document.getElementById("mholdername").focus();
            document.getElementById("mholdername").style.background  = "yellow";
            return false
        }
        if((stdname==null) ||(stdname=="")||(stdname==" ")){
            alert("Please Select Student name!");
            document.getElementById("Studentname").focus();
            document.getElementById("Studentname").style.background  = "yellow";
            return false
        }
        if((holdername==null) ||(holdername=="" )||(holdername==" ")){
            alert("Please Select Ac Holder name!");
            document.getElementById("mholdername").focus();
            document.getElementById("mholdername").style.background  = "yellow"
            return false
        }
        if((acnum==null) ||(acnum=="") ||(acnum==" ")){
            alert("Please Select  Account Number!");
            document.getElementById("mAcnumber").focus();
            document.getElementById("mAcnumber").style.background  = "yellow"
            return false
        }
        if((bankname==null) ||(bankname=="") ||(bankname==" ")){
            alert("Please Select  Bank Name!");
            document.getElementById("mbankName").focus();
            document.getElementById("mbankName").style.background  = "yellow"
            return false
        }
        if((bnkaddrs==null) ||(bnkaddrs=="") ||(bnkaddrs=="")){
            alert("Please Select Bank Address!");
            document.getElementById("mBAddress").focus();
            document.getElementById("mBAddress").style.background  = "yellow"
            bnkaddrs.focus();
            return false
        }
        if((ifsc==null) ||(ifsc=="") ||(ifsc==" ")){
            alert("Please Select IFSC code!");
            document.getElementById("mifsccode").focus();
            document.getElementById("mifsccode").style.background  = "yellow"
            return false
      }
   /*  if(id=="draftsave"){
                            document.frm.action="ActionPage.jsp";
                            document.frm.submit();
                        }
                          if(id=="Freeze")
                         {
                         document.frm.action="ActionPage.jsp";
                         document.frm.submit();
                         }
       } */
</script>
</HEAD>
<%
String qrytrgr="";
ResultSet rsTRG=null;

String tempPRSNT="N";
String TempIDSqry="";
ResultSet TempRS=null;
String qryTempID="",qryTempID1="";
String qryTempIDN="";
String UpdtqryTMP="";
ResultSet RsTempId=null;
ResultSet RsTempIdN=null,RsTempIdN1=null;
String TempID="";
String mholdername="",mAcnumber="",mbankName="",mBranch="",mBAddress="",mifsccode="";
String Bankdtlqry="";
ResultSet BnkRS=null;
String UNIQUEID="",InstituteCode="",StudentIDD="";
String  mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet accDetail;
String mWebEmail="Deepak.gupta@jiit.ac.in";
int mMaxPWD=20;
int mMinPWD=5;
String holdername="",bankname="",accNumber="",IfscCd="",BnkAddress="",BranchName="";
int i=0;
int j=0;
int k=0;
int t=0;
int x=0,y=0;
String RcrDPresnt="N",RcrDPresntTemp="N";

String InsertQRyTMP="";

String Updtqry="";

String InsertQRy="";

String AccQuery="";
String AcctNumber="",freezeAcctNumber="";


String ButtonValue="";



if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
//new added
if (session.getAttribute("UNIQUEID")==null)
{
	UNIQUEID="";
}
else
{
	UNIQUEID=session.getAttribute("UNIQUEID").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
	InstituteCode="";
}
else
{
	InstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("StudentIDD")==null)
{
	StudentIDD="";
}
else
{
	StudentIDD=session.getAttribute("StudentIDD").toString().trim();
}
//new added

%>
<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin =0 bottommargin=0 scroll=auto>
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
        qry="Select WEBKIOSK.ShowLink('414','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
%>
<form name="frm" method ="post" action="StudentBankDetail.jsp">
<input id="x" name="x" type=hidden>
<TABLE cellspacing=0  cellpadding=2 frame =box align="center" border=3 style="FONT-FAMILY: Arial;
	FONT-SIZE: x-small" borderColor=black borderColorDark=#00bfff width=40%>
    <% try{
     qryTempID="Select 'Y'  from  StudentPersonalBankDetail where Studentid='"+StudentIDD+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"'";
//System.out.println("1111--"+qryTempID);
     RsTempId=db.getRowset(qryTempID);
     if(RsTempId.next()){

        RcrDPresnt="Y";

     }
     }catch(Exception e){
     //out.print("Excption Temp"+e);
    }
    %>

    <%
  try{
     qryTempIDN="Select nvl(TEMP#STUDENTID,'')TEMP#STUDENTID from temp#Studentmaster where Studentid='"+StudentIDD+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"'";

     RsTempIdN=db.getRowset(qryTempIDN);
     //out.print(qryTempIDN);
     while(RsTempIdN.next()){
         // out.print("Inside Loop");
         TempID=RsTempIdN.getString("TEMP#STUDENTID").toString().trim();
         //out.print("Outer Loop"+TempID);

     }
     }catch(Exception e){
     out.print("Excption Temp"+e);
    }
     %>
      <%
      //code Added By Anoop
     try{
     qryTempID1="Select 'Y'  from  temp#StudentPersonalBankDetail where Temp#Studentid='"+TempID+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"'";
//System.out.println("22222--"+qryTempID1);
     RsTempIdN1=db.getRowset(qryTempID1);
     //out.print(qryTempIDN);
     while(RsTempIdN1.next()){
         // out.print("Inside Loop");
          RcrDPresntTemp="Y";
         //out.print("Outer Loop"+TempID);

     }
     }catch(Exception e){
     out.print("Excption in Temp"+e);
    }
    //code Added By Anoop
     %>

    <%
  try{
   Bankdtlqry="select nvl(InstituteCode,' ')InstituteCode,nvl(StudentId,' ')StudentId,nvl(uniqueID,' ')uniqueID,nvl(BankAccountNo,' ')BankAccountNo,nvl(NameOfBank,' ')NameOfBank,nvl(BranchName,' ')BranchName,nvl(NameOfACHolder,' ')NameOfACHolder,nvl(IFSCCode,' ')IFSCCode,nvl(BankAddress,' ')BankAddress ";
   Bankdtlqry=Bankdtlqry+"from StudentPersonalBankDetail where StudentId='"+StudentIDD+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"' ";

   BnkRS=db.getRowset(Bankdtlqry);

   while(BnkRS.next()){

       mholdername=BnkRS.getString("NameOfACHolder");
       mAcnumber=BnkRS.getString("BankAccountNo");
       mbankName=BnkRS.getString("NameOfBank");
       mBranch=BnkRS.getString("BranchName");
       mBAddress=BnkRS.getString("BankAddress");
       mifsccode=BnkRS.getString("IFSCCode");





   }

 }catch(Exception e){

  out.print("Select Error"+e);
  }
qrybankdetails="Select nvl(FREEZED,'N')FREEZED from studentpersonalbankdetail where  STUDENTID='"+StudentIDD+"' and INSTITUTECODE='"+InstituteCode+"'  and UNIQUEID='"+UNIQUEID+"'";
                                                Bnkdtl=db.getRowset(qrybankdetails);

                                                if(Bnkdtl.next()){
                                                     FreezeStatus=Bnkdtl.getString("FREEZED").toString();
                                                }else{
                                                FreezeStatus="N";
                                                }
%>

     <TR align="middle" bgcolor="#ff8c00">
         <TD  width="85%"colspan="2" align="center"><P align=center><FONT color=black face=Arial size=3><STRONG>&nbsp;Student Bank Detail Form</STRONG></FONT></P></TD>

	</TR>

	<TR bgcolor="#ff9900">

		<TD bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;Name Of Account Holder</b></FONT></TD>
                 <% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
		 <td><INPUT ID="mholdername" Name="mholdername" Type="text" value="<%=request.getParameter("mholdername").toString()%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
	         <%}else{%>
                <td><INPUT ID="mholdername" Name="mholdername" Type="text" value="<%=mholdername%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>

                <%}%>

        </TR>
        <TR bgcolor="#ff9900">

            <TD bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;Bank Account Number</b></FONT></TD>
            <% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
		<td><INPUT ID="mAcnumber" Name="mAcnumber" Type="text" value="<%=request.getParameter("mAcnumber").toString()%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
	      <%}else{%>
              <td><INPUT ID="mAcnumber" Name="mAcnumber" Type="text" value="<%=mAcnumber%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
              <%}%>

        </TR >
	<TR bgcolor="#ff9900">

            <TD bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;Name Of Bank</b></FONT></TD>
			<% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
		<td><INPUT ID="mbankName" Name="mbankName" Type="text" value="<%=request.getParameter("mbankName").toString()%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
		<%}else{%>
       <td><INPUT ID="mbankName" Name="mbankName" Type="text" value="<%=mbankName%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
		<%}%>
	</TR>
        <TR bgcolor="#ff9900">

		<TD  bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;Branch</b></FONT></TD>
                <% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
		<td><INPUT ID="mBranchName" Name="mBranchName" Type="text" value="<%=request.getParameter("mBranchName").toString()%>"  style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
                <%}else{%>
                <td><INPUT ID="mBranchName" Name="mBranchName" Type="text" value="<%=mBranch%>" style="WIDTH: 260px; HEIGHT: 22px" maxLength=30></td>
               <%}%>
	</TR>
        <TR bgcolor="#ff9900">

		<TD bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;Address Of Bank</b></FONT></TD>
                 <% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
		<td><INPUT ID="mBAddress" Name="mBAddress" Type="text" value="<%=request.getParameter("mBAddress").toString()%>"  style="WIDTH: 260px; HEIGHT: 22px "  maxLength=30></td>
	          <%}else{%>
                <td><INPUT ID="mBAddress" Name="mBAddress" Type="text" value="<%=mBAddress%>" style="WIDTH: 260px; HEIGHT: 22px "  maxLength=30></td>
                 <%}%>

        </TR>
        <TR bgcolor="#ff9900">

		<TD bgcolor="#f2f2f2"><FONT color=black face=Arial size=2><b>&nbsp;IFSC Code</b></FONT></TD>
                <% if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){ %>
                <td ><INPUT ID="mifsccode" Name="mifsccode" Type="text" value="<%=request.getParameter("mifsccode").toString()%>" style="WIDTH: 260px; HEIGHT: 22px " maxLength=30></td>
	        <%}else{%>
                <td ><INPUT ID="mifsccode" Name="mifsccode" Type="text" value="<%=mifsccode%>" style="WIDTH: 260px; HEIGHT: 22px " maxLength=30></td>
                <%}%>

        </TR>

        <TR bgcolor="#ff9900"><td colspan=4 align=center>
                <input type="hidden" name="InstituteCode" value="<%=InstituteCode%>" id="InstituteCode">
                 <input type="hidden" name="StudentIDD" value="<%=StudentIDD%>" id="StudentIDD">
                  <input type="hidden" name="UNIQUEID" value="<%=UNIQUEID%>" id="UNIQUEID">
                  <%
                  if(FreezeStatus.equalsIgnoreCase("Y")){

                  }else{
                  %>
                  <INPUT Type="submit" Value="DraftSave" id="save" name="save" >
                  <INPUT Type="submit" Value="Freeze" id="save" name ="save"></td></TR>
                 <%}%>
        <!--<td> <input type="file" name ="photo" value="photo"></td> -->


 </TABLE>
        <center><h6><font size="3" color="blue">Once You freeze the details form will disappear!</font></h6></center>
</form>
<%



if(request.getParameter("x")!=null && !request.getParameter("x").equals(" ")){
try{
if (request.getParameter("mholdername")==null)
{
	holdername="";
}
else
{
	holdername=request.getParameter("mholdername").toString().trim();
}
if (request.getParameter("mbankName")==null)
{
	bankname="";
}
else
{
	bankname=request.getParameter("mbankName").toString().trim();
}
if (request.getParameter("mAcnumber")==null)
{
	accNumber="";
}
else
{
	accNumber=request.getParameter("mAcnumber").toString().trim();
}
if (request.getParameter("mifsccode")==null)
{
	IfscCd="";
}
else
{
	IfscCd=request.getParameter("mifsccode").toString().trim();
}
if (request.getParameter("mBAddress")==null)
{
	BnkAddress="";
}
else
{
	BnkAddress=request.getParameter("mBAddress").toString().trim();
}
if (request.getParameter("mBranchName")==null)
{
	BranchName="";
}
else
{
	BranchName=request.getParameter("mBranchName").toString().trim();
}

if (request.getParameter("save")==null)
{
	ButtonValue="";
}
else
{
	ButtonValue=request.getParameter("save").toString().trim();
}
%>


<%
}catch(Exception e){
   out.print("Getting Parameter"+e);
   }





try{


//out.print(RcrDPresnt+""+ButtonValue);

//*******************************************************Triger Disable**********************************************************************//

//qrytrgr="Alter trigger  CAMPUS.TRGRESTRICTDML_TMPPBD DISABLE ";
//		rsTRG=db.getRowset(qrytrgr);

		qrytrgr="Alter trigger  CAMPUS.TRGRESTRICTDML_PBD DISABLE ";
		rsTRG=db.getRowset(qrytrgr);

//*******************************************************Triger Disable**********************************************************************//

if(RcrDPresnt.equals("N")&&RcrDPresntTemp.equals("N")){

AccQuery="SELECT * FROM StudentPersonalBankDetail WHERE  BANKACCOUNTNO='"+accNumber+"'";
accDetail=db.getRowset(AccQuery);

if(accDetail.next())
    {
AcctNumber=accDetail.getString("BANKACCOUNTNO").toString();
x++;
    }
if(ButtonValue.equals("DraftSave")&&AcctNumber.equals("")){
    InsertQRy="Insert into StudentPersonalBankDetail (INSTITUTECODE,STUDENTID,UNIQUEID,BANKACCOUNTNO,NAMEOFBANK,BRANCHNAME,NAMEOFACHOLDER,IFSCCODE,BANKADDRESS,FREEZED)" ;
    InsertQRy=InsertQRy+ " values('"+InstituteCode+"','"+StudentIDD+"','"+UNIQUEID+"','"+accNumber+"','"+bankname+"','"+BranchName+"','"+holdername+"','"+IfscCd+"','"+BnkAddress+"','N')";

    InsertQRyTMP="Insert into temp#StudentPersonalBankDetail (INSTITUTECODE,temp#StudentId,UNIQUEID,BANKACCOUNTNO,NAMEOFBANK,BRANCHNAME,NAMEOFACHOLDER,IFSCCODE,BANKADDRESS,FREEZED)" ;
    InsertQRyTMP=InsertQRyTMP+ " values('"+InstituteCode+"','"+TempID+"','"+UNIQUEID+"','"+accNumber+"','"+bankname+"','"+BranchName+"','"+holdername+"','"+IfscCd+"','"+BnkAddress+"','N')";


}
/*AccQuery="SELECT * FROM StudentPersonalBankDetail WHERE  BANKACCOUNTNO='"+accNumber+"' AND FREEZED='N'";
accDetail=db.getRowset(AccQuery);

if(accDetail.next())
    {
freezeAcctNumber=accDetail.getString("BANKACCOUNTNO").toString();
y++;
    }*/
if(ButtonValue.equals("Freeze")&&AcctNumber.equals("")){

    InsertQRy="Insert into StudentPersonalBankDetail (INSTITUTECODE,STUDENTID,UNIQUEID,BANKACCOUNTNO,NAMEOFBANK,BRANCHNAME,NAMEOFACHOLDER,IFSCCODE,BANKADDRESS,FREEZED)" ;
    InsertQRy=InsertQRy+ " values('"+InstituteCode+"','"+StudentIDD+"','"+UNIQUEID+"','"+accNumber+"','"+bankname+"','"+BranchName+"','"+holdername+"','"+IfscCd+"','"+BnkAddress+"','Y')";

    InsertQRyTMP="Insert into temp#StudentPersonalBankDetail (INSTITUTECODE,temp#STUDENTID,UNIQUEID,BANKACCOUNTNO,NAMEOFBANK,BRANCHNAME,NAMEOFACHOLDER,IFSCCODE,BANKADDRESS,FREEZED)" ;
    InsertQRyTMP=InsertQRyTMP+ " values('"+InstituteCode+"','"+TempID+"','"+UNIQUEID+"','"+accNumber+"','"+bankname+"','"+BranchName+"','"+holdername+"','"+IfscCd+"','"+BnkAddress+"','Y')";
}

  i=db.update(InsertQRy);
  t=db.update(InsertQRyTMP);
  //out.print(InsertQRy+"InsertTEMP"+InsertQRyTMP);
  if(x>0)
      {%>
     <script>
        alert("Account Number Already Present Please Select Diffrent Account Number");
</script>
      <%
      }
if(i>0){
//out.print("Normal Saved ");
}
if(i>0){
//out.print("Temp Saved Successfully"+ButtonValue+""+StudentIDD);
}

}else if(RcrDPresnt.equals("Y")&&RcrDPresntTemp.equals("Y")){
    AccQuery="SELECT * FROM StudentPersonalBankDetail WHERE  BANKACCOUNTNO='"+accNumber+"' AND STUDENTID<>'"+StudentIDD+"'";
accDetail=db.getRowset(AccQuery);

if(accDetail.next())
    {
AcctNumber=accDetail.getString("BANKACCOUNTNO").toString();
x++;
    }

 if(ButtonValue.equals("DraftSave")&&AcctNumber.equals("")){
    Updtqry="update StudentPersonalBankDetail set BANKACCOUNTNO='"+accNumber+"',NAMEOFBANK='"+bankname+"',BRANCHNAME='"+BranchName+"',NAMEOFACHOLDER='"+holdername+"',IFSCCODE='"+IfscCd+"',BANKADDRESS='"+BnkAddress+"',FREEZED='N'";
    Updtqry=Updtqry+" where StudentId='"+StudentIDD+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"' ";

    UpdtqryTMP="update temp#StudentPersonalBankDetail set BANKACCOUNTNO='"+accNumber+"',NAMEOFBANK='"+bankname+"',BRANCHNAME='"+BranchName+"',NAMEOFACHOLDER='"+holdername+"',IFSCCODE='"+IfscCd+"',BANKADDRESS='"+BnkAddress+"',FREEZED='N'";
    UpdtqryTMP=UpdtqryTMP+" where temp#STUDENTID='"+TempID+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"' ";
}
if(ButtonValue.equals("Freeze")&&AcctNumber.equals("")){
    Updtqry="update StudentPersonalBankDetail set BANKACCOUNTNO='"+accNumber+"',NAMEOFBANK='"+bankname+"',BRANCHNAME='"+BranchName+"',NAMEOFACHOLDER='"+holdername+"',IFSCCODE='"+IfscCd+"',BANKADDRESS='"+BnkAddress+"',FREEZED='Y'";
    Updtqry=Updtqry+" where StudentId='"+StudentIDD+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"'";

     UpdtqryTMP="update temp#StudentPersonalBankDetail set BANKACCOUNTNO='"+accNumber+"',NAMEOFBANK='"+bankname+"',BRANCHNAME='"+BranchName+"',NAMEOFACHOLDER='"+holdername+"',IFSCCODE='"+IfscCd+"',BANKADDRESS='"+BnkAddress+"',FREEZED='Y'";
    UpdtqryTMP=UpdtqryTMP+" where temp#StudentId='"+TempID+"' and UniqueID='"+UNIQUEID+"' and institutecode='"+InstituteCode+"'";
}

  j=db.update(Updtqry);
  k=db.update(UpdtqryTMP);
 // out.print("Account Number Already Present Please Select Diffrent Account Number");
if(j>0 && k>0 && x==0){%>
<script>
        alert("Record Successfully Submitted");
</script>
<%}
  else if(x>0)
       {%>
       <script>
        alert("Account Number Already Present Please Select Diffrent Account Number");
</script>
 
    <%
  }
}if(AcctNumber.equals("")){%>



<center><FONT COLOR='GREEN'>Record Saved Successfully
    </FONT>
<a href="../StudentFiles/StudentPage.jsp"><font color="blue">continue to Webkiosk</font></a></center>
<%}
//*******************************************************Triger Enable**********************************************************************//


             //   qrytrgr="Alter trigger  CAMPUS.TRGRESTRICTDML_TMPPBD ENABLE";
				//rsTRG=db.getRowset(qrytrgr);

				qrytrgr="Alter trigger CAMPUS.TRGRESTRICTDML_PBD  ENABLE";
				rsTRG=db.getRowset(qrytrgr);

//*******************************************************Triger Enable**********************************************************************//
}catch(Exception e){
   out.print("Insert error"+e);
}

}

}else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
   }
      }
else
{
      out.print("<center><img src='../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp'>Login</a> to continue</font> <br>");
}
%>

<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
</td>
</tr>
</table>



</BODY>
</HTML>