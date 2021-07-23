<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0,count=0;
double mTotalDays=0,mpaid=0,mlwp=0,mabsent=0;
String qry="",qry1="";
String mComp="",TRCOLOR="White";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mFacultyName="",mFaculty="", mMsg="",mFacultyCode="";
String mLeave="",mLeaveName="",mLeaveCode="";
String mLvStatus="",mStatus="";
String QryFaculty="",mEID="",mENM="";
String QryLeave="",QryRID="";
String mSrcType="I";
String mLYC="",mLeaveYearCode="";
String LYC="";
String mLC="",mLCFD="",mLCTD="", mRightsID="173";

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

if(request.getParameter("RID")==null)
{
	QryRID="";
}
else
{
	QryRID=request.getParameter("RID").toString().trim();	
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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Pending Leave Request Report ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 

</SCRIPT>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script language=javascript>
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
    document.frm.submit();
}
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
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
		qry="Select WEBKIOSK.ShowLink('"+mRightsID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);

	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
	  //----------------------
	%>
	<form name="frm"  method="get"  >
	<input id="x" name="x" type=hidden>
	<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
	<table id=id1 width="852"   topmargin=0 cellspacing=0 cellpadding=0 rightmargin=0 leftmargin=0 bottommargin=0 >

	
<!-------------Page Heading and Marquee Message----------------------->
<%
try
{
	String mPageHeader="Self Leave Request Report", mMarqMsg="", CurrDate="";
	qry="Select to_char(sysdate,'dd-mm-yyyy')CurrDate from dual";
	rs=db.getRowset(qry);
	if(rs.next())
	{
		CurrDate=rs.getString("CurrDate");
	}
	qry="Select nvl(A.MARQUEEMESSAGE,' ')MarqMsg FROM PAGEBASEDMEESSAGES A WHERE A.RIGHTSID='"+mRightsID+"' and A.RELATEDTO LIKE '%E%' and to_date('"+CurrDate+"','dd-mm-yyyy') between MESSAGEFLASHFROMDATETIME and MESSAGEFLASHUPTODATETIME and nvl(DEACTIVE,'N')='N'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mMarqMsg=rs.getString("MarqMsg");
		%>
		<tr><td width=100% bgcolor="#A53403" style="FONT-WEIGHT:bold; FONT-SIZE:smaller; WIDTH:100%; HEIGHT:15px; FONT-VARIANT:small-cap; filter:progid:DXImageTransform.Microsoft.Gradient(startColorStr='Orange', endColorStr='#A53403', gradientType='0'"><marquee behavior="" scrolldelay=100 width=100%><font color="white" face=arial size=2><STRONG><%=mMarqMsg%></STRONG></font></marquee></b></td><tr>
		<%
	}
	qry="Select nvl(B.PAGEHEADER,'"+mPageHeader+"')PageHeader FROM WEBKIOSKRIGHTSMASTER B WHERE B.RIGHTSID='"+mRightsID+"' and B.RELATEDTO LIKE '%E%'";
	rs=db.getRowset(qry);
	//out.print(qry);
	if(rs.next())
	{
		mPageHeader=rs.getString("PageHeader");
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
	else
	{
		%>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4> <%=mPageHeader%> </FONT></u></b></font></td></tr>
		<%
	}
}
catch(Exception e)
{}
%>
<!-------------Page Heading and Marquee Message----------------------->
<tr>
<td colspan=2 align=right ><marquee  scrolldelay=200 width=200><a target=_new href="SelfLeaveStatus.jsp"><b>View Datewise Leave Request</b></a></marquee></td>
</tr>
</table>
	<br>
	<table cellpadding=7 cellspacing=0 align=center width=80% rules=groups border=2>
