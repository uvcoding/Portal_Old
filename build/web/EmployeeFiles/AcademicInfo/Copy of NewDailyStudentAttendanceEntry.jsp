<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%


DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rsAtt=null, rsRowNum=null, RsChk1=null, rsdt=null;
GlobalFunctions gb=new GlobalFunctions();
String qry="";
String qry2="",mREGCONFIRMATIONDATE="";
String qry1="",mLTP="";
long mSNo=0,dt=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="",mtime1="",mtime2="";
String mMemberName="";
String mInstitute="";
String mExam="",mSubject="",mexam="",mSubj="",mGroup="",TRCOLOR="#F8F8F8",mcolor="",mCode="",mES="",mSubj1="";
String mSection="",mSubsection="",mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="";
String mSExam="";
String mSES="";
String qryexam="",qrysubj="",qrysec="";
String mPrn="N",qsysdate="";
String mDate="",mType="",mltp1="";
String mRollno="",mName="",mradio1="";
String mDTfrom="";
String mDTupto="";
int Ctr=0, mDiffInDate=0, mDataComboSubSec=0;
int LFST=0, TFST=0, PFST=0, mRowNum=4,Flag=0,flag1=0;
long QryTotCls=0, QryTotPrs=0, QryPercAtt=0;
String mtimepicker1="";
String mtimepicker2="";
String mInst="", mComp="", mRightsID="",mLoginComp="";
int check=0;
	
String  DataSublist[]=new String[100];
String  Sublist[]=new String[100];
String mAcademicYear="";
String mAcad="",mACAD1="";



if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

mInstitute=mInst;

if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}



if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
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
	mHead=" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Subjectwise Students Class Attendance ] </TITLE>

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
<SCRIPT TYPE="text/javascript">


function Classtotime(Ctime)
{
//alert("sdsd"+document.frm2.LTP.value);
//Classtotime=document.frm2.LTP.value;

//alert(Ctime.indexOf(":"));

//alert(Ctime.substring(0,Ctime.indexOf(":"))+"Ctime");	
//int  Ct=parseInt(Ctime);
var Ct=Ctime.substring(0,Ctime.indexOf(":"));

var LTP=document.frm2.LTP.value;
var am,cc; 
	
if(LTP=='L')

	{
if(Ct==12)
	{
	Ct=0;
	 am="pm";

	 
 cc= parseInt(Ct)+parseInt(1);	

 totime=cc+Ctime.substring(Ctime.indexOf(":"),Ctime.indexOf(" "))+" "+am;

	}
	else
	{
		

 cc= parseInt(Ct)+parseInt(1);	

 totime=cc+Ctime.substring(Ctime.indexOf(":"));
	 
 }

	


//var ccc= cc+Ctime.substring(1);
//alert(cc+"xxxx"+totime);	
//document.frm2.timepicker2.value=;

if(totime!='NaN')
document.frm2.timepicker2.value=totime;
	}
}



function Check()
{
//alert('fdfds'+document.frm.SubSection.value);
	
	if(document.frm.SubSection.value==null || document.frm.SubSection.value=="")
	{
		alert("Please Select Sub Section !");
		
		return false;
	}
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
else if ((("0123456789").indexOf(keychar) > -1))
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

<script language="JavaScript" type ="text/javascript">
   function rad_check()
   { 
	
	var p=0;
	var a=0;

	for (var i = 0; i < document.frm1.elements.length; i++) 
	{
        var e=document.frm1.elements[i]; 
        if ((e.name != 'allbox') && (e.type == 'radio') && (e.value=='P') && (e.checked==true)  ) 
	  { 
		p++;	
        }
       else if((e.name != 'allbox1') && (e.type == 'radio') && (e.value=='A') && (e.checked==true)) 
        {
 		a++;
	  }	
      }
   if(p>0 && a>0)	
   {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=false;
   }
   else if(p>0 && a<=0)
   {
	document.frm1.allbox.checked=true;
	document.frm1.allbox1.checked=false;
   }
   else if (a>0 && p<=0)
   {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=true;
   }				
   else if(a<=0 && p<=0)
  {
	document.frm1.allbox.checked=false;
	document.frm1.allbox1.checked=false;
   }		
 }
</script>
<script type="text/javascript" src="js/TimePicker.js"></script>
<SCRIPT LANGUAGE="JavaScript"> 
 function un_check()
{
var mFlag=0;
 for (var i = 0; i < document.frm1.elements.length; i++) 
{
 var e = document.frm1.elements[i]; 
if ((e.name != 'allbox') && (e.type == 'radio') &&(e.value=='P')) 
{ 
e.checked = document.frm1.allbox.checked;
if (mFlag==0 && document.frm1.allbox.checked==true)
	{ 
	document.frm1.allbox1.checked=false;
	mFlag=1;
	}
 } } }
 </SCRIPT>

<SCRIPT LANGUAGE="JavaScript"> 


function un_check1()
{
	var mFlag=0;
	 for (var i = 0; i < document.frm1.elements.length; i++) 
     {
	 var e = document.frm1.elements[i]; 
	if ((e.name != 'allbox1') && (e.type == 'radio') &&(e.value=='A')) 
	{ 
	e.checked = document.frm1.allbox1.checked;
 	}

	if (mFlag==0 && document.frm1.allbox1.checked==true)
	{ 
	document.frm1.allbox.checked=false;
	mFlag=1;
	}

    }
}
 </SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
function ChangeOptions(Exam,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section)
  {
    removeAllOptions(Subject);
	var subj='?';
	var mflag=0;
	var ssec='?';
	for(i=0;i<DataCombo.options.length;i++)
       {	
		var v1;
		var pos;
		var exam;
		var sc;
		var len;
		var otext;
		var v1=DataCombo.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		exam=v1.substring(0,pos);
		sc=v1.substring(pos+3,len);
		if (exam==Exam)
		 { 	if(mflag==0) 
			{
			subj=sc;
			mflag=1;
			}

			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=sc;
			
			Subject.options.add(optn);
		}
	}



	removeAllOptions(AcademicYear);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			AcademicYear.options.add(optns);
			ssec='ALL';

	for(i=0;i<DataComboAcad.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var acad;
		var otexts;
		var v1s=DataComboAcad.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			
			var optns = document.createElement("OPTION");
			optns.text=DataComboAcad.options(i).text;
			optns.value=acad;
			AcademicYear.options.add(optns);
		}
	}		


	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			Section.options.add(optns);
			ssec='ALL';

				//alert("ddddd"+DataComboSec.options.length);

	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var exams;
		var scs;
		var lens;
		var scse;
		var acad;
		var otexts;
		var v1s=DataComboSec.options(i).value;
			


		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,lens);

			
		if (exams==Exam && subj==scs)
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	
		
		
}
//********Click event on subject**********
function ChangeSubject(Exam,subj,DataComboAcad,AcademicYear,DataComboSec,Section)
  {
    

	removeAllOptions(AcademicYear);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			AcademicYear.options.add(optns);
			ssec='ALL';

	for(i=0;i<DataComboAcad.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var acad;
		var otexts;
		var v1s=DataComboAcad.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			
			var optns = document.createElement("OPTION");
			optns.text=DataComboAcad.options(i).text;
			optns.value=acad;
			AcademicYear.options.add(optns);
		}
	}		


	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			Section.options.add(optns);
			ssec='ALL';

				//alert("ddddd"+DataComboSec.options.length);

	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var pos3;
		var exams;
		var scs;
		var lens;
		var scse;
		var acad;
		var otexts;
		var v1s=DataComboSec.options(i).value;
			


		lens= v1s.length ;	
		
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('&&&');
				pos3=v1s.indexOf('///');
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		acad=v1s.substring(pos2+3,pos3);
		scse=v1s.substring(pos3+3,lens);

			
		if (exams==Exam && subj==scs)
		 { 		
			
		

			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	






	/*var mflag=0;
	var ssec='?';
	
	removeAllOptions(Section);
	 mflag=0;
			var optns = document.createElement("OPTION");
			optns.text='ALL';
			optns.value='ALL';
			Section.options.add(optns);
			ssec='ALL';

	for(i=0;i<DataComboSec.options.length;i++)
       {	
		var v1s;
		var pos1;
		var pos2;
		var exams;
		var scs;
		var lens;
		var scse;
		var otexts;
		var v1s=DataComboSec.options(i).value;
		lens= v1s.length ;	
		pos1=v1s.indexOf('***');
		pos2=v1s.indexOf('///')
		exams=v1s.substring(0,pos1);
		scs=v1s.substring(pos1+3,pos2);
		scse=v1s.substring(pos2+3,lens);
		if (exams==Exam && subj==scs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataComboSec.options(i).text;
			optns.value=scse;
			Section.options.add(optns);
		}
	}	
		
	*/
}

   
function removeAllOptions(selectbox)
{
var i;
for(i=selectbox.options.length-1;i>=0;i--)
{
selectbox.remove(i);
}
}


