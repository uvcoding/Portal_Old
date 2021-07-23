<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mDesg="",mDept="",mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDMemberID="",mTotalRec="",mFstid="";
int ctr=0;
int mTotalCount=0;
String mName1="",mName2="",mSemester="",mStudentid="",mINSTITUTECODE="",mEventsubevent="";
String mExam="",mName3="",mSubject="",mSID="",mName4="",mDetained="",mProceed="",mName5="";;
double mMax=0;
double mMarks=0;
ResultSet rs=null,RsChk=null;
String qry="",mShowMarks="",mName7="";
String mMOP="",mSPrint="",mStatus="";
double mpercmarks=0,mMax1=0;

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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";

%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Marks Entry Level One Action ] </TITLE>
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
function showAlert()
{
if(document.frm2("Proceed").checked==true)
{

	var mChoice=confirm('Once You will check and continue, You cannot change marks of the students using this form! Continue...?');
	if (mChoice) 
	{
		document.frm2("Proceed").checked=true;	
	}
	else
	{
		document.frm2("Proceed").checked=false;
	}
 }
else
	{
		alert('You cannot start IInd Level Marks entry until you check it and continue.');
	}
document.frm2("Proceed").focus;

}
//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%	
	try{
	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);

		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk1=null;

  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk1= db.getRowset(qry);
	if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
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
%>
	<center><font size=4 color=green>Ist Level marks entry status</font></center>
			<hr>
			<table align='center' width='70%'>
			<tr><td bgcolor=red>&nbsp;&nbsp;&nbsp</td><td>Error/Notentered</td>
			<td bgcolor=Green>&nbsp;&nbsp;&nbsp</td><td>Marks saved/Modified</td>
			<td bgcolor="#3399cc">&nbsp;&nbsp;&nbsp</td><td>Detained/Absent</td>
			</tr></table>
			<table border=1 cellpadding=0 cellspacing=0 rules="rows" align=center width=90%>
			<tr bgcolor=ff8c00>
			<td><b>Student name</b></td>
			<td><b>Semester</b></td>
			<td><b>Marks</b></td>
			<td><b>Status</b></td>
			</tr>
