<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>
<%
try
{  //1
DBHandler db=new DBHandler();
String qryi="";
ResultSet rs=null;
ResultSet rs1=null;
OLTEncryption enc=new OLTEncryption();
String qry="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSNO=0;
String pPassd="";
String minst="", mAcademicyear="";
String mName1=""	,mName2="",mName3="",mName4="",mName5="",mInst="";
String pMemberID="" ,pMemberCode="" , pMemberType=""  ,pMemberRole="" , pPass="", mName="";
int mMaxPWD=20;
int mMinPWD=4;
int mFlag=0;
String qryt="",mTs="";
ResultSet rst=null;
int len=0,kk=0;
String mP="";
String mN="";
String mE="";
String mI="";
String pdMemberID="",pdMemberCode="";
String qrye="";
ResultSet rse=null;
String mSTemail="",mQUOTA="";
/*
if (session.getAttribute("MinPasswordLength")==null)
{
	mMinPWD=4;
}
else
{
	mMinPWD=Integer.parseInt(session.getAttribute("MinPasswordLength").toString().trim());
}

if (session.getAttribute("MaxPasswordLength")==null)
{
	mMaxPWD=20;
}
else
{
	mMaxPWD=Integer.parseInt(session.getAttribute("MaxPasswordLength").toString().trim());
}
*/

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
if (session.getAttribute("BASEINSTITUTECODE")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("BASEINSTITUTECODE").toString().trim();
}
	String mHead="";
	if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
		   mHead=session.getAttribute("PageHeading").toString().trim();
	else
		   mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Parents Signup XLS ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>
<form name="save" >
<!-- <table align=center>
<tr><td><U><FONT face='arial' color=darkbrown size=4>Student Password Creation.</FONT></U>
</td></tr>
</table> -->
<hr>
<h1><font size=3>Parents Password Generated.</font></h1>
<!--Institute-->
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
<%
// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";

if (session.getAttribute("BASELOGINID")==null || session.getAttribute("BASELOGINID").toString().trim().equals(""))
	mLogEntryMemberID="";
else
	mLogEntryMemberID=session.getAttribute("BASELOGINID").toString().trim();

if (session.getAttribute("BASELOGINTYPE")==null || session.getAttribute("BASELOGINTYPE").toString().trim().equals(""))
	mLogEntryMemberType="";
else
	mLogEntryMemberType=session.getAttribute("BASELOGINTYPE").toString().trim();

if (!mLogEntryMemberType.equals(""))
	mLogEntryMemberType=enc.decode(mLogEntryMemberType);

if (!mLogEntryMemberID.equals(""))
	mLogEntryMemberID=enc.decode(mLogEntryMemberID);

//--------------------------------------
String mIPAddress=session.getAttribute("IPADD").toString().trim();

	String mLoginIDFrSes="";
if(mInst.equals("JIIT"))
	mLoginIDFrSes="asklJIITADMINaskl";
else if(mInst.equals("JPBS"))
	mLoginIDFrSes="asklJPBSADMINaskl";
else
	mLoginIDFrSes="asklJ128ADMINaskl";
//out.print(mLogEntryMemberID+" - "+mLoginIDFrSes);
	if(mLogEntryMemberID.equals(mLoginIDFrSes) && mLogEntryMemberType.equals("A"))

	{ //2

//if(request.getParameter("StdPwd").toString().trim().length()>=mMinPWD && request.getParameter("StdPwd").toString().trim().length()<=mMaxPWD )
//{
	try
	{
	// mDMemberCode=enc.decode(mMemberCode);
	pMemberType=enc.encode("P");

	pMemberRole =request.getParameter("RoleName");
	// pPass=enc.encode(request.getParameter("StdPwd").toString().trim());
	int c=0;


//	String mChkAllSudent=request.getParameter("ProgramCode");
	String mStr=request.getParameter("ProgramCode");

	if(request.getParameter("Academicyear")==null)
	{
		 mAcademicyear="";
	}
	else
	{
		 mAcademicyear=request.getParameter("Academicyear");
	}
	if(request.getParameter("QUOTA")==null)
	{
		 mQUOTA="";
	}
	else
	{
		 mQUOTA=request.getParameter("QUOTA");
	}
	
	%>

	<TABLE cellSpacing=1 cellPadding=1  border=1 rules="groups" align=center bordercolor=black>
				<thead>
				<TR >
				<td><FONT face=arial color=black><B>S.No</b></font></td>
				<TD><FONT face=arial color=black><B>Enrollment No.<br>/ LoginID</FONT></TD>
				<TD><FONT face=arial color=black><B>Password</B></FONT></TD>
				<TD><FONT face=arial color=black><B>Student Name</FONT></TD>
                                <TD><FONT face=arial color=black><B>Father Name</FONT></TD>
				<TD><FONT face=arial color=black><B>Program Code</FONT></TD>
	                        <TD><FONT face=arial color=black><B>Academic Year</FONT></TD>
                                <TD><FONT face=arial color=black><B>Parents E-Mail</FONT></TD>
				<TR>
				</thead>
	<%
		if (mStr.equals(""))
		{
		 qry="select A.STUDENTID, A.ENROLLMENTNO, A.STUDENTNAME, A.PROGRAMCODE, A.academicyear,A.FATHERNAME,B.PWD ,nvl(C.PAEmailID,' ') PAEmailID from STUDENTMASTER A, MEMBERMASTER b , StudentPhone c Where A.academicyear='"+mAcademicyear+"' AND B.ORATYP='"+pMemberType+"' AND B.ORAADM='"+pMemberRole+"' and a.QUOTA=decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"') ";
		 qry=qry+"and A.INSTITUTECODE='"+mInst+"' AND a.ENROLLMENTNO=b.MEMCODE and A.ENROLLMENTNO is not null and nvl(A.deactive,'N')='N' And a.studentid = c.studentid(+) order by ENROLLMENTNO";
		}
		else
		{
		qry="select A.STUDENTID, A.ENROLLMENTNO, A.STUDENTNAME, A.PROGRAMCODE, A.academicyear,A.FATHERNAME,B.PWD ,nvl(C.PAEmailID,' ') PAEmailID from STUDENTMASTER A, MEMBERMASTER b , StudentPhone c Where A.ProgramCode IN ("+mStr+") and  a.ENROLLMENTNO=b.MEMCODE AND B.ORATYP='"+pMemberType+"' AND B.ORAADM='"+pMemberRole+"' AND  ";
		qry=qry+" A.academicyear='"+mAcademicyear+"' and a.QUOTA=decode('"+mQUOTA+"','ALL',quota,'"+mQUOTA+"')  and A.ENROLLMENTNO is not null and A.INSTITUTECODE='"+mInst+"' and nvl(A.deactive,'N')='N' And a.studentid = c.studentid(+) order by ENROLLMENTNO";
		}
		rs=db.getRowset(qry);
//out.print(qry);
		while (rs.next())
		{
			kk++;
			%>

				<tr>
					<td ><%=kk%>.</td>
					<td ><%=rs.getString("ENROLLMENTNO")%></td>
					<td ><%=rs.getString("PWD")%></td>
                                        <td ><%=rs.getString("STUDENTNAME")%></td>
					<td ><%=rs.getString("FATHERNAME")%></td>
					<td ><%=rs.getString("PROGRAMCODE")%></td>
					<td ><%=rs.getString("academicyear")%></td>
                                        <td ><%=rs.getString("PAEmailID")%></td>


				</tr>

			<%
		}







	}
	catch(Exception e)
	{
	//	out.print(qry+"error");
	}
	%>


</form>
	<%
/*}
else
{
out.print("<br><img src='../../Images/Error1.jpg'>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Password length must be between "+mMinPWD+ " to " +mMaxPWD +" </font> <br>");
out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'><a href='SignUpStudents.jsp'><img src='../../Images/Back.jpg' border=0></a></font> <br>");

}*/

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}	//1
catch(Exception e)
{
	//out.print("dddd");
}
%>
</body>
</html>