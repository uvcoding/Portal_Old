<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey Entry Screen ] </TITLE>
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
<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>


<%
String mName1=""	,mName2="",mName3="",mName4="",mName5="",mName6="",mWebEmail="",mTextname="";
String mSingleLTP="";
String mSrsCode="";
String mSrsSubCode="";
String mQNo="";
String mLTP="";
String mRatingValue="";
String mInstituteCode="";
String mCmpCode="";
String mFacultyType="";
String mEmpId="";
String mEventCode="";
String mExamCode="";
String mAcademic="";
String mProgramCode="";
String mTaggingFor="";
String mSectionBranch="";
String mSubSectionCode="";
String mStudentID="";
String mSemester="";
String mSemType="";
String mBasket="";
String mSubjectID="";
long mTotalRec=0;
String mRatingCode="";
String mInst="";
String mMem="";
String mMemID="";
String mDMemID="";
String mDMem="";
String mProg="";
String mName="";
String mBranch="";
String mSem="";
String mLTP1="";
String mApproved="";
long kk=0;
String qry="";
ResultSet rsf=null,rsf1=null;
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();

/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	StudNewSrsEntry.JSP		[For Students]					
	' * Author:		Rituraj
	' * Date:		24th Oct 2006								
	' * Version:	1.0								
	' * Description:	Displays Personal Info. of Students 					
*************************************************************************************************
*/
try{
if (session.getAttribute("WebAdminEmail")==null)
{
	 mWebEmail="";
}	 
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}