<!--**Staff Name Combo**-->
	<tr><td nowrap><font color=black face=arial size=2><STRONG>Employee </STRONG>
	<%
	if(mSrcType.equals("D"))
	{
	qry="select distinct nvl(A.EMPLOYEEID,' ')FacultyID, nvl(A.EMPLOYEENAME,' ')FacultyName, ";
	qry=qry+" nvl(A.EMPLOYEECODE,' ')FacultyCode from EMPLOYEEMASTER A,LEAVEREQUEST B where A.EMPLOYEEID=B.EMPLOYEEID"; 
	}
	else if(mSrcType.equals("H"))
	{
	qry="SELECT distinct nvl(EMPLOYEENAME,' ')FacultyName,nvl(EMPLOYEEID,' ')FacultyID,EMPLOYEECODE FacultyCode  FROM V#STAFF  WHERE  DEPARTMENTCODE IN (SELECT DEPARTMENTCODE  FROM HODLIST WHERE EMPLOYEEID='"+mChkMemID+"' AND  NVL(DEACTIVE,'N')='N') AND EMPLOYEEID IN (SELECT EMPLOYEEID FROM LEAVEREQUEST ) AND NVL(DEACTIVE,'N')='N' ORDER BY FacultyName "; 
	}
	else if(mSrcType.equals("I"))
	{
	qry="select distinct nvl(A.EMPLOYEEID,' ')FacultyID,nvl(A.EMPLOYEENAME,' ')FacultyName, ";
	qry=qry+" nvl(A.EMPLOYEECODE,' ')FacultyCode from EMPLOYEEMASTER A,LEAVEREQUEST B where A.EMPLOYEEID=B.EMPLOYEEID and B.EMPLOYEEID='"+mChkMemID+"'"; 
	}
	rs=db.getRowset(qry);
	%>
	<select name="FacultyID" tabindex=1 id="FacultyID"  >
	<%   	
	if(request.getParameter("x")==null)
	{	
		while(rs.next())
		{
		 	mFaculty=rs.getString("FacultyID");
			if(QryFaculty.equals(""))
			{
				QryFaculty=mFaculty;
			}
		 	mFacultyName=rs.getString("FacultyName");
			mFacultyCode=rs.getString("FacultyCode");
			%>
			<option value=<%=mFaculty%>><%=mFacultyName%>(<%=mFacultyCode%>)</option>
			<%
		}
	}
	else
	{
		while(rs.next())
		{
	   		mFaculty=rs.getString("FacultyID");
		   	mFacultyName=rs.getString("FacultyName");
		   	mFacultyCode=rs.getString("FacultyCode");
			if(mFaculty.equals(request.getParameter("FacultyID").toString().trim()))
			{
				%>
	   			<option selected value=<%=mFaculty%>><%=mFacultyName%>(<%=mFacultyCode%>)</option>
		  		<%
		  	}
			else
      		{
				%>
	   			<option value=<%=mFaculty%>><%=mFacultyName%>(<%=mFacultyCode%>)</option>
				<%
			}
		}
	}
	%>
	</select></td>
<!-- Leave year code -->
<td  nowrap><font color=black face=arial size=2><STRONG>Leave Year</STRONG>
	<%
qry="Select distinct NVL(A.LEAVEYEARCODE,' ')LEAVEYEARCODE, "; 
	qry=qry+" NVL(TO_CHAR(A.FROMDATE,'DD-MM-YYYY'),' ')FROMDATE, ";
	qry=qry+" NVL(TO_CHAR(A.TODATE,'DD-MM-YYYY'),' ')TODATE ";
	qry=qry+" FROM LEAVEYEAR A,LEAVEREQUEST B WHERE B.LEAVEYEARCODE=A.LEAVEYEARCODE AND B.EMPLOYEEID='"+mChkMemID+"' order by LEAVEYEARCODE desc ";

	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{	
		%>
		<select name="LeaveYear" tabindex=2 id="LeaveYear"  >
		<% 
		while(rs.next())
		{  
			mLeaveYearCode=rs.getString("LEAVEYEARCODE")+"***"+rs.getString("FROMDATE")+"###"+rs.getString("TODATE");	
			if(mLYC.equals(""))
			{
				mLYC=mLeaveYearCode;
			%>
			<option Value=<%=mLeaveYearCode%>><%=rs.getString("LEAVEYEARCODE")%></option>
			<%
			}
			else
			{
			%>
			<option Value=<%=mLeaveYearCode%>><%=rs.getString("LEAVEYEARCODE")%></option>
			<%
			}
		}
	}
	else
	{
		%>	
		<select name="LeaveYear"  id="LeaveYear" tabindex=2 >	
		<%
		while(rs.next())
		{
			mLeaveYearCode=rs.getString("LEAVEYEARCODE")+"***"+rs.getString("FROMDATE")+"###"+rs.getString("TODATE");	
		if(mLeaveYearCode.equals(request.getParameter("LeaveYear").toString().trim()))
			{
			%>
	    	<option selected value=<%=mLeaveYearCode%>><%=rs.getString("LEAVEYEARCODE")%></option>
			<%
		  	}
			else
      		{
				%>
		<option  value=<%=mLeaveYearCode%>><%=rs.getString("LEAVEYEARCODE")%></option>
				<%
			}
		}
	}
	%>
	</select></td>

