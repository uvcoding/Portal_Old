<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="Green",mComp="",TRCOLOR="White",mWebEmail="";
String mMemberID="", mDMemberID="", mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="", mMemberName="";
String mInst="", myFlag="0";
String mFactType="";
int mChk=0;
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

String mTime="";
qry="Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime from Dual";
rs=db.getRowset(qry);
if (rs.next())
	mTime=rs.getString("mTime");
else
	mTime="";

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
  mHead=session.getAttribute("PageHeading").toString().trim();
else
  mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Alert/Message Window ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
   for (var i = 0; i < document.frm1.elements.length; i++) 
   {
	  var e = document.frm1.elements[i]; 
	  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
	  { 
	   e.checked = document.frm1.allbox.checked;
	  }
   }
}
</SCRIPT>
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
<script>
function openWindow( url )
{
  window.open(url, '_blank');
  window.focus();
}
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>


<center>
<!--<marquee direction="right" height="150" scrollamount="5" behavior="scroll" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee1"><img src="../../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/9.jpg"></marquee>
<marquee direction="righttoleft" height="25" width="102%" scrolldelay="50" scrollamount="5" behavior="scroll" loop="0" style="font-family:Verdana;font-size:25px;text-decoration:none;color:#FFFFFF;background-color:navy;" id="Marquee2"><STRONG>Site is Under Construction. Modules will open one by one after sometime.</STRONG></marquee>-->

