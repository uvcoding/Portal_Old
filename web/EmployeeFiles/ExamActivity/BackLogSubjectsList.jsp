<!---27-11-2019--->
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
ResultSet  rs=null,rs1=null,rss1=null,rsc=null,rse=null,rse1=null,rsso=null;
String qry="",qry1="";
String mDID="",mProg="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
double mMinCrLmt=0, mMaxCrLmt=0, mMinCrLmtTkn=0, mMaxCrLmtTkn=0, mMaxCrLmtAld=0, mCourseCrPt=0, mTotalCrLmtTkn=0;
String mSect="",	mSubSect="", mTag="",mElective="",mSCode="";
String mExam="", mFailGraders="F", mPrcode="";
String mName1="", mName2="",mName3="", mName4="", mName5="", mName6="", mName7="", mName8="", mName9="", mName10="";
int mochoice=0, mochoice1=0,Count=0,chk=0,m=1;
/*
*************************************************************************************************
	' *
	' * File Name:	PRStudentEntry.jsp		[For Students]
	' * Author:		Ankur Verma
	' * Date:		13th April 2011
	' * Version:	1.0
	' * Description:	Pre Registration of Students [Choices for Back & Curr Core+Elective+FreeElective]
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";


%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

<Html>
<head>

</head>

<body topmargin=0 rightmargin=0 leftmargin=10 bottommargin=0 bgcolor=#fce9c5>
<cenTer>
<%
String mSEMESTER="", mSname="";
String mBranch="", mAcad="";
String mInst="", mComp="", mWebEmail="";
int mSem=0, mSno=0, mChoice=1, mTot=0;
String mySect="";
String mFELFinal="N", mCoreFinal="N";
int mSemester=0;
String mSemType="", mSubjType="", mSubjTypeDesc="", mSubjId="", mSubjName="", mBasket="";
String mColor="white";
String mCol1="lightyellow";
String mCol2="#F8F8F8";
String mStartDate="",mEndDate="";
OLTEncryption enc=new OLTEncryption();
mSname=session.getAttribute("MemberName").toString().trim();
mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());

if (session.getAttribute("WebAdminEmail")==null)
{
	mWebEmail="";
}
else
{
	mWebEmail=session.getAttribute("WebAdminEmail").toString().trim();
}

try
{

if (session.getAttribute("MemberID")!=null && session.getAttribute("MemberCode")!=null)
{
	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	String mStatus="";
	ResultSet rds=null, RsChk=null;
  	//-----------------------------
	//-- Enable Security Page Level
	//-----------------------------
	qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
        RsChk= db.getRowset(qry);

	//if(1==1)
	if(RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

	mComp=session.getAttribute("CompanyCode").toString().trim();
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());


qry=" SELECT distinct examcode, regcode                     FROM preventmaster                    WHERE institutecode = '"+mInst+"'                      AND NVL (prcompleted, 'N') = 'N'                      AND NVL (prbroadcast, 'N') = 'Y'                      AND prrequiredfor = 'S'                      AND NVL (deactive, 'N') = 'N'                      AND TRUNC (SYSDATE) >= TRUNC (fromdate)                      AND TRUNC (SYSDATE) <= TRUNC (endate)";
	rs=db.getRowset(qry);
	//out.print(qry);
	if (rs.next())
		mExam=rs.getString(1);


qry1="select  TO_CHAR(FROMDATE,'DD Month YYYY')FROMDATE,TO_CHAR(ENDATE,'DD Month YYYY') ENDATE from PREVENTMASTER Where  INSTITUTECODE='"+mInst+"' and examcode='"+mExam+"' AND NVL(PRREQUIREDFOR,'N')='S'";
	rs1=db.getRowset(qry1);
//out.print(qry1);
	if (rs1.next())
		{
		mStartDate=rs1.getString("FROMDATE");
		mEndDate=rs1.getString("ENDATE");
		}




qry=" Select SEMESTER from  STUDENTREGISTRATION where StudentID='" +mDID+ "' and examcode='"+mExam+"' and  InstituteCode='" + mInst + "' And nvl(regallow,'N')='Y'";
//out.print(qry);
rs=db.getRowset(qry);
if (rs.next())
	mSem=rs.getInt("SEMESTER");

qry="Select distinct nvl(STUDENTID, ' ') STUDENTID, nvl(PROGRAMCODE,' ') PROGRAMCODE,nvl(BRANCHCODE,' ') BRANCHCODE, ";
qry=qry+"   ACADEMICYEAR from STUDENTMASTER where StudentID='" +mChkMemID+ "' and  InstituteCode='" + mInst + "'";
	rs=db.getRowset(qry);
	if (rs.next())
	{
		mSname=session.getAttribute("MemberName").toString().trim();
		mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
		mProg=rs.getString("PROGRAMCODE");
		mBranch=rs.getString("BRANCHCODE");
		mAcad=rs.getString("ACADEMICYEAR");
	}

/*
qry="Select distinct A.Semester Semester, decode(nvl(COURSETYPE,'C'),'C','A','B') BASKET, A.SubjectID SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj, B.COURSECREDITPOINT COURSECREDITPOINT From STUDENTRESULT A, ProgramSubjectTagging B, SubjectMaster C ";
qry=qry+" where A.semester=b.semester and A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And  A.InstituteCode=B.InstituteCode And ";
qry=qry+" b.PROGRAMCODE='"+mProg +"' And b.academicyear='"+mAcad+"'";
qry=qry+" and A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND A.institutecode=C.institutecode and A.subjectID=B.subjectID And A.subjectID=C.subjectID";
qry=qry+" order by Basket , Subj";
*/

