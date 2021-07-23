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
	' * Author:		Vijay Kumar
	' * Date:		07th Oct 2008
	' * Version:	1.0								
	' * Description:	Pre Registration of Students [Choices for Back & Curr Core+Elective+FreeElective]
*************************************************************************************************
*/

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JUIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subject Selection for the comming classes(Pre Registration of Students) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<Html>
<head>
 <script>
<!--
if(window.history.forward(1) != null)
window.history.forward(1);
-->
</script>
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
OLTEncryption enc=new OLTEncryption();
mSname=session.getAttribute("MemberName").toString().trim();
mSCode=enc.decode(session.getAttribute("MemberCode").toString().trim());
	String  mStartDate="",mEndDate="";
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
		//out.print(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{

	//mComp=session.getAttribute("CompanyCode").toString().trim();
	mInst=session.getAttribute("InstituteCode").toString().trim();
	mDID=enc.decode(session.getAttribute("MemberID").toString().trim());

	
qry=" SELECT distinct examcode, regcode    FROM preventmaster  WHERE institutecode = '"+mInst+"'  AND NVL (prcompleted, 'N') = 'N'  AND NVL (prbroadcast, 'N') = 'Y'  AND prrequiredfor = 'S'  AND NVL (deactive, 'N') = 'N'   AND TRUNC (SYSDATE) >= TRUNC (fromdate)  AND TRUNC (SYSDATE) <= TRUNC (endate)";
	rs=db.getRowset(qry);
	// out.print(qry);
	if (rs.next())
		mExam=rs.getString(1);
	
String mYear=""; 

qry1="select  TO_CHAR(FROMDATE,'DD Month YYYY')FROMDATE,TO_CHAR(ENDATE,'DD Month YYYY') ENDATE ,TO_CHAR (endate, 'YYYY')+1 endate11 from PREVENTMASTER Where  INSTITUTECODE='"+mInst+"' and examcode='"+mExam+"' AND NVL(PRREQUIREDFOR,'N')='S'";
	rs1=db.getRowset(qry1);