<%
try
{

	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
		mDMemberID=enc.decode(mMemberID);
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		if(mDMemberType.equals("E"))
		{
			mFactType="I";
		}
		else
		{
			mFactType="E";
		}
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	   //-----------------------------
	   //-- Enable Security Page Level  
	   //-----------------------------


		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			
//	System.out.print("DFGDGFDGFDGSDGFGSDGDF");
	



qry="select to_char(TRANSDATETIME,'dd-mm-yyyy hh:mi:ss am')TRANSDATETIME  from (select * from LOGTRANSINFO  a where a.MEMBERID ='"+mChkMemID+"'  and a.TRANSTYPE='LASTLOGIN' AND A.TRANSDATETIME < SYSDATE  and a.TRANSDATETIME not in (select max(TRANSDATETIME) from LOGTRANSINFO where MEMBERID ='"+mChkMemID+"'  and TRANSTYPE='LASTLOGIN') ORDER BY A.TRANSDATETIME desc) where rownum<2";
rs=db.getRowset(qry);
if(rs.next())
{
	mTime=rs.getString("TRANSDATETIME");

}
%>

<p align=right>
<font color=darkbrown size=2 face='verdana'><b>Welcome , <%=mMemberName%> <!-- .You Last Visited the site on <%=mTime%> --></b></font>
</p>
<%


	if(mChkMemID.equals("UNIV-C00003")  || mChkMemID.equals("UNIV-M00004") )
			{
						String CurrDate="";
			qry="Select to_char(to_date(sysdate,'DD-MM-RRRR'),'dd-mm-rrrr')CurrDate from dual";
			
				rs1=db.getRowset(qry);
			if (rs1.next())
				 CurrDate=rs1.getString("CurrDate").toString().trim();
			
			%>
			<table align=center width=100% cellspacing=0 cellpadding=0 border=1>
			<tr bgcolor=orange>
				<td colspan=8 align=center><font color=white face=verdana size=2><b>Today's Birth Day </b></font></td>
				</tr>
				<tr bgcolor=orange>
				<td><font color=white face=verdana size=2><b>Employee</b></font></td>
				<td><font color=white face=verdana size=2><b>Designation/Dept</b></font></td>
				<td><font color=white face=verdana size=2><b>Date of Joining</b></font></td>
				<td><font color=white face=verdana size=2><b>Years in JIIT</b></font></td>
				<td><font color=white face=verdana size=2><b>Email-ID</b></font></td>
				<td><font color=white face=verdana size=2><b>Mobile No</b></font></td>					
				<td><font color=white face=verdana size=2><b>Wishes</b></font></td>
				</tr>		
			
			<%

			 qry1="select iNITCAP(a.employeename||'('||a.employeecode||')')EMPLOYEENAME,INITCAP('( '||b.designation||' ) '||d.department) AS DESIG_DEPTT,to_char(A.DATEOFJOINING,'dd-mm-yyyy')DATEOFJOINING,DATEOFBIRTH,round((months_between(SYSDATE,DATEOFJOINING)/12),2) AS YEARMONTHS_IN_JIIT,nvl(C.EMAILID,' ')EMAILID,nvl(C.MOBILE,' ')MOBILE from employeemaster a,DESIGNATIONMASTER b,departmentmaster d,EMPLOYEEADDRESS C where d.departmentcode = a.departmentcode AND A.DESIGNATIONCODE = B.DESIGNATIONCODE AND A.EMPLOYEEID = C.EMPLOYEEID(+) AND to_char(dateofbirth,'ddmm')= to_char(TO_DATE('"+CurrDate+"','DD-MM-YYYY'),'ddmm') and nvl(a.deactive,'N') = 'N'  and A.companycode IN ('UNIV','JPBS') order by department,a.gradecode";
			//out.print(qry1);
			rs=db.getRowset(qry1);
		
				while(rs.next() )
				{
					%>
					<tr bgcolor=lightblue >
					<td ><font color=black face=verdana size=2><b><%=rs.getString("EMPLOYEENAME")%> </b></font></td>
					<td><font color=black face=verdana size=2><b><%=rs.getString("DESIG_DEPTT")%> </b></td>
					<td nowrap><font color=black face=verdana size=2><b><%=rs.getString("DATEOFJOINING")%> </b></td>
					<td NOWRAP><font color=black face=verdana size=2><b><%=rs.getString("YEARMONTHS_IN_JIIT").toString().trim()%> </b></td>
						
					<td><font color=black face=verdana size=2><b><%=rs.getString("EMAILID")%> </b></td>
					<td><font color=black face=verdana size=2><b><%=rs.getString("MOBILE")%> </b></td>
					<td><font color=black face=verdana size=2><b>Happy Birth Day</b></font></td>
					</tr>
					<%
					
						mChk=1;
					//out.print(qry);
				}
			
			%>
		
			</table>

			<%
			if(mChk==0)
				{
				
				out.print("<center><font color=red face=verdana size=2 ><b>No Record Found!</b></font> </center>");
				
				}
			}


//////////////////////////////////////////////////////////////
////////Tax Declaration



String mSysdate="",mDateFrom="",mDateTo="",mFYear="",Panno="",mFREEZE="",mTimeOver="",mDaysLeft="",mStatus="";	
String mAssYear="",mTDSCode="";
		
		qry="SELECT to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR	,nvl(TDSCODE,' ')TDSCODE  ,(TOPERIOD-trunc(sysdate))DAYCOUNT	FROM TDS#PARAMETER where COMPANYCODE='"+mComp+"' and  trunc(SYSDATE) >= trunc(fromperiod)   and  trunc(SYSDATE) <= trunc(toperiod) ";
rs=db.getRowset(qry);
if(rs.next())
		{
		mDateFrom=rs.getString("FROMPERIOD");
		mDateTo=rs.getString("TOPERIOD");
		mStatus=rs.getString("STATUS");
		mAssYear=rs.getString("ASSESSMENTYEAR");
		mFYear=rs.getString("FINYEAR");
		mTDSCode=rs.getString("TDSCODE");
		mDaysLeft=rs.getString("DAYCOUNT");

		

qry1="select 'Y' from tds#parameter where  COMPANYCODE='"+mComp+"' and trunc(SYSDATE) >= trunc(fromperiod)   and  trunc(SYSDATE) <= trunc(toperiod)";
rs1=db.getRowset(qry1);
if(!rs1.next())
	mTimeOver="Y";
else
	mTimeOver="N";



 qry1="select nvl(FREEZE,'N')FREEZE  from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssYear+"' and EMPLOYEEID='"+mDMemberID+"' ";
rs1=db.getRowset(qry1);
if(rs1.next())
{
	mFREEZE=rs1.getString("FREEZE");
}
else
	{
		mFREEZE="X";
	}
%><br>

	
<hr>
	<p align=left><font face=arial size=2 >
		<UL>
			<LI>Please submit your investment details for income tax   between <b><u><%=mDateFrom%></u></b>  and <b><u><%=mDateTo%></u></b>  .
		</UL>
		</font>

	</p>

<p align=left><font face=arial color=red size=2 >
		<UL>
		<%
		if(mFREEZE.equals("X"))
		{
		%>
			<LI>
			You have not submitted your online investment details. Please fill up & submit the hard copy  to  Accounts department.
			<%
		}
		else if(mFREEZE.equals("N"))
		{
			%>
			<LI>Please submit your investment detail and take a print-out for submission
				Only <%=mDaysLeft%> days left
				<%
		}
	
		if(mTimeOver.equals("Y"))
		{	
				%>
		
			<LI>Sorry you have missed submission of investment declaration.  Please contact  
				Accounts department for the same.
				<%
		}
				%>

		</UL>
		</font>
		</p>
			<hr>


<%}


///////////////////////////////////////////////////////////






			String mGetPLRID="", mEmpType="", CurrRID="", RestRID="", mDiffPath="N", mDiffPathRID="";
			qry="select EMPLOYEETYPE EmpType from V#STAFF WHERE COMPANYCODE='"+mComp+"' AND EMPLOYEEID='"+mChkMemID+"' ";
			rs=db.getRowset(qry);
			if(rs.next())
			{
				mEmpType=rs.getString("EmpType");
			}



			qry="Select nvl(WEBKIOSK.GetPendingLeaveRequestID('"+mComp+"','"+mInst+"','LEAVE','"+mChkMemID+"','"+mEmpType+"'),'Zero') GetPLRID from dual";
			rs=db.getRowset(qry);		
			if(rs.next() && !rs.getString("GetPLRID").equals("Zero"))
			{
				mGetPLRID=rs.getString("GetPLRID");		
				int lenReq=0, lenDfPath=0, posReq=0, posDfPath=0;

	


				if(mGetPLRID.indexOf("#")>=0)
				{
					while(1==1)
					{
						lenReq=mGetPLRID.length();
						posReq=mGetPLRID.indexOf("#");
						CurrRID=mGetPLRID.substring(0,posReq);
						RestRID=mGetPLRID.substring(posReq+1,lenReq);
						mGetPLRID=RestRID;
						if(CurrRID.indexOf("=")>=0)
						{
							lenDfPath=CurrRID.length();
							posDfPath=CurrRID.indexOf("=");
							mDiffPathRID=CurrRID.substring(0,posDfPath);
							mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
							CurrRID=mDiffPathRID;
						}
						qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(B.EntryDate,'dd-mm-yyyy') RDATE,to_Char(B.STARTDATE,'dd-Mon-yyyy')SDATE, to_Char(B.ENDDATE,'dd-Mon-yyyy') EDate";
						qry=qry+" ,WORKFLOWCODE,WORKFLOWTYPE, nvl(B.APPROVEDSTATUS,' ') APPROVEDSTATUS FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where ";
						qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
						qry=qry+" And NVL(B.APPROVEDSTATUS,'D') not in ('A','C') and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY RequestID DESC";
					    	rs=db.getRowset(qry);
					
						if(rs.next())
						{
						
							if(myFlag.equals("0"))
							{
						      	myFlag="1";							
								%>
								<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>New/Pending Request(s) for Approval/Cancellation</B>
								<BR>
								<table bgcolor='#d3d3d3' border=1 bordercolor='#008080' class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
								<thead>
								<tr bgcolor='#cccc99'>
								<td align=left rowspan=2 nowrap>
								<font color=black face='Verdana' size=2><B>Request From (Member Name)</B></font>
								</td>
								<td align=center rowspan=2 nowrap><font color=black face='Verdana' size=2> <B>Leave<br>Code</B></font>
								</td>
								<td align=center nowrap>
								<font color=black face='Verdana' size=2><B>Request Date</B></font>
								</td>
								<td align=center nowrap Title="See Approval Status"><b><font color=black face='Verdana' size=2><b>View Status</b></font>
								</td>
								</tr>
								</thead>
								<tbody>
								<%
							}
							mSno++;
							%>
							<tr bgcolor="<%=TRCOLOR%>">
							<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" target="_NEW"  href='../HRMS/LeaveWF/LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN face=verdana><%=rs.getString("STAFF")%></FONT></a></td>
							<td nowrap align=Left><font face=verdana color=<%=mColor%>><%=rs.getString("LEAVE")%></font></td>
							<td nowrap align=center><font face=verdana color=<%=mColor%>><%=rs.getString("RDATE")%></font></td>
							<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target="_New" href='../HRMS/LeaveWF/PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=mDMemberID%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=<%=rs.getString("APPROVEDSTATUS")%>'><font color=blue face=verdana>View Remarks</font></a></td></tr>
							<%
						}				 
						if(mGetPLRID.indexOf("#")<0)
						{
							CurrRID=mGetPLRID;
							if(CurrRID.indexOf("=")>=0)
							{
								lenDfPath=CurrRID.length();
								posDfPath=CurrRID.indexOf("=");
								mDiffPathRID=CurrRID.substring(0,posDfPath);
								mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
								CurrRID=mDiffPathRID;
							}
							qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(nvl(B.EntryDate,sysdate),'dd-mm-yyyy') RDATE,to_Char(B.STARTDATE,'dd-Mon-yyyy')SDATE, to_Char(B.ENDDATE,'dd-Mon-yyyy') EDate,WORKFLOWCODE,WORKFLOWTYPE, nvl(B.APPROVEDSTATUS,'D') APPROVEDSTATUS";
							qry=qry+" FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where nvl(B.APPROVEDSTATUS,'D') not in ('C','A') and";
							qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
							qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY RequestID DESC";	 //out.print(qry);	
				    			rs=db.getRowset(qry);
							if(rs.next())
							{
								if(myFlag.equals("0"))
								{
								      myFlag="1";
									%>
									<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>New/Pending Request(s) for Approval/Cancellation</B>
									<BR>
									<table bgcolor='#d3d3d3' border=1 bordercolor='#008080' class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
									<thead>
									<tr bgcolor='#cccc99'>
									<td align=left rowspan=2 nowrap><font color=black face='Verdana' size=2><B>Request From (Member Name)</B></font></td>
									<td align=center rowspan=2 nowrap><font color=black face='Verdana' size=2><B>Leave<br>Code</B></font></td>
									<td align=center nowrap><font color=black face='Verdana' size=2><B>Request Date</B></font></td>
									<td align=center nowrap Title="See Approval Status"><b><font color=black face='Verdana' size=2><b>View Status</b></font></td>
									</tr>
									</thead>
									<tbody>
									<%
								}
								mSno++;
								%>
								<tr bgcolor="<%=TRCOLOR%>">
								<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" target="_NEW"  href='../HRMS/LeaveWF/LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN face=verdana><%=rs.getString("STAFF")%></FONT></a></td>
								<td nowrap align=Left><font face=verdana color=<%=mColor%>><%=rs.getString("LEAVE")%></font></td>
								<td nowrap align=center><font face=verdana color=<%=mColor%>><%=rs.getString("RDATE")%></font></td>
								<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target="_New" href='../HRMS/LeaveWF/PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=mDMemberID%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=<%=rs.getString("APPROVEDSTATUS")%>'><font color=blue face=verdana>View Remarks</font></a></td>
								</tr>
								<%
							}
							break;
						}
					}
				}
				else
				{
					CurrRID=mGetPLRID;
					if(CurrRID.indexOf("=")>=0)
					{
						lenDfPath=CurrRID.length();
						posDfPath=CurrRID.indexOf("=");
						mDiffPathRID=CurrRID.substring(0,posDfPath);
						mDiffPath=CurrRID.substring(posDfPath+1,lenDfPath);
						CurrRID=mDiffPathRID;
					}
					qry="Select Distinct '"+mDiffPath+"' DiffPath, B.RequestID RID, B.EMPLOYEEID EMPLOYEEID, nvl(A.EMPLOYEENAME,' ') STAFF, nvl(B.PURPOSEOFLEAVE,' ')POL, B.LeaveCode LEAVE, B.LeaveCode||' ('||C.LEAVEDESCRIPTION||')' LCODE, to_char(nvl(B.EntryDate,sysdate),'dd-mm-yyyy') RDATE,to_Char(B.STARTDATE,'dd-Mon-yyyy')SDATE, to_Char(B.ENDDATE,'dd-Mon-yyyy') EDate,WORKFLOWCODE,WORKFLOWTYPE, ";
					qry=qry+", nvl(B.APPROVEDSTATUS,' ')APPROVEDSTATUS, nvl(B.PAID,0)PAID, nvl(B.WITHOUTPAY,0)LWP, nvl(B.ABSENT,0)ABSENT FROM EMPLOYEEMASTER A, LEAVEREQUEST B, LEAVEMASTER C where ";
					qry=qry+" A.EMPLOYEEID=B.EMPLOYEEID and A.COMPANYCODE='"+mComp+"' and B.REQUESTID='"+CurrRID+"'";
					qry=qry+" and B.COMPANYCODE=C.COMPANYCODE and B.LEAVECODE=C.LEAVECODE ORDER BY REQUESTID DESC";
					//out.print(qry);
				    	rs=db.getRowset(qry);
					if(rs.next())
					{
						if(myFlag.equals("0"))
						{
						      myFlag="1";
							%>
							<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>New/Pending Request(s) for Approval/Cancellation</B>
							<BR>
							<table bgcolor='#d3d3d3' border=1 bordercolor='#008080' class="sort-table" id="table-1" border=1 leftmargin=0 cellpadding=0 cellspacing=0 align=center>
							<thead>
							<tr bgcolor='#cccc99'>
							<td align=left rowspan=2 nowrap><font color=black face='Verdana' size=2><B>Request From (Member Name)</B></font></td>
							<td align=center rowspan=2 nowrap><font color=black face='Verdana' size=2><B>Leave<br>Code</B></font></td>
							<td align=center nowrap><font color=black face='Verdana' size=2><B>Request Date</B></font></td>
							<td align=center nowrap Title="See Approval Status"><b><font color=black face='Verdana' size=2><b>View Status</b></font></td>
							</tr>
							</thead>
							<tbody>
							<%
						}
						mSno++;
						%>
						<tr bgcolor="<%=TRCOLOR%>">
						<td nowrap align=left><a Title="Click to Approve <%=rs.getString("STAFF")%>'s Leave Request" TARGET="_NEW" href='../HRMS/LeaveWF/LeaveRequestApprovalDetail.jsp?RID=<%=rs.getString("RID")%>&amp;DiffPath=<%=rs.getString("DiffPath")%>&amp;EID=<%=rs.getString("EMPLOYEEID")%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>'><FONT COLOR=GREEN face=verdana><%=rs.getString("STAFF")%></FONT></a></td>
						<td nowrap align=Left><font color=black face=verdana><%=rs.getString("LEAVE")%></font></td>
						<td nowrap align=center><font color=black face=verdana><%=rs.getString("RDATE")%></font></td>	
						<td nowrap align=left><a Title="Click to View <%=rs.getString("STAFF")%>'s UnApproved Leave Request" target="_New" href='../HRMS/LeaveWF/PendingLeaveRequestDetail.jsp?RID=<%=rs.getString("RID")%>&amp;WFC=<%=rs.getString("WORKFLOWCODE")%>&amp;WFT=<%=rs.getString("WORKFLOWTYPE")%>&amp;EID=<%=mDMemberID%>&amp;LEAVECODE=<%=rs.getString("LEAVE")%>&amp;DATEFROM=<%=rs.getString("SDATE")%>&amp;DATETO=<%=rs.getString("EDATE")%>&amp;POL=<%=rs.getString("POL")%>&amp;APRSTAT=<%=rs.getString("APPROVEDSTATUS")%>'><font color=blue face=verdana>View Remarks</font></a></td>
						</tr>
						<%
					}
				}
				%>
				</tbody>
				</table>
				<%
/*
   ====================================================================================
   Self Pending Message
   ====================================================================================
*/
				qry="Select B.LEAVECODE  LEAVECODE ,B.REQUESTID RID ";
				qry=qry+" ,to_char(nvl(B.EntryDate,sysdate),'dd-mm-yyyy')SDATE, "; 
				qry=qry+" decode(B.STATUS,'A','Approved','C','Cancelled','Pending')STATUS ";
				qry=qry+" FROM  LEAVEREQUEST B where "; 
				qry=qry+" B.EMPLOYEEID='"+mDMemberID+"' And nvl(READFLAG,'N')='N' ";
				qry=qry+" ORDER BY SDATE";
				rs=db.getRowset(qry);
				mSno=0;
//  -----------------------------------
// 
//  For New/Message 		
// 
//  -----------------------------------
				%><br><%
				myFlag="0";
				while (rs.next())
				{
					if(myFlag.equals("0"))
					{
						myFlag="1";
						%>
				 		<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Approval/Cancellation status of my Request(s)</B>
						<table border=1 bordercolor='silver' bgcolor='white'  cellpadding=0 cellspacing=0 width='50%'>
						<tr bgcolor='Green'>
						<td><FONT COLOR=WHITE face=verdana size=2><B>Leave</b></font></td>
						<td><FONT COLOR=WHITE face=verdana size=2><B>Req. ID</b></font></td>
						<td><FONT COLOR=WHITE face=verdana size=2><B>Req. Date</b></font></td>
						<td><FONT COLOR=WHITE face=verdana size=2><B>Status</b></font></td>
						</tr>
						<%
					}
					%>
					<tr>
					<td> &nbsp; <Font face=verdana size=2><%=rs.getString("LEAVECODE")%></font></td>
					<td> &nbsp; <A Title="Click to View Leave Request" target="_New" href='../HRMS/LeaveWF/LeaveRequestReadFirstTime.jsp?RID=<%=rs.getString("RID")%>'><FONT COLOR=BLUE face=verdana size=2><%=rs.getString("RID")%></FONT></a>
					<td> &nbsp; <font face=verdana size=2><%=rs.getString("SDATE")%></font></td>
					<td> &nbsp; <font face=verdana size=2><%=rs.getString("STATUS")%></font></td>
					</tr>	
					<%
				}
				%>
				</table>



	

				<%
/*
   ====================================================================================
   Get Information Message regarding the Leave Approval/Cancellation
   ====================================================================================
*/
				qry="Select COUNT(*) from MESSAGEFORME where MEMBERID='"+mDMemberID+"' and MEMBERTYPE='"+mFactType+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mInst+"' AND nvl(MSGFLAG,'N')='N' AND nvl(DEACTIVE,'N')='N' GROUP BY MEMBERID, MEMBERTYPE, COMPANYCODE, INSTITUTECODE";
				rs=db.getRowset(qry);
				out.print(qry);
				%><br><%
				if(rs.next())
				{
					%>
			 		<font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Information Message Regarding Others Approval/Cancellation Request(s)</B>
					<table border=0 bordercolor='silver' cellpadding=0 cellspacing=0>
					<tr><td nowrap><FONT COLOR=Blue face=verdana size=2><B>You have <%=rs.getInt(1)%> new information message to view</b></font></td></tr>
					<tr><td align=center><a target=_new href="../HRMS/GetInfoMessage.jsp"><img src='../../Images/ClickHere.gif'></a></td></tr>
					</table>
					<%
				}
/*
  =================================================================================
  =================================================================================

*/



}

/* ====================================================================================
  Get Information Message from INBOX
 ====================================================================================
*/
int nonewfmsg=0;
qry=" SELECT count(*) FROM MESSAGESLIST Where  INSTITUTECODE='"+mInst+"' And MSGTOUSERD='"+ mDMemberID+"' And MSGTOMEMBERTYPE='E' And ReadLastTime='N' And nvl(DEACTIVE,'N')='N'";				
rs=db.getRowset(qry);
if (rs.next())
   nonewfmsg=rs.getInt(1);

qry=" SELECT count(*) FROM MESSAGESLIST Where  INSTITUTECODE='"+mInst+"' And MSGTOUSERD='"+ mDMemberID+"' And MSGTOMEMBERTYPE='E' And nvl(DEACTIVE,'N')='N'";				

rs=db.getRowset(qry);
%><br><%
	if(rs.next() && rs.getInt(1)>=1)
		{
		
			%>
	 		<font color="#a52a2a" size=2 face='Verdana'><B>my INBOX/Message</B>
			<table border=0 bordercolor='silver' cellpadding=0 cellspacing=0>
			<tr><td nowrap><FONT COLOR=Blue face=verdana size=2><B>You have <%=nonewfmsg%> new information message to view</b></font></td></tr>
			<tr><td align=center><a target=_new href="../../CommonFiles/GetINBOXMessage.jsp"><img src='../../Images/ClickHere.gif'></a></td></tr>
			</table>
			<%
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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}  
}
catch(Exception e)
{
 
}