qry="Select distinct A.Semester Semester, A.SubjectID SubjectID, C.Subject||' ('||C.SubjectCode||')' Subj From STUDENTRESULT A,  SubjectMaster C ";
qry=qry+" where A.institutecode='"+mInst +"' And A.studentid= '"+mChkMemID+"' And  ";
qry=qry+" A.grade='"+mFailGraders+"' And A.semester< "+(mSem-1)+" AND A.institutecode=C.institutecode and  A.subjectID=C.subjectID";
qry=qry+" union ";
qry=qry+" (select distinct C.semester Semester, C.SUBJECTID SUBJECTID, B.Subject||' ('||B.SubjectCode||')' SUBJECT from NRSTUDENTFAILSUBJECTS C,SUBJECTMASTER B";
qry=qry+"  where C.institutecode='"+mInst+"'  And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID  AND NVL(C.REGISTERED,'N')<>'Y'   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' ";
qry=qry+"  and C.semester<="+(mSem-1)+" AND C.BASKET IN ('A') ) ";
qry=qry+" order by Subj";

//out.print(qry);
rs=db.getRowset(qry);
if (rs.next())
{
%>
<center>
				<font color=darkbrown size=4><b>List of total Back Log/Fail Subjects</font></B>
</center>
				<br>

<FONT face=Arial size=2 color=black><STRONG>Student Name - </STRONG></FONT><%=GlobalFunctions.toTtitleCase(mSname)%> (<%=mSCode%>)
<br>
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
<tr bgcolor=darkblue>
<td><font color=white><b>Semester</b></font></td><td><font color=white><b>Subject</b></font></td><td><font color=white><b>Subject Type</b></font></td><td><font color=white><b>Credit</b></font></td></td><td><font color=white><b>Offered Status</b></font></td>
</tr>
<%

//out.print(qry);
String mSubjID="";

				rs=db.getRowset(qry);
				while(rs.next())
				{
					mSno++;
					mColor="#FF6464";
					mSemester=rs.getInt("Semester");
					mSubjName=rs.getString("Subj");
					mSubjID=rs.getString("SubjectID");


					qry="Select B.COURSECREDITPOINT COURSECREDITPOINT,decode(nvl(COURSETYPE,'C'),'C','A','B') BASKET From ProgramSubjectTagging B";
					qry=qry+" where B.institutecode='"+mInst +"' ";
					//qry=qry+" and b.semester="+mSemester +"  and b.PROGRAMCODE='"+mProg +"' And b.academicyear='"+mAcad+"'";
					qry=qry+" And B.subjectID ='"+mSubjID+"' ORDER BY COURSECREDITPOINT DESC";


					rds=db.getRowset(qry);
					if (rds.next())
					{
						mCourseCrPt=rds.getDouble("COURSECREDITPOINT");
						mBasket=rds.getString("BASKET");
					}
					else
					{
						mCourseCrPt=0;
						mBasket="";
					}



					mTotalCrLmtTkn=mTotalCrLmtTkn+mCourseCrPt;
					if(mBasket.equals("A"))
						mSubjTypeDesc="CORE";
					else if(mBasket.equals("E"))
						mSubjTypeDesc="ELECTIVE";



			//CHANGE MSEM <=
				qry="Select  SubjectID from ( ";
				qry=qry+" (Select B.SubjectID  From ProgramSubjectTagging B ";
				qry=qry+" where B.institutecode='"+mInst +"' And B.ExamCode='"+mExam+"' ";
				qry=qry+" And B.semester<"+(mSem-1)+" and B.subjectID='"+ mSubjID +"')";
				qry=qry+" union ";
				qry=qry+" (select A.SUBJECTID from PR#ELECTIVESUBJECTS A";
				qry=qry+"  where A.institutecode='"+mInst+"'  And A.ExamCode='"+mExam+"' And A.SubjectID='"+mSubjID+"'";
				qry=qry+"  and A.semester<"+(mSem-1)+" ) ";
				qry=qry+"  union ";
				qry=qry+" (select A.SUBJECTID From OFFERSUBJECTTAGGING A";
				qry=qry+"  where A.institutecode='"+mInst+"' And A.ExamCode='"+mExam+"' ";
				qry=qry+"  and A.subjectID='"+ mSubjID +"'))";
//				out.println(qry);
				rs1=db.getRowset(qry);
				if(rs1.next())
				{
					mStatus="<font color=Green><b>Offered Now</b>";
				}
				else
				{
					mStatus="<font color=Red><b>Not Offered</b>";
				}




					%>
						<tr><td><%=mSemester%></td>
						<td><Font face=arial><%=mSubjName%></font></td>
						<td><Font face=arial><%=mSubjTypeDesc%></font></td>
						<td><Font face=arial><%=mCourseCrPt%></font></td>
						<td><%=mStatus%></td>
					</tr>
			<%
			}
			%>
				</table>


			<%

	}
	else
	{
	%>




	<%
	}
