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
<TITLE>#### <%=mHead%> [ Pre Registration Subject Choice Confirmation ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;

function Validate()
{
//window.print();

var answer=confirm('Are you sure,you want to Freeze ? After this  action you cannot change your choice !');

if (answer ==1)
{
return true;
}
else if (answer==0)
{
return false;
}
//	return false;
}


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
	' * File Name:	PRStudentAction.jsp		[For Students]					
	' * Author:		Vijay Kumar
	' * Date:		07th Oct 2008
	' * Version:	1.0								
	' * Description:	Pre Registration of Students [Back & Curr Core+Elective+Free Elective Subject Choice.]
*************************************************************************************************
*/

DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
String qry="",mWebEmail="",EmpIDType="";
String mSemType="",mProg="",mBranch="",mSect="",mSubSect="",mTag="",mAcad="",mFactType="";
String mMemberID="",mMemberType="",mMemberCode="",mMemberName="",mDMemberCode="";
int mSem=0, MinForDBasket=0, MaxForDBasket=0, mErrFlag=0;
ResultSet rs=null,rs1=null,Rsd1=null, rsMaxSubjLmt=null,rsCCP=null;
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mSubjectType="",mPrcode="";
String mChk="", mSubjType="", mSubjId="", mSubjName="", mElecCode="";
int mSemester=0, mTotalRec=0, MaxSubjFlag=0, MaxSubjTknFlag=0, mLimitExceeded=0,aaa=0;
double mMinCrLmt=0, mMaxCrLmt=0, mCourseCrPtTkn=0, mCourseCrPt=0,mTotalCrLmtTkn=0;
String mBasket="", mChoice="1";
String mExamCode="",subjectrunning="";
String mInst="";
String mEmployeeID="";
String mSUBJECTID="",mEmployeename="",mElective="",msendtohod="",mCredit="";
String mEName=" ";
int n=0, BackCoreFlag=0, kk=0,mNo=0,mBas=0,mMsg=0,mBasketD=0,mDF=0;
double sum=0,sum1=0,mMinCCPCore=0,backcore=0;
double mMinBasketD=0,mMaxBasketD=0,sumcore=0,mCCP=0.0;
String Flag="N";
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

if (request.getParameter("mSem")==null)
{
	mSem=0;
}
else
{
	mSem=Integer.parseInt(request.getParameter("mSem").toString().trim());
}

if (request.getParameter("SemType")==null)
{
	mSemType="";
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
}

if (request.getParameter("mProg")==null)
{
	mProg="";
}
else
{
	mProg=request.getParameter("mProg").toString().trim();
}
if (request.getParameter("mBranch")==null)
{
	mBranch="";
}
else
{
	mBranch=request.getParameter("mBranch").toString().trim();
}
if (request.getParameter("mSect")==null)
{
	mSect="";
}
else
{
	mSect=request.getParameter("mSect").toString().trim();
}
	
if (request.getParameter("mTag")==null)
{
	mTag="";
}
else
{
	mTag=request.getParameter("mTag").toString().trim();
}

if (request.getParameter("mAcad")==null)
{
	mAcad="";
}
else
{
	mAcad=request.getParameter("mAcad").toString().trim();
}

msendtohod="N";

if (request.getParameter("ExamCode")==null)
{
	mExamCode="";
}
else
{
	mExamCode=request.getParameter("ExamCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();   
}
if (request.getParameter("PREVENTCODE")==null)
{
	mPrcode="";
}
else
{
	mPrcode=request.getParameter("PREVENTCODE").toString().trim();
}
if (request.getParameter("TotalCCPAld")==null)
{
	mCourseCrPtTkn=0;
}
else
{
	mCourseCrPtTkn=Double.parseDouble(request.getParameter("TotalCCPAld").toString().trim());
}
//out.print(mCourseCrPtTkn);

qry=qry+" select min(A.COURSECREDITPOINT) COURSECREDITPOINT from PROGRAMSCHEME A,SUBJECTMASTER B";
qry=qry+" where A.institutecode='"+mInst +"' and A.Academicyear='"+mAcad+"' and A.programcode='"+mProg+"' and A.TAGGINGFOR='"+mTag+"' AND A.SECTIONBRANCH='"+mSect+"' ";
qry=qry+" and A.semester="+mSem+" AND A.BASKET='A' AND A.institutecode=B.institutecode and A.subjectID=B.subjectID ";
rs=db.getRowset(qry);
if(rs.next())
{
	mMinCCPCore=rs.getDouble(1);
}


qry="SELECT MINCREDITPOINT MINCRPT, MAXCREDITPOINT MAXCRPT FROM PR#PROGRAMMINMAXCP WHERE INSTITUTECODE='"+mInst+"' AND (EXAMCODE,REGCODE) in ";
qry=qry+" (SELECT  ExamCode,REGCODE from PREVENTMASTER WHERE INSTITUTECODE='"+mInst+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='S' AND NVL(DEACTIVE,'N')='N')";
qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mSect+"' AND SEMESTER="+mSem+" AND EXAMCODE='"+mExamCode+"' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mMinCrLmt=rs.getDouble(1);
	mMaxCrLmt=rs.getDouble(2);

}

