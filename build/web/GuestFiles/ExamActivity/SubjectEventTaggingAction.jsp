<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
%>
<html>
<head>
<title>#### <%=mHead%> [ Examination Event/Sub Event Tagging ] </title>

	<script>
		if(window.history.forward(1) != null)
			window.history.forward(1);
	</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",mDMemberID="";
String mExamID="",mSubEventCode,mEventCode="",mSubj="",msubj="";
String qry="",QRY="",mDualMarks="",MOM="";
double WEIGHTAGE=0,MAXMARKS=0,mW=0,EXPWEIGHTAGE=0;
String mFType="";
String mCurDate="";
String mExamSubEvent="",mExamEvent="",mFstid="";
int n=0;
ResultSet rs=null, RS=null;
String mMarks="",mPerc="";
String mDate1="", mDate2="";
try
{			
if (request.getParameter("Date1")!=null)	
 	mDate1=request.getParameter("Date1").toString().trim();
else
 	mDate1="";

if (request.getParameter("Date2")!=null)	
	mDate2=request.getParameter("Date2").toString().trim();
else
	mDate2="";

if (request.getParameter("EXPWEIGHTAGE")!=null)	
	EXPWEIGHTAGE=Double.parseDouble(request.getParameter("EXPWEIGHTAGE").toString().trim());
else
	EXPWEIGHTAGE=0;
if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}
							
