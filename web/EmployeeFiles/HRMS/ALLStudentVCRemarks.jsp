<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
OLTEncryption enc=new OLTEncryption();

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
	String mEnroll="",mSysDate="";
String qryn="";
ResultSet rsn=null;
String mFLAG="";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student VC Remarks] </TITLE> 
<SCRIPT LANGUAGE="JavaScript">
 
function Validate()
{
if(document.frm1.Remarks.value=="")
	{
		alert("Please Fill the Remarks.. ");
		frm1.Remarks.focus();
		return false;
	}
}
	function Documentdisable()
	{
				if(document.frm1.ORemarks.checked==true)
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=true;
						document.frm1.OtherRemarks.disabled=false;
					}
					else
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=false;
						document.frm1.OtherRemarks.disabled=true;
					}
					if(document.frm1.ORelated.checked==true)
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=true;
						document.frm1.OtherRelated.disabled=false;
					}
					else
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=false;
						document.frm1.OtherRelated.disabled=true;
					}
		}
	
		function funremarks()	
				{
					if(document.frm1.ORemarks.checked==true)
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=true;
						document.frm1.OtherRemarks.disabled=false;
					}
					else
					{
						document.frm1.OtherRemarks.value="";
						document.frm1.RemarksType.disabled=false;
						document.frm1.OtherRemarks.disabled=true;

					}
				}
				function funrelated()
				{
					if(document.frm1.ORelated.checked==true)
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=true;
						document.frm1.OtherRelated.disabled=false;
					}
					else
					{
						document.frm1.OtherRelated.value="";
						document.frm1.RelatedTo.disabled=false;
						document.frm1.OtherRelated.disabled=true;
					}
				}

//-->
</SCRIPT>
</HEAD>
<%
String mMemberID="";
String mMemberType="";
String mMemberCode="",qry="";
DBHandler db=new DBHandler();
ResultSet rs=null;
String mWebEmail="";
String mInst="";

if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}


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

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}
%>

<BODY aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0  onLoad="Documentdisable();">
<%
if(!mMemberID.equals("") || !mMemberType.equals("") || !mMemberCode.equals(""))
{

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('188','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
		String Heading="",mMemType="";

	if(request.getParameter("MEMTYPE")==null || request.getParameter("MEMTYPE").equals(""))
	{
		mMemType="";
	}
	else
	{
	   mMemType=request.getParameter("MEMTYPE").toString().trim();
	}

	if(mMemType.equals("S"))
    {
		Heading="Students";
     }
    else if(mMemType.equals("E"))
	{
		Heading="Employees" ; 
	 }
qry="select to_char(sysdate,'dd-mm-yyyy') from dual";
rs=db.getRowset(qry);
rs.next();
mSysDate=rs.getString(1);
  //----------------------
%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA">Remarks for <%=Heading%> </font>
</td>
</tr>
</TABLE>

<form name="frm2" action="ALLStudentVCRemarksAction.jsp" method="post"> 
<input type=hidden name="y" id="y">
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: VERDANA"<b>View Existing Remarks/Comments(Query/View criteria)</b></font>
</td>
</tr>
</TABLE>
<table align=center rules=groups border=1 width=70%  cellspacing=0 cellpadding=0 >
<tr>
<td><b>Interaction date between</b>
<input readonly type=text value="<%=mSysDate%>" name=InteractionDate1 size=10  maxlength=10 onchange="return iSValidDate(InteractionDate1.value);" >&nbsp;<a href="javascript:NewCal('InteractionDate1','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
</td>
<td>
<b>and </b></td>
<td>
<input readonly type=text value="<%=mSysDate%>" name=InteractionDate2 size=10  maxlength=10 onchange="return iSValidDate(InteractionDate2.value);" >&nbsp;<a href="javascript:NewCal('InteractionDate2','ddmmyyyy')"><img src="images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
</td>
<td><input type=submit value=Submit></td>
</tr>
</table>
<INPUT TYPE=HIDDEN NAME="MEMTYPE" ID="MEMTYPE" value="<%=mMemType%>">
</form>
<%
  



  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
  {
   %>
<br>	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------

}
else
{
out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp'>Login</a> to continue</font> <br>");
}
%>

</BODY>
</HTML>