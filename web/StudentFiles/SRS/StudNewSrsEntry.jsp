<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
try{
String mHead="",xLTP="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey Entry Screen ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script  language=javascript >
	function validate()
	{
		maxlength=250;
 		for (var i = 0; i < document.frm1.elements.length; i++) 
		{
 			var e = document.frm1.elements[i]; 
			if (e.type == 'textarea') 
			{ 
				if(e.value.length>=maxlength)
				{
					alert("Your comments must be 250 characters or less");
					e.focus();
					return false;
				}
 			} 
		}
		return true;
 	}

			
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
<body topmargin=0 rightmargin=0 leftmargin=1 bottommargin=0 bgcolor=#fce9c5>
<%
String myLTP="",mLTP1="", qryl="", mltp="", mName1="",mName2="",mName3="",mName4="",mName5="",mName6="";
String mEventCode="" ,mEventCode1="";
int mValue1=0, myValue=0,mValue2=0;
String mSubjID="",mSingleLTP="", mTextname="",memp="";
String x1="",y1="",z1="",p1="",s1="",e1="",f1="",t1="",ft="";
String mCmpcode="",memp1="",mfaculty="";
String mQC="";
String chk="";
String mSC="";
String rsr="";
String ra="";
String ass="";
String mEName="";
String mEmp1="";
String mLTP="";
String a="";
String qry="";
String mSU="";
String mSR="";
String mS="";
String msu="";
String msr="";
String ms="";
String mInst="";
String mMem="";
String mMemID="";
String mProg="";
String mName="";
String mBranch="";
String mSem="";
String mDMemID="";
String mDMem="";
String mDInst="";
String x="";
String v="";
String mSRSSubCode="";
String as="";
int mSNo=0;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs5=null;
ResultSet rs6=null;
ResultSet rsh=null;
ResultSet rsl=null,rshead=null,rse=null;
boolean mflag=false;
String mStart="";
String mUpto="";
String mRattingType="";
String mRequiredNa="";

DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();

/*
	' 
*************************************************************************************************
	' *												
	' * File Name:	StudNewSrsEntry.JSP		[For Students]					
	' * Author:		Rituraj
	' * Date:		24th Oct 2006								
	' * Version:	1.0								
	' * Description:	Displays Personal Info. of Students 					
*************************************************************************************************
*/


if (session.getAttribute("InstituteCode")==null)
{
    mInst="";
}
else
{
    mInst=session.getAttribute("InstituteCode").toString().trim();
}
if(session.getAttribute("MemberCode")==null)
{
	mMem="";	
}
else
{
	mMem=session.getAttribute("MemberCode").toString().trim();
}
if(session.getAttribute("MemberID")==null)
{
	mMemID="";	
}
else
{
	mMemID=session.getAttribute("MemberID").toString().trim();
}

if(session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}
if(session.getAttribute("MemberName")==null)
{
	mName="";
}
else
{
	mName=session.getAttribute("MemberName").toString().trim();
}
if(session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}
if(session.getAttribute("CurrentSem")==null)
{
	mSem="";
}
else
{
	mSem=session.getAttribute("CurrentSem").toString().trim();
}

try { 
if (session.getAttribute("MemberCode")!=null)
{ 
	OLTEncryption enc=new OLTEncryption();
	mDMemID=enc.decode(mMemID);
	mDMem=enc.decode(mMem);
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
	qry="Select WEBKIOSK.ShowLink('30','"+ mDMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------
	%> 
<table  ALIGN=CENTER bottommargin=0  topmargin=0 width="100%">
<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Student Reaction Survey</TD>
</font></td></tr>
</TABLE>

<table left align=0 cellpadding=1 cellspacing=0 align=center rules=groups width="100%"  border=1 >
<form name="frm" method=get>
<input id="x" name="x" type=hidden>

<tr><td colspan=4><FONT color=black face=Arial size=2><STRONG>Name :</STRONG>&nbsp;
&nbsp;<%=mName%>&nbsp;[<%=mDMem%>]</FONT> &nbsp; &nbsp; &nbsp;
<font color=black face=Arial size=2><STRONG>Programe-Branch :</STRONG>&nbsp;
&nbsp;<%=mProg%>-<%=mBranch%> &nbsp; &nbsp;<FONT color=black face=Arial size=2><STRONG>Semester :</strong></font>&nbsp;<%=mSem%></FONT></td> 
</tr> 
<tr><td COLSPAN=3><!-- <B>LTP:</B>&nbsp;<SELECT NAME="LTP" id="LTP">
	<OPTION VALUE="L" SELECTED>LECTURE/TUTORIAL</OPTION>
<OPTION VALUE="P"  >PRACTICAL</OPTION>
 
</SELECT> &nbsp; -->
<FONT color=black face=Arial size=2><STRONG>SRS for: </STRONG></FONT>
<%
//-----------------------------------
// choosing subject ,faculty, ltp 
//-----------------------------------

qry="SELECT Distinct nvl(S.SUBJECTID,' ') SUBJECTID , nvl(S.SUBJECT,' ') || ' ('||nvl(S.SUBJECTCODE,' ')||')' SUBJECT, EmployeeID,EmployeeName, LTP,FACULTYTYPE, ";
qry=qry+" to_char(S.EVENTFROM,'dd-mm-yy')EVENTFROM, to_char(S.EVENTTO,'dd-mm-yy')EVENTTO, ";
qry=qry+" nvl(S.SRSEVENTCODE,' ') SRSEVENTCODE  From V#SRSEvents S ";
qry=qry+" Where trunc(sysdate) between trunc(EVENTFROM) and trunc(EVENTTO) and nvl(S.DEACTIVE,'N')='N'";
qry=qry+" and ( fstid) ";
qry=qry+" In (select fstid from STUDENTLTPDETAIL SS where STUDENTID='"+mDMemID+"' ";
qry=qry+" and nvl(DEACTIVE,'N')='N' ) and not exists (select 'y' from srseventsuggestion sd";
qry=qry+" where sd.STUDENTID='"+mDMemID+"' AND SD.fstID=s.FSTID) ";
qry=qry+" and ( S.Fstid,s.srsEVENTcODE) IN (SELECT  SS1.Fstid,sS1.srsEVENTcODE from SRSEVENTS ss1 WHERE NVL(SS1.APPROVED,'N')='N' ";
qry=qry+" AND NVL(SS1.DEACTIVE,'N')='N')";
qry=qry+" and S.SRSEVENTCODE IN (select nvl(SRSEVENTCODE,' ')SRSEVENTCODE ";
qry=qry+" FROM SRSEVENTMASTER WHERE SRSCOMPLETED='N' AND SRSBROADCAST='Y')  Order by SRSEVENTCODE,Subject,EmployeeID";

//out.print(qry);
	rs3=db.getRowset(qry);
	%>	
	   <select  name=Subject tabindex="0" id="Subject" style="WIDTH: 580px">
	<% 
	if (request.getParameter("Subject")==null) 
	{
	   while(rs3.next())
		{	
//-----------------------------------
// for Merging LTP 
//-----------------------------------

			if(x1.equals(""))
			{
				x1=rs3.getString("srseventcode");
				y1=rs3.getString("SUBJECTID");
				z1=rs3.getString("Employeeid");
				p1="'"+rs3.getString("LTP")+"'";
				myLTP=rs3.getString("LTP");
				s1=rs3.getString("SUBJECT");
				e1=rs3.getString("Employeename");
				f1=rs3.getString("eventfrom");
				t1=rs3.getString("eventto");
				ft=rs3.getString("FACULTYTYPE");

			}	
			else if((!z1.equals(rs3.getString("employeeid")))||(!y1.equals(rs3.getString("SUBJECTID"))))
			{
							
					ms=y1+"***"+x1+"---"+z1+"///"+myLTP+"+++"+ft;	
			 %>
		<!--	<OPTION selected Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
		<OPTION selected Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option>

   			<%	
				x1=rs3.getString("srseventcode");
				y1=rs3.getString("SUBJECTID");
				z1=rs3.getString("Employeeid");
				p1="'"+rs3.getString("LTP")+"'";
				myLTP=rs3.getString("LTP");
				s1=rs3.getString("SUBJECT");
				e1=rs3.getString("Employeename");
				f1=rs3.getString("eventfrom");
				t1=rs3.getString("eventto");
				ft=rs3.getString("FACULTYTYPE");

			} 
			else
			{
				p1=p1+",'"+rs3.getString("LTP")+"'";
				myLTP=myLTP+rs3.getString("LTP");
			}
	 	}
			ms=y1+"***"+x1+"---"+z1+"///"+myLTP+"+++"+ft;
			if(ms.length()>12)
			{	
			 %>
		<!--	  <OPTION selected Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
			  <OPTION selected Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option>
   			<%	
	 		}
	}
	else
	 {
  
	    		while(rs3.next())
			{  
			
			if(x1.equals(""))
			{
				x1=rs3.getString("srseventcode");
				y1=rs3.getString("SUBJECTID");
				z1=rs3.getString("Employeeid");
				p1="'"+rs3.getString("LTP")+"'";
				myLTP=rs3.getString("LTP");
				s1=rs3.getString("SUBJECT");
				e1=rs3.getString("Employeename");
				f1=rs3.getString("eventfrom");
				t1=rs3.getString("eventto");
				ft=rs3.getString("FACULTYTYPE");
			}	
	else if((!z1.equals(rs3.getString("employeeid")))||(!y1.equals(rs3.getString("SUBJECTID"))))
		{
				ms=y1+"***"+x1+"---"+z1+"///"+myLTP+"+++"+ft;	
 				if(ms.equals(request.getParameter("Subject").toString().trim()))
 		    		{ 
			 %>
<!--			  <OPTION selected Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
<OPTION selected Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option>

   			<%	}
				else
				{ 
			 %>
	<!--		  <OPTION  Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
			  <OPTION  Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option>
   			<%	}

				x1=rs3.getString("srseventcode");
				y1=rs3.getString("SUBJECTID");
				z1=rs3.getString("Employeeid");
				p1="'"+rs3.getString("LTP")+"'";
				myLTP=rs3.getString("LTP");
				s1=rs3.getString("SUBJECT");
				e1=rs3.getString("Employeename");
				f1=rs3.getString("eventfrom");
				t1=rs3.getString("eventto");
				ft=rs3.getString("FACULTYTYPE");
			} 
			else
			{
				p1=p1+",'"+rs3.getString("LTP")+"'";
				myLTP=myLTP+rs3.getString("LTP");
			}
	     	     }   
			ms=y1+"***"+x1+"---"+z1+"///"+myLTP+"+++"+ft;	
 				if(ms.equals(request.getParameter("Subject").toString().trim()) && ms.length()>12)
 		    		{ 
			 %>
<!--			  <OPTION selected Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
			 <OPTION selected Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option>

  			<%	}
				else if(ms.length()>12)
				{ 
			 %>
			  <!-- <OPTION  Value =<%=ms%>><%=y1+"-"+s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> -->
			   <OPTION  Value =<%=ms%>><%=s1+"&nbsp;["+GlobalFunctions.getSortedLTPSQ(p1)+"] of "+GlobalFunctions.toTtitleCase(e1)+" [ Event "+ f1 +" to  " + t1+"]"%></option> 

   			<%	}

		   
	 }
     %>
	</select>
 
</TD></TR>
<tr>
 <td align=right><INPUT Type="submit" Value="Feedback">  </td> 
</tr>
<%    
	//-----------------
	// Find LTP facutlies
	//-----------------
	int pos=0,len=0,pos1=0,pos2=0,pos3=0;
	if(request.getParameter("Subject")!=null)
	{
//-----------------------------------
// bifracute ltp,empid,subject ID 
//-----------------------------------


//xLTP=request.getParameter("LTP").toString().trim();
		mEventCode1=request.getParameter("Subject").toString().trim();
		len=mEventCode1.length();
		pos=mEventCode1.indexOf("***");
		pos1=mEventCode1.indexOf("---");
		pos2=mEventCode1.indexOf("///");
		pos3=mEventCode1.indexOf("+++");	
		mSubjID=mEventCode1.substring(0,pos);
		mEventCode=mEventCode1.substring(pos+3,pos1);
		memp=mEventCode1.substring(pos1+3,pos2);
		mLTP=mEventCode1.substring(pos2+3,pos3);
		mfaculty=mEventCode1.substring(pos3+3,len);
if(mfaculty.equals("I"))
{			
qry="select WEBKIOSK.getMemberName('"+memp+"','E') from dual "; 
}
else if(mfaculty.equals("E"))
{
qry="select WEBKIOSK.getMemberName('"+memp+"','V') from dual "; 
}
rse=db.getRowset(qry);
rse.next();
memp1=rse.getString(1);
%>
<tr><td>
	
  	 <FONT color=black face=Arial size=2><STRONG>Rating for Faculty :&nbsp;</STRONG>&nbsp;<font color=#c00000><b><%=memp1%></b></font></FONT>
 <FONT color=black face=Arial size=2><STRONG>&nbsp;&nbsp;&nbsp;Feedback For :&nbsp;</STRONG>&nbsp;<font color=#c00000> <b><%=GlobalFunctions.getLTPDescWSQ(mLTP)%></b></font></FONT> </td>
<!-- <td align=right><INPUT Type="submit" Value="Feedback">  </td> -->
</tr>
</form>
</table>

<%	 



	if (request.getParameter("x")!=null )
	{
if(mLTP.equals("LT")){
xLTP="L";
}else if(mLTP.equals("T")){
xLTP="L";
}else if(mLTP.equals("L")){
xLTP="L";
}else if(mLTP.equals("P")){
xLTP="P";
}else{
xLTP=mLTP;

}
	
	
	
	//out.print(myLTP+"*************"+mLTP+"************************"+GlobalFunctions.getLTPDescWSQ(mLTP));
%>
		<table left align=0 cellpadding='1' cellspacing='0' align='center'  width="100%" rules='rows'  border='1'>
		<form name="frm1" method='post' action='StudNewSrsAction.jsp' onsubmit='return validate()'>
		<tr bgcolor="#c00000" ><td colspan=0><b><font color=White>SNo. SRS Description</font></td><td><strong><font color=White>Rating: 1=Lower&nbsp; 5=Higher</font></strong></td></tr>

<%		
      	qry="select nvl(A.SRSCODE,0)SRSCODE,nvl(B.SEQID,0)SEQID , LTP FROM LTPSRSTYPETAGGING A,SRSTYPEMASTER B WHERE '"+mLTP+"' like '%'||LTP||'%' ";
		qry=qry +" and A.INSTITUTECODE='"+mInst+"' and A.SRSEVENTCODE='"+mEventCode+"'  AND A.INSTITUTECODE=B.INSTITUTECODE AND A.SRSEVENTCODE=B.SRSEVENTCODE AND A.SRSCODE=B.SRSCODE AND NVL(A.DEACTIVE,'N')='N' AND NVL(B.DEACTIVE,'N')='N' ";
		qry=qry +" ORDER BY B.SEQID ";
		 // out.print(qry);
		rs2=db.getRowset(qry);
		long kk=0;
//-----------------------------------
// for geeting srscode
//-----------------------------------
		while(rs2.next())
		 {  
		        mSU=rs2.getString("SRSCODE");
 	  		  qry="select nvl(SRSSUBDESCRIPTION,' ')SRSSUBDESCRIPTION,nvl(SRSSUBCODE,0)SRSSUBCODE, ";
		        qry=qry +" NVL(SEQID,0)SEQID from SRSSUBTYPEMASTER where  institutecode='"+mInst+"' and SRSEVENTCODE='"+mEventCode+"' and srscode='"+mSU+"'  order by SEQID ";
			  rs4=db.getRowset(qry);
//-----------------------------------
// for getting srssubcode
//-----------------------------------
		 	  while(rs4.next())
	   	  	{
				int mFlag=0;
			     mSC=rs4.getString("SRSSUBCODE");	
		          qry="select nvl(SRSQUESTION,' ')SRSQUESTION, nvl(RATINGCODE,0)RATINGCODE,nvl(SRSQUESTIONCODE,0)SRSQUESTIONCODE,SEQID ";
			    qry=qry +" from SRSQUESTIONMASTER where  institutecode='"+mInst+"' and LTP='"+xLTP+"' and SRSEVENTCODE='"+mEventCode+"' and srscode='"+mSU+"' and srssubcode='"+mSC+"' ";
			    qry=qry +" and nvl(DEACTIVE,'N')='N' ORDER BY SEQID ";
		      //  out.println(qry);
		          rs5=db.getRowset(qry);
			    mSNo=0;
 				while(rs5.next())
	     		  {	
			 	kk++;	
	     		 	mSNo++;
			      ra=rs5.getString("ratingcode");
				mQC=rs5.getString("SRSQUESTIONCODE");
				if(mFlag==0)
			     {
%>
				<tr><td colspan=2><STRONG><%=rs4.getString("SRSSUBDESCRIPTION")%></STRONG></td></tr>
<%
				}
//--------------------------------------
// passing dynamic values to action page
//--------------------------------------
					mFlag=1;
			mName1="SRSCODE_"+String.valueOf(kk).trim();
			mName2="SRSSUBCODE_"+String.valueOf(kk).trim();
			mName3="Qno_"+String.valueOf(kk).trim();
			mName4="LTP_"+String.valueOf(kk).trim();
			mName5="RATINGVALUE_"+String.valueOf(kk).trim();  
			mName6="RATINGCODE_"+String.valueOf(kk).trim();  
			mSingleLTP=rs2.getString("LTP");

%>	
		<tr><td><%=mSNo%>.&nbsp;<%=rs5.getString(1)%></td> 
		<input type=hidden Name='<%=mName1%>' ID='<%=mName1%>' value=<%=mSU%>>
		<input type=hidden Name='<%=mName2%>' ID='<%=mName2%>' value=<%=mSC%>>
		<input type=hidden Name='<%=mName3%>' ID='<%=mName3%>' value=<%=mQC%>>
		<input type=hidden Name='<%=mName4%>' ID='<%=mName4%>' value=<%=mSingleLTP%>>
		<input type=hidden Name='<%=mName6%>' ID='<%=mName6%>' value=<%=ra%>>
		<td nowrap>
<%		
     			 qry="select nvl(RATINGCODE,0)RATINGCODE,nvl(RATINGTYPE,' ')RATINGTYPE,nvl(RATINGSTARTFROM,0)RATINGSTARTFROM, ";
			qry=qry +" nvl(RATINGENDUPTO,0)RATINGENDUPTO,nvl(REQUIREDNA,' ')REQUIREDNA , nvl(EVALUATIONFROM,RATINGSTARTFROM) EVALUATIONFROM, nvl(EVALUATIONUPTO,RATINGENDUPTO) EVALUATIONUPTO";
  			qry=qry +" from SRSRATINGMASTER where ratingcode='"+ra+"' ";
			rs6=db.getRowset(qry);
//-----------------------------------
// for gaeeting rating value
//-----------------------------------
			mValue1=0;
			mValue2=0;
			myValue=0;
				while(rs6.next())
			{
				mStart=rs6.getString("RATINGSTARTFROM");
				mUpto=rs6.getString("RATINGENDUPTO");
				mRattingType=rs6.getString("RATINGTYPE").trim();
				mRequiredNa=rs6.getString("REQUIREDNA").trim();
				mValue1=rs6.getInt("EVALUATIONFROM");
				mValue2=rs6.getInt("EVALUATIONUPTO");
				myValue=mValue1;
//-----------------------------------
// Dynamic printing of radio buttons 
//-----------------------------------
				if(mRattingType.equals("N"))
            	    {
		                for(int i=(Integer.parseInt(mStart));i<=(Integer.parseInt(mUpto));i++)
            	         {
                 			v=String.valueOf(i);
					%>
				       <INPUT id=<%=mName5%> type=radio name=<%=mName5%> value=<%=myValue%>><%=v%>
					<%
					myValue=myValue+1;
	          	         }		
   		 	     }
   					else if(mRattingType.equals("T"))
   			 	     {
			%>
  
						<INPUT id=<%=mName5%> type=radio name=<%=mName5%> value=<%=mValue2%>>Yes
					      <INPUT id=<%=mName5%> type=radio name=<%=mName5%> value=<%=mValue1%>>No
			<%
      				}

						if (mRequiredNa.equals("Y"))
					{
					%>
					      <INPUT id=<%=mName5%> type=radio name=<%=mName5%>  value=00 CHECKED>N/A
					<%
					 }
				
					%>
						</td>	</tr>
					<%
  		     			}
	      		} 
			   }
//-----------------------------------------
// for printing heading over comment block
//-----------------------------------------
			qry="SELECT LTP, HEADINGTEXT  FROM SRSLTPSUGGESTIONHEADING ";
			qry=qry +" where SRSCODEAFTERSUGGESTIONREQUIRED='"+rs2.getString("SRSCODE")+"' and LTP='"+rs2.getString("LTP")+"' and nvl(DEACTIVE,'N')='N' "; 
       		rshead=db.getRowset(qry);
			if(rshead.next())
			{
				 mTextname="TEXT"+rshead.getString("LTP"); 
			%>	
				<tr><td colspan=2><STRONG><%=rshead.getString("HEADINGTEXT")%>(Upto 250 chars.)</STRONG></td></tr>
				<tr><td colspan=2><TEXTAREA id=<%=mTextname%> name=<%=mTextname%> style="WIDTH: 645px; HEIGHT: 54px" rows=3 ></TEXTAREA></td></tr>
			<%
			}
	      } 

qry="select Distinct S.INSTITUTECODE ,nvl(S.SEMESTER,'')SEMESTER, S.COMPANYCODE,nvl(S.FACULTYTYPE,' ')FACULTYTYPE, ";
qry=qry+ " nvl(S.EMPLOYEEID,' ')EMPLOYEEID, nvl(S.EXAMCODE,' ')EXAMCODE,nvl(S.ACADEMICYEAR,' ')ACADEMICYEAR, ";
qry=qry+ " nvl(S.PROGRAMCODE,' ')PROGRAMCODE, nvl(S.TAGGINGFOR,' ')TAGGINGFOR, ";
qry=qry+ " nvl(S.SUBSECTIONCODE,' ')SUBSECTIONCODE,nvl(S.SEMESTERTYPE,' ')SEMESTERTYPE,nvl(S.SECTIONBRANCH,' ')SECTIONBRANCH, ";
qry=qry+ " nvl(S.BASKET,' ')BASKET from V#SRSEvents  S Where INSTITUTECODE='"+mInst+"' ";
qry=qry+ " and nvl(S.DEACTIVE,'N')='N' And fstid  In (select fstid from V#STUDENTLTPDETAIL SS ";
qry=qry+ " where STUDENTID='"+mDMemID+"' And SubjectID='"+mSubjID+"' and '"+mLTP+"' like '%'||LTP||'%' ";
qry=qry+ " and nvl(SS.DEACTIVE,'N')='N')  and nvl(S.APPROVED,'N')='N' and S.SRSEVENTCODE IN (select nvl(SRSEVENTCODE,' ')SRSEVENTCODE ";
qry=qry+ " FROM SRSEVENTMASTER sm WHERE SRSCOMPLETED='N' AND SRSBROADCAST='Y' and nvl(sm.Deactive,'N')='N') ";

/*
qry="select Distinct S.INSTITUTECODE , S.COMPANYCODE, nvl(S.FACULTYTYPE,' ')FACULTYTYPE, ";
qry=qry+ " nvl(S.EMPLOYEEID,' ')EMPLOYEEID, nvl(S.EXAMCODE,' ')EXAMCODE,nvl(S.ACADEMICYEAR,' ')ACADEMICYEAR, ";
qry=qry+ " nvl(S.PROGRAMCODE,' ')PROGRAMCODE, nvl(S.TAGGINGFOR,' ')TAGGINGFOR, ";
qry=qry+ " nvl(S.SUBSECTIONCODE,' ')SUBSECTIONCODE,nvl(S.SEMESTERTYPE,' ')SEMESTERTYPE,nvl(S.SECTIONBRANCH,' ')SECTIONBRANCH, ";
qry=qry+ " nvl(S.BASKET,' ')BASKET from V#SRSEvents  S Where INSTITUTECODE='"+mInst+"' ";
qry=qry+ " and nvl(S.DEACTIVE,'N')='N' And fstid  In (select fstid from V#STUDENTLTPDETAIL SS ";
qry=qry+ " where STUDENTID='"+mDMemID+"' And SubjectID='"+mSubjID+"' and '"+mLTP+"' like '%'||LTP||'%' ";
qry=qry+ " and nvl(SS.DEACTIVE,'N')='N')  and nvl(S.APPROVED,'N')='N' and S.SRSEVENTCODE IN (select nvl(SRSEVENTCODE,' ')SRSEVENTCODE ";
qry=qry+ " FROM SRSEVENTMASTER sm WHERE SRSCOMPLETED='N' AND SRSBROADCAST='Y' and nvl(sm.Deactive,'N')='N') ";
*/

			rsh=db.getRowset(qry);
			rsh.next();  
	%>		
		<input type=hidden ID=INSTITUTECODE NAME=INSTITUTECODE value=<%=mInst%>>
		<input type=hidden ID=COMPANYCODE NAME=COMPANYCODE value=<%=rsh.getString("COMPANYCODE")%>>
		<input type=hidden ID=FACULTYTYPE NAME=FACULTYTYPE value=<%=rsh.getString("FACULTYTYPE")%>>
		<input type=hidden ID=EMPLOYEEID NAME=EMPLOYEEID value=<%=rsh.getString("EMPLOYEEID") %>>
		<input type=hidden ID=SRSEVENTCODE NAME=SRSEVENTCODE value="<%=mEventCode%>">
		<input type=hidden ID=EXAMCODE NAME=EXAMCODE value=<%=rsh.getString("EXAMCODE")%>>
		<input type=hidden ID=ACADEMICYEAR NAME=ACADEMICYEAR value=<%=rsh.getString("ACADEMICYEAR")%>>
		<input type=hidden Name=PROGRAMCODE ID=PROGRAMCODE value=<%=mProg%>>
		<input type=hidden ID=TAGGINGFOR NAME=TAGGINGFOR value=<%=rsh.getString("TAGGINGFOR")%>>
		<input type=hidden Name=SECTIONBRANCH ID=SECTIONBRANCH value="<%=rsh.getString("SECTIONBRANCH")%>">
		<input type=hidden ID=SUBSECTIONCODE NAME=SUBSECTIONCODE value="<%=rsh.getString("SUBSECTIONCODE")%>">
		<input type=hidden ID=STUDENTID NAME=STUDENTID value="<%=mDMemID%>">
<!--	<input type=hidden Name=SEMESTER ID=SEMESTER value="<%=mSem%>"> -->
		<input type=hidden ID=SEMESTER NAME=SEMESTER value="<%=rsh.getString("SEMESTER")%>"> 
		<input type=hidden ID=SEMESTERTYPE NAME=SEMESTERTYPE value=<%=rsh.getString("SEMESTERTYPE")%>>
		<input type=hidden ID=BASKET NAME=BASKET value=<%=rsh.getString("BASKET")%>>
		<input type=hidden Name=SUBJECTID ID=SUBJECTID value=<%=mSubjID%>>
		<input type=hidden Name=TotalLTP ID=TotalLTP value=<%=mLTP%>>  
		<input type=hidden Name=TotalRec ID=TotalRec value=<%=kk%>> 
		<tr><td colspan=2 align=center><INPUT Type="submit" Value="Send Feedback"></td> </tr>
		</form>
		</table>

		

	<%
	
		  } // request.getrParameter("x")!=null

	   	} //request.getrParameter("subject")!=null
   	// }
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
	</font>
   <%
   }
	  //-----------------------------

 }
  else
	{
 %>
	<br>
	
	<br><img src='../../Images/Error1.jpg'>
	Session timeout! Please <a href="../../index.jsp">Login</a> to continue...
 <%
	}
}
catch (Exception e)
{
}
}
catch (Exception e)
{
out.print("Event completed");
}

 %>
<br>
</body>
</Html>