%>
<br><br><br><br><br><br><br><br><br><br><br><br>
<table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small;border-spacing:1px;border-style:outset;border-color:grey" align=center bordercolor="grey">
                    <TR bgcolor=white>
                    <td>				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A style="color: white"  href="http://www.campuslynx.in" target=new  color=white><IMG align=center src="../../Images/CampusLynx.png" style="border-color: white">
					</A><br><FONT size =2 style="FONT-FAMILY: ARIal"><b>&nbsp;Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =1 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution&nbsp;</FONT>
					</td><td>
					<FONT size =1 color=BLACK>&nbsp;Software developed and maintained by </font><br>
					<STRONG>&nbsp;<A HREF="http://www.jilit.co.in" target=new><FONT SIZE="2" COLOR="BLACK">JIL Information Technology Ltd.</FONT></A>&nbsp;</STRONG></FONT>
					</td>
					</tr>
					</table><table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small;border-spacing:1px;border-style:outset;border-color:grey" align=center bordercolor="grey">
				    <TR bgcolor=white><td><FONT size =1 color=BLACK>&nbsp;For your comments or suggestions please send an email at	 <A tabIndex=8 href="campus.support@jalindia.co.in">&nbsp;<FONT SIZE="1" COLOR="blue">campus.support@jalindia.co.in</FONT></A></FONT></td></TR>
				    </table>     
</body>
</Html>
