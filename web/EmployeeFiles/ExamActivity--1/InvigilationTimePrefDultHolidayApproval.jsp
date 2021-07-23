<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 

<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rss=null,rsss=null,rsrs=null;
ResultSet rs1=null,RsChk1=null,rs3=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",qry1="",qry2="",mDutyHoliDay="";
String mComp="";
int mSno=0,mFlag=0,mFlag2=0;
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6=""; 
String mMemberID="";
String mDMemberID="",memp="",mEmpname="",mEname="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mtext="";
String mETime="",mFromTime="",mUptoTime="";
String mDate1="",mDate2="",mApproved="";
String mCurDate1="";
String mTmpTime1="",mType="";

String mpretimel="",mtotimel="";
String mTmpTime2="",mtotime="",mpretime="",mEntryby="",mFacid="";

qry="select to_Char(Sysdate-1,'dd-mm-yyyy') PrevDate, to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
String mPrevDate=rs.getString(1);
mCurDate1=rs.getString(2);

if (session.getAttribute("InstituteCode")==null)
{
	mInst="JIIT";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="UNIV";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Invigilation Time Pref./Duty Holiday ] </TITLE>
<script type="text/javascript" src="js/TimePicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />


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
<STYLE>
	input {			
			font-size:13px;
		}
</STYLE>
</HEAD>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	qry="Select WEBKIOSK.ShowLink('92','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
 //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table align=center width="100%" bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u><FONT SIZE=4>Invigilation Duty Time Prefernce (unavailability)/Duty Holiday (Approval)</FONT></u></b></font></td></tr>
</table>
<table cellpadding=2 cellspacing=0 align=center rules=groups border=3>
<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
		<%
		if (request.getParameter("x")!=null)
		{
			mDate1=mDate1=request.getParameter("TXT1").toString().trim();
			mDate2=request.getParameter("TXT2").toString().trim();
		}
		else
		{
			mDate1=mPrevDate;
			mDate2=mCurDate1;
		}
		%>
		&nbsp;&nbsp;
<!******************Date**************-->
<tr><td align=center>
<b>Leave on Invigilation Duty From <font size=1 color=teal>(DD-MM-YYYY)</font>&nbsp; 
<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> To 
<input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></b>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none;  HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Refresh" name=submit1>
</td></tr>
</table>
</form>
<table class="sort-table" id="table-1"  border=1 cellpadding=0 cellspacing=0 align=center>
<form name=frm1 action="InvigilationTimePrefDultHolidayApprovalAction.jsp" method=post>
	<thead>
	<tr bgcolor="#ff8c00">
	<td><font color=white size=2 face=arial><b>Approve</font></td>
	<td><font color=white size=2 face=arial><b>Invigilator Name</font></td>
	<td><font color=white size=2 face=arial><b>Exam Code</font></td>
	<td><font color=white size=2 face=arial><b>Req.Date</font></td>
	<td><font color=white size=2 face=arial><b>Preference/Duty Holiday-Date Time</font></td>
	<td><font color=white size=2 face=arial><b>Reason/Remarks</font></td>										
	<td><font color=white size=2 face=arial><b>Entry By</font></td>				
	<td Title="Click to Edit"><font color="White"><b>EDIT !</b></font></td>
	</tr>
	</thead>
	<tbody>
 <%
