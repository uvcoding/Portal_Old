<%@ page  buffer="10kb" autoFlush="true"  language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rsd=null;
String qry="";
String DSC="",DSC1="";
String mWebEmail="";
String mMemberID="";
String mMemberType="";
String mMemberName="";
String mMemberCode="";
String mDMemberType="";
String mDMemberCode="";
String mDMemberID="";
String mInst="";
String mDSheet="";
String mDatesheet="";
String mSubject="";
String msubject="";
String mSubj="";
String mDCode="";
String mDcode="";
String mDataCode="";
String moldDate="";
String mSc="";
int ctr=0;
int mRights=0;
String Heading="";
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

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
   mHead=session.getAttribute("PageHeading").toString().trim();
else
   mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Student Reaction Survey detailed report ] </TITLE>


<script language="JavaScript" type ="text/javascript">

<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5   rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%	
try{
OLTEncryption enc=new OLTEncryption();
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
{
	mDMemberType=enc.decode(mMemberType);
	mDMemberCode=enc.decode(mMemberCode);
	mDMemberID=enc.decode(mMemberID);

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress =session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
	ResultSet RsChk=null;
	
	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
		

	qry="Select WEBKIOSK.ShowLink('36','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {

	%>
	<form name="frm"  method="get" >
	<input id="x" name="x" type=hidden>
	<table width='100%' ALIGN=CENTER bottommargin=0  topmargin=0>
	<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Seating Plan View By Students
	</font></td></tr>
	</TABLE>
	<table align=center bottommargin=0 rules=groups topmargin=0,cellspacing=0 cellpadding=0>
   

	<!--************Institute*************-->
	<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
	<%
	qry="select WEBKIOSK.GetSeatingPlanCodes('"+mInst+"') DS from dual ";

	rsd=db.getRowset(qry);
	if (rsd.next() && !rsd.getString("DS").equals("N"))
	{
		DSC=rsd.getString("DS");	
		//out.print(DSC);	
		int len=0;
		int pos1=0;
		DSC=rsd.getString("DS")	;	
		len=DSC.length();
		pos1=DSC.indexOf(")");
		DSC1=DSC.substring(0,pos1+1)+"'";	
	//out.print(DSC1 +" - "+DSC);

	//'2008ODDSEM(2008ODDSEM)-2008ODDT1'
//"+DSC+"
	
	%>
 <!--*********Datesheet Code*************-->
 <tr>
<td nowrap>
<td><font face=arial size=2><b>DateSheet Code :</b></font></td>
 <input type="text" id="sample" value="Hello!">
  <%
 try{
    qry="select distinct EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE dscode from V#CENTREWISEROOMALLOCATION where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in (select EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE from SEATINGPLAN where ";
    qry=qry+" EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in ("+DSC+") and nvl(Status,'N')='F') ";	
    rs=db.getRowset(qry);	
	//out.print(qry);
	%>
	 <select name=DScode tabindex="0" id="DScode">
	<%
    if (request.getParameter("x")==null)				
   {
	while(rs.next())
	{
        mDataCode=rs.getString("dscode"); 
	  if(mDcode.equals(""))	
	   mDcode=mDataCode;
       %>
 <option value=<%=mDataCode%>><%=mDataCode%></option>
	<%	 	
  	}
     } //closing of if
 else
 {
   while(rs.next())
 {
         mDataCode=rs.getString("dscode"); 
	  if(mDataCode.equals(request.getParameter("DScode").toString().trim()))
 {
  		mDcode=mDataCode;
%>
				<OPTION selected Value =<%=mDataCode%>><%=mDataCode%></option>
				<%			
		     	}
		     	else
		      {
				%>
		      	<OPTION Value =<%=mDataCode%>><%=mDataCode%></option>
		      	<%			
		   	}	
       }	//closing of while
   }	 //closing of else		
 %>
  </select>
<%
}
catch(Exception e)
{
//out.print("error"+qry);
}
%>
&nbsp; &nbsp;
</td>
<td align=center colspan=2 nowrap><input type='submit' value='Show/Refresh'></td></tr>
</table>
</form>
<table bgcolor=#fce9c5 class="sort-table" id="table-1" width='100%' bottommargin=0 rules=groups topmargin=0 cellspacing=0 cellpadding=0 border=2 align=center>	
<!--
<tr bgcolor="#ff8c00">
<td><b><font color="white">SNo.</font></b></td>
<td><b><font color="white">Date/Day</font></b></td>
<td><b><font color="white">Time</font></b></td>
<td align=center><b><font color="white">Course code</font></b></td>
<td><b><font color="white">Course Name</font></b></td>
</tr>
  -->
<%
	msubject="ALL";
	if(request.getParameter("x")!=null)
		mDcode=request.getParameter("DScode");     	
	else
	   	mDcode=mDcode;
 
/*	qry="select subjectID, subject||'('||SUBJECTCODE||')' SUBJECT ,examcentercode,to_char(DATETIME,'dd-mm-yyyy')||' At '||to_char(DATETIME,'hh:mi PM')DateTime,";
	qry=qry+" examcentername,roomdesc from V#CENTREWISEROOMALLOCATION where institutecode='"+mInst+"' and studentid='"+mDMemberID+"' and subjectID in ";
	qry=qry+" (Select subjectID from V#STUDENTLTPDETAIL where examcode ";
	qry=qry+" in(select examcode from datesheet ";
	qry=qry+" where EXAMCODE||'('||EXAMEVENTCODE||')' in ("+DSC1+") and nvl(Status,'N')='F') ";
	qry=qry+" )";
	qry=qry+" and EXAMCODE||'('||EXAMEVENTCODE||')-'||SPCODE in('"+mDcode+"') ";
	qry=qry+" and subjectID=decode('"+msubject+"','ALL',subjectID,'"+msubject+"') ";
 	qry=qry+" Order by DATETIME";*/

	
	
	qry="select A.subjectID, A.subject||'('||A.SUBJECTCODE||')' SUBJECT ,A.examcentercode,to_char(A.DATETIME,'dd-mm-yyyy')||' At '||to_char(A.DATETIME,'hh:mi PM')DateTime, A.examcentername,A.roomdesc,nvl(B.SEATNOX,'')SEATNOX,nvl(B.SEATNOY,'') SEATNOY,NVL(B.SHORTSEATNAME,' ')SHORTSEATNAME from V#CENTREWISEROOMALLOCATION A,SEATINGPLANALLOCATION B where A.institutecode='"+mInst+"' and A.studentid='"+mDMemberID+"' AND  A.EXAMCODE=B.EXAMCODE AND  A.EXAMEVENTCODE=B.EXAMEVENTCODE AND  A.ENROLLMENTNO=B.ENROLLMENTNO AND  A.INSTITUTECODE=B.INSTITUTECODE AND A.SPCODE=B.SPCODE AND  A.ROOMCODE=B.ROOMCODE AND A.DATETIME=B.DATETIME AND A.EXAMCENTERCODE=B.EXAMCENTERCODE and A.subjectID in  (Select subjectID from V#STUDENTLTPDETAIL where examcode in (select examcode from datesheet where EXAMCODE||'('||EXAMEVENTCODE||')' in ("+DSC1+") and nvl(Status,'N')='F') ) and A.EXAMCODE||'('||A.EXAMEVENTCODE||')-'||A.SPCODE in('"+mDcode+"') and A.subjectID=decode('"+msubject+"','ALL',A.subjectID,'"+msubject+"') Order by A.DATETIME  ";
	
	//out.println(qry);

	rs=db.getRowset(qry);
	ctr=0;
	while(rs.next())
	{
		moldDate=rs.getString("DateTime");	
		if(!mSc.equals(rs.getString("subjectID")))
		{
 		  mSc=rs.getString("subjectID");
		%>
		<tr><td colspan=3><font color=DarkBlue><STRONG>Paper ID : <%=rs.getString("subject")%></STRONG></font></td>
		<td colspan=3><font color=DarkBlue><STRONG>Date : <%=moldDate%></STRONG></font></td>
		</tr>
		<tr>
		 
		<td><b>Exam Center Name</b></td>
	
		<td><b>Room Name</b></td> 	

		<td><b>ROW NO </b></td> 	

		<td><b>COLOUMNO </b></td> 			
	
		<td><b>Seat No.</b></td> 	
	
	</tr>
	<%
		}
	%>
		<tr>
		 
		<td><%=rs.getString("examcentername")%></td>
	
		<td><%=rs.getString("roomdesc")%></td>

		<td><%=rs.getString("SEATNOX")%></td>

		<td><%=rs.getString("SEATNOY")%></td>

		<td><%=rs.getString("SHORTSEATNAME")%></td>
		</tr>
	 <%	
       } // closing of while
 %>
	</table>
	<BR>
	<!-- <left><FONT size=3 face=arial COLOR=RED><B>Note:-</B></FONT></left>
	<br><br>
	<left><FONT size=2 face=arial><B>1. In case of any variation observed, please mail back to jiiterp@jiit.ac.in and contact ERP Personnel in booths next to LT-1 not later than 25 August forenoon.</B></FONT></left>
	<BR>
	<left><FONT size=2 face=arial><B>2. Must recheck the final seating plan and date sheet on 25th August 2008 after 5:00 P.M.</B></FONT></lEFT> -->
<%

	}  // closing of ds code
//----------------------
//-security link
//----------------------
 
 } // closing of Webkiosk Showlink if
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
 }  //closing of Session if 
 else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
} // closing of outer try
catch(Exception e)
{
//out.print("error"+qry);
}      
%>

</body>
</html>
