<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
ResultSet rs1=null,rss=null,RsChk1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",mDutyHoliDay="";
String mComp="";
int mSno=0;
String mEmpType="TEC";
String mExam="",mexam="",qryexam=""; 
String mFacultyName="",mFaculty="",QryFaculty="";
String EQryFaculty="", EQryFacultyType="", QryFacultyType="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="",mtext="";
String mETime="",mFromTime="",mUptoTime="";
String mDate1="",mDate2="";
String mCurDate1="";
String mTmpTime1="";
String mTmpTime2="";
String AprStatus="";
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurDate1=rs.getString(1);

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


function ChangeOptions(TEXT)
{
	TEXT.value='';
}
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
		qry="Select WEBKIOSK.ShowLink('107','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
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

 //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table align=center width="100%" bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u><FONT SIZE=4>Leave/Time Prefernce on Invigilation Duty [By HOD]</FONT></u></b></font></td></tr>
</table>
<table cellpadding=2 cellspacing=0 width="100%" align=center rules=groups border=3>

<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>

<!--*********ExamCode**********-->
<tr><td><FONT color=black face=Arial size=2><b>Event Exam Code </b></FONT>
<%
qry="Select Distinct nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM ,EXCLUDEINATTENDANCE ";
qry=qry+" from EXAMMASTER Where nvl(Deactive,'N')='N' ";
qry=qry+" and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEININVIGDUTYSEATPLAN,'N')='N' ";
qry=qry+" order by EXAMPERIODFROM DESC ";
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(TEXT);" onChange="ChangeOptions(TEXT);">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
			%>
			<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%
			}
			else
			{
			%>
			<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
			<%

			}
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px" onclick="ChangeOptions(TEXT);" onChange="ChangeOptions(TEXT);">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
				%>
				<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
		      	<%			
		   	}
		}
		%>
		</select>
	  	<%
	}
%>
<font color=black face=arial size=2><STRONG>&nbsp;&nbsp;Invigilator&nbsp;</STRONG>
<%
	qry="select distinct nvl(EMPLOYEEID,' ')Faculty, nvl(EMPLOYEENAME,' ')FacultyName from EMPLOYEEMASTER where EMPLOYEETYPE in '"+mEmpType+"' and";
	qry=qry+" DEPARTMENTCODE in (select DEPARTMENTCODE from hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N')";
	qry=qry+" union select distinct nvl(A.STAFFID,' ')Faculty, nvl(B.STUDENTNAME,' ')FacultyName";
	qry=qry+" from OTHERSTAFFLOADTAGGING A, STUDENTMASTER B where A.STAFFID=B.STUDENTID";
	qry=qry+" union select distinct nvl(A.STAFFID,' ')Faculty, nvl(B.EMPLOYEENAME,' ')FacultyName";
	qry=qry+" from OTHERSTAFFLOADTAGGING A, EMPLOYEEMASTER B where A.STAFFID=B.EMPLOYEEID order by FacultyName";
	//out.print(qry);

	rs=db.getRowset(qry);
	%>
	<select name="Faculty" tabindex="0" id="Faculty" style="WIDTH: 230px" >
	<%   	
	if(request.getParameter("x")==null)
	{	
		QryFaculty="ALL";
		while(rs.next())
		{
		 	mFaculty=rs.getString("Faculty");
		 	mFacultyName=rs.getString("FacultyName");
			%>
				<option value=<%=mFaculty%>><%=mFacultyName%></option>
			<%
			
		}
	}
	else
	{
		while(rs.next())
		{
	   		mFaculty=rs.getString("Faculty");
		   	mFacultyName=rs.getString("FacultyName");
		   	if(mFaculty.equals(request.getParameter("Faculty").toString().trim()))
			{
			   QryFaculty=mFaculty;
			   %>
	    			<option selected value=<%=mFaculty%>><%=mFacultyName%></option>
		  	   <%
		  	}
			else
      		{		
	   		   %>
	    			<option  value=<%=mFaculty%>><%=mFacultyName%></option>
	   		   <%
		}	
	}
}
%>
</select></td></tr>
<tr><td>
<%
	if (request.getParameter("x")!=null)
	{
		mDate1=mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();
	}
	else
	{
		mDate1=mCurDate1;
		mDate2=mCurDate1;
	}

	if(request.getParameter("x")==null)
	{
		mTmpTime1="09:00 am";
		mTmpTime2="08:00 pm";
	}
	else
	{
		mTmpTime1=request.getParameter("timepicker1");
		mTmpTime2=request.getParameter("timepicker2");
	}
