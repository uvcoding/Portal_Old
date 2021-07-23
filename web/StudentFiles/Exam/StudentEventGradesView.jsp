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
<TITLE>#### <%=mHead%> [ View Student Grade Card (Eventwise) ] </TITLE>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />

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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
/*
' 
*************************************************************************************************
	' *												
	' * File Name:	StudentEventGradesViewjsp.JSP		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		3rd Aug 2007
	' * Version:	2.0							
	' * Description:	Grade Card of Students
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String qry1="", qry2="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String mInst="", mGFlag="", mDetained;
int msno=0;
String QryExam="", mExamCode="",mexamcode="",mexam="",mProg="",mBranch="",mSem="",mName="";
String mINSTITUTECODE="";
String mEmployeeID="";
String mSUBJECTCODE="", ABC="";
String mEName="",msubj="",mSubj="",mSubjcode="", QrySubject="";
ResultSet rs=null,rs1=null,rs2=null;
	String qrye="";
ResultSet rse=null;
String QryExam11="";

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
if (session.getAttribute("InstituteCode")==null)
{
	mINSTITUTECODE="";
}
else
{
	mINSTITUTECODE=session.getAttribute("InstituteCode").toString().trim();
}
if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
try 
{  
//1
	if(!mMemberID.equals("") && !mMemberType.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
	//2
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('100','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		//if (RsChk.next() && RsChk.getString("SL").equals("Y"))
if(1==1)
		{
	  //----------------------
			try
			{
				mDMemberCode=enc.decode(mMemberCode);
				mMemberID=enc.decode(mMemberID);
				mMemberType=enc.decode(mMemberType);
			}
			catch(Exception e)
			{
				//out.println(e.getMessage());
			}
			%>
			<form name="frm" method=get>
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr>
			<TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><b>Student Grade Card (ExamWise)</b></font>
			</td>
			</tr>
			</table>
			<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
			<tr><td><font color=#00008b face=arial size=2><STRONG>&nbsp; Name:&nbsp;</STRONG></font><font face="arial"><%=GlobalFunctions.toTtitleCase(mName)%> [<%=mDMemberCode%>]</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Course/Branch:&nbsp;</STRONG></font><font face="arial"><%=mProg%>(<%=mBranch%>)</font>
			&nbsp;&nbsp;<font color=#00008b face=arial size=2><STRONG>Current Semester:&nbsp;</STRONG></font><font face="arial"><%=mSem%></font></td></tr>
			<tr><td ALIGN=CENTER><HR><font color=#00008b face=arial size=2><STRONG>&nbsp; Exam Code</STRONG></font>
			<%
			qry="select distinct nvl(examcode,' ')examcode, EXAMPERIODFROM from exammaster where institutecode='"+mINSTITUTECODE+"'";
			qry=qry+" and nvl(deactive,'N')='N' and EXAMCODE IN (SELECT EXAMCODE FROM STUDENTWISEGRADE where studentid='"+mChkMemID+"' ) order by EXAMPERIODFROM Desc";
			//out.println(qry);
			rs=db.getRowset(qry);
			%>
			<select name="exam" tabindex="0" id="exam" style="WIDTH: 200px">	
			<option selected value='' > << Select Exam Code  >>  </option>
			<%
			if(request.getParameter("x")==null)
			{
				while(rs.next())
				{
				 	mexamcode=rs.getString("examcode");
					if(mexamcode.equals(""))
						QryExam=mexamcode;
					%>
					<option value=<%=mexamcode%>><%=mexamcode%></option>
					<%
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
			&nbsp;<input type="submit" value="Show"></td></tr>
			</table>
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
			}
			%>
			<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 >
			<thead>
			<!--<#c00000>-->
			<tr bgcolor="#ff8c00">
			<td nowrap><b><font color=white size=2>SNo.</font></b></td>
			  <td nowrap><b><font color=white size=2>Subject</font></b></td>
			  <td nowrap><b><font color=white size=2>Exam Code</font></b></td>
			  
			  <td nowrap><b><font color=white size=2>Grade Awarded</b></td>
			<!--  <td><b><font color=white>E to D?</b></td> -->
			</tr>
			</thead>
			<tbody>
			<Br>
			<%
			
				/*qry="select distinct nvl(c.EXAMCODE,' ')EXAMCODE, nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT, ";
				qry=qry+ " NVL(A.FINALMARKS,0) FINALMARKS, NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD, SUM(NVL(C.WEIGHTAGE,0)) MAXMARKS from STUDENTWISEGRADE A, SUBJECTMASTER B, V#EXAMEVENTSUBJECTTAGGING C";
				qry=qry+ " where A.studentid='"+mMemberID+"' AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mMemberID+"'   ";
				qry=qry+ " and v.examcode='"+QryExam+"' AND NVL(V.DEACTIVE,'N')='N' )";
				qry=qry+ " and A.fstid=C.fstid  AND A.STUDENTID=C.STUDENTID AND b.SUBJECTid=C.SUBJECTid AND A.INSTITUTECODE=B.INSTITUTECODE AND B.INSTITUTECODE=C.INSTITUTECODE  AND  NVL(A.DOCMODE,'N')='A' and (a.BREAK#SLNO, b.SUBJECTID, a.INSTITUTECODE, a.EXAMCODE) in (select  BREAK#SLNO, SUBJECTID, INSTITUTECODE, EXAMCODE from gradecalculation where nvl(finalized,'N')='Y' AND NVL(STATUS,'N')='A')   ";
				qry=qry+ " GROUP BY c.EXAMCODE, nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')', A.FINALMARKS, A.FINALGRADE, A.GRADEFLAG";
				qry=qry+ " ORDER BY EXAMCODE, SUBJECT, FINALMARKS";*/

				qry="SELECT    a.grade FINALGRADE, nvl(B.SUBJECT,' ')||'('||NVL(B.SUBJECTCODE,' ')||')' SUBJECT,c.examcode    FROM studentresult#pub a, subjectmaster b    ,V#STUDENTLTPDETAIL C   WHERE a.subjectid     = b.subjectid     AND a.institutecode = b.institutecode     AND a.institutecode = '" + mINSTITUTECODE + "'     AND A.studentid     = '"+mMemberID+"'      AND A.INSTITUTECODE = C.INSTITUTECODE AND A.STUDENTID=C.STUDENTID AND A.SUBJECTID=B.SUBJECTID     AND A.SUBJECTID     = C.SUBJECTID     AND C.EXAMCODE      = '"+QryExam+"'      AND A.semester      = C.SEMESTER  and  C.LTP IN ('L','P')    and nvl(c.DEACTIVE,'N')='N'     AND NVL(C.STUDENTDEACTIVE,'N')='N' ORDER BY SUBJECT";
				//out.println(qry);
			
			/*else
			{
				qry="select distinct nvl(A.EXAMCODE,' ')EXAMCODE, nvl(C.SUBJECT,' ')||'('||NVL(C.SUBJECTCODE,' ')||')' SUBJECT, ";
				qry=qry+ " NVL(A.FINALMARKS,0) FINALMARKS, NVL(A.FINALGRADE,0) FINALGRADE, nvl(A.GRADEFLAG,' ')ETOD  from STUDENTWISEGRADE A, SUBJECTMASTER B, V#STUDENTLTPDETAIL C";
				qry=qry+ " where A.studentid='"+mMemberID+"' AND a.FSTID IN (SELECT FSTID FROM V#STUDENTLTPDETAIL V WHERE v.studentid='"+mMemberID+"'  ";
				qry=qry+ " and v.examcode='"+QryExam+"' )";
				qry=qry+ " and nvl(A.DOCMODE,'N')='A'  and A.fstid=C.fstid and A.studentid=C.studentid and A.examcode=C.examcode  ";
				qry=qry+ " GROUP BY A.EXAMCODE, nvl(C.SUBJECT,' ')||'('||NVL(C.SUBJECTCODE,' ')||')', A.FINALMARKS, A.FINALGRADE, A.GRADEFLAG";
				qry=qry+ " ORDER BY EXAMCODE, SUBJECT, FINALMARKS";
			}*/
			//out.print(qry);
			rs1=db.getRowset(qry);
			msno=0;
			while(rs1.next())
			{
				msno++ ;
				
				%>
				<tr>
				<td nowrap><font size=2 face=verdana> <%=msno%>.</td>
				<td nowrap><font size=2 face=verdana> <%=rs1.getString("SUBJECT")%></td>
				<td nowrap><font size=2 face=verdana> <%=rs1.getString("EXAMCODE")%></TD>
							
				<td nowrap><font size=2 face=verdana> <%=rs1.getString("FINALGRADE")%><b></td>
				</tr>	
				<%
			}
			%>
			</tbody>
			</table>		
					
			
			
			
		
			<script type="text/javascript">
			var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString"]);
			</script>
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
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}   //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}	//1	
catch(Exception e)
{
}
%>
</form>
</body>
</html>