<!--**Leave Code Combo**-->
	<td  nowrap><font color=black face=arial size=2><STRONG>Leave Code</STRONG>
	<%
	qry="Select distinct NVL(A.LEAVEDESCRIPTION,'')LeaveDesc, "; 
	qry=qry+" NVL(A.LEAVECODE,'')LeaveCode ";
	qry=qry+" FROM LEAVEMASTER A,LEAVEREQUEST B WHERE A.LEAVECODE=B.LEAVECODE order by LeaveDesc";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(request.getParameter("x")==null)
	{	
		%>
		<select name="LeaveDesc" tabindex=2 id="LeaveDesc"  >
		<option selected Value=ALL>ALL</option>
		<% 
		QryLeave="ALL";
		while(rs.next())
		{
	        mLeave=rs.getString("LeaveDesc");	
		 	mLeaveCode=rs.getString("LeaveCode");
			if(QryLeave.equals(""))
			{
				QryLeave=mLeaveCode;
			%>
			<option Value=<%=mLeaveCode%>><%=mLeave%>(<%=mLeaveCode%>)</option>
			<%
			}
			else
			{
			%>
			<option Value=<%=mLeaveCode%>><%=mLeave%>(<%=mLeaveCode%>)</option>
			<%
			}
		}
	}
	else
	{
		%>	
		<select name="LeaveDesc"  id="LeaveDesc" tabindex=2 >	
		<%
		if (request.getParameter("LeaveDesc").toString().trim().equals("ALL"))
 		{
			%>
	 		<OPTION selected value=ALL>ALL</option>
			<%
		}
		else
		{
			%>
			<OPTION value=ALL>ALL</option>
			<%
		}
		while(rs.next())
		{
		mLeave=rs.getString("LeaveDesc");
	   	mLeaveCode=rs.getString("LeaveCode");
		if(mLeaveCode.equals(request.getParameter("LeaveDesc").toString().trim()))
			{
			%>
		    	<option selected value=<%=mLeaveCode%>><%=mLeave%>(<%=mLeaveCode%>)</option>
			<%
		  	}
			else
      		{
				%>
				<option  value=<%=mLeaveCode%>><%=mLeave%>(<%=mLeaveCode%>)</option>
				<%
			}
		}
	}
	%>
	</select></td>