//out.print(qry1);
	if (rs1.next())
		{
		mStartDate=rs1.getString("FROMDATE");
		mEndDate=rs1.getString("ENDATE");
		mYear=rs1.getString("endate11");
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
qry=qry+"  where C.institutecode='"+mInst+"'  And B.institutecode=C.institutecode And C.studentid= '"+mChkMemID+"' And B.SubjectID=C.SubjectID   And nvl(C.REGISTEREXAMCODE,'"+mExam+"')='"+mExam+"' "; 
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
<td><font color=white><b>Semester</b></font></td><td><font color=white><b>Subject</b></font></td><td><font color=white><b>Subject Type</b></font></td><td><font color=white><b>Credit</b></font></td></td><td><font color=white><b>Present Status</b></font></td>
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

				qry="Select  SubjectID from ( ";
				qry=qry+" (Select B.SubjectID  From ProgramSubjectTagging B ";
				qry=qry+" where B.institutecode='"+mInst +"' And B.ExamCode='"+mExam+"' ";
				qry=qry+" And B.semester<="+(mSem-1)+" and B.subjectID='"+ mSubjID +"')";
				qry=qry+" union ";
				qry=qry+" (select A.SUBJECTID from PR#ELECTIVESUBJECTS A";
				qry=qry+"  where A.institutecode='"+mInst+"' And A.ExamCode='"+mExam+"' And A.SubjectID='"+mSubjID+"'";
				qry=qry+"  and A.semester<"+(mSem-1)+" ) ";						
				qry=qry+"  union ";
				qry=qry+" (select A.SUBJECTID From OFFERSUBJECTTAGGING A";
				qry=qry+"  where A.institutecode='"+mInst+"' And A.ExamCode='"+mExam+"' ";
				qry=qry+"  and A.subjectID='"+ mSubjID +"'))";					 
				//out.println(qry);
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
	
%>
<font color=Green face=verdana Size=4><b><a href='PRStudentEntry.jsp'>Click to proceed Registration Process</a></b></font>	<br>
<br><title>ONLINE PRE-REGISTRATION : STUDENTS </title>

 

<style>
 /* Style Definitions */
 table.MsoNormal
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:10.0pt;
	font-family:"Times New Roman";
	mso-ansi-language:#0400;
	mso-fareast-language:#0400;
	mso-bidi-language:#0400;}
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=EN-US link=blue vlink=purple style='tab-interval:.5in'>
<div class=Section1>
<font face="Times New Roman">
</font><p style="margin: 0cm 0cm 0pt; text-align: center; line-height: normal;" class="MsoNormal" align="center"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">ONLINE
PRE-REGISTRATION : STUDENTS FOR EXAM : <%=mExam%><o:p></o:p></span></u></b></p>

<!--<font face="Times New Roman"></font>-->

<p style="margin: 0cm 0cm 0pt; text-align: center; line-height: normal;" class="MsoNormal" align="center"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p><span style="text-decoration: none;">&nbsp;</span></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: center; line-height: normal;" class="MsoNormal" align="center"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">LAST
DATE OF FREEZING IS <%=mEndDate%><o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -36pt; mso-add-space: auto; mso-list: l2 level1 lfo1;" class="MsoListParagraphCxSpFirst"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">1.<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Pre-registration shall be carried out
for the students of all programs/semesters.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -36pt; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -36pt; mso-add-space: auto; mso-list: l2 level1 lfo1;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">2.<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">The pre-registration shall be done
through the web kiosk.<span style="mso-spacerun: yes;">&nbsp; </span>The system shall
allow the student to proceed with pre-registration in following priority only:<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo2;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">a)<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Priority 1 </span></b><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><span style="mso-spacerun: yes;">&nbsp;</span>-<span style="mso-spacerun: yes;">&nbsp;
</span>Backlog core papers on offer<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo2;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">b)<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Priority 2 </span></b><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><span style="mso-spacerun: yes;">&nbsp;</span>- <span style="mso-tab-count: 1;"> </span>Current
Core papers on offer<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo2;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">c)<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Priority 3<span style="mso-spacerun: yes;">&nbsp; </span>- </span></b><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Compulsory
elective e.g. HSS Course of 8<sup>th</sup> Semester<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l0 level1 lfo2;" class="MsoListParagraphCxSpLast"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">d)<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Priority 4 - </span></b><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">other
electives on offer (Student can take only one elective out of the department ) <sup></sup>.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -36pt; mso-add-space: auto; mso-list: l2 level1 lfo1;" class="MsoListParagraphCxSpFirst"><span style='font-family: "Times New Roman","serif"; font-size: 10pt; mso-fareast-font-family: "Times New Roman";' lang="EN-US"><span style="mso-list: Ignore;">3.<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">The
pre-registration shall be carried out from <%=mStartDate%> <span style="mso-spacerun: yes;">&nbsp;</span> till <%=mEndDate%> , after
which the webkiosk window shall automatically close </span></b><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">and
hence pre-registration facility thereafter shall not be available to the
students.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">How to use webkiosk for pre-registration<o:p></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><b style="mso-bidi-font-weight: normal;"><u><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p><span style="text-decoration: none;">&nbsp;</span></o:p></span></u></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l3 level1 lfo5;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">F<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Students
shall thereafter be able to view the courses on offer as per the priority given
above. The system would have automatically pre-register the students with the
core courses (backlog as well as current on offer) up to the authorized credit
limit.<span style="mso-spacerun: yes;">&nbsp; </span><!--In case the credit limit is
exceeded before all core courses of the semester for which pre-registration is being
carried out are registered (backlog + odd semester 2018) then the students
shall get an option to tick the choice of odd semester 2018 core-course that
he/she wishes to opt by un-checking the courses that are not<span style="mso-spacerun: yes;">&nbsp; </span>to be opted by the student.--><o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l3 level1 lfo5;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">F<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Thereafter,
the student should tick the windows in following sequence:<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l1 level1 lfo3;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Symbol; font-size: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">HSS courses as per the priority i, ii
&amp; iii�. (you shall automatically be allotted one course with highest
priority in case of any course being dropped).<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l1 level1 lfo3;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Symbol; font-size: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">All other electives in order of priority.<span style="mso-spacerun: yes;">&nbsp; </span>If you do not select the priority for all the
listed elective course the system shall not allow you to save and will be treated as unregistered.<span style="mso-spacerun: yes;">&nbsp; </span>In case the student exceeds the credit limit
due to core courses or backlog courses the system will not allow full
complement of elective courses and shall restrict the allotment upto the
maximum permissible credits.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l1 level1 lfo3;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Symbol; font-size: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Once the subjects are properly ticked
the student shall have 2 options;<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; mso-add-space: auto;" class="MsoListParagraphCxSpMiddle"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 72pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l4 level1 lfo4;" class="MsoListParagraphCxSpMiddle"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Click
the save draft<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 72pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l4 level1 lfo4;" class="MsoListParagraphCxSpLast"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">Click
the Freeze.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l1 level1 lfo3;" class="MsoListParagraphCxSpFirst"><span style="font-family: Symbol; font-size: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">In case student presses on <u>save draft</u>
then he/she shall be able to re-access the draft and modify it.<span style="mso-spacerun: yes;">&nbsp; </span>In this case student should login again in
the webkiosk and proceed with modification of subjects which were last saved as
a draft under pre-registration.<span style="mso-spacerun: yes;">&nbsp; </span>However,
this option can be exercised only upto <%=mEndDate%>.<span style="mso-spacerun: yes;">&nbsp; </span><!--Thereafter, the choices filled in will
automatically be locked.--><o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 54pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l1 level1 lfo3;" class="MsoListParagraphCxSpLast"><span style="font-family: Symbol; font-size: 10pt; mso-fareast-font-family: Symbol; mso-bidi-font-family: Symbol;" lang="EN-US"><span style="mso-list: Ignore;">�<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">In case student presses freeze then the
choices of subjects are frozen and treated as final.<span style="mso-spacerun: yes;">&nbsp; </span><!--In case student fails to freeze the choice it
will automatically be locked on <%=mEndDate%> .--><o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l3 level1 lfo5;" class="MsoListParagraph"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">F<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">In
case any elective course is chosen on a higher priority by a student and
dropped by the department because of poor subscription or any other reason than
the student will be given the elective of lower choice as per the priority
already assigned.<o:p></o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal; text-indent: -18pt; mso-add-space: auto; mso-list: l3 level1 lfo5;" class="MsoListParagraph"><span style="font-family: Wingdings; font-size: 10pt; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings;" lang="EN-US"><span style="mso-list: Ignore;">F<span style='font: 7pt/normal "Times New Roman"; font-size-adjust: none; font-stretch: normal;'>&nbsp; </span></span></span><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">NO ADD/DROP SHALL BE PERMITTED ONCE
STUDENT HAS FREEZED THE COURSE.<o:p></o:p></span></b></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt 36pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">