if(session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}
if(session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
if(session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}
if(session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("MemberCode")!=null &&  session.getAttribute("MemberType")!=null)
{ 
	OLTEncryption enc=new OLTEncryption();
	String mSuggest="";
	int mSuggested=0;
	mDMemID=enc.decode(mMemID);
	mDMem=enc.decode(mMem);
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('30','"+ mDMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------

	 if (request.getParameter("TotalRec")!=null && Long.parseLong(request.getParameter("TotalRec").toString().trim())>0)
	  {
			mTotalRec=Long.parseLong(request.getParameter("TotalRec").toString().trim());
			mInstituteCode=request.getParameter("INSTITUTECODE").toString().trim();
			mCmpCode=request.getParameter("COMPANYCODE").toString().trim();
			mFacultyType=request.getParameter("FACULTYTYPE").toString().trim();
			mEmpId=request.getParameter("EMPLOYEEID").toString().trim();
			mEventCode=request.getParameter("SRSEVENTCODE").toString().trim();
			mExamCode=request.getParameter("EXAMCODE").toString().trim();
			mAcademic=request.getParameter("ACADEMICYEAR").toString().trim();
			mProgramCode=request.getParameter("PROGRAMCODE").toString().trim();
			mTaggingFor=request.getParameter("TAGGINGFOR").toString().trim();
			mSectionBranch=request.getParameter("SECTIONBRANCH").toString().trim();
			mSubSectionCode=request.getParameter("SUBSECTIONCODE").toString().trim();
			mStudentID=request.getParameter("STUDENTID").toString().trim();
			mSemester=request.getParameter("SEMESTER").toString().trim();
			mSemType=request.getParameter("SEMESTERTYPE").toString().trim();
			mBasket=request.getParameter("BASKET").toString().trim();
			mSubjectID=request.getParameter("SUBJECTID").toString().trim();
			mLTP=request.getParameter("TotalLTP").toString().trim(); // Find LTP in the form of LTP
			int n1=0,mTotalLTP=request.getParameter("TotalLTP").toString().trim().length(); // Find length of LTP

// SRSEventSuggestion entry
//------------------------

	for (int kkk=0;kkk<mTotalLTP;kkk++)
		{		
		mLTP1=mLTP.substring(kkk,kkk+1);
		
		qry="select fstid From FacultySubjecttagging where INSTITUTECODE='"+mInstituteCode+"' and COMPANYCODE='"+mCmpCode+"' and FACULTYTYPE='"+mFacultyType+"' and EMPLOYEEID='"+mEmpId+"' and EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcademic+"' and  PROGRAMCODE='"+mProgramCode+"' and ";
		qry=qry+ " TAGGINGFOR='"+mTaggingFor+"' and  SECTIONBRANCH='"+mSectionBranch+"' and SUBSECTIONCODE='"+mSubSectionCode+"' and SEMESTER='"+mSemester+"' and  SEMESTERTYPE='"+mSemType+"' and BASKET='"+mBasket+"' and  SUBJECTID='"+mSubjectID+"' and  LTP='"+mLTP1+"' and nvl(DEACTIVE,'N')='N' ";
 		rsf=db.getRowset(qry);
		while(rsf.next())
		{
		 mTextname="TEXT"+mLTP1; 
		 if(request.getParameter(mTextname)==null)
			mSuggest="";	
		 else
			mSuggest=GlobalFunctions.replaceSignleQuot(request.getParameter(mTextname).toString().trim());
			if(mSuggest.length()>250)
				mSuggest=mSuggest.substring(0,249);

		qry=" insert into SRSEVENTSUGGESTION (FSTID, SRSEVENTCODE, STUDENTID, ENTRYDATE, DEACTIVE, SUGGESTION, ISABUSING ) ";
		qry=qry+ " values ('"+rsf.getString("fstid")+"','"+mEventCode+"','"+mStudentID+"',sysdate,'N','"+mSuggest+"','N') "; 

		n1=db.insertRow(qry);
		}
	  }


// SRSEventDetail entry
//------------------------

	for (kk=1;kk<=mTotalRec ;kk++)
		{				
			mName4="LTP_"+String.valueOf(kk).trim();
			mLTP=request.getParameter(mName4).toString().trim();				
			mName1="SRSCODE_"+String.valueOf(kk).trim();
			mName2="SRSSUBCODE_"+String.valueOf(kk).trim();
			mName3="Qno_"+String.valueOf(kk).trim();
			mName5="RATINGVALUE_"+String.valueOf(kk).trim();  
			mName6="RATINGCODE_"+String.valueOf(kk).trim();  	
			mSrsCode=request.getParameter(mName1).toString().trim();
			mSrsSubCode=request.getParameter(mName2).toString().trim();
			mQNo=request.getParameter(mName3).toString().trim();
			mRatingValue=request.getParameter(mName5).toString().trim();
			mRatingCode=request.getParameter(mName6).toString().trim();
			
qry="select fstid from facultysubjecttagging where INSTITUTECODE='"+mInstituteCode+"' and COMPANYCODE='"+mCmpCode+"' and FACULTYTYPE='"+mFacultyType+"' and EMPLOYEEID='"+mEmpId+"' and EXAMCODE='"+mExamCode+"' and ACADEMICYEAR='"+mAcademic+"' and  PROGRAMCODE='"+mProgramCode+"' and ";
qry=qry+ "TAGGINGFOR='"+mTaggingFor+"' and  SECTIONBRANCH='"+mSectionBranch+"' and SUBSECTIONCODE='"+mSubSectionCode+"' and SEMESTER='"+mSemester+"' and  SEMESTERTYPE='"+mSemType+"' and BASKET='"+mBasket+"' and  SUBJECTID='"+mSubjectID+"' and  LTP='"+mLTP+"' and nvl(DEACTIVE,'N')='N' ";

rsf1=db.getRowset(qry);
while(rsf1.next())
{
	if(mRatingValue.equals("00"))
	{	
	qry="insert into	SRSEVENTDETAIL (FSTID, SRSEVENTCODE, STUDENTID, SRSCODE, SRSSUBCODE, SRSQUESTIONCODE, RATINGCODE, NASELECTED, ENTRYDATE, DEACTIVE) ";
	qry=qry +" values ('"+rsf1.getString("fstid")+"','"+mEventCode+"','"+mStudentID+"','"+mSrsCode+"','"+mSrsSubCode+"','"+mQNo+"','"+mRatingCode+"','Y',SysDate,'N') ";	

	int n=db.insertRow(qry);	
  	  }
	else 
	{ 

	qry="insert into	SRSEVENTDETAIL (FSTID, SRSEVENTCODE, STUDENTID, SRSCODE, SRSSUBCODE, SRSQUESTIONCODE, RATINGCODE, RATINGVALUE, ENTRYDATE, DEACTIVE) ";
	qry=qry +" values ('"+rsf1.getString("fstid")+"','"+mEventCode+"','"+mStudentID+"','"+mSrsCode+"','"+mSrsSubCode+"','"+mQNo+"','"+mRatingCode+"','"+mRatingValue+"',SysDate,'N') ";		
	
	int n=db.insertRow(qry);
	} 
	
   }
}
%>
<p>
<hr>
<font color=Green size=4>
SRS Entry/feedback saved...<br>
<br>Please continue <b>Click <a href=StudNewSrsEntry.jsp> New SRS Entry</a></b> to enter the next suggestion (if any)<br>
If Event Entry date will be expried you can not submit your feedabck!
<hr>
</p>

<%
	   } 
		else
		{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select the ranking</font> <br>");
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



	}  
		else
		{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
		}      
}
catch(Exception e)
{
// out.print("error");
}
	
%>
		<table ALIGN=Center VALIGN=TOP>
		<tr>
		<td valign=middle><br><br><br><br><br><br><br><br><br>
		<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
		<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
		A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
		<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
		</td></tr></table>
</body>
</html>

