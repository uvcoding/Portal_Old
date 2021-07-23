<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="", qry1="";

int mSNO=0;
String mMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";

String mSubj="", mStatus="", mCtype="", mSID="",mDate1="",mDate2="";
String mExam="", mColor="";
String mLTP="";
String mTotal="";
String mStudID="";
String mCType="ALL";
try
{
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

	if (request.getParameter("EXAM").toString().trim()==null)
	{
		mExam="";
	}
	else
	{	
		mExam=request.getParameter("EXAM").toString().trim();
	}

	if (request.getParameter("SID").toString().trim()==null)
	{
		mSID="";
	}
	else
	{
		mSID=request.getParameter("SID").toString().trim();
	}

	if (request.getParameter("SC").toString().trim()==null)
	{
		mSubj="";
	}
	else
	{
		mSubj=request.getParameter("SC").toString().trim();
	}

	if (request.getParameter("LTP").toString().trim()==null)
	{
		mLTP="";
	}
	else
	{	
		mLTP=request.getParameter("LTP").toString().trim();
	}
	if (request.getParameter("Date1").toString().trim()==null)
	{
		mDate1="";
	}
	else
	{	
		mDate1=request.getParameter("Date1").toString().trim();
	}
	if (request.getParameter("Date2").toString().trim()==null)
	{
		mDate2="";
	}
	else
	{	
		mDate2=request.getParameter("Date2").toString().trim();
	}

//out.println(mDate1 +"  "+mDate2);

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [Student Attendance Report (Day wise Absent/Present)]</TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("")) 
	{
	mDMemberCode=enc.decode(mMemberCode);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
			if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

%>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>
<TD colspan=0 align=middle ><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b>Day wise Student Attendance (Absent/Present)</b></font></td>
</tr>
</TABLE>
<%
String mSnm="", mENo="",mSubject="";
qry="select StudentName, Enrollmentno from StudentMaster where StudentID='"+mSID+"'";
rs1=db.getRowset(qry);
if(rs1.next())
{
mSnm=rs1.getString(1);
mENo=rs1.getString(2);
}

qry="select subject||'('|| subjectcode ||')' subject From subjectmaster where subjectid='"+ mSubj +"'";
	rs1=db.getRowset(qry);
	if(rs1.next())
	{
		mSubject=rs1.getString(1);
	}

%>
<table width="100%">
<tr><td align=center>
 <font color="#00008b" size=3>Student Name: <B><%=GlobalFunctions.toTtitleCase(mSnm)%> [<%=mENo%>]</B></font><br>
 <font color="#00008b" size=3>Subject Code: <b><%=mSubject%></B> &nbsp; &nbsp; LTP: <B><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></B></font>
</td></tr></table>
 <TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="70%" border=1 >
<thead>
<tr bgcolor="#ff8c00">
 <td align=center Title="Click on SNo to sort"><b><font color="White">SNo</font></b></td>
 <td align=center Title="Click on Date to Sort"><b><font color="White">Date</font></b></td>
 <td align=center Title="Click on Attendance by to Sort"><b><font color="White">Attendance By</font></b></td> 
 <td align=center Title="Click on Status to Sort"><b><font color="White">Status</font></b></td> 
</tr>
</thead>
<tbody>
<%
	qry="select to_char(ATTENDANCEDATE,'DD-MM-YYYY')ADate, nvl(ENTRYBYFACULTYNAME,' ')EName, nvl(PRESENT,'N')Status from V#STUDENTATTENDANCE ";
	qry=qry+" where EXAMCODE='"+mExam+"'";
	qry=qry+" and ATTENDANCETYPE=Decode('"+mCType + "','ALL',ATTENDANCETYPE,'"+ mCType +"')";
	qry=qry+" and SUBJECTID='"+mSubj+"'";
	qry=qry+" and LTP='"+mLTP+"'";
	qry=qry+" and STUDENTID='"+mSID+"' ";
	qry=qry+" and trunc(ATTENDANCEDATE) between trunc(decode(to_date('"+mDate1+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate1+"','dd-mm-yyyy'))) ";
	qry=qry+" and trunc(decode(to_date('"+mDate2+"','dd-mm-yyyy'),'',ATTENDANCEDATE,to_date('"+mDate2+"','dd-mm-yyyy'))) ";
	qry=qry+" and nvl(DEACTIVE,'N')='N'  order by ADATE DESC ";
	rs=db.getRowset(qry);
	//out.print(qry);
	mSNO=0;
	while(rs.next())
	{
		mSNO++;
		if(rs.getString("Status").equals("Y"))
		{
			mStatus="Present";
			mColor="Green";
		}
		else
		{
			mStatus="Absent";
			mColor="RED";
		}
		%>
		<tr>
		<td align=center><%=mSNO%>.</td>
		<td align=center><%=GlobalFunctions.toTtitleCase(rs.getString("ADate"))%></td>
		<td align=center><%=rs.getString("EName")%></td>
		<td align=center><font color=<%=mColor%>><B><%=mStatus%></B></font></td>
		</tr>
	<%
	}
%>
</tbody>
</TABLE>
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","Number","Number"]);
</script>

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
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}		
catch(Exception e)
{
}
%>
</body>
</html>