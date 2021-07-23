
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<script type="text/javascript" src="../js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="../css/sortabletable.css" />
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rss=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="",qrys="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0,total=0;
int kk1=0;
String Tagg="";
String Mpro="",mtag="",mSec="",mAcad="";
int Data=0;
String mSID="";
String mComp="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",mE="";
String mexam="";
String mLTP="";
String mltp="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="";
String mSubj="",mELECTIVECODE="";
String msubj="";
String mSubjType="";
String msubjType="",mST="",mCustomRun="",mCustom="",mSubRunPE="",mSubRunPS="",mSubjCode="";
int mFlag=0,sum=0;


//ArrayList arrlist =new ArrayList() ;

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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
String Academicyear1="";
 Academicyear1=request.getParameter("acdyear1")==null?"":request.getParameter("acdyear1");
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Elective Subject(s) Report ] </TITLE>


<script language="JavaScript" type ="text/javascript">

  if (top != self) top.document.title = document.title;

</script>

<script language=javascript>

	function RefreshContents()
	{
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}

	function Link(str,linkstr)
	{
			var cust=document.getElementById(str);
			//alert(cust.value);
			if(cust.value=="C")
			{
    	    var td=document.getElementById(str+"td");

			var link=document.createElement("a");

			link.setAttribute("href",linkstr);
			link.setAttribute("id",str+"a");
			link.appendChild(document.createTextNode("Click"));
			td.appendChild(link);
			}
			else if(cust.value=="Y")
			{
				var rem=document.getElementById(str+"a");
				rem.parentNode.removeChild(rem);
			}


			else if(cust.value=="N")
			{
				var rem=document.getElementById(str+"a");
				rem.parentNode.removeChild(rem);
			}


	}


</script>