%>

<br><title>

ONLINE PRE-REGISTRATION INSTRUCTIONS: STUDENTS</title>
</head>

<body lang=EN-US link=blue vlink=purple style='tab-interval:.5in'>
<div class=Section1>

<p class=MsoNormal align=center style='text-align:center'><b><u><span
style='mso-bidi-font-size:11.0pt;font-family:Tahoma'>
<U>PLEASE READ INSTRUCTIONS BEFORE PROCEEDING WITH THE PRE-REGISTRATION PROCESS.</U>
<br><o:p></o:p></span></u></b></p>


<p class=MsoNormal><span style='mso-bidi-font-size:11.0pt;font-family:Tahoma;
mso-bidi-font-weight:bold'>Last Date of Freezing </span><span
style='font-size:11.0pt;font-family:Tahoma;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
<font face="Times New Roman">

</font>
<p class=MsoNormal><span style='mso-bidi-font-size:11.0pt;font-family:Tahoma;
mso-bidi-font-weight:bold'>2nd Year (4th Semester) B.Tech & Integrated M.Tech   - 23-11-2019 to 24-11-2019<br>
3rd Year (6th Semester) B.Tech & Integrated M.Tech   - 25-11-2019 to 27-11-2019<br>
All Others		  -  28-11-2019 to 29-11-2019 </span><span
style='font-size:11.0pt;font-family:Tahoma;mso-bidi-font-weight:bold'><o:p></o:p></span></p>
<font face="Times New Roman">

</font>

<p style="margin: 0cm 0cm 6pt; text-align: justify; tab-stops: 18.0pt;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><span style='letter-spacing: -0.1pt; font-family: "Calibri","sans-serif"; font-size: 11pt; mso-bidi-font-size: 10.0pt; mso-bidi-font-family: Helv;' lang="EN-US">All students as below are required to complete the pre-registration process.<br>(a)Those who have to choose electives (including replacement of backlog electives). <br>(b)Those who have backlogs in core courses in any semester.</p>



<p style="margin: 0cm 0cm 6pt; text-align: justify; tab-stops: 18.0pt;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><span style='letter-spacing: -0.1pt; font-family: "Calibri","sans-serif"; font-size: 11pt; mso-bidi-font-size: 10.0pt; mso-bidi-font-family: Helv;' lang="EN-US">Schedule - </span></b><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Calibri","sans-serif"; font-size: 11pt; mso-bidi-font-size: 10.0pt; mso-bidi-font-family: Helv;' lang="EN-US">2nd Year (4th Semester) B.Tech & Integrated M.Tech  - 23-11-2019 to 24-11-2019<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
3rd Year (6th Semester) B.Tech & Integrated M.Tech  - 25-11-2019 to 27-11-2019<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
All Other   -   28-11-2019 to 29-11-2019<br></span></b><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Verdana","sans-serif"; font-size: 9pt;' lang="EN-US"><o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt; text-align: justify;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">In case student fails to pre-register, he / she may:-<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l1 level1 lfo5;" class="MsoNormal"><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;"><span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">


