<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;

GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mComp="";
String QryExam="",mexamcode="",mcolor="";
String QryFaculty="",mfaculty="",mfacultyid="";
String mLocked="", mSubj="", mExamCode="";
String mEveSub="", mEvent="", mSubevent="",mSubjID="";
int len=0, pos=0;


if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ Exam Event/Sub Event Re-Weightage ] </TITLE>

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
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
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
			
	
	    qry="Select WEBKIOSK.ShowLink('102','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Event/Sub Event Re-Weightage Tagging</B></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 width="650px" align=center rules=groups border=3>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>

<!--*********Exam**********-->
<tr><td valign=top><font color=black face=arial size=2>&nbsp;<STRONG>Exam Code</STRONG></font>
<%
  qry="select nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mInstitute+"'";
	qry=qry+" AND NVL(LOCKEXAM,'N')='N' and nvl(EXCLUDEINPREREG,'N')='N' and nvl(deactive,'N')='N' order by EXAMPERIODFROM desc";
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=exam tabindex="0" id="exam" style="WIDTH: 120px">
<%   	
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mexamcode=rs.getString("examcode");
			if(QryExam.equals(""))
 			{			
			QryExam=mexamcode;
			%>
			<OPTION Selected Value =<%=mexamcode%>><%=mexamcode%></option>
			<%
			}
			else
			{
		%>
			<option value=<%=mexamcode%>><%=mexamcode%></option>
		<%
			}
		}
	}
	else
	{
		while(rs.next())
	  {
	   mexamcode=rs.getString("examcode");			
	   if(mexamcode.equals(request.getParameter("exam").toString().trim()))
	   {	
			QryExam=mexamcode;
	   %>
	    <option selected value=<%=mexamcode%>><%=mexamcode%></option>
	 	 <%
	   }
     else
     {
	   %>
	    <option  value=<%=mexamcode%>><%=mexamcode%></option>
	   <%
	   }	
	  }
  }
 %>
</select>
</td>
<td valign=top><font color=black face=arial size=2>&nbsp;<STRONG>Faculty</STRONG></font>
<%
  qry="select distinct nvl(A.EntryBy,' ')EntryBy, NVL(B.EMPLOYEENAME,' ')EName, NVL(B.EMPLOYEECODE,' ')ECode from EXAMEVENTSUBJECTTAGGING A, EMPLOYEEMASTER B where (A.EntryBy='"+mChkMemID+"' OR A.CORDFACULTYID='"+mChkMemID+"') and A.EntryBy=B.EmployeeID";
  rs=db.getRowset(qry);
//out.print(qry);
%>
	<select name=Faculty tabindex="0" id="Faculty" style="WIDTH: 250px">
<%   	
 	if(request.getParameter("x")==null)
	{
		while(rs.next())
		{
		 	mfacultyid=rs.getString("EntryBy");
		 	mfaculty=rs.getString("EName");
			if(QryFaculty.equals(""))
 			{			
			QryFaculty=mfaculty;
			%>
			<OPTION Selected Value =<%=mfacultyid%>><%=mfaculty%></option>
			<%
			}
			else
			{
		%>
			<option value=<%=mfacultyid%>><%=mfaculty%></option>
		<%
			}
		}
	}
	else
	{
		while(rs.next())
		{
		 	mfacultyid=rs.getString("EntryBy");
		 	mfaculty=rs.getString("EName");
			if(mfacultyid.equals(request.getParameter("Faculty").toString().trim()))
			{
				QryFaculty=mfacultyid;
			%>
			    <option selected value=<%=mfacultyid%>><%=mfaculty%></option>
	 		<%
	   		}
     			else
     			{
	   		%>
			    <option  value=<%=mfacultyid%>><%=mfaculty%></option>
	   		<%
	   		}
	  	}
 	 }
