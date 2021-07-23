<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
String qry="",qry1="",mfinalized="";
String mSemType=""; 
int ctr=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";  
String mMemberName="";
String mInst="";
String mExam="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName12="";
String mName10="",mName11="";

String mELECTIVECODE="",mSubject="",mCustom="",mCustomRun="";
String mSubjType="";
String mST="",mDepartmentCode="";
String sb="";
String qry123="";
String qry1234="";
int updt=0;


ResultSet rs123=null;
ResultSet rs1234=null;



if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
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
if (session.getAttribute("DepartmentCode")==null)
{
	mDepartmentCode="";
}
else
{
	mDepartmentCode=session.getAttribute("DepartmentCode").toString().trim();
}
 
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Elective Subject(s) to be Run by HOD ] </TITLE>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
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
		
		qry="Select WEBKIOSK.ShowLink('114','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
			if(request.getParameter("ExamCode")!=null)
				{
					

					if (request.getParameter("ExamCode")==null)
						mExam="";
					else
						mExam=request.getParameter("ExamCode").toString().trim();

				if (request.getParameter("finalized")==null)
						mfinalized="";
					else
						mfinalized=request.getParameter("finalized").toString().trim();

				

				if(request.getParameter("SemType")==null)
					mSemType="";
				else
					mSemType=request.getParameter("SemType").toString().trim();
						
					mST="E";

				int mTot=0;

				if(request.getParameter("Total")==null )
					mTot=0;
				else
					mTot=Integer.parseInt(request.getParameter("Total").toString().trim());

				%>
				<center><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>
				Elective Subject(s) Running Status by HOD</u></b></font></center>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#e68a06'>
				 <th>Sno.</th>
				 <th>Subject Code</th>
				 <th>Subject Description</th>
				  <th>To Be Offered</th>
				<%		

//------------------------
						
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

		 
					
					String mRunning="";
					String mSubjCode="",mSubjID="",mLastStatus="";
					String mProg="";
					String mTagg="";
					String mSectionBranch="";
					String mAcademic="",mSem="";


	 				String mColor="";
					int mChoice=0;
					String mCol1="LightGrey";
					String OldmELECTIVECODE="";
					String mCol2="#ffffff";
					int jk=0,k=0;


					for(int i=0;i<mTot;i++)
					{ 
						
						ctr++;
						mName1="SUBJCODE"+ctr;
						mName2="RUNNING"+ctr;
						mName3="ELECTIVE"+ctr;
						mName4="LASTSTATUS"+ctr;
						mName5="PRGCODE"+ctr;
						mName6="TAGGINGFOR"+ctr;
						mName7="SECIONBRANCH"+ctr;
						mName8="ACYEAR"+ctr;
						mName9="SUBJID"+ctr;

						mName10="SEMESTER"+ctr;
						mName11="SEMESTERTYPE"+ctr;
						mName12="SBJECT"+ctr;
						mCustom="CUSTOM"+ctr;

						mSubjCode=request.getParameter(mName1).toString().trim();
						mSubjID=request.getParameter(mName9).toString().trim();
						mLastStatus=request.getParameter(mName4).toString().trim();
						mSubject=request.getParameter(mName12).toString().trim();

						mRunning=request.getParameter(mName2).toString().trim();

						mProg=request.getParameter(mName5).toString().trim();
						mTagg=request.getParameter(mName6).toString().trim();
						mSectionBranch=request.getParameter(mName7).toString().trim();
						mAcademic=request.getParameter(mName8).toString().trim();
						

						mSem=request.getParameter(mName10).toString().trim();
						mSemType=request.getParameter(mName11).toString().trim();
						mCustomRun=request.getParameter(mCustom).toString().trim();

					
						

						if (mST.equals("E"))
							{
							  if(request.getParameter(mName3)!=null)
								mELECTIVECODE=request.getParameter(mName3).toString().trim();
							  else
								mELECTIVECODE="";
							}
						else
							mELECTIVECODE=" ";

						if (!mELECTIVECODE.equals(OldmELECTIVECODE))
							{
							   if (mChoice==0)
								mChoice=1 ;
							   else
								mChoice=0 ;
							   OldmELECTIVECODE=mELECTIVECODE;
							}

						if (mChoice==0) 
							mColor=mCol1;
						else
						      mColor=mCol2;
						 //out.println(mLastStatus+"Last"+mRunning+"<br>");
						  //out.println(mCustomRun+"Custom"+mRunning);

						%>

						<tr bgcolor="<%=mColor%>">
						<td>&nbsp;<%=ctr%></td>
						<td>&nbsp;<%=mSubjCode%></td>
						<%
						   if (mELECTIVECODE.equals(" "))
					      	 {
						%>
							<td><%=mSubject%></td>
						<%
						     }
						    else	
							{		
						%>
							<td><%=mSubject%>&nbsp;(<%=mELECTIVECODE%>)&nbsp;</td>
						<%		
							}
						
					//	if (mLastStatus.equals(mRunning) )
								//|| mCustomRun.equals(mRunning))
						//	  {
								 if(mRunning.equals("Y"))
								  {
									%>
									<td align=right><font color=green>Running</font></td>
									<%
								  }
								 else  if(mRunning.equals("N"))
								  {
									%>
									<td align=right><font color=Red>Not Running</font></td>
									<%
								  }
								 /*else if(mCustomRun.equals("C"))
								  {*/
									%>
									<!-- <td align=right><font color=blue>Custom</font></td> -->
									<%
								  //}
								
							  //}
							// if ( !mLastStatus.equals(mRunning))
							//  {
				                          //sb=session.getAttribute("sb").toString().trim();
								if(mST.equals("E"))
								  {
                                                                      // out.print(sb);
									qry="Update PR#ELECTIVESUBJECTS B set SUBJECTRUNNING='"+mRunning+"' Where B.INSTITUTECODE='"+mInst+"' AND B.EXAMCODE='"+mExam+"'";
									qry=qry+" And B.SubjectID='"+mSubjID+"' and     b.academicyear     = '"+mAcademic+"' AND (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
									qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D,preventsAYTagging x Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' ";
                                                                        qry=qry+"   AND NVL (d.loaddistributionstatus, 'N') = 'N'    and x.academicyear   = b.academicyear AND d.institutecode  = x.institutecode  AND d.preventcode    = x.preventcode AND d.membertype     = x.membertype  AND d.memberid  = x.memberid ";
									qry=qry+"AND NVL (x.elrnningfinalizedbyhod, 'N') = 'N'   And NVL (x.deactive, 'N') = 'N'   AND NVL (d.deactive, 'N') = 'N'))";
													  
								  }
								   qry1="Update PR#STUDENTSUBJECTCHOICE	SET SUBJECTRUNNING='"+mRunning+"',FACULTYID='"+mDMemberID+"' , FACULTYTYPE='"+mDMemberType+"'	Where INSTITUTECODE='"+mInst+"' And EXAMCODE='"+mExam+"' And ACADEMICYEAR='"+mAcademic+"' And PROGRAMCODE='"+mProg+"' And TAGGINGFOR='"+mTagg+"' And SECTIONBRANCH='"+mSectionBranch+"'		And SEMESTER='"+mSem+"' And SEMESTERTYPE='"+mSemType+"'	And SUBJECTID='"+mSubjID+"'	And nvl(SUBJECTTYPE,'N')='E' And nvl(Deactive,'N')='N' ";
                                                     //------Removed entrydate from update query1 because of FIFO at DOAA..................................................//
								//out.print(qry1+"<br><br><br>");
								//  out.print(qry1+"ankur");
								   k=db.update(qry1);
														   
								   jk=db.update(qry);	
								
								if (jk>0  && k>0)
								   {
									  //--------------//
									  //  Log Entry   //
								  	  //--------------//
									    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Sbject Running=[Y]", "ExamCode:"+ mExam +" Subject Code "+ mSubjCode+" SubjType:"+mST , "NO MAC Address" , mIPAddress);				
									   //--------------//						
																		
									
									
									%>
									<!--  <td align=right><font color=green>Running</font></td>  -->
									<%
								   }
								else
								   {
									%>
										<td>&nbsp;</td>
									<%
								   }
							 //  }
							// else 
							// { 
								if(mST.equals("E"))
								   {	
									qry="Update PR#ELECTIVESUBJECTS B set SUBJECTRUNNING='"+mRunning+"'  Where B.INSTITUTECODE='"+mInst+"' AND B.EXAMCODE='"+mExam+"'"; 
									qry=qry+" And B.SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
									qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
									qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								   }
								  //out.print(qry+"<br><br><br>");
								  jk=db.update(qry);	
								  if (jk>0 )
								   {

									  //--------------//
									  //  Log Entry   //
								  	  //--------------//
									    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Sbject Running=[N]", "ExamCode:"+ mExam +" Subject Code "+ mSubjCode+" SubjType:"+mST , "NO MAC Address" , mIPAddress);				
									   //--------------//						

									%>
									<!-- <td align=right><font color=red>Not Running</font></td> -->
									<%
								   }
								   else
								   {
									%>
										<td>&nbsp;</td>
									<%
								   }
							 //  }


						/* else if (mRunning.equals("C") && !mCustomRun.equals(mRunning))
							 //&& !mLastStatus.equals(mRunning))
							  {
				
								if(mST.equals("E"))
								  {

									// 
									qry="Update PR#ELECTIVESUBJECTS B set SUBJECTRUNNING='Y',CUSTOMFINALIZED='Y' Where B.INSTITUTECODE='"+mInst+"' AND B.EXAMCODE='"+mExam+"'";
									qry=qry+" And B.SubjectID='"+mSubjID+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE ";
									qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
									qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
									qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
									qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
									qry=qry+" And nvl(B.DEACTIVE,'N')='N'";


																
								  }
								  
								//out.print(qry+"ankurY");
								
								   jk=db.update(qry);	
								
								if (jk>0 )
								   {
									  //--------------//
									  //  Log Entry   //
								  	  //--------------//
									    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"Sbject Running=[Y]", "ExamCode:"+ mExam +" Subject Code "+ mSubjCode+" SubjType:"+mST , "NO MAC Address" , mIPAddress);				
									   //--------------//						
									
									*/
									%>
									<!-- <td align=right><font color=green>Custom</font></td> -->
									<%
								 //  }
								//else
								 //  {
									%>
									<!-- 	<td>&nbsp;</td> -->
									<%
								//   }
							   //}

							
						%>
					</tr>
					<%
	
					}
                                        sb=session.getAttribute("sb").toString().trim();
				if (mfinalized.equals("YES"))

					{//out.print(sb);
						qry="Update preventsAYTagging B set ELRNNINGFINALIZEDBYHOD='Y',FINALIZEDBY='"+mDMemberID+"', FINALIZEDDATE=sysdate  Where B.INSTITUTECODE='"+mInst+"'";
						qry=qry+ " And B.MEMBERTYPE<>'S' and B.MEMBERID='"+mDMemberID+"' and b.Academicyear in("+sb+") ";
						qry=qry+ " And (b.INSTITUTECODE,b.PREVENTCODE) in (select PE.INSTITUTECODE,PE.PREVENTCODE from PREVENTMASTER PE ";
						qry=qry+" Where PE.INSTITUTECODE='"+mInst+"' and PE.EXAMCODE='"+mExam+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' ";
						qry=qry+" and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N') And nvl(B.ELRNNINGFINALIZEDBYHOD,'N')='N'  and nvl(B.DEACTIVE,'N')='N'";

						out.print(qry);
						jk=db.update(qry);	
						if (jk>0)
						//if(1==1)
						{
							  //--------------//
							  //  Log Entry   //
						  	  //--------------//
							    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"ELRunning Locked", "ExamCode:"+ mExam  , "NO MAC Address" , mIPAddress);				
							   //--------------//	
							String DoaID="";
							String DoaIDtype="";
							String DpeCode="";
							qry="Select ORAID,ORATYP from MEMBERMASTER where  ORAADM='"+enc.encode("DOAA")+"'";
							//out.println(qry);
							ResultSet rs=db.getRowset(qry);
							while(rs.next())
							{
									DoaID=enc.decode(rs.getString("ORAID"));
									DoaIDtype=enc.decode(rs.getString("ORATYP"));
							}
							/*qry="Select employeeid from hodlist where  departmentcode='"+mDepartmentCode+"'";
							//out.println(qry);
							ResultSet rs=db.getRowset(qry);
							while(rs.next())
							{
								DoaID=rs.getString("Employteeid");
								DoaIDtype="E";

							}*/
							try{
							qry="Select DEPARTMENT from departmentMASTER where  DEPARTMENTCODE='"+mDepartmentCode+"'";
							//out.println(qry);
							ResultSet rs1=db.getRowset(qry);
							if(rs1.next())
							{
									mDepartmentCode=rs1.getString("DEPARTMENT");
									mDepartmentCode=gb.replaceSignleQuot(mDepartmentCode);
									
							}
                                                        qry123="select 'y' from preventsAYTagging b  WHERE b.institutecode = '"+mInst+"'  AND b.membertype <> 'S'  AND b.memberid = '"+mDMemberID+"'  ";
                                                        qry123= qry123+" AND NVL (b.elrnningfinalizedbyhod, 'N') = 'N'    AND NVL (b.deactive, 'N') = 'N' and rownum=1";

                                                        rs123=db.getRowset(qry123);
                                                        if(!rs123.next()){


                                                 qry1234=" UPDATE prevents b ";
                                                 qry1234=qry1234+" SET elrnningfinalizedbyhod = 'Y',";
                                                 qry1234=qry1234+" finalizedby = '"+mDMemberID+"', ";
                                                 qry1234=qry1234+" finalizeddate = SYSDATE";
                                                 qry1234=qry1234+" WHERE b.institutecode = '"+mInst+"'";
                                                 qry1234=qry1234+" AND b.membertype <> 'S'";
                                                 qry1234=qry1234+" AND b.memberid = '"+mDMemberID+"'";
                                                 qry1234=qry1234+" AND NVL (b.loaddistributionstatus, 'N') = 'N'";
                                                 qry1234=qry1234+" AND (b.institutecode, b.preventcode) IN ( ";
                                                 qry1234=qry1234+" SELECT pe.institutecode, pe.preventcode ";
                                                 qry1234=qry1234+"  FROM preventmaster pe ";
                                                 qry1234=qry1234+"  WHERE pe.institutecode = '"+mInst+"' ";
                                                 qry1234=qry1234+"  AND   pe.examcode = '"+mExam+"' ";
                                                 qry1234=qry1234+"  AND NVL (pe.prcompleted, 'N') = 'N' ";
                                                 qry1234=qry1234+"  AND NVL (pe.prbroadcast, ' N') = 'Y' ";
                                                 qry1234=qry1234+"  AND NVL (pe.prrequiredfor, 'N') <> 'S' ";
                                                 qry1234=qry1234+"  AND NVL (pe.deactive, 'N') = 'N') ";
                                                 qry1234=qry1234+"   AND NVL (b.elrnningfinalizedbyhod, 'N') = 'N' ";
                                                 qry1234=qry1234+" AND NVL (b.deactive, 'N') = 'N' ";

                                                 updt=db.update(qry1234);
                                                if(updt>0){
                                                  //out.print("Updated Successfully");
                                                  }

                                                  }
				                  qry="";
					          qry="INSERT into MESSAGESLIST (INSTITUTECODE,MSGFROMUSERD,MSGFROMMemberType,MSGToUSERD,MSGToMemberType,MSGSUBJECT ,MSGTEXT,MSGDATETIME)values('"+mInst+"','"+mChkMemID+"','"+mChkMType+"','"+DoaID+"','"+DoaIDtype+"','ELECTIVE SUBJECT HAS BEEN APPROVED BY HOD("+mDepartmentCode+")','ELECTIVE SUBJECT HAS BEEN APPROVED BY HOD("+mDepartmentCode+")',sysdate)";
							//out.println(qry);
							k=db.update(qry);
							}catch(Exception e)
							{
								//out.println("e"+e);
							}

						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has been Finalized/Freezed<br> No further modification can take place.</font></td>
						<%	
						}
						else
						{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has not been Finalized/Freezed<br> HOD Load Distribution can not take place untile you finalized/Freezed the same.</font></td>
						<%	
						}


					}
					else
					{
						%>
						<tr><td colspan=4><font color=Blue size=3><b>Elective Subjects to be Run has not been Finalized/Freezed<br> HOD Load Distribution can not take place untile you finalized/Freezed the same.</font></td>
						<%	
					}


			%>
			</TABLE>
			 <%

  		}// Closing of Exam Code is null
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
		}

		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------

	    }  // if no rights assigned to the user
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
	} // closing of Session Time out check
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
} // closing of try
catch(Exception e)
{

}
%>
</body>
</html>