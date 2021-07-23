<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Attendance Status  ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="";
String qry1="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int n=0;
ResultSet rs=null,rs1=null,RsChk1=null;
String mSID="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="", mName7="";
String mSelf="", mINSTITUTECODE="";
String mFstid="", mDate="", mType="", mStudentID="";
String mPresent="", mAbsent="";
int kk=0, mTotalRec=0, Ctr=0;
String Date="", Type="";	
String mEmployeeid="";
String mTfrom="", mTupto="";
String mRollno="", mSno="";
		
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
%>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<center><font size=4>Attendance Status</font></center>
<hr>
<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
<tr bgcolor=ff8c00>
<td><b>SNo.</b></td>	
<td><b>Enrollment No.</b></td>
<td><b>Student Name</b></td>	
<td><b>Status</b></td>
</tr>
<%
try 
{  //1
if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{  //2

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
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
	try
	{	
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
		mMemberType=enc.decode(mMemberType);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}
	if(mMemberType.equals("E"))
	    mMemberType="I";
	else if(mMemberType.equals("S"))
	    mMemberType="S";
	else
	    mMemberType="E";

	if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
	{ 	//3
		mTotalRec=Integer.parseInt(request.getParameter("TotalRec").toString().trim());
		for (kk=1;kk<=mTotalRec;kk++)
		{  			
			mName1="Present"+String.valueOf(kk).trim(); 	
			mName2="Absent"+String.valueOf(kk).trim(); 
			mName3="Fstid"+String.valueOf(kk).trim();
			mName4="StudID"+String.valueOf(kk).trim();
	      	mName5="Employeeid"+String.valueOf(kk).trim();
			mName6="Enrollment"+String.valueOf(kk).trim();
			mName7="SNo"+String.valueOf(kk).trim();

			mINSTITUTECODE= request.getParameter("INSTITUTE");
			mPresent=request.getParameter(mName1);
			mFstid= request.getParameter(mName3);
			mStudentID= request.getParameter(mName4);
			mEmployeeid=request.getParameter(mName5);	
			mRollno=request.getParameter(mName6);
			mSno=request.getParameter(mName7);			
			
			Date=request.getParameter("ADATE");
			Type=request.getParameter("ATYPE");
			mTfrom=request.getParameter("Timefrom");
			mTupto=request.getParameter("Timeupto");
				
			if(mEmployeeid.equals(mMemberID))
			mSelf="Y";
			else
			mSelf="N";

			if(mPresent!=null || mAbsent!=null)
			{  //4
			   qry="select 'y' from studentattendance where fstid='"+mFstid+"' and studentid='"+mStudentID+"' ";
			   qry=qry+" and ATTENDANCEDATE=To_date('"+Date+ "','dd-MM-yyyy') and CLASSTIMEFROM=To_date('"+mTfrom+"','dd-MM-yyyy HH:MI PM') ";
			   qry=qry+" and CLASSTIMEUPTO=To_date('"+mTupto+"','dd-MM-yyyy HH:MI PM') ";
			   qry=qry+" and ATTENDANCETYPE='"+Type+"' ";
			   //out.print(qry);
	               rs=db.getRowset(qry);	
			   if(rs.next())
			   {	
                    	if(mPresent.equals("P"))
				{
					qry1="UPDATE STUDENTATTENDANCE SET PRESENT='Y', ENRTYDATE=SYSDATE WHERE FSTID='"+mFstid+"' AND STUDENTID='"+mStudentID+"' AND to_char(CLASSTIMEFROM,'dd-MM-yyyy HH:MI PM')='"+mTfrom+"'";
					n=db.update(qry1);
					qry="Select WEBKIOSK.getMemberName('"+mStudentID+"','S') SL from dual" ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      	{
			 		  mSID=RsChk1.getString(1);	
					}
					%>
					<tr>
					<td><%=mSno%></td>
					<td><%=mRollno%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<td><font color=green face=arial size=2><B>Present</B></font></td>
					<tr>
					<%	
				}
				else 
				{
					qry1="UPDATE STUDENTATTENDANCE SET PRESENT='N', ENRTYDATE=SYSDATE WHERE FSTID='"+mFstid+"' AND STUDENTID='"+mStudentID+"' AND to_char(CLASSTIMEFROM,'dd-MM-yyyy HH:MI PM')='"+mTfrom+"'";
					n=db.update(qry1);
					qry="Select WEBKIOSK.getMemberName('"+mStudentID+"','S') SL from dual" ;
					RsChk1= db.getRowset(qry);
					if(RsChk1.next())
			      	{
			 		  mSID=RsChk1.getString(1);	
					}
					%>
					<tr>
					<td><%=mSno%></td>
					<td><%=mRollno%></td>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<td><font color=red face=arial size=2><B>Absent</B></font></td>
					<tr>
					<%	
				}
				//out.print(qry1);
		} // closing of select if
    } // closing of if 4
} // closing of for

// Log Entry
	  		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"ATTENCANCE EDIT BY RESPECTIVE FACULTY", "Attendance DateTime From: "+mTfrom +"Upto :"+mTupto+ "Class Type : "+Type , "No MAC Address" , mIPAddress);
			   //-----------------
%>
	</table>
<%
	
	} //3
	else
	{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" <b><font size=3 face='Arial' color='Red'>Please make the attendance first !</font>&nbsp; &nbsp; &nbsp;<a href=DailyStudentAttendanceEntry.jsp><img src='../../Images/Back.jpg' border=0 ></a><br><br> ");
	//out.print("<p><a href=DailyStudentAttendanceEntry.jsp><img src='../../Images/Back.jpg' border=0 ></a></p>");  

	}

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

}  //2
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}	//1	
catch(Exception e)
{
	//out.print("No Item Selected..."+qry);
//	out.println(e.getMessage());
}
%>
<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>