function AlertMe()
{
	document.dd.twait.value='';
}
</SCRIPT>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body  onload="AlertMe()" aLink=#ff00ff  bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
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
	qry="Select WEBKIOSK.ShowLink('82','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
 	RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
		
		qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";

		rs=db.getRowset(qry);

		if(rs.next())
			qsysdate=rs.getString(1);
		else
			qsysdate="";	

	if (request.getParameter("x")!=null)
	{
		mDate=request.getParameter("qsysdate").toString().trim();
	}
	else
	{
		mDate=qsysdate;
	}
  //----------------------


%>
<form name="frm" method="post" >
<input id="x" name="x" type=hidden>
<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Daily Class Attendance Entry [ Today's Attendance or Previous Day's Excuse]</TD>
</font></td></tr>
</TABLE>
<table id=id2 cellpadding=1 cellspacing=1 width="100%" align=center rules=rows border=2>
<!--Institute****-->
<Input Type=hidden name=InstCode Value=<%=mInstitute%>>
<tr><td nowrap colspan=2>
<FONT color=black face=Arial size=2><b>&nbsp; Exam Code</b></FONT>
<%
try
{ 	
	qry="SELECT Exam from(";
	qry=qry+" Select nvl(EXAMCODE,' ') Exam , EXAMPERIODFROM from EXAMMASTER Where InstituteCode='"+mInst+"' AND ";
	qry=qry+" nvl(Deactive,'N')='N' and Nvl(LOCKEXAM,'N')='N' and nvl(EXCLUDEINATTENDANCE,'N')='N' ";
//-----
	//qry=qry+" and examcode in (select EXAMCODEFORATTENDNACEENTRY from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"')";
//-----
//--OR--
//-----
	qry=qry+" and (examcode in (select ExamCode from facultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail))";
	qry=qry+" OR examcode in (select ExamCode from MultiFacultysubjecttagging where employeeid='"+mDMemberID+"' AND  fstid in (select fstid from studentltpdetail)))";
//-----
	qry=qry+" order by EXAMPERIODFROM DESC)";
	//qry=qry+" WHERE ROWNUM<=3";
	//out.print(qry);
	rs=db.getRowset(qry);
	if (request.getParameter("x")==null) 
	{
		%>
		<Select Name=Exam tabindex="0" id="Exam" style="WIDTH: 120px"
onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);"
onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(qryexam.equals(""))
 			{
			mexam=mExam;
			qryexam=mExam;
			%>
			<OPTION Selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
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
	else
	{
		%>	
		<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px"
onclick="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);"
 onChange="ChangeOptions(Exam.value,DataCombo,Subject,DataComboAcad,AcademicYear,DataComboSec,Section);">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("Exam");
			if(mExam.equals(request.getParameter("Exam").toString().trim()))
 			{
				mexam=mExam;
				qryexam=mExam;
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
<FONT color=black face=Arial size=2><b>&nbsp; Attendance Date </b></FONT><input type='text' name='qsysdate' id='qsysdate' value=<%=mDate%> style="width=70px" MAXLENGTH=10>&nbsp;  
 
<!-- <input type='text' name='ClassFrom' id='ClassFrom' style="width=50px"><b> To</B>  <input type='text' name='ClassUpto' id='ClassUpto' style="width=50px">-->  

<%
if(request.getParameter("radio1")==null)
{
	%>
	<FONT color=black face=Arial size=2><b>&nbsp; Attendance Type </b></FONT> &nbsp;<input type=radio name=radio1 id=radio1  value='R' checked><b><font color= green>Regular</font></b> 
	<input type=radio name=radio1 id=radio1 value='E'><b><font color=brown>Extra</font></b>
	<%
}
else
{
	mradio1=request.getParameter("radio1").toString().trim();
	if(mradio1.equals("R"))
	{
		%>
		<FONT color=black face=Arial size=2><b>&nbsp; Attendance Type </b></FONT> &nbsp;<input type=radio name=radio1 id=radio1  value='R' checked><b><font color= green>Regular</font></b> 
		<input type=radio name=radio1 id=radio1 value='E'><b><font color=brown>Extra</font></b>
		<%
	}
	else
	{
		%>
		<FONT color=black face=Arial size=2><b>&nbsp; Attendance Type </b></FONT> &nbsp;<input type=radio name=radio1 id=radio1  value='R' ><b><font color= green>Regular</font></b> 
		<input type=radio name=radio1 id=radio1 value='E' checked><b><font color=brown>Extra</font></b>
		<%
	}
}	
%>
</td>
<td nowrap>
<!--*********Exam**********-->
<!--******************DataCombo**************-->
<%
try														
{     

qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.employeeid='"+mDMemberID+"'";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from facultysubjecttagging A,SUBJECTMASTER B";
qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')";
qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) And InstituteCode='"+mInst+"' and ";
qry=qry+" Nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" union ";
qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"' ) AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"'  AND A.INSTITUTECODE=B.INSTITUTECODE ";
qry=qry+" order by subject ";
//out.print(qry);
rs=db.getRowset(qry);

	//out.print(qry);
	if (request.getParameter("x")==null) 
	{
	 %>
		<Select Name=DataCombo id="DataCombo" style="WIDTH:0px">	
		<%   
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;
			%>
			<OPTION Value="<%=mES%>"><%=rs.getString("subject")%></option>
			<%
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<Select Name=DataCombo id="DataCombo" style="WIDTH:0px">	
		<%
		while(rs.next())
		{
			mExam=rs.getString("subjectid");
			mCode=rs.getString("examcode");
			mES=mCode+"***"+mExam;

			if(mExam.equals(request.getParameter("Subject").toString().trim()))
 			{
				%>
				<OPTION selected Value="<%=mES%>"><%=rs.getString("subject")%></option>
				<%
		     	}
		     	else
		      {
				%>
		      	<OPTION Value="<%=mES%>"><%=rs.getString("subject")%></option>
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
//----***************Subject**********************
%>
</td></tr>
<tr><td nowrap colspan="3">
<FONT color=black face=Arial size=2><b>&nbsp; &nbsp; &nbsp; &nbsp; Subject</b> </FONT>
<%	


	qry="Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.employeeid='"+mDMemberID+"'";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"' and A.EXAMCODE='"+qryexam+"' AND  A.INSTITUTECODE=B.INSTITUTECODE " ;
	qry=qry+" union ";
	qry=qry+" Select nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from facultysubjecttagging A, SUBJECTMASTER B";
	qry=qry+" where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')";
	qry=qry+" and A.fstid not in (select fstid from STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"' And InstituteCode='"+mInst+"') AND A.SUBJECTID=B.SUBJECTID and B.InstituteCode='"+mInst+"' and A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+"  AND A.INSTITUTECODE=B.INSTITUTECODE union ";
	qry=qry+" Select  nvl(A.subjectid,' ') subjectid, nvl(B.subjectcode,' ') subjectcode,A.examcode,nvl(B.subject,' ')||' ('||B.subjectcode||') ' subject ";
	qry=qry+" from  facultysubjecttagging A,SUBJECTMASTER B where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"' And InstituteCode='"+mInst+"' )AND A.SUBJECTID=B.SUBJECTID   AND A.INSTITUTECODE=B.INSTITUTECODE and B.InstituteCode='"+mInst+"' ";
	qry=qry+" and A.EXAMCODE='"+qryexam+"' order by subject";
	rs=db.getRowset(qry);
	//out.print(qry);
	%>

	<select name=Subject tabindex="0" id="Subject" 
    onclick="ChangeSubject(Exam.value,Subject.value,DataComboAcad,AcademicYear,DataComboSec,Section);"
 onChange="ChangeSubject(Exam.value,Subject.value,DataComboAcad,AcademicYear,DataComboSec,Section);">
	<%
	if (request.getParameter("x")==null) 
	{
	while(rs.next())
	{
		if(mSubj1.equals(""))
		{
		 	mSubj1=rs.getString("subjectid");
			qrysubj=mSubj1;
 			%>
			<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
			<%
		}
		else
		{
 			%>
			<OPTION Value ='<%=rs.getString("subjectid")%>'><%=rs.getString("subject")%></option>
			<%
		}
	}
}
else
{
		while(rs.next())
		{
			mSubj1=rs.getString("subjectid");
			if (mSubj1.equals(request.getParameter("Subject").toString().trim()))
			{
			qrysubj=mSubj1;
			%>
			<OPTION selected Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
			<%
		}
		else
		{
			%>
      		<OPTION Value ='<%=mSubj1%>'><%=rs.getString("subject")%></option>
     			<%			
	   	}
	}
}
%>
</select>

</td></tr>
<tr><td >
&nbsp; &nbsp; &nbsp;   &nbsp; &nbsp; &nbsp; &nbsp; 
<FONT color=black><FONT face=Arial size=2><STRONG>LTP </STRONG></FONT></FONT>

<%	
	qry="Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and  A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.employeeid='"+mDMemberID+"' and A.fstid not in (select fstid from  ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid<>'"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' " ;
	qry=qry+" union ";
	qry=qry+" Select Distinct LTP ,decode(nvl(LTP,' '),'L','Lecture','T','Tutorial','P','Practical','E','Project') LtpDesc ,";
	qry=qry+" decode(nvl(LTP,' '),'L','1','T','2','P','3','4') orderltp ";
	qry=qry+" from  facultysubjecttagging A where A.fstid in (select fstid from ";
	qry=qry+" STUDATTENDANCEBYSPECIALFACULTY where trunc(sysdate)=trunc(attendancedate) and ";
	qry=qry+" nvl(deactive,'N')='N' and facultyid='"+mDMemberID+"') ";//and A.EXAMCODE='"+qryexam+"' ";
	qry=qry+" ORDER BY orderltp ";
	rs=db.getRowset(qry);
	//out.print(qry);

%>
	<select name=LTP tabindex="0" id="LTP" style="WIDTH: 90px" >	
<% 
if (request.getParameter("x")==null) 
{
	while(rs.next())
	{
		mltp1=rs.getString("LTP");
		if(mltp1.equals("L"))
		{
	 		%>
			<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
		else
		{
	 		%>
			<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
	}
}
else
{
		while(rs.next())
		{
			mltp1=rs.getString("LTP");
			if (mltp1.equals(request.getParameter("LTP").toString().trim()))
			{
			%>
			<OPTION selected Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
			<%
		}
		else
		{
			%>
      		<OPTION Value ='<%=mltp1%>'><%=rs.getString("LtpDesc")%></option>
	     		<%
	   	}
	}
}
%>
</select>
&nbsp;&nbsp;

<FONT color=black><FONT face=Arial size=2><STRONG>Academic Year</STRONG></FONT></FONT>
&nbsp;&nbsp;
	<%
	try
	{


 qry = "select distinct nvl(ACADEMICYEAR,' ')ACADEMICYEAR   from facultysubjecttagging where " +
         " INSTITUTECODE='"+ mInst +"' AND nvl(deactive,'N')='N' and employeeid='"+mDMemberID+"' or fstid in (select fstid from" +
         " MULTIFACULTYSUBJECTTAGGING where " +
         " institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') " +
         "and employeeid='"+mDMemberID+"')  order by ACADEMICYEAR";
//out.print(qry);
     rs = db.getRowset(qry);

		%>	
															
		<select name="AcademicYear" tabindex="0" id="AcademicYear" style="WIDTH: 80px" >
		<OPTION selected Value ='ALL'>ALL</option>
<%   
	if (request.getParameter("x")==null) 
	 {
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR").toString().trim();
			if(mAcad.equals(""))
			{
				mAcad=mAcademicYear;
			%>
				<OPTION   Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
			else
			{
			%>
				<OPTION Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%
			}
		} // closing of while
	 } // closing of if 
	 else
	{
		while(rs.next())
		{
			mAcademicYear=rs.getString("ACADEMICYEAR").toString().trim();
			if(mAcademicYear.equals(request.getParameter("AcademicYear").toString().trim()))
 			{
			   mAcad=mAcademicYear;
			%>
				<OPTION selected Value="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			<%			
			}
			else
 	            {
				%>
					<OPTION Value ="<%=mAcademicYear%>"><%=rs.getString("ACADEMICYEAR")%></option>
			    	<%			
			}
		 } // closing of while
 } // closing of else
					%>
						</select>
					  	<%
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				


//**********************DataComboAcad***************
//out.print(qryexam);
try
{ 
	qry1 = "select distinct nvl(ACADEMICYEAR,' ')ACADEMICYEAR ,subjectid ,examcode from facultysubjecttagging where " +
         " INSTITUTECODE='"+ mInst +"' AND nvl(deactive,'N')='N' and employeeid='"+mDMemberID+"' or fstid in (select fstid from" +
         " MULTIFACULTYSUBJECTTAGGING where " +
         " institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') " +
         "and employeeid='"+mDMemberID+"')  order by ACADEMICYEAR";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="DataComboAcad" tabindex="0" id="DataComboAcad" style="WIDTH: 0px">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mACAD1=mSExam+"***"+mSubj+"&&&"+rs1.getString("ACADEMICYEAR");

			%>
			<OPTION Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataComboAcad" tabindex="0" id="DataComboAcad" style="WIDTH:0px">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid").toString().trim();
			mSExam=rs1.getString("examcode");
			mACAD1=mSExam+"***"+mSubj+"&&&"+rs1.getString("ACADEMICYEAR");

			if(mACAD1.equals(request.getParameter("AcademicYear").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mACAD1%>"><%=rs1.getString("ACADEMICYEAR")%></option>
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

			



 <!******************Group/Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; &nbsp; &nbsp; Branch Code</STRONG>&nbsp;</FONT></FONT>
<%
try
{ 
	qry1="select 'ALL' section from dual union all";
	qry1=qry1+" select DISTINCT nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where facultytype=decode('"+mDMemberType+"','E','I','E')";
	qry1=qry1+" and employeeid='"+mDMemberID+"' and institutecode='"+mInst+"' and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' Group By nvl(SECTIONBRANCH,' ')";
	qry1=qry1+" UNION";
	qry1=qry1+" select DISTINCT nvl(SECTIONBRANCH,' ') Section from facultysubjecttagging where ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y')";
	qry1=qry1+" and examcode='"+qryexam+"' and subjectid='"+qrysubj+"' and institutecode='"+mInst+"' Group By nvl(SECTIONBRANCH,' ') order by Section";
	//out.print(qry1);

	rs1=db.getRowset(qry1);

	if (request.getParameter("x")==null) 
	{
		%>
		<select name=Section tabindex="0" id="Section" style="WIDTH: 80px">
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("Section");
			
			qrysec=mSubj;
			%>
			<OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name=Section tabindex="0" id="Section" style="WIDTH: 80px" >
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("Section");
			if(mSubj.equals(request.getParameter("Section").toString().trim()))
 			{
				qrysec=mSubj;
				%>
				<OPTION selected Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mSubj%>><%=rs1.getString("Section")%></option>
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

//**********************DataComboSec***************
//out.print(qryexam);
try
{ 
	qry1=" select DISTINCT nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode,academicyear from  facultysubjecttagging where  ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE, academicyear";
	qry1=qry1+" UNION";
	qry1=qry1+" select DISTINCT nvl(SECTIONBRANCH,' ') Section,nvl(subjectid,' ')subjectid,nvl(EXAMCODE,' ')examcode,academicyear from  facultysubjecttagging where  ";
	qry1=qry1+" fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"') and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" or nvl(FINALIZED,'N')='Y' or NVL(DEACTIVE,'N')='Y' )  Group by SECTIONBRANCH ,subjectid,EXAMCODE, academicyear";
	qry1=qry1+" order by Section";
	//out.print(qry1);
	rs1=db.getRowset(qry1);
	if (request.getParameter("x")==null) 
	{
		%>
		<select name="DataComboSec" tabindex="0" id="DataComboSec" style="WIDTH: 0px">	
		<%   
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid");
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"&&&"+rs1.getString("academicyear")+"///"+rs1.getString("Section");

			%>
			<OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
			
			<%			
		}
		%>
		</select>
		<%
	}
	else
	{
		%>	
		<select name="DataComboSec" tabindex="0" id="DataComboSec" style="WIDTH:0px">	
		<%
		while(rs1.next())
		{
			mSubj=rs1.getString("subjectid").toString().trim();
			mSExam=rs1.getString("examcode");
			mSES=mSExam+"***"+mSubj+"///"+rs1.getString("Section");

			if(mSES.equals(request.getParameter("Section").toString().trim()))
 			{
				%>
				<OPTION selected Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value ="<%=mSES%>"><%=rs1.getString("Section")%></option>
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
    </td>
    </tr>
    <tr>
        <td align="center" colspan="4">
            <input type="submit" name="Submit" value="Submit"   >
        </td>
    </tr>
    </table>
</form>

<form name="frm2">
    <input type="hidden" name="y" id="y">
        <input type="hidden" name="x" id="x">
    <%

try
{


//out.print("aajaj");
if (request.getParameter("AcademicYear")!=null)
		mAcademicYear=request.getParameter("AcademicYear").toString().trim();
	else
		mAcademicYear="";

	if (request.getParameter("qsysdate")!=null)
		mDate=request.getParameter("qsysdate").toString().trim();
	else
		mDate="";

	mExam=request.getParameter("Exam").toString().trim();

	if (request.getParameter("Subject")!=null)
		mSubject=request.getParameter("Subject").toString().trim();
	else
		mSubject="";

	mLTP=request.getParameter("LTP").toString().trim();
	mSection=request.getParameter("Section").toString().trim();

if (request.getParameter("qsysdate")!=null)
		mDate=request.getParameter("qsysdate").toString().trim();
	else
		mDate="";

	//out.print("X - "+request.getParameter("x"));
	//out.print(mSubject+"aajaj");

	//mSubsection=request.getParameter("SubSection").toString().trim();
	mType=request.getParameter("radio1").toString().trim();


	//out.print(mRowNum);

if(!mSubject.equals(""))
{
    %>
 <input type="hidden" name="Subject" id="Subject" value="<%=mSubject%>">
 <input type="hidden" name="radio1" id="radio1" value="<%=mType%>">
 <input type="hidden" name="LTP" id="LTP" value="<%=mLTP%>"> 
 <input type="hidden" name="Exam" id="Exam" value="<%=mExam%>">
     <input type="hidden" name="AcademicYear" id="AcademicYear" value="<%=mAcademicYear%>">
         <input type="hidden" name="Section" id="Section" value="<%=mSection%>">
    <input type="hidden" name="qsysdate" id="qsysdate" value="<%=mDate%>">

<table id=id2 cellpadding=1 cellspacing=1 width="100%" align=center rules=rows border=2>

<tr><td colspan="3">

 <!******************Sub Group/Sub Section**************-->
<FONT color=black><FONT face=Arial size=2><STRONG>&nbsp; &nbsp;Sub Section</STRONG>
 </FONT></FONT>
<%

	qry1="select 'ALL' SubSection   from dual union all (Select DISTINCT SUBSECTIONCODE SubSection from  V#STUDENTLTPDETAIL where  NVL (deactive, 'N') = 'N' AND NVL (STUDENTDEACTIVE, 'N') = 'N' AND ";
	qry1=qry1+" facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+mExam+"' and subjectid='"+mSubject+"' and LTP='"+mLTP+"' ";
	qry1=qry1+" and sectionbranch=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') ";
	qry1=qry1+" and institutecode='"+mInst+"' and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' ) Group By SUBSECTIONCODE";
	qry1=qry1+" UNION";
	qry1=qry1+" Select DISTINCT SUBSECTIONCODE SubSection from  V#STUDENTLTPDETAIL where  ";
	qry1=qry1+" NVL (deactive, 'N') = 'N' AND NVL (STUDENTDEACTIVE, 'N') = 'N' AND fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"'" +
            " and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') " +
            "and employeeid='"+mDMemberID+"') and  ";
	qry1=qry1+" examcode not in (select examcode from exammaster where nvl(LOCKEXAM,'N')='Y' ";
	qry1=qry1+" and nvl(FINALIZED,'N')='Y' and	 NVL(DEACTIVE,'N')='Y' )  ";
	qry1=qry1+" and examcode='"+mExam+"' and subjectid='"+mSubject+"'";
	qry1=qry1+" and sectionbranch=decode('"+mSection+"','ALL',sectionbranch,'"+mSection+"') ";
	qry1=qry1+" and institutecode='"+mInst+"' and LTP='"+mLTP+"' and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  Group By SUBSECTIONCODE )";
	//out.print(qry1);
	rs1=db.getRowset(qry1);

		  int cnt=0;
       
String mcheck="";
		while(rs1.next())
		{
            cnt++;
			mSubj=rs1.getString("SubSection").toString().trim();

            if(request.getParameter("SubSection"+cnt)==null)
                mcheck="";
            else
                mcheck="checked";
			if(mSubj.equals("ALL"))
			{

            %>
&nbsp;  &nbsp; &nbsp;<input type="checkbox" name="SubSection<%=cnt%>" id="SubSection<%=cnt%>" <%=mcheck%> value="Y" >
			<b><%=mSubj%></b> 
			
			<%
			}
		
			else
			{
				%>
            <input type="checkbox" name="SubSection<%=cnt%>" id="SubSection<%=cnt%>" <%=mcheck%> value="Y" >
			<%=mSubj%>
			
			<%
			}
				%>
       <input type="hidden" name="SubSectionCode<%=cnt%>" id="SubSectionCode<%=cnt%>"  value="<%=mSubj%>" >

           
			
			
			

        <%
		}
        %>
        <input type="hidden" name="cnt" id="cnt" value="<%=cnt%>">
        <%
		
	

if(request.getParameter("timepicker1")==null)
	mtimepicker1="" ;
else
	mtimepicker1=request.getParameter("timepicker1");	

if(request.getParameter("timepicker2")==null)
	mtimepicker2="" ;
else
	mtimepicker2=request.getParameter("timepicker2");

if(request.getParameter("RowNum")==null)
	mRowNum=4;
else
	mRowNum=Integer.parseInt(request.getParameter("RowNum").toString().trim());
%>

&nbsp;&nbsp;
<font face="arial" size="2">Students  of batches shown in window are tagged with you *</font>
</td></tr>
<tr><td colspan="3">
<FONT color=black face=Arial size=2><b>&nbsp; Class Period </b></FONT><input id='timepicker1' name='timepicker1' type='text' value="<%=mtimepicker1%>" size=8 maxlength=8 ONBLUR="validateDatePicker(this)" onchange="return Classtotime(timepicker1.value);" >&nbsp;<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker1)" STYLE="cursor:hand" onmouseover="Classtotime(timepicker1.value);">
&nbsp;&nbsp;<STRONG><FONT color=black face=Arial size=2>&nbsp; To &nbsp; </FONT></STRONG>
<input id='timepicker2' name='timepicker2' type='text' value='<%=mtimepicker2%>' size=8 maxlength=8 ONBLUR="validateDatePicker(this)" onmouseover="Classtotime(timepicker1.value);">&nbsp;
<IMG SRC="../../Images/timepicker.gif" BORDER="0" ALT="Pick a Time!" ONCLICK="selectTime(this,timepicker2)" STYLE="cursor:hand" onmouseover="Classtotime(timepicker1.value);">
<!--<FONT color=black face=Arial size=2><b>View Last &nbsp;</b></FONT><input style="FONT-WEIGHT: bold; FONT-SIZE: x-small; WIDTH: 23px; FONT-FAMILY: Arial; HEIGHT: 22px; text-align:center;background-color:'#CCFFFF'" id='RowNum' name='RowNum' type='text' value='<%=mRowNum%>' size=2 maxlength=1 onKeyPress="return numbersonly(this, event);"><FONT color=black face=Arial size=2><b>&nbsp; Days Attendance </b></FONT>--><INPUT Type="submit" Value="Show/Refresh" onClick="return Check();">
</td></tr>
<tr><td nowrap colspan=2><font face=verdana size=2>
    <B><u>Hint:-</u></b>
 If Sub Section window does not show any batch No.(except word ALL)
 please do refresh the window by clicking a link on the left hand panel.
<br>
    * In case of doubt contact department tagging co-ordinator or JIITERP<br>
   &nbsp; In case a student shows Zero attendance throught or for a prolonged period,
   do check registration status with registry.<br>
   &nbsp; In case of additional name of students is shown above
   what you are teaching than do contact department tagging co-ordinator or JIITERP.

    </font></td></tr>
<TR>
<!-- <TD width=50% nowrap>
<marquee behavior=alternate scrolldelay=300 direction=right>
<a href='DailyStudentAttendanceEdit.jsp'><font color=blue><b>Edit/Change Previous Day Attendance</b></font></a>
</marquee>
</TD> -->
<TD  nowrap>
<marquee behavior=alternate scrolldelay=300 direction=left><a href='AttendanceofPreviousDay.jsp'><font color=blue><b>Excuse/Remarks For Previous Day Attendance</b></font></a></marquee>
</TD>
</TR>
</table>
</form>
<%
}
}
catch(Exception e)
{

}



if(request.getParameter("x")!=null)
{
	if (request.getParameter("DataComboSub")!=null)
		mDataComboSubSec=Integer.parseInt(request.getParameter("DataComboSub").toString().trim());
	else
		mDataComboSubSec=0;


	if (request.getParameter("AcademicYear")!=null)
		mAcademicYear=request.getParameter("AcademicYear").toString().trim();
	else
		mAcademicYear="";

	if (request.getParameter("qsysdate")!=null)
		mDate=request.getParameter("qsysdate").toString().trim();
	else
		mDate="";

	mtime1=request.getParameter("timepicker1").toString().trim().toUpperCase();
	mtime2=request.getParameter("timepicker2").toString().trim().toUpperCase();
	
	mLTP=request.getParameter("LTP").toString().trim();

//mtime1.substring(0,mtime1.indexOf(":"));



int ftime=Integer.parseInt(mtime1.substring(0,mtime1.indexOf(":")));
int ttime=Integer.parseInt(mtime2.substring(0,mtime2.indexOf(":")));

String mtime4="",mtime22="",mDTExtrafrom="",mDTExtraupto="";



if((ttime-ftime)>1  &&  mLTP.equals("L") )
	{
	
		
			mtime1=mtime1;
			mtime22=(ftime+1)+mtime1.substring(mtime1.indexOf(":"));

		//	mtime3=mtime22;
			mtime4=mtime2;
				out.print(mtime1+"ccc"+mtime22);
				out.print(mtime22+"ccc"+mtime4);
	
	
	mDTfrom=mDate+" "+mtime1;
	mDTupto=mDate+" "+mtime22;


	mDTExtrafrom=mDate+" "+mtime22;
	mDTExtraupto=mDate+" "+mtime4;


	}
	else
	{
		
	mDTfrom=mDate+" "+mtime1;
	mDTupto=mDate+" "+mtime2;
	}
//out.print(mDTfrom+"aajaj"+mDTupto);

	mExam=request.getParameter("Exam").toString().trim();

	if (request.getParameter("Subject")!=null)
		mSubject=request.getParameter("Subject").toString().trim();
	else
		mSubject="";

	
	mSection=request.getParameter("Section").toString().trim();	

	//String mSubSec[]={"ALL"};
    String mSubSec="";
    int mCnt=0;
    mCnt= Integer.parseInt(request.getParameter("cnt"));

   //out.print(mCnt+"ddd");
	try
	{
	
		for (int i=1;i<=mCnt;i++)
		{

//out.print(request.getParameter("SubSection"+i)+"lll");

    if (request.getParameter("SubSection"+i)==null )
          mSubSec= "N";
	else
          mSubSec= request.getParameter("SubSectionCode"+i);

// out.print(mSubSec+"mSubSec");
if(!mSubSec.equals("N"))
   {

            if(mSubSec.equals("ALL"))
                {
                         mSubsection="ALL";
		    }
  else
      {

      	if(mSubsection.equals("") )
				mSubsection="'"+mSubSec+"'";
			else
				mSubsection=mSubsection+",'"+mSubSec+"'";

      }
}
		}
	}
	catch(Exception e)
	{
		//mSubsection="ALL";
	}
    
//	if(mSubsection.indexOf("ALL")>0)
//		mSubsection="ALL";

	//out.print("X - "+request.getParameter("x"));


   
  // out.print(mSubsection+"aajaj");

	//mSubsection=request.getParameter("SubSection").toString().trim();	
	mType=request.getParameter("radio1").toString().trim();			

	if(request.getParameter("RowNum")==null)
		mRowNum=4;
	else
		mRowNum=Integer.parseInt(request.getParameter("RowNum").toString().trim());

	
	
	
	//out.print(mSubsection);

	
	
	if(!mSubsection.equals(""))
	{
	%>

<form name="dd" id="dd">
<center>
<input style="width:220px;font-size:16px;position:absolute;text-align:middle;
	color:red;font-weight:bold;BORDER-LEFT: c00000 0px solid;BORDER-TOP: c00000 0px solid;
	BORDER-RIGHT: c00000 0px solid;BORDER-BOTTOM: c00000 0px solid ; background-color:transparent"  name="twait" id="twait" readonly type="text" value="Loading! Please Wait...">
</center>
</form>


	<form name="frm1"  method="post" action="NewDailyStudentAttendanceEntryAction.jsp">
	<INPUT TYPE="HIDDEN" NAME="DataComboSub" VALUE=<%=mDataComboSubSec%>>
	<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='90%' bottommargin=0 rules=rows topmargin=0 cellspacing=0 cellpadding=0 border=1 align=center>
	<thead>
	<tr bgcolor="#ff8c00">
	<td rowspan=2 Title="Sort on SlNo"><font color="White"><b>Sr.<br>No.</b></font></td>
	<td rowspan=2 Title="Sort on Enrollment No" nowrap><font color="White"><b>Roll No.</b></font></td>
	<td rowspan=2 Title="Class Student Name"><font color="White"><b>Name</b></font></td>
	<td rowspan=2 Title="Sort on Section/Subsection"><font color="White"><b>Section<br>(SubSec.)</b></font></td>


	<td rowspan=2><font color="Green"><input onClick="un_check()"  type="checkbox" id='allbox' name='allbox' value='P' checked>&nbsp;<b>Present</b></font></td>
	<td rowspan=2><font color="darkbrown"><input onClick="un_check1()"  type="checkbox" id='allbox1' name='allbox1' value='A'>&nbsp;<b>Absent</b></font></td> 
	<td Colspan=3 Title="Student % Attendance" align=center nowrap><font color="White"><b>% Attendance Till Today</b></font></td>
	<%
	qry="Select ATTENDANCEDATE, CLASSTIMEFROM FROM (";
	qry=qry+" Select Distinct to_char(ATTENDANCEDATE,'dd/mm')ATTENDANCEDATE, to_date(CLASSTIMEFROM,'DD-MM-YYYY')CLASSTIMEFROM from studentattendance where fstid in (Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"'  and  A.AcademicYear = decode('"+mAcademicYear+"' ,'ALL',a.academicyear,'"+mAcademicYear+"' )    and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='"+mLTP+"'";
	if(mSubsection.equals("ALL")  )
	{
		qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"')";
	}
	else
	{
		qry=qry+" and A.subsectioncode in ("+mSubsection+")";
	}
	qry=qry+" and A.sectionbranch=decode('"+mSection+"','ALL',A.sectionbranch,'"+mSection+"')";
	qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"'   and  AA.AcademicYear = decode('"+mAcademicYear+"' ,'ALL',aa.academicyear,'"+mAcademicYear+"' )   AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='"+mLTP+"'";
	if(mSubsection.equals("ALL"))
	{
		qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"')";
	}
	else
	{
		qry=qry+" and A.subsectioncode in ("+mSubsection+")";
	}
	qry=qry+" and AA.sectionbranch=decode('"+mSection+"','ALL',AA.sectionbranch,'"+mSection+"'))";
	qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))) ORDER BY CLASSTIMEFROM DESC";
	qry=qry+" ) WHERE ROWNUM<='"+mRowNum+"' ORDER BY CLASSTIMEFROM";
	rsRowNum=db.getRowset(qry);
	//out.print(qry);
	while(rsRowNum.next())
	{
		%>
		<td rowspan=2 nowrap title="Student Attendance (Present or Absent) as on <%=rsRowNum.getString("ATTENDANCEDATE")%>"><font color="White"><b><%=rsRowNum.getString("ATTENDANCEDATE")%></b></font></td>
		<%
	}
	%>
	</tr>
	<tr bgcolor="#ff8c00">
	<td rowspan=2 Align=center Title="Student Lecture % Attendance"><font color="White"><b>L</b></font></td>
	<td rowspan=2 Align=center Title="Student Tutorial % Attendance"><font color="White"><b>T</b></font></td>
	<td rowspan=2 Align=center Title="Student Practical % Attendance"><font color="White"><b>P</b></font></td>
	</tr>	
	</thead>
	<tbody>
	<%	

	qry="select nvl(to_date('"+qsysdate+"','DD-MM-YYYY')-to_date('"+mDate+"','DD-MM-YYYY'),0) DiffInDate from dual";
	rs2=db.getRowset(qry);
	//out.print(qry);
	if(rs2.next())
		mDiffInDate = rs2.getInt("DiffInDate");
	if(mDiffInDate>=0)
	{
		if (GlobalFunctions.iSValidDate(mDate)==true)
		{	
			qry="Select WEBKIOSK.IsValidTimeFormat('"+mtime1+"')SL,WEBKIOSK.IsValidTimeFormat('"+mtime2+"')SL1 from dual";
			RsChk1= db.getRowset(qry);
			if (RsChk1.next() && RsChk1.getString("SL").equals("Y") && RsChk1.getString("SL1").equals("Y"))
			{
				try
				{
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"'  and  A.AcademicYear =decode('"+mAcademicYear+"' ,'ALL',a.academicyear,'"+mAcademicYear+"' )   and A.LTP='L' ";
					qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"' AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='L' ";
					if(mSubsection.equals("ALL"))
					{
						qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					}	
					else
					{
						qry=qry+" and A.subsectioncode in ("+mSubsection+")";
					}
					qry=qry+" and AA.sectionbranch=decode('"+mSection+"','ALL',AA.sectionbranch,'"+mSection+"'))";
					qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
					rsdt=db.getRowset(qry);
					if(rsdt.next())
						LFST++;
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='T'   and  A.AcademicYear = decode('"+mAcademicYear+"' ,'ALL',a.academicyear,'"+mAcademicYear+"' )   " ;
					qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"' AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='T' ";
					if(mSubsection.equals("ALL"))
					{
						qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					}
					else
					{
						qry=qry+" and A.subsectioncode in ("+mSubsection+")";
					}
					qry=qry+" and AA.sectionbranch=decode('"+mSection+"','ALL',AA.sectionbranch,'"+mSection+"'))";
					qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
					rsdt=db.getRowset(qry);
					if(rsdt.next())
						TFST++;
					qry="Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='P'  and  A.AcademicYear = decode('"+mAcademicYear+"' ,'ALL',a.academicyear,'"+mAcademicYear+"' )   ";
					qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"' AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='P' ";
					if(mSubsection.equals("ALL"))
					{
						qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					}
					else
					{
						qry=qry+" and A.subsectioncode in ("+mSubsection+")";
					}
					qry=qry+" and AA.sectionbranch=decode('"+mSection+"','ALL',AA.sectionbranch,'"+mSection+"'))";
					qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))";
					//out.print(qry);
					rsdt=db.getRowset(qry);
					if(rsdt.next())
						PFST++;

				}
				catch(Exception e)
				{
				}

				qry=" SELECT TO_CHAR(TO_DATE('"+mDTupto+"','DD-MM-YYYY HH:MI PM'),'YYYYMMDDHH24MI') ";
				qry=qry+" - TO_CHAR(TO_DATE('"+mDTfrom+"','DD-MM-YYYY HH:MI PM'),'YYYYMMDDHH24MI') ";
				qry=qry+" from dual ";	
				rsdt=db.getRowset(qry);
				rsdt.next();
				dt=rsdt.getLong(1);
				if(dt>0)
				{
				qry="select  nvl(A.EMPLOYEEID,' ')employeeid,nvl(A.FSTID,' ')fstid,nvl(A.enrollmentno,' ')enrollmentno,nvl(A.studentname,' ')studentname, NVL(A.studentid,' ')studentid,";
					qry=qry+" NVL(A.SECTIONBRANCH,' ')|| '('||A.SUBSECTIONCODE||')' sectionbranch, nvl(B.SEMESTER,1) SEMESTER, nvl(to_char(B.REGCONFIRMATIONDATE,'dd-mm-yyyy'),' ') REGCONFIRMATIONDATE ,nvl(B.REGCONFIRMATION,'N')REGCONFIRMATION, ";
					qry=qry+" A.SECTIONBRANCH SECBR, A.SUBSECTIONCODE, C.SemesterType,C.LTP LTP ,nvl(C.SLNO,-1) SLNO ";
					qry=qry+" from V#STUDENTLTPDETAIL A,STUDENTREGISTRATION B, SUBJECTWISESLNO C  " ;
					//qry=qry+" where C.COMPANYCODE=A.COMPANYCODE ";
					//qry=qry+" AND C.INSTITUTECODE = A.INSTITUTECODE";

					qry=qry+" Where C.INSTITUTECODE = A.INSTITUTECODE ";
					qry=qry+" AND NVL(a.studentdeactive,'N')='N' AND NVL(a.deactive,'N')='N' ";
					qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND C.studentid=A.studentid";
					qry=qry+" AND C.INSTITUTECODE= A.INSTITUTECODE";
					qry=qry+" AND C.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND C.ACADEMICYEAR=A.ACADEMICYEAR ";
					qry=qry+" AND C.PROGRAMCODE=A.PROGRAMCODE ";
					qry=qry+" AND C.TAGGINGFOR=A.TAGGINGFOR ";
					qry=qry+" AND C.SECTIONBRANCH=A.SECTIONBRANCH ";
					qry=qry+" AND C.SUBSECTIONCODE=A.SUBSECTIONCODE ";
					qry=qry+" AND C.SUBJECTID=A.SUBJECTID ";
					qry=qry+" AND C.LTP=A.LTP ";
					//and  a.SEMESTER=b.SEMESTER";
					//qry=qry+" AND C.COMPANYCODE=B.COMPANYCODE";
					qry=qry+" AND C.INSTITUTECODE=B.INSTITUTECODE";
					qry=qry+" AND C.EXAMCODE=B.EXAMCODE";
					qry=qry+" AND C.REGCODE=B.REGCODE";
					qry=qry+" AND C.STUDENTID=B.STUDENTID";
					qry=qry+" AND C.studentid=A.studentid";
					qry=qry+" AND B.INSTITUTECODE=A.INSTITUTECODE";
					//qry=qry+" AND B.COMPANYCODE=A.COMPANYCODE";
					qry=qry+" AND B.EXAMCODE=A.EXAMCODE";
					qry=qry+" AND B.ACADEMICYEAR=A.ACADEMICYEAR";
					qry=qry+" AND B.STUDENTID=A.STUDENTID  and  A.AcademicYear =  decode('"+mAcademicYear+"' ,'ALL',a.academicyear,'"+mAcademicYear+"' )    and A.institutecode='"+mInst+"'";
//qry=qry+" and (A.EMPLOYEEID in (select '"+mDMemberID+"' from Dual ";
//qry=qry+" where not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
//------------OR-------------
qry=qry+" and (A.EMPLOYEEID in (select employeeid from facultysubjecttagging where employeeid='"+mDMemberID+"' OR (a.fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"' and fstid in (select fstid from facultysubjecttagging where examcode='"+mExam+"' and subjectid='"+mSubject+"' and LTP in ('"+mLTP+"'))))";
qry=qry+" and not exists (select 'y' from STUDATTENDANCEBYSPECIALFACULTY ssf Where ";
					qry=qry+" trunc(sysdate)=trunc(sSF.attendancedate) and nvl(sSF.deactive,'N')='N' and A.fstid=ssf.fstid))";
					qry=qry+" or A.EMPLOYEEID in (Select sf.FACULTYID from  STUDATTENDANCEBYSPECIALFACULTY SF ";
					qry=qry+" where trunc(sysdate)=trunc(SF.attendancedate) and nvl(SF.deactive,'N')='N' and A.fstid=sf.fstid)";
					qry=qry+" )"; 
					qry=qry+" and A.SUBJECTID='"+mSubject+"'";
					qry=qry+" and A.LTP in ('"+mLTP+"') ";
					qry=qry+"  and A.ExamCode='"+mExam+"'";
					if(mSubsection.equals("ALL"))
					{
						qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
					}
					else
					{
						qry=qry+" and A.subsectioncode in ("+mSubsection+")";
					}
					qry=qry+" and A.sectionbranch=decode('"+mSection+"','ALL',A.sectionbranch,'"+mSection+"') "; 	

					if (mType.equals("R"))
					{
						qry=qry+" And FSTID not in (Select  FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='R' )";
					}
					
					else
					{
						qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='E' ";
						qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
						qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					}
					
					// commented ankur
					/*qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					qry=qry+" And (to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					qry=qry+" or to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";*/

					qry=qry+" And FSTID not in (Select FSTID from STUDENTATTENDANCEEXCUSED where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"'";
					qry=qry+" And (to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
					qry=qry+" or to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					qry=qry+" order by SLNO"; 


			/*		qry="select   NVL (b.employeeid, ' ') employeeid, NVL (a.fstid, ' ') fstid,         NVL (f.enrollmentno, ' ') enrollmentno,         NVL (f.studentname, ' ') studentname,         NVL (a.studentid, ' ') studentid,            NVL (b.sectionbranch, ' ')         || '('         || f.subsectioncode         || ')' sectionbranch,         b.sectionbranch secbr,          f.subsectioncode, b.semestertype, b.ltp ltp,         NVL (b.semester, 1) semester,         NVL (TO_CHAR (d.regconfirmationdate, 'dd-mm-yyyy'),              ' '             ) regconfirmationdate from studentltpdetail a, facultysubjecttagging b,studentregistration d ,studentmaster f    where  nvl(f.DEACTIVE,'N')='N' AND NVL (A.deactive, 'N') = 'N' AND   b.subjectid = '"+mSubject+"'     AND b.ltp IN ('"+mLTP+"')      AND b.examcode = '"+mExam+"'      and  b.AcademicYear =  decode('"+mAcademicYear+"' ,'ALL',b.academicyear,'"+mAcademicYear+"' )    and b.institutecode='"+mInst+"'             and a.STUDENTID=f.STUDENTID     and a.STUDENTID=d.STUDENTID     AND d.institutecode = b.institutecode     AND d.examcode = b.examcode         AND d.studentid = a.studentid ";
      if(mSubsection.equals("ALL"))
					{
						qry=qry+" and b.subsectioncode=decode('"+mSubsection+"','ALL',b.subsectioncode,'"+mSubsection+"') ";
					}
					else
					{
						qry=qry+" and b.subsectioncode in ("+mSubsection+")";
					}
					qry=qry+" and b.sectionbranch=decode('"+mSection+"','ALL',b.sectionbranch,'"+mSection+"') "; 	// OR (a.fstid = b.fstid AND b.semestertype = 'RWJ')
    qry=qry+" and( (a.fstid = b.fstid and b.semestertype='REG' and b.mergewithfstid is null and b.employeeid = '"+mDMemberID+"' )   or (a.fstid = b.fstid and b.semestertype <>'REG' and b.employeeid = '"+mDMemberID+"'  AND( (b.mergewithfstid IS NULL) or ( b.academicyear <> 'ALL' And  b.academicyear= '"+mAcademicYear+"'  )) )     or         (exists (select 'x'                      from facultysubjecttagging c                      where c.examcode = b.examcode                      and c.institutecode = b.institutecode                      and c.subjectid = b.subjectid                      and c.ltp = b.ltp                      and b.fstid = c.mergewithfstid                      and c.fstid = a.fstid   and b.employeeid = '"+mDMemberID+"'                  )         )      )      AND (   b.employeeid IN (                SELECT employeeid                  FROM facultysubjecttagging                 WHERE employeeid = '"+mDMemberID+"'                    OR     (fstid IN (                               SELECT fstid                                 FROM multifacultysubjecttagging                                WHERE companycode='"+mComp+"' and institutecode='"+mInst+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"'                                  )                           )                      )         ) ";
  					if (mType.equals("R"))
					{
						qry=qry+" And b.FSTID not in (Select  FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='R' )";
					}
					
					else
					{
						qry=qry+" And b.FSTID not in (Select FSTID from STUDENTATTENDANCE where to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+mDate+"' and ATTENDANCETYPE='E' ";
						qry=qry+" And ( to_date('"+mDTfrom+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO ";
						qry=qry+" or  to_date('"+mDTupto+"','dd-mm-yyyy hh:mi PM') between CLASSTIMEFROM and CLASSTIMEUPTO))";
					}
    qry=qry+" AND b.fstid NOT IN (            SELECT fstid              FROM studentattendanceexcused             WHERE TO_CHAR (attendancedate, 'dd-mm-yyyy') = '"+mDate+"'               AND (   TO_DATE ('"+mDTfrom+"', 'dd-mm-yyyy hh:mi PM')                          BETWEEN classtimefrom                              AND classtimeupto                    OR TO_DATE ('"+mDTupto+"', 'dd-mm-yyyy hh:mi PM')                          BETWEEN classtimefrom                              AND classtimeupto                   ))                  order by f.ENROLLMENTNO";*/
//out.print(qry);
					rs1=db.getRowset(qry);
					while(rs1.next())
					{
						//check=1;

						Ctr++;
						if(Ctr%2==0)
							TRCOLOR="White";
						else
							TRCOLOR="#F8F8F8";

						mRollno=rs1.getString("enrollmentno").toString().trim();
						mName=rs1.getString("studentname").toString().trim();
						mName1="Present"+String.valueOf(Ctr).trim(); 	
						mName2="Absent"+String.valueOf(Ctr).trim(); 	
						mName3="Fstid"+String.valueOf(Ctr).trim();
						mName4="StudID"+String.valueOf(Ctr).trim();
						mName5="Employeeid"+String.valueOf(Ctr).trim();
						mName6="Enrollment"+String.valueOf(Ctr).trim();
						mName7="SNo"+String.valueOf(Ctr).trim();
						%>
						<tr bgcolor=<%=TRCOLOR%>>
						<td><%=Ctr%>.</td>
						<td><%=mRollno%></td>
						<td nowrap><%=GlobalFunctions.toTtitleCase(mName)%></td>
						<td><%=rs1.getString("sectionbranch")%></td>
						
						

						<td><input type='radio' value='P' ID='<%=mName1%>' Name='<%=mName1%>' checked onclick="return rad_check();"><font color=green>&nbsp;<b>P</b></font></td>
						<td><input type='radio' value='A' ID='<%=mName1%>' Name='<%=mName1%>' onclick="return rad_check();"><font color=red>&nbsp;<b>A</b></font></td>
						<%
						if(rs1.getString("REGCONFIRMATIONDATE")==null)
							mREGCONFIRMATIONDATE="";
						else
							mREGCONFIRMATIONDATE=rs1.getString("REGCONFIRMATIONDATE");
						
						//out.print(mREGCONFIRMATIONDATE+"mREGCONFIRMATIONDATE");
					
						if(LFST>0)
						{
//------------------Start of 'L' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
						qry1="SELECT SUM (Tcount)Tcount FROM (select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='L'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+"  and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(" "))
						{
						qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						 qry1=qry1+"  UNION ALL  select  COUNT (DISTINCT classtimefrom) Tcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'      and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  AND ltp ='L'     AND examcode = '"+mExam+"'  AND studentid = '"+rs1.getString("studentid")+"' ";
						if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and   NVL (deactive, 'N') = 'N'           )";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotCls=rs.getLong("Tcount");
						else
							QryTotCls=0;
						qry1="SELECT SUM (Pcount)Pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='L' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+"  and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
						qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+"   UNION ALL  select  COUNT (DISTINCT classtimefrom) Pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'   and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )    AND ltp ='L'  AND NVL (present, 'N') = 'Y'   AND examcode = '"+mExam+"'  AND studentid = '"+ rs1.getString("studentid") +"' ";
						 if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
						qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
								qry1=qry1+" 	and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"'       )";
						//out.print(qry1);
						rs=db.getRowset(qry1);


						if(rs.next())
							QryTotPrs=rs.getLong("Pcount");
						else
							QryTotPrs=0;
						try
						{
							if(QryTotCls==0)
								QryPercAtt=0;
							else
								QryPercAtt=((QryTotPrs*100)/QryTotCls);

							//out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt);
						}
						catch(ArithmeticException e)
						{
							//out.print(e);
						}
//------------------End of 'L' Percentage--------------------
						%>
						<!-- <td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'L' Attendance" target=_New href="DailyStudentAttendanceReportDet.jsp?RightsID=82&amp;EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=L&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>"><font color=""><b><%=QryPercAtt%></b> %</font></a></td> -->
						<%
						}
						else
						{
						%>
						<td ALIGN=CENTER>-</td>
						<%
						}
						if(TFST>0)
						{
//------------------Start of 'T' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
						qry1="SELECT SUM (Tcount)Tcount FROM (select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='T'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+" and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )    and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+"  UNION ALL select  COUNT (DISTINCT classtimefrom) Tcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'   and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )    AND ltp ='T'     AND examcode = '"+mExam+"'  AND studentid = '"+rs1.getString("studentid")+"'";
						if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and NVL (deactive, 'N') = 'N')";

						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotCls=rs.getLong("Tcount");
						else
							QryTotCls=0;
						qry1="SELECT SUM (Pcount)Pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='T' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+"  and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') ";
						qry1=qry1+" and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+"   UNION ALL select  COUNT (DISTINCT classtimefrom) Pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'    and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )   AND ltp ='T'  AND NVL (present, 'N') = 'Y'   AND examcode = '"+mExam+"'  AND studentid = '"+ rs1.getString("studentid") +"' ";
						 if(rs1.getLong("Semester")==1  && !mREGCONFIRMATIONDATE.equals(" "))
						{
						qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" 	and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"'       )";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotPrs=rs.getLong("Pcount");
						else
							QryTotPrs=0;
						try
						{
							if(QryTotCls==0)
								QryPercAtt=0;
							else
								QryPercAtt=((QryTotPrs*100)/QryTotCls);

							//out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt);
						}
						catch(ArithmeticException e)
						{
							//out.print(e);
						}
//------------------End of 'T' Percentage--------------------
						%>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'T' Attendance" target=_New href="DailyStudentAttendanceReportDet.jsp?RightsID=82&amp;EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=T&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>"><font color=""><b><%=QryPercAtt%></b> %</font></a></td>
						<%
						}
						else
						{
						%>
						<td ALIGN=CENTER>-</td>
						<%
						}
						if(PFST>0)
						{
//------------------Start of 'P' Percentage--------------------
						QryTotCls=0;
						QryTotPrs=0;
						qry1="SELECT SUM (Tcount)Tcount FROM (select count(Distinct CLASSTIMEFROM)Tcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='P'";
						qry1=qry1+" and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  and STUDENTID='"+rs1.getString("studentid")+"'";
						qry1=qry1+" and EXAMCODE='"+mExam+"' and INSTITUTECODE='"+mInst+"' and nvl(DEACTIVE,'N')='N'";
						//qry1=qry1+" and STUDENTID='"+rs1.getString("studentid")+"'";
						if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+"  UNION  ALL select  COUNT (DISTINCT classtimefrom) Tcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'    and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )   AND ltp ='P'     AND examcode = '"+mExam+"'  AND studentid = '"+rs1.getString("studentid")+"'";
						if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
					      qry1=qry1+"  and   NVL (deactive, 'N') = 'N'           )";

						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotCls=rs.getLong("Tcount");
						else
							QryTotCls=0;
						qry1="SELECT SUM (Pcount)Pcount FROM (select count(*)Pcount from V#STUDENTATTENDANCE where SubjectID='"+mSubject+"' and LTP='P' and EXAMCODE='"+mExam+"'";
						//qry1=qry1+" and FSTID='"+rs1.getString("Fstid")+"'";
						qry1=qry1+"  and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )  and STUDENTID='"+rs1.getString("studentid")+"' and INSTITUTECODE='"+mInst+"' and nvl(PRESENT,'N')='Y' and nvl(DEACTIVE,'N')='N'";
						if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(" "))
						{
							qry1=qry1+" and trunc(ATTENDANCEDATE) >= TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" and SECTIONBRANCH=decode('"+rs1.getString("SECBR")+"','ALL',SECTIONBRANCH,'"+rs1.getString("SECBR")+"') and SUBSECTIONCODE=decode('"+rs1.getString("subsectioncode")+"','ALL',SUBSECTIONCODE,'"+rs1.getString("subsectioncode")+"')";
						qry1=qry1+"   UNION ALL  select  COUNT (DISTINCT classtimefrom) Pcount from STUDENTPREVATTENDENCE where  subjectid = '"+mSubject+"'   and  AcademicYear = decode('"+mAcademicYear+"' ,'ALL',academicyear,'"+mAcademicYear+"' )     AND ltp ='P'  AND NVL (present, 'N') = 'Y'   AND examcode = '"+mExam+"'  AND studentid = '"+ rs1.getString("studentid") +"' ";
						 if(rs1.getLong("Semester")==1 && !mREGCONFIRMATIONDATE.equals(" "))
						{
						qry1=qry1+" and trunc(ATTENDANCEDATE)>=TO_Date('"+mREGCONFIRMATIONDATE+"','dd-mm-yyyy')";
						}
						qry1=qry1+" 	and   NVL (deactive, 'N') = 'N'    and INSTITUTECODE='"+mInst+"'       )";
						rs=db.getRowset(qry1);
						//out.print(qry1);
						if(rs.next())
							QryTotPrs=rs.getLong("Pcount");
						else
							QryTotPrs=0;
						try
						{
							if(QryTotCls==0)
								QryPercAtt=0;
							else
								QryPercAtt=((QryTotPrs*100)/QryTotCls);

							//out.print(QryTotCls+" "+QryTotPrs+" Tot Percentage - "+QryPercAtt);
						}
						catch(ArithmeticException e)
						{
							//out.print(e);
						}
//------------------End of 'P' Percentage--------------------
						%>
						<td ALIGN=CENTER>&nbsp;<a Title="View Date wise Student 'P' Attendance" target=_New href="DailyStudentAttendanceReportDet.jsp?RightsID=82&amp;EXAM=<%=mExam%>&amp;SID=<%=rs1.getString("studentid")%>&amp;SC=<%=mSubject%>&amp;LTP=P&amp;SEC=<%=rs1.getString("SECBR")%>&amp;SUBSEC=<%=rs1.getString("subsectioncode")%>"><font color=""><b><%=QryPercAtt%></b> %</font></a></td>
						<%
						}
						else
						{
						%>
						<td ALIGN=CENTER>-</td>
						<%
						}
						qry="Select ATTENDANCEDATE, ATTDATE, CLASSTIMEFROM FROM (";
						qry=qry+" Select Distinct to_char(ATTENDANCEDATE,'dd/mm')ATTENDANCEDATE, to_char(ATTENDANCEDATE,'dd-mm-yyyy')ATTDATE, to_date(CLASSTIMEFROM,'DD-MM-YYYY')CLASSTIMEFROM from studentattendance where fstid in (Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='"+mLTP+"' ";
						if(mSubsection.equals("ALL"))
						{
							qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
						}
						else
						{
							qry=qry+" and A.subsectioncode in ("+mSubsection+")";
						}
						qry=qry+" and A.sectionbranch=decode('"+mSection+"','ALL',A.sectionbranch,'"+mSection+"')";
						qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"' AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='"+mLTP+"' ";
						if(mSubsection.equals("ALL"))
						{
							qry=qry+" and A.subsectioncode=decode('"+mSubsection+"','ALL',A.subsectioncode,'"+mSubsection+"') ";
						}
						else
						{
							qry=qry+" and A.subsectioncode in ("+mSubsection+")";
						}
						qry=qry+" and AA.sectionbranch=decode('"+mSection+"','ALL',AA.sectionbranch,'"+mSection+"'))";
						qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))) ORDER BY CLASSTIMEFROM DESC";
						qry=qry+" ) WHERE ROWNUM<='"+mRowNum+"' ORDER BY CLASSTIMEFROM";
						rsRowNum=db.getRowset(qry);
						//out.print(qry);
						while(rsRowNum.next())
						{
							qry="Select decode(PRESENT,'N','<Font Color=red face=arial><B>A</B></Font>','Y','<Font Color=Green face=arial><B>P</B></Font>') Attendance from studentattendance where studentid='"+rs1.getString("studentid")+"' and to_char(ATTENDANCEDATE,'dd-mm-yyyy')='"+rsRowNum.getString("ATTDATE")+"'";
							qry=qry+" and fstid in (Select A.fstid from facultysubjecttagging A where A.INSTITUTECODE='"+mInst+"' and A.COMPANYCODE='"+mComp+"' and A.EXAMCODE='"+mExam+"' and A.SubjectID='"+mSubject+"' and A.LTP='"+mLTP+"'";
							qry=qry+" and A.FSTID in ((select AA.FSTID from FACULTYSUBJECTTAGGING AA WHERE AA.INSTITUTECODE='"+mInst+"' and AA.COMPANYCODE='"+mComp+"' AND AA.EMPLOYEEID='"+mDMemberID+"' and AA.EXAMCODE='"+mExam+"' and AA.SubjectID='"+mSubject+"' and AA.LTP='"+mLTP+"')";
							qry=qry+" UNION (Select B.FSTID from Multifacultysubjecttagging B where B.INSTITUTECODE='"+mInst+"' and B.COMPANYCODE='"+mComp+"' and A.FSTID=B.FSTID))) ORDER BY CLASSTIMEFROM DESC";
							rsAtt=db.getRowset(qry);
							//out.print(qry);
							if(rsAtt.next())
							{
								%>
								<td nowrap align=center><b><%=rsAtt.getString("Attendance")%></b></td>
								<%
							}
							else
							{
								%>
								<td nowrap align=center><b>-</b></td>
								<%
							}
						}
						%>
						</tr>
						<input type=hidden name=<%=mName3%> ID=<%=mName3%> value='<%=rs1.getString("Fstid")%>'>
						<input type=hidden name=<%=mName4%> ID=<%=mName4%> value='<%=rs1.getString("studentid")%>'>
						<input type=hidden name=<%=mName5%> ID=<%=mName5%> value='<%=rs1.getString("employeeid")%>'>
						<input type=hidden name=<%=mName6%> ID=<%=mName6%> value='<%=mRollno%>'>
						<input type=hidden name=<%=mName7%> ID=<%=mName7%> value='<%=Ctr%>'>
						<%          						
					}
						
				}// closing of time 
				else
				{
					out.print("<br><img src='../../Images/Error1.jpg'>");
					out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");
				}
			}
			else
			{
				out.print("<br><img src='../../Images/Error1.jpg'>");
				out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Invalid time format. </font> <br><br>");	
			}
		} // closing of Global Validate
		else
		{
			out.print("<br><img src='../../Images/Error1.jpg'>");
			out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Valid Date Format is DD-MM-YYYY only error in time</font> <br><br>");
	     }
	} // Date Checking if it exceeds beyond the sysdate
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print("&nbsp; <b><font size=3 face='Arial' color='Red'> Sorry ! &nbsp; Future Date Attendance is not allowed...</font> <br><br>");
	}
	%>	
	<td><Input Type=hidden name=INSTITUTE ID=INSTITUTE Value='<%=mInstitute%>'></td>
	<td><input type=hidden name=ADATE ID=ADATE value='<%=mDate%>'></td>
	<td><input type=hidden name=ATYPE ID=ATYPE value='<%=mType%>'></td>
	<td><input type=hidden name=TotalRec ID=TotalRec value='<%=Ctr%>'></td>
	<td><input type=hidden name=Timefrom ID=Timefrom value='<%=mDTfrom%>'></td>
	<td><input type=hidden name=Timeupto ID=Timeupto value='<%=mDTupto%>'>
	
	
	<input type=hidden name=mDTExtrafrom ID=mDTExtrafrom value='<%=mDTExtrafrom%>'>
	<input type=hidden name=mDTExtraupto ID=mDTExtraupto value='<%=mDTExtraupto%>'>
	</td>
	</tbody>
	</table>
	<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["Number", "Number", "CaseInsensitiveString"]);
	</script>
	<table align=center bgcolor=white width=90% cellmargin=0 bottommargin=0 border=1>
	<tr>
	<td align=middle><font color=blue face=arial size=3><b>Total Student(s) - <%=Ctr%></b></font>&nbsp; &nbsp;<input type=submit value="Save Attendance"></td>
	</tr>
	</table>
	<font color=green><b>&nbsp; &nbsp; &nbsp; &nbsp; # Once you submit the attendance, you can further Edit the same.</b></font>
	</form>
	<%
		} // subsection not null
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print("&nbsp; <b><font size=3 face='Arial' color='Red'>Please select Sub Section .</font> <br><br>");
	}
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
	 //out.print("error");	
}
%>
</body>
</html>