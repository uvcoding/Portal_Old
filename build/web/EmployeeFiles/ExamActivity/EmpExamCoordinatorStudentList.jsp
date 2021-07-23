<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="TIET ";
	
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Coordinator Wise Student List ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",mInst="",minst="",mComp="",mDMemberID="";
String mExamID="",mexam="",mExamid="",QryExamid="",mSubEventCode="",mSubj="",msubj="";
String qry="",mDualMarks="",MOM="",Dt1="",Dt2="",mEE="";
double mAllowedWeightage=0,MaxAW=100;
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null;
String msubeven="",mMarks="",mPerc="",mName1="",mSem="",mMark="",mName2="",mName3="";
boolean flag=false;
try
{
	
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
		mInst="";
	}
	else
	{
		mInst=session.getAttribute("InstituteCode").toString().trim();
	}

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
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
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
		qry="Select WEBKIOSK.ShowLink('217','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
  //----------------------
			mDMemberCode=enc.decode(mMemberCode);
			mDMemberType=enc.decode(mMemberType);
			mDMemberID=enc.decode(mMemberID);
			%>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Coordinator Wise Student List </B></TD>
			</font></td></tr>
			</TABLE>
			 <table cellpadding=1 cellspacing=1  align=center rules=groups border=2 >
			<br>
			<!-- <tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><%=mMemberName%>[<%=mDMemberCode%>]
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDept)%>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><%=GlobalFunctions.toTtitleCase(mDesg)%>
			<hr></td></tr>  -->


		<!--*********Exam**********-->
			<td>&nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT> 
			<select name=Exam tabindex="1" id="Exam">	
			<%
			try
			{
			 qry="SELECT EXAMCODE from(";
	qry=qry+" Select nvl(EXAMCODE,' ') EXAMCODE , EXAMPERIODFROM from EXAMMASTER Where InstituteCode='"+mInst+"' AND ";
	qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
	qry=qry+" and (examcode in (select ExamCode from facultysubjecttagging where employeeid='"+mDMemberID+"'and InstituteCode='"+mInst+"'  AND  fstid in (select fstid from studentltpdetail where InstituteCode='"+mInst+"' ))";
	qry=qry+" OR examcode in (select ExamCode from MultiFacultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail where InstituteCode='"+mInst+"' )))";
	qry=qry+" order by EXAMPERIODFROM DESC)";
			 rs=db.getRowset(qry);
			 if (request.getParameter("x")==null)
			 {
				 while(rs.next())
				 {
					 mExamid=rs.getString("EXAMCODE");
					 if(QryExamid.equals(""))
 					 {
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%			
					 }
					 else
					 {
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%			
					 }
				}
			}
			else
			{
				while(rs.next())
				{
					mExamid=rs.getString("EXAMCODE");
					if(mExamid.equals(request.getParameter("Exam")))
	 				{
						QryExamid=mExamid;
						%>
						<OPTION selected Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value =<%=mExamid%>><%=rs.getString("EXAMCODE")%></option>
						<%
					}
				}
			 }
		     }    
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
				  }
		     %>
	           </select>&nbsp;&nbsp;
			<input type=hidden name="Exam" id="Exam" value="<%=mExamid%>">
				
			<INPUT Type="submit" Value="&nbsp; OK &nbsp;">
			</td>
			</tr>
			</table>
			</form>
			<%
			if(request.getParameter("x")!=null)
			{
				if (request.getParameter("Exam")==null)	
				{
					mExamID="";
				}
				else
				{
					mExamID=request.getParameter("Exam").toString().trim();

				}
			%>
			<form name="frm1" method=post > 
			<input type=hidden name="y" id="y">
			<input type=hidden name="x" id="x">
			<input type=hidden name="Exam" id="Exam" value='<%=mExamID%>'>
			<table cellpadding=1 cellspacing=0  align=center rules=groups border=2>
		<!--*********Exam Event Code**********-->
			
		<!--********Subject*****-->
			<tr><td >
			<%
			qry="Select distinct subject, subjectID From (";
		 	qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP='L' OR  a.ltp = 'P' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamID+"'  and a.INSTITUTECODE='"+mInst+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+" and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"'  ";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where (a.ltp = 'L' OR  a.ltp = 'P') and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamID+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"'   ";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" MINUS";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where (a.ltp = 'L' OR  a.ltp = 'P') and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamID+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"'  and INSTITUTECODE='"+mInst+"' ";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" )";
			//out.print(qry);
			rss=db.getRowset(qry);
			
			%>
			<FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;<select name=Subject tabindex="0" id="Subject">	
			<%
			try
			{
				if (request.getParameter("y")==null) 
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(msubj.equals(""))
			 			msubj=mSubj;
						%>
						<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
						<%			
				

					}
				}
				else
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(mSubj.equals(request.getParameter("Subject").toString().trim()))
			 			{
							msubj=mSubj;
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
				}
			}
			catch(Exception e)
			{
				//out.print(qry);
			}
			%>
			</select>
			&nbsp;&nbsp;
			<INPUT Type="submit" Value="&nbsp; View &nbsp;">
			
			</td>
			</tr>
			</table>
		</form>
			
			<%
				
			//out.println("Exam Code :"+mExamID+" Subject :"+mSubj+" Event :"+mEventCode);
			if(request.getParameter("y")!=null)
			{
				%>
				<form name="frm2" method="post" action="EmpExamCoordinatorStudentListXL.jsp">
				<%
				
				//out.println("Exam Code"+mExamID);
				if(request.getParameter("Exam")!=null  && request.getParameter("Subject")!=null )
				{
					
					mExamID=request.getParameter("Exam").toString().trim();
					mSubj=request.getParameter("Subject").toString().trim();
				
				
				//*******************************************************************
					qry="Select distinct FSTID FROM (";
		 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
					qry=qry+" subjectmaster B where (a.ltp = 'L' OR  a.ltp = 'P' OR A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and   A.examcode='"+mExamID+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
					qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"' ";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
					qry=qry+" UNION";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where  (a.ltp = 'L' OR  a.ltp = 'P') and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamID+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE  and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"' ";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" MINUS";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where (a.ltp = 'L' OR  a.ltp = 'P') and A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamID+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamID+"' and INSTITUTECODE='"+mInst+"'  ";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" ) order by fstid";
					rss=db.getRowset(qry);
				//	out.print(qry);
					%>
					<br><br>
					<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0 border=1 RULES=NONE width="90%" align=center >
						<thead>
						<tr bgcolor="#ff8c00">
						<td colspan=2 align=center >
							<font color="White" size=3><b> Available List 
						</td>
						</tr>
						</thead>
						<tbody>

					<%
					String QryFSTID="",qry1="",mEmpName="",mSecBranch="",mSubCode="",mEmpId="",mProg="";
					int Count=0,Ctr=0,mCount=0,Sum=0;
					while(rss.next())
					{
						if(QryFSTID.equals(""))
							QryFSTID="'"+rss.getString(1)+"'";
						else
							QryFSTID=QryFSTID+",'"+rss.getString(1)+"'";
						
					}
					%>
					<tr>
					<td valign=top >
					<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0 border=1  width="90%" align=center >		
					<%
						
					qry="select nvl(B.EMPLOYEENAME,' ')||' ('||B.EMPLOYEECODE||')' EMPNM, " +
                            "B.EMPLOYEEID EMPLOYEEID FROM FACULTYSUBJECTTAGGING A,  " +
                            "V#STUDENTLTPDETAIL B WHERE A.EMPLOYEEID=B.EMPLOYEEID AND  " +
                            "A.FSTID=B.FSTID  AND  a.INSTITUTECODE='"+mInst+"'  and  " +
                            "A.INSTITUTECODE=B.INSTITUTECODE and   nvl(B.deactive,'N')='N'  " +
                            "AND NVL(B.STUDENTDEACTIVE,'N')='N' and A.SUBJECTID=B.SUBJECTID " +
                            "AND	A.FSTID in ("+QryFSTID+") order by EMPNM,B.EMPLOYEEID ";
					//out.println(qry);
					rs2=db.getRowset(qry);
						while(rs2.next())
							{ 
							msno++;	
								if(msno==1)
								{
									%>
								<tr>
								<thead>
								<tr bgcolor="#ff8c00">
								
								 <td ><font color="White" size=2><b>Employee Name</b></font></td>
								 </td>
								 
								 </thead>
								 </tr>
								 <%
								}
								%>
									<tr>
									<%
										if(!mEmpId.equals(rs2.getString("EMPLOYEEID")))
										{
											mEmpId=rs2.getString("EMPLOYEEID");	
											flag=true;
											%>
											<td nowrap>
											<font FACE='ARIAL' size=2><%=rs2.getString("EMPNM")%>
											</td>
										<%
										}
										else
										{
											flag=false;
											%>
											<td nowrap><font FACE='ARIAL' size=2>&nbsp;</td>
											<%
										}
											%>
										 
									</tr>
									<%	
							}
					%>
					</table>
					</td>

					
					<%
					qry="select  nvl(B.EMPLOYEENAME,' ')||' ('||B.EMPLOYEECODE||')' EMPNM," +
                            "nvl(B.PROGRAMCODE,'')PROGRAMCODE, nvl(A.SECTIONBRANCH,' ')SECBR, " +
                            "nvl(A.SUBSECTIONCODE,'')SUBSEC, nvl(B.FSTID,'')FSTID,NVL(B.STUDENTNAME,'') " +
                            "STUDENTNAME,NVL(B.ENROLLMENTNO,' ')ENROLLMENTNO FROM FACULTYSUBJECTTAGGING A, " +
                            "V#STUDENTLTPDETAIL B WHERE A.EMPLOYEEID=B.EMPLOYEEID  AND		" +
                            "A.SECTIONBRANCH=B.SECTIONBRANCH  AND A.PROGRAMCODE=B.PROGRAMCODE AND  " +
                            "nvl(B.deactive,'N')='N' AND NVL(B.STUDENTDEACTIVE,'N')='N' AND	" +
                            "A.SUBSECTIONCODE=B.SUBSECTIONCODE AND A.SEMESTER=B.SEMESTER  and " +
                            "a.INSTITUTECODE='"+mInst+"'  and A.INSTITUTECODE=B.INSTITUTECODE AND " +
                            "A.FSTID=B.FSTID AND A.FSTID in ("+QryFSTID+") group by B.EMPLOYEENAME, " +
                            "B.EMPLOYEECODE,B.PROGRAMCODE,A.SECTIONBRANCH,A.SUBSECTIONCODE,B.FSTID,  " +
                            "B.STUDENTNAME,B.ENROLLMENTNO ORDER BY EMPNM, SECBR, SUBSEC,PROGRAMCODE,STUDENTNAME";
					rs1=db.getRowset(qry);
					//9/24/2011out.print(qry);
					%>
					<td valign=top>
					<table valign=top bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0  topmargin=0 cellspacing=0 cellpadding=0 border=1  width="90%" align=center >		
					<%
					while(rs1.next())
					{
						Ctr++;

						if(Ctr==1)
						{
							%>
						<tr>
						<thead>
						<tr bgcolor="#ff8c00">
						<td ><font color="White" SIZE=2><b>TNo.</b></font></td>
						 <td ><font color="White" SIZE=2><b>Program</b></font></td>
						 <td ><font color="White" SIZE=2><b>(Sec/SubSec)</b></font></td>
						<td ><font color="White" SIZE=2><b> Students Name</b></font></td> 
						<td ><font color="White" SIZE=2><b> EnrollmentNo.</b></font></td> 
						</tr>
						</thead>
						</tr>
						
							<%
						}
						qry1="select count(FSTID)COUNT1 FROM V#STUDENTLTPDETAIL  where  FSTID='"+rs1.getString("FSTID")+"' AND INSTITUTECODE='"+mInst+"' and  nvl(deactive,'N')='N' AND NVL(STUDENTDEACTIVE,'N')='N'  ";
						//	out.println(qry1);
							rs=db.getRowset(qry1);
							%>									
							<tr>
							<%
							while(rs.next())
							{
								Count=rs.getInt("COUNT1");
								if(mCount!=Count)
									//&& (!mSubCode.equals(rs1.getString("SUBSEC")))  )
								{
									mCount=rs.getInt("COUNT1");
									%>
									<td><font FACE='ARIAL' size=2>[<%=Count%>]</font></td>									<%
						
								}
								else
								{
									 flag=false;
									%>
									<td>&nbsp;</td>
									<%							
								}	
								
								if(!mProg.equals(rs1.getString("PROGRAMCODE")) )
								{
									mProg=rs1.getString("PROGRAMCODE");
									flag=true;
									%>
									<td ALIGN='CENTER' nowrap><font FACE='ARIAL' size=2><%=rs1.getString("PROGRAMCODE")%>
									</font></td>
									<%
								}
								else
								{
									flag=false;
									%>
									<td ALIGN='CENTER'>''</td>
									<%							
								}


								if( !mSubCode.equals(rs1.getString("SUBSEC")) )
								{
									mSecBranch=rs1.getString("SECBR");
									mSubCode=rs1.getString("SUBSEC");
									 flag=true;
									%>

									<td ALIGN='CENTER' nowrap><font size=2 FACE='ARIAL'>
									(<%=rs1.getString("SECBR")%>-<%=rs1.getString("SUBSEC")%>)</font></td>
									<%
								}
								else
								{
									 flag=false;
									%>
									<td ALIGN='CENTER'>''</td>
									<%							
								}	
								
							}
								%>
						<td ALIGN='Left' nowrap><font FACE='ARIAL' size=2>&nbsp; &nbsp; &nbsp;<%=rs1.getString("STUDENTNAME")%>
						
						</td>
						<td ALIGN='Left'><font FACE='ARIAL' size=2 ><%=rs1.getString("ENROLLMENTNO")%>
						
						</td>
						
						</tr>
						
						<%
					}
					//out.print("Subject"+mSubj);
					%>
					</table>
					
					<table >
					<tr><td align='center'><font color=Green FACE='ARIAL' size=4><b>Total Students: <%=Ctr%> </b></font>
					</td></tr>
					
					<input type=hidden name="Subject" id="Subject" value="<%=mSubj%>">
					<input type=hidden name="Exam" id="Exam" value="<%=mExamID%>">
					<input type=hidden name="FSTID" id="FSTID" value="<%=QryFSTID%>">
					

						<tr><td align='center'>
							<INPUT Type="submit" Value="Click to Print in XL">
							
					</td></tr>
					
				
					</table>
					</form>	
								
					<%
				} // Mandatory Items cannot be null
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");	
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
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
}
%>