%>
<!******************Date**************-->
<b>Duty From &nbsp; 
<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> to 
<input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></b>
<font size=2 color=teal>(Valid Date Format - DD-MM-YYYY)</font> </td></tr>

<tr valign=bottom><td valign=bottom>
<table align=center width=100% border=1><tr><td valign=middle>
<STRONG><FONT color=black face=Arial size=2><input id="DutyHoliday" name="DutyHoliday" Type=Radio value="N" checked> Not available for Invg. Duty From </FONT></STRONG>
<input id='timepicker1' name='timepicker1' type='text' value='<%=mTmpTime1%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker1)" STYLE="cursor:hand">
<STRONG><FONT color=black face=Arial size=2> To </FONT></STRONG>
<input id='timepicker2' name='timepicker2' type='text' value='<%=mTmpTime2%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker2)" STYLE="cursor:hand">
</td></tr>
<tr><td><input id="DutyHoliday" name="DutyHoliday" Type=Radio value="Y"><STRONG><FONT color=black face=Arial size=2>Duty Holiday (Full day duty denied)</strong></font>
</td></tr></table>
</td>
</tr>
<%
	if(request.getParameter("x")==null)
	{
		mtext="";
	}
	else
	{
		mtext=request.getParameter("TEXT").toString().trim();
	}
	if(request.getParameter("x")==null)
	{
		QryFaculty="";
	}
	else
	{
		QryFaculty=request.getParameter("Faculty").toString().trim();
		EQryFaculty=enc.encode(QryFaculty);
		qry="select ORATYP from MemberMaster where ORAID='"+EQryFaculty+"'";
		rs= db.getRowset(qry);		  
		if (rs.next())
		{
			EQryFacultyType=rs.getString(1);
			QryFacultyType=enc.decode(EQryFacultyType);
		}
	}
%>
<tr><td colspan=2><b>Reason/Remarks (Maximum 250 Characters) </b><br>	
	<TextArea Name='TEXT' Id='TEXT' maxlength=250 cols=68 rows=3>
	</TextArea>
