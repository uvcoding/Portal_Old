<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUIT ";
%>
<HTML>
<head>

<style type="text/css"> 
body {scrollbar-3dlight-color:#ffd700;
scrollbar-arrow-color:#ff0; 
scrollbar-base-color:=:#000ff0;
scrollbar-darkshadow-color:#000000; 
scrollbar-face-color:#de6400; 
scrollbar-highlight-color:#9900005;
scrollbar-shadow-color:#f0f} 
</style> 

<TITLE>#### <%=mHead%> [Change Contact information] </TITLE>
  <script language="JavaScript" type ="text/javascript">
	<!-- 
	  if (top != self) top.document.title = document.title;
	-->
  </script>
<script language=javascript>
	<!--
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<SCRIPT TYPE="text/javascript">
<!--
// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place


function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}

//-->
</SCRIPT>
<script language = "Javascript">
function echeck(str) {

		var at="@"
		var dot="."
		var lat=str.indexOf(at)
		var lstr=str.length
		var ldot=str.indexOf(dot)
		if (str.indexOf(at)==-1){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(at)==-1 || str.indexOf(at)==0 || str.indexOf(at)==lstr){
		   alert("Invalid E-mail ID")
		   return false
		}

		if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 || str.indexOf(dot)==lstr){
		    alert("Invalid E-mail ID")
		    return false
		}

		 if (str.indexOf(at,(lat+1))!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.substring(lat-1,lat)==dot || str.substring(lat+1,lat+2)==dot){
		    alert("Invalid E-mail ID")
		    return false
		 }

		 if (str.indexOf(dot,(lat+2))==-1){
		    alert("Invalid E-mail ID")
		    return false
		 }
		
		 if (str.indexOf(" ")!=-1){
		    alert("Invalid E-mail ID")
		    return false
		 }

 		 return true					
	}

function ValidateForm(){
	var emailID=document.frm.SEMail
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please Enter your Email ID")
		emailID.focus()
		return false
	}
	if (echeck(emailID.value)==false){
		emailID.value=""
		emailID.focus()
		return false
	}
	return true
 }
</script>

</head>
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%
String mSCellNo="", mPCellNo="", mSTelNo="", mPTelNo="", mSEmail="",mPEmail="";
String mInstC="",mWebEmail="",mMemberID="",mADDRESS1="",mADDRESS2="",mADDRESS3="";
String mMem="",mCITY="",mPIN="",mPOSTOFFICE="",mRAILSTATION="";
String mMemID="",mPOLSTATION="",mDISTRICT="",mSTATE="";
String mDID="";
String qry="";
String mScellNo="",mMemberType="";
String mStelNo="";
String mSstd="";
String mSemail="";
String mPcellNo="";
String mPstd="";
String mPtelNo="";
String mPemail="",mInst="",mCD="";
String x="";
ResultSet rs=null,rsi=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
try
{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}
if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemberID="";	
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}
if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	OLTEncryption enc=new OLTEncryption();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());
	mCD=enc.decode(session.getAttribute("MemberCode").toString().trim());
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();


if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

if (mLogEntryMemberType.equals(""))
	mLogEntryMemberType=mMemberType;

if (mLogEntryMemberID.equals(""))
	mLogEntryMemberID=mMemberID;


