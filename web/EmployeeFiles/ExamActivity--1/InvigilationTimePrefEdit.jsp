<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null;
ResultSet rs1=null,rss=null,RsChk1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",mDutyHoliDay="";
String mComp="";
int mSno=0;
String mExam="",mexam="",qryexam=""; 
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

if (session.getAttribute("LoginComp")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("LoginComp").toString().trim();
}
//out.print(mComp);
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
<TITLE>#### <%=mHead%> [ Edit Invigilation Time Pref./Duty Holiday ] </TITLE>
<script type="text/javascript" src="js/TimePicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<script language="JavaScript" type ="text/javascript">

</script>
<script language=javascript>
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
if(!mMemberID.equals("") && !mMemberCode.equals(""))
	{	OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('91','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		// For Log Entry Purpose
//--------------------------------------
String mLogEntryMemberID="",mLogEntryMemberType="";


String mExamCode="",EntryDate="",mPrefFromdate="",mPrefToDate="",mPrefFromTime="",mPrefToTime="";
String mDutyHoliday="";
String  mPrefFromDate1="",mPrefToDate2="",mchecked="",mchecked1="",mRemarks="";

if(request.getParameter("ExamCode")==null)
	mExamCode="";
else
	mExamCode=request.getParameter("ExamCode").toString().trim();

if(request.getParameter("EntryDate")==null)
	EntryDate="";
else
	EntryDate=request.getParameter("EntryDate").toString().trim();

qry="SELECT INSTITUTECODE, COMPANYCODE, EXAMCODE,    INVIGILATORTYPE, INVIGILATORID,nvl(to_char(PREFROMDATE,'dd-mm-yyyy'),' ')PREFROMDATE,nvl(to_char(PRETODATE,'dd-mm-yyyy'),' ')PRETODATE, nvl(DUTYHOLIDAY,'N')DUTYHOLIDAY,  nvl(to_char(PREFFROMTIME,'hh:mi PM'),' ')PREFFROMTIME, nvl(to_char(PRETOTIME,'hh:mi PM'),' ')PRETOTIME, nvl(to_char(PREFFROMTIME,'DD-MM-YYYY'), ' ')PREFFROMTIMEDATE, nvl(to_char(PRETOTIME,'DD-MM-YYYY'),' ')PRETOTIMEDATE, NVL(REMARKS,'N')REMARKS, APPROVED,    ENTRYBY, ENTRYDATE, APPROVEDBY,    APPROVEDDATE, DEACTIVE FROM INVIGILATIONTIMEPREF WHERE INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' AND INVIGILATORID='"+mChkMemID+"' and EXAMCODE='"+mExamCode+"' AND TO_CHAR(entrydate,'DD-MM-YYYY')='"+EntryDate+"' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mPrefFromdate=rs.getString("PREFROMDATE").toString().trim();
	mPrefToDate=rs.getString("PRETODATE").toString().trim();
	

	mPrefFromDate1=rs.getString("PREFFROMTIMEDATE").toString().trim();
	mPrefToDate2=rs.getString("PRETOTIMEDATE").toString().trim();

	mPrefFromTime=rs.getString("PREFFROMTIME").toString().trim();
	mPrefToTime=rs.getString("PRETOTIME").toString().trim();

	mDutyHoliday=rs.getString("DUTYHOLIDAY").toString().trim();

	mRemarks=rs.getString("REMARKS").toString().trim();
}
//out.print("ss");
%>
<form name="frm"  method="get" >
<input id="ExamCode" name="ExamCode" value="<%=mExamCode%>" type=hidden>
<input id="EntryDate" name="EntryDate" value="<%=EntryDate%>" type=hidden>

<input id="x" name="x" type=hidden>
<table align=center width="100%" bottommargin=0 topmargin=0>
 <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b><u><FONT SIZE=4>Edit Leave/Time Prefernce on Invigilation Duty [Self]</FONT></u></b></font></td></tr>
</table>
<table cellpadding=2 cellspacing=0 width="100%" align=center rules=groups border=3>

<!*********--Institute--************>
<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>

<!--*********ExamCode**********-->
<tr><td><FONT color=black face=Arial size=2><b>Event Exam Code </b></FONT>
<INPUT TYPE="text" NAME="Exam" ID="Exam" readonly value="<%=mExamCode%>">


<%


if(!mDutyHoliday.equals("Y"))
{
	
	mchecked="checked";
	if (request.getParameter("x")!=null)
	{
		mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();

	}
	else
	{
	mDate1=mPrefFromdate;
		mDate2=mPrefToDate;
	}
}
else
{
    mchecked1="checked";
	if (request.getParameter("x")!=null)
	{
		mDate1=request.getParameter("TXT1").toString().trim();
		mDate2=request.getParameter("TXT2").toString().trim();

	}
	else
	{
		mDate1=mPrefFromdate;
		mDate2=mPrefToDate;
	}
}



if(request.getParameter("x")==null)
	{
		mTmpTime1=mPrefFromTime;
		mTmpTime2=mPrefToTime;
	}
	else
	{
		mTmpTime1=request.getParameter("timepicker1");
		mTmpTime2=request.getParameter("timepicker2");
	}
	


%>
&nbsp;&nbsp;
<!******************Date**************-->
<FONT color=black face=Arial size=2><b>Duty From &nbsp; 
<input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>'> to 
<input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10></b>
<font size=1 color=teal>(DD-MM-YYYY)</font> </td></tr>
<tr valign=bottom><td valign=bottom>
<table align=center width=100% ><tr><td valign=middle>
<STRONG><FONT color=black face=Arial size=2><input id="DutyHoliday" name="DutyHoliday" Type=Radio value="N" <%=mchecked%>> Not available for Invg. Duty From </FONT></STRONG>
<input id='timepicker1' name='timepicker1' type='text' value='<%=mTmpTime1%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker1)" STYLE="cursor:hand">
<STRONG><FONT color=black face=Arial size=2> To </FONT></STRONG>
<input id='timepicker2' name='timepicker2' type='text' value='<%=mTmpTime2%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)">&nbsp;<IMG SRC="images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker2)" STYLE="cursor:hand">
</td></tr>
<tr><td><input id="DutyHoliday" name="DutyHoliday" Type=Radio value="Y" <%=mchecked1%>><STRONG><FONT color=black face=Arial size=2>&nbsp;Duty Holiday (Full day duty denied)</strong></font>
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
%>
<tr><td colspan=2><FONT color=black face=Arial size=2><b>Reason/Remarks (Maximum 250 Characters) </b><br>	
	<TextArea Name='TEXT' Id='TEXT' maxlength=250 cols=68 rows=3>
<%=mRemarks%>	</TextArea>
<FONT color=red>*</FONT>
<INPUT id=submit1 style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 50px; HEIGHT: 23px; FONT-VARIANT: normal" type=submit size=5 value="Update" name=submit1></td></tr>
</table>
</form>
<%
if(request.getParameter("x")!=null)
	{
		mDutyHoliDay=request.getParameter("DutyHoliday").toString().trim();
		mExam=request.getParameter("Exam").toString().trim();
		if (request.getParameter("TXT1")!=null)
			mDate1=request.getParameter("TXT1").toString().trim();
		else
			mDate1="";
		if (request.getParameter("TXT2")!=null)
			mDate2=request.getParameter("TXT2").toString().trim();
		else
			mDate2="";
	//}
		
		   if (mDate1.length()==10 && mDate2.length()==10  &&  GlobalFunctions.iSValidDate(mDate1)==true && GlobalFunctions.iSValidDate(mDate2))
		   {
			 mFromTime=request.getParameter("timepicker1").toString().trim().toUpperCase();
			 mUptoTime=request.getParameter("timepicker2").toString().trim().toUpperCase();
			qry="Select WEBKIOSK.IsValidTimeFormat('"+mFromTime+"') Time1, WEBKIOSK.IsValidTimeFormat('"+mUptoTime+"') Time2  from dual";
			RsChk1= db.getRowset(qry);
			//out.print(qry);
			// If Valid Time
			if ((mDutyHoliDay.equals("Y")) || (mDutyHoliDay.equals("N") && mFromTime.length()>=6 && mUptoTime.length()>=6 && RsChk1.next() && RsChk1.getString("Time1").equals("Y") && RsChk1.getString("Time2").equals("Y")))
			{						  
				mFromTime=mDate1+" "+mFromTime;
				mUptoTime=mDate1+" "+mUptoTime;
				String mStaffType="I";
				if(mDMemberType.equals("E")) 
					mStaffType="I" ;
				else 
					mStaffType="E";
				if(!mtext.equals(""))
				{
					mtext=GlobalFunctions.replaceSignleQuot(mtext);
				
						if (mDutyHoliDay.equals("Y"))
						{

							qry="UPDATE INVIGILATIONTIMEPREF SET          PREFROMDATE     = to_date('"+mDate1+"','dd-mm-yyyy'),       PRETODATE       = to_date('"+mDate2+"','dd-mm-yyyy'),       DUTYHOLIDAY     = 'Y',           REMARKS         = '"+mtext+"',        ENTRYBY         = '"+mDMemberID+"',       ENTRYDATE       = SYSDATE WHERE  INSTITUTECODE   = '"+mInst+"' AND    COMPANYCODE     = '"+mComp+"' AND    EXAMCODE        ='"+mExam+"' AND    INVIGILATORTYPE = '"+mStaffType+"' AND    INVIGILATORID   = '"+mDMemberID+"' and   PREFROMDATE     = to_date('"+mDate1+"','dd-mm-yyyy') ";


						}
						else
						{
					 	
							qry="UPDATE INVIGILATIONTIMEPREF SET        PREFROMDATE     = to_date('"+mDate1+"','dd-mm-yyyy'),       PRETODATE       = to_date('"+mDate2+"','dd-mm-yyyy'),       DUTYHOLIDAY     = 'N',       PREFFROMTIME    = To_date('"+mFromTime+"','dd-mm-yyyy hh:mi PM'),       PRETOTIME       = To_date('"+mUptoTime+"','dd-mm-yyyy hh:mi PM'),       REMARKS         = '"+mtext+"',         ENTRYBY         = '"+mDMemberID+"',       ENTRYDATE       = SYSDATE WHERE   INSTITUTECODE   = '"+mInst+"' AND    COMPANYCODE     = '"+mComp+"' AND    EXAMCODE        ='"+mExam+"' AND    INVIGILATORTYPE = '"+mStaffType+"' AND    INVIGILATORID   = '"+mDMemberID+"' and   PREFROMDATE     = to_date('"+mDate1+"','dd-mm-yyyy') ";
							
						}
				 		try
					 	{
    						
							//	out.print(qry);
								int n=db.update(qry);
							response.sendRedirect("InvigilationTimePrefDultHoliday.jsp");
							//out.print(qry);
		   // Log Entry
  		   //-----------------
			    db.saveTransLog(mInst,mDMemberID,mDMemberType ,"INVIGILATION DUTY HOLIDAY", "Date from : "+mDate1+" to "+ mDate2, "No MAC Address" , mIPAddress);
		   //-----------------



						qry=" SELECT to_Char(EntryDate,'dd-mm-yyyy') RFDT, to_char(PREFROMDATE,'dd-mm-yyyy') ||' to '||to_char(PRETODATE,'dd-mm-yyyy') || '( '||decode(DUTYHOLIDAY,'Y','Full Day Leave/Holiday',to_char(PREFFROMTIME,'hh:mi PM')||' to '|| to_char(PRETOTIME,'hh:mi PM'))||' )' Tim , nvl(REMARKS,' ') REMARKS, nvl(APPROVED,'N')APPROVED,EXAMCODE, INVIGILATORID	FROM INVIGILATIONTIMEPREF"; 
	qry=qry+" Where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and EXAMCODE='"+mExam+"'"; 
	qry=qry+" And INVIGILATORID='"+mDMemberID+"' AND  nvl(DEACTIVE,'N')='N'";
    	rs= db.getRowset(qry);
	%>
	<table class="sort-table" id="table-1"  width='100%' border=1 cellpadding=0 cellspacing=0 align=center>
	<thead>
		<tr bgcolor="#ff8c00">
			<td><font color=white size=2 face=arial><B>SNo</b></font></td>
			<td><font color=white size=2 face=arial><B>Req. Date</b></font></td>
			<td><font color=white size=2 face=arial><B>Preference/Duty Holiday -  Date Time</b></font></td>
			<td><font color=white size=2 face=arial><B>Approved?</b></font></td>
			<td><font color=white size=2 face=arial><B>Reason/Remarks</b></font></td>
					
								
		</tr>
	</thead>
	<tbody>
	<%
	mSno=0;

	while (rs.next())
	{
		mSno++;
		mRemarks=rs.getString("Remarks");
		if (rs.getString("Remarks").length()>35)
		mRemarks=mRemarks.substring(0,35)+"...";
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
				<td><font color=<%=mColor%>><%=mSno%>.</font></td>	
				<td nowrap><font color=<%=mColor%>><%=rs.getString("RFDT")%></font></td>					
				<td nowrap><font color=<%=mColor%>><%=rs.getString("TIM")%></font></td>
				<td align=center><font color=<%=mColor%>><%=AprStatus%></font></td>

			
				
				<td nowrap><font color=<%=mColor%>><%=mRemarks%></font></td>
					
			</tr>
		<%
	}
		%>
		</tbody>
		</table><%
       					}
		      	 		catch(Exception e){}
					
				}
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Reason/Remarks for Duty Holiday / Time Preference must be entered...</font> <br>");
				}	
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Time Range </font> <br>");
 			}
		   }
	  	   else
		   {
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Invalid Date Range </font> <br>");
		   }		
		
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
	out.print("error"+e);	
}
%>
</form>
</body>
</html>