%>
</select><INPUT Type="submit" Value="Show/Refresh">
</td></tr>
</table>
</form>
<%	
	if(request.getParameter("x")!=null)
	{
		if(request.getParameter("exam")==null)
		{
			QryExam="";
		}
		else
		{
			QryExam=request.getParameter("exam").toString().trim();	
		}
		if(request.getParameter("Faculty")==null)
		{
			QryFaculty="";
		}
		else
		{
			QryFaculty=request.getParameter("Faculty").toString().trim();	
		}
	} //closing of outer if
	%>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%">
	<thead>
	<tr bgcolor="#ff8c00">
	<td><font color="White"><b>SNo.</b></font></td>
	<td><font color="White"><b>Subject</b></font></td>
	<td nowrap><font color="White"><b>Event/Sub Event</b></font></td>	
	<td nowrap align=center><font color="White"><b>Weightage (in %)</b></font></td>
	<td nowrap align=center><font color="White"><b>Full Marks</b></font></td>
	<td align=center><font color="White"><b>Edit?</b></font></td>
	</tr>
	</thead>
	<tbody>
	<%
		qry=" Select  nvl(EXAMCODE,' ')ECode, nvl(SUBJECTCODE,' ')SUBJECTCODE, subjectid,nvl(SUBJECT,' ')SUBJECT, nvl(EVENTSUBEVENT,' ')SubEvent, nvl(WEIGHTAGE,0) WEIGHTAGE,";
		qry=qry+" nvl(MAXMARKS,0) MAXMARKS, decode(nvl(LOCKED,' '),'Y','YES','N','NO') LOCKED from V#EXAMEVENTSUBJECTTAGGING WHERE INSTITUTECODE='"+mInstitute+"' AND EXAMCODE=decode('"+QryExam+"','ALL',EXAMCODE,'"+QryExam+"') ";
		//qry=qry+" AND EMPLOYEEID=decode('"+mChkMemID+"','ALL',EMPLOYEEID,'"+mChkMemID+"')";
		qry=qry+" AND EMPLOYEEID IN (select entryby EMPLOYEEID from EXAMEVENTSUBJECTTAGGING where entryby='"+mChkMemID+"' and fstid in (select fstid from facultysubjecttagging where INSTITUTECODE='"+mInstitute+"' and COMPANYCODE='"+mComp+"' and EXAMCODE='"+QryExam+"'))";
		qry=qry+" Group By EXAMCODE, SUBJECTCODE,subjectid, SUBJECT, EVENTSUBEVENT, WEIGHTAGE, MAXMARKS, LOCKED";
		qry=qry+" Order By ECode, SUBJECTCODE,subjectid, SUBJECT, SubEvent, WEIGHTAGE, MAXMARKS, LOCKED";
		//out.print(qry);
		rs1=db.getRowset(qry);
 		int Ctr=0;
		while(rs1.next())
		{
			Ctr++;
			mcolor="Black";
			mSubj=rs1.getString("SUBJECTCODE");
			mSubjID=rs1.getString("subjectid");
			mExamCode=rs1.getString("ECode");
			mLocked=rs1.getString("LOCKED");

			mEveSub=rs1.getString("SubEvent");
			len=mEveSub.length();
			pos=mEveSub.indexOf("#");
			if(pos>0)
			{
				mEvent=mEveSub.substring(0,pos);
				mSubevent=mEveSub.substring(pos+1,len);
			}
			else
			{
				mEvent=mEveSub;
			}
//*********************************************************************
			qry="Select distinct FSTID FROM (";
 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP='L' OR A.PROJECTSUBJECT='Y' or A.LTP='P') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamCode+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamCode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP IN ('L','P')  and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamCode+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamCode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" UNION ";
		 	qry=qry+" (Select AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' subject , AA.subjectID subjectID from facultysubjecttagging AA, SubjectMaster CC , ";
			qry=qry+" ProgramSubjectTagging BB where AA.SUBJECTID='"+mSubjID+"' AND AA.LTP='P' AND nvl(AA.PROJECTSUBJECT,'N')<>'Y' And BB.L=0 and BB.T=0 and BB.P>0 And BB.ExamCode='"+mExamCode+"' And AA.employeeid='"+mDMemberID+"' and AA.examcode='"+mExamCode+"' ";
			qry=qry+" AND AA.INSTITUTECODE=BB.INSTITUTECODE And AA.EXAMCODE=BB.EXAMCODE And AA.ACADEMICYEAR=BB.ACADEMICYEAR And AA.PROGRAMCODE=BB.PROGRAMCODE And AA.TAGGINGFOR=BB.TAGGINGFOR And AA.SECTIONBRANCH=BB.SECTIONBRANCH And AA.SEMESTER=BB.SEMESTER And AA.BASKET=BB.BASKET And AA.SUBJECTID=BB.SUBJECTID ";
			qry=qry+" And AA.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+" and nvl(AA.deactive,'N')='N' and nvl(BB.Deactive,'N')='N' AND ";
			qry=qry+" AA.INSTITUTECODE=CC.INSTITUTECODE AND BB.INSTITUTECODE=CC.INSTITUTECODE AND cc.SUBJECTID=BB.SUBJECTID AND AA.SUBJECTID=CC.SUBJECTID ";
			qry=qry+" and AA.SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamCode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' , AA.subjectID)";
			qry=qry+" MINUS";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP='L' and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamCode+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamCode+"'";
			qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubjID+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" ) WHERE FSTID IN (SELECT FSTID FROM EXAMEVENTSUBJECTTAGGING WHERE NVL(DEACTIVE,'N')='N' AND (ENTRYBY='"+mChkMemID+"' OR CORDFACULTYID='"+mChkMemID+"') and fstid in (select fstid from facultysubjecttagging where INSTITUTECODE='"+mInstitute+"' and COMPANYCODE='"+mComp+"' and EXAMCODE='"+QryExam+"')) order by fstid";
			rs=db.getRowset(qry);
			//out.print(qry);
			String QryFSTID="";
			while(rs.next())
			{
				if(QryFSTID.equals(""))
					QryFSTID="'"+rs.getString(1)+"'";
				else
					QryFSTID=QryFSTID+",'"+rs.getString(1)+"'";
			}
			//out.print(QryFSTID);
