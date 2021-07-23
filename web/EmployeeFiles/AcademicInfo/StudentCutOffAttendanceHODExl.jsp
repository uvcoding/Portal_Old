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
<TITLE>#### <%=mHead%> [ View Student Cut-Off Attendance ] </TITLE>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>


<SCRIPT TYPE="text/javascript">

function AlertMe()
{
dd.twait.value='';
}


// copyright 1999 Idocs, Inc. http://www.idocs.com
// Distribute this script freely but keep this notice in place
function numbersonly(myfield, e, dec)
{
var key;
var keychar;

if (window.event)
   key = window.event.keyCode;
else if (e)
   key = e.which;
else
   return true;
keychar = String.fromCharCode(key);

// control keys
if ((key==null) || (key==0) || (key==8) || 
    (key==9) || (key==13) || (key==27) )
   return true;

// numbers
else if ((("0123456789.").indexOf(keychar) > -1))
   return true;

// decimal point jump
else if (dec && (keychar == "."))
   {
   myfield.form.elements[dec].focus();
   return false;
   }
else
   return false;
}
//-->
</SCRIPT>
</head>
<body  onload="AlertMe()" aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>  
<%

/*
	' 
*************************************************************************************************
	' *												
	' * File Name:		StudentCutOffAttendance.jsp		[For DOAA/Admin]					
	' * Author:			Vijay
	' * Date:			1st Feb 09
	' * Version:		1.0								
	' * Description:	Faculty Class Attendance Detail
*************************************************************************************************
*/
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="",mWebEmail="",EmpIDType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
String QryAcadYr="", mAcadYr="";
String mInst="", mEmpID="";
String OldEnNo="", OldSubj="", OldLTPVal="";
int Ctr=0, CTR=0;
long QryTotCls=0, QryTotPrs=0, QryPercAtt=0;
double mCutOffVal=0;
String mFName="", mFID="", mECode="", mExamFac="", mSubject="";
String QryFaculty="", QryExam="", QryType="", mFaculty="", mFacultyID="", mFacultyName="",mLTP="";
String mexamcode="",mfaculty="", mName="",mDate1="",mDate2="", mEm, mTcount="", mEcount="";
long mTotClass=0,mTotExc=0;
String mProgCode="", QryProgCode="", mSub="",mSec="",QrySub="";
String mEmployeeID="", mAttBy="", mAttDate="";
String mSUBJECTCODE="", mSUBJECTID="", mFSTID="";
String mEName="";
String mClassType="";
String mClasstype="";
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs2=null;

