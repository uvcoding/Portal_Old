<%@ page buffer="1kb" autoFlush="true" language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
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
<script language=javascript>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: large; FONT-FAMILY: fantasy"><b>Grade Sheet</b></TD>
</font></td></tr>
</TABLE>
<br>
<%
try
{
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
DBHandler db=new DBHandler();
String mCheckRadio="";
String  mMemberID="",mMemberType="",mMemberName="",mMemberCode="",mInst="";

String mDMemberCode="",mDMemberType="";
Set mGradeChecked=new HashSet();
Set mGradeUnChecked=new HashSet();
int mCount=0;
int pos2Init=0,pos2=0,pos3Init=0,pos20=0;
String mWeightageInit="",mWeightage="";
String mInitMarks="",mWe="";
int pos4Init=0,pos201=0;
String mMassCut="",mMass="",qryv="";
int pos2011=0,pos5Init=0;
String mFST="",mfst="";

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

  if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
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
qryv="Select WEBKIOSK.ShowLink('146','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
RsChk= db.getRowset(qryv);
if (RsChk.next() && RsChk.getString("SL").equals("Y"))
 {
      if(request.getParameter("CHECKRADIO")==null)
		mCheckRadio="N";
	else
		mCheckRadio=request.getParameter("CHECKRADIO").toString().trim();

	if(request.getParameter("COUNT")==null)
		mCount=0;
	else
		mCount=Integer.parseInt(request.getParameter("COUNT").toString().trim());

	int len=0;
	int pos=0,pos1=0;
	int lenInit=0;
	int posInit=0,pos1Init=0;
	String mStudid="",mMarks="",mGrad="",mExamCode="";
	String mStudidInit="",mMarksInit="",mGradInit="",mSubjectCode="";
	String mName="",mRoll="",mNam="";
	int ctr=0;
	String qry="",qrysub="";
	String mSc="";
	String mSem1="";

	ResultSet rs=null,rssub=null;

	if(request.getParameter("ExamCode")==null)
		mExamCode="";
	else
		mExamCode=request.getParameter("ExamCode").toString().trim();

	if(request.getParameter("Subject")==null)
		mSubjectCode="";
	else
		mSubjectCode=request.getParameter("Subject").toString().trim();
	
	if(request.getParameter("SEMESTER")==null)
		mSem1="";
	else
		mSem1=request.getParameter("SEMESTER").toString().trim();

	qrysub="select subject,SUBJECTCODE from subjectmaster where subjectID='"+mSubjectCode+"' and nvl(deactive,'N')='N' ";
	//out.print(qrysub);
	rssub=db.getRowset(qrysub);
	if(rssub.next())
		{
	 		mNam=rssub.getString("subject");
			mSc=rssub.getString("SUBJECTCODE");

		}
		else
		{
			mNam="";
			mSc="";
		}

	qry="Select Distinct NVL(INSTITUTECODE,' ')IC from v#SRSEVENTS WHERE nvl(deactive,'N')='N' ";
	rs=db.getRowset(qry);
	while(rs.next())
	{
		mInst=rs.getString("IC");
	}

%>
<TABLE ALIGN=CENTER rules=COLUMNS rules=groups  cELLSPACING=0 BORDER=0>
<tr><td colspan=3><b>CoOrdinator Name/Member name : </b><font color=dark brownt><b><%=mMemberName%>&nbsp;(<%=mDMemberCode%>)</font></b></td></tr>
	<TR>
		<TD><b>Exam Code :</b><%=mExamCode%></TD>
		<TD nowrap ><b>&nbsp; Subject Code :</b><%=mNam%>&nbsp(<%=mSc%>)</TD>
	</TR>
	</TABLE>
<br>
<TABLE ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=0>
<ol>
<%
qry="select question ,questionid from EXAMGRADEQUESTION where institutecode='"+mInst+"' and examcode='"+mExamCode+"' and nvl(DEACTIVE,'N')='N' order by questionid ";
rs=db.getRowset(qry);
while(rs.next())
{
%>

<TR>
<td><li><%=rs.getString("question")%>?&nbsp;Yes</br></td>
</tr>
<%
} // closing of while
%>
</table>
	<br>
<table align=center>
<tr>
<td align=center><b>General Information</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Total<br>Students<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Rejected<br>Students<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Students<br>Considered<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Mean<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Standard<br>Deviation<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial<br>AVGP<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>AVGP<B><font></TD>
	</TR>
<%

int mTotalStudents=0,mStudentsRejected=0,mStudentsConsidered=0;
double mMean=0,mInitialAVGP=0,mFinalAVGP=0,mDeviation=0;

if(request.getParameter("TOTALSTUDENTS")==null)
		mTotalStudents=0;
	else
		mTotalStudents=Integer.parseInt(request.getParameter("TOTALSTUDENTS").toString().trim());

	if(request.getParameter("STUDENTREJECTED")==null)
		mStudentsRejected=0;
	else
		mStudentsRejected=Integer.parseInt(request.getParameter("STUDENTREJECTED").toString().trim());

	if(request.getParameter("STUDENTCONSIDERED")==null)
		mStudentsConsidered=0;
	else
		mStudentsConsidered=Integer.parseInt(request.getParameter("STUDENTCONSIDERED").toString().trim());

	if(request.getParameter("MEAN")==null)
		mMean=0;
	else
		mMean=Double.parseDouble(request.getParameter("MEAN").toString().trim());

	if(request.getParameter("INITIALAVGP")==null)
		mInitialAVGP=0;
	else
		mInitialAVGP=gb.getRound(Double.parseDouble(request.getParameter("INITIALAVGP").toString().trim()),2);
	if(request.getParameter("FINALAVGP")==null)
		mFinalAVGP=0;
	else
		mFinalAVGP=gb.getRound(Double.parseDouble(request.getParameter("FINALAVGP").toString().trim()),2);

	if(request.getParameter("DEVIATION")==null)
		mDeviation=0;
	else
		mDeviation=gb.getRound(Double.parseDouble(request.getParameter("DEVIATION").toString().trim()),2);
%>


		<TD ALIGN=CENTER><%=mTotalStudents%></TD>
		<TD ALIGN=CENTER><%=mStudentsRejected%></TD>
		<TD ALIGN=CENTER><%=mStudentsConsidered%></TD>
		<TD ALIGN=CENTER><%=mMean%></TD>
		<TD ALIGN=CENTER><%=mDeviation%></TD>
		<TD ALIGN=CENTER><%=mInitialAVGP%></TD>
		<TD ALIGN=CENTER><%=mFinalAVGP%></TD>
</tr>
</table>
<br>
<table align=center>
<tr>
<td align=center><b>Grades</B>
</td>
</tr>
</table>
<TABLE bgcolor=#fce9c5 class="sort-table"  width=76% ALIGN=CENTER rules=COLUMNS CELLSPACING=0 BORDER=1> 
<thead>
<tr bgcolor="#ff8c00">
		<TD ALIGN=CENTER><font color=white><b>Grade<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Recommended<br>From<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Recommended<br>To<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Standered<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Initial<br>Count<B><font></TD>
		<TD ALIGN=CENTER><font color=white><b>Count<B><font></TD>
</tr>
</thead>
<%
int len11=0,pos11=0,pos111=0,pos211=0,pos311=0,pos411=0;
String mGrade="",mRecommendedFrom="",mRecommendedTo="",GradeMasterLowerLimit="";
String InitialCount="",GradeMasterTotalCount="";
int icc=0;
int icf=0;
LinkedHashSet mGradeChecked1=(LinkedHashSet)session.getAttribute("GRADEMASTERSET");	
	if(mGradeChecked1==null)
	{
		mGradeChecked1=new LinkedHashSet();
	}
	Iterator it1=mGradeChecked1.iterator();
   while(it1.hasNext())	
   {
		String element = (String)it1.next();
		len11=element.length();
		pos11=element.indexOf("///");
		pos111=element.indexOf("***");
		pos211=element.indexOf("$$$");
		pos311=element.indexOf("%%%");
		pos411=element.indexOf("###");

		mGrade=element.substring(0,pos11);	
		mRecommendedFrom=element.substring(pos11+3,pos111);
		mRecommendedTo=element.substring(pos111+3,pos211);
		GradeMasterLowerLimit=element.substring(pos211+3,pos311);
		InitialCount=element.substring(pos311+3,pos411);
		GradeMasterTotalCount=element.substring(pos411+3,len11);
		icc=(int)Double.parseDouble(InitialCount);
		icf=(int)Double.parseDouble(GradeMasterTotalCount);
%>
<tr>
<TD ALIGN=right><%=mGrade%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=mRecommendedFrom%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=mRecommendedTo%>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=GradeMasterLowerLimit%>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<!-- <TD ALIGN=right><%=InitialCount%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=GradeMasterTotalCount%>&nbsp; &nbsp; &nbsp; &nbsp;</TD> -->
 <TD ALIGN=right><%=icc%>&nbsp; &nbsp; &nbsp; &nbsp;</TD>
<TD ALIGN=right><%=icf%>&nbsp; &nbsp; &nbsp; &nbsp;</TD> 
</tr>
<%
} // closing of while
%>
</table>
<br>
<table align=center>
<tr>
<td align=center><b>Final Examination of students Semester-<%=mSem1%></B>
</td>
</tr>
</table>

 <TABLE bgcolor=#fce9c5 class="sort-table" id="table-1" ALIGN=CENTER rules=COLUMNS CELLSPACING=0 width=76% BORDER=1> 
<!-- <table bgcolor=#fce9c5 class="sort-table" id="table-1" bottommargin=0 rules=columns topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center width="100%"> -->
<thead>
<tr bgcolor="#ff8c00">
	<td><b><font color=white>SNo.</font></b></td>
	<td><b><font color=white >Roll No.</font></b></td>
	<td><b><font color=white >Masscuts</font></b></td>
	<td><b><font color=white >Student Name</font></b></td>
	<td><b><font color=white >Final<br>Marks</font></b></td>
	<td><b><font color=white >Final<br>Grade</font></b></td>
</tr>
</thead>
<tbody>
<%
	
	mGradeChecked=(Set)session.getAttribute("GRADECHECKED");
	if(mGradeChecked==null)
	{
		mGradeChecked=new HashSet();
	}
    mGradeUnChecked=(Set)session.getAttribute("GRADEUNCHECKED");
    Iterator itun=mGradeUnChecked.iterator();
   	while(itun.hasNext())	
   {
		ctr++;
		String elementtopicInit = (String)itun.next();
	  	lenInit=elementtopicInit.length();
		posInit=elementtopicInit.indexOf("*****");
		pos1Init=elementtopicInit.indexOf("$$$$$");
		pos2Init=elementtopicInit.indexOf("?????");
		pos3Init=elementtopicInit.indexOf("#####");   
		pos4Init=elementtopicInit.indexOf("/////");
		pos5Init=elementtopicInit.indexOf("%%%%%");
		mStudidInit=elementtopicInit.substring(0,posInit);	
		mMarksInit=elementtopicInit.substring(posInit+5,pos1Init);
		mGradInit=elementtopicInit.substring(pos1Init+5,pos2Init);
		mWeightageInit=elementtopicInit.substring(pos2Init+5,pos3Init);
		mInitMarks=elementtopicInit.substring(pos3Init+5,pos4Init);
		mMassCut=elementtopicInit.substring(pos4Init+5,pos5Init);
		mFST=elementtopicInit.substring(pos5Init+5,lenInit);	

	qry="select enrollmentno,studentname from studentmaster where studentid='"+mStudidInit+"' and nvl(DEACTIVE,'N')='N' ";
	rs=db.getRowset(qry);
	if(rs.next())
	{
	mRoll=rs.getString("enrollmentno");
	mName=rs.getString("studentname");
}
else
{
mRoll="";
mName="";			
  }				
		%>

		<tr bgcolor=white>
		<td><%=ctr%></td>
		<td><%=mRoll%></td>
	<!--	<td><%=mWeightageInit%></td>
		<td><%=mInitMarks%></td>
		<td><%=mGradInit%></td> -->
		<td><%=mMassCut%></td>
<%
	if(mGradInit.equals("F"))
	{
	%>
	<td><%=GlobalFunctions.toTtitleCase(mName)%>*</td>
	<%
	}
	else
	{
	%>
	<td><%=GlobalFunctions.toTtitleCase(mName)%></td>
	<%
	}
	%>
	<td><%=mMarksInit%></td>
		<%
			
		if(mCheckRadio.equals("Y"))
		{

		Iterator it=mGradeChecked.iterator();
 		while(it.hasNext())	
		   {
			
				String elementtopic = (String)it.next();
			  	len=elementtopic.length();
				pos=elementtopic.indexOf("*****");
				pos1=elementtopic.indexOf("$$$$$");
				pos2=elementtopic.indexOf("?????");
				pos20=elementtopic.indexOf("#####");
				pos201=elementtopic.indexOf("/////");
				pos2011=elementtopic.indexOf("%%%%%");

				mStudid=elementtopic.substring(0,pos);	
				mMarks=elementtopic.substring(pos+5,pos1);
				mGrad=elementtopic.substring(pos1+5,pos2);
			      mWeightage=elementtopic.substring(pos2+5,pos20);
				mWe=elementtopic.substring(pos20+5,pos201);
				mMass=elementtopic.substring(pos201+5,pos2011);	
				mfst=elementtopic.substring(pos2011+5,len);	

				if(mStudidInit.equals(mStudid))
			   {
			%>
				<td><%=mGrad%></td></tr>
			<%
				break;
			   }
		  } // closing of while
		} // closing of if mCheckRadio=Y
	else
	   {
		%>
			<td>&nbsp;</td></tr>
		<%
	   }
    } // closing of while
	qry="select to_char(sysdate,'dd-mm-yyyy hh:mi:ss PM') from dual";
	rs=db.getRowset(qry);
	rs.next();
	String mDat=rs.getString(1);
%>
	</tbody>
	</table>	
<script type="text/javascript">
var st1 = new SortableTable(document.getElementById("table-1"),["Number","Number","Number","Number","CaseInsensitiveString","CaseInsensitiveString","CaseInsensitiveString","Number"]);
</script>
<br>
<table width=76% align=center>
<tr>
<td align=left>
Name:-<br>
Signature of Instructor:<br>
Submitted on..<%=mDat%>
</td>
<td align=right>*Detained Candidate 
</td>
</tr>

</tr>
</table>
<table width=80% align=center>
<tr>
<td nowrap align=center title="Click to Print" valign=top>
<table width=10% align=center border=2 bordercolor=magroon><tr><td align=center nowrap><font color=blue>
<b>Click  <a style="CURSOR:hand" onClick="window.print();"><img src="../../Images/printer.gif"></a> To Print</b></font></td></tr></table></td>
</tr>
</table>
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

} // closing of if(!mMemberID.equals(""))
 //-----------------------------
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
	// out.print(e);
}
%>