if (session.getAttribute("Department")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("Department").toString().trim();
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

OLTEncryption enc=new OLTEncryption();

//System.out.println("\n LINE1: EXPWEIGHTAGE = "+EXPWEIGHTAGE +" !mMemberID = "+mMemberID + " mMemberCode= "+mMemberCode + " mMemberName = " + mMemberName );

if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{	

if(EXPWEIGHTAGE >0 )
 {
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberType=enc.decode(mMemberType);
	mDMemberID=enc.decode(mMemberID);
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('58','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	 {	
	   //----------------------
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
		if (EXPWEIGHTAGE>0 && request.getParameter("ExamCode")!=null && request.getParameter("EventSubEventCode")!=null && request.getParameter("SubjectID")!=null)
		{
			if (GlobalFunctions.iSValidDate(mDate1)==true && GlobalFunctions.iSValidDate(mDate2))
			{
				mInst=request.getParameter("Inst").toString().trim();
				if (mDMemberType.equals("E"))
					mFType="I";
				else if(mDMemberType.equals("V"))
					mFType="E";

				mExamID=request.getParameter("ExamCode").toString().trim();
				mSubj=request.getParameter("SubjectID").toString().trim();
				mEventCode=request.getParameter("EventSubEventCode").toString().trim();
 
				if (request.getParameter("ModeOfEntry")==null)
					MOM="";
				else
					MOM=request.getParameter("ModeOfEntry").toString().trim();

				if(request.getParameter("DualEntry")==null)
					mDualMarks="Y";
				else
					mDualMarks=request.getParameter("DualEntry").toString().trim();

				if(request.getParameter("WEIGHTAGE")==null)
					WEIGHTAGE=0;
				else
					WEIGHTAGE=Double.parseDouble(request.getParameter("WEIGHTAGE"));

				if(request.getParameter("MAXMARKS")==null)
					MAXMARKS=0;
				else
					MAXMARKS=Double.parseDouble(request.getParameter("MAXMARKS"));


				if(EXPWEIGHTAGE>0 && EXPWEIGHTAGE>=WEIGHTAGE && MAXMARKS>0) 
				{
					qry="Select SUBJECT||' ('||SUBJECTCODE||')' SUBJ , EMPLOYEENAME From V#EXAMEVENTSUBJECTTAGGING Where INSTITUTECODE='"+mInst+"'";
					qry=qry+" and FACULTYTYPE='"+mFType+"' and EMPLOYEEID='"+mDMemberID+"'";
					qry=qry+" and EXAMCODE='"+mExamID+"' and SUBJECTID='"+mSubj+"'";
					qry=qry+" and (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y') and EVENTSUBEVENT='"+mEventCode+"'";
					qry=qry+" and SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"'";
					qry=qry+" and NVL(STATUS,'D')='F')";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						%>
						<br><img src='../../Images/Error1.jpg'>
						&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Exam Event/Sub Event Tagging already Exist!</font> <br>
						<hr>
						<font color=Blue>Subject : <%=rs.getString("subj")%> By Faculty : <%=rs.getString("EMPLOYEENAME")%>
						</font>
						<Table border=1 width=100% cellpadding=0 cellspacing=0>
						<tr bgcolor="#c00000">
						<td><font size=2 face='verdana' color=white><b>Event<br>Sub Event</b></font></td>
						<td><font size=2 face='verdana' color=white><b>Event From</b></font></td>
						<td><font size=2 face='verdana' color=white><b>Event Upto</b></font></td>				
						<td><font size=2 face='verdana' color=white><b>Weightage</b></font></td>
						<td><font size=2 face='verdana' color=white><b>Full Marks</b></font></td>				
						<td><font size=2 face='verdana' color=white><b>Mode of Marks Entry</b></font></td>
						<td><font size=2 face='verdana' color=white><b>Level-I<br>Completed</b></font></td>
						<td><font size=2 face='verdana' color=white><b>Publised</b></font></td>
						<%				
						qry="Select Distinct EVENTSUBEVENT, to_char(FROMDATE,'dd-mm-yy') FROMDATE, to_char(TODATE,'dd-mm-yy') TODATE, nvl(PUBLISHED,'N') PUBLISHED , nvl(LOCKED,'N') LOCKED, WEIGHTAGE, ";
						qry=qry+" decode(MARKSORPERCENTAGE,'M','Marks','P','in %') MARKSORPERCENTAGE, MAXMARKS, nvl(PROCEEDSECOND,'N') PROCEEDSECOND ";
						qry=qry+" from V#EXAMEVENTSUBJECTTAGGING A Where INSTITUTECODE='"+mInst+"'";
						qry=qry+" and FACULTYTYPE='"+mFType+"' and EMPLOYEEID='"+mDMemberID+"'";
						qry=qry+" and EXAMCODE='"+mExamID+"' and SUBJECTID='"+mSubj+"'";
						qry=qry+" and ( LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y')";
						qry=qry+" and SUBJECTID NOT IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"'";
						qry=qry+" and NVL(STATUS,'D')='F')";						
						rs=db.getRowset(qry);
						//out.print(qry);
						while(rs.next())
						{
							%>
							<tr>
							<td><%=rs.getString("EVENTSUBEVENT")%></td>
							<td><%=rs.getString("FROMDATE")%></td>
							<td><%=rs.getString("TODATE")%></td>
							<td><%=rs.getDouble("WEIGHTAGE")%></td>
							<td><%=rs.getDouble("MAXMARKS")%></td>
							<td><%=rs.getString("MARKSORPERCENTAGE")%></td>
							<td><%=rs.getString("PROCEEDSECOND")%></td>
							<td><%=rs.getString("PUBLISHED")%></td>
							</tr>
							<%
						}
					}
					else
					{
						qry="select FSTID from FACULTYSUBJECTTAGGING A Where INSTITUTECODE='"+mInst+"'";
						qry=qry+" and FACULTYTYPE='"+mFType+"' and EMPLOYEEID='"+mDMemberID+"'";
						qry=qry+" and EXAMCODE='"+mExamID+"' and SUBJECTID='"+mSubj+"'";
						qry=qry+" and (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y')";					
						qry=qry+" and SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"'";
						qry=qry+" and NVL(STATUS,'D')='F')";
						qry=qry+" And  exists (select 1 from StudentLTPDetail B where B.FSTID=A.FSTID)";
						//out.print(qry);
						rs=db.getRowset(qry);
						while(rs.next())
						{
							mFstid=rs.getString("FSTID");
							qry="INSERT INTO EXAMEVENTSUBJECTTAGGING (  FSTID, EVENTSUBEVENT, DOUBLEENTRY,    FROMDATE, TODATE, WEIGHTAGE, MARKSORPERCENTAGE,MAXMARKS, ENTRYDATE,    ENTRYBY)";
							qry=qry+" VALUES ('"+rs.getString("FSTID")+"','"+ mEventCode +"','"+mDualMarks+"',to_date('"+mDate1+"','dd-mm-yyyy'),to_date('"+mDate2+"','dd-mm-yyyy'),"+WEIGHTAGE+",'"+MOM+"',"+ MAXMARKS+",Sysdate,'"+mDMemberID+"')";
							//out.print(qry);
							n=n+db.insertRow(qry);
						}
						if(n==0)
						{
							out.print("<br><img src='../../Images/Error1.jpg'>");
							out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No Record found with selected subject or Grade Calculation is over! Transaction aborted.</font> <br>");
						}
						else if(n>0)
						{
						// Log Entry
	  					//-----------------
						    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"EVENT TAGGING", "EventCode : "+mEventCode + "weightage : "+ WEIGHTAGE+"MaxMarks :"+MAXMARKS+"SubjetID :"+mSubj+"ExamCode :"+mExamID, "No MAC Address" , mIPAddress);
						//-----------------
							%>
							<hr>
							<font size=4 color= green><b>Event-Sub Event Subject Tagging completed...</b></font>
							<hr>
							<%
						}
					}
				}
				else
				{
				 	out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid Weightage Entered! Transaction aborted.</font> <br>");
				}
			}	// Validate Date
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only</font> <br>");
			}
		} // Mandatory Items cannot be null
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");
		}
	}
	else
	{
		%>
		<br>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'> Access Denied (authentication_failed) </h3><br>
		<P>This page is not authorized/available for you.
		<br>For assistance, contact your network support team. 
		</font><br><br><br><br> 
		<%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> You have already used 100 Weightage!</font> <br>");
}

 }
 else
 {
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
 }
}
catch(Exception e)
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");
}   
%>
</body>
</html>