<%
			mINSTITUTECODE=request.getParameter("institute");
			mEventsubevent=request.getParameter("EventSubevent");
			mExam=request.getParameter("Exam");			
			mMax=Double.parseDouble(request.getParameter("MaxMarks"));
			mSubject=request.getParameter("subjectcode");
			mMOP=request.getParameter("Marksorpercentage"); 	
			if(mMOP.equals("P")) 
      		{       
			mMax1=mMax;
			mMax=100;
			}
			mStatus=request.getParameter("Status");
			/*
			if(mStatus.equals("D"))
			mSPrint="Detained";
			else
			mSPrint="Absent";
			*/
	if(request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
	{ 
		mTotalCount =Integer.parseInt(request.getParameter("TotalCount").toString().trim());
		for (ctr=1;ctr<=mTotalCount;ctr++)
		{			

			mName1="Semester"+String.valueOf(ctr).trim();  
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks"+String.valueOf(ctr).trim();
			mName4="Detained"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
			mName7="Status"+String.valueOf(ctr).trim();
	
			mSemester=request.getParameter(mName1);
			mStudentid=request.getParameter(mName2);
		   // mMarks=Double.parseDouble(request.getParameter(mName3));
			try{
			if(request.getParameter(mName3)==null || request.getParameter(mName3).equals(""))
			{	
			mMarks=-1;
			mShowMarks=" ";
			}
			else
			{
			mMarks=Double.parseDouble(request.getParameter(mName3));
			mShowMarks=String.valueOf(mMarks);
			}
			}
			catch(Exception e)
			{
				mMarks=-1;
				mShowMarks=" ";
			}
			
			if (request.getParameter(mName4)==null)
			{
				mDetained="";
			}
			else
			{
				mDetained=request.getParameter(mName4).toString().trim();
			}

			if(mDetained.equals("D"))
			mSPrint="Detained";
			else if(mDetained.equals("A"))
			mSPrint="Absent";
			else
			mSPrint="";

			mFstid=request.getParameter(mName5);
			
		try{	
		       if(mDetained.equals("N") && (mMax<mMarks || mMarks<0))
			{
		  qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
		  RsChk= db.getRowset(qry);
		  if(RsChk.next())
		  mSID=RsChk.getString(1);	
		 %>
			<tr>
			<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
			<td><%=mSemester%></td>
			<td>&nbsp;<%=mShowMarks%></td>
			<td><font color=red>(Not entered)</font></td>
			</tr>
	       <%	
		} 
		else
		{	//--1
			if(mMOP.equals("P"))
			{	
				 mpercmarks=(mMarks*mMax1)/100 ;	
		
				qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
				qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
				qry=qry+" where INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mExam+"' and ";
				qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and   ";
				qry=qry+" fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
				rs=db.getRowset(qry);
				if(rs.next())
				{
					if(!mDetained.equals("N"))
		  			{
					   qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=null,DETAINED='"+mDetained+"' ";
					   qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
					   qry=qry+" and studentid='"+mStudentid+"' ";
					   int n=db.update(qry);	
						qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}
					%>	
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mSPrint%> </td>
						<td><font color=green>(Updated)</font></td>
						</tr>
	      			<%
				   	}	
					    else
					    {		
					       qry="update STUDENTEVENTSUBJECTMARKS set DETAINED=null,MARKSAWARDED1='"+mpercmarks+"' ";
					  	 qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
					 	 qry=qry+" and studentid='"+mStudentid+"' ";
			  		 	 int n=db.update(qry);
						 qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}
					%>	
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mpercmarks%></td>
						<td><font color=green>(Updated)</font></td>
						</tr>
	      			<%
	                       	     }
					}
				else
	                 {	
	  			  if(!mDetained.equals("N"))
				  {
					qry="insert into 	STUDENTEVENTSUBJECTMARKS (FSTID, EVENTSUBEVENT, STUDENTID, ";
					qry=qry+" MARKSAWARDED1,MARKSAWARDED2,DETAINED,ENTRYDATE, ENTRYBY) ";
					qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"',null,null,'"+mDetained+"',sysdate,'"+mDMemberID+"') "; 	
			      	int n=db.insertRow(qry);
					qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}

					%>
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mSPrint%></td>
						<td><font color="#3399cc">Save</font></td>
						</tr>
		      		<%

				  }	
					 else
					{					
						qry="insert into 	STUDENTEVENTSUBJECTMARKS (FSTID, EVENTSUBEVENT, STUDENTID, ";
						qry=qry+" MARKSAWARDED1,ENTRYDATE, ENTRYBY) ";
						qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"','"+mpercmarks+"',sysdate,'"+mDMemberID+"') "; 	
						int n=db.insertRow(qry);
						qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						RsChk= db.getRowset(qry);
						if(RsChk.next())
						{
						 	 mSID=RsChk.getString(1);	
						}
					%>
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mpercmarks%></td>
						<td><font color=green>Save</font></td>
						</tr>
		      		<%
				     }
				}
                  }	
				else
				{    //-----------2 if Marks type then
				qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
				qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
				qry=qry+" where INSTITUTECODE='"+mINSTITUTECODE+"' and EXAMCODE='"+mExam+"' and ";
				qry=qry+" EVENTSUBEVENT='"+mEventsubevent+"' and   ";
				qry=qry+" fstid='"+mFstid+"' and STUDENTID='"+mStudentid+"' ";
				rs=db.getRowset(qry);
		//out.print(qry);
				if(rs.next())
				{
					if(!mDetained.equals("N"))
		  			{
					   qry="update STUDENTEVENTSUBJECTMARKS set MARKSAWARDED1=NULL,DETAINED='"+mDetained+"' ";
					   qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
					   qry=qry+" and studentid='"+mStudentid+"' ";
					   int n=db.update(qry);
						qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}
	
					//out.print(qry);
					%>	
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mSPrint%></td>	
						<td><font color="#3399cc">(Updated)</font></td>
						</tr>
					<%
				   	}	
					    else
					    {		
					       qry="update STUDENTEVENTSUBJECTMARKS set DETAINED=null,MARKSAWARDED1='"+mMarks+"' ";
					  	 qry=qry+" where fstid='"+mFstid+"' and eventsubevent='"+mEventsubevent+"' ";
					 	 qry=qry+" and studentid='"+mStudentid+"' ";
					 	 int n=db.update(qry);
						 qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}
					%>	
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mShowMarks%></td>
						<td><font color=green>(Updated)</font></td>
						</tr>
	      			<%
	                       	     }
					}
				else
	                 {	
	  			  if(!mDetained.equals("N"))
				  {
					qry="insert into STUDENTEVENTSUBJECTMARKS (FSTID, EVENTSUBEVENT, STUDENTID, ";
					qry=qry+" MARKSAWARDED1,MARKSAWARDED2,DETAINED,ENTRYDATE, ENTRYBY) ";
					qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"',NULL,NULL,'"+mDetained+"',sysdate,'"+mDMemberID+"') "; 	
			      	int n=db.insertRow(qry);
					qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						 RsChk= db.getRowset(qry);
						 if(RsChk.next())
			 	      	{
				 			 mSID=RsChk.getString(1);	
						}

					%>
					<tr>
					<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
					<td><%=mSemester%></td>
					<td><%=mSPrint%> </td>
					<td><font color="#3399cc">Save</font></td>
					</tr>
				<%
				  }	
					 else
					{					
						qry="insert into 	STUDENTEVENTSUBJECTMARKS (FSTID, EVENTSUBEVENT, STUDENTID, ";
						qry=qry+" MARKSAWARDED1,ENTRYDATE, ENTRYBY) ";
						qry=qry+" values ('"+mFstid+"','"+mEventsubevent+"','"+mStudentid+"','"+mMarks+"',sysdate,'"+mDMemberID+"') "; 	
						int n=db.insertRow(qry);
				
						qry="Select WEBKIOSK.getMemberName('"+mStudentid+"','S') SL from dual" ;
						RsChk= db.getRowset(qry);
						if(RsChk.next())
						{
						 	 mSID=RsChk.getString(1);	
						}
					%>
						<tr>
						<td><%=GlobalFunctions.toTtitleCase(mSID)%></td>
						<td><%=mSemester%></td>
						<td><%=mShowMarks%></td>
						<td><font color=green>Save</font></td>
						</tr>
		      		<%
				   }

				}
		}  //-------closing of mMOP else 2
		} //----else 1
	    }
			catch(Exception e)
			{	
			//out.print("error"+qry);
			}	
