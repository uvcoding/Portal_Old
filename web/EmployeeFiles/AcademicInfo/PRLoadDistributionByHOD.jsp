<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
String mMemberID="",mDMemberID="";
String mMemberName="",departmentname="";
String mMemberType="",mDMemberType="",mSst="",mPrcode="",mradio1="",mradio11="";
String mHead="", TRCOLOR="";
String mDMemberCode="",mMemberCode="",mexam="",mExam="",QryExam="";
String mInst="" ;
String qry="",ELE1="",mSubjID="";
int ctr=0;
String mType="",mL="",mT="",mP="",mST="",mSemType="",SEM="",mBasket="",BASKET="";
String mProjSubj="", SUBJ="",mSubj="",TYPE="",DEPT="",mDept="",QryDept="",LTP="",SUBNAME="",mSname="",EXAM="",QrySemType="",mComp="";
String curacadyr="";
if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}
/*if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}*/

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
if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}
if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="UNIV";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [HOD Advance Load Distribution] </TITLE>
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
function activeFreeze()
{
alert('fdfdf');
alert(document.frm1.radio1.value);
	if(document.frm1.radio1.value=='N')
		document.frm1.submit.disabled=true;
	else
		document.frm1.submit.disabled=false;
}
function showAlert()
{
	//alert(document.frm.NotAssign.value+"XXX");
	var NotAssign=document.frm.NotAssign.value;
/*
	if(NotAssign=='Y')
	{
		alert('Please Assign Load distribution for all  REG and RWJ batch Subjects!');		
		return false;
	}
	else
	{
	alert('Once the Load Distribution is freezed, It can not be changed further!');

	}
	*/
	//	return false;
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
  qry="Select WEBKIOSK.ShowLink('56','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	    RsChk= db.getRowset(qry);
	    if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	  	{
		
		/*qry=" Select PREVENTCODE PREVENTCODE  from PREVENTS A WHERE INSTITUTECODE='"+ mInst+"' AND (PREVENTCODE) IN (SELECT  PREVENTCODE from PREVENTMASTER WHERE INSTITUTECODE='" + mInst+"' ";
		qry=qry+" and NVL(FREEELECTIVERUNFINALIZED,'N')='Y'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y' and PRREQUIREDFOR='E'";
		qry=qry+" AND NVL(DEACTIVE,'N')='N') and  nvl(LOADDISTRIBUTIONSTATUS,'N') not in ('F','A') and nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' and MEMBERTYPE='E' ";
		and MEMBERID IN (sELECT EMPLOYEEID)'"+mChkMemID+"' ";
		qry=qry+"  and nvl(DEACTIVE,'N')='N'";*/
		
		//out.print(qry);	
		
		//rs=db.getRowset(qry);
		if(1==1)
		//if(rs.next())
		{		
			//mPrcode=rs.getString("PREVENTCODE");
  //----------------------
%>
<form name="frm"  method="get" >
<input id="x" name="x" type=hidden>
<table id=id1 ALIGN=CENTER bottommargin=0  topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: verdana"><B>Advance Teaching Load Distribution by HOD</B></TD>
</font></td></tr>
</TABLE>
<table id=idd2 cellpadding=1 cellspacing=0 align=center rules=rows  border=3>
<tr>
<!--*********Exam**********-->
<td><FONT color=black><FONT face=Arial size=2 color=black><STRONG><B>Exam Code </B></STRONG></FONT></td>
<td>
<%
try
{
	//qry=" SELECT distinct EXAMCODE Exam from PREVENTMASTER WHERE INSTITUTECODE='"+ mInst+"' and FREEELECTIVERUNFINALIZED='Y'  and nvl(PRCOMPLETED,'N')='N' and nvl(PRBROADCAST,'N')='Y'";
	//qry=qry+" AND NVL(DEACTIVE,'N')='N'";									

	qry="SELECT PREREGEXAMID Exam from COMPANYINSTITUTETAGGING WHERE INSTITUTECODE='"+ mInst+"' and COMPANYCODE='"+mLoginComp+"' AND NVL(DEACTIVE,'N')='N'";
	//out.print(qry);
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
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
<FONT face=Arial size=2 color=black><b>Semester Type</b></font>
&nbsp; &nbsp;
<select name=SemType id=SemType>
<%
if(request.getParameter("SemType")==null)
{
	if(QrySemType.equals(""))
		QrySemType=mSemType;
	%>
	<!--<option selected value='ALL'>ALL</option>-->
	<option value='REG'>REG</option>
	<!--<option value='RWJ'>RWJ</option>-->
	<%
}
else
{
	mSemType=request.getParameter("SemType").toString().trim();
	QrySemType=mSemType;
	if(mSemType.equals("ALL"))
	{
		%>
		<!--<option selected value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
		<!--<option value='RWJ'>RWJ</option>-->
 		<%
	}
	else if(mSemType.equals("REG"))
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option selected value='REG'>REG</option>
	   	<!--<option value='RWJ'>RWJ</option>-->
 		<%
	}	
	else 
	{
		%>
		<!--<option value='ALL'>ALL</option>-->
		<option value='REG'>REG</option>
	  	<!--<option selected value='RWJ'>RWJ</option>-->
		<%
	}
}
%>
</select>
</td>
<tr>
<td><FONT face=Arial size=2 color=black><b>Department</b></font></td>
<td colspan=2>
<%
qry="select a.DEPARTMENTCODE,a.department from departmentmaster a ,USERWISELOADPERMITION b where a.departmentcode=b.DEPARTMENTCODE and nvl(A.deactive,'N')='N' and nvl(b.deactive,'N')='N' and b.EMPLOYEEID='"+mChkMemID+"'  and examcode='"+mExam+"' and COMPANYCODE='"+mComp+"' and nvl(freezed,'N')='N'";
//out.println(qry);
rs=db.getRowset(qry);	
if (request.getParameter("x")==null) 
{
	%>
	<select name="department" tabindex="0" id="department" style="WIDTH: 350px">	
	<%   
	while(rs.next())
	{
		mDept=rs.getString("DEPARTMENTCODE");
		departmentname=rs.getString("department");
		%>
		<OPTION Value =<%=mDept%>><%=departmentname%> (<%=mDept%>)</option>
		<%
	}
	%>
	</select>
	<%
}
else
{
	%>
	<select name="department" tabindex="0" id="department" style="WIDTH: 350px">	
	<%
	while(rs.next())
	{
		mDept=rs.getString("DEPARTMENTCODE");
		departmentname=rs.getString("department");
		if(mDept.equals(request.getParameter("department").toString().trim()))
		{
			%>
			<OPTION Selected Value =<%=mDept%>><%=departmentname%> (<%=mDept%>)</option>
			<%
		}
		else
		{
			%>
			<OPTION Value =<%=mDept%>><%=departmentname%> (<%=mDept%>)</option>
			<%
		}
	}
	%>
	</select>
	<%
}
%>
<input type=submit id=btn name=btn value='Show/Refresh'>
</td>
</tr>	
</table>
<TABLE align=center rules=Rows class="sort-table" id="table-1" cellSpacing=1 cellPadding=1 width="100%" border=1 rules=groups>
<thead>
<tr bgcolor="#ff8c00">
<td nowrap rowspan=2 align=middle><b><font face=arial size=2 color=white>Sr.<br>No.</font><b></td>
<td nowrap rowspan=2 align=middle><b><font face=arial size=2 color=white>Subject <br>Type </font><b></td>
<td nowrap rowspan=2 align=middle><b><font face=arial size=2 color=white>Subject</font><b></td>
<td nowrap colspan=4 align=center nowrap><b><font face=arial size=2 color=white>Load Distribution For <img src='../../Images/arrow.gif'></font</b></td>
</tr>
<tr bgcolor="#ff8c00">
<td nowrap align=middle><b><font face=arial size=2 color=white>Lecture</font></b></td>
<td nowrap align=middle><b><font face=arial size=2 color=white>Tutorial</font></b></td>
<td nowrap align=middle><b><font face=arial size=2 color=white>Practical</font></b></td>
<td nowrap align=middle><b><font face=arial size=2 color=white>Project</font></b></td>
</tr>	
</THEAD>
<TBODY>
<%
if(request.getParameter("Exam")==null)
	QryExam=mexam;
else
	QryExam=request.getParameter("Exam").toString().trim();

if(request.getParameter("SemType")==null)
	QrySemType="REG";
else
	QrySemType=request.getParameter("SemType").toString().trim();

if(request.getParameter("department")==null)
	QryDept=mDept;
else
	QryDept=request.getParameter("department").toString().trim();

//out.print("Exam - "+QryExam+" Department - "+QryDept+" SemType - "+QrySemType);

String QrySemType1="";
int mflag=0;

if (QryExam!=null && !QryDept.equals("") && !QrySemType.equals(""))
{
	try
	{
		qry="SELECT PREVENTCODE FROM PREVENTMASTER A WHERE INSTITUTECODE='"+ mInst+"' AND EXAMCODE='"+QryExam+"' AND NVL(DEACTIVE,'N')='N' AND NVL(PRCOMPLETED,'N')='N' AND NVL(PRREQUIREDFOR,'E')='E'";
		//out.println(qry);
		ResultSet rdddd= db.getRowset(qry);
		if(rdddd.next())
		{
			mPrcode=rdddd.getString("PREVENTCODE");
			//out.println(mPrcode);
		}
		if(request.getParameter("department")!=null)		
			mDept=request.getParameter("department");
		qry="SELECT academicyear FROM academicyearmaster WHERE INSTITUTECODE='"+ mInst+"'  AND NVL(DEACTIVE,'N')='N' AND NVL(currentyear,'N')='Y' and ACADEMICYEAR IN (SELECT ACADEMICYEAR FROM PROGRAMSUBSECTIONTAGGING WHERE INSTITUTECODE='"+mInst+"' and EXAMCODE='"+QryExam+"' and nvl(semester,0)=1)";
		//out.println(qry);
		rdddd= db.getRowset(qry);
		if(rdddd.next())
		{		
			curacadyr=rdddd.getString("academicyear");
		}
		//nvl(L,0)L,nvl(T,0)T,nvl(P,0)P
		qry="select distinct 'C' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from programscheme A ,Subjectmaster B ";
		qry=qry+" where A.institutecode='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+QryExam+"' and c.institutecode='"+mInst+"' ";
		qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
		qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
		qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
		qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
		qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH And c.subjecttype='C' AND C.departmentcode ='"+mDept+"' )  AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+"and (A.L>0 or A.T>0 or A.P>0 )";
		qry=qry+" and ( a.academicyear='"+curacadyr+"' or (Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')))";
		qry=qry+" union ";
		qry=qry+"select distinct 'C' CEF, A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and   a.examcode='"+QryExam+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) aND A.Basket='A'";
		qry=qry+" and Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')";
		qry=qry+" union ";
		qry=qry+" select distinct 'E' CEF,A.L L,A.T T,A.P P, A.subjectid subjectid, B.subjectcode subjectcode,A.ELECTIVECODE ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from PR#ELECTIVESUBJECTS A ,Subjectmaster B  ";
		qry=qry+" where A.institutecode='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and A.examcode='"+QryExam+"' ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+QryExam+"' and c.institutecode='"+mInst+"' ";
		qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
		qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
		qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
		qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
		qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH AND   C.subjecttype='E' and C.departmentcode ='"+mDept+"' ) and A.SUBJECTRUNNING='Y' AND A.SUBJECTID=B.SUBJECTID   ";
		qry=qry+" and (A.L>0 or A.T>0 or A.P>0 ) ";
		qry=qry+" and ( a.academicyear='"+curacadyr+"' or (Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')))";
		qry=qry+" union ";
		qry=qry+"select distinct 'E' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from OFFERSUBJECTTAGGING A ,Subjectmaster B where A.institutecode='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE and  a.examcode='"+QryExam+"'  AND a.departmentcode ='"+mDept+"'  AND A.SUBJECTID=B.SUBJECTID and (A.L>0 or A.T>0 or A.P>0 ) and  A.Basket='B'";
		qry=qry+" and Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE='REG')";
		
		//---- back log subjects
	/*		qry=qry+" union ";
		qry=qry+"select distinct 'RWJ' CEF,A.L L,A.T T,A.P P,A.subjectid subjectid,B.subjectcode subjectcode,null ELECTIVECODE,A.Basket Basket,B.Subject||' ('||B.SubjectCode||') ' subj, NVL(B.PROJECTSUBJECT,'N')PROJECTSUBJECT from programscheme A ,Subjectmaster B ";
		qry=qry+" where A.institutecode='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE ";
		qry=qry+" and A.subjectid in (select C.subjectid from PR#DEPARTMENTSUBJECTTAGGING C ";
		qry=qry+" where  C.examcode='"+QryExam+"' and c.institutecode='"+mInst+"' ";
	//	qry=qry+" AND A.INSTITUTECODE = C.INSTITUTECODE ";
	//	qry=qry+" AND A.ACADEMICYEAR =C.ACADEMICYEAR ";
	//	qry=qry+" AND A.PROGRAMCODE  = C.PROGRAMCODE ";
	//	qry=qry+" AND A.TAGGINGFOR   = C.TAGGINGFOR ";
	//	qry=qry+" AND A.SECTIONBRANCH = C.SECTIONBRANCH ";
		qry=qry+" AND C.departmentcode ='"+mDept+"' )  AND A.SUBJECTID=B.SUBJECTID ";
		qry=qry+"and (A.L>0 or A.T>0 or A.P>0 )";
		qry=qry+" and ( a.academicyear='"+curacadyr+"' or (Exists (select 1 from pr#studentsubjectchoice a1 where a1.subjectid =a.subjectid and  institutecode = '"+mInst+"' and examcode = '"+QryExam+"' and SEMESTERTYPE IN ('RWJ','SAP')  and SUBJECTRUNNING='Y' )))";*/
		
		
		qry=qry+"order by CEF, subj ";
//out.print(qry);
		rs=db.getRowset(qry);
		out.print(rs.next());
		while(rs.next())
		{
			ctr++;
			if(ctr%2==0)
				TRCOLOR="White";
			else
				TRCOLOR="#F8F8F8";

			mSubjID=rs.getString("subjectid");
			mSubj=rs.getString("subjectcode");
			mSname=rs.getString("subj");
			mBasket=rs.getString("Basket");
			mProjSubj=rs.getString("PROJECTSUBJECT");
			mType=rs.getString("CEF").trim();

			qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
			qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
			qry=qry+" and subjecttype='"+mType+"' and LTP='L' ";
			rs1=db.getRowset(qry);
			if(rs1.next())
				mL=rs1.getString("cnt");
	
			qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
			qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
			qry=qry+" and subjecttype='"+mType+"' and LTP='T' ";
			rs2=db.getRowset(qry);
			if(rs2.next())
				mT=rs2.getString("cnt");

			qry="select count(distinct facultyid)cnt from PR#FACULTYSUBJECTCHOICES ";
			qry=qry+" where institutecode='"+mInst+"' and examcode='"+QryExam+"' and subjectid='"+mSubjID+"' ";
			qry=qry+" and subjecttype='"+mType+"' and LTP='P' ";
			rs3=db.getRowset(qry);
			if(rs3.next())
				mP=rs3.getString("cnt");

			if(mType.equals("C"))
			{
				mSst="Core";
				ELE1="CORE";
				QrySemType1="REG";
			}
			else if(mType.equals("E"))
			{
				mSst="Elective("+rs.getString("ELECTIVECODE")+")";
				ELE1=rs.getString("ELECTIVECODE");
								QrySemType1="REG";
			}
			else
			{
				mSst="RWJ-SAP";
				ELE1="BackLog - Subjects";	
								QrySemType1="RWJ','SAP";
								}
			%>
			<tr bgcolor=<%=TRCOLOR%>>
			<td align=right><%=ctr%>. &nbsp; </td>
			<td nowrap><%=mSst%></td>
			<td nowrap>&nbsp;<%=rs.getString("subj")%></td>
			<td width='10%' align=center>
			<%
			if(rs.getInt("L")>0)
			{
				qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='L'";
				//out.print(qry);
				rs4=db.getRowset(qry);
				if(rs4.next())
				{
					qry="SELECT NVL(STATUS,'D')STATUS FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='L'";
					//out.print(qry);
					rs5=db.getRowset(qry);
					if(rs5.next() && rs5.getString("STATUS").equals("D"))
					{
						mflag=1;
						
						if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=Darkbrown><b>Assign</b></font></a>
							<%
						}
						else
						{
						%>
						<a target=_Blank TITLE="Completely Assigned"  href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=L"><font size=2 color=Darkbrown><b>Assign</b></font></a>
						<%
						}
					}
					else if( rs5.getString("STATUS").equals("F") || rs5.getString("STATUS").equals("A")) 
					{
						
						
						if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=Green><b>Assign</b></font></a>
							<%
						}
						else
						{
						%>
						<a target=_Blank TITLE="Partially Assigned / Not Freezed" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=L"><font size=2 color=Green><b>Assign</b></font></a>
						<%
						}
					}
				}
				else
				{
					mflag=1;
				
						if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=blue><b>Assign</b></font></a>
							<%
						}
						else
						{
					%>
					<a target=_Blank TITLE="Completely Unassigned"  href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=L"><font size=2 color=blue><b>Assign</b></font></a>
					<%
						}
				}
			}
			else
			{
				%>
				-
				<%
			}
			%>
			</td>
			<td width='10%' align=center>
			<%
			if(rs.getInt("T")>0)
			{
				qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='T'";
				//out.print(qry);
				rs4=db.getRowset(qry);
				if(rs4.next())
				{
					qry="SELECT NVL(STATUS,'D')STATUS FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='T'";
					//out.print(qry);
					rs5=db.getRowset(qry);
					if(rs5.next() && rs5.getString("STATUS").equals("D"))
					{
				mflag=1;
								if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=darkbrown><b>Assign</b></font></a>
							<%
						}
						else
						{%>
						<a target=_Blank TITLE="Partially Assigned / Not Freezed     " href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=T"><font size=2 color=darkbrown><b>Assign</b></font></a>
						<%
						}
					}
			else if( rs5.getString("STATUS").equals("F") || rs5.getString("STATUS").equals("A")) 
					{
				
								if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=green><b>Assign</b></font></a>
							<%
						}
						else
						{%>
						<a target=_Blank TITLE="Completely Assigned" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=T"><font size=2 color=green><b>Assign</b></font></a>
						<%
						}
					}
				}
				else
				{
					mflag=1;
				

							if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=blue><b>Assign</b></font></a>
							<%
						}
						else
						{%>
					<a target=_Blank TITLE="Completely Unassigned" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=T"><font size=2 color=blue><b>Assign</b></font></a>
					<%
						}
				}
			}
			else
			{
				%>
				-
				<%
			}
			%>
			</td>
			<td width='10%' align=center>
			<%
			if(rs.getInt("P")>0)
			{
			   if(mProjSubj.equals("N"))
			   {
				qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='P'";
				//out.print(qry);
				rs4=db.getRowset(qry);
				if(rs4.next())
				{
					qry="SELECT NVL(STATUS,'D')STATUS FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE IN ('"+QrySemType1+"') AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='P'";
					//out.print(qry);
					rs5=db.getRowset(qry);
					if(rs5.next() && rs5.getString("STATUS").equals("D"))
					{
					mflag=1;
								if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=darkbrown><b>Assign</b></font></a>
							<%
						}
						else
						{%>
						<a target=_Blank TITLE="Partially Assigned / Not Freezed" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=darkbrown><b>Assign</b></font></a>
						<%
						}

					}
					else if( rs5.getString("STATUS").equals("F") || rs5.getString("STATUS").equals("A")) 
					{
						
						
						if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=green><b>Assign</b></font></a>
							<%
						}
						else
						{%>
						<a target=_Blank  TITLE="Completely Assigned"  href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=green><b>Assign</b></font></a>
						<%
						}
					}
				}
				else
				{
					mflag=1;	
						if(mType.equals("RWJ"))
						{
							%>
						<font size=2 color=blue><b>Assign</b></font></a>
							<%
						}
						else
						{%>
					<a target=_Blank TITLE="Completely Unassigned" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=blue><b>Assign</b></font></a>
					<%
						}
				}
			   }
			   else
			   {
				%>
				-
				<%
			   }
			}
			else
			{
				%>
				-
				<%
			}
			%>
			</td>
			<td width='10%' align=center>
			<%
			if(rs.getInt("P")>0)
			{
			   if(mProjSubj.equals("Y"))
			   {
				qry="SELECT 'Y' FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='P'";
				//out.print(qry);
				rs4=db.getRowset(qry);
				if(rs4.next())
				{
					qry="SELECT NVL(STATUS,'D')STATUS FROM PR#HODLOADDISTRIBUTION WHERE INSTITUTECODE='"+mInst+"' AND COMPANYCODE='"+mComp+"' AND EXAMCODE='"+QryExam+"' AND SEMESTERTYPE='"+QrySemType+"' AND BASKET='"+mBasket+"' AND SUBJECTID='"+mSubjID+"' AND NVL(DEPARTMENTRUNNIG,' ')='"+QryDept+"' AND LTP='P'";
					//out.print(qry);
					rs5=db.getRowset(qry);
					if(rs5.next() && rs5.getString("STATUS").equals("D"))
					{
						%>
						<a target=_Blank TITLE="Partially Assigned / Not Freezed     " href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=darkbrown><b>Assign</b></font></a>
						<%
					}
						else if( rs5.getString("STATUS").equals("F") || rs5.getString("STATUS").equals("A")) 
					{
						%>
						<a target=_Blank TITLE="Completely Assigned" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=green><b>Assign</b></font></a>
						<%
					}
				}
				else
				{
					%>
					<a target=_Blank TITLE="Completely Unassigned" href="PRLoadDistributionByHODAction.jsp?PROJSUBJ=<%=mProjSubj%>&amp;SUBJID=<%=mSubjID%>&amp;SUBJ=<%=mSubj%>&amp;ELECTIVECODE=<%=rs.getString("ELECTIVECODE")%>&amp;BASKET=<%=mBasket%>&amp;PRCODE=<%=mPrcode%>&amp;radio1=<%=mradio1%>&amp;SEM=<%=QrySemType%>&amp;ELE=<%=ELE1%>&amp;SUBNAME=<%=mSname%>&amp;EXAM=<%=QryExam%>&amp;TYPE=<%=mType%>&amp;DEPT=<%=QryDept%>&amp;LTP=P"><font size=2 color=blue><b>Assign</b></font></a>
					<%
				}
			   }
			   else
			   {
				%>
				-
				<%
			   }
			}
			else
			{
				%>
				-
				<%
			}
			%>
			</td>
			</tr>
			<%
		} //closing of while
	}
	catch(Exception e)
	{
		//out.print("Errors"+e);
	}
	%>
	</TBODY>
	</table>
	
	<%
	//	out.print(mflag+"mflag");
		
		if(mflag==1)
	{
			%>
	<INPUT TYPE="hidden" NAME="NotAssign" id="NotAssign" value="Y">
		<%
	}else
	{
		%>
	<INPUT TYPE="hidden" NAME="NotAssign" id="NotAssign" value="N">
		<%
	}
				%>

	
	
	<table align=center>
		<tr>
			<td align=left bgcolor=blue width=5%>&nbsp;&nbsp;&nbsp</td><td><font size=2 color="blue" face=arial><B>Completely Unassigned</B></Font> &nbsp; &nbsp; </td>
      		<td align=center valign=top bgcolor=darkbrown width=5%>&nbsp;&nbsp;&nbsp</td><td><font size=2 color="darkbrown" face=arial><B>Partially Assigned / Not Freezed &nbsp; &nbsp; </B></font></td>
			<td align=right bgcolor=Green width=5%>&nbsp;&nbsp;&nbsp</td><td><font size=2 color="green" face=arial><B>Completely Assigned</B></Font></td>
      	</tr>
	</table>
	</form>
	<form name="frm1" method="post" action="PRLoadDistributionHODApproval.jsp">
	<input id="x1" name="x1" type=hidden>
	<table cellspacing=0 align=center border=2 rules=groups width=100%>
	<tr bgcolor="#ff8c00">
	<TR><TD ALIGN=CENTER><font size=2 face=verdana color=black><b><sup>#</sup>Finalize and Freeze :- </b></font>
	<input checked type=radio id=radio1 name=radio1 value='N'><Font color=red><b>No</b></Font>
	<input type=radio id=radio1 name=radio1 value='Y'><Font color=green><b>Yes</b></Font>
	<INPUT Type="submit" Value="Freeze" onclick="return showAlert();"></TD></TR>
	</table>
	<input type=hidden name=PRCODE ID=PRCODE value='<%=mPrcode%>'>
	<input type=hidden name=EXAMCODE ID=EXAMCODE value='<%=QryExam%>'>
	<input type=hidden name=SemType ID=SemType value='<%=QrySemType%>'>
	<input type=hidden name=department ID=department value='<%=QryDept%>'>
	<input type=hidden name=EXAMCODE ID=EXAMCODE value='<%=QryExam%>'>
	</form>
	<font color=RED># If any Subject is <u>Complete Unassigned</u>, the Load Distribution will not be proceed to Freeze.</font> 
	<BR>
	<font color=RED># Once you finalize and freeze, Load distribution can not be modifed further.</font> 
	<%

	} //closing of if(QryExam)

	}
	else
	{
		%>
		<br>
		<font color=red>
		<h3><br><img src='../../Images/Error1.jpg'> Load Distribution has already been finalized and sent to DOAA for Approval  </h3><br>
		</font>	<br>	<br>	<br>	<br>  
		<%
	}
//-----------------------------
//---Enable Security Page Level  
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