if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('29','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

  //----------------------


qry="select nvl(StStdCode,' ') Sstd, nvl(StTelNo,' ') sTel,nvl(StCellNo,' ') SCell,nvl(StEmailid,' ') sEmail,nvl(PaStdCode,' ') Pstd, nvl(PaTelNo,' ') pTel,nvl(PaCellNo,'') pCell, nvl(PaEmailid,' ') pEmail from Studentphone where STUDENTID='" +mDID+ "'";
rs=db.getRowset(qry);
if ( rs.next())
{
	if (rs.getString("SCell")==null)
		mSCellNo="";
	else
	   	mSCellNo=rs.getString("SCell");

	if (rs.getString("pCell")==null)
		 mPCellNo="";
	else
		 mPCellNo=rs.getString("pCell");

	if(rs.getString("SSTD")==null)
		 mSstd="";
	else
		mSstd=rs.getString("SSTD");

	if(rs.getString("PSTD")==null)
		 mPstd="";
	else
		mPstd=rs.getString("PSTD");

	if(rs.getString("sTel")==null)
		 mSTelNo="";
	else
		mSTelNo=rs.getString("sTel");

	if(rs.getString("pTel")==null)
		mPTelNo="";
	else
		mPTelNo=rs.getString("pTel");

	if(rs.getString("sEmail")==null)
		 mSEmail=rs.getString("sEmail");
	else
		 mSEmail=rs.getString("sEmail");

	if(rs.getString("pEmail")==null)
		 mPEmail=rs.getString("pEmail");
	else
		 mPEmail=rs.getString("pEmail");
	
 }
 qry="SELECT NVL(CADDRESS1,' ')ADDRESS1, NVL(CADDRESS2,' ')ADDRESS2,NVL(CADDRESS3,' ')ADDRESS3,NVL(CCITY,' ')CITY,NVL(CPIN,'')PIN,NVL(CDISTRICT,' ')DISTRICT,NVL(CPOSTOFFICE,' ')POSTOFFICE,NVL(CRAILSTATION,' ')RAILSTATION,NVL(CPOLICESTATION,' ')POLSTATION, NVL(CSTATE,' ')STATE FROM STUDENTADDRESS WHERE STUDENTID='" +mDID+ "'";
 //out.print(qry);
 rs=db.getRowset(qry);
 if(rs.next())
		   {
	 if (rs.getString("ADDRESS1").equals(" "))
		mADDRESS1=" ";
	else
	   	mADDRESS1=rs.getString("ADDRESS1");

	if (rs.getString("ADDRESS2").equals(" "))
		mADDRESS2=" ";
	else
	   	mADDRESS2=rs.getString("ADDRESS2");
	if (rs.getString("ADDRESS3").equals(" "))
		mADDRESS3=" ";
	else
	   	mADDRESS3=rs.getString("ADDRESS3");
	
	if (rs.getString("CITY").equals(" "))
		mCITY=" ";
	else
	   	mCITY=rs.getString("CITY");
	if (rs.getString("PIN")==null)
		mPIN="";
	else
	   	mPIN=rs.getString("PIN");
	if (rs.getString("DISTRICT").equals(" "))
		mDISTRICT=" ";
	else
	   	mDISTRICT=rs.getString("DISTRICT");
	if (rs.getString("POSTOFFICE").equals(" "))
		mPOSTOFFICE=" ";
	else
	   	mPOSTOFFICE=rs.getString("POSTOFFICE");
	if (rs.getString("RAILSTATION").equals(" "))
		mRAILSTATION=" ";
	else
	   	mRAILSTATION=rs.getString("RAILSTATION");
	if (rs.getString("POLSTATION").equals(" "))
		mPOLSTATION=" ";
	else
	   	mPOLSTATION=rs.getString("POLSTATION");
	if (rs.getString("STATE").equals(" "))
		mSTATE=" ";
	else
	   	mSTATE=rs.getString("STATE");

		   }
%>
<form name="frm"  method="post" action="StudModifyEmailIDTelephoneAction.jsp" onSubmit="return ValidateForm();">
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"><B>Student/Parent Information</B></font>
</td>
</tr>
</TABLE>

<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
	qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
	rsi=db.getRowset(qry);
	while(rsi.next())
	{
		mInstC=rsi.getString("IC");
	}
%>
<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1 style="FONT-FAMILY: Arial; 
	FONT-SIZE: x-small" borderColor=black borderColorDark=white width=100%>
     <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Student Contact Detail (Current)</STRONG></FONT></P></TD>
		<!--<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Student Contact Detail (New)</STRONG></FONT></P></TD>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSCellNo%> </FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><INPUT ID="SCellNo" Name="SCellNo" Type="text" value="<%=mSCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>	
	<TR>
		<td><FONT color=black face=Arial size=2>&nbsp;STD Code - Phone</FONT></td>
		<TD><FONT color=black>&nbsp;<%=mSstd%>&nbsp;-&nbsp;<%=mSTelNo%></FONT>&nbsp;
		<!--<td><FONT color=black face=Arial size=2>&nbsp;STD Code</FONT></td>-->
		<!--<td colspan="3"><INPUT ID="SSTD" Name="SSTD" Type="text" value="<%=mSstd%>" style="WIDTH: 50px; HEIGHT: 22px" maxLength=20>-->
		<!--<FONT color=black face=Arial size=2>&nbsp;Phone</FONT>-->
		<!--<INPUT ID="STelNo" Name="STelNo" Type="text" value="<%=mSTelNo%>" style="WIDTH: 100px; HEIGHT: 22px" maxLength=50></td>-->
	</TR>	
		
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSEmail%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>-->
		<!--<td><INPUT ID="SEMail" Name="SEMail" Type="text" value="<%=mSEmail%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=60><font color=red>*</font></td>-->
	</TR>
	 <TR align="middle" bgcolor="#ff8c00">
		<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Correspondance Address (Current)</STRONG></FONT></P></TD>
		<!--<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Correspondance Address(New)</STRONG></FONT></P></TD>-->
	</TR>
    <TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 1</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS1%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Address 1</FONT></TD>
		<td><INPUT ID="Address1" Name="Address1" Type="text" value="<%=mADDRESS1%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=60></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 2</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS2%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Address 2</FONT></TD>
		<td><INPUT ID="Address2" Name="Address2" Type="text" value="<%=mADDRESS2%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=60></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Address 3</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mADDRESS3%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Address 3</FONT></TD>
		<td><INPUT ID="Address3" Name="Address3" Type="text" value="<%=mADDRESS3%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=60></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;City</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mCITY%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;City</FONT></TD>
		<td><INPUT ID="City" Name="City" Type="text" value="<%=mCITY%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Pin</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPIN%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Pin</FONT></TD>
		<td><INPUT ID="Pin" Name="Pin" Type="text" value="<%=mPIN%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=6 onKeyPress="return numbersonly(this, event);"></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Post Office</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPOSTOFFICE%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Post Office</FONT></TD>
		<td><INPUT ID="Post0ffice" Name="Post0ffice" Type="text" value="<%=mPOSTOFFICE%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Railway Station</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mRAILSTATION%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Railway Station</FONT></TD>
		<td><INPUT ID="RailStation" Name="RailStation" Type="text" value="<%=mRAILSTATION%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Police Station</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPOLSTATION%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Police Station</FONT></TD>
		<td><INPUT ID="PolStation" Name="PolStation" Type="text" value="<%=mPOLSTATION%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;District</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mDISTRICT%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;District</FONT></TD>
		<td><INPUT ID="District" Name="District" Type="text" value="<%=mDISTRICT%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;State</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mSTATE%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;State</FONT></TD>
		<td><INPUT ID="State" Name="State" Type="text" value="<%=mSTATE%>" style="WIDTH: 250px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>

<TR align="middle" bgcolor="#ff8c00">
<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Parent/Guardian Contact Detail (Current)</STRONG></FONT></P></TD>
<!--<TD colspan="2"><P align=center><FONT color=white face=Arial size=2><STRONG>&nbsp;Parent/Guardian Contact Detail (New)</STRONG></FONT></P></TD>-->
	</TR>
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPCellNo%> </FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;Cell/Mobile</FONT></TD>
		<td><INPUT ID="PCellNo" Name="PCellNo" Type="text" value="<%=mPCellNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>-->
	</TR>	
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;STD Code - Phone</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPstd%>&nbsp;-&nbsp;<%=mPTelNo%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;STD Code</FONT></td>-->
		<!--<td colspan="3"><INPUT ID="PSTD" Name="PSTD" Type="text" value="<%=mPstd%>" style="WIDTH: 50px; HEIGHT: 22px" maxLength=20>-->
		<!--<FONT color=black face=Arial size=2>&nbsp;Phone</FONT>-->
		<!--<INPUT ID="PTelNo" Name="PTelNo" Type="text" value="<%=mPTelNo%>" style="WIDTH: 100px; HEIGHT: 22px" maxLength=50></td>-->
	</TR>	
		
	<TR>
		<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><FONT color=black>&nbsp;<%=mPEmail%></FONT>&nbsp;</td>
		<!--<TD><FONT color=black face=Arial size=2>&nbsp;E-Mail</FONT></TD>
		<td><INPUT ID="PEMail" Name="PEMail" Type="text" value="<%=mPEmail%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=60></td>-->
	</TR>
	
	<!--<TR><td colspan=4 align=center><INPUT Type="submit" Value="Save"></td></TR>-->
	</TABLE></body>
<%

	

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
	
	
   }
  //-----------------------------

}
else
{
%>
<br>Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
 <%
	}
}
catch(Exception e)
{
}
%>
<center>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>
		</td></tr></table>
</form>
</html>