// Log Entry
	  		   //-----------------
			    db.saveTransLog(mINSTITUTECODE,mLogEntryMemberID,mLogEntryMemberType ,"MARKS ENTRY LEVEL-1", "ExamCode: "+mExam +"EventSubevent "+ mEventsubevent+ "SubjectID"+mSubject+"Fstid:"+mFstid +"MaxMarks: "+mMax, "NO MAC Address" , mIPAddress);
			   //-----------------
		}    //----------closing of for loop

//out.println("Global Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 
session.setMaxInactiveInterval(1800); 
//out.println("Special Maximum Inactive Interval of Session in Seconds is : " +session.getMaxInactiveInterval()); 

	%>
<tr>
<form name="frm2" id="frm2" method="post" action="Level2ProceedAction.jsp">
<td colspan=5 align=center valign=top><font size=2 color="#993300" face=arial>
<b>** Procced  to second level marks entry
<input type=checkbox name='Proceed' id='Proceed' value='Y' onclick="return showAlert();">
<INPUT Type="submit" Value="Continue IInd level now"></td>
<input type=hidden name='institute' id='institute' value=<%=mINSTITUTECODE%>>
<input type=hidden name='Exam' id='Exam' value=<%=mExam%>>
<input type=hidden name='EventSubevent' id='EventSubevent' value=<%=mEventsubevent%>>
<input type=hidden name='subjectcode' id='subjectcode' value=<%=mSubject%>>		
</form></tr>
</table>
<p>**<font color="#cc9933" size=3> 
Once You check the box and continue to IInd level then Ist Level Entry will be closed.
 For the same all marks must be entered or Detained in this level.</b></font></font></p>
	
	<%	
	 //---------closing of totalcount loop  
	
	}
	else
	{
	out.print("No record entered...");
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


//---------closing of session loop
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
//------------------try
     	}
	catch(Exception e)
	{
	//out.print("last catch"+qry);
	}	
%>