qry="select to_Char(Sysdate,'dd-mm-yyyy') date1, to_Char((Sysdate-6),'dd-mm-yyyy') date2 from dual";
rs=db.getRowset(qry);
rs.next();
String mCurrDate=rs.getString("date1");
String mPrevDate=rs.getString("date2");

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
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
	qry="Select WEBKIOSK.ShowLink('261','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
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



		if(request.getParameter("exam")==null)
			QryExam="";
		else
			QryExam=request.getParameter("exam").toString().trim();	
		if(request.getParameter("ACAD")==null)
			QryAcadYr="";
		else
			QryAcadYr=request.getParameter("ACAD").toString().trim();	
		if(request.getParameter("PROG")==null)
			QryProgCode="";
		else
			QryProgCode=request.getParameter("PROG").toString().trim();	


		if(request.getParameter("SUBJ")==null)
			QrySub="";
		else
			QrySub=request.getParameter("SUBJ").toString().trim();	

		try
		{
			if(request.getParameter("CUTOFF")==null)
				mCutOffVal=0;
			else
				mCutOffVal=Double.parseDouble(request.getParameter("CUTOFF").toString().trim());	
		}
		catch (Exception e)
		{
			mCutOffVal=0;
		}


	%>
	<form name="frm" method=get>
	<input id="x" name="x" type=hidden>
	<table ALIGN=CENTER bottommargin=0  topmargin=0 >
	<tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: Arial"><b>Student Cut-Off Attendance</b></td></tr>
	</table>
	<table rules=groups cellspacing=1 cellpadding=1 align=center border=1>
	<tr><td nowrap>
	<font color=black face=arial size=2><STRONG>Exam Code : <%=QryExam%></STRONG></font>
	
	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Academic Year : <%=QryAcadYr%></STRONG></font>
	

	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Program Code  : <%=QryProgCode%></STRONG></font>
	
	</td></tr>
	<tr><td align=center>
	<font color=black face=arial size=2><STRONG>&nbsp; &nbsp; Cut-Off Value <=   <%=mCutOffVal%> </strong></font>



	</td></tr>

	</table>


		<%
	ResultSet rsq=null,rsb=null;
				String Qqry="",m10th="",m12th="",mStudID="",qryb="";	
				String mSUP="",mRWJ="";
			ResultSet rs1=null;
			double mCGPA=0.0;
			String mFailsub="",mFailSem="";
			int mSem=0;

		
		if(mCutOffVal >= 0 && mCutOffVal <=100)
		{
			qry="select distinct A.Studentid Studentid, A.StudentName StudentName, A.EnrollmentNo EnrollmentNo, A.FSTID FSTID, A.SUBJECTID SUBJECTID, A.SUBJECTCODE SUBJECTCODE, A.SUBJECT SUBJECT, A.LTP LTP, A.SEMESTER SEMESTER, A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE SUBSEC From v#studentltpdetail A";
			qry=qry+" where A.ExamCode='"+QryExam+"' and nvl(A.STUDENTDEACTIVE,'N')='N' and a.subjectid in ("+QrySub+") and A.ACADEMICYEAR='"+QryAcadYr+"' AND PROGRAMCODE='"+QryProgCode+"' AND A.INSTITUTECODE='"+mInst+"' and (A.fstid) in (Select C.fstid from StudentAttendance C Where A.FSTID=C.FSTID) order By StudentName, SUBJECT, LTP, FSTID";
			rs=db.getRowset(qry);
			//out.print(qry);
			String QryLTPVal="";
			while(rs.next())
			{
				Ctr++;
				mSubject=rs.getString("SUBJECTID");
				
				
				mSem=rs.getInt("SEMESTER");
				mSem=mSem-1;
				
				
				QryLTPVal=rs.getString("LTP");
				if(QryLTPVal.equals("L") || QryLTPVal.equals("T"))
					QryLTPVal="'L','T'";
				else
					QryLTPVal="'P'";
				//out.print(QryLTPVal);
				if(!mStudID.equals(rs.getString("Studentid")))
					{			
			//Studentqualification  10th and 12th 
		mStudID=rs.getString("Studentid");
		

				Qqry="Select distinct  nvl(PercentOfMarks,0) PercentOfMarks, nvl(Grade,' ') Grade ";
	Qqry = Qqry + " From STUDENTQUALIFICATION Where StudentID ='" +rs.getString("Studentid")+ "' and QUALIFICATIONCODE='12th' order by YearOfPassing desc";
				rsq=db.getRowset(Qqry);
				if(rsq.next())
					m12th=rsq.getString("PercentOfMarks");
				

				
				Qqry="Select distinct  nvl(PercentOfMarks,0) PercentOfMarks, nvl(Grade,' ') Grade ";
	Qqry = Qqry + " From STUDENTQUALIFICATION Where StudentID ='" +rs.getString("Studentid")+ "' and QUALIFICATIONCODE='10th' order by YearOfPassing desc";
				rsq=db.getRowset(Qqry);
				if(rsq.next())
					m10th=rsq.getString("PercentOfMarks");
//-------------------------------------------------------------------		

// Student CGPA 
if(mSem!=0)
						{
qry="select CGPA CGPA FROM ";
	qry=qry+" STUDENTSGPACGPA#Pub WHERE institutecode='"+mInst+"' AND SEMESTER='"+mSem+"' and  STUDENTID='" +rs.getString("Studentid")+ "' ";
	//out.print(qry);
	rs1=db.getRowset(qry);
	if(rs1.next())
		mCGPA=rs1.getDouble("CGPA");







						}
						else
						{
							mCGPA=0.0;
						}


//----------------

//Student Backlog history


qryb="select count(studentid)RWJ from v#studentltpdetail where semestertype in ('RWJ','SAP') and ltp in ('L','P') and nvl(STUDENTDEACTIVE,'N')='N'   and nvl(deactive,'N')='N'  and studentid ='" +rs.getString("Studentid")+ "' AND INSTITUTECODE='"+mInst+"' ";
//out.print(qryb);
rsb=db.getRowset(qryb);
	if(rsb.next())
		mRWJ=rsb.getString("RWJ");

qry1="select count(studentid)SUP from v#studentltpdetail where semestertype = 'SUP' and ltp in ('L','P')  and nvl(STUDENTDEACTIVE,'N')='N'   and nvl(deactive,'N')='N'  and studentid = '" +rs.getString("Studentid")+ "' AND INSTITUTECODE='"+mInst+"' ";
rs1=db.getRowset(qry1);
	if(rs1.next())
		mSUP=rs1.getString("SUP");

//----------------------------
					}


				if(Ctr==1)
				{
					%>
					<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 border=1>
					<thead>
					<tr bgcolor="#ff8c00">
					 <td nowrap align=left><b><font color="White">SNo.</font></b></td> 
					 <td nowrap align=left><b><font color="White">Student</font></b></td> 
					 
					 <td nowrap align=left><b><font color="White">CGPA</font></b></td> 
					 <td nowrap align=left><b><font color="White">10th%</font></b></td> 
					 <td nowrap align=left><b><font color="White">12th%</font></b></td> 
					 
					  <td  align=left><b><font color="White">No's(Count)History<br> of Backlogs</font></b></td>
					  
					  <td  align=left><b><font color="White">No's(count)History<br> of Supplimentary</font></b></td>

					
						
					
				 <td nowrap align=left><b><font color="White">Semester in <br>which Failed</font></b></td> 



					 <td nowrap align=left><b><font color="White">Subject</font></b></td> 
					 <td nowrap align=center><b><font color="White">LTP</font></b></td> 
					 <td nowrap align=center><b><font color="White">Attendance (%)</font></b></td> 
					</tr>
					</thead>
					<tbody>
					<%
				}
				qry1="SELECT SUM (Tcount)Tcount FROM (select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP IN ("+QryLTPVal+")";
				//qry1=qry1+" and FSTID='"+rs.getString("Fstid")+"'";
				qry1=qry1+" and INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+QryAcadYr+"' and PROGRAMCODE='"+QryProgCode+"' and nvl(DEACTIVE,'N')='N'";
				qry1=qry1+" and SECTIONBRANCH='"+rs.getString("SECBR")+"' and SUBSECTIONCODE='"+rs.getString("SUBSEC")+"'";
				qry1=qry1+"   UNION ALL  select  COUNT (DISTINCT classtimefrom) Tcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'   and  AcademicYear = '"+QryAcadYr+"'    AND LTP IN ("+QryLTPVal+")     AND INSTITUTECODE='"+mInst+"' and  examcode = '"+QryExam+"'  ) ";
				rs2=db.getRowset(qry1);
				//out.print(qry1);
				if(rs2.next())
					QryTotCls=rs2.getLong("Tcount");
				else
					QryTotCls=0;

				qry1="SELECT SUM (Pcount)Pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP IN ("+QryLTPVal+") ";
				//qry1=qry1+" and FSTID='"+rs.getString("Fstid")+"'";
				qry1=qry1+" and INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and ACADEMICYEAR='"+QryAcadYr+"' and PROGRAMCODE='"+QryProgCode+"' and nvl(DEACTIVE,'N')='N'";
				qry1=qry1+" and STUDENTID='"+rs.getString("studentid")+"' and nvl(PRESENT,'N')='Y' ";
				qry1=qry1+" and SECTIONBRANCH='"+rs.getString("SECBR")+"' and SUBSECTIONCODE='"+rs.getString("SUBSEC")+"'";
				qry1=qry1+"   UNION ALL  select  COUNT (DISTINCT classtimefrom) Pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'   and  AcademicYear = '"+QryAcadYr+"'    AND LTP IN ("+QryLTPVal+")  AND NVL (present, 'N') = 'Y'   AND INSTITUTECODE='"+mInst+"' and  examcode = '"+QryExam+"'  AND studentid = '"+ rs.getString("studentid") +"'  ) ";
				rs2=db.getRowset(qry1);
				//out.print(qry1);
				if(rs2.next())
					QryTotPrs=rs2.getLong("Pcount");
				else
					QryTotPrs=0;
				try
				{
					if(QryTotCls==0)
						QryPercAtt=0;
					else
						QryPercAtt=((QryTotPrs*100)/QryTotCls);

					//out.print(QryTotCls+" :: "+QryTotPrs+" Tot Percentage - "+QryPercAtt+"<bR>");
				}
				catch(ArithmeticException e)
				{
					//out.print(e);
				}


				
				if(QryPercAtt<=mCutOffVal)
				{
//out.print(rs.getString("EnrollmentNo")+"sss"+QryTotCls+" :: "+QryTotPrs+" Tot Percentage - "+QryPercAtt+"<bR>");

					
					if(!OldEnNo.equals(rs.getString("EnrollmentNo")))
					{
						CTR++;
						OldEnNo=rs.getString("EnrollmentNo");
						%>
					<tr>
						<td align=right><%=CTR%>.</td>
						<td nowrap><%=rs.getString("StudentName")%> &nbsp; [<%=rs.getString("EnrollmentNo")%>]</td>

						<td nowrap><%=mCGPA%> </td>
						<td nowrap><%=m10th%> </td>
						<td nowrap><%=m12th%> </td>	


						<td nowrap><%=mRWJ%> </td>
						<td nowrap><%=mSUP%> </td>	

					<td nowrap> 
<%
						
						// Backlog history

qryb="SELECT DISTINCT a.semester semester, a.subjectid subjectid,                c.subject || ' (' || c.subjectcode || ')' subj, 'Fail' status           FROM studentresult a, subjectmaster c          WHERE a.institutecode = '"+mInst+"'             AND a.studentid = '" +rs.getString("Studentid")+ "'            AND NVL (fail, 'N') = 'Y'            AND NVL (grade, 'N') <> 'X'             AND a.semester <= '"+mSem+"'            AND a.institutecode = c.institutecode            AND a.subjectid = c.subjectid UNION SELECT DISTINCT a.semester semester, a.subjectid subjectid,       c.subject || ' (' || c.subjectcode || ')' subj, 'NR on date' status           FROM nrstudentfailsubjects a, subjectmaster c          WHERE a.institutecode = '"+mInst+"'             AND NVL (a.registered, 'N') = 'N'            AND a.studentid = '" +rs.getString("Studentid")+ "'            AND a.semester <= '"+mSem+"'                   AND a.institutecode = c.institutecode            AND a.subjectid = c.subjectid       ORDER BY status, semester, subj ";
rsb=db.getRowset(qryb);
while(rsb.next())
							{
	mFailsub=rsb.getString("subj");
	mFailSem=rsb.getString("semester");

	out.print(mFailsub+"  Sem:-"+mFailSem+"<br>");
						}
	%>
						
						</td>	
							
							

						<td nowrap><%=rs.getString("SUBJECT")%> &nbsp; [<%=rs.getString("SUBJECTCODE")%>]</td>
						<%
						if(QryLTPVal.equals("'P'"))
						{
							%>
							<td nowrap align=center>P</td>
							<td nowrap align=center><%=QryPercAtt%></td>
							<%
						}
						else
						{
							%>
							<td nowrap align=center>L and/or T</td>
							<td nowrap align=center><%=QryPercAtt%></td>
							<%
						}
							%>
							</tr>
							<%
					}
			
					
				}
			}
		}
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Cut-Off Value must be between '0' and '100' !</font> <br>");
		}
	
	%>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number"]);
	</script>
	<%
	if(Ctr>0)
	{
		%>
		<table align=center bgcolor=white width=100% cellmargin=0 bottommargin=0 border=1>
		<tr>
		<td align=middle><font color=blue face=arial size=3><b>Total Student(s) - <%=CTR%></b></font></td>
		</tr>
		</table>
		<%
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
		<P>	This page is not authorized/available to you.
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
</body>
</html>