(a)           Register only for non-clashing courses during regular registration as time table would have already been made without considering the choices. No other choices shall be provided.<br>
(b)           Pay a fine of Rs. 500/- for delay.<br>
</font><p style="margin: 3pt 0cm 0pt; text-align: justify;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">Courses
registration Sequence<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l1 level1 lfo5;" class="MsoNormal"><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;"><span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">
(a)           Back log core courses starting from the first semester<br>
(b)           Core subjects of the Even semester subject to the maximum credit restriction.<br>
(c)           HSS and Science Electives courses  ONE from each basket  minimum 4 choices may be prioritized.<br>
(d)           Departmental electives. ONE  per basket shall be allowed. However, student may choose all the courses from the basket duly prioritized.<br>
(e)           Those who wish to do some electives through MOOC?s may follow the MOOC?s regulation given in Academic System..  <br>
<!--</font><p style="margin: 3pt 0cm 0pt; text-align: justify;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">Registration
Registration Sequence for Grade Improvement (Please see the rules governing grade improvement on website)<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l3 level1 lfo3;" class="MsoNormal"><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;"><span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">
(a)           It is mandatory to pre-register for the subject (only which is on offer)<br>
(b)           Click on the grade improvement button. Thereafter select the courses that you wish to pre-register.<br>
(c)           A fee receipt will be generated for the courses that are ticked by the students.<br>
(d)           The payment should be made to the Accounts Section. The receipt so obtained should be deposited with the Registry<br>
(e)           Thereafter,proceed with the pre-registration process as given above.<br>--->

</font><p style="margin: 3pt 0cm 0pt; text-align: justify;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">Special
Instructions for Pre- Registration<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l4 level1 lfo4;" class="MsoNormal"><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;"><span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">
(a)           Electives will be allotted based on CGPA criterion, where the number of seats are fixed for the electives.<br>
(b)           Incase courses dropped/CGPA criteria not met next course in order of priority with in the basket shall be taken into consideration.<br>
(c)           No changes shall be allowed on pre-registered courses<br>
(d)           Once the subjects are properly ticked the student shall have 2 options;<br>
> Click on Save draft<br>
>  Click on Freeze.<br>
(e)           In case student presses on Save Draft then he/she shall be able to re-access the draft and modify it.<br>
(f)            In case student presses freeze then the choices of subjects are frozen and treated as final.<br>
(g)           In case student fails to freeze the choice it will automatically be locked on the last announced date.<br>
(h)           Please retain a copy of frozen choices for future reference<br>

<!--</font><p style="margin: 3pt 0cm 0pt; text-align: justify;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">In case student fails to pre-register, he / she may:-<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l1 level1 lfo5;" class="MsoNormal"><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;"><span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">


(a)           Register only for non-clashing courses during regular registration as time table would have already been made without considering the choices. No other choices shall be provided.<br>
(b)           Pay a fine of Rs. 500/- for delay.<br>-->



<!-- <p style="margin: 3pt 0cm 0pt 27pt; text-align: justify; text-indent: -27pt; tab-stops: list 27.0pt; mso-list: l4 level1 lfo4;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><span style='letter-spacing: -0.2pt; font-family: "Calibri","sans-serif"; font-size: 10pt; mso-fareast-font-family: Calibri;' lang="EN-US"><span style="mso-list: Ignore;">(i)<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span></b><b style="mso-bidi-font-weight: normal;"><span style='letter-spacing: -0.2pt; font-family: "Calibri","sans-serif"; font-size: 10pt; mso-bidi-font-family: Tahoma;' lang="EN-US">NO ADD/DROP SHALL BE
PERMITTED ONCE STUDENT HAS FROZEN THE COURSES<o:p></o:p></span></b></p><font face="Times New Roman"> -->

</font><p style="margin: 0cm 0cm 0pt; text-align: justify;" class="MsoNormal"><b><span style='font-family: "Tahoma","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US"><o:p>&nbsp;</o:p></span></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: justify;" class="MsoNormal"><b><span style='font-family: "Tahoma","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US"><o:p>&nbsp;</o:p></span></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: justify;" class="MsoNormal"><b><span style='font-family: "Tahoma","sans-serif"; font-size: 10pt; mso-bidi-font-family: "Times New Roman";' lang="EN-US">Registrar</span></b></p><font face="Times New Roman">
</font>

	<font color="RED" face=verdana Size=5><b><a href='PRStudentEntry.jsp'>Click to proceed with Pre-Registration Process</a></b></font><br>
	<font color="RED" face=verdana Size=5><b><a href='PRStudentEntry_dual.jsp'>Click to proceed with Pre-Registration Process(For DUAL 10Sem M.Tech Only)</a></b></font><br>


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
	<br>For assistance, contact your network support team. <br><br><br>
	</font>
   <%
   }
	  //-----------------------------
}
else
{
%>
<br>
Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
<%
}
}
catch(Exception e)
{
	out.print(e);
}
%>
</body>
</Html>