String mEmpName="";

		if(request.getParameter("x")!=null)
		{
			if (request.getParameter("TXT1")==null || request.getParameter("TXT1").equals(""))
				mDate1="**";
			else
				mDate1=request.getParameter("TXT1").toString().trim();
			if (request.getParameter("TXT2")==null || request.getParameter("TXT2").equals(""))
				mDate2="**";
			else
				mDate2=request.getParameter("TXT2").toString().trim();
		}
		if ((mDate1.equals("**") || GlobalFunctions.iSValidDate(mDate1)==true )&& (mDate2.equals("**") || GlobalFunctions.iSValidDate(mDate2)))
		{
		/*---------
			qry=" SELECT A.ExamCode ExamCode, to_Char(EntryDate,'dd-mm-yyyy') RFDT, to_char(PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(PRETODATE,'dd-mm-yyyy') || '( '||decode(DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(PREFFROMTIME,'hh:mi PM')||' to '|| to_char(PRETOTIME,'hh:mi PM'))||' )' Tim , nvl(REMARKS,' ') REMARKS, ";
			qry=qry+" to_char(prefromdate,'dd-mm-yyyy')prefromtime,to_char(pretodate,'dd-mm-yyyy')pretotime,";
			qry=qry+" nvl(EMPLOYEENAME,' ')EMPLOYEENAME,nvl(ENTRYBY,' ')EntryBy,NVL(INVIGILATORID,' ')INVIGILATORID,NVL(INVIGILATORTYPE,' ')INVIGILATORTYPE,nvl(APPROVED,'N')APPROVED FROM V#INVIGILATIONTIMEPREF "; 
			qry=qry+" Where INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'"; 
		    	qry=qry+" And ((TRUNC(PREFROMDATE) BETWEEN trunc(decode('"+mDate1+"','**',PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy')))) ";
			qry=qry+" OR (TRUNC(PRETODATE) BETWEEN trunc(decode('"+mDate1+"','**',PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy'))))) ";
		---------*/
			qry=" SELECT to_char(A.PREFFROMTIME,'hh:mi PM')FROMTIME, to_char(A.PRETOTIME,'hh:mi PM')TOTIME ,to_char(A.PREFROMDATE,'dd-mm-yyyy')PREFROMDATEL ,to_char(A.PRETODATE,'dd-mm-yyyy')PRETODATEL  , A.ExamCode ExamCode, to_Char(A.EntryDate,'dd-mm-yyyy') RFDT, to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , nvl(A.REMARKS,' ') REMARKS, ";
			qry=qry+" to_char(A.prefromdate,'dd-mm-yyyy')prefromtime,to_char(A.pretodate,'dd-mm-yyyy')pretotime,";
			qry=qry+" nvl(B.EMPLOYEENAME,' ')EMPLOYEENAME,nvl(A.ENTRYBY,' ')EntryBy,NVL(A.INVIGILATORID,' ')INVIGILATORID,NVL(A.INVIGILATORTYPE,' ')INVIGILATORTYPE,nvl(A.APPROVED,'N')APPROVED FROM INVIGILATIONTIMEPREF A, EMPLOYEEMASTER B "; 
			qry=qry+" Where A.INSTITUTECODE='"+mInst+"' and nvl(A.DEACTIVE,'N')='N'"; 
		    	qry=qry+" And ((TRUNC(A.PREFROMDATE) BETWEEN trunc(decode('"+mDate1+"','**',A.PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',A.PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy')))) ";
			qry=qry+" OR (TRUNC(A.PRETODATE) BETWEEN trunc(decode('"+mDate1+"','**',A.PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',A.PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy'))))) ";
		 	qry=qry+" AND A.INVIGILATORID=B.EMPLOYEEID AND   A.COMPANYCODE=B.COMPANYCODE union ";
		 	
			//rs=db.getRowset(qry);


			qry=qry+" SELECT to_char(A.PREFFROMTIME,'hh:mi PM')FROMTIME, to_char(A.PRETOTIME,'hh:mi PM')TOTIME ,  to_char(A.PREFROMDATE,'dd-mm-yyyy')PREFROMDATEL ,to_char(A.PRETODATE,'dd-mm-yyyy')PRETODATEL  , A.ExamCode ExamCode, to_Char(A.EntryDate,'dd-mm-yyyy') RFDT, to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , nvl(A.REMARKS,' ') REMARKS, ";
			qry=qry+" to_char(A.prefromdate,'dd-mm-yyyy')prefromtime,to_char(A.pretodate,'dd-mm-yyyy')pretotime,";
			qry=qry+" nvl(B.STUDENTNAME,' ')EMPLOYEENAME,nvl(A.ENTRYBY,' ')EntryBy,NVL(A.INVIGILATORID,' ')INVIGILATORID,NVL(A.INVIGILATORTYPE,' ')INVIGILATORTYPE,nvl(A.APPROVED,'N')APPROVED FROM INVIGILATIONTIMEPREF A, STUDENTMASTER B "; 
			qry=qry+" Where A.INSTITUTECODE='"+mInst+"' and nvl(A.DEACTIVE,'N')='N'"; 
		    	qry=qry+" And ((TRUNC(A.PREFROMDATE) BETWEEN trunc(decode('"+mDate1+"','**',A.PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',A.PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy')))) ";
			qry=qry+" OR (TRUNC(A.PRETODATE) BETWEEN trunc(decode('"+mDate1+"','**',A.PREFROMDATE,to_Date('"+mDate1+"','dd-mm-yyyy'))) ";
		 	qry=qry+" AND trunc(decode('"+mDate2+"','**',A.PRETODATE,to_Date('"+mDate2+"','dd-mm-yyyy'))))) ";
		 	qry=qry+" AND A.INVIGILATORID=B.STUDENTID AND NVL(A.INVIGILATORTYPE,'N')='S' ";
		 	qry=qry+" ORDER BY ExamCode, EmployeeName";
			rs=db.getRowset(qry);

			//out.print(qry);
			
			mSno=0;
			int kk=0;
			String mRemarks="";
			while(rs.next())
			{
			mSno++;
			kk++;	
			mRemarks=rs.getString("Remarks");
			mApproved=rs.getString("APPROVED");
			memp=rs.getString("INVIGILATORID");
			mpretime=rs.getString("prefromtime");
			mtotime=rs.getString("pretotime");
			mType=rs.getString("INVIGILATORTYPE");	
			mEname=rs.getString("EMPLOYEENAME");	

mpretimel=rs.getString("PREFROMDATEL");
			mtotimel=rs.getString("PRETODATEL");

			mName1="Approved_"+String.valueOf(kk).trim(); 
			mName2="EmployeeID_"+String.valueOf(kk).trim(); 
			mName3="Prefromtime_"+String.valueOf(kk).trim(); 				
			mName4="Totime_"+String.valueOf(kk).trim(); 				
			mName5="Type_"+String.valueOf(kk).trim(); 
			mName6="Ename_"+String.valueOf(kk).trim(); 

			if (rs.getString("Remarks").length()>30)
				mRemarks=mRemarks.substring(0,30)+"...";

			qry1="select trunc(sysdate)-to_date('"+mtotime+"','dd-MM-yyyy') from dual ";
			rs1=db.getRowset(qry1);
			rs1.next();
			long mSysCurrDiff=rs1.getLong(1);

			if(mSysCurrDiff >0)
			{
				String mColor="Red";
				if(mApproved.equals("N"))
				{
				%>
				<tr>
				<td><input type='checkbox' value='Y' ID='<%=mName1%>' Name='<%=mName1%>'disabled></td>
				<%	
				}
				else
				{
				%>
				<tr>
				<td><input type='checkbox' value='Y' ID='<%=mName1%>' Name='<%=mName1%>'disabled></td>
				<%
				}
			%>
				<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value='<%=memp%>'>
				<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value='<%=mpretime%>'>
				<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=mtotime%>'>
				<input type=hidden ID='<%=mName5%>' NAME='<%=mName5%>' value='<%=mType%>'> 
				<input type=hidden ID='<%=mName6%>' NAME='<%=mName6%>' value='<%=mEname%>'> 

				<td nowrap><font color=<%=mColor%>><%=rs.getString("EMPLOYEENAME")%></font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("ExamCode")%></font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("RFDT")%></font></td>					
				<td nowrap><font color=<%=mColor%>><%=rs.getString("TIM")%></font></td>
				<td><font color=<%=mColor%>><%=mRemarks%></font></td>
				<%
				mEntryby=rs.getString("EntryBy");
				mFacid=rs.getString("INVIGILATORID");
				
				if(mEntryby.equals(mFacid))
				{
				%>
					<td nowrap><font color=<%=mColor%>>&nbsp;SELF</font></td>	
				<%	
				}
				else
				{
				
					qry1="select guestname employeename from guest where guestid='"+mEntryby+"'";
					//out.print(qry1);
					rsrs=db.getRowset(qry1);
						if(rsrs.next())
					{
						mEmpName=rsrs.getString("employeename");
						mFlag=1;
					}
					else
					{
						qry1="select employeename from employeemaster where employeeid='"+mEntryby+"' ";
						rsrs=db.getRowset(qry1);
						if(rsrs.next())
						{
							mEmpName=rsrs.getString("employeename");
							mFlag=1;
						}

					}
					
					//out.print(mEmpName+"sdfasfds");
					if(mFlag==1)
					{
					%>
						<td nowrap><font color=<%=mColor%>>&nbsp;<%=mEmpName%></font></td>
					<%
					}
					else		
					{
						qry2="select studentname from studentmaster where studentid='"+mEntryby+"' ";
						rsss=db.getRowset(qry2);	
						if(rsss.next())
						{
						%>
							<td nowrap><font color=<%=mColor%>>&nbsp;<%=rsss.getString("studentname")%></font></td>	
						<%
						}
					}
				}

				 

		if(mApproved.equals("N"))
				{




				%>



				<td nowrap>
			<font color="BLUE" size=2><a target="NEW" title="Edit Invigilation Duty"  href="InvigilationTimePrefEditAll.jsp?ExamCode=<%=rs.getString("EXAMCODE")%>&amp;EmployeeId=<%=rs.getString("INVIGILATORID")%>&amp;EntryDate=<%=rs.getString("RFDT")%>&amp;EmpName=<%=rs.getString("EmployeeName")%>&amp;PREFROM=<%=rs.getString("PREFROMDATEL")%>&amp;PREFTO=<%=rs.getString("PRETODATEL")%>&amp;PREFROMT=<%=rs.getString("FROMTIME")%>&amp;PREFTOT=<%=rs.getString("TOTIME")%>"    > <b> Edit </b></a>
			</font></td>
			<%
				}
				else
				{
					%>
				<td nowrap>
			<font color="BLUE" size=2><b> Edit </b>
			</font></td>
			<%
				}
				%>

				</tr>
				<%
			} //closing of if(mSysCurrDiff >0)
			else
			{
				String mColor="Black";
				if(mApproved.equals("N"))
				{
				%>
				<tr>
				<td><input type='checkbox' value='Y' ID='<%=mName1%>' Name='<%=mName1%>'></td>
				<%	
				}
				else
				{
				%>
				<tr>
				<td><input type='checkbox' value='Y' ID='<%=mName1%>' Name='<%=mName1%>' checked></td>
				<%
				}
			%>
				<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value='<%=memp%>'>
				<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value='<%=mpretime%>'>
				<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value='<%=mtotime%>'>
				<input type=hidden ID='<%=mName5%>' NAME='<%=mName5%>' value='<%=mType%>'> 
				<input type=hidden ID='<%=mName6%>' NAME='<%=mName6%>' value='<%=mEname%>'> 

				<td nowrap><font color=<%=mColor%>><%=rs.getString("EMPLOYEENAME")%></font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("ExamCode")%></font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("RFDT")%></font></td>					
				<td nowrap><font color=<%=mColor%>><%=rs.getString("TIM")%></font></td>
				<td><font color=<%=mColor%>><%=mRemarks%></font></td>
				<%
				mEntryby=rs.getString("EntryBy");
				mFacid=rs.getString("INVIGILATORID");
				
				if(mEntryby.equals(mFacid))
				{
				%>
					<td nowrap><font color=<%=mColor%>>&nbsp;SELF</font></td>	
				<%	
				}
				else
				{
					qry1="select guestname employeename from guest where guestid='"+mEntryby+"'";
					
					rsrs=db.getRowset(qry1);
						if(rsrs.next())
					{
						mEmpName=rsrs.getString("employeename");
						mFlag2=1;
					}
					else
					{
						qry1="select employeename from employeemaster where employeeid='"+mEntryby+"' ";
						rsrs=db.getRowset(qry1);
						if(rsrs.next())
						{
							mEmpName=rsrs.getString("employeename");
							mFlag2=1;
						}

					}
					
					//out.print(mEmpName+"sdfasfds");
					if(mFlag2==1)
					{
					%>
						<td nowrap><font color=<%=mColor%>>&nbsp;<%=mEmpName%></font></td>
					<%
					}
					else		
					{
						qry2="select studentname from studentmaster where studentid='"+mEntryby+"' ";
						rsss=db.getRowset(qry2);	
						if(rsss.next())
						{
						%>
							<td nowrap><font color=<%=mColor%>>&nbsp;<%=rsss.getString("studentname")%></font></td>	
						<%
						}
					}
				}
				

				if(mApproved.equals("N"))
				{
				%>
				
			<td nowrap>
			<font color="BLUE" size=2><a target="NEW" title="Edit Invigilation Duty"  href="InvigilationTimePrefEditAll.jsp?ExamCode=<%=rs.getString("EXAMCODE")%>&amp;EmployeeId=<%=rs.getString("INVIGILATORID")%>&amp;EntryDate=<%=rs.getString("RFDT")%>&amp;EmpName=<%=rs.getString("EmployeeName")%>&amp;PREFROM=<%=rs.getString("PREFROMDATEL")%>&amp;PREFTO=<%=rs.getString("PRETODATEL")%>&amp;PREFROMT=<%=rs.getString("FROMTIME")%>&amp;PREFTOT=<%=rs.getString("TOTIME")%>"    > <b> Edit </b></a>
			</font></td>
			<%
				}
				else
				{
					%>
				<td nowrap>
			<font color="BLUE" size=2><b> Edit </b>
			</font></td>
			<%
				}


				%>
				</tr>
				<%
					mApproved="";
			} //closing of else of if(mSysCurrDiff >0)

			}  // closing of while
			%>
			<input type=hidden name=TotalRec id=TotalRec value='<%=kk%>'>
			<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
			<%
			//----------- closing of (request.getParameter("x")!=null)
			%>
			</tbody>
			<tr><td colspan=7 align=left>

			<input type="submit" name=btn1 value="Approved"></td></tr>
			</form>
			</table>
			<%
			
		}  // closing of date
		else
		{
			out.print("<img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Date Range </font> ");
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
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
  }      
}
catch(Exception e)
{
	//out.print("error"+qry);	
}
%>
</body>
</html>