<!--**Leave Status Combo**-->
</tr>
<tr>
	<td nowrap><font color=black face=arial size=2><STRONG>Leave Status</STRONG>
	<select name="LvStatus" tabindex=3 ID="LvStatus"  >
		<%
		if(request.getParameter("x")==null)
		{
				mLvStatus="ALL";
		%>
				<OPTION Value=ALL selected>ALL</option>
				<OPTION Value=A>Approved</option>
				<OPTION Value=C>Canceled</option>
				<OPTION Value=D>Pending</option>
		<%
		}
		else
		{					if(request.getParameter("LvStatus").toString().trim().equals("ALL"))
		{
		%>
			<OPTION Value=ALL selected>ALL</option>
			<OPTION Value=A>Approved</option>
			<OPTION Value=C>Canceled</option>
			<OPTION Value=D>Pending</option>
		<%
		}
		else if (request.getParameter("LvStatus").toString().trim().equals("A"))
		{
		%>
	 		<OPTION Value=ALL>ALL</option>
			<OPTION Value=A selected>Approved</option>
			<OPTION Value=C>Canceled</option>
			<OPTION Value=D>Pending</option>
		<%
		}
		else if (request.getParameter("LvStatus").toString().trim().equals("C"))
		{
		%>
			<OPTION Value=ALL>ALL</option>
			<OPTION Value=A>Approved</option>
			<OPTION Value=C selected>Canceled</option>
			<OPTION Value=D>Pending</option>
		<%
		}
		else
		{
		%>	
			<OPTION Value=ALL>ALL</option>
			<OPTION Value=D selected>Pending</option>
			<OPTION Value=A>Approved</option>
			<OPTION Value=C>Canceled</option>
		<%
		}
		}
		%>
	</select></td>
	<td align=right><input style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 100px; HEIGHT: 23px; FONT-VARIANT: normal; cursor:hand; border-width:1;"  type=Submit tabindex=4 name="Show" value="Show/Refresh"  ></td></tr>
	</TABLE>
	</form>
	<%
	if(request.getParameter("x")!=null)
		{
		QryFaculty=request.getParameter("FacultyID").toString().trim();
		QryLeave=request.getParameter("LeaveDesc").toString().trim();
		mLvStatus=request.getParameter("LvStatus").toString().trim();
		LYC=request.getParameter("LeaveYear").toString().trim();

		}
	else
		{
		QryFaculty=QryFaculty;
		QryLeave=QryLeave;
		mLvStatus=mLvStatus;
		LYC=mLYC;
		}
			int len=LYC.length();
			int pos1=LYC.indexOf("***");
			int pos2=LYC.indexOf("###");
			mLC=LYC.substring(0,pos1);
			mLCFD=LYC.substring(pos1+3,pos2);
			mLCTD=LYC.substring(pos2+3,len);
	
	try
	{
	qry="Select Distinct nvl(A.EMPLOYEENAME,' ')STAFF,B.LEAVECODE ,B.EMPLOYEEID EMPLOYEEID,B.REQUESTID ";
	qry=qry+" RID,to_char(B.STARTDATE,'dd-mm-yyyy')SDATE, "; 
	qry=qry+" NVL(WORKFLOWCODE,' ')WORKFLOWCODE,NVL(WORKFLOWTYPE,' ')WORKFLOWTYPE, ";
	qry=qry+" nvl(to_char(B.ENDDATE,'dd-mm-yyyy'),'')EDATE,";
	qry=qry+" nvl(B.PAID,0)PAID, nvl(B.WITHOUTPAY,0)LWP,"; 
	qry=qry+"nvl(B.ABSENT,0)ABSENT,nvl(B.PURPOSEOFLEAVE,' ')POL,";
	qry=qry+" decode(B.STATUS,'A','Approved','C','Canceled','Pending')STATUS FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where "; qry=qry+"B.EMPLOYEEID='"+QryFaculty+"' and B.LEAVECODE=decode('"+QryLeave+"','ALL',B.LEAVECODE,'"+QryLeave+"') and nvl(STATUS,'D')=decode('"+mLvStatus+"','ALL',nvl(STATUS,'D'),'"+mLvStatus+"')";
	qry=qry+" and (trunc(STARTDATE) between  to_date('"+mLCFD+"','dd-mm-yyyy') and   to_date('"+mLCTD+"','dd-mm-yyyy') or trunc(ENDDATE) between  to_date('"+mLCFD+"','dd-mm-yyyy') and   to_date('"+mLCTD+"','dd-mm-yyyy') )";
	qry=qry+" and A.EMPLOYEEID=B.EMPLOYEEID  ORDER BY SDATE, EDATE ";
	
		rs=db.getRowset(qry);
		while(rs.next())
		{
			mStatus=rs.getString("STATUS");
			if(count==0)
			{
			%>
			<table  width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B><u>Available List</u> </B></TD>
			</font></td>	
			</table>
			<table class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center width=90%>
			<thead>
			<tr bgcolor="#ff8c00">
			<td align=left rowspan=2 nowrap><font color=white><B>Staff</B></font></td>
			<td align=center rowspan=2 nowrap><font color=white><B>Leave<br>Code</B></font></td>
			<td align=center nowrap colspan=2><font color=white><B>Period</B></font></td>
			<td align=center rowspan=2 nowrap><font color=white><B>No.of Days <br>
			Leave Applied</B></font></td>
			<td align=center rowspan=2 nowrap Title="See Approval Status"><b><font color="white"></font><font color="white">Status</font></b></td>
			</tr>
			<tr bgcolor="#ff8c00">
			<td align=center nowrap><font color=white><B>Start Date</B></font></td>
			<td align=center nowrap><font color=white><B>End Date</B></font></td>
			</tr>
			</thead>
			<%
			count++;	
			}
			%>
		<tbody>
		<tr>
		<td nowrap align=left><%=rs.getString("STAFF")%></font></td>	
		<td nowrap align=left><%=rs.getString("LEAVECODE")%></font></td>	
		<td nowrap align=center><%=rs.getString("SDATE")%></font></td>	
		<td nowrap align=center><%=rs.getString("EDATE")%></font></td>
		<%
		mpaid=rs.getDouble("PAID");
		mlwp=rs.getDouble("LWP");
		if(mpaid >=0 || mlwp >=0)
		{
		   mTotalDays=mpaid+mlwp;
		%>
		<td nowrap align=right><%=mTotalDays%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </font></td>	
		<%
		}
		if(mStatus.equals("Approved"))
		{
		%>
		<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Approved Leave" target=_New href='PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVECODE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=A'><FONT COLOR=GREEN><%=mStatus%></FONT></a></td>
		<%
		}
		else if(mStatus.equals("Pending"))	
		{
		%>
		<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Pending Leave" target=_New href='PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVECODE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=P'><FONT COLOR=BLUE><%=mStatus%></FONT></a></td>
		<%
		}
		else if(mStatus.equals("Canceled"))
		{
		%>
		<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s Canceled Leave" target=_New href='PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVECODE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=C'><FONT COLOR=RED><%=mStatus%></FONT></a></td>
		<%
		}
		else
		{
		%>
		<td nowrap>&nbsp;</td>
		<%
		}
		%>
		</tr>
		</tbody>
		<%
		}
		if(count==0)
		{
		if(request.getParameter("x")!=null)
			{
		%><CENTER><%
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <font size=3 face='Arial' color='Red'><b>No such record found...</b></font><br>");
		%></CENTER><%
			}
		}
		}//TRY END
		catch(Exception e)
		{
		//out.print("Exception "+e);
		}
	//-----------------------------
//---Enable Security Page Level  
//-----------------------------
}
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>  
   <%
}
//-----------------------------
}
else
{
	out.print("<br><img src='../../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
	//out.print("Exception "+e);
}
%>
</body>
</html>