//*********************************************************************
			if(!QryFSTID.equals(""))
			{
			qry1="select distinct 'Y' FROM STUDENTWISEGRADE WHERE INSTITUTECODE='"+mInstitute+"' And EXAMCODE='"+mExamCode+"'";
			qry1=qry1+" And (FSTID) IN ("+QryFSTID+")";
			//out.print(qry1);
			rs=db.getRowset(qry1);
			if(!rs.next())
			{
			   if(!mLocked.equals("YES"))
			   {
				%>
				<tr>
				<td nowrap><font color=<%=mcolor%>><%=Ctr%>.</font></td>
				<td nowrap><font color=<%=mcolor%>><%=rs1.getString("SUBJECT")%>(<%=rs1.getString("SUBJECTCODE")%>)</font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;&nbsp;&nbsp;<%=rs1.getString("SubEvent")%></font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("WEIGHTAGE")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("MAXMARKS")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td align=center><a href ='EditExamEventSubjWeightage.jsp?INST=<%=mInstitute%>&amp;ECODE=<%=QryExam%>&amp;SUBJECTID=<%=rs1.getString("subjectid")%>&amp;SUBJCODE=<%=rs1.getString("SUBJECTCODE")%>&amp;SUBJ=<%=rs1.getString("SUBJECT")%>&amp;EVENT=<%=mEvent%>&amp;SUBEVENT=<%=mSubevent%>&amp;WEIGHTAGE=<%=rs1.getString("WEIGHTAGE")%>&amp;FMARKS=<%=rs1.getString("MAXMARKS")%>'><img src='../../Images/EditButt.jpg' border=0 title="Edit the current tagged Weightage"></a></td>
				</tr>		
				<%  						
			   }
			   else
			   {
				%>
				<tr>
				<td nowrap><font color=<%=mcolor%>><%=Ctr%>.</font></td>
				<td nowrap><font color=<%=mcolor%>><%=rs1.getString("SUBJECT")%>(<%=rs1.getString("SUBJECTCODE")%>)</font></td>
				<td nowrap><font color=<%=mcolor%>>&nbsp;&nbsp;&nbsp;<%=rs1.getString("SubEvent")%></font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("WEIGHTAGE")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("MAXMARKS")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
				<td align=center><table><tr bgcolor='#ff8c00'><td align=center><b><font color=Black face=arial size=2>LOCKED</font></b></td></tr></table></td>
				</tr>		
				<%  						
			   }
			}
			else
			{
			   %>
			   <tr>
			   <td nowrap><font color=<%=mcolor%>><%=Ctr%>.</font></td>
			   <td nowrap><font color=<%=mcolor%>><%=rs1.getString("SUBJECT")%>(<%=rs1.getString("SUBJECTCODE")%>)</font></td>
			   <td nowrap><font color=<%=mcolor%>>&nbsp;&nbsp;&nbsp;<%=rs1.getString("SubEvent")%></font></td>
			   <td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("WEIGHTAGE")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
			   <td align=right nowrap><font color=<%=mcolor%>><%=rs1.getString("MAXMARKS")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
			   <td align=center>&nbsp;</td>
			   </tr>		
			   <%  						
			}
			}

		mSubevent="";
		 }
		%>
		</tbody>
		</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
</script>
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
//out.print(qry+" "+e);
}
%>
</body>
</html>