<script>
	if(window.history.forward(1) != null)
	window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
 <%@page contentType="text/html"%>
	   	<%
		response.setContentType("application/vnd.ms-excel");
		%>
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

		/*qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{*/
		  //----------------------

			qry=" SELECT  a.EXAMCODE,ENDATE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and a.ExamCode in (Select PREREGEXAMID exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInstitute+"') and nvl(a.PRCOMPLETED,'N')='N' and ENDate is not null and fromdate is not null and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			rs= db.getRowset(qry);
			//out.print(qry);
			if(rs.next())
			{
				%>
				<form name="frm"  method="post" action="PreRegistrationElectiveReportXLS.jsp" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Elective Subject(s) [Pre registration]</b></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{
					qry="Select PREREGEXAMID Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInstitute+"'";
					rs=db.getRowset(qry);
					if (request.getParameter("x")==null)
				 	  {
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%
						     	}
						     	else
						         {
							%>
							      	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
				// out.println("Error Msg");
				}
				%>
				</td>
				<td>

				<B> &nbsp; &nbsp; Semester Type &nbsp; </b><select ID=SemType Name=SemType style="WIDTH: 60px">
				<%
					msemtype="ALL";
					%>
				<option selected value="ALL">ALL</option>
			 	</select>
				</td></tr>
				</table>

				<%
				int mData=0;
				int maxCol=0;
				int mSbjChoice=0;


				if (request.getParameter("Exam")==null)
					mE=mexam;
				else
					mE=request.getParameter("Exam").toString().trim();

				if(request.getParameter("SemType")==null)
					mSemType=msemtype;
				else
					mSemType=request.getParameter("SemType").toString().trim();

				mST="E";


				qry="Select 'Y' from PREVENTS Where ";
				qry=qry+"  ( nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' or nvl(LOADDISTRIBUTIONSTATUS,'N') in ('F','A'))";
				qry=qry+" and (PREVENTCODE) in (Select PREVENTCODE from PREVENTMASTER dd where ";
				qry=qry+" EXAMCODE='"+mE+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRREQUIREDFOR,'S')<>'S' and nvl(DEACTIVE,'N')='N')";
				qry=qry+" and MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' and nvl(DEACTIVE,'N')='N'";
				// If EL has not been approved then processINSTITUTECODE='"+mInstitute+"' and
				rs=db.getRowset(qry);
				//out.print(qry1);
				if (!rs.next())
				{
				%>
				<br>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center class="sort-table" id="table-1">
				<form name="frm1" ID="frm1"  method=post>
				<tr bgcolor='#ff8c00'>
				<td align=left ><font color=white><b>Program-Branch (Academic Year)</b></font></td>
				<td >


				<font color=white><b>Subject</b></font></td>

				<%


				/*qry="select max(B.CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE B where ";
				qry=qry+" B.INSTITUTECODE='"+mInstitute+"' And B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
				qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
				qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N' ";
				qry=qry+" And (D.INSTITUTECODE, D.PREVENTCODE) in (Select E.INSTITUTECODE, E.PREVENTCODE ";
				qry=qry+" from PREVENTS E Where E.MEMBERTYPE<>'S' and  nvl(E.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(E.DEACTIVE,'N')='N') )";  */

                               //new added

                                qry="select max(B.CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE B where ";
				qry=qry+" B.INSTITUTECODE='"+mInstitute+"' And B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
				qry=qry+" And B.SUBJECTTYPE='"+mST+"' AND B.ACADEMICYEAR in("+Academicyear1+") And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
				qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N' ";
				qry=qry+" And (D.INSTITUTECODE, D.PREVENTCODE) in (Select E.INSTITUTECODE, E.PREVENTCODE ";
				qry=qry+" from PREVENTS E Where E.MEMBERTYPE<>'S' and  nvl(E.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(E.DEACTIVE,'N')='N') )";
				//out.print(qry2);
				rs=db.getRowset(qry);

					if (rs.next())
						maxCol=rs.getInt(1);
					else
						maxCol=0;

					for(int i=1;i<=maxCol;i++)
					{
					%>
					 <td ><font color=white><b>Ch<%=i%></B></font></td>
					<%
					}
					%><td ><font color=white><b>Total(Students)</b></font></td>
					</tr>
					<%
					if (mST.equals("E"))
						{
						/*qry="select distinct  BDT.PROGRAMCODE PROGRAMCODE ,BDT.ACADEMICYEAR ACADEMICYEAR,BDT.TAGGINGFOR TAGGINGFOR, BDT.SECTIONBRANCH SECTIONBRANCH, nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N')LastStatus,NVL(C.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,B.SUBJECTTYPE SUBJECTTYPE,B.SEMESTER SEMESTER,B.SEMESTERTYPE SEMESTERTYPE,B.EXAMCODE EXAMCODE from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C, PR#DepartmentSubjectTagging BDT  where  A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
						qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
						qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S'  And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" And B.INSTITUTECODE=BDT.INSTITUTECODE and B.ACADEMICYEAR=BDT.ACADEMICYEAR and B.PROGRAMCODE=BDT.PROGRAMCODE and B.TAGGINGFOR=BDT.TAGGINGFOR and B.SECTIONBRANCH=BDT.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=BDT.INSTITUTECODE and a.SUBJECTID=BDT.SUBJECTID and b.SUBJECTID=bdt.SUBJECTID and b.EXAMCODE=bdt.EXAMCODE and c.SUBJECTID=bdt.SUBJECTID and c.EXAMCODE=bdt.examcode";
						qry=qry+" Group By BDT.PROGRAMCODE ,BDT.ACADEMICYEAR,BDT.TAGGINGFOR, BDT.SECTIONBRANCH,B.ElectiveCode,A.SubjectCode,B.SubjectID,nvl(A.Subject,A.SubjectCode), nvl(C.SubjectRunning,'N'),C.CUSTOMFINALIZED,B.SUBJECTTYPE,B.SEMESTER,B.SEMESTERTYPE,B.EXAMCODE ";
						qry=qry+" Order by count(*) Desc,Subject";
 * */ //new added

                                            qry="select distinct  BDT.PROGRAMCODE PROGRAMCODE ,BDT.ACADEMICYEAR ACADEMICYEAR,BDT.TAGGINGFOR TAGGINGFOR, BDT.SECTIONBRANCH SECTIONBRANCH, nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N')LastStatus,NVL(C.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,B.SUBJECTTYPE SUBJECTTYPE,B.SEMESTER SEMESTER,B.SEMESTERTYPE SEMESTERTYPE,B.EXAMCODE EXAMCODE from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C, PR#DepartmentSubjectTagging BDT  where  A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' AND B.ACADEMICYEAR in("+Academicyear1+")  And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
						qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
						qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S'  And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" And B.INSTITUTECODE=BDT.INSTITUTECODE and B.ACADEMICYEAR in ("+Academicyear1+") and B.PROGRAMCODE=BDT.PROGRAMCODE and B.TAGGINGFOR=BDT.TAGGINGFOR and B.SECTIONBRANCH=BDT.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=BDT.INSTITUTECODE and a.SUBJECTID=BDT.SUBJECTID and b.SUBJECTID=bdt.SUBJECTID and b.EXAMCODE=bdt.EXAMCODE and c.SUBJECTID=bdt.SUBJECTID and c.EXAMCODE=bdt.examcode";
						qry=qry+" Group By BDT.PROGRAMCODE ,BDT.ACADEMICYEAR,BDT.TAGGINGFOR, BDT.SECTIONBRANCH,B.ElectiveCode,A.SubjectCode,B.SubjectID,nvl(A.Subject,A.SubjectCode), nvl(C.SubjectRunning,'N'),C.CUSTOMFINALIZED,B.SUBJECTTYPE,B.SEMESTER,B.SEMESTERTYPE,B.EXAMCODE ";
						qry=qry+" Order by count(*) Desc,ElectiveCode,Subject";

						}

					//out.print(qry3);
					rs=db.getRowset(qry);
					%>
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
					<input type=hidden Name='SubjectType' ID='SubjectType' value='<%=mST%>'>
					<input type=hidden Name='SemType' ID='SemType' value='<%=mSemType%>'>
					<%

					String mColor="";
					int mChoice=0;
					String mLastStatus="";
					String mCol1="LightGrey";
					String mCol2="#ffffff";
					String mChkCode="",mChkOldCode="",mName10="",mName11="",mName12="";
					String mOldSubject="";


					while(rs.next())
					{
					//	mData=1;
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
						mChkCode=rs.getString("PROGRAMCODE")+rs.getString("SECTIONBRANCH") +rs.getString("ACADEMICYEAR")+rs.getString("ELECTIVECODE");
						if (mST.equals("E"))
							mELECTIVECODE=rs.getString("ELECTIVECODE");
						else
							mELECTIVECODE=" ";
						mSbjChoice=rs.getInt("MaxChoice");
						if (!mChkCode.equals(mChkOldCode))
							{
							   if (mChoice==0)
								mChoice=1 ;
							   else
								mChoice=0 ;
							mChkOldCode=mChkCode;
							}

						if (mChoice==0)
							mColor=mCol1;
						else
						      mColor=mCol2;

						mLastStatus=rs.getString("LastStatus").toString().trim();
						//mCustomRun=rs.getString("CUSTOMFINALIZED").toString().trim();

						mSubjCode=rs.getString("SC").toString().trim();


						//out.print(mOldSubject+"asdasd"+rs.getString("SC"));

					if(mOldSubject.equals("")){
						mOldSubject=rs.getString("SC");
						mSID=rs.getString("SID");
						 Mpro=rs.getString("PROGRAMCODE");
						 mtag=rs.getString("TAGGINGFOR");
						 mSec=rs.getString("SECTIONBRANCH");
						 mAcad=rs.getString("ACADEMICYEAR");

					}
					//out.println(mOldSubject +"<br>"+!mOldSubject.equals(rs.getString("SC"))+"<br>"+rs.getString("SC"));
					 if(!mOldSubject.equals(rs.getString("SC")))
						{
							mOldSubject=rs.getString("SC");
									//out.print("INNNNNNNNNN");
							%>
							<tr bgcolor=black>


							<td>&nbsp;
							</td>
							<td align=right>

									<font color=white><b>Total</b></font>
								</td>
							<%
							int mk=0;
							 for (int mCh=1;mCh<=maxCol;mCh++)
							{
								/*for( mk=mCh ; mk<=mCh;mk++)
								{*/
                                                             /*
								qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectId='"+mSID+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
							//	qry=qry+" And B.ACADEMICYEAR='"+mAcad+"'";// and B.PROGRAMCODE='"+Mpro+"'";
								qry=qry+" And B.TAGGINGFOR='"+mtag+"' ";//and B.SECTIONBRANCH='"+mSec+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";
 *
 * */  //new added
                                                              qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"' AND B.ACADEMICYEAR in("+Academicyear1+")" ;
								qry=qry+"  and B.SubjectId='"+mSID+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
								//qry=qry+" And B.ACADEMICYEAR='"+mAcad+"'";// and B.PROGRAMCODE='"+Mpro+"'";
								qry=qry+" And B.TAGGINGFOR='"+mtag+"' ";//and B.SECTIONBRANCH='"+mSec+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";

								//out.print(qry4);
								rs1=db.getRowset(qry);
							      while (rs1.next() )
								   {

										sum=sum+rs1.getInt(1);
									  if(sum!=0)
									   {
										%>
										 <td align=right><font color=white><B><%=sum%></B></font></td>
										<%
									   }
										else
									   {
											%>
										 <td align=right><font color=white>&nbsp;</font></td>
										<%

									   }


								    }
									total=sum+total;
									sum=0;

								//}
							   }



							%>
							<td>
							<font color=white><B><%=total%></B></font>
							</td>
							<%total=0;%>
							</tr>
							<%
								mSID=rs.getString("SID");
							 Mpro=rs.getString("PROGRAMCODE");
						 mtag=rs.getString("TAGGINGFOR");
						 mSec=rs.getString("SECTIONBRANCH");
						 mAcad=rs.getString("ACADEMICYEAR");
						}

%>


						<!------------------>
						<tr bgcolor="<%=mColor%>">
						<td>&nbsp;<%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%>
						 &nbsp;(<%=rs.getString("ACADEMICYEAR")%>)</td>
						<td nowrap>&nbsp;<%=mSubjCode%> - <br>
						<%
						    if (mELECTIVECODE.equals(" "))
					      	{
							%>
								<%=rs.getString("SUBJECT")%>
							<%
							}
							else
							{
							%>
								<%=rs.getString("SUBJECT")%>(<%=mELECTIVECODE%>)
							<%
							}

						//out.print(mLastStatus+"LastStatus"+mCustomRun+"Custom");
						%>
						</td>




						<%
							// Subject cum Choice wise Student Count

						    for (int mCh=1;mCh<=maxCol;mCh++)
							{
								int mk=mCh;
                                                                /*
								qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectId='"+rs.getString("SID")+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
								qry=qry+" And B.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and B.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
								qry=qry+" And B.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"' and B.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice"; */
                                                                //new added
                                                                qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectId='"+rs.getString("SID")+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
								qry=qry+" And B.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and B.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
								qry=qry+" And B.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"' and B.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";
								//out.print(qry5);
								rs1=db.getRowset(qry);
							      if (rs1.next() && rs1.getInt(1)>0)
								   {
									%>
										<td align=right><%=rs1.getInt(1)%>&nbsp;&nbsp;</td>
									<%




								    }
								else
								   {
									%>
										<td>&nbsp;</td>
									<%

								   }



							  }

							%>

<td>&nbsp;</td>
					</tr>
					<%


					}%>
<tr bgcolor=black>


							<td>&nbsp;
							</td>
							<td align=right>

								<font color=white><b>Total</b></font>
								</td>
							<%
							int mk=0;
							 for (int mCh=1;mCh<=maxCol;mCh++)
							{
								/*for( mk=mCh ; mk<=mCh;mk++)
								{*/
								/*qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectId='"+mSID+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
							//	qry=qry+" And B.ACADEMICYEAR='"+mAcad+"'";// and B.PROGRAMCODE='"+Mpro+"'";
								qry=qry+" And B.TAGGINGFOR='"+mtag+"' ";//and B.SECTIONBRANCH='"+mSec+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice"; */
                                                             //new added
                                                                qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"' AND B.ACADEMICYEAR in("+Academicyear1+")  ";
								qry=qry+" And B.SubjectId='"+mSID+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
							//	qry=qry+" And B.ACADEMICYEAR='"+mAcad+"'";// and B.PROGRAMCODE='"+Mpro+"'";
								qry=qry+" And B.TAGGINGFOR='"+mtag+"' ";//and B.SECTIONBRANCH='"+mSec+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";

								//out.print(qry6);
								rs1=db.getRowset(qry);
							      while (rs1.next() )
								   {

										sum=sum+rs1.getInt(1);

										 if(sum!=0)
									   {
										%>
										 <td align=right><font color=white><b><%=sum%></b></font></td>
										<%
									   }
										else
									   {
											%>
										 <td align=right><font color=white>&nbsp;</font></td>
										<%

									   }


								    }
									total=sum+total;
									sum=0;

								//}
							   }



							%>
							<td>
							<font color=white><B><%=total%></B></font>
							</td>
							<%total=0;%>
							</tr><%





			%>
				<tr><td align=center colspan=15>
					<font color=blue><a onClick="window.print();">
					<img src="../../../Images/printer.gif"  style="cursor:hand"><b>Click to Print</b></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT Type="submit" Value="Save in Excel">

					</td>

				</tr>
			</form>
			</TABLE>
			 <%
			}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration : Elective Subject Rnning is already approved/Finalized</FONT><br>
		Click here to see a list of finalized <a href='ElectiveSubjectRunningList.jsp'>Elective Sbjects(Running)</a></P>

		</P>
		 <%
		}


  		}
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

}
%>
</body>
</html>