qry="SELECT MINSUBJECT MINSUBJECT, MAXSUBJECT MAXSUBJECT FROM basketmaster WHERE INSTITUTECODE='"+mInst+"'  ";
qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mSect+"' AND SEMESTER="+mSem+" and basket in ('E','D') ";
rs=db.getRowset(qry);
if(rs.next())
{
	mMinBasketD=rs.getDouble(1);
	mMaxBasketD=rs.getDouble(2);
}

double mMinBasketB=0.0,mMaxBasketB=0.0;

qry="SELECT MINSUBJECT MINSUBJECT, MAXSUBJECT MAXSUBJECT FROM basketmaster WHERE INSTITUTECODE='"+mInst+"'  ";
qry=qry+" AND ACADEMICYEAR='"+mAcad+"' AND PROGRAMCODE='"+mProg+"' AND TAGGINGFOR='"+mTag+"' AND SECTIONBRANCH='"+mSect+"' AND SEMESTER="+mSem+" and basket='B' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
{
	mMinBasketB=rs.getDouble(1);
	mMaxBasketB=rs.getDouble(2);
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

		qry=" SELECT nvl(SUBSECTIONCODE,' ')SUBSECTIONCODE FROM STUDENTMASTER WHERE STUDENTID='"+mChkMemID+"' and INSTITUTECODE='"+mInst+"' ";
		Rsd1=db.getRowset(qry);
		if(Rsd1.next())
		{
			mSubSect=Rsd1.getString(1);
		}

		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------

		qry="Select WEBKIOSK.ShowLink('52','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			//-------------------------------------
			//----- For Log Entry Purpose
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
			<form name="frm1" method="post" action="PRStudSendToHODAction.jsp">
<%
			if (request.getParameter("TotalRec")!=null && Integer.parseInt(request.getParameter("TotalRec").toString().trim())>0)
			{	//3
				mTotalRec =Integer.parseInt(request.getParameter("TotalRec").toString().trim());
				String mFlag="Y";
				int studelecchoise=0;
				//out.println("ddd");
				int aa=1;
				if(request.getParameter("studelecchoise")==null)
					studelecchoise=0;
				else if(request.getParameter("studelecchoise").equals(""))
					studelecchoise=0;
				else
					studelecchoise=Integer.parseInt(request.getParameter("studelecchoise"));
				//---------------------------------------------------------------
				// Validateinf Choice - If duplicate entry redirect to prev page
				//---------------------------------------------------------------
				for (int TT1=1;TT1<=mTotalRec;TT1++)
				{
					//out.println(mTotalRec+"<br>");
					mName1="CHK"+String.valueOf(TT1).trim(); 
					mName3="SEMTYP"+String.valueOf(TT1).trim(); 
					mName4="SUBJTYP"+String.valueOf(TT1).trim(); 
					mName8="ELCODE"+String.valueOf(TT1).trim(); 
					mName7="CCP"+String.valueOf(TT1).trim(); 
					mName9="BASKET"+String.valueOf(TT1).trim(); 
					mName10="CHOICE"+String.valueOf(TT1).trim(); 
					if (request.getParameter(mName1)==null)
						mChk="N";
					else
						mChk=request.getParameter(mName1).toString().trim();
					if(request.getParameter(mName3)==null)
						mSemType="";
					else
						mSemType=request.getParameter(mName3);
					if(request.getParameter(mName4)==null)
						mSemType="";
					else
						mSubjType=request.getParameter(mName4);
					if(request.getParameter(mName7)==null)
						mCredit="";
					else
						mCredit=request.getParameter(mName7).toString().trim();
					if(request.getParameter(mName9)==null)
						mBasket="";
					else
						mBasket=request.getParameter(mName9).toString().trim();
					if(request.getParameter(mName10)==null)
						mChoice="";
					else
						mChoice=request.getParameter(mName10).toString().trim();	
					//out.println("::<br>");
					if(mChk.equals("Y") )
					{
						//out.println(request.getParameter("pdvalue"));
						if(mBasket.equals("B") && mDF==0 && request.getParameter("pdvalue").equals("Y"))
						{
						sum1=sum1+Double.parseDouble(mCredit);
						//out.println("a"+sum1);
						mDF=1;
						}
						else if(!mBasket.equals("B"))
						{
							if(studelecchoise>=aa && (mBasket.equals("D") || mBasket.equals("E")))
							{
								sum1=sum1+Double.parseDouble(mCredit);
								aa++;
							}
							else if (!mBasket.equals("D") && !mBasket.equals("E") )
								sum1=sum1+Double.parseDouble(mCredit);

							
							

						}
						
						//out.print(mBasket+"<BR>"+sum1);
					}
					//out.print(mBasket+"<BR>");
					//out.println(mSemType+""+mSubjType+""+mChk+"<br>");
					
					if(mSubjType.equals("C"))
					{
						sumcore=sumcore+Double.parseDouble(mCredit);
					}
					if(mSemType.equals("RWJ") ||  mSemType.equals("SAP"))
					{
						backcore=backcore+Double.parseDouble(mCredit);
					}
					
					
					
					
					if(mSubjType.equals("C") && (mSemType.equals("RWJ") || mSemType.equals("SAP")) && mChk.equals("N"))
					{
						BackCoreFlag++;
					}
					if(request.getParameter(mName8)==null)
					{
						mElecCode="";
					}
					else
					{
						mElecCode=request.getParameter(mName8).toString().trim();
					}
					//out.print(mElecCode+"<br>");
				
					if(mBasket.equals("A") && mSemType.equals("REG") && mChk.equals("Y"))
					{
						mMsg=1;
					}

					if(mBasket.equals("D") && mSemType.equals("REG") && mChk.equals("Y"))
					{
						mBasketD++;
					}
					//out.print(mChk);
					if(mBasket.equals("E") && mSemType.equals("REG") && mChk.equals("Y"))
					{
						mBasketD++;
					}
				}
				//out.println("aaaaa");
				//out.print(mMsg+"dddd"+(sum1+mMinCCPCore)+"ss"+mMaxCrLmt);
				/*int studelecchoise=0;
				if(request.getParameter("studelecchoise")==null)
					studelecchoise=0;
				else
					studelecchoise=Integer.parseInt(request.getParameter("studelecchoise"));*/
				if(sumcore>=mMaxCrLmt)
					mMsg=1;
				if(mMsg==0 && ((sum1+mMinCCPCore) > mMaxCrLmt) )
				{
					%>
					<br>
					<CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'>Please select the core subject of current semester  !</font>
					<font size=4 color=blue><a href="PRStudentEntry.jsp">Continue...</a></font>
					</CENTER><BR>
					<%
				}

				else
				{
					double a=0,mBasketDCCP=3,b=0;
					//out.print(mBasketD+"mBasketD");
					//out.println(sum1+"<BR>");
					//out.print((studelecchoise) * mBasketDCCP);
					a =sum1+ ((studelecchoise) * mBasketDCCP);
					b =sum1 + ((mBasketD+1) * mBasketDCCP );					
					//out.print(sum1+"<br>");
					//out.print(a+"<br>");
					//out.print(b+"<br>");
					//out.print(a+"aaa<br>"+mBasketD+"mMaxCrLmt="+mMaxCrLmt+"<br>mMinBasketD="+mMinBasketD+"<br>mMaxBasketD="+mMaxBasketD);
					//out.println(a <=mMaxCrLmt);
					//out.println("aaa"+request.getParameter("CHOICE1")!=null);
					if(request.getParameter("select1")!=null && (((studelecchoise < mMinBasketD && (a <=mMaxCrLmt)) || studelecchoise >mMaxBasketD ) || (b <= mMaxCrLmt && studelecchoise < mMinBasketD ))) 
							
					{
						%>
						<br>
					<CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'>Minimum <%=mMinBasketD%> and Maximum <%=mMaxBasketD%> Elective Subjects must be selected !</font>
					</CENTER><BR>
					<%
					}
					else
					{
				%>
				

				<center><font size=4 color=navy><b>Registration Status<BR>
				Ensure to Save/Freeze as given below</b> </font></center>
				<!--<table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
				<tr bgcolor=ff8c00>
				<td><font color=white><b>Subject (Subject Code)</b></font></td>
				<td><font color=white><b>Subject Type</b></font></td>
				<td><font color=white><b>Credit</b></font></td>
				<td><font color=white><b>Priority</b></font></td>
				<td><font color=white><b>Pre-Reg. Status</b></font></td>-->
				<input Type=hidden id="ExamCode" name="ExamCode" value='<%=mExamCode%>'>
				<input Type=hidden id="PREVENTCODE" name="PREVENTCODE" value='<%=mPrcode%>'>
				
				<%
				if(backcore>=mMaxCrLmt)
					BackCoreFlag=0;
					
				if(BackCoreFlag==0)
				{
					if (mFlag.equals("Y"))
					{
						
						
						mCourseCrPtTkn=sum1;
					//	out.println(mCourseCrPtTkn+"mMinCrLmt:"+mMinCrLmt+"mMaxCrLmt:"+mMaxCrLmt);
						if(mCourseCrPtTkn>=mMinCrLmt && mCourseCrPtTkn<=mMaxCrLmt)
						{
							qry="Delete from PR#STUDENTSUBJECTCHOICE where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamCode+"'";
							qry=qry+" and ACADEMICYEAR='"+mAcad+"' and PROGRAMCODE='"+mProg+"' and TAGGINGFOR='"+mTag+"' and ";
							qry=qry+" SECTIONBRANCH='"+mSect+"' and STUDENTID='"+mChkMemID+"'";
							int aa1=db.update(qry);
							//out.print(qry);
							qry="update prevents set NOOFELESUBJECTSCHOICES='' where institutecode = '"+mInst+"' and  MEMBERID= '"+mMemberID+"'    and PREVENTCODE='"+mPrcode+"'   and nvl(deactive,'N')<>'Y' ";
							//out.println(qry);
							db.update(qry);
							qry="delete from NRSTUDENTFAILSUBJECTS where INSTITUTECODE='"+mInst+"' and  ACADEMICYEAR='"+mAcad+"' and  PROGRAMCODE='"+mProg+"' and CURRENTEXAM='"+mExamCode+"'";
							//out.println(qry);
							int yy=db.update(qry);
							//out.println(yy);
							
							
							
							
							
							for (kk=1;kk<=mTotalRec ;kk++)
							{
								mName1="CHK"+String.valueOf(kk).trim(); 
								mName2="SEM"+String.valueOf(kk).trim(); 
								mName3="SEMTYP"+String.valueOf(kk).trim(); 
								mName4="SUBJTYP"+String.valueOf(kk).trim(); 
								mName5="SUBJID"+String.valueOf(kk).trim(); 
								mName6="SUBJ"+String.valueOf(kk).trim(); 
								mName7="CCP"+String.valueOf(kk).trim(); 
								mName8="ELCODE"+String.valueOf(kk).trim();
								mName9="BASKET"+String.valueOf(kk).trim(); 
								mName10="CHOICE"+String.valueOf(kk).trim(); 
								try
								{
									if (request.getParameter(mName1)==null)
										mChk="N";
									else
										mChk=request.getParameter(mName1).toString().trim();

									mSemester=Integer.parseInt(request.getParameter(mName2).toString().trim());
									mSemType=request.getParameter(mName3).toString().trim();
									mSubjType=request.getParameter(mName4).toString().trim();
									mSubjId=request.getParameter(mName5).toString().trim();
									mSubjName=request.getParameter(mName6).toString().trim();
									mCourseCrPt=Double.parseDouble(request.getParameter(mName7).toString().trim());
									if(request.getParameter(mName8)==null)
									{
										mElecCode="";
									}
									else
									{
										mElecCode=request.getParameter(mName8).toString().trim();
									}
									mBasket=request.getParameter(mName9).toString().trim();
									
									mChoice=request.getParameter(mName10).toString().trim();
									
									
									/*if(request.getParameter(mName10).equals("") && request.getParameter(mName10)==null)
									{
										mChoice="";
									}
									else
									{
										mChoice=request.getParameter(mName10).toString().trim();
									}
								*/
								
								if(mBasket.equals("D") && !mElecCode.equals("") && mChk.equals("Y"))
								{
				
									/*for(int msem=1;msem<=mSem;msem++)
									{
										qry="Select MINSUBJECT MinSubj, MAXSUBJECT MaxSubj From BasketMaster Where INSTITUTECODE='"+mInst+"' And ACADEMICYEAR='"+mAcad+"' And PROGRAMCODE='"+mProg+"' And TAGGINGFOR='"+mTag+"' And SECTIONBRANCH='"+mSect+"' And SEMESTER="+msem+" And BASKET='D'";
										rsMaxSubjLmt=db.getRowset(qry);
										out.print(qry);
										if(rsMaxSubjLmt.next())
										{
											MinForDBasket=rsMaxSubjLmt.getInt("MinSubj");
											MaxForDBasket=rsMaxSubjLmt.getInt("MaxSubj");
										}
										
										if(mSemester==msem)
										{
										
											MaxSubjFlag++;

										}
										
										
										if(MaxSubjFlag<=MinForDBasket || MaxSubjFlag>=MaxForDBasket)
										{
											//out.print(MaxSubjTknFlag+"hhh");
											MaxSubjTknFlag++;
										}
									}*/
								}
								
								
								if(mSubjType.equals("C")){
									//out.println("hello");
									mSubSect=mSubSect;
									subjectrunning="Y";
								}
								else if(1==1){
									mSubSect=mSubSect;
									subjectrunning="";
								}
								else if(mSubjType.equals("E")){
									mElecCode=mElecCode;
										mSubSect=mSubSect;
										//out.println("hello"+mSubSect);
									subjectrunning="";
									
								}else{
									mElecCode="";
									subjectrunning="";
								}
								
									
								if(MaxSubjTknFlag==0 )
								{
									//out.print(mChoice+"<br>");
									if(!mChoice.equals("") && !mChoice.equals("0"))
									{
										//out.println(mSubjId+"::::"+mChk);
										if(mChk.equals("Y") && mChoice!=null )
										{

												if(mSemType.equals("SAP") || mSemType.equals("RWJ") )
												{
													mSubSect="";
												}
												
												//out.println("<br>aa"+subjectrunning);
												qry="INSERT INTO PR#STUDENTSUBJECTCHOICE ( INSTITUTECODE, EXAMCODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR,";
												qry=qry+" SECTIONBRANCH,SEMESTER, STUDENTID, SUBJECTID, SEMESTERTYPE, ELECTIVECODE, CHOICE,SUBJECTRUNNING, SUBSECTIONCODE, ENTRYDATE,ENTRYBY,SUBJECTTYPE)";
												qry=qry+" VALUES ('"+mInst+"','"+mExamCode+"','"+mAcad+"','"+mProg+"','"+mTag+"','"+mSect+"','"+mSemester+"',";
												qry=qry+" '"+mMemberID+"','"+mSubjId+"','"+mSemType+"','"+mElecCode+"','"+mChoice+"', '"+subjectrunning+"','"+mSubSect+"', sysdate,'"+mMemberID+"','"+mSubjType+"')";
												n=0;
												n=db.update(qry);
											//	out.print(qry);
												//n=0;
											if(n>0)
											{
												
												//out.println(mSemType);
												if(mSemType.equals("SAP"))
												{
													String qrya="update NRSTUDENTFAILSUBJECTS set REGISTERED='Y', REGISTEREXAMCODE='"+mExamCode+"', REGISTERDATE =sysdate where INSTITUTECODE='"+mInst+"' and PROGRAMCODE='"+mProg+"' and   TAGGINGFOR ='"+mTag+"' and  SECTIONBRANCH='"+mSect+"' and  STUDENTID='"+mMemberID+"' and  SEMESTER ='"+mSemester+"'  and SUBJECTID='"+mSubjId+"'";
													//out.println("hhi"+qrya);
													db.update(qrya);

												}
												
												
												if(mBasket.equals("B") && mBas==0)
												{													
													sum=sum+mCourseCrPt;
													mBas=1;
												}											
												else if(!mBasket.equals("B"))
												{
													if(studelecchoise>aaa && (mBasket.equals("D") || mBasket.equals("E")))
													{
														sum=sum+mCourseCrPt;
														aaa++;
													}
													else if (!mBasket.equals("D") && !mBasket.equals("E") )
														sum=sum+mCourseCrPt;		
												}
												db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"STUDENT PRE REGISTRATION CHOICE", "Exam Code : "+mExamCode +"Academic Year : "+ mAcad+ "Program Code : "+mProg+"Subject : "+mSubjName, "NO MAC Address" , mIPAddress);
												%>
												<%
													
												
												
												%>
												
												
												
												
												
												
												
												
												<!--<tr><td><%//=mSubjName%></td>
												<td align=center><%//=mSubjType%></td>
												<td align=center><%//=mCourseCrPt%>
												 </td>
												<td align=center>&nbsp;<%//=mChoice%></td>
												<td align=center><font color=Green>Submitted</font></td></tr>-->
												<%
											}
										  
										}
										else
										{
											if(mSubjType.equals("C")){

											String qryh="select 'Y' from NRSTUDENTFAILSUBJECTS where INSTITUTECODE='"+mInst+"' and PROGRAMCODE='"+mProg+"' and   TAGGINGFOR ='"+mTag+"' and  SECTIONBRANCH='"+mSect+"' and  STUDENTID='"+mMemberID+"' and  SEMESTER ='"+mSemester+"'  and SUBJECTID='"+mSubjId+"'";
											rs=db.getRowset(qryh);
										if(rs.next()){
										 String qrya="update NRSTUDENTFAILSUBJECTS set REGISTERED='', REGISTEREXAMCODE='', REGISTERDATE ='' where INSTITUTECODE='"+mInst+"' and PROGRAMCODE='"+mProg+"' and   TAGGINGFOR ='"+mTag+"' and  SECTIONBRANCH='"+mSect+"' and  STUDENTID='"+mMemberID+"' and  SEMESTER ='"+mSemester+"'  and SUBJECTID='"+mSubjId+"'";
													//out.println("hhi"+qrya);
													db.update(qrya);


											}else{

										qry="INSERT INTO NRSTUDENTFAILSUBJECTS (INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, TAGGINGFOR, SECTIONBRANCH, STUDENTID, SEMESTER, SUBJECTID, SUBJECTTYPE, BASKET,ENTRYBY, ENTRYDATE,CURRENTEXAM) VALUES ('"+mInst+"','"+mAcad+"','"+mProg+"','"+mTag+"','"+mSect+"','"+mMemberID+"','"+mSemester+"','"+mSubjId+"','"+mSubjType+"','A','"+mMemberID+"',sysdate,'"+mExamCode+"')";
										//out.print(qry);
										db.update(qry);
													}




										//out.println(qry);
										}
										}
									}
									else
									{
										//out.print(mSubjType);
										
										//,'"+mChoice+"', '"+subjectrunning+"','"+mSubSect+"', sysdate,'"+mMemberID+"',)";
										
										
										
										
										
										/*if(request.getParameter("select")!=null)
											mNo=1;
										else
											mNo=0;*/
										
									}
								}
								else
								{
									mLimitExceeded++;
								}
								}
								catch(Exception e)
								{
									//out.print(e);
								}
							}
							qry="";
							qry="update prevents set NOOFELESUBJECTSCHOICES='"+studelecchoise+"' where institutecode = '"+mInst+"' and  MEMBERID= '"+mMemberID+"'    and PREVENTCODE='"+mPrcode+"'   and nvl(deactive,'N')<>'Y' ";
							//out.println(qry);
							db.update(qry);
							%><table border=1 cellpadding=3 cellspacing=1 rules="All" align=center>
				<tr bgcolor=ff8c00>
				<td><font color=white><b>Subject (Subject Code)</b></font></td>
				<td><font color=white><b>Subject Type</b></font></td>
				<td><font color=white><b>Credit</b></font></td>
				<td><font color=white><b>Priority</b></font></td>
				<td><font color=white><b>Pre-Reg. Status</b></font></td></tr><%
							String qry12="Select SUBJECTID,subject,nvl(choice,0) abc,subjectrunning,decode(electivecode,'B', 1,null,2,'PDE',3,'DE',4)aa,electivecode,decode(electivecode,null,'Core','B-1','Elective(PDE)','PDE','Elective(PDE)','PD', 'Elective(PDE)','E-1', 'Elective(E-1)', 'E-2', 'Elective(E-2)', 'E-3', 'Elective(E-3)','DE','Elective(DE)','B','BackCore','E','Elective',electivecode)subjecttype,semestertype from (SELECT DISTINCT   A.SUBJECTID , NVL (a.subject, ' ')                 || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype           FROM subjectmaster a, pr#studentsubjectchoice b          WHERE b.examcode = '"+mExamCode+"'            AND b.institutecode = '"+mInst+"'            AND b.semestertype = 'REG'            AND b.subjecttype = 'C'            AND b.studentid = '"+mMemberID+"'   and a.INSTITUTECODE=b.INSTITUTECODE          AND a.subjectid = b.subjectid            union       SELECT DISTINCT  A.SUBJECTID ,  NVL (a.subject, ' ')                || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                NVL (b.electivecode, '') electivecode,                NVL (b.subjecttype, '') subjecttype,                NVL (b.semestertype, '') semestertype           FROM subjectmaster a, pr#studentsubjectchoice b          WHERE b.examcode = '"+mExamCode+"'             AND b.institutecode = '"+mInst+"'             AND b.semestertype = 'REG'             AND b.subjecttype = 'E'             AND b.studentid = '"+mMemberID+"'      and a.INSTITUTECODE=b.INSTITUTECODE        AND a.subjectid = b.subjectid             union SELECT DISTINCT  A.SUBJECTID ,  NVL (a.subject, ' ')                || '('                || NVL (a.subjectcode, ' ')                || ')' subject,                NVL (b.choice, 0) choice,                NVL (b.subjectrunning, ' ') subjectrunning,                'B' electivecode, NVL (b.subjecttype, '')                subjecttype,                NVL (b.semestertype, '') semestertype           FROM subjectmaster a, pr#studentsubjectchoice b          WHERE b.examcode = '"+mExamCode+"'            AND b.institutecode = '"+mInst+"'            AND b.semestertype in('RWJ','SAP')            AND b.studentid = '"+mMemberID+"'    and a.INSTITUTECODE=b.INSTITUTECODE         AND a.subjectid = b.subjectid       ORDER BY subjecttype,electivecode)  ";
								rs1=db.getRowset(qry12);		
								//out.print(qry12);
							while(rs1.next())
							{
									

								qry="select max(COURSECREDITPOINT)COURSECREDITPOINT from (Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT From PROGRAMSUBJECTTAGGING C where examcode='"+mExamCode+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From OfferSubjectTagging C where examcode='"+mExamCode+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" UNION Select nvl(C.COURSECREDITPOINT,0) COURSECREDITPOINT   From pr#electivesubjects C where examcode='"+mExamCode+"'  And subjectid='"+rs1.getString("SUBJECTID")+"' AND INSTITUTECODE='"+mInst+"' )";
								//out.print(qry);
								rsCCP=db.getRowset(qry);
								if (rsCCP.next())
								{
									mCCP=rsCCP.getDouble("COURSECREDITPOINT");
								}
								else
								{
									mCCP=0;
								}



								if(rs1.getString("subjecttype").equals("Elective(PDE)"))
								{
									%><tr bgcolor='lightyellow'><%
								}else if(rs1.getString("subjecttype").equals("Elective(DE)")){
									%><tr bgcolor='white'><%
								}else if(rs1.getString("subjecttype").equals("C")){
									%><tr bgcolor='LightGrey'><%
								}else if(rs1.getString("subjecttype").equals("BackCore")){
									%><tr bgcolor='#FFB9B9'><%
								}


												%>
												<td><%=rs1.getString("subject")%></td>
												<td align=center nowrap><%=rs1.getString("subjecttype")%></td>
												<td align=center>&nbsp;<%=mCCP%></td>
												<td align=center>&nbsp;<%=rs1.getString("abc")%></td>
												<td align=center><font color=Green>Submitted</font></td></tr>
												<%
							}


						}	
						else
						{
							%><BR><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Your Course Credit Points must be within the permissible limit [between <%=mMinCrLmt%> and <%=mMaxCrLmt%>] !</font></CENTER><BR><%
						}
					}
				}
				else
				{
					%><BR><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> You must have to choose Backlog Core subject !</font></CENTER><BR><%
				}
	
				if(mLimitExceeded > 0)
				{
					%><BR><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Total Elective Subject (without preference) chosen by you must be within the permissible limit!</font></CENTER><BR><%
				}
			if(mNo==1)
			{
				%><BR><CENTER><img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'>Choice should not be blank!</font></CENTER><BR><%
			}
				%>
				

				<tr><td colspan=5 align=right><%if(sum!=0.0){%><Font color=green face=verdana size=4><B>Total Course Credit Points Pre-Registered/Allowed Now : <%=sum%><b></font><%}%></td></tr>

				<%
					qry="select sum(totalearnedcredit)totalearnedcredit from STUDENTSGPACGPA where INSTITUTECODE='"+mInst+"' and  studentid= '"+mMemberID+"' ";
				//out.print(qry);
					rs=db.getRowset(qry);
					if(rs.next())
						{
						%>
						<tr><td colspan=5 align=right><Font color=green face=verdana size=4><B>Total Earned Credit Till Date : <%=rs.getDouble("totalearnedcredit")%><b></font></td></tr>		
						<%	

						}

//Examcode check is from companyinstitutetagging current semester

	qry="select distinct nvl(A.SUBJECT,' ')||'('||NVL(A.SUBJECTCODE,' ')||')' SUBJECT, ";
	qry=qry+" nvl(b.COURSECREDITPOINT,0)COURSECREDITPOINT, nvl(B.BASKET,'C')BASKET,A.SEMESTER||' ('||A.SEMESTERTYPE||')' sem  ";
	qry=qry+" FROM V#STUDENTSUBJECTTAGGING A, PROGRAMSUBJECTTAGGING B,companyinstitutetagging c WHERE  a.EXAMCODE=c.GRADEENTRYEXAMID          and a.INSTITUTECODE=c.INSTITUTECODE          and c.INSTITUTECODE=b.INSTITUTECODE          and c.GRADEENTRYEXAMID=b.EXAMCODE ";
	qry=qry+" and A.studentid='"+mMemberID+"' and B.institutecode='"+mInst+"' and ";
	qry=qry+" nvl(B.deactive,'N')='N' and B.SUBJECTID=A.SUBJECTID AND B.INSTITUTECODE=A.INSTITUTECODE and ";
	qry=qry+" nvl(A.deactive,'N')='N' and B.BASKET=A.BASKET AND A.EXAMCODE=B.EXAMCODE ";
	//qry=qry+" B.ACADEMICYEAR=A.ACADEMICYEAR AND B.TAGGINGFOR=A.TAGGINGFOR and ";
	//qry=qry+" Group By A.SUBJECT, A.SUBJECTCODE, B.COURSECREDITPOINT, B.BASKET ";
	qry=qry+" order by basket, COURSECREDITPOINT";

	rs1=db.getRowset(qry);
	//out.print(qry);
	
	while(rs1.next())
	{
		
		mTotalCrLmtTkn=mTotalCrLmtTkn+Double.parseDouble(rs1.getString("COURSECREDITPOINT"));

	}
%>
<tr><td colspan=5 align=right><Font color=green face=verdana size=4><B>Credits Registered in <%=mSem-1%> Semester :</b> <b><%=mTotalCrLmtTkn%></b></font></td></tr>

		
			
				<td colspan=5 align=left><%if(sum!=0.0){%><Font color=green face=verdana size=3><B>Once You  Freeze, you cannot change your preference / choice !
				<br>
				If you wish to edit click Pre Registration Link again.
				<b></font><%}%>
				<%if(sum!=0.0){%>
				<INPUT TYPE="submit" value="Click to Freeze" onClick="return Validate();">
				<%}%>
				
				</td></tr>

				</table>
				<input type=hidden name="mysumm" value="<%=sum%>">
				</form>
				<!-- <marquee scrolldelay=125 behavior=alternate><font color=red><b>NOTE:- <font color=red size=2>&nbsp; &nbsp; # After Submitting your Choice for Regular and BackPaper,you need to send your choice to HOD for Approval.</font>
				</marquee> -->
				<%
				
				}
				}
				} //3
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>No subject found or choice given by you!</font> <br>");	
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
			<h3>	<br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>
			<%
		}
		//-----------------------------
	}  //2
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}	//1	
catch(Exception e)
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> No Item Selected...</font> <br>");
	out.print(e.getMessage()+ " - " +e);
}
%><br><br>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</body>
</html>