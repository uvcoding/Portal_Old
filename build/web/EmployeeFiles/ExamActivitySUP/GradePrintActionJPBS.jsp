<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String qry="";
ResultSet rs=null;
String qrys="";
ResultSet rss=null;
ResultSet rss1=null;
int mSno1=0;
String mNames="";
DBHandler db=new DBHandler();
String mInst="",mDefault="";
int ctr=0;
String mHead="";
String mysubjcode="",mETOD="",mDet="";
String qrysub="",mNam="",mSc="",mCheckFstid="",mWeightageInit="",qry2="",qryi=""; 
ResultSet rssub=null,rs2=null,rsi=null;

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

%>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) 
  top.document.title = document.title;
//-->
</script>
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
try
{
OLTEncryption enc=new OLTEncryption();

String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="";
String mECode="",mecode="";
int mSno=0,mFlag=0;
String mName="";
String mSCode="",mscode="";
String mEC="",mSC="";
String mName1="";

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
    RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

		
		%><table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Freezed Grade Sheet</b></TD>
</font></td></tr>
</TABLE><%
		
		mEC=request.getParameter("ExamCode");
			mSC=request.getParameter("Subject");
			mETOD=request.getParameter("ETOD");
		String bno=request.getParameter("bno");
		//out.print(mSC);
		qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSC+"' and institutecode='"+mInst+"' and nvl(deactive,'N')='N' ";
	rssub=db.getRowset(qrysub);
	if(rssub.next())
		{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");
		}
		else
		{
			mNam="";
			mSc="";
		}

	String qryz="select 'Y'  from exameventmaster where INSTITUTECODE='"+mInst+"' and  EXAMCODE='"+mEC+"' and nvl(MASSCUTSAPPLICABLE,'N')='Y' AND NVL(NEGATIVEMASSCUTSALLOWED,'N')='Y' ";
ResultSet rsz=db.getRowset(qryz);
if(rsz.next())
		{
			mFlag=1;
		}

		%>
		<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD><b>Exam Code :</b><%=mEC%></TD>
		<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
	</TR>
	</TABLE>
<table align=center>
<!-- <tr>
<td align=center><b>Final Examination of students Semester-</B>
</td>
</tr> -->
</table>

<TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
	<td ><b><font color=white>&nbsp;SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	
	<td><b><font color=white >Student Name</font></b></td>
<%
	if(mFlag==1)
		{
			%>
			<td><b><font color=white >Marks Cuts</font></b></td>
			<%
		}
		%>

	 <td><b><font color=white >Marks</font></b></td> 
	<td><b><font color=white >Grade</font></b></td>
</tr>
</thead>
<tbody>
<%
qryi=" SELECT distinct B.enrollmentno,B.studentname,A.STUDENTID,A.INITIALMARKS,A.INITIALGRADE,A.MASSCUTS,A.FINALMARKS,";
qryi=qryi+" nvl(A.FINALGRADE,' ')FINALGRADE,nvl(A.MASSCUTS,0)MASSCUTS FROM STUDENTWISEGRADE A,V#STUDENTEVENTSUBJECTMARKS  B where A.BREAK#SLNO= '"+bno+"'  ";
qryi=qryi+" and A.INSTITUTECODE='"+mInst+"' and a.institutecode=b.institutecode AND A.FSTID=B.FSTID and A.EXAMCODE='"+mEC+"'  AND A.STUDENTID=B.STUDENTID AND NVL(A.DEACTIVE,'N')='N'  order by B.studentname";
rsi=db.getRowset(qryi);
//out.print(qryi);
while(rsi.next())
{
	ctr++;
	mDet=rsi.getString("FINALGRADE");
%>
		<tr bgcolor=white >
		<td align='right'><B><%=ctr%>.</B></td>
		<td><%=rsi.getString("enrollmentno")%></td>
<%
	if(mDet.equals("F"))
	{
	%>
			<td><%=GlobalFunctions.toTtitleCase(rsi.getString("studentname"))%>*</td>
	<%

	}
	else
	{
		%>
			<td><%=GlobalFunctions.toTtitleCase(rsi.getString("studentname"))%></td>
		<%
	}
	
	if(mFlag==1)
		{
			%>
			<td>&nbsp;<%=rsi.getDouble("MASSCUTS")%></td>
			<%
		}
		%>
		<td>&nbsp;<%=rsi.getDouble("FINALMARKS")%></td>
		<td>&nbsp;<%=rsi.getString("FINALGRADE")%></td>
		</tr>
<%
} // closing of while rsi
qry="select to_char(sysdate,'dd-mm-yyyy hh:mi:ss PM') from dual";
rs=db.getRowset(qry);
rs.next();
String mDat=rs.getString(1);

%>
</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","CaseInsensitiveString"]);
</script>
<br>
<table width=76% align=center>
<tr>
<td align=left>
Name:-<br>
Signature of Instructor:<br>
Submitted on..<%=mDat%>
</td>
<td align=right>*Detained Candidate 
</td>
</tr>
</table>

<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
</form>
 <%





//-----------------------------
//---Enable Security Page Level  
//-----------------------------
	}
	else
	{
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
  	}
//-----------------------------


} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}    
}
catch(Exception e)
{
	// out.print(e);
}
%>