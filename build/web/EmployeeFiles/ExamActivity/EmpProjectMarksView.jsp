<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<!--<%=request.getContextPath()%>-->
<%
try
{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
<head>
<TITLE>#### <%=mHead%> [ Event-Wise Project Marks Entry ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />



<script language="javascript">
function kH(e)
{
	var pK = document.all? window.event.keyCode:e.which;
	return pK != 13;
}

document.onkeypress = kH;
if (document.layers) document.captureEvents(Event.KEYPRESS);
</script>

<script language=javascript>

function RefreshContents()
{
    document.frm.x.value='ddd';
    document.frm.submit();
}
function Marks_Check(objtxt,objprevtxt,mMax,preventby,currentby)
{
	var TotCtr=document.frm1.TotalCount.value;
	var ChkID=document.frm1.ChkID.value;
	var DualMarks=document.frm1.DualMarks.value;
	//alert('Dual Marks - '+DualMarks);
	//alert(document.frm1.TotalCount.value);
	for(i=1;i<=TotCtr;i++)
	{
		mName7="EntByT1"+i;
		mName8="EntByT2"+i;
		//alert(document.frm1[mName7].value)
		//alert(document.frm1[mName8].value)
	}
	var prevVal=objprevtxt.value;
	var currVal=objtxt.value;
	//alert(prevVal+' - '+currVal);
	if(DualMarks=='Y')
	{
	if(objprevtxt.value!='' && objprevtxt.value.length>0)
	{
		if(objprevtxt.value.toUpperCase()=='A' && objtxt.value.toUpperCase()!='A')
		{
			alert('Invalid Marks!');
			alert('If first marks is A(Absent) then second marks must be A(Absent)');
			objtxt.value='';
			objtxt.focus;
		}
		else if(objprevtxt.value.toUpperCase()=='D' && objtxt.value.toUpperCase()!='D')
		{
			alert('Invalid Marks!');
			alert('If first marks is D(Detained) then second marks must be D(Detained)');
			objtxt.value='';
			objtxt.focus;
		}
		else if(objprevtxt.value>=0 && (objtxt.value.toUpperCase()=='D' || objtxt.value.toUpperCase()=='A'))
		{
			alert('Invalid Marks!');
			alert('If first marks is numeric then second marks must be numeric only');
			objtxt.value='';
			objtxt.focus;
		}
	}
	if(objtxt.value=='A' || objtxt.value=='D' || objtxt.value=='a' || objtxt.value=='d')
	{
		//alert('Valid Marks!');
		objtxt.value=objtxt.value.toUpperCase();
	  	objtxt.focus;

		if(preventby.value!=null && preventby.value==ChkID)
		{
			alert('Both marks can not be entered by same faculty');
			objtxt.value='';
			objtxt.focus;
		}
		else
		{
			objtxt.focus;
		}
		if((preventby.value=='' && currentby.value=='') && (objprevtxt.value!='' && objprevtxt.value.length>0))
		{
			alert('Both marks can not be entered by same faculty');
			objtxt.value='';
			objtxt.focus;
		}
	}
	else if(objtxt.value!='' && objtxt.value.length>0)
	{
	 	var entry=objtxt.value;
		if(parseFloat(entry)>=0)
		{
			if(objtxt.value>mMax)
			{
				alert('Marks Must be <='+mMax);
				objtxt.value='';
				objtxt.focus;
			}
		 	else if(objtxt.value<=mMax)
			{
				if(preventby.value!=null && preventby.value==ChkID)
				{
					alert('Both marks can not be entered by same faculty');
					objtxt.value='';
					objtxt.focus;
				}
				else
				{
					objtxt.focus;
				}
				if((preventby.value=='' && currentby.value=='') && (objprevtxt.value!='' && objprevtxt.value.length>0))
				{
					alert('Both marks can not be entered by same faculty');
					objtxt.value='';
					objtxt.focus;
				}
			}
			else
			{
				alert('Invalid Marks!');
				objtxt.value='';
		  		objtxt.focus;
			}
		}
		else
		{
			alert('Invalid Marks!');
			objtxt.value='';
		  	objtxt.focus;
		}
	}
	}
	else
	{
	//alert('Dual Marks - '+DualMarks);
	if(objtxt.value=='A' || objtxt.value=='D' || objtxt.value=='a' || objtxt.value=='d')
	{
		//alert('Valid Marks!');
		objtxt.value=objtxt.value.toUpperCase();
		objprevtxt.value=objtxt.value;
	  	objtxt.focus;
	}
	else if(objtxt.value!='' && objtxt.value.length>0)
	{
	 	var entry=objtxt.value;
		if(parseFloat(entry)>=0)
		{
			if(objtxt.value>mMax)
			{
				alert('Marks Must be <='+mMax);
				objprevtxt.value='';
				objtxt.value='';
				objtxt.focus;
			}
		 	else if(objtxt.value<=mMax)
			{
				objprevtxt.value=objtxt.value;
				objtxt.focus;
			}
			else
			{
				alert('Invalid Marks!');
				objprevtxt.value='';
				objtxt.value='';
		  		objtxt.focus;
			}
		}
		else
		{
			alert('Invalid Marks!');
			objprevtxt.value='';
			objtxt.value='';
		  	objtxt.focus;
		}
	}
	}
}
function showAlert()
{
	if(document.frm1("Proceed").checked==true)
	{
		alert('Once You will check to Lock, You cannot enter marks of the rest students further');
	}
	else
	{
		alert('You can not proceed for Grade Entry until you check and Lock it.');
	}
}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onkeydown="if(event.keyCode==13){event.keyCode=9;return event.keyCode}">
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rsse=null;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDeptCode="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExamid="",mEventsubevent="",mSubj="";
String qry="",x="";
int msno=0, len =0, pos=0;
String mSE="", mSPMarks1="", mSPMarks2="", mSPMarks1By="", mSPMarks2By="", mSPMarks1ByID="", mSPMarks2ByID="";
double mAvgMarks=0, mWeight=0, mMaxmarks=0,MyMax=0;
int ctr=0, mGroupID=1;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="", mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null;
String mDualMarks="",mMOP="",mlistorder="",mctr="",qrys="",mSelf="S";
String mName1="",mName2="",mName3="",mName4="",mName5="", mName6="", mName7="", mName8="",mLoginComp="";
String cccc="",pro="",sub="",QryExam="",QryEventSubevent="";
String 	mSelf1="N";
int 			mFlag=0;
session.setAttribute("Click",mSelf);

if (session.getAttribute("Designation")==null)
{
	mDesg="";
}
else
{
	mDesg=session.getAttribute("Designation").toString().trim();
}

if (session.getAttribute("DepartmentCode")==null)
{
	mDeptCode="";
}
else
{
	mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
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


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}


	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;

	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

		qry="Select WEBKIOSK.ShowLink('60','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		{
	  //----------------------
	 
		%>
		<form name="frm" method="post" >
		<input id="x" name="x" type=hidden>
		<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
		<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B>Event/Sub Event wise Project Marks View</B></font></TD></tr>
		</TABLE>

                <table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
                <tr><td><font color=Green face=arial size=2><STRONG><%=mMemberName%>[<%=mDMemberCode%>]
                &nbsp;&nbsp; : &nbsp;<%=GlobalFunctions.toTtitleCase(mDesg)%>&nbsp; (<%=GlobalFunctions.toTtitleCase(mDept)%>)
                </td></tr>
                <!--Institute****-->
                <tr><td><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT></FONT>
                <%
                try
                {
                    qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster Where InstituteCode='"+mInst+"' and nvl(Deactive,'N')='N' ";
					//out.print(qry);
                    rs=db.getRowset(qry);
                    if (request.getParameter("x")==null)
                    {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(""))
                                minst=mInst;
                            %>
                            <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                            <%
                        }
                        %>
                        </select>
                        <%
                     }
                     else
                     {
                        %>
                        <select name=InstCode tabindex="1" id="InstCode" style="WIDTH: 80px">
                        <%
                        while(rs.next())
                        {
                            mInst=rs.getString("InstCode");
                            if(mInst.equals(request.getParameter("InstCode").toString().trim()))
                            {
                                %>
                                <OPTION selected Value =<%=mInst%>><%=mInst%></option>
                                <%
                            }
                            else
                            {
                                %>
                                <OPTION Value =<%=mInst%>><%=mInst%></option>
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
                    //out.println(e.getMessage());
                }
                %>
                <!--*********Exam**********-->
                &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
                <%
                    try
                    {
                        qry="Select distinct NVL(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='"+mInst+"' And CompanyCode='"+mLoginComp+"'";

						//out.print(qry);
                        rs=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
								QryExam=mExamid;
                                %>
                                <OPTION Value =<%=mExamid%>><%=mExamid%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name=Exam tabindex="2" id="Exam" style="WIDTH: 229px">
                            <OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
                            <%
                            while(rs.next())
                            {
                                mExamid=rs.getString("GRADEENTRYEXAMID");
								QryExam=mExamid;
                                if(mExamid.equals(request.getParameter("Exam").toString().trim()))
                                {
                                    %>
                                    <OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value =<%=mExamid%>><%=mExamid%></option>
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
                        //out.println(e.getMessage());
                    }
                    %>
                    &nbsp;&nbsp;<FONT color=black><FONT face=Arial size=2><STRONG>Event-Subevent</STRONG></FONT></FONT>
                    <%
                    try
                    {
                      

					qry="select distinct A.EVENTSUBEVENT EVENTSUBEVENT from v#eXAMEVENTSUBJECTTAGGING  A where ";
	qry+=" (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND ( ( LTP='P' or LTP='E') and  NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
      qry=qry+" ) and A.examcode='"+QryExam+"'  AND (( A.LTP='P' or A.LTP='E') and NVL(a.projectsubject, 'N') = 'Y') order by eventsubevent";
	//  out.print(qry);
                        rse=db.getRowset(qry);

                        if (request.getParameter("x")==null)
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION selected Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
								QryEventSubevent=mEventsubevent;
                                %>
                                <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                <%
                            }
                            %>
                            </select>
                            <%
                        }
                        else
                        {
                            %>
                            <select name="Event" tabindex="3" id="Event" style="WIDTH: 215px">
                            <OPTION Value="NONE"><b><-- Select an Event-Subevent --></b></option>
                            <%
                            while(rse.next())
                            {
                                mEventsubevent=rse.getString("EVENTSUBEVENT").toString().trim();
                                if(mEventsubevent.equals(request.getParameter("Event").toString().trim()))
                                {
									QryEventSubevent=mEventsubevent;
                                    %>
                                    <OPTION selected Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                                else
                                {
                                    %>
                                    <OPTION Value ="<%=mEventsubevent%>"><%=mEventsubevent%></option>
                                    <%
                                }
                            }
                            %>
                            </select>
                            <%
                        }
                        //out.println("Subevent"+mEventsubevent);
                    }
                    catch(Exception e)
                    {
                        //out.print("error");
                    }
                    %>
                    </td></tr>
                    <tr><td>
                    <!--SUBJECT**************-->
                    <FONT color=black><FONT face=Arial size=2><STRONG>Subject</STRONG></FONT></FONT>
                    <%
                    try
                    {
                  

					  qry="select distinct A.subject ||' ( '||A.subjectcode||' )' subject, A.subjectID from v#eXAMEVENTSUBJECTTAGGING  A where ";
	qry+=" (A.fstid) in ("; 
	qry+=" select AA.fstid from facultysubjecttagging AA where facultytype=decode('"+mDMemberType+"','E','I','E') and nvl(deactive,'N')='N' AND employeeid='"+mDMemberID+"'  AND ( ( LTP='P' or LTP='E') and  NVL(PROJECTSUBJECT,'N')='Y')";
	qry+=" UNION select AA.fstid from MultiFacultySubjectTagging aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.EMPLOYEEID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from Ex#SubjectGradeCoordinator aa where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.FACULTYID='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventProjectMarks1 aa where aa.MARKS1ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventProjectMarks2 aa where aa.MARKS2ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry+=" UNION select AA.fstid from StudentEventSubjectMarks aa where aa.ENTRYBY='"+mDMemberID+"' and aa.FSTID=a.FSTID AND NVL(AA.DEACTIVE,'N')='N'";
	qry=qry+" ) and eventsubevent='"+QryEventSubevent+"' and examcode='"+QryExam+"' and (( A.LTP='P' or A.LTP='E') and NVL (a.projectsubject, 'N') = 'Y') ";
	qry=qry+" GROUP BY A.subject ||' ( '||A.subjectcode||' )',A.subjectID ";
	qry=qry+" order by subject";
	//out.print(qry);
                        rss=db.getRowset(qry);
                        if (request.getParameter("x")==null)
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSC.equals(""))
                                        mSC=mSubj;
                                        %>
                                        <OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
                                        <%
                                }
                                %>
                                </select>
                                <%
                        }
                        else
                        {
                                %>
                                <select name=Subject tabindex="4" id="Subject" style="WIDTH: 400px">
                                <%
                                while(rss.next())
                                {
                                        mSubj=rss.getString("SubjectID");
                                        if(mSubj.equals(request.getParameter("Subject").toString().trim()))
                                        {
                                                mSC=mSubj;
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
                                %>
                                </select>
                                <%
                         }
                    }
                    catch(Exception e)
                    {
                    }
                    %>
                    
                  </td></tr>
				  <tr><td align=center><INPUT Type="submit" Value="Show/Refresh"></td></tr>
				  <input type=hidden name="Exam" value="<%=QryExam%>">
				  <input type=hidden name="Subject" value="<%=mSC%>">
				    <input type=hidden name="Event" value="<%=QryEventSubevent%>">
					 <input type=hidden name="CompanyCode" value="<%=mComp%>">
					
			</table>
			</form>


<%int  mCoord=0;
	  if (request.getParameter("x")!=null )
	{
		mInst=request.getParameter("InstCode").toString().trim();
		QryExam=request.getParameter("Exam").toString().trim();
		mSC=request.getParameter("Subject").toString().trim();
        QryEventSubevent=request.getParameter("Event").toString().trim();


            String qrycord="select AA.fstid from V#Ex#SubjectGradeCoordinator aa,facultysubjecttagging a where aa.INSTITUTECODE='"+mInst+"' and aa.COMPANYCODE='"+mComp+"' and aa.COORDINATORID='"+mDMemberID+"' and aa.FSTID=a.FSTID  and aa.institutecode=a.institutecode and a.examcode=aa.examcode and aa.examcode='"+QryExam+"' and aa.subjectid='"+mSC+"' and aa.subjectid=a.subjectid ";
             //out.print(qrycord);
           ResultSet rscord=db.getRowset(qrycord);
          if(rscord.next())
			{
			  mCoord=1;
%>
				<form name=frm2 method=post>
				<input type=hidden name="y">
				<input type=hidden name="x">
					  <input type=hidden name="Exam" value="<%=QryExam%>">
					 
				  <input type=hidden name="Subject" value="<%=mSC%>">
				    <input type=hidden name="Event" value="<%=QryEventSubevent%>">
					 <input type=hidden name="CompanyCode" value="<%=mComp%>">
					<table cellpadding=1 cellspacing=0 align=center rules=groups border=3>
				 <tr><td nowrap>
                    <%


                    String sel="";
                    if(request.getParameter("y")==null)
                    {
                        %>
                        <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                        &nbsp;
                        <INPUT TYPE="radio" NAME="Click" Value='All'>
                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                        <%
                    }
                    else
                    {
                        if(request.getParameter("Click")!=null)
                        {
                                if(request.getParameter("Click").equals("Self"))
                                {
                                        %>
                                        <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                        &nbsp;
                                        <INPUT TYPE="radio" NAME="Click" Value='All' >
                                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                        <%
                                }
                                else
                                {
                                        %>
                                        <INPUT TYPE="radio" NAME="Click" Value='Self'>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                        &nbsp;
                                        <INPUT TYPE="radio" NAME="Click" Value='All' checked>
                                        <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                        <%
                                }
                        }
                        else
                        {
                                %>
                                <INPUT TYPE="radio" NAME="Click" Value='Self' checked>
                                <FONT color=black><FONT face=Arial size=2><STRONG>Self Batch Marks Entry (By Individual Faculty)</STRONG></FONT>
                                &nbsp;
                                <INPUT TYPE="radio" NAME="Click" Value='All' checked>
                                <FONT color=black><FONT face=Arial size=2><STRONG>All Batches Marks Entry (By Course Coordinator)</STRONG></FONT>
                                <%
                        }
                }
                %>
				</td></tr>

			<input type=hidden name="Exam" value="<%=QryExam%>">
				  <input type=hidden name="Subject" value="<%=mSC%>">
				    <input type=hidden name="Event" value="<%=QryEventSubevent%>">
					 <input type=hidden name="Click" value="<%=request.getParameter("Click")%>">
					  <input type=hidden name="InstCode" value="<%=mInst%>">

                  <tr><td align=center><INPUT Type="submit" Value="Show/Refresh"></td></tr>
			</table>
			</form>
<%
			}
		else
		{
			mFlag=1;
		}
	
int tabctrtxt=7;
int tabctrchk=1000;

if(request.getParameter("y")!=null || mFlag==1)
{
	

	if(request.getParameter("Subject")!=null && request.getParameter("Event")!=null && request.getParameter("Exam")!=null)
      {
	
		mIC=request.getParameter("InstCode").toString().trim();
			
		mEC=request.getParameter("Exam").toString().trim();
		
		mSC=request.getParameter("Subject").toString().trim();
		
		
		mEvent=request.getParameter("Event").toString().trim();

		if(request.getParameter("Click")!=null)
			mSelf1=request.getParameter("Click");
		else
			mSelf1="N";

		//out.println(mEvent+"ssss");
		len=mEvent.length();
		pos=mEvent.indexOf("#");
		if(pos>0)
		{
			mSE=mEvent.substring(0,pos);
		}
		else
		{
			mSE=mEvent.toString().trim();
		}
		try
		{
		qrys="select nvl(detainedstatus,'A')detainedstatus from exameventmaster ";
		qrys=qrys+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' and  exameventcode='"+mSE+"' ";
	
		ResultSet rsStatus=db.getRowset(qrys);
		if(rsStatus.next())
		{
			mStatus=rsStatus.getString("detainedstatus");
		}
		}
		catch(Exception e)
		{
		}

		if(!mEC.equals("NONE") && !mEvent.equals("NONE"))
		{
           	qry="select DISTINCT nvl(DOUBLEENTRY,'Y')DOUBLEENTRY, WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
 		qry=qry+" where institutecode='"+mIC+"' and  examcode='"+mEC+"' ";
            qry=qry+" And EVENTSUBEVENT='"+mEvent+"'  ";
            qry=qry+" AND (( LTP='P' or LTP='E') and  PROJECTSUBJECT='Y') and subjectID='"+mSC+"' AND  NVL (deactive, 'N') = 'N'";
		//out.print(qry);
		rsm=db.getRowset(qry);
		if(rsm.next())
		{
			mDualMarks=rsm.getString("DOUBLEENTRY");
			mMOP=rsm.getString("MARKSORPERCENTAGE");
			mMaxmarks=rsm.getDouble("MAXMARKS");
			mWeight=rsm.getDouble("WEIGHTAGE");
		}

		if (mMOP.equals("M"))
			MyMax=mMaxmarks;
		else
			MyMax=100;

		%>
		<form name="frm1"  method="post" action="ProjMarksEntryAction.jsp">
		<input id="y" name="y" type=hidden>
					<input id="x" name="x" type=hidden>
					<input type=hidden name="Exam" value="<%=mEC%>">
				  <input type=hidden name="Subject" value="<%=mSC%>">
				    <input type=hidden name="Event" value="<%=mEvent%>">
					 <input type=hidden name="InstCode" value="<%=mIC%>">
					 <input type=hidden name="Click" value="<%=request.getParameter("Click")%>">
		<%
		//len=mEvent.length();
		//pos=mEvent.indexOf("#");
		//mExamevent=mEvent.substring(0,pos);
		//mExamsubevent=mEvent.substring(pos+1,len);
		try
		{
		//out.print(mSelf1+"sdffffffffffffffffffffffffffffffffff");
		if(mSelf1.equals("Self") || mSelf1.equals("N"))
	{ 

		/*qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+ " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and";
		qry=qry+" examcode='"+mEC+"' AND (LTP='E' and PROJECTSUBJECT='Y') and subjectID='"+mSC+"' ";
		qry=qry+" AND ((EMPLOYEEID IN (SELECT EMPLOYEEID FROM EMPLOYEEMASTER WHERE DEPARTMENTCODE='"+mDeptCode+"')) OR (fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
		qry=qry+" AND EVENTSUBEVENT='"+mEvent+"' and employeeid='"+mDMemberID+"' and NVL(LOCKED,'N')='Y' " ;
		qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";*/


		qry="select A.fstid fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry=qry+" nvl(A.enrollmentno,' ')EnrollNo,nvl(A.semester,0)semester,A.subsectioncode, ";
	qry=qry+ " nvl(a.programcode,' ')||' ('||nvl(a.SECTIONBRANCH,' ')||' - '|| a.subsectioncode||')' Course,nvl(a.PROJECTSUBJECT,'N')PROJECTSUBJECT  from v#eXAMEVENTSUBJECTTAGGING A  ";
	qry=qry+" where A.institutecode='"+mInst+"'  AND NVL(A.DEACTIVE,'N')='N'   and EVENTSUBEVENT='"+mEvent+"' And ";
	qry=qry+" A.examcode='"+mEC+"' ";
	//qry=qry+" AND ((EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) OR (fstid in (select fstid from MULTIFACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')))   
	qry=qry+"and A.facultytype=decode('"+mDMemberType+"','E','I','E') and ( A.PROJECTSUBJECT='Y' and ( A.LTP='P' or A.LTP='E')) and A.subjectID='"+mSC+"'  and a.fstid in (  SELECT aa.fstid FROM studenteventprojectmarks1 aa   WHERE aa.marks1entryby = '"+mDMemberID+"' and aa.STUDENTID=a.STUDENTID and aa.EVENTSUBEVENT='"+mEvent+"'   AND aa.fstid = a.fstid  AND NVL (aa.deactive, 'N') = 'N'   UNION     SELECT aa.fstid    FROM studenteventprojectmarks2 aa   WHERE aa.marks2entryby = '"+mDMemberID+"'  and aa.STUDENTID=a.STUDENTID and aa.EVENTSUBEVENT='"+mEvent+"'   AND aa.fstid = a.fstid    AND NVL (aa.deactive, 'N') = 'N'  UNION    SELECT aa.fstid   FROM studenteventsubjectmarks aa   WHERE aa.entryby ='"+mDMemberID+"'  and aa.STUDENTID=a.STUDENTID and aa.EVENTSUBEVENT='"+mEvent+"'    AND aa.fstid = a.fstid    AND NVL (aa.deactive, 'N') = 'N') ";
	qry=qry+" GROUP BY A.fstid,nvl(A.studentid,' '),nvl(A.studentname,' '), ";
	qry=qry+" nvl(A.enrollmentno,' '),nvl(A.semester,0),A.subsectioncode, ";
	qry=qry+ " nvl(A.programcode,' '),nvl(A.SECTIONBRANCH,' '),a.PROJECTSUBJECT " ;
	qry=qry+" order by EnrollNo  ";

	}
	else
	{

		
		
		
		/*qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+ " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#STUDENTEVENTSUBJECTMARKS ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and";
		qry=qry+" examcode='"+mEC+"' and NVL(LOCKED,'N')='Y' AND  (LTP='E' and PROJECTSUBJECT='Y') and subjectID='"+mSC+"' ";
		qry=qry+" AND facultytype=decode('"+mDMemberType+"','E','I','E')";
		 qry=qry+" AND EVENTSUBEVENT   ='"+mEvent+"' " ;
		qry=qry+" GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";

*/
		qry="select A.fstid fstid,nvl(A.studentid,' ')studentid,nvl(A.studentname,' ')studentname, ";
	qry=qry+" nvl(A.enrollmentno,' ')EnrollNo,nvl(A.semester,0)semester, ";
	qry=qry+ " nvl(a.programcode,' ')||' ('|| nvl(a.SECTIONBRANCH,' ')||' - '|| a.subsectioncode||')' Course,nvl(a.PROJECTSUBJECT,'N')PROJECTSUBJECT  from v#eXAMEVENTSUBJECTTAGGING A  ";
	qry=qry+" where A.institutecode='"+mInst+"'  AND NVL(A.DEACTIVE,'N')='N'  and EVENTSUBEVENT='"+mEvent+"' And A.facultytype=decode('"+mDMemberType+"','E','I','E') ";
	qry=qry+" and A.examcode='"+mEC+"'  and A.subjectID='"+mSC+"' and ( A.PROJECTSUBJECT='Y' and ( A.LTP='P' or A.LTP='E'))  and a.fstid in (  SELECT aa.fstid              FROM studenteventprojectmarks1 aa             WHERE  aa.fstid = a.fstid     and aa.EVENTSUBEVENT='"+mEvent+"' and aa.STUDENTID=a.STUDENTID         AND NVL (aa.deactive, 'N') = 'N'            UNION            SELECT aa.fstid              FROM studenteventprojectmarks2 aa             WHERE  aa.fstid = a.fstid     and aa.EVENTSUBEVENT='"+mEvent+"'   and aa.STUDENTID=a.STUDENTID           AND NVL (aa.deactive, 'N') = 'N'            UNION            SELECT aa.fstid              FROM studenteventsubjectmarks aa             WHERE  aa.fstid = a.fstid  and aa.EVENTSUBEVENT='"+mEvent+"'   and aa.STUDENTID=a.STUDENTID   AND NVL (aa.deactive, 'N') = 'N') ";
	qry=qry+" GROUP BY A.fstid,nvl(A.studentid,' '),nvl(A.studentname,' '), ";
	qry=qry+" nvl(A.enrollmentno,' '),nvl(A.semester,0),A.subsectioncode, ";
	qry=qry+ " nvl(A.programcode,' '),nvl(A.SECTIONBRANCH,' '),PROJECTSUBJECT " ;
	qry=qry+" order by EnrollNo ";
			}
		//out.print(qry);
		rs1=db.getRowset(qry);
		msno=0;
		ctr=0;


		while(rs1.next())
		{
			mSPMarks1ByID="";
			mSPMarks2ByID="";
			mSPMarks1By="";
			mSPMarks2By="";
			ctr++;
			if(ctr==1)
			{
				if(mMOP.equals("M"))
				{
					%>
					<CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
					&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=navy><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></FONT></CENTER>
					<%
				}
				else
				{
					%>
					<CENTER><FONT face=Arial size=2 color=navy><STRONG>Maximum Marks (Full Marks for Evaluation) : </STRONG><%=mMaxmarks%></FONT>
					&nbsp;&nbsp;&nbsp;<FONT face=Arial size=2 color=navy><STRONG>Weightage in Percentage : </STRONG><%=mWeight%></CENTER></FONT>
					<%
				}
				%>
					

				
				<style type="text/css">
				@media print 
				{
				input#btnPrint 
				{
					display: none;
				}
				}
				</style>
				<center><input type="button" id="btnPrint" onclick="window.print();" value="Print Page"/></center>
				
				<table bgcolor=#fce9c5 class="sort-table" id="table-1" cellspacing=0 cellpadding=0 width="98%" border=1 align=center>
				<thead>
				<tr bgcolor="#ff8c00">
				<tr bgcolor="#ff8c00" height=40px>
				<td align=center><b><font color=white face=arial size=2>SNo.</font></b></td>
				<td align=center><b><font color=white face=arial size=2>Enroll. No</font></b></td>
				<td align=left><b><font color=white face=arial size=2>Student Name</font></b></td>
				<td align=center title="Tutor/Teacher/Examiner-I Marks"><b><font color=white face=arial size=2 nowrap>Examiner-I<BR> Enter out of <%=mMaxmarks%><br><%=mEvent%></font></b></td>
				<td align=left title="Marks Entered By Tutor/Teacher/Examiner-I"><b><font color=white face=arial size=2>Name of Examiner-I</font></b></td>
				<%
				if(mDualMarks.equals("Y"))
				{
				%>
				<td align=center title="Tutor/Teacher/Examiner-II Marks"><b><font color=white face=arial size=2 nowrap>Examiner-II<BR>Enter out of <%=mMaxmarks%><br><%=mEvent%>	</font></b></td>
				<td align=left title="Marks Entered By Tutor/Teacher/Examiner-II"><b><font color=white face=arial size=2>Name of Examiner-II</font></b></td>
				<%
				}
				%>
				<!--<td align=left><b><font color=white face=arial size=2>Course (Section/Branch)<font></b></td>
				<td align=center><b><font color=white face=arial size=2>Sem.<font></b></td>-->
				<%
				qry="Select Distinct A.EventSubEvent, nvl(A.WEIGHTAGE,0)WEIGHTAGE, nvl(A.MAXMARKS,0)MAXMARKS, to_date(A.FROMDATE,'dd-mm-yyyy')FDate, to_date(A.TODATE,'dd-mm-yyyy')TDate from ExamEventSubjectTagging A Where A.FSTID IN (SELECT F.FSTID FROM FACULTYSUBJECTTAGGING F WHERE F.examcode='"+mEC+"' AND (( F.LTP='P' or F.LTP='E') and F.PROJECTSUBJECT='Y') and F.subjectID='"+mSC+"') AND A.FSTID IN (SELECT B.FSTID FROM STUDENTEVENTSUBJECTMARKS B WHERE NVL(B.LOCKED,'N')='Y' AND A.FSTID=B.FSTID AND A.EVENTSUBEVENT=B.EVENTSUBEVENT   ";
				if(mSelf1.equals("N"))
				{
				qry=qry+" and  b.entryby='"+mDMemberID+"' ";
				}
				qry=qry+" ) AND A.EVENTSUBEVENT NOT IN ('"+mEvent+"') ORDER BY weightage";
				
				/*qry=qry+" and A.FSTID IN (SELECT c.FSTID FROM studenteventprojectmarks1 c WHERE  A.FSTID=c.FSTID AND A.EVENTSUBEVENT=c.EVENTSUBEVENT) ";
				qry=qry+" and A.FSTID IN (SELECT d.FSTID FROM studenteventprojectmarks2 d WHERE  A.FSTID=d.FSTID AND A.EVENTSUBEVENT=d.EVENTSUBEVENT) ";
				qry=qry+" ORDER BY weightage ";
*/

				//out.print(qry);
				rs2=db.getRowset(qry);
				while(rs2.next())
				{
					
					cccc=rs2.getString("EventSubEvent");
					 pro=cccc.substring(0,cccc.indexOf("#"));
					sub=cccc.substring(cccc.indexOf("#"));

					%><td align=center nowrap><b><font color=white face=arial size=2><%=pro%><br><%=sub%><br> Marks <BR>Allotted<BR>out of <%=rs2.getString("MAXMARKS")%><font></b></td><%
				}
				%>
				</tr>
				</thead>
				<tbody>
				<%
			}
			//tabctrtxt++;
			//tabctrchk++;
			tabctrtxt=tabctrtxt+2;
			tabctrchk=tabctrchk+2;
			mctr=String.valueOf(ctr).trim();
		    	msno++;
			mName1="Semester"+String.valueOf(ctr).trim();
			mName2="Studentid"+String.valueOf(ctr).trim();
			mName3="Marks1"+String.valueOf(ctr).trim();
			mName4="Marks2"+String.valueOf(ctr).trim();
			mName5="Fstid"+String.valueOf(ctr).trim();
			mName7="EntByT1"+String.valueOf(ctr).trim();
			mName8="EntByT2"+String.valueOf(ctr).trim();
			%>
			<tr>
			<td align=right><%=msno%>.&nbsp; &nbsp; &nbsp; </td>
			<td><%=rs1.getString("EnrollNo")%></td>
			<td><%=rs1.getString("studentname").toUpperCase()%></td>
			<%

                qry="Select nvl(A.PROJMARKS1,-1)PROJMARKS1, nvl(A.PROJDETAINED1,'N') PROJDETAINED1, nvl(B.EMPLOYEENAME,' ')||' ['||nvl(B.EMPLOYEECODE,' ')||']' M1ENTRYBY, nvl(MARKS1ENTRYBY,' ')MARKS1ENTRYBY from STUDENTEVENTPROJECTMARKS1 A, V#STAFF B";
		    qry=qry+" where A.MARKS1ENTRYBY=B.EMPLOYEEID AND A.fstid='"+rs1.getString("fstid")+"' and A.EVENTSUBEVENT='"+mEvent+"' and A.STUDENTID='"+rs1.getString("studentid")+"' ";
			//out.print(qry);
			/*if(mSelf1.equals("N"))
				{
				qry=qry+" and  A.MARKS1ENTRYBY='"+mDMemberID+"' ";
				}*/
		    rs2=db.getRowset(qry);
                if(rs2.next())
                {
                    mSPMarks1 = rs2.getString("PROJMARKS1");
                    mSPMarks1ByID=rs2.getString("MARKS1ENTRYBY");
                    mSPMarks1By = rs2.getString("M1ENTRYBY");
                    if(mSPMarks1.equals("-1"))
                        mSPMarks1 = rs2.getString("PROJDETAINED1");
                        if(mSPMarks1.equals("N"))
                            mSPMarks1 = "";
                }
                else
                {
                    mSPMarks1 = "Not Entered";
                }
                qry="Select nvl(A.PROJMARKS2,-1)PROJMARKS2, nvl(A.PROJDETAINED2,'N') PROJDETAINED2, nvl(B.EMPLOYEENAME,' ')||' ['||nvl(B.EMPLOYEECODE,' ')||']' M2ENTRYBY, nvl(MARKS2ENTRYBY,' ')MARKS2ENTRYBY from STUDENTEVENTPROJECTMARKS2 A, V#STAFF B";
		    qry=qry+" where A.MARKS2ENTRYBY=B.EMPLOYEEID AND A.fstid='"+rs1.getString("fstid")+"' and A.EVENTSUBEVENT='"+mEvent+"' and A.STUDENTID='"+rs1.getString("studentid")+"' ";
			/*if(mSelf1.equals("N"))
				{
				qry=qry+" and  A.MARKS2ENTRYBY='"+mDMemberID+"' ";
				}*/
		    rs2=db.getRowset(qry);
		    //out.print(qry);
                if(rs2.next())
                {
                    mSPMarks2=rs2.getString("PROJMARKS2");
                    mSPMarks2ByID=rs2.getString("MARKS2ENTRYBY");
                    mSPMarks2By=rs2.getString("M2ENTRYBY");
                    if(mSPMarks2.equals("-1"))
                        mSPMarks2= rs2.getString("PROJDETAINED2");
                        if(mSPMarks2.equals("N"))
                            mSPMarks2 = "";
                }
                else
                {
                    mSPMarks2 = "Not Entered";
                }
		    if(mSPMarks1By.equals(""))
			mSPMarks1By="&nbsp;";
		    if(mSPMarks2By.equals(""))
			mSPMarks2By="&nbsp;";

		    %>
		    <input type=hidden name='<%=mName7%>' id='<%=mName7%>' value='<%=mSPMarks1ByID%>'>
		    <input type=hidden name='<%=mName8%>' id='<%=mName8%>' value='<%=mSPMarks2ByID%>'>
		    <%


//---------------------------------------------End of Proj Marks I & II--------------------------------------

		    x="";
		    if(mMOP.equals("P"))
		    x="%";
		    if(mSPMarks1ByID.equals("") || mSPMarks1ByID.equals(mChkMemID))
		    {
			%>
			<td align=center bgcolor="LightCyan"><%--<input tabindex="<%=tabctrtxt%>" type=text name='<%=mName3%>' id='<%=mName3%>' value="<%=mSPMarks1%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 onBlur="Marks_Check(<%=mName3%>,<%=mName4%>,<%=MyMax%>,<%=mName8%>,<%=mName7%>);"  ><%=x%>--%>&nbsp;<%=mSPMarks1%><%=x%></td>
			<td><font color="black"><%=mSPMarks1By%></font></td>
			<%
		    }
		    else
		    {
			%>
			<td align=center bgcolor="LightPink"><Font color=Red><!-- Marks Entered  -->
			<%
				 if(mCoord==1)
				{
				%>
				 <font color="black"><%=mSPMarks1%></Font> 
				<%
				}
				else
				{
					%>
					Invisible (entered by others)
					<%
				}
			
				%>
			<!-- <font color="black"><%=mSPMarks1%></Font> -->
			
			<input tabindex="<%=tabctrtxt%>" type=hidden name='<%=mName3%>' id='<%=mName3%>' value="<%=mSPMarks1%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 READONLY><font color="black"><%=x%></font></td>
			 <td><Font color=Red>Invisible (entered by others)  <!-- <%=mSPMarks1By%> --></Font></td> 
			<%
		    }
		    if(mSPMarks2ByID.equals("") || mSPMarks2ByID.equals(mChkMemID))
		    {
			if(mDualMarks.equals("N"))
			{
			%>
			<%--<input tabindex="<%=tabctrtxt%>" type=hidden name='<%=mName4%>' id='<%=mName4%>' value="<%=mSPMarks2%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"  ><%=mSPMarks2%><%=x%>--%>
			<%
			}
			else
			{
			%>
			<td align=center bgcolor="LightCyan"><%--<input tabindex="<%=tabctrtxt%>" type=text name='<%=mName4%>' id='<%=mName4%>' value="<%=mSPMarks2%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 onBlur="Marks_Check(<%=mName4%>,<%=mName3%>,<%=MyMax%>,<%=mName7%>,<%=mName8%>);"  ><%=x%>--%>&nbsp;<%=mSPMarks2%><%=x%></td>
			<td><font color="black"><%=mSPMarks2By%></font></td>
			<%
			}
		    }
		    else
		    {
			if(mDualMarks.equals("N"))
			{
			%>
			<%--<input tabindex="<%=tabctrtxt%>" type=hidden name='<%=mName4%>' id='<%=mName4%>' value="<%=mSPMarks2%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 READONLY><%=mSPMarks2%><%=x%>--%>
			<%
			}
			else
			{
			%>
			<td align=center bgcolor="LightPink"><Font color=Red><!-- Marks Entered --> 
			<%
				if(mCoord==1)
				{
				%>
				 <font color="black"><%=mSPMarks2%></Font> 
				<%
				}
				else
				{
					%>
					Invisible (entered by others)
					<%
				}
					%>
			<input tabindex="<%=tabctrtxt%>" type=hidden name='<%=mName4%>' id='<%=mName4%>' value="<%=mSPMarks2%>" style="WIDTH: 40px; height: 20px; text-align:right; width:35px; font-size:12px; color:black; font-weight:bold" maxlength=5 READONLY><font color="black"><%=x%></font></td>
			<td><Font color=Red>Invisible (entered by others)  <!-- <%=mSPMarks2By%> --></Font></td>
			<%
			}
		    }
		    %>
		    <!--<td><%=rs1.getString("Course")%></td>
		    <td align=center><%=rs1.getString("semester")%></td>-->
		    <%
			/*qry="Select Distinct A.EventSubEvent, nvl(A.WEIGHTAGE,0)WEIGHTAGE, to_date(A.FROMDATE,'dd-mm-yyyy')FDate, to_date(A.TODATE,'dd-mm-yyyy')TDate from ExamEventSubjectTagging A Where A.FSTID IN (SELECT F.FSTID FROM FACULTYSUBJECTTAGGING F WHERE F.examcode='"+mEC+"' AND F.LTP='E' AND F.PROJECTSUBJECT='Y' and F.subjectID='"+mSC+"') AND A.FSTID IN (SELECT B.FSTID FROM STUDENTEVENTSUBJECTMARKS B WHERE NVL(B.LOCKED,'N')='Y' AND A.FSTID=B.FSTID AND A.EVENTSUBEVENT=B.EVENTSUBEVENT) AND A.EVENTSUBEVENT NOT IN ('"+mEvent+"') ORDER BY weightage";*/

			
			qry="Select Distinct A.EventSubEvent, nvl(A.WEIGHTAGE,0)WEIGHTAGE, nvl(A.MAXMARKS,0)MAXMARKS, to_date(A.FROMDATE,'dd-mm-yyyy')FDate, to_date(A.TODATE,'dd-mm-yyyy')TDate from ExamEventSubjectTagging A Where A.FSTID IN (SELECT F.FSTID FROM FACULTYSUBJECTTAGGING F WHERE F.examcode='"+mEC+"' AND (( F.LTP='P' or F.LTP='E') and F.PROJECTSUBJECT='Y') and F.subjectID='"+mSC+"') AND A.FSTID IN (SELECT B.FSTID FROM STUDENTEVENTSUBJECTMARKS B WHERE NVL(B.LOCKED,'N')='Y' AND A.FSTID=B.FSTID AND A.EVENTSUBEVENT=B.EVENTSUBEVENT   ";
				if(mSelf1.equals("N"))
				{
				qry=qry+" and  b.entryby='"+mDMemberID+"' ";
				}
				qry=qry+" ) AND A.EVENTSUBEVENT NOT IN ('"+mEvent+"') ORDER BY weightage";

			//out.print(qry);
			rs2=db.getRowset(qry);
			while(rs2.next())	
			{
	                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
			    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
			    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
			    qry=qry+" EVENTSUBEVENT='"+rs2.getString("EventSubEvent")+"' and ";
			    qry=qry+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
				
				/*qry=" union Select nvl(PROJMARKS1,-1)MARKSAWARDED1,decode(nvl(PROJDETAINED1,' '),'D','Detained','M','Make Up','A','Absent',' ') DETAINED  from studenteventprojectmarks1 where   EVENTSUBEVENT='"+rs2.getString("EventSubEvent")+"'   AND NVL(DEACTIVE,'N')='N'  AND fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"'    union (Select nvl(PROJMARKS2,-1)MARKSAWARDED1,decode(nvl(PROJDETAINED2,' '),'D','Detained','M','Make Up','A','Absent',' ') DETAINED  from studenteventprojectmarks2 where   EVENTSUBEVENT='"+rs2.getString("EventSubEvent")+"'    AND NVL(DEACTIVE,'N')='N'  AND fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"')"	;
				*/
			    //out.print(qry);
			    rs3=db.getRowset(qry);
      	          if(rs3.next())
			    {
				if(rs3.getString("MARKSAWARDED1").equals("-1"))
				{
					%>
					<td align=center>&nbsp;</td>
					<%
				}
				else
				{
					%>
					<td align=center><%=rs3.getString("MARKSAWARDED1")%></td>
					<%
				}
			    }
			    else
			    {
				%>
				<td align=center>&nbsp;</td>
				<%
			    }
			}
		    %>
		    </tr>
		    <input type=hidden name='<%=mName1%>' id='<%=mName1%>' value='<%=rs1.getString("semester")%>'>
		    <input type=hidden name='<%=mName2%>' id='<%=mName2%>' value='<%=rs1.getString("studentid")%>'>
		    <input type=hidden name='<%=mName5%>' id='<%=mName5%>' value='<%=rs1.getString("fstid")%>'>
		    <%
		}

		%>
		</tbody>
		</table>
		<%
			if(ctr==0)
			{
				out.print("<center><font size=2 face=verdana color=red><b>No Rows Selected !</b></font><center>");
			}
	}
	catch(Exception e)
	{
		//out.print("error");
	}
	session.setAttribute("Click",mSelf);
	%>
	<table align=center>
	<tr><td colspan=5 align=center>
	<%--
	if(ctr>0)
	{
		%>
		<INPUT Type="submit"  tabindex="<%=tabctrtxt%>" Value="Save Marks"></td></tr>
		<%
	}
	else
	{
		out.print("<img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> One of the following possible errors occured :<br><br><font size=2 face='Verdana' color='Red'><li>Selected Event-Subevent is not tagged with this Subject !<LI>You are not authorized to proceed Project Marks Entry !<LI>It is locked and finalized for the selected Event-Subevent ! </font></font> <br>");
	}
	--%>
	</td></tr>
	<%--
	if(ctr>0)
	{
		%>
		<tr>
		<td align=left bgcolor=LightPink width=5%>&nbsp;&nbsp;&nbsp</td><td><font size=2 color="navy" face=arial><B>Read Only</B></Font></td>
      	<td align=center valign=top><font size=2 color="navy" face=arial><B> &nbsp; &nbsp; Enter 'A' - for Absent &nbsp; &nbsp; Enter 'D' - for Detained &nbsp; &nbsp; Enter Marks between '0' to '<%=mMaxmarks%>' &nbsp; &nbsp; </B></font></td>
		<td align=right bgcolor=LightCyan width=5%>&nbsp;&nbsp;&nbsp</td><td><font size=2 color="navy" face=arial><B>Editable</B></Font></td>
      	</tr>
		<%
	}
	--%>
	<table>
	<input type=hidden name='institute' id='institute' value="<%=mIC%>">
	<input type=hidden name='Exam' id='Exam' value="<%=mEC%>">
	<input type=hidden name='EventSubevent' id='EventSubevent' value="<%=mEvent%>">
	<input type=hidden name='TotalCount' id='TotalCount' value="<%=ctr%>">
     	<input type=hidden name='MaxMarks' id='MaxMarks' value="<%=mMaxmarks%>">
	<input type=hidden name='subjectcode' id='subjectcode' value="<%=mSC%>">
	<input type=hidden name='Marksorpercentage' id='Marksorpercentage' value="<%=mMOP%>">
	<input type=hidden name='Status' id='Status' value="<%=mStatus%>">
	<input type=hidden name='ChkID' id='ChkID' value="<%=mChkMemID%>">
	<input type=hidden name='DualMarks' id='DualMarks' value="<%=mDualMarks%>">
	</form>
	<%
	}
	else
      {
      	out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'><b><font size=3 face='Arial' color='Red'> Please select an Exam Code and Event-Subevent ! </font> <br>");
	}
	}
	else
	{
		out.print("<br><img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Mandatory items(Event,Subject,Exam.,etc.) must be entered. </font> <br>");

	}
	}

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
// out.print("aaaaaaaaaaaaa");
}
%>