<FONT color=red>*</FONT>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Save" name=submit1></td></tr>
</table>
<%	
	if(request.getParameter("x")!=null)
	{
		mDutyHoliDay=request.getParameter("DutyHoliday").toString();
		mExam=request.getParameter("Exam").toString();
		if (request.getParameter("TXT1")!=null)
			mDate1=request.getParameter("TXT1").toString().trim();
		else
			mDate1="";
		if (request.getParameter("TXT2")!=null)
			mDate2=request.getParameter("TXT2").toString().trim();
		else
			mDate2="";
	
		  if (mDate1.length()==10 && mDate2.length()==10  &&  GlobalFunctions.iSValidDate(mDate1)==true && GlobalFunctions.iSValidDate(mDate2))
		  {
			mFromTime=request.getParameter("timepicker1").toString().trim().toUpperCase();
			mUptoTime=request.getParameter("timepicker2").toString().trim().toUpperCase();
			qry="Select WEBKIOSK.IsValidTimeFormat('"+mFromTime+"') Time1, WEBKIOSK.IsValidTimeFormat('"+mUptoTime+"') Time2  from dual";
			RsChk1= db.getRowset(qry);
			//out.print(qry);
			//If Valid Time
			if ((mDutyHoliDay.equals("Y")) || (mDutyHoliDay.equals("N") && mFromTime.length()>=6 && mUptoTime.length()>=6 && RsChk1.next() && RsChk1.getString("Time1").equals("Y") && RsChk1.getString("Time2").equals("Y")))
			{						  
				mFromTime=mDate1+" "+mFromTime;
				mUptoTime=mDate1+" "+mUptoTime;
				String mStaffType="I";
				if(QryFacultyType.equals("E")) 
					mStaffType="I" ;
				else if(QryFacultyType.equals("S"))
					mStaffType="S";
				else
					mStaffType="E";
				if(!mtext.equals(""))
				{
					mtext=GlobalFunctions.replaceSignleQuot(mtext);
					qry=" SELECT 'Y' FROM INVIGILATIONTIMEPREF ";
   					qry=qry+" Where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' ";
					//qry=qry+" and EXAMCODE='"+qryexam+"'";
   					qry=qry+" And INVIGILATORID=Decode('"+QryFaculty+ "','ALL',INVIGILATORID,'"+QryFaculty+"') and ( trunc(to_date('"+mDate1+"','dd-mm-yyyy')) between trunc(PREFROMDATE) and trunc(PRETODATE) or trunc(to_date('"+mDate2+"','dd-mm-yyyy')) between trunc(PREFROMDATE) and trunc(PRETODATE) )";
					//out.print(qry);
					rs= db.getRowset(qry);		  
					if (!rs.next())
					{
				 		try
					 	{
    							if (mDutyHoliDay.equals("Y"))
							{
					 			qry="INSERT INTO INVIGILATIONTIMEPREF (INSTITUTECODE, COMPANYCODE, EXAMCODE,  INVIGILATORTYPE, INVIGILATORID, PREFROMDATE,  PRETODATE, DUTYHOLIDAY, REMARKS,ENTRYBY, ENTRYDATE) ";
				 				qry=qry+" VALUES ('"+mInst+"','"+mComp+"','"+mExam+"','"+mStaffType+"','"+QryFaculty+"',to_date('"+mDate1+"','dd-mm-yyyy'),to_date('"+mDate2+"','dd-mm-yyyy'),'Y','"+mtext+"','"+mDMemberID+"',SYSDATE)";
							}
							else
							{
						 		qry="INSERT INTO INVIGILATIONTIMEPREF (INSTITUTECODE, COMPANYCODE, EXAMCODE,  INVIGILATORTYPE, INVIGILATORID, PREFROMDATE,  PRETODATE, DUTYHOLIDAY, PREFFROMTIME, PRETOTIME, REMARKS,ENTRYBY, ENTRYDATE) ";
						 		qry=qry+" VALUES ('"+mInst+"','"+mComp+"','"+mExam+"','"+mStaffType+"','"+QryFaculty+"',to_date('"+mDate1+"','dd-mm-yyyy'),to_date('"+mDate2+"','dd-mm-yyyy'),'N',To_date('"+mFromTime+"','dd-mm-yyyy hh:mi PM'), To_date('"+mUptoTime+"','dd-mm-yyyy hh:mi PM'),'"+mtext+"','"+mDMemberID+"',SYSDATE)";
							}
							int n=db.insertRow(qry);
							if(n>0)
								out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>Invig. Duty Time Pref. saved successfully...</font> <br>");
		   // Log Entry
  		   //-----------------
			db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"INVIGILATION DUTY HOLIDAY BY HOD LOGIN", "Date from : "+mDate1+" to "+ mDate2+" INVGTYP : "+ mStaffType+" INVGID : "+ QryFaculty, "No MAC Address" , mIPAddress);
		   //-----------------
       					}
		      	 		catch(Exception e){}
					}
					else	
					{
						out.print("<img src='../../Images/Error1.jpg'>");
						out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Duty Holiday / Time Preference already requested...</font> <br>");
					}
				}
				else
				{
					out.print("<img src='../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Reason/Remarks for Duty Holiday / Time Preference can't be empty...</font> <br>");
				}	
			}
			else
			{
				out.print("<img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Time Period </font> <br>");
 			}
		}
	  	else
		{
			out.print("<img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Date Period </font> <br>");
		}		
	}  //----------- closing of (request.getParameter("x")!=null)
	//else

	// Show Table in all cases
	qry=" SELECT nvl(B.EMPLOYEENAME,' ')INVIGILATORID, to_Char(A.EntryDate,'dd-mm-yyyy') RFDT,";
	qry=qry+" to_char(A.PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(A.PRETODATE,'dd-mm-yyyy') || '( '||decode(A.DUTYHOLIDAY,'Y','Full Day Leave/Holiday',";
	qry=qry+" to_char(A.PREFFROMTIME,'hh:mi PM')||' to '|| to_char(A.PRETOTIME,'hh:mi PM'))||' )' Tim , nvl(A.REMARKS,' ') REMARKS, nvl(A.APPROVED,'N')APPROVED";
	qry=qry+" FROM INVIGILATIONTIMEPREF A, EMPLOYEEMASTER B WHERE A.INVIGILATORID=B.EMPLOYEEID AND"; 
	qry=qry+" A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+qryexam+"'"; 
	qry=qry+" and B.DEPARTMENTCODE in (select DEPARTMENTCODE from hodlist where employeeid='"+mChkMemID+"' and nvl(deactive,'N')='N')";
	//qry=qry+" And A.INVIGILATORID='"+QryFaculty+"' 
	qry=qry+" AND to_date(A.PRETODATE,'dd-mm-yyyy')>=to_date(sysdate,'dd-mm-yyyy') and nvl(A.DEACTIVE,'N')='N' order by A.PREFROMDATE";
    	rs= db.getRowset(qry);
	//out.print(qry);
	%>
	<table class="sort-table" id="table-1"  width='100%' border=1 cellpadding=0 cellspacing=0 align=center>
		<thead>
			<tr bgcolor="#ff8c00">
				<th><font color=white>SNo</font></th>
				<th><font color=white>Req. Date</font></th>	
				<th><font color=white>Preference/Duty Holiday - Date Time</font></th>
				<th><font color=white>Reason/Remarks</font></th>										
				<th><font color=white>Approved?</font></th>					
				<th><font color=white>Invigilator</font></th>					
			</tr>
		</thead>
		<tbody>
		<%
	mSno=0;
	String mRemarks="";
	while (rs.next())
	{
		mSno++;
		mRemarks=rs.getString("Remarks");
		String mRemarks1="";
		if (rs.getString("Remarks").length()>25)
		mRemarks1=mRemarks.substring(0,25)+"...";
		else
		mRemarks1=mRemarks;	
		String mColor="Black";
		if(rs.getString("APPROVED").equals("Y"))
		{
			mColor="DarkGreen";
			AprStatus="Yes";
		}
		else
		{
			mColor="Black";
			AprStatus="No";
		}
		%>
			<tr>
				<td nowrap><font color=<%=mColor%>><%=mSno%>.</font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("RFDT")%></font></td>					
				<td nowrap><font color=<%=mColor%>><%=rs.getString("TIM")%></font></td>
				<td nowrap title="<%=mRemarks%>"><font color=<%=mColor%>><%=mRemarks1%></font></td>
				<td nowrap align=center><font color=<%=mColor%>><%=AprStatus%></font></td>
				<td nowrap><font color=<%=mColor%>><%=rs.getString("INVIGILATORID")%></font></td>
			</tr>
		<%
	}
		%>
		</tbody>
		</table>
			
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
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	//out.print("Catch Block");	
}
%>
</form>
</body>
</html>