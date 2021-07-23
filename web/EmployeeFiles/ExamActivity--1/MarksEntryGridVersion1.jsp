<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ taglib prefix="ntb" uri="http://www.nitobi.com"%>
<html xmlns:ntb>
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
session.setAttribute("CurrEvent","");
session.setAttribute("PrevEvent","");

response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
%>
<head>
  
<TITLE>#### <%=mHead%> [ Event-Wise Marks Entry ] </TITLE>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
        <link type="text/css" rel="stylesheet" href="../css/style/nitobi.grid.css">
        <link type="text/css" rel="stylesheet" href="../css/style/callout/xp/nitobi.callout.css">
        <link type="text/css" rel="stylesheet" href="../css/style/nitobi.combo.css">
        <script type="text/javascript" src="../js/script/toolkit.js"></script>
        <script type="text/javascript" src="../js/script/nitobi.grid.js"></script>
        <script type="text/javascript" src="../js/script/nitobi.callout.js"></script>
        <script type="text/javascript" src="../js/script/nitobi.combo.js"></script>

<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->
</script>

 <script language="javascript">
function kH(e) {

var pK = document.all? window.event.keyCode:e.which;
return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>


<script language="text/javascript">
function showAlert()
{
 if(document.frm2("Proceed").checked==true)
 {
	alert('Once You will check and Lock , You cannot enter marks of the rest students further');
 }
 else
 {
	alert('You cannot proceed for Grade Entry until you check it and Lock it.');
 }
}

//-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
function runCallout()
{
// Create a new callout with the 'xp' style
myCallout = new nitobi.callout.Callout("xp");

// use attachToElement to bind it to the form field (using ID, not NAME)
myCallout.attachToElement('columnheader_3_ntb__1');

// set the title of the element
myCallout.setTitle('New Version of Marks Entry!');

// set the body
myCallout.setBody('Enter marks directly or Copy-Paste from Excel enabled page. You are requested to keep SAVING. ');

// show it
myCallout.show();
}
</script>
<style type="text/css">
<!--
BODY{
scrollbar-face-color:#fce9c5;
scrollbar-arrow-color:darkpink;
scrollbar-track-color:darkpink;
scrollbar-shadow-color:'white';
scrollbar-highlight-color:'lightgray';
scrollbar-3dlight-color:'blue';
scrollbar-darkshadow-Color:'gray';
}
-->
</style>
</head>

<body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
  
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="";
String qry="",qry1="",x="",msubsection="",mPrint="";
int msno=0;
int len =0;
int pos=0;
String mSE="", mMaxMarks="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0,flag=0;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="",mPrevEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsmm=null,rschk1=null;
String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",mName4="",mName7="";

session.setMaxInactiveInterval(10800);
session.setAttribute("Click",mSelf);

if (session.getAttribute("Designation")==null)
	mDesg="";
else
	mDesg=session.getAttribute("Designation").toString().trim();
if (session.getAttribute("Department")==null)
	mDept="";
else
	mDept=session.getAttribute("Department").toString().trim();
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();
if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
try
{
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
                %>
        	<form name="frm" method="get" >
                <input id="x" name="x" type=hidden>
							<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0 border=1>

				<tr>
			<td align=center><font face=arial size=3 color=Black><B>Marks Entry Status </font></B></td>
			
			</tr>
			<tr>
			<td nowrap valign=top>
			<Table valign=top width=100% border=0 bgcolor=white>
			<tr bgcolor="#ff8c00">
			<td nowrap><font color=white size=3 face=arial><B>Subject</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Co-Ordinator</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Faculty</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Batch</B></font></td>
			<td nowrap><font color=white size=3 face=arial><B>Status</B></font></td>
			</tr>
				<%
					String QryFSTID="",mExamid1=""; 
					qry1="select distinct  GRADEENTRYEXAMID from companyinstitutetagging where INSTITUTECODE='"+mInst+"' and companycode='"+mComp+"' ";
					rs1=db.getRowset(qry1);
					if(rs1.next())
						mExamid1=rs1.getString("GRADEENTRYEXAMID");
					

			qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ') Faculty, nvl(C.EmployeeCode,' ')EmployeeCode FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamid1+"' and a.employeeid='"+mDMemberID+"'";
			qry=qry+" and a.ltp in ('L','P') and a.PROGRAMCODE NOT IN('PHD','PHDP') AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamid1+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' )";
			/*qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM v#studenteventsubjectmarks  WHERE INSTITUTECODE='"+mInst+"' and employeeid='"+mDMemberID+"' AND EXAMCODE='"+mExamid1+"'  and NVL(DEACTIVE,'N')='N')";*/
			qry=qry+"   AND NVL(A.DEACTIVE,'N')='N' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";
			
			/*qry="Select DISTINCT A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.EMPLOYEEID EMPLOYEEID, A.PROGRAMCODE PC, A.SECTIONBRANCH SEC, A.SUBSECTIONCODE SUBSEC, nvl(B.subject,' ')||' ('|| nvl(B.subjectcode,' ')||')' Subject, nvl(C.EmployeeName,' ') Faculty, nvl(C.EmployeeCode,' ')EmployeeCode FROM FACULTYSUBJECTTAGGING A, SubjectMaster B, EmployeeMaster C WHERE A.INSTITUTECODE='"+mInst+"' AND PROGRAMCODE NOT IN('PHD','PHDP') AND A.EXAMCODE='"+mExamID+"'";
			qry=qry+" AND A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and A.EMPLOYEEID=C.EMPLOYEEID AND C.DEPARTMENTCODE=DECODE('"+QryDept+"','All',C.DEPARTMENTCODE,'"+QryDept+"') ";
			qry=qry+"  AND A.SUBJECTID IN (SELECT SUBJECTID FROM PROGRAMSUBJECTTAGGING WHERE  EXAMCODE='"+mExamID+"' AND INSTITUTECODE='"+mInst+"' AND P <> 0  and NVL(DEACTIVE,'N')='N') AND  A.SUBJECTID NOT IN(SELECT SUBJECTID FROM v#studenteventsubjectmarks      WHERE institutecode ='"+mInst+"'  AND examcode = '"+mExamID+"' AND NVL (deactive, 'N') = 'N' ) ";
			qry=qry+" AND A.FSTID NOT IN (SELECT FSTID FROM v#studenteventsubjectmarks WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EVENTSUBEVENT LIKE '%"+mEventCode+"%'   and NVL(DEACTIVE,'N')='N')";
			qry=qry+" AND A.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND nvl(DEACTIVE,'N')='N' and nvl(STUDENTDEACTIVE,'N')='N' ) ";
			qry=qry+" AND A.LTP='"+QryLTP+"'  AND NVL(A.DEACTIVE,'N')='N' AND A.PROJECTSUBJECT='"+QryProjSubj+"' ORDER BY SUBJECT, Faculty, PROGRAMCODE, SECTIONBRANCH, SUBSECTIONCODE";*/
		
			//out.print(qry);
			rs=db.getRowset(qry);
			String mSub="",mFac="";
			while(rs.next() )
			{
				flag=1;
				
				%>
				<tr>
				<%
				if(!mSub.equals(rs.getString("SUBJECTID")))
				{
					%>
					<td nowrap><Font size=1 face=arial><%=rs.getString("Subject")%></font></td>
					<%
						mSub=rs.getString("SUBJECTID");
				}
				else
				{
					%>
					<td nowrap><Font size=1>-------""-------</font></td>
					<%
				}
				
				
				String qryf="select COORDINATORNAME,COORDINATORcode from V#EX#SUBJECTGRADECOORDINATOR where FSTID='"+rs.getString("FSTID")+"' and subjectid='"+rs.getString("SUBJECTID")+"' AND examcode='"+mExamid1+"' AND INSTITUTECODE='"+mInst+"' ";
					//out.print(qryf);
					ResultSet rsf=db.getRowset(qryf);
				if(rsf.next())
				{
					%>
					<td nowrap><Font size=1 color=red face=arial><%=rsf.getString("COORDINATORNAME")%><br>
					<%=rsf.getString("COORDINATORCODE")%></font></td>
					<%
				}
				else
				{
					%>
					<td nowrap><Font size=1 color=red face=arial>Co-ordinator <BR>Not Defined</font></td>
					<%
				}
				
				if(!mFac.equals(rs.getString("EMPLOYEEID")) )
				{

					%>
					<td nowrap><Font size=1 face=arial><%=rs.getString("Faculty")%><br><%=rs.getString("EmployeeCode")%></font></td>
					<%
						mFac=rs.getString("EMPLOYEEID");
				}
				else
				{
					%>
					<td nowrap><Font size=1>-------""-------</font></td>
					<%
				}
				//}
					%>
				<td nowrap><Font size=1 face=arial><%=rs.getString("PC")%> (<%=rs.getString("SEC")%>-<%=rs.getString("SUBSEC")%>)</font></td>
				<%
				qry="Select nvl(EVENTSUBEVENT,' ')EVENTSUBEVENT  FROM v#EXAMEVENTSUBJECTTAGGING WHERE FSTID='"+rs.getString("FSTID")+"'  AND nvl(DEACTIVE,'N')='N' and subjectid='"+rs.getString("SUBJECTID")+"' ";
				//out.print(qry);AND EVENTSUBEVENT like '%"+mEventCode+"%'
				rs1=db.getRowset(qry);
				if(rs1.next())
				{
					qry="select 'Y' from v#studenteventsubjectmarks where FSTID='"+rs.getString("FSTID")+"' AND nvl(DETAINED,'N')='N'  and nvl(LOCKED,'N')='N' and subjectid='"+rs.getString("SUBJECTID")+"' and EVENTSUBEVENT='"+rs1.getString("EVENTSUBEVENT")+"' and MARKSAWARDED2 is NOT null";
					//and and MARKSAWARDED1 isNOT null and MARKSAWARDED2 isNOT null";  AND EVENTSUBEVENT='"+mEventCode+"'
					rschk1=db.getRowset(qry);
				//	out.print(qry);
					if(rschk1.next())
					{
						%>							
							<td nowrap><Font size=2 face=arial><b><%=rs1.getString("EVENTSUBEVENT")%></b><BR><Font size=2 COLOR=RED face=arial><b>Marks  Entered <BR> but not locked</b></font></td>
						<%
						
					}
					else
					{
							qry1="select 'Y' from v#studenteventsubjectmarks where FSTID='"+rs.getString("FSTID")+"' AND nvl(DETAINED,'N')='N'  and nvl(LOCKED,'N')='Y' and subjectid='"+rs.getString("SUBJECTID")+"' and EVENTSUBEVENT='"+rs1.getString("EVENTSUBEVENT")+"' ";
					//and and MARKSAWARDED1 isNOT null and MARKSAWARDED2 isNOT null";  AND EVENTSUBEVENT='"+mEventCode+"'
					rs2=db.getRowset(qry1);	
						if(rs2.next())
						{
							%>							
							<td nowrap><Font size=2 face=arial><b><%=rs1.getString("EVENTSUBEVENT")%></b><BR><Font size=2 COLOR=green face=arial><b>Marks Entered and Locked </b></font></td>
							<%
						}
						else
						{
							%>							
							<td nowrap><Font size=2 face=arial><b><%=rs1.getString("EVENTSUBEVENT")%></b><BR><Font size=2 COLOR=Blue face=arial><b>Marks Not Entered  </b></font></td>
							<%
						}
						
						
					}
				}
				else 
				{
					 qry1="select COORDINATORNAME from V#EX#SUBJECTGRADECOORDINATOR where FSTID='"+rs.getString("FSTID")+"' AND examcode='"+mExamid1+"' AND INSTITUTECODE='"+mInst+"' and subjectid='"+rs.getString("SUBJECTID")+"' ";
					//out.print(qry1);
					ResultSet rsg=db.getRowset(qry1);
					if(rsg.next())
					{
					%>
					<td nowrap><Font size=1 COLOR=PURPLE face=arial><b>Pre-Marks Entry <BR>Not Done by Faculty</b></font></td>
					<%
					}
					else
					{
						%>
					<td nowrap><Font size=1 COLOR=red face=arial><b>Co-ordinator Not Defined</b></font></td>
					<%
					}
				}
				%>
				</tr>
				<%
			}
					 //out.print("sdafsfsf");
					%>


                <table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
                <tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B>Event/Sub Event wise Students Marks Entry</B></TD>
                </font></td></tr>
                </TABLE>

                <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
                <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
                &nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
                </td></tr>
                <!--Institute****-->
                <tr><td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
                <%
                try
                {
                    qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInst+"' and nvl(Deactive,'N')='N' ";
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(""))
                                minst=mInst;
                            %>
                            <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                            <%
                        }
                        %>
                        </select>
                        <%
                     }
                     else
                     {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(request.getParameter("InstCode").toString().trim()))
                            {
                                %>
                                <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                                <%
                            }
                            else
                            {
                                %>
                                <OPTION Value =<%=mInst%>><%=mInst%></option>
                                <%
                            }
                        }
                        %>
                        </select>
                        <%
                    }
                }
                catch(Exception e)
                {
                    //out.println(e.getMessage());
                }
                %>
                <!--*********Exam**********-->
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
                    try
                    {
				qry=" Select GRADEENTRYEXAMID from (";
				qry+=" Select nvl(EXAMCODE,' ') GRADEENTRYEXAMID, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
           			qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging Where INSTITUTECODE='"+mInst+"')";
		            //qry+=" and examcode in (select nvl(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
     			      qry+=" order by EXAMPERIODFROM DESC";
				qry+=") where rownum<8 ORDER BY 1 DESC"; 

                  
                        rs=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
                                %>
                                <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
                                if(mExamid.equals(request.getParameter("Exam").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                                    <%
                                }
                            }
                            %>
                            </select>
                            <%
                        }
                    }
                    catch(Exception e)
                    {
                        //out.println(e.getMessage());
                    }
                    %>
                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                    <%
                    try
                    {
                        qry="select EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING  Where INSTITUTECODE='"+mInst+"' AND ";
                        qry=qry+"  trunc(sysdate) >= trunc(FROMDATE) and trunc(sysdate) <= trunc(TODATE) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  AND (fstid) in ((select fstid from facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR LTP='P') AND INSTITUTECODE='"+mInst+"' AND  PROJECTSUBJECT='N' ";
                       /* qry=qry+" UNION select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' AND FSTID NOT IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE PROJECTSUBJECT='Y')
					   */
					   qry=qry+")";
                        qry=qry+" UNION select fstid from EX#SUBJECTGRADECOORDINATOR where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"' AND FSTID NOT IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE PROJECTSUBJECT='Y'))";
                        qry=qry+"GROUP BY EVENTSUBEVENT ORDER BY EVENTSUBEVENT";
                        //out.print(qry);trunc(SYSDATE) >= trunc(fromperiod)   and  trunc(SYSDATE) <= trunc(toperiod)
                        rse=db.getRowset(qry);

                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION selected Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
                                %>
                                <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
                                if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                            }
                            %>
                            </select>
                            <%
                        }
                        //out.println("Subevent"+mEventsubevent);
                    }
                    catch(Exception e)
                    {
                        //out.print("error");
                    }
                    %>
                    </td></tr>
                    <tr><td nowrap>
                    <!--SUBJECT**************-->
                    <FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
                    <%
                    try
                    {
                        qry="select subject||' ( '||subjectcode||' )' subject, subjectID from V#EXAMEVENTSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' AND  ";
                        qry=qry+" trunc(sysdate) >= trunc(FROMDATE) and trunc(sysdate) <= trunc(TODATE)  and facultytype=decode('"+mDMemberType+"','E','I','E')";
                        qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  AND (fstid) in ((select fstid from  facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and nvl(deactive,'N')='N' AND (LTP='L' OR LTP='P') AND INSTITUTECODE='"+mInst+"' AND  PROJECTSUBJECT='N' ";
                       /* qry=qry+" UNION select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' AND FSTID NOT IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE PROJECTSUBJECT='Y')*/
						qry=qry+" )";
                        qry=qry+" UNION select fstid from EX#SUBJECTGRADECOORDINATOR where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"' AND FSTID NOT IN (SELECT FSTID FROM FACULTYSUBJECTTAGGING WHERE PROJECTSUBJECT='Y'))";
                        qry=qry+" GROUP BY subject||' ( '||subjectcode||' )',subjectID";
                      // out.print(qry);
                        rss=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 440px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSC.equals(""))
                                        mSC=mSubj;
                                        %>
                                        <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                        <%
                                }
                                %>
                                </select>
                                <%
                        }
                        else
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 440px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSubj.equals(request.getParameter("Subject").toString().trim()))
                                        {
                                                mSC=mSubj;
                                                %>
                                                <OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                                <%
                                        }
                                        else
                                      {
                                                %>
                                        <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                        <%
                                        }
                                }
                                %>
                                </select>
                                <%
                         }
                    }
                    catch(Exception e)
                    {
                    }
                    %>
                    <FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; List order in:</STRONG></FONT></FONT>
                    <select name=listorder tabindex="5" id="listorder" style="WIDTH: 125px">
                    <%
                    if(request.getParameter("listorder")==null)
                    {
                        %>
                        <OPTION Value =EnrollNo selected>Enrollment No.</option>
                        <!--<OPTION Value =Studentname>Student Name</option>
                        <OPTION Value =Subsectioncode >Subsection/Group</option>-->
                        <%
                    }
                    else
                    {
                        mlistorder=request.getParameter("listorder");
                        if(mlistorder.equals("EnrollNo"))
                        {
                            %>
                            <OPTION Value =EnrollNo selected>Enrollment No.</option>
                            <!--<OPTION Value =Studentname>Student Name</option>
                            <OPTION Value =Subsectioncode>Subsection/Group</option>-->
                            <%
                        }
                    }
                    %>
                    </select>
                    <select name=order tabindex="6" id="order" style="WIDTH: 105px">
                    <%
                    if(request.getParameter("order")==null)
                    {
                        %>
                        <OPTION Value =Asc selected>Ascending</option>
                        <!--<OPTION Value =Desc>Descending</option>-->
                        <%
                    }
                    else
                    {
                        mlistorder=request.getParameter("order");
                        if(mlistorder.equals("Asc"))
                        {
                            %>
                            <OPTION Value =Asc selected>Ascending</option>
                            <!--<OPTION Value =Desc>Descending</option>-->
                            <%
                        }
                    }
                    %>
                    </select>
                    </td></tr>
                    <tr><td nowrap>
                    <%
                    String sel="";
                    if(request.getParameter("x")==null)
                    {
                        %>
                        <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                        &nbsp;
                        <INPUT TYPE="radio" NAME="Click" Value='All'>
                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                        <%
                    }
                    else
                    {
                        if(request.getParameter("Click")!=null)
                        {
                                if(request.getParameter("Click").equals("Self"))
                                {
                                        %>
                                        <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                        &nbsp;
                                        <INPUT TYPE="radio" NAME="Click" Value='All' >
                                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                        <%
                                }
                                else
                                {
                                        %>
                                        <INPUT TYPE="radio" NAME="Click" Value='Self'>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                        &nbsp;
                                        <INPUT TYPE="radio" NAME="Click" Value='All' checked>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                        <%
                                }
                        }
                        else
                        {
                                %>
                                <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                                <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                &nbsp;
                                <INPUT TYPE="radio" NAME="Click" Value='All' checked>
                                <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                <%
                        }
                }
                %>
                &nbsp;<INPUT Type="submit" Value="Show/Refresh" >
                </td></tr>
                </table>
                </form>
                <%
                if(request.getParameter("x")!=null)
                {
                    //out.print("mSelf"+mSelf);
                    if(request.getParameter("Click")!=null && request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
                    {
                		mSelf=request.getParameter("Click");
                		mIC=request.getParameter("InstCode").toString().trim();
                        mEC=request.getParameter("Exam").toString().trim();
                        mSC=request.getParameter("Subject").toString().trim();
                        mList=request.getParameter("listorder").toString().trim();
                        mOrder=request.getParameter("order").toString().trim();
                        mEvent=request.getParameter("Event").toString().trim();

                        session.setAttribute("Click",mSelf);
                        session.setAttribute("InstCode",mIC);
                        session.setAttribute("Exam",mEC);
                        session.setAttribute("Subject",mSC);
                        session.setAttribute("listorder",mList);
                        session.setAttribute("order",mOrder);
                        session.setAttribute("Event",mEvent);
                        len=mEvent.length();
                        pos=mEvent.indexOf("#");
                        if(pos>0)
                        {
                        	mSE=mEvent.substring(0,pos);
                        }
                        else
                        {
                        	mSE=mEvent.toString().trim();
                        }
                        if(!mEC.equals("NONE") && !mEvent.equals("NONE"))
                        {
                        if(mSelf.equals("Self"))
                        {
                            qry="select 'Y' from V#EXAMEVENTSUBJECTTAGGING";
                            qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                            qry=qry+" examcode='"+mEC+"' and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' ";
                            qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  AND ((EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
                            qry=qry+" AND EVENTSUBEVENT='"+mEvent+"' " ;
                            qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                		}
                        else
                        {
                            qry="select 'Y' from V#EXAMEVENTSUBJECTTAGGING";
                            qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N'  ";
                            qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  and examcode='"+mEC+"'  and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' ";
                            qry=qry+" And EVENTSUBEVENT='"+mEvent+"' " ;
                            qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mChkMemID+"')";
                            qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                        }
                        rsmm=db.getRowset(qry);
				//out.print(qry);
                        if(rsmm.next())
                        {
                            qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";
                            qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mSE+"' ";
                            //out.println("dfs "+qrys);
                            ResultSet rsStatus=db.getRowset(qrys);
                            if(rsStatus.next())
                            {
                                mStatus=rsStatus.getString("detainedstatus");
                            }
                            if(mStatus.equals("D"))
                			  mPrint="Detained";
                            else if(mStatus.equals("A"))
                                mPrint="Absent";
                            else
                                mPrint="Absent/Detained";
                            if(mSelf.equals("Self"))
                            {
                                qry="select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                                qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
                                qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  AND ((EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual))  ) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                                qry=qry+" And EVENTSUBEVENT='"+mEvent+"' and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N' ";
                            }
                            else
                            {
                                qry="select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                                qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
                                qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  And EVENTSUBEVENT='"+mEvent+"'  ";
                                qry=qry+" and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N'";
                            }
                        //   out.print(qry);
                            rsm=db.getRowset(qry);
                            if(rsm.next())
                            {
                                mMOP=rsm.getString("MARKSORPERCENTAGE");
                                mMaxmarks=rsm.getDouble("MAXMARKS");
                                mWeight=rsm.getDouble("WEIGHTAGE");
                            }
				    mMaxMarks=mMaxmarks+"";
                            session.setAttribute("MAXMARKS",mMaxMarks);

                            if (mMOP.equals("M"))
                                MyMax=mMaxmarks;
                            else
                                MyMax=100;

                            if(mMOP.equals("M"))
                            {
                                %>
					  <CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></FONT></CENTER>
                                <%
                            }
                            else
                            {
                                %>
					  <CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Full Marks for Evaluation :&nbsp;</STRONG><%=mMaxmarks%></FONT>
                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <FONT color=navy face=Arial size=2><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></FONT></CENTER>
                                <%
                            }
                            //out.println("Self/Other:- "+mSelf+" Inst:- "+mIC+" Exam:- "+mEC+" Subject:- "+mSC+" List:- "+mList+" Order:- "+mOrder+" EventSubEvent:- "+mEvent+" Event:- "+mSE);
                            session.setAttribute("CurrEvent",mEvent);
                            %>
                            <table align=center>
                            <tr>
                            <td nowrap>
				<!--frozenleftcolumncount="1"rowinsertenabled="false" sortenabled="true" rowsperpage="5" autosaveenabled="1" gridresizeenabled="false"
				rowdeleteenabled="true"
						  rowinsertenabled="true"
						   toolbarenabled="true"
						  gridresizeenabled="true"
						  mode="livescrolling"
						  autosaveenabled="1" 	-->
<script type="text/javascript">


function afterPaste(eventArgs){
   
     var maxmarks = ${sessionScope['MAXMARKS']};
       var myMasterGrid = nitobi.getComponent('SimpleGrid1');
    var begin=eventArgs.coords.bottom.y;
    var end =(eventArgs.data.split("\n").length-1) +begin;
     var errorocc=false;
    
    for(var rowNum=begin;rowNum<end;rowNum++){
    
        var value = myMasterGrid.getCellObject(rowNum,3).getValue().toUpperCase();
      
        myMasterGrid.getCellObject(rowNum,3).setValue(value);
        if(value!='' && value!='A' && value!='D'){
            var textBoxValue= value;
            var ValidChars="0123456789.";
            var Chars;
            var deccount=0;
            var flag=false;
            var decpoint=0;

            for(var i=0;i<textBoxValue.length;i++)
            {
                Chars = textBoxValue.charAt(i);
                if(ValidChars.indexOf(Chars) == -1)
                {
                    //alert('Invalid Marks!'+rowNum);
                    errorocc=true;
                    
                    clearcell(myMasterGrid,rowNum,value);
                    break;
                }
                if(Chars=='.'){
                    flag=true;
                    decpoint++;
                }

                if(flag){
                    deccount++;
                }
            }
			
            if(decpoint>0 && deccount==1){
               //  alert("Invalid marks!"+rowNum);
               errorocc=true;

               clearcell(myMasterGrid,rowNum);
                  continue;
            }
            if(decpoint>1){
                // alert("Invalid marks!"+rowNum);
                errorocc=true;
                clearcell(myMasterGrid,rowNum);
                   continue;
            }
            if(deccount>3){
              //  alert("Invalid marks!"+rowNum);
              errorocc=true;
              clearcell(myMasterGrid,rowNum);
                continue;
            }
        if(value.length>5){
          //  alert("Invalid marks!"+rowNum);
          errorocc=true;
           
           clearcell(myMasterGrid,rowNum);
             continue;
        }else{
            if(value>maxmarks){
               // alert('Marks Must be <='+maxmarks);
               errorocc=true;
                clearcell(myMasterGrid,rowNum);
                continue;
            }

        }
}
 checkifupdated(myMasterGrid,rowNum,myMasterGrid.getCellObject(rowNum,3).getValue());
    }
    if(errorocc){
        alert("Invalid Marks!");
    }
    displayUpdated(myMasterGrid);
}
function clearcell(myMasterGrid,rowNum){
    myMasterGrid.getCellObject(rowNum,3).setValue("");
     checkifupdated(myMasterGrid,rowNum,"");
}
function cellclick(eventArgs){

    var maxmarks = ${sessionScope['MAXMARKS']};
var myRow = eventArgs.cell.getRow();
var myMasterGrid = nitobi.getComponent('SimpleGrid1');
var value = myMasterGrid.getCellObject(myRow,3).getValue().toUpperCase();
myMasterGrid.getCellObject(myRow,3).setValue(value);
    //alert(isNaN(parseFloat(value)));
    if(value!='' && value!='A' && value!='D'){

       
            var textBoxValue= value;
            var ValidChars="0123456789.";
            var Chars;
            var deccount=0;
            var flag=false;
            var decpoint=0;
            for(var i=0;i<textBoxValue.length;i++)
            {
                Chars = textBoxValue.charAt(i);
                if(ValidChars.indexOf(Chars) == -1)
                {
                    alert('Invalid Marks!');

                    myMasterGrid.getCellObject(myRow,3).setValue("");
                    break;
                }
                if(Chars=='.'){
                    flag=true;
                    decpoint++;
                }

                if(flag){
                    deccount++;
                }
            }
            if(decpoint>0 && deccount==1){
                 alert("Invalid marks!");
                 myMasterGrid.getCellObject(myRow,3).setValue("");
                   
            }
            if(decpoint>1){
                 alert("Invalid marks!");
                 myMasterGrid.getCellObject(myRow,3).setValue("");
                   
            }
            if(deccount>3){
                alert("Invalid marks!");
                myMasterGrid.getCellObject(myRow,3).setValue("");
               
            }
        if(value.length>5){
            alert("Invalid marks!");
            myMasterGrid.getCellObject(myRow,3).setValue("");
             
        }else{
            if(value>maxmarks){
                alert('Marks Must be <='+maxmarks);
                myMasterGrid.getCellObject(myRow,3).setValue("");
               
            }

        }
}
checkifupdated(myMasterGrid,myRow,myMasterGrid.getCellObject(myRow,3).getValue());

   displayUpdated(myMasterGrid);
}


function beforepaste(eventArgs){
    var copyrows = eventArgs.data.split("\n").length-1;
    var myMasterGrid = nitobi.getComponent('SimpleGrid1');
    var totalrows = myMasterGrid.rowCount;
    var roweff= totalrows -eventArgs.coords.bottom.y;
  
    if(Number(roweff )<Number(copyrows)){
        alert("Paste Failed: No of rows you are attemting to paste exceeds data grid.");
        return false;
    }
}
function checkifupdated(grid,row,newval){
      var myDataTable = grid.getDataSource("_default");

   var myRecord = myDataTable.getRecord(row);
    var dbvalue =myRecord.getAttribute("h");

   if(dbvalue!=newval)    {

       grid.getCellObject(row,7).setValue("y");
   }else{

      grid.getCellObject(row,7).setValue("n");
   }
}
function cellvalidate(eventArgs){
    var mygrid = nitobi.getGrid('SimpleGrid1');
    checkifupdated(mygrid,eventArgs.cell.Row,eventArgs.newValue);
   
   displayUpdated(mygrid);
}
function displayUpdated(gridobj){



 var updatedrecords=0;
    for(var rowNum=0;rowNum<gridobj.rowCount;rowNum++){

        var value = gridobj.getCellObject(rowNum,7).getValue();
        if(value=='y'){
             updatedrecords++;
        }

}
 document.getElementById("updated").value=updatedrecords;
}
function test(eventArgs){
      var mygrid = nitobi.getGrid('SimpleGrid1');
    updatedrecords=0;
    document.getElementById("updated").value =updatedrecords;
    for(var rowNum=0;rowNum<mygrid.rowCount;rowNum++){

        mygrid.getCellObject(rowNum,7).setValue("n");
    }
}
// now we create a new one
</script>
<br>
<font  face="Arial" size="2"><STRONG>No of records changed since last saved:</STRONG></font> <input type="text" readonly="true" size="3" value="0" style="border:none;background-color:#fce9c5;font-weight:bold;font-size:11px;"  id="updated"/>
						  <ntb:grid
						  id="SimpleGrid1"
                          onafterpasteevent="afterPaste(eventArgs)"
                          ondatareadyevent="runCallout()"
                      onbeforepasteevent="beforepaste(eventArgs)"
                        toolbarenabled="true"
						  rowdeleteenabled="false"
						  rowinsertenabled="false"
                        
						 onbeforecopyevent=""
                          onaftercopyevent=""
                      
                            onbeforesaveevent="test(eventArgs)"
						  height="400"
						  copyenabled="true"
						  pasteenabled="true"
						  mode="localnonpaging"
						  gridresizeenabled="false"
						  gethandler="MarksEntryGetHandler.jsp"
						  savehandler="MarksEntrySaveHandler.jsp"
						  entertab="down"
						  >

					  <ntb:columns>
					    <ntb:radiobutton  sortenabled="false" width="50" align="center" label=" Checked " xdatafld="checked" editable="false" type="number" cssstyle="font-size:10pt;font-weight:bold; color:black;"></ntb:radiobutton>

                                <ntb:textcolumn  sortenabled="false" width="50" align="center" label=" Sr. No. " xdatafld="SNo" editable="false" type="number" cssstyle="font-size:10pt;font-weight:bold; color:black;"></ntb:textcolumn>
                                <ntb:textcolumn sortenabled="false" width="100" align="center" label=" Enrollment No. " xdatafld="EnrollNo" editable="false"></ntb:textcolumn>
                                <ntb:textcolumn sortenabled="false" width="175" align="left" label=" Student Name " xdatafld="StudentName" editable="false"></ntb:textcolumn>
                               
                               <ntb:textcolumn  onaftercelleditevent="cellclick(eventArgs)" sortenabled="false" width="100" align="center" label="${sessionScope['CurrEvent']}(Curr.) Marks " xdatafld="Marks" editable="true" cssstyle="font-size:10pt;font-weight:bold; color:Green; background-color:lightgoldenrodyellow;border-color:lightgray; border-width:1; border-bottom-width:thin;"></ntb:textcolumn>
                                <%
                                if(mSelf.equals("Self"))
                                {
                                    qry="SELECT distinct EVENTSUBEVENT||' Marks' EVENTSUBEVENT from V#StudentEventSubjectMarks ";
                                    qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='Y' and nvl(PUBLISHED,'N')='Y' and ";
                                    qry=qry+" examcode='"+mEC+"' and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' ";
                                    qry=qry+" AND ((EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
                                    qry=qry+" AND EVENTSUBEVENT<>'"+mEvent+"' " ;
                                    qry=qry+" Order By EVENTSUBEVENT ";
                                }
                                else
                                {
                                    qry="SELECT distinct EVENTSUBEVENT||' Marks' EVENTSUBEVENT from V#EXAMEVENTSUBJECTTAGGING ";
                                    qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='Y'  ";
                                    qry=qry+"  and  nvl(STUDENTLTPDEACTIVE,'N')='N'  and examcode='"+mEC+"'  and (LTP='L' OR LTP='P') AND PROJECTSUBJECT='N' and subjectID='"+mSC+"' ";
                                    qry=qry+" And EVENTSUBEVENT<>'"+mEvent+"' " ;
                                    qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mChkMemID+"')";
                                    qry=qry+" order by EVENTSUBEVENT ";
                                }
                               // System.out.print("JILIT - "+qry);
                                rs = db.getRowset(qry);
                                int qryCTR=0;
                                while(rs.next())
                                {
                                    qryCTR++;
                                    mPrevEvent=rs.getString(1);
                                    session.setAttribute("PrevEvent",mPrevEvent);
                                    session.setAttribute("Counter",String.valueOf(qryCTR));
                                    %>
                                    <ntb:textcolumn sortenabled="false" width="66" align="center" label="${sessionScope['PrevEvent']}" xdatafld="PMarks${sessionScope['Counter']}" editable="false"></ntb:textcolumn>
                                    <%
                                }
                                %>
                                <ntb:textcolumn sortenabled="false" width="150" align="center" label=" Course (Section/Branch) " xdatafld="Course" editable="false"></ntb:textcolumn>
                                <ntb:textcolumn sortenabled="false" width="75" align="center" label=" Semester " xdatafld="Semester" editable="false"></ntb:textcolumn>
                                 <ntb:textcolumn  xdatafld="MarksHidden" visible="false" ></ntb:textcolumn>
                                 <ntb:textcolumn  xdatafld="Updated"  visible="false" ></ntb:textcolumn>
                               
                            </ntb:columns>
                            </ntb:grid>
                            </td>
                            </tr>
                            <tr>
                                <td align=center valign=top><font size=2 color="black" face=arial><B>Enter 'A' - for Absent &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Enter 'D' - for Detained &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Enter Marks between '0' to '<%=mMaxmarks%>'</B></font></td>
                            </tr>
                            <tr>
                            <TD><form name="frm2" id="frm2" method="post" action="MarksEntryTempPage.jsp"></TD>
                            </tr>
                            <tr>
                            <TD>&nbsp;</TD>
                            </tr>
                            <tr>
                            <td align=center valign=top nowrap><font size=2 color="#993300" face=arial>
				    <form name="frm2" id="frm2" method="post" action="MarksEntryTempPage.jsp">
                            <b>** Lock Marks Entry <input type=checkbox name='Proceed' id='Proceed' value='Y' onclick="return showAlert();">
                            <INPUT NAME="Lock" Type="submit" Value="Lock Marks Entry Now">
				    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				    <INPUT NAME="Excel" Type="submit" Value="Click to Export in Excel">
                            <input type=hidden name='institute' id='institute' value="<%=mIC%>">
                            <input type=hidden name='Exam' id='Exam' value="<%=mEC%>">
                            <input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
                            <input type=hidden name='subjectcode' id='subjectcode' value="<%=mSC%>">
                            </form>
                            </td></tr>
                            <tr><td nowrap>&nbsp;</td></tr>
                            <tr><td nowrap><font color="navy" size=2 face=arial>Once You check the 'Lock Marks Entry' and locked it then Marks Entry will be closed and can not be changed.</td></tr>
                            </table>
                            <%
                            //System.out.println("Vijay-hgfjhg");
                        }
                        else
                        {
                            //out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Either you have locked Marks Entry or not authorized to proceed. Please Contact Course Coordinator ! </font> <br>");
                            out.print("<img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> One of the following possible errors occured :<br><br><font size=1ace='Arial' color='Red'><li>Selected Event-Subevent is not tagged with this Subject !<LI>All Batch Marks Entry shall be proceeded by Co-ordinator only !<LI>You have locked Marks Entry For the selected Event-Subevent ! </font></font> <br>");
                        }
                        }
                        else
                        {
                            out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Please select an Exam Code and Event-Subevent ! </font> <br>");
                        }
                    }
                }
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
//catch(org.json.JSONException e)
catch(Exception e)
{
    //System.out.println(e);
}
%>
</body>
</html>