</font><p style="margin: 0cm 0cm 0pt; text-align: justify; line-height: normal;" class="MsoNormal"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US"><o:p>&nbsp;</o:p></span></p><font face="Times New Roman">


</font><p style="margin: 0cm 0cm 0pt; text-align: justify; line-height: normal;" class="MsoNormal"><b style="mso-bidi-font-weight: normal;"><span style='font-family: "Times New Roman","serif"; font-size: 10pt;' lang="EN-US">REGISTRAR<o:p></o:p></span></b></p><font face="Times New Roman">

</font>


</div>
	
<!-- <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:0in;
margin-left:.5in;margin-bottom:.0001pt;text-align:justify;text-indent:-.5in;
mso-list:l4 level1 lfo1;tab-stops:list .5in'><![if !supportLists]><span
style='font-size:10.0pt;font-family:Tahoma;mso-fareast-font-family:Tahoma;
mso-bidi-font-weight:bold'><span style='mso-list:Ignore'>4.<span
style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</span></span></span><![endif]><b><span style='font-size:10.0pt;font-family:Tahoma'>(a) Pre- Registration will be done through any Laboratory/LRC or personal computer.<br>
<br>(b)	All HODs are requested to nominate a faculty member to facilitate the process.
<o:p></o:p></span></p>	
<p class=MsoNormal style='margin-top:3.0pt;text-align:justify'><b><span
style='font-size:10.0pt;font-family:Tahoma'><o:p>&nbsp;</o:p></span></b></p> -->

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