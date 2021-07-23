<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../CommonFiles/ExceptionHandler.jsp" %>  
<%  


/*
  ' **********************************************************************************************************
  ' *													   *
  ' * File Name:	FrameLeftStudent.JSP		[For Students]			   *
  ' * Author:		Ashok Kumar Singh 						         *
  ' * Date:		20fth Oct 2006	 							   *
  ' * Version:	1.0										   *	
  ' **********************************************************************************************************
*/


String qry="",qry1="";
String pInstCode="";
DBHandler db=new DBHandler();
OLTEncryption enc=new OLTEncryption();
ResultSet Rs =null,rs1=null,rs=null;
String mMemberID="", mMemberType="", mRole="",mIPAddress="", mDeptCode="",mComp="";
String mInst="";
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
		pInstCode="";
	}
	else
	{
		pInstCode=session.getAttribute("InstituteCode").toString().trim();
		mInst=pInstCode;
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
	if (session.getAttribute("ROLENAME")==null)
	{
		mRole="";
	}
	else
	{
		mRole=session.getAttribute("ROLENAME").toString().trim();
	}
	if (session.getAttribute("IPADD")==null)
	{
		mIPAddress="";
	}
	else
	{
		mIPAddress=session.getAttribute("IPADD").toString().trim();
	}
	if (session.getAttribute("DepartmentCode")==null)
	{
		mDeptCode="";
	}
	else
	{
		mDeptCode=session.getAttribute("DepartmentCode").toString().trim();
	}

//	out.print(mMemberID+"::PPP::"+mRole);
%>
<HTML>
<HEAD>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<style type="text/css">
<!--
BODY{
scrollbar-face-color:#fce9c5;
scrollbar-arrow-color:darkpink;
scrollbar-track-color:darkpink;
scrollbar-shadow-color:'';
scrollbar-highlight-color:'';
scrollbar-3dlight-color:'';
scrollbar-darkshadow-Color:'';
}
-->
</style>
<style type="text/css">
.menutitle{
cursor:pointer;
margin-bottom: 4px;
background-color:#fce9c5;
color:#c00000;
width:130px;
padding:1px;
text-align:Left;
font-weight:bold;
font: 1.0em Georgia, "Times New Roman", Times, serif;
/*/*/border:5px solid #FFCF83;/* */
}

.submenu
{
	margin-bottom: 0.5em;
}
</style>
<style type="text/css">
.menutitlee{
cursor:pointer;
margin-bottom: 4px;
background-color:white;
color:#c00000;
width:130px;
padding:1px;
text-align:Left;
font-weight:bold;
font: 1.0em Georgia, "Times New Roman", Times, serif;
/*/*/border:5px solid #FFCF83;/* */
}

.submenue
{
	margin-bottom: 0.5em;
}
</style>

<script type="text/javascript">

/***********************************************
* Switch Menu scriptby Martial B of http://getElementById.com/
* Modified by Dynamic Drive for format & NS4/IE4 compatibility
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var persistmenu="yes" //"yes" or "no". Make sure each SPAN content contains an incrementing ID starting at 1 (id="sub1", id="sub2", etc)
var persisttype="sitewide" //enter "sitewide" for menu to persist across site, "local" for this page only

if (document.getElementById){ //DynamicDrive.com change
document.write('<style type="text/css">\n')
document.write('.submenu{display: none;}\n')
document.write('</style>\n')
}
function SwitchMenu(obj)
{
	if(document.getElementById)
	{
		var el = document.getElementById(obj);
		var ar = document.getElementById("masterdiv").getElementsByTagName("span"); //DynamicDrive.com change
		if(el.style.display != "block")
		{
			 //DynamicDrive.com change
			for (var i=0; i<ar.length; i++)
			{
				if (ar[i].className=="submenu") //DynamicDrive.com change
				ar[i].style.display = "none";
			}
			el.style.display = "block";
		}
		else
		{
			el.style.display = "none";
		}
	}
}

function get_cookie(Name)
{ 
	var search = Name + "="
	var returnvalue = "";
	if (document.cookie.length > 0)
	{
		offset = document.cookie.indexOf(search)
		if (offset != -1)
		{ 
			offset += search.length
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length;
			returnvalue=unescape(document.cookie.substring(offset, end))
		}
	}
	return returnvalue;
}

function onloadfunction()
{
	if (persistmenu=="yes")
	{
		var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
		var cookievalue=get_cookie(cookiename)
		if (cookievalue!="")
			document.getElementById(cookievalue).style.display="block"
	}
}

function savemenustate()
{
	var inc=1, blockid=""
	while (document.getElementById("sub"+inc))
	{
		if (document.getElementById("sub"+inc).style.display=="block")
		{
			blockid="sub"+inc
			break
		}
		inc++
	}
	var cookiename=(persisttype=="sitewide")? "switchmenu" : window.location.pathname
	var cookievalue=(persisttype=="sitewide")? blockid+";path=/" : blockid
	document.cookie=cookiename+"="+cookievalue
}

if (window.addEventListener)
	window.addEventListener("load", onloadfunction, false)
else if (window.attachEvent)
	window.attachEvent("onload", onloadfunction)
else if (document.getElementById)
	window.onload=onloadfunction

if (persistmenu=="yes" && document.getElementById)
	window.onunload=savemenustate
</script>

<script language="Javascript1.1"> 	 
function UnLoadWindows()
{		
	alert("For better security you must close this window....");		
	top.close();
	window.open("../CommonFiles/SignOut.jsp");	 
} 
</script>
</HEAD>
<BODY vLink=#00000b link=#00000b bgcolor="#de6400" leftMargin=1 topMargin=0 marginheight="0" marginwidth="0" >
<%
if(!mMemberID.equals("") || !mMemberType.equals(""))
{

  //out.print(mMemberID+"SDDSDSD"+mRole);

	mMemberID=enc.decode(mMemberID);
	mMemberType=enc.decode(mMemberType);
	mRole=enc.decode(mRole);

//out.print(enc.encode(mRole));

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	ResultSet RsChk=null;
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------

	qry="Select WEBKIOSK.ShowLink('43','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
//out.print(qry);
      RsChk= db.getRowset(qry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
  //----------------------
		%>
		<TABLE cellSpacing=0 width="100%" align=center bgcolor="#de6400" valign="top" >
		<TR><TD nowrap align=left><FONT face="Times" color=white size=4><STRONG><U>Available Options</U></STRONG></FONT>
		<!--<img height=2 src="../Images/ColorBar.gif" width=110>-->
		</td></tr>
		<tr>
		<td>
		<!-Keep all menus within masterdiv-->
		<%
			if (mMemberID.equals("UNIV-M00004") || mMemberID.equals("UNIV-C00003") || mMemberID.equals(" UNIV-H00011") || mMemberID.equals("UNIV-K00016") || mMemberID.equals("UNIV-K00020") || mMemberID.equals("UNIV-S00084")   )
			{			%>
			 <br><A href="AcademicInfo/EMP_changestudchoice.jsp" target="DetailSection"><font color=White><b>Student Re-Choice</b></font></A><br>
			 <A href="AcademicInfo/PreRegistrationElectiveReport.jsp" target="DetailSection"><font color=White><b>Elective Subjects Count</b></font></A><br><br>
			<%
		
			}

if(mInst.equals("J128"))
		{
			if (mMemberID.equals("UNIV-M00046") || mMemberID.equals("UNIV-R00036"))
			{			%>
			 <br><A href="AcademicInfo/EMP_changestudchoice.jsp" target="DetailSection"><font color=White FACE=ARIAL><b>Student Re-Choice</b></font></A><br>
			 <A href="AcademicInfo/PreRegistrationElectiveReport.jsp" target="DetailSection"><font color=White FACE=ARIAL><b>Elective Subjects Count</b></font></A><br><br>
			<%
		
			}
		}
			%>

		<div id="masterdiv">
		<div class="menutitle" onclick="SwitchMenu('sub1')">Personal Info.&nbsp;<img src="../Images/arrow.gif"></div>
	

		<span class="submenu" id="sub1">



		<%
		qry="Select WEBKIOSK.ShowLink('1','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
		//out.print(qry);
		
		
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Personal Information" href="PersonalInfo/EmpPersonalInfo.jsp"><FONT face="Arial" color =white size=2>Personal Detail</font></a><br>
			<%
		}
		qry="Select WEBKIOSK.ShowLink('185','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
		//out.print(qry);
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Self Attendance Detail" href="PersonalInfo\SelfAttendanceDetail.jsp"><FONT face="Arial" color =white size=2>Self Attendance</font></a><br>
	

			<%
		}

			qry="Select WEBKIOSK.ShowLink('269','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
		//out.print(qry);
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Penalty Attendance Detail" href="PersonalInfo\EmployeePenaltyAtt.jsp"><FONT face="Arial" color =white size=2>Penalty Attendance</font></a><br>

			<%
		}


		qry="Select WEBKIOSK.ShowLink('48','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change eMailID/Contact Numbers" href="PersonalInfo/EmpModifyEmailIDTelephone.jsp"><FONT face="Arial" color =white size=2>Edit Info.</font></a><br>
			<%
		}
		qry="Select WEBKIOSK.ShowLink('2','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Dependent Information" href="PersonalInfo/EmpDependentsList.jsp"><FONT face="Arial" color =white size=2>Dependent Info.</font></a><br>
			<%
		}
	qry="Select WEBKIOSK.ShowLink('3','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Leave Detail" target="DetailSection" href="PersonalInfo/EmployeeLeaveInformation.jsp"><FONT face="Arial" color =white size=2>Leave Detail</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('4','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Salary history" target="DetailSection" href="PersonalInfo/EmployeeSalaryHistory.jsp"><FONT face="Arial" color =white size=2>Salary Detail</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('161','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";		

	Rs=db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
      {
	  %>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Salary slip of employee" target="DetailSection" href='PersonalInfo\SalarySlip.jsp'><FONT face="Arial" color =white size=2>Salary Slip</font></a><br>
	  <%
	}
	
	
	qry="Select WEBKIOSK.ShowLink('168','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";		

	Rs=db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
    {
	  
		String mTDSCode="",mDateFrom="",mDateTo="",mFYear="",Panno="",mFREEZE="",mAssYear="";	
		
		qry="SELECT to_char(FROMPERIOD,'dd-mm-yyyy')FROMPERIOD, to_char(TOPERIOD,'dd-mm-yyyy')TOPERIOD, NVL(STATUS,'N')STATUS ,NVL(ASSESSMENTYEAR,' ')ASSESSMENTYEAR , NVL(FINYEAR,' ')FINYEAR	,nvl(TDSCODE,' ')TDSCODE  ,(TOPERIOD-trunc(sysdate))DAYCOUNT	FROM TDS#PARAMETER where COMPANYCODE='"+mComp+"'  and trunc(SYSDATE) >= trunc(fromperiod)  and  trunc(SYSDATE) <= trunc(toperiod) ";
//		out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
		{
		mDateFrom=rs.getString("FROMPERIOD");
		mDateTo=rs.getString("TOPERIOD");
		
		mAssYear=rs.getString("ASSESSMENTYEAR");
		mFYear=rs.getString("FINYEAR");
		mTDSCode=rs.getString("TDSCODE");
	

	

 qry1="select nvl(FREEZE,'N')FREEZE  from TDS#EDIDECLARATIONHEADER where  COMPANYCODE='"+mComp+"' and  TDSCODE='"+mTDSCode+"' and ASSESSMENTYEAR='"+mAssYear+"' and EMPLOYEEID='"+mChkMemID+"' ";
	rs1=db.getRowset(qry1);
	if(rs1.next())
	{
	mFREEZE=rs1.getString("FREEZE");
	}
	else
	{
		mFREEZE="X";
	}
	
	if(mFREEZE.equals("Y"))
		{
		%>
			
    	<img src="../Images/bullet4.gif">&nbsp;<a  title="Tax Decleration" target="DetailSection" href='FAS/TDSDeclaration.jsp'><FONT face="Arial" color =white size=2>Tax Declaration</font></a><br>
	  
		<%
		}
		else
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  title="Tax Decleration" target="DetailSection" href='FAS/TDSDeclarationInstruction.jsp'><FONT face="Arial" color =white size=2>Tax Declaration</font></a><br>
			<%
		}
	}
	  %>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Tax Decleration" target="DetailSection" href='FAS/TDSDeclare.jsp'><FONT face="Arial" color =white size=2>Tax Declaration Report</font></a><br>
	  <%
	
	if(mChkMemID.equals("UNIV-S00048") || mChkMemID.equals("UNIV-R00039") )
		{
	 %>
		 <img src="../Images/bullet4.gif">&nbsp;<a  title="Tax Decleration ReportALL" target="DetailSection" href='FAS/TDSDeclareReportAll.jsp'><FONT face="Arial" color =white size=2>Declaration ReportALL</font></a><br>
	 <%
		}

%>
	<img src="../Images/bullet4.gif">&nbsp;<a  title="Tax Calculation Sheet" target="DetailSection" href='FAS/TDSCalculation.jsp'><FONT face="Arial" color =white size=2>Tax Calculation</font></a><br>	

	<%

	}
   qry="Select WEBKIOSK.ShowLink('257','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

     Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Employee PF/TDS Report" target="DetailSection"
       href="FAS/EmployeePFTDSReport.jsp"><font face="Arial" color=white size=2>Employee PF/TDS</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('5','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Request for LTC" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>LTC Request</font></a><br>		
	<%
	}
	qry="Select WEBKIOSK.ShowLink('6','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Status of LTC [Approved/Pending]" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>LTC Status</font></a><br>		
	<%
	}
	qry="Select WEBKIOSK.ShowLink('7','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Request for Mediclaim" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Mediclaim Req.</font></a><br>		
	<%
	}

	qry="Select WEBKIOSK.ShowLink('8','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Medical Status [Approved/Pending]" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Medi. Status</font></a><br>		
	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('9','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
     if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Message for Me" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Inbox</font></a><br>		

	<%
	}

	qry="Select WEBKIOSK.ShowLink('151','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs= db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	   {
	  %>
   	      <img src="../Images/bullet4.gif">&nbsp;<a href='../CommonFiles/SelfStudEmpDrCrAdvice.jsp' Title='Veiw Debit/Credit Advive' Target=_NEW><font  face="Arial" color =white size=2>Dr/Cr Advice</font></a><br>
	  <%
	   }

	%>
 </span>

<%


qry="Select WEBKIOSK.ShowLink('255','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
%>

  <div class="menutitle" onclick="SwitchMenu('sub2')">HRMS &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
  <span class="submenu" id="sub2">
	<%	 

qry="Select WEBKIOSK.ShowLink('255','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="DepartmentSelection" target="NEW" href="HRMS/DepartmentSelectionPage.jsp"><FONT face="Arial" color =white size=2>Initial ShortListing</font></a><br>
	<%
	}

qry="Select WEBKIOSK.ShowLink('256','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="HODWiseSelection" target="NEW" href="HRMS/HODWiseSelection.jsp"><FONT face="Arial" color =white size=2>Final ShortListing </font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('169','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="Leave Detail" target="DetailSection" href="HRMS/PageWiseMessageEntry.jsp"><FONT face="Arial" color =white size=2>Page wise msg</font></a><br>
	<%
	}


      if (mMemberID.equals("TIET-R00001"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Application form related vacancy/interview" target="_new" href='HRMS/Application/ApplicationForm.jsp'><FONT face="Arial" color =white size=2>Application</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('141','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Man-power Indent for the concern department" target="DetailSection" href='HRMS/Application/ManPowerIndent.jsp'><FONT face="Arial" color =white size=2>Man-Power Req.</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('143','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Approval of Man-power Indent for the concern department" target="DetailSection" href='HRMS/Application/ManPowerIndentApproval.jsp'><FONT face="Arial" color =white size=2>Man-Power Req./ <font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Indent Approval</font></a><br>
	<%
	}

	 
	qry="Select WEBKIOSK.ShowLink('149','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Shortlist of Candidate(s)" target="DetailSection" href='HRMS/Application/ShortListApplicant.jsp'><FONT face="Arial" color =white size=2>Short List</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('144','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Surplus Employee Info. - By HOD" href='HRMS/Application/SurPlusEmpInfo.jsp'><FONT face="Arial" color=white size=2>SurplusEmployee<small></small></font></a><br>
	<%
	}

//--------------------------
	qry="Select WEBKIOSK.ShowLink('179','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Advance Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=ADVANCE'><FONT face="Arial" color=white size=2>Advance Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Leave Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=LEAVE'><FONT face="Arial" color=white size=2>Leave Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Leave Travel Consession (LTC) Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=LTC'><FONT face="Arial" color=white size=2>LTC Workflow</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="NOC Work Flow" href='HRMS/WorkFlowMenuOptions.jsp?WFC=NOC'><FONT face="Arial" color=white size=2>NOC Workflow</font></a><br>
	<%
	}
//--------------------------

	qry="Select WEBKIOSK.ShowLink('172','"+ mMemberID  +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Work Flow Approval Level" href='HRMS/WorkFlowApprovalLevel.jsp?DEPTCODE=<%=mDeptCode%>'><FONT face="Arial" color=white size=2>Work Flow Level<small></small></font></a><br>
	<%
	}
	%>
 </span>
 <%
}

	qry="Select WEBKIOSK.ShowLink('12','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{

      %>

 <div class="menutitle" onclick="SwitchMenu('sub3')">SRS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
 <span class="submenu" id="sub3">
	<%
	qry="Select WEBKIOSK.ShowLink('12','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Submitted SRS for Printing Approval" target="DetailSection" href='SRS\SrsApprovalEmployee.jsp'><FONT face="Arial" color =white size=2>Allow SRS Print</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('78','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report Before Finalization" target="DetailSection" href="SRS\EmpSRSTeachRatingRepBeforeFinalized.jsp"><FONT face="Arial" color =white size=2>PreFinalizedSRS</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('47','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Finalization os SRS After Printing" target="DetailSection" href="SRS\FinalizedSRSAfterPrint.jsp"><FONT face="Arial" color =white size=2>SRS Finalization</font></a><br>
	<%
	}

	
	qry="Select WEBKIOSK.ShowLink('77','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="DateWise SRS" target="DetailSection" href="SRS\DateWiseSRSDetailRep.jsp"><FONT face="Arial" color =white size=2>DateWise SRS</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('40','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Personal SRS Report (Summary-Overall Average)" target="DetailSection" href="SRS\EmpSRSTeachRatingRepInd.jsp"><FONT face="Arial" color =white size=2>Personal SRS<br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Summary</font></a><br>
	<%
	}

      
	qry="Select WEBKIOSK.ShowLink('10','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{      
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report" target="DetailSection" href="SRS\EmpSRSTeachRatingRep.jsp"><FONT face="Arial" color =white size=2>SRS Summary</font></a><br>
	<%
	}
	//else
	//{
	  qry="Select WEBKIOSK.ShowLink('41','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	  {
 	  %>
	   <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS Report (Department wise)" target="DetailSection" href="SRS\EmpSRSTeachRatingRepHOD.jsp"><FONT face="Arial" color =white size=2>Department wise <br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>SRS Summary</font></a><br>
	  <%
	  }
	//}

	qry="Select WEBKIOSK.ShowLink('55','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Personal SRS detailed" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailInd.jsp"><FONT face="Arial" color =white size=2>Self SRS Detail</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('11','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS detailed" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailRep.jsp"><FONT face="Arial" color =white size=2>All SRS Detail</font></a><br>	
	<%
	}
	else
	{
		qry="Select WEBKIOSK.ShowLink('54','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	Rs = db.getRowset(qry);
	      if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
	  	<img src="../Images/bullet4.gif">&nbsp;<a  title="View SRS detailed Department wise" target="DetailSection" href="SRS\EmpSRSTeachRatingDetailHOD.jsp"><FONT face="Arial" color =white size=2>Department wise<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>SRS Detail</font></a><br>	
		<%
		}
	}
	

	qry="Select WEBKIOSK.ShowLink('49','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Datewise SRS Count" target="DetailSection" href=SRS\SrsSubmitionCount.jsp><FONT face="Arial" color =white size=2>SRS Count</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('140','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Semester/Programwise Students SRS Count" target="DetailSection" href=SRS\SrsDetailReport.jsp><FONT face="Arial" color =white size=2>Stud SRS Status</font></a><br>
	<%
	}

	

	qry="Select WEBKIOSK.ShowLink('79','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="Total Sent/Left SRS Count" target="DetailSection" href=SRS\SentLeftSRSList.jsp><FONT face="Arial" color =white size=2>Sent/Left Count</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('69','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	  <img src="../Images/bullet4.gif">&nbsp;<a  title="View Abusing Word Suggestion" target="DetailSection" href=SRS\ViewSrsAbusingWord.jsp><FONT face="Arial" color =white size=2>Abused SRS</font></a><br>
	<%
	}
	
	qry="Select WEBKIOSK.ShowLink('104','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View SRS Rating Graph" href="SRS\GraphEmpSRSTeachRatingRep.jsp"><FONT face="Arial" color =white size=2>SRS Graphs</font></a><br>
	<%
	}

	%>
  </span>

<%
}

	qry="Select WEBKIOSK.ShowLink('13','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{

%>
   <div class="menutitle" onclick="SwitchMenu('sub4')">Journals Info.&nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub4">
	<%
	qry="Select WEBKIOSK.ShowLink('13','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  title="Post New Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Post Journal</font></a><br>
	<%
	}	
	qry="Select WEBKIOSK.ShowLink('14','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="Modify Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Modify Journals</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('15','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  title="View Research work/Journals" target="DetailSection" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>View Journals</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('16','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Seminar Attended history posting" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Write Seminar</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('17','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seminar attended detail" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>View Seminar</font></a><br>
	<%
	}
	%>
   </span>
   <%
   }

   %>
   <div class="menutitle" onclick="SwitchMenu('sub5')">Academic Info <img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub5">

    <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/TP/showregisteredpage.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>T&P Registration</FONT></A></br> 
	<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/TP/QuerryCriteria.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>T&P Querry Criteria</FONT></A></br> 
	    <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/TP/afterregistered.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>After Registration</FONT></A></br>
        <%

	qry="Select WEBKIOSK.ShowLink('127','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 Rs = db.getRowset(qry);
       if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="_New" title="Counselling Seats Status (Refreshing Seats Window) " href="SeatStatus/CounsSeat.jsp"><FONT face="Arial" color=white size=2>Couns Seats</font></a><br>
	<%

	}

	qry="Select WEBKIOSK.ShowLink('128','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="_New" title="Students having completed Counselling (Scrolling Window)" href="StudentStatus/CounsStud.jsp"><FONT face="Arial" color =white size=2>Couns. Stud.</font></a><br>
	<%
	}
 


	int mok=0;
	qry="Select WEBKIOSK.ShowLink('105','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	mok=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A  href="../EmployeeFiles/AcademicInfo/TeachingLoad.jsp" title="View/Modify Teaching Load"  target="DetailSection"><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
	<%
	}
	if (mok==0)
	{
		qry="Select WEBKIOSK.ShowLink('106','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
			<img src="../Images/bullet4.gif">&nbsp;<A  href="../EmployeeFiles/AcademicInfo/TeachingLoad.jsp" title="View/Modify Teaching Load"  target="DetailSection"><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
		<%
		}
	 }


	qry="Select WEBKIOSK.ShowLink('228','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Application Form of JPBS" href="../EmployeeFiles/JPBSApp/index.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>JPBS Applications</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Edit Application Form of JPBS" href="../EmployeeFiles/JPBSApp/EditApplicationForm.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>JPBS Appln Edit</FONT></A></br>

		<!-- <img src="../Images/bullet4.gif">&nbsp;<A title="Application Form of JPBS Work Experience" href="../EmployeeFiles/JPBSApp/WorkExpApplicationForm.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>JPBSApp WorkExp.</FONT></A></br> -->
		<%
	}

	qry="Select WEBKIOSK.ShowLink('252','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/ViewStudentRegistrationSummary.jsp" title="Student Registration Summary - RegAllow/RegConfirm/FeesPaid" target="DetailSection"><FONT face="Arial" size =2 color=white>Registration Summary</FONT></A></br>
		<%
	}

      qry="Select WEBKIOSK.ShowLink('82','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 // out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/NewDailyStudentAttendanceEntry1.jsp"
        title="Student Attendance Entry-for the current working Days/class only"
        target="DetailSection"><FONT face="Arial" size =2 color=yellow> Attendance Entry</FONT></A></br>

		<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/DailyStudentAttendanceEdit.jsp"
        title="Edit Student Attendance Entry-for the current working Days/class only"
        target="DetailSection"><FONT face="Arial" size =2 color=white>Edit Attendance Entry</FONT></A></br>

<!-- 
		<img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/DailyStudentAttendanceEntry.jsp"
        title="Student Attendance Entry-for the current working Days/class only"
        target="DetailSection"><FONT face="Arial" size =2 color=white>Old Attendance Entry</FONT></A></br>
 -->

 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/DailyStudentAttendanceReport.jsp" title="Student wise Class percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Student Attendance</FONT></A></br> 
		<%
	}

     qry="Select WEBKIOSK.ShowLink('89','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Authorization/Permition to Grant Special Permition to take attendance of Students from Other Batches" href="../EmployeeFiles/StudAttendByOtherFacltyRequest.jsp" title="Subject Choice entry for the comming batch" target="DetailSection"><FONT face="Arial" size =2 color=white>Student Attend.<br><FONT face="Arial" color='#de6400' size=2> &nbsp;&nbsp;&nbsp;</font>by Other Faculty</FONT></A></br>
		<%
	}
	int flag=0;




	qry="Select WEBKIOSK.ShowLink('84','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/ViewAttendanceSummary11.jsp?SrcType=H" title="Subject wise Student percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance Summary</FONT></A></br> 
		
		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/StudentNotAttendClass.jsp?SrcType=H" title="Student Not Attended Class " target="DetailSection"><FONT face="Arial" size =2 color=white>Student Not<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp;  &nbsp;</font>Attended Classes</FONT></A></br> 




		<!--  <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/attendancepercenWisebreackup.jsp?SrcType=H" title="Student Attendance Percentage wise BreakUP" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance %<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp;  &nbsp;</font>wise BreakUP</FONT></A></br>  -->
			
	<!-- 	<img src="../Images/bullet4.gif">&nbsp;<A title="Department wise Class Attendance taken by the concerned Faculty" href="../EmployeeFiles/AcademicInfo/EmployeeAttendanceListHOD.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Deptwise Attend.</FONT></A></br> -->
	<%
	}
	else
	{
			qry="Select WEBKIOSK.ShowLink('83','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		  <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/ViewAttendanceSummary11.jsp?SrcType=I" title="Subject wise Student percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance Summary</FONT></A></br> 

		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/StudentNotAttendClass.jsp?SrcType=I" title="Student Not Attended Class " target="DetailSection"><FONT face="Arial" size =2 color=white>Student Not<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp; &nbsp;</font>Attended Classes</FONT></A></br> 


 <img src="../Images/bullet4.gif">&nbsp;<A title="Personal Class Attendance" href="../EmployeeFiles/AcademicInfo/EmployeeAttendanceListPersonal.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>My Batch Attend.</FONT></A></br>  
		<%
			flag=1;
	}
		}
		

	qry="Select WEBKIOSK.ShowLink('87','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/ViewAttendanceSummary11.jsp?SrcType=A" title="Subject wise Student percentage(%) Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance Summary</FONT></A> <br>

		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/StudentNotAttendClass.jsp?SrcType=A" title="Student Not Attended Class " target="DetailSection"><FONT face="Arial" size =2 color=white>Student Not<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp; &nbsp;</font>Attended Classes</FONT></A></br>

		 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/attendancepercenWisebreackup.jsp?SrcType=H" title="Student Attendance Percentage wise BreakUP" target="DetailSection"><FONT face="Arial" size =2 color=white>Attendance %<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp;  &nbsp;</font>wise BreakUP</FONT></A></br> 


 <img src="../Images/bullet4.gif">&nbsp;<A href="../EmployeeFiles/AcademicInfo/DateWiseAttendancePer.jsp?SrcType=H" title="Student Attendance Datewise  Percentage wise BreakUP" target="New"><FONT face="Arial" size =2 color=white>Datewise Attendance%<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp;  &nbsp;</font>wise BreakUP</FONT></A></br> 




	 <img src="../Images/bullet4.gif">&nbsp;<A title="List of Attendance taken by all Faculty" href="../EmployeeFiles/AcademicInfo/EmployeeAttendanceListALL.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>All Batch Attend</FONT></A></br> 
	<%
	}

	qry="Select WEBKIOSK.ShowLink('235','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Student Cut-Off Attendance" href="../EmployeeFiles/AcademicInfo/StudentCutOffAttendance.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Cut-Off Attendance</FONT></A></br>
	<%
	}
	%>
	
	 <img src="../Images/bullet4.gif">&nbsp;<A title="List of Attendance taken by all Faculty" href="../EmployeeFiles/AcademicInfo/Attendancespecial.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Att.special Approval</FONT></A></br> 
	<%



qry="Select WEBKIOSK.ShowLink('261','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Student Cut-Off Attendance" href="../EmployeeFiles/AcademicInfo/StudentCutOffAttendanceHOD.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Cut-Off Attendance<br><FONT face="Arial" color='#de6400' size=1>&nbsp;&nbsp;&nbsp;</font> HOD</FONT></A></br>
	<%
	}


qry="Select WEBKIOSK.ShowLink('267','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Student Cut-Off Attendance" href="../EmployeeFiles/AcademicInfo/StudentCutOffAttendByVCC.jsp" title="View Class Attendance" target="DetailSection"><FONT face="Arial" size =2 color=white>Complete Cut-off<Br>
		<FONT face="Arial" color='#de6400' size=1> &nbsp;	&nbsp;	&nbsp;</font>Attendance:<br>		<FONT face="Arial" color='#de6400' size=1>&nbsp;   &nbsp;&nbsp;</font>Administrator</FONT></A></br>
	<%
	}






	qry="Select WEBKIOSK.ShowLink('65','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of Students in a particular Subject and Teacher" href="../EmployeeFiles/AcademicInfo/EmpSubjectStudentLoadView.jsp" title="Subject Choice entry for the comming batch" target="_new"><FONT face="Arial" size =2 color=white>Class Student List</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('254','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Debarred Student" href="../EmployeeFiles/AcademicInfo/DebarStudent.jsp" title="Debarred Student" target="DetailSection"><FONT face="Arial" size =3 color=white><B>Debarr Student</b></FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('253','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of Students having Mail-ID Viewed by VC" href="../EmployeeFiles/AcademicInfo/StudentEmailIDList.jsp" title="List of Students having Mail-ID Viewed by VC" target="DetailSection" ><FONT face="Arial" size =2 color=white>Students List</FONT></A></br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('85','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="List of All Students in a particular Subject and Teacher " href="../EmployeeFiles/AcademicInfo/EmpSubjectStudentLoadViewDOAA.jsp" title="Subject Choice entry for the comming batch" target="_new"><FONT face="Arial" size =2 color=white>Facultywise <br><FONT face="Arial" color='#de6400' size=2>&nbsp;&nbsp;&nbsp;</font>Class List</FONT></A></br>

	<%
	}

		qry="Select WEBKIOSK.ShowLink('217','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A  title="Coordinator Faculty and Student List"  href="ExamActivity/EmpExamCoordinatorStudentList.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Co-ord Wise StudList</FONT></A></br>

		<%
	}

	qry="Select WEBKIOSK.ShowLink('86','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Count of All Students in a particular Subject and Teacher " href="../EmployeeFiles/AcademicInfo/EmpSubjectStudentLoadCount.jsp" title="Total Count in a Section/Subsection against selected Subject" target="_new"><FONT face="Arial" size =2 color=white>Total Classes<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Count</FONT></A></br>

	<%
	}

	
	qry="Select WEBKIOSK.ShowLink('50','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject Choices Entry/Request"
        href="../EmployeeFiles/AcademicInfo/EmpSubjectChoiceEntry.jsp"
        title="Subject Choice entry for the comming batch" target="DetailSection">
            <FONT face="Arial" size =2 color=white>Subj. Preference</FONT></A></br>
            
	<%
	}

	qry="Select WEBKIOSK.ShowLink('110','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject's Room and Daywise Time Preference Entry/Request" href="../EmployeeFiles/AcademicInfo/EmpSubjectDateTimePrefEntry.jsp" target="DetailSection"><FONT face="Arial" size =2 color=white>Day/Time Pref.</FONT></A></br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('51','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="../EmployeeFiles/AcademicInfo/EmpSubjectChoiceView.jsp" title="Subject Choice entry for the comming batch" target="DetailSection"><FONT face="Arial" size =2 color=white>Selected/Opted<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Subjects in PR </FONT></A></br>	
	<%
	}

	int h=0;
	qry="Select WEBKIOSK.ShowLink('126','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	h=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="../EmployeeFiles/AcademicInfo/EmpSbjChoiceNoChoices.jsp?Type=D" title="Subject Choice/No choices sent by Faculty" target="DetailSection"><FONT face="Arial" size =2 color=white>Faculty Choices</FONT></A></br>	
	<%
	}

	if(h==0)
	{
	qry="Select WEBKIOSK.ShowLink('125','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	h=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Faculty Subject choice View" href="../EmployeeFiles/AcademicInfo/EmpSbjChoiceNoChoices.jsp?Type=H" title="Subject Choice/No choices sent by Faculty" target="DetailSection"><FONT face="Arial" size =2 color=white>Faculty Choices</FONT></A></br>	
	<%
	}
	}


	qry="Select WEBKIOSK.ShowLink('114','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
		//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Elective Subjects to be Run by HOD" href="AcademicInfo/PRRegElectiveSubjToBeRun.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subjects<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>to be run-HOD</FONT></A></br>
	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('123','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
//	out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Count of All Students in a particular Subject and Teacher " href="../EmployeeFiles/AcademicInfo/SubjectWiseTotalCount.jsp" title="Total Count in a Section/Subsection against selected Subject" target="DetailSection"><FONT face="Arial" size =2 color=white>Total Student<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Count</FONT></A></br>	

	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Report" href="AcademicInfo/PreRegistrationReport.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Pre Reg. Report</FONT></A></br>

		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiom - Student Subject Choice of Electives" href="AcademicInfo/PRRegStudentChoice.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Student Choice<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> of Electives</FONT></A></br>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registratiomn - Approval of finalized Elective Subjects by DOAA" href="AcademicInfo/PRRegApprovElectiveSubjByDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Approve Electives</FONT></A></br>


	<%
	}
	qry="Select WEBKIOSK.ShowLink('220','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Elective/Free-Elective Subjects Finalization Status " href="AcademicInfo/EleSubjectStatus.jsp?SrcType=H" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subjects<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status-HOD</FONT></A></br>
	
	<%
	}
	qry="Select WEBKIOSK.ShowLink('219','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Elective/Free-Elective Subjects Finalization Status " href="AcademicInfo/EleSubjectStatus.jsp?SrcType=D" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subjects<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status-DOAA</FONT></A></br>
	
	<%
	}
	qry="Select WEBKIOSK.ShowLink('222','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Semester Wise Student Count Given Their Choice For Elective Subjects" href="AcademicInfo/StudentCount.jsp?SrcType=H" target=DetailSection><FONT face="Arial" size =2 color=white>Student Count Per<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> Semester-HOD</FONT></A></br>
	
	<%
	}
	qry="Select WEBKIOSK.ShowLink('221','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Semester Wise Student Count Given Their Choice For Elective Subjects" href="AcademicInfo/StudentCount.jsp?SrcType=D" target=DetailSection><FONT face="Arial" size =2 color=white>Student Count Per<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> Semester-DOAA</FONT></A></br>
	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('112','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration BackLog Paper Apprval/Finalization by DOAA" href="AcademicInfo/PRRegBackPaperFinalDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>BackLog Papers<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approval - DOAA</FONT></A></br>
	<%
	}



     qry="Select WEBKIOSK.ShowLink('56','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
<!-- 	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - HOD Load Distribution (Base)" href="AcademicInfo/PRRegLoadDistributionHOD.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution</FONT></A></br>	 -->
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - HOD Load Distribution (Advance)" href="AcademicInfo/PRLoadDistributionByHOD.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Adv. Load Distribution</FONT></A></br>	
	
	

	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - HOD Load Distribution (Advance)" href="AcademicInfo/PRLoadDistributionByHODReport.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> Report</FONT></A></br>	 
	
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - HOD Load Distribution Before Load Assign" href="AcademicInfo/oldSubject_newSubject.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>One to One Load</FONT></A></br>
	
	<img src="../Images/bullet4.gif">&nbsp;<A title="Back Log Students Merge With Regular Batches" href="AcademicInfo/BackLogStudLoadDistribution.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Backlog Sub. Load <br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> Distribution</FONT></A></br>	
	
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - DOAA" href="AcademicInfo/StudentAssignLoadDistribution.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>BackLog Sub. Load<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> Report</FONT></A></br>
	
	<img src="../Images/bullet4.gif">&nbsp;<A title="Back Log Students Merge With Regular Batches" href="AcademicInfo/BackLogStudILoadDistsubjectII.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Old Subj. v/s<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font> New Subj.</FONT></A></br>
	



	<%
	}

	 qry="Select WEBKIOSK.ShowLink('274','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
//out.print(qry);
	  Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Back Log Students Merge With Regular Batches" href="AcademicInfo/BacklogStudMergeReg.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>After Adv.Load Dist.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Backlog Stud Merge with Reg Batch </FONT></A></br>

	<%
	}

	int m129=0;
	qry="Select WEBKIOSK.ShowLink('129','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m129=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpAssignedLoadDistribution.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Assigned Load</FONT></A></br>
		
	<%
	}

	if (m129==0)
	{
	qry="Select WEBKIOSK.ShowLink('130','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - Departmentwise" href="AcademicInfo/EmpAssignedLoadDistribution.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Assigned Load</FONT></A></br>

	<%
	}
	}

	qry="Select WEBKIOSK.ShowLink('251','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	  //out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - By an Individual from User Wise Load" href="AcademicInfo/EmpAssignedLoadDistribution.jsp?Type=I" target=DetailSection><FONT face="Arial" size =2 color=white>Assigned Load</FONT></A></br>

	<%
	}

	//--------------------------------

	int mm129=0;
	qry="Select WEBKIOSK.ShowLink('129','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	mm129=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpAssignedLoadDistributionaApproved.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Teaching Load<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approved/Finalized</FONT></A></br>
	<%
	}

	if (mm129==0)
	{
	qry="Select WEBKIOSK.ShowLink('130','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Faculty for Assigned Load Distribution - Departmentwise" href="AcademicInfo/EmpAssignedLoadDistributionaApproved.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Teaching Load</FONT></A></br>
	<%
	}
	}



	//--------------------------------
	int m133=0;
	qry="Select WEBKIOSK.ShowLink('133','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m133=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Subjects and its respective Faculty member for Assigned Load Distribution - DOAA" href="AcademicInfo/EmpSubjectwiseAssignedLoadDistribution.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Subj. wise Load</FONT></A></br>
	<%
	}


	if (m133==0)
	{
	qry="Select WEBKIOSK.ShowLink('132','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration - List of Subjects and its respective Faculty member for Assigned Load Distribution  - Departmentwise" href="AcademicInfo/EmpSubjectwiseAssignedLoadDistribution.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Subj. wise Load</FONT></A></br>
	<%
	}
	}
	//--------------------------------


	qry="Select WEBKIOSK.ShowLink('113','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Cancellation of HOD Load Distribution Subejcts by DOAA" href="AcademicInfo/PRRegLoadDistributionCancelDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Cancel By DOAA</FONT></A></br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('113','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Load Distribution Approval and FSTID Generation by DOAA" href="AcademicInfo/PRRegLoadDistributionApprovalDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Load Distribution<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Approval - DOAA</FONT></A></br>	
	<%
	}



   	qry="Select WEBKIOSK.ShowLink('259','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">
    <A
    title="Faculty  Change program"
    href="AcademicInfo/Facultywisebranchchange.jsp" target=DetailSection>
        <FONT face="Arial" size =2 color=white>Faculty Change</FONT></A>


<br>
		<img src="../Images/bullet4.gif">
    <A
    title="Faculty  Change program"
    href="AcademicInfo/MultiFacultyAdd.jsp" target=DetailSection>
        <FONT face="Arial" size =2 color=white>Multi Faculty</FONT></A>
	<%
	}



	int m121=0;

	qry="Select WEBKIOSK.ShowLink('121','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m121=1;

	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Subjects Load Distribution Report by DOAA" href="AcademicInfo/SubjectLoadList.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Subject Load List</FONT></A></br>
	<%
	}

	if (m121==0)
	{
	qry="Select WEBKIOSK.ShowLink('122','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration Subjects Load Distribution Report by HOD" href="AcademicInfo/SubjectLoadList.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Subject Load List</FONT></A></br>
	<%
	}
	}


	int m119=0;
	qry="Select WEBKIOSK.ShowLink('119','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m119=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration List of Elective/Free Elective Subjects Running  by DOAA" href="AcademicInfo/ElectiveSubjectRunningList.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subject<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Running List</FONT></A></br>	
	<%
	}
	if (m119==0)
	{
	qry="Select WEBKIOSK.ShowLink('120','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Pre Registration List of Elective/Free Elective Subjects Running by HOD" href="AcademicInfo/ElectiveSubjectRunningList.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Elective Subject<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Running List</FONT></A></br>	
	<%
	}
	}




	int m135=0;
	qry="Select WEBKIOSK.ShowLink('135','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m135=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for DOAA" href="AcademicInfo/EmpTimeTableView.jsp?Type=D" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}
	if (m135==0)
	{
	m135=1;
	qry="Select WEBKIOSK.ShowLink('136','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for all HODs" href="AcademicInfo/EmpTimeTableView.jsp?Type=H" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}
	}
	if (m135==0)
	{
	m135=1;
	qry="Select WEBKIOSK.ShowLink('137','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Time Table for Faculty Member" href="AcademicInfo/EmpTimeTableView.jsp?Type=F" target=DetailSection><FONT face="Arial" size =2 color=white>Time Table</FONT></A></br>	
	<%
	}

	}


	%>
    </span>


   <div class="menutitle" onclick="SwitchMenu('sub6')">Exam. Activity<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub6">
	<%

    // Provide Link when Date Seet/Seating Plan Has been prepared and Exam Last Date is applicable
	
    int Ed=0;
    qry="Select WEBKIOSK.GetDateSheetCodes('"+pInstCode+"') SL from dual";
	//out.print(qry);
    Rs = db.getRowset(qry);
    if (Rs.next() && !Rs.getString("SL").equals("N"))
     {
		
	qry="Select WEBKIOSK.ShowLink('20','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.println(qry);
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{  Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat Complete (For Admin users)" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Date Sheet-All</font></a><br>
	<%
	}
 	if(Ed==0)
	{
	qry="Select WEBKIOSK.ShowLink('97','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat Departmentwise" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Date Sheet-HOD</font></a><br>
	<%
	}
	}
	if(Ed==0)
	{
	qry="Select WEBKIOSK.ShowLink('98','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Ed=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Date Sheat - individual Faculty" href="ExamActivity/EmpViewDateSheet.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Date Sheet-Indv.</font></a><br>
	<%
	}
	}
	int Sp=0;
	qry="Select WEBKIOSK.ShowLink('21','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		Sp=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan for all employee" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Seating plan -All</font></a><br>					
	<%
	}
	if(Sp==0)
	{
	qry="Select WEBKIOSK.ShowLink('34','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
        Rs = db.getRowset(qry);
        if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	  Sp=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan (Departmentwise)" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Seating plan-<small>HOD</small></font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" href="ExamActivity/EmpViewSubjectwiseStrength.jsp?RightsID=34"><FONT face="Arial" color=white size=2>Exam Stud Strength</font></a>
	<%
	}
     }

     if(Sp==0)
	{
	 qry="Select WEBKIOSK.ShowLink('35','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
         Rs = db.getRowset(qry);
         if (Rs.next() && Rs.getString("SL").equals("Y"))
	 {
	   Sp=1;
	  %>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Seating plan for indifidula employee" href="ExamActivity/EmpViewSeatPlan.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Seating plan-Indv.</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" href="ExamActivity/EmpViewSubjectwiseStrength.jsp?RightsID=35"><FONT face="Arial" color =white size=2>Exam Stud Strength</font></a>
	<%
	}
       }
//--------------------------------------	
/*
	int Dt=0;

	qry="Select WEBKIOSK.ShowLink('115','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for all employee" href="ExamActivity/DutyStatus.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Exam Duty-All</font></a><br>					
	<%
	}
	 if(Dt==0)
	{
	qry="Select WEBKIOSK.ShowLink('116','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan (Departmentwise)" href="ExamActivity/DutyStatus.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Exam Duty-<small>HOD</small></font></a><br>					
	<%
	}
      }
  	if(Dt==0)
	{
	qry="Select WEBKIOSK.ShowLink('117','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	Dt=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for individual employee" href="ExamActivity/DutyStatus.jsp?SrcType=I"><FONT face="Arial" color =white size=2>My Exam Duty</font></a><br>					
	<%
	}

	}
*/
//-------------------------------------
	qry="Select WEBKIOSK.ShowLink('115','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for all employee" href="ExamActivity/DutyStatus.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Exam Duty-All</font></a><br>					
		<%
	}
	qry="Select WEBKIOSK.ShowLink('116','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan (Departmentwise)" href="ExamActivity/DutyStatus.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Exam Duty-<small>HOD</small></font></a><br>					
		<%
      }
	qry="Select WEBKIOSK.ShowLink('117','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Duty plan for individual employee" href="ExamActivity/DutyStatus.jsp?SrcType=I"><FONT face="Arial" color =white size=2>My Exam Duty</font></a><br>					
		<%
	}
}
  // Closing of Date seet date checking


	qry="Select WEBKIOSK.ShowLink('91','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - Self" href='ExamActivity/InvigilationTimePrefDultHoliday.jsp'><FONT face="Arial" color =white size=2>Invig. Time Pref./<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Duty Request</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('107','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - By HOD" href='ExamActivity/InvigilationTimePrefDultHolidayHOD.jsp'><FONT face="Arial" color=white size=2>Inv. Rqst by <small>HOD</small></font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('108','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request - By DOAA" href='ExamActivity/InvigilationTimePrefDultHolidayADMIN.jsp'><FONT face="Arial" color=white size=2>Inv. Rqst by <small>DOAA</small></font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('92','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Duty Holiday/Time Pref. Request " href='ExamActivity/InvigilationTimePrefDultHolidayApproval.jsp'><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Request Approval</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('95','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="ExamActivity/InvigilationStatus.jsp?SrcType=I"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status (Self)</font></a><br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('93','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="ExamActivity/InvigilationStatus.jsp?SrcType=A"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status (All)</font></a><br>	
	<%
	}
	
	
	qry="Select WEBKIOSK.ShowLink('94','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Invigilation Time Pref./Duty Holiday Request Status" href="ExamActivity/InvigilationStatus.jsp?SrcType=H"><FONT face="Arial" color =white size=2>Invig. Time Pref.<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Status  Deptwise</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('58','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	if(mInst.equals("JIIT"))
	{
	qry+=" Where Exists ( select 1 from facultysubjecttagging A, ";
	qry=qry+" subjectmaster B where (A.LTP='L' OR (A.LTP='P' AND A.PROJECTSUBJECT='Y')) and A.employeeid='"+mMemberID +"' and A.examcode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N') and A.facultytype='I' ";	
	qry=qry+"  and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
	qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N') ";
	qry=qry+" and NVL(STATUS,'D')='F')";
	qry=qry+" AND a.FSTID NOT IN ( SELECT FSTID FROM V#EX#SUBJECTGRADECOORDINATOR)";
	qry=qry+" UNION";
 	qry=qry+" select 1 from V#EX#SUBJECTGRADECOORDINATOR A, ";
	qry=qry+" SUBJECTMASTER B where A.LTP IN ('L','P','E') and A.COORDINATORID='"+mMemberID +"' and A.EXAMCODE IN (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N') and A.COORDINATORTYPE='I' ";
	qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
	qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N')";
	qry=qry+" and NVL(STATUS,'D')='F')";
	qry=qry+" UNION ";
 	qry=qry+" Select 1 from facultysubjecttagging AA, SubjectMaster CC , ";
	qry=qry+" ProgramSubjectTagging BB where AA.LTP='P' AND nvl(AA.PROJECTSUBJECT,'N')<>'Y' AND AA.FSTID NOT IN ( SELECT NP.FSTID FROM V#EX#SUBJECTGRADECOORDINATOR NP )";
	qry=qry+" And BB.L=0 and BB.T=0 and BB.P>0 And BB.ExamCode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N') And AA.employeeid='"+mMemberID +"' and AA.examcode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N') ";
	qry=qry+" and aa.INSTITUTECODE='"+mInst+"' AND AA.INSTITUTECODE=BB.INSTITUTECODE And AA.EXAMCODE=BB.EXAMCODE And AA.ACADEMICYEAR=BB.ACADEMICYEAR And AA.PROGRAMCODE=BB.PROGRAMCODE And AA.TAGGINGFOR=BB.TAGGINGFOR And AA.SECTIONBRANCH=BB.SECTIONBRANCH And AA.SEMESTER=BB.SEMESTER And AA.BASKET=BB.BASKET And AA.SUBJECTID=BB.SUBJECTID ";
	qry=qry+" And AA.facultytype='I' ";	
	qry=qry+" and nvl(AA.deactive,'N')='N' and nvl(BB.Deactive,'N')='N' AND ";
	qry=qry+" aa.INSTITUTECODE='"+mInst+"' and AA.INSTITUTECODE=CC.INSTITUTECODE AND BB.INSTITUTECODE=CC.INSTITUTECODE AND cc.SUBJECTID=BB.SUBJECTID AND AA.SUBJECTID=CC.SUBJECTID ";
	qry=qry+" and AA.SUBJECTID Not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode in (Select nvl(EXAMCODE,' ')  from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND nvl(Deactive,'N')='N' and nvl(FINALIZED,'*')='N' AND NVL(LOCKEXAM,'N')='N')";
	qry=qry+" and NVL(STATUS,'D')='F'))";
		
	}
	//out.print(qry);	
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="Tagging of Subject as per Examination, Weightage & Full Marks"  href="ExamActivity/EmpExamEventSubjTagging.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Pre Marks Entry</FONT></A></br>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="Change Personal Batch Tagged Weightage (Event/Sub Event) as per Exam & Subject"  href="ExamActivity/ChangeExamEventSubjWeightage.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Re-Weightage</FONT></A><br>
	<%
	}

	//out.print(mMemberID+"aaa	");

	if(mMemberID.equals("UNIV-M00004"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="Tagging of Subject as per Examination, Weightage & Full Marks"  href="ExamActivity/AdminExamEventSubjTagging.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Admin Pre Marks Entry</FONT></A></br>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('218','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<A  title="View Marks Entry Status by Admin"  href="ExamActivity/EmpExamMarksStatusList.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry Status</FONT></A></br>
		<%
	}


	qry="Select WEBKIOSK.ShowLink('59','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A  title="View Personal Batch Tagged Subjects (Event/Sub Event) as per Examination, Weightage & Full Marks"  href="ExamActivity/ViewExamEventSubjTagging.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Exam Events</FONT></A></br>
	<%
	}




	//qry="Select WEBKIOSK.ShowLink('102','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      //Rs = db.getRowset(qry);
      //if (Rs.next() && Rs.getString("SL").equals("Y"))
	//{
	%>
	<!-- <img src="../Images/bullet4.gif">&nbsp;<A  title="Change Personal Batch Tagged Weightage (Event/Sub Event) as per Exam & Subject"  href="ExamActivity/ChangeExamEventSubjWeightage.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Re-Weightage</FONT></A></br> -->
	<%
	//}



	qry="Select WEBKIOSK.ShowLink('60','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Student's Marks Entry Grid Version" href="ExamActivity/MarksEntryGridVersion.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry</FONT></A><BR>

<img src="../Images/bullet4.gif">&nbsp;<A title="Student's Marks Entry Grid Version" href="ExamActivity/MarksEntryGridVersionnew.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry(Re-exam)</FONT></A><BR>


	<img src="../Images/bullet4.gif">&nbsp;<A title="Student's Project Marks Entry" href="ExamActivity/ProjMarksEntry.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Project Marks Entry</FONT></A><BR>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Student's Project Marks Entry Finalization" href="ExamActivity/ProjMarksEntryFinal.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Project Marks Final</FONT></A><BR>
	<!--<img src="../Images/bullet4.gif">&nbsp;<A title="Nitobi Grid Sample" href="nitobi/nitobitest.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Nitobi 1</A><BR>-->
	<%
	}

qry="Select WEBKIOSK.ShowLink('236','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Students Marks Entry Forcibly" href="ExamActivity/MarksEntryLvl1&2Forcibly.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry Forcibly</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('244','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Student's Project Marks Entry Forcibly After Finalization By HOD" href="ExamActivity/ProjMarksEntryForcibly.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Project Marks Forcibly</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('63','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Students Marks Entry New" href="ExamActivity/MarksEntryNew.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('64','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Students Marks Entry New" href="ExamActivity/MarksEntryLvl1.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('60','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<!-- <img src="../Images/bullet4.gif">&nbsp;<A title="Students Marks Entry Level-2" href="ExamActivity/MarksEntryLvl2.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry-II</FONT></A><BR> -->
	<%
	}

	qry="Select WEBKIOSK.ShowLink('61','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Proj. Marks View" href="ExamActivity/EmpProjectMarksView.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Project Marks View</FONT></A><BR>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Marks View" href="ExamActivity/EmpMarksView.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks View</FONT></A><BR>

	<%
	}


	qry="Select WEBKIOSK.ShowLink('265','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	

		<img src="../Images/bullet4.gif">&nbsp;<A title="Marks View HOD" href="ExamActivity/EmpMarksViewHOD.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks View HOD</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('266','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
	//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{

		  //Complete Cutt-off Attendance : Admin
	%>
	



		<img src="../Images/bullet4.gif">&nbsp;<A title="Marks View HOD" href="ExamActivity/EmpMarksViewVCC.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Complete Marks<br><FONT face="Arial" color='#de6400' size=1>&nbsp;   &nbsp;&nbsp;   &nbsp;</font>View of Student:<br><FONT face="Arial" color='#de6400' size=1>&nbsp;   &nbsp;&nbsp;   </font>Administrator 
				</FONT></A><BR>
	<%
	}




	qry="Select WEBKIOSK.ShowLink('60','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<!--<img src="../Images/bullet4.gif">&nbsp;<A title="Students Marks Entry Level-1 & Level-2" href="ExamActivity/MarksEntryLvl1&2Forcibly.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Entry Forcibly</FONT></A><BR>-->
	<%
	}

	int md=0;
	qry="Select WEBKIOSK.ShowLink('57','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		md=1;
	%>
		<img src="../Images/bullet4.gif">&nbsp;<A title="Ongoing performance record of Students (Departmental Manual)" href="ExamActivity/EmpPeformanceReportStud.jsp?Type=H" target="_New"><FONT face="Arial" size =2 color=white>Stud. Progressive <br><font color='#de6400'>&nbsp;&nbsp;&nbsp;&nbsp;</font>Marks</font></a><br>	
	<%
	}

	if (md==0)
	{
		qry="Select WEBKIOSK.ShowLink('111','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	Rs = db.getRowset(qry);
	      if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
		%>
			<img src="../Images/bullet4.gif">&nbsp;<A title="Ongoing performance record of Students (Departmental Manual)" href="ExamActivity/EmpPeformanceReportStud.jsp?Type=I" target="_New"><FONT face="Arial" size =2 color=white>Stud. Progressive <br><font color='#de6400'>&nbsp;&nbsp;&nbsp;&nbsp;</font>Marks</font></a><br>	
		<%
		}
	}



	/*
	qry="Select WEBKIOSK.ShowLink('64','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Marks Updation" href="ExamActivity/MarksEntryDOAA.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Marks Updation</FONT></A><BR>

	<%
	}
	*/

	qry="Select WEBKIOSK.ShowLink('103','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Allow for MakeUp Test" href="ExamActivity/MakeUpTest.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Allow for MakeUp</FONT></A><BR>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('124','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{

	%>
	<img src="../Images/bullet4.gif">&nbsp;<A title="Students Makeup Marks Entry " href="ExamActivity/MakeupMarksEntry.jsp" target=DetailSection><FONT face="Arial" size =2 color=white>Makeup Marks</FONT></A><BR>
	<%
	}


	qry="Select WEBKIOSK.ShowLink('66','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="SCGPA/CGPA wise Subject List" href="ExamActivity/ListStudentByCGPAMarks.jsp"><FONT face="Arial" color =white size=2>Stud. Marks Qry</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('18','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Paperwise distribtion" href="UnderConstruction.jsp"><FONT face="Arial" color =white size=2>Paperwise dist.</font></a><br>	
	<%
	}

	int m227=0;
      qry="Select WEBKIOSK.ShowLink('226','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	m227=1;
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Subject List For Grade Entry of Students  " href="ExamActivity/SubListForGradeEntry.jsp?SrcType=A""><FONT face="Arial" color =white size=2>Subjects for Grading</font></a><br>
	<%
	}
	if (m227==0)
	{
      qry="Select WEBKIOSK.ShowLink('227','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Subject List For Grade Entry of Students  " href="ExamActivity/SubListForGradeEntry.jsp?SrcType=H""><FONT face="Arial" color =white size=2>Subjects for Grading</font></a><br>
	<%
	}

	}

      qry="Select WEBKIOSK.ShowLink('146','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
   //  out.print(qry);
	  Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		 if(pInstCode.equals("JIIT") || pInstCode.equals("J128")) 
		{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeCalculation.jsp"><FONT face="Arial" color =white size=2>Grade Entry</font></a><br>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade View of Students  " href="ExamActivity/GradePrint.jsp"><FONT face="Arial" color =white size=2>Grade View</font></a><br>
	<%
		}
		else if(pInstCode.equals("JPBS")) 
		{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="_NEW" title="Grade Entry of Students for JPBS " href="ExamActivity/GradeCalculationJPBS.jsp"><FONT face="Arial" color =white size=2>JPBS Grade Entry</font></a><br>

		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade View of Students for JPBS  " href="ExamActivity/GradePrintJPBS.jsp"><FONT face="Arial" color =white size=2>JPBS Grade View</font></a><br>
	<%
		}


		
	}

 qry="Select WEBKIOSK.ShowLink('146','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="_NEW" shape="rect" coords="0,0,100,100" title="X-Project Grade Entry of Students  " href="ExamActivity/ProjectGradeCalculation.jsp" ><FONT face="Arial" color =white size=2 >X-ProjectGrade Entry</font></a><br>
		<!-- <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade View of Students  " href="ExamActivity/ProjectGradePrint.jsp" onClick="openNewWindow3()"><FONT face="Arial" color =white size=2>ProjectGrade View</font></a><br> -->
	<%
	}

	qry="Select WEBKIOSK.ShowLink('147','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeCalculationApprovalDOAA.jsp"><FONT face="Arial" color =white size=2>Grade Approval</font></a><br>

		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeEntryStatus.jsp"><FONT face="Arial" color =white size=2>Grade Entry Status<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Subject wise</font></a><br>

		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Grade Entry of Students  " href="ExamActivity/GradeEntryStatusStudent.jsp"><FONT face="Arial" color =white size=2>Grade Entry Status<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Student Wise</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('246','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
	//out.print(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Modified Grade Approval" href="ExamActivity/ApproveChangedStudGrade.jsp"><FONT face="Arial" color=white size=2>Changed Grd. Approve</font></a><br>
		<%
	}

	qry="Select WEBKIOSK.ShowLink('271','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
	//out.print(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Modified Grade Approval" href="ExamActivity/SummerInstructionEmp.jsp"><FONT face="Arial" color=white size=2>Summer Semester  </font></a><br>
		<%
	}
	%>	
    </span>

    <div class="menutitle" onclick="SwitchMenu('sub7')">Admin Option <img src="../Images/arrow.gif"></div>
    <span class="submenu" id="sub7">
<%
	qry="Select WEBKIOSK.ShowLink('223','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
	//out.print(qry);
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="NEW" title="Emial to Students in  bulk" href="AdminOptions\LotusEmail\ListRecipient.jsp"><FONT face="Arial" color =white size=2>Mass Mailing</font></a><br>						
			<%

				%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="NEW" title="Emial to Students in  bulk" href="AdminOptions\LotusEmail\WriteMail.jsp"><FONT face="Arial" color =white size=2>Mass Mailing</font></a><br>						
			<%
		}
	

	qry="Select WEBKIOSK.ShowLink('190','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
		//out.print(qry);
		Rs = db.getRowset(qry);
		if (Rs.next() && Rs.getString("SL").equals("Y"))
		{
			%>
			<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Employee Attendance Detail" href="AdminOptions\EmployeeAttendanceDetail.jsp"><FONT face="Arial" color =white size=2>Staff Attendance</font></a><br>

			
<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentPHD Attendance Detail" href="AdminOptions\StudentAttendancePHD.jsp"><FONT face="Arial" color =white size=2>StudentPHD Att.</font></a><br>
			<%
		}
	qry="Select WEBKIOSK.ShowLink('206','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
	//out.print(qry);
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Employee Attendance Detail" href="AdminOptions\EmployeeAttendanceDetail.jsp?SRCType=H"><FONT face="Arial" color =white size=2>Dept. Attendance</font></a><br>


		
<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentPHD Attendance Detail" href="AdminOptions\StudentAttendancePHDHOD.jsp"><FONT face="Arial" color =white size=2>StudentPHD Att.HOD</font></a><br>
		<%
	}
	qry="Select WEBKIOSK.ShowLink('191','"+ mMemberID +"','E','"+mRole+"','"+mIPAddress+"') SL from dual";
	//out.print(qry);
	Rs = db.getRowset(qry);
	if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
		%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Employee Attendance Detail" href="AdminOptions\EmployeeLateEarlyAttendance.jsp"><FONT face="Arial" color =white size=2>Emp Late/Early Att</font></a><br>

		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Employee Attendance Detail" href="AdminOptions/StudentLateEarlyAttendance.jsp"><FONT face="Arial" color =white size=2>Student Late/Early Att</font></a><br>
		<%
	}


	qry="Select WEBKIOSK.ShowLink('0','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup in bulk (create LoginID for New Students)" href="../CommonFiles/SignUpStudents.jsp"><FONT face="Arial" color=white size=2>Bulk Signup of<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Student</font></a><br>
	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('70','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Signup Member(create LoginID for Employee/Student/Visiting Staff/Guest one by one) " href="../CommonFiles/SignUp.jsp"><FONT face="Arial" color=white size=2>Signup Member</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('38','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change Role of Employee" href="AdminOptions/ChangeEmpRole.jsp"><FONT face="Arial" color=white size=2>Change Role</font></a><br>	
	<%
	}
	qry="Select WEBKIOSK.ShowLink('39','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Reset Password of any Member " href="AdminOptions/ResetPasswordForciblyNew.jsp"><FONT face="Arial" color=white size=2>Reset Password</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('67','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Assign/Reset Employee KIOSK Page Heading/Title " href="AdminOptions/WebPageTitle.jsp"><FONT face="Arial" color=white size=2>Webpage Title</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('68','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Deactive WebKiosk Member" href="AdminOptions/DeactiveWebkioskMember.jsp"><FONT face="Arial" color =white size=2>Lock/Unlock ID</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('81','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Locked WebKiosk Member List" href="AdminOptions/ListLockedMember.jsp"><FONT face="Arial" color =white size=2>Locked Members</font></a><br>	
	<%
	}
	
	qry="Select WEBKIOSK.ShowLink('101','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Change WebKiosk Marquee Text" href="AdminOptions/KioskMarqueeText.jsp"><FONT face="Arial" color =white size=2>Change Marquee</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('90','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Employee Information (Department wise)" href="../CommonFiles/DeptwiseEmpViewEmpInfo.jsp"><FONT face="Arial" color =white size=2>Department wise<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Employee Info.</font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('229','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual"; 
      Rs = db.getRowset(qry); 
      if (Rs.next() && Rs.getString("SL").equals("Y")) 
        { 
        %> 
        <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Employee Information (Department wise)" href="../CommonFiles/DeptwiseHodViewEmpInfo.jsp"><FONT face="Arial" color =white size=2>Department wise<br><font color='#de6400'>&nbsp;&nbsp;&nbsp;</font>Employee Info.</font></a><br>         
        <% 
        } 


	qry="Select WEBKIOSK.ShowLink('72','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Employee Information" href="../CommonFiles/EmpViewEmpInfo.jsp"><FONT face="Arial" color =black size=2>Employee Info</font></a><br>	
	<%
	}


	qry="Select WEBKIOSK.ShowLink('71','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
//	out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="View Students Information" href="../CommonFiles/EmpViewStdInfo.jsp"><FONT face="Arial" color =white size=2>Student Info</font></a><br>	
	<%
	}


	 

	%>
   </span>

   <div class="menutitle" onclick="SwitchMenu('sub8')">Room Booking<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub8">
	<%
	qry="Select WEBKIOSK.ShowLink('26','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Book a Room" href="RoomBooking/EmpBookRoom.jsp"><FONT face="Arial" color =white size=2>Room Booking</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('27','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Cancel a Booked Room by the respective Employee" href="RoomBooking/EmpCancelRoomBooking.jsp"><FONT face="Arial" color =white size=2>Cancel Room</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('28','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Cancel Room Forcibly" href="RoomBooking/EmpForcebilyCancelRoom.jsp"><FONT face="Arial" color =white size=2>Cancel Forcibly</font></a><br>
	<%
	}

	qry="Select WEBKIOSK.ShowLink('96','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Booked Room History" href="RoomBooking/EmpBookedRoomHistory.jsp"><FONT face="Arial" color =white size=2>Booked History</font></a><br>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('145','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
		<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Room Wise Room Booking History" href="RoomBooking/EmpBookedRoomHistoryRoomWise.jsp"><FONT face="Arial" color =white size=2>Roomwise Hist.</font></a><br>
	<%
	}
	%>
   </span>




 <div class="menutitle" onclick="SwitchMenu('sub10')">Res. Booking<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub10">
	<%
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Resource Parameter" href="ResourceBooking/ResParameter.jsp"><FONT face="Arial" color =white size=2>Res. Parameter</font></a><br>
	<%
	}
qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Resource Type" href="ResourceBooking/ResType.jsp"><FONT face="Arial" color =white size=2>Res. Type</font></a><br>

   	<% }
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Room Usage" href="ResourceBooking/RoomUsage.jsp"><FONT face="Arial" color =white size=2>Room Usage</font></a><br>
    <% }
	%>
	<% 
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Role Master" href="ResourceBooking/RoleMaster.jsp"><FONT face="Arial" color =white size=2>Role Master</font></a><br>
    <% }
	%>
	<% 
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Right Master" href="ResourceBooking/RightMaster.jsp"><FONT face="Arial" color =white size=2>Right Master</font></a><br>
    <% }
	%>
	<% 
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="No Booking Time Slot" href="ResourceBooking/NoBookingTimeSlot.jsp"><FONT face="Arial" color =white size=2>No Booking Time Slot</font></a><br>
    <% }
 
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="No Resource Booking" href="ResourceBooking/NoResourceBooking.jsp"><FONT face="Arial" color =white size=2>No Resource Booking </font></a>
    <% }
	qry="Select WEBKIOSK.ShowLink('275','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Resource Master" href="ResourceBooking/ResourceMaster.jsp"><FONT face="Arial" color =white size=2>Resource Master </font></a><br>
    <% }
	%>
 </span>


<%
    

    qry="Select WEBKIOSK.ShowLink('156','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
    <div class="menutitle" onclick="SwitchMenu('sub9')">Purchase &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub9">


	   <img src="../Images/bullet4.gif">&nbsp;<a  target="_new" title="Purchase Requisition" href="PRI\PurchaseRequisition.jsp"><FONT face="Arial" color =white size=2>Purchase<br><font color='#de6400'>&nbsp; &nbsp</font>Requisition</font></a><br>
	<%
	}
		
	%>
 </span>

<%

   qry="Select WEBKIOSK.ShowLink('188','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
          {

%>

 <div class="menutitle" onclick="SwitchMenu('sub10')">VC Page &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img src="../Images/arrow.gif"></div>
   <span class="submenu" id="sub10">
<%
    

   qry="Select WEBKIOSK.ShowLink('188','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Students VC Remarks" href="../CommonFiles/VCPage/StudentVCRemarks.jsp"><FONT face="Arial" color =white size=2>Student VC Remarks</font></a><br>	
	<%
	}
	 
qry="Select WEBKIOSK.ShowLink('188','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Students VC Remarks" href="../CommonFiles/VCPage/ALLStudentVCRemarks.jsp?MEMTYPE=S"><FONT face="Arial" color =white size=2>View Students VC<br><font color='#de6400'>&nbsp; &nbsp</font>Remarks </font></a><br>	
	<%
	}

	qry="Select WEBKIOSK.ShowLink('188','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Students VC Remarks" href="../CommonFiles/VCPage/ALLStudentVCRemarks.jsp?MEMTYPE=E"><FONT face="Arial" color =white size=2>View Employees VC<br><font color='#de6400'>&nbsp; &nbsp</font>Remarks </font></a><br>	
	<%
	}

      }
      %>
 </span>

 <%


qry="Select WEBKIOSK.ShowLink('262','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
//out.print(qry);
      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	
	%>

 <div class="menutitle" onclick="SwitchMenu('sub10')">BI Tool &nbsp; &nbsp; &nbsp;  &nbsp;<img src="../Images/arrow.gif"></div>
 <span class="submenu" id="sub10">

<div class="menutitlee" onclick="SwitchMenue('sub104')"><img src="../Images/entearrow.jpeg" width=15><FONT SIZE="2" COLOR="">STUD-RESULT</FONT><img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub104">
 <%
    //testgrd  MarksEntryStatus.jsp        specialapproval.jsp

 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 Rs = db.getRowset(qry);
  if (Rs.next() && Rs.getString("SL").equals("Y"))
  {
  %>
  <img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="SubjectWiseFailStudent" href="BITOOL/SubjectWiseFailStudentList.jsp"><FONT face="Arial" color =white size=2>FailStudentList
	</font></a><br>
<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentCGPA" href="BITOOL/StudentCGPAPercentage.jsp"><FONT face="Arial" color =white size=2>StudentCGPA
 </font></a><br>
  <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/EmpExamMarksStatusList.jsp"><FONT face="Arial" color =white size=2>Marks Entry Status</font></a><br>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/Studenttranscript.jsp"><FONT face="Arial" color =white size=2>Student Transcript</font></a>	

 



	<%
	}
	%>
 </span>


<div class="menutitlee" onclick="SwitchMenue('sub105')"><img src="../Images/entearrow.jpeg" width=15><FONT SIZE="2" COLOR="">&nbsp;&nbsp;BI-T&P&nbsp;&nbsp;</FONT><img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub105">
 <%
    //testgrd  MarksEntryStatus.jsp        specialapproval.jsp

 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 Rs = db.getRowset(qry);
  if (Rs.next() && Rs.getString("SL").equals("Y"))
  {
  %>
	  <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/placementstatus.jsp"><FONT face="Arial" color =white size=2>Placement Status
	  </font></a>
	  <br>	
	  <img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Student Hostel" href="BITOOL/asdfg.jsp"><FONT face="Arial" color =white size=2>Visited Company
	  </font></a>
		

	<%
	}
	%>
 </span>


 <div class="menutitlee" onclick="SwitchMenue('sub107')"><img src="../Images/entearrow.jpeg" width=15><FONT SIZE="2" COLOR="">COUNSELLING</FONT><img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub107">
 <%

 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 Rs = db.getRowset(qry);
  if (Rs.next() && Rs.getString("SL").equals("Y"))
   {
  %>


   <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/appstatus.jsp"><FONT face="Arial" color =white size=2>Appplication Status
	  </font></a>
	  <br>	
	  <img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Student Hostel" href="BITOOL/rankwiseappstatus.jsp"><FONT face="Arial" color =white size=2>No.of App. in given Rank
	  </font></a>
  <%
   }
   %>
 </span>
 <div class="menutitlee" onclick="SwitchMenue('sub103')"><img src="../Images/entearrow.jpeg" width=15><FONT SIZE="2" COLOR="">&nbsp;BI-FEE&nbsp;</FONT><img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub103">
 <%
   
 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 Rs = db.getRowset(qry);
  if (Rs.next() && Rs.getString("SL").equals("Y"))
  {
  %>

<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/mis.jsp"><FONT face="Arial" color =white size=2>Registration<br>(Count&FeesPaid)
	</font></a> <br>
<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/feediscount.jsp"><FONT face="Arial" color =white size=2>Fee Discount</font></a><br>
<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Student Hostel" href="BITOOL/feecollectionbankjvcash.jsp"><FONT face="Arial" color =white size=2>Fee Collection (Bank,Cash&JV)
	</font></a>
	<br>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/FeeCollectionReport.jsp"><FONT face="Arial" color =white size=2>Fee Collection
	</font></a><br>
<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/Feepaidanddues.jsp"><FONT face="Arial" color =white size=2>FeePaid & Dues
	</font></a> <br>
<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/Feerefund.jsp"><FONT face="Arial" color =white size=2>Fee Refund
	</font></a> <br>

  <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentCGPA" href="BITOOL/specialapproval.jsp"><FONT face="Arial" color =white size=2>Special Approval(Stud.)
 </font></a><br>	

 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/quotawiseregistrationstatus.jsp"><FONT face="Arial" color =white size=2>Registration Status(Quota Wise)

	<%
	
	%>
 </span>
 <div class="menutitlee" onclick="SwitchMenue('sub122')"><img src="../Images/entearrow.jpeg" width=15><FONT SIZE="2" COLOR="">&nbsp;&nbsp;BI-STUDENT&nbsp;&nbsp;</FONT><img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub122">
 <%
  }
 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
 Rs = db.getRowset(qry);
  if (Rs.next() && Rs.getString("SL").equals("Y"))
  {
  %>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/StudHostel.jsp"><FONT face="Arial" color =white size=2>Student Hostel
 </font></a>
	<br>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentCGPA" href="BITOOL/Studentscholarship.jsp"><FONT face="Arial" color =white size=2>StudentScholarship
 </font></a><br>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/Studenttranscript.jsp"><FONT face="Arial" color =white size=2>Student Transcript</font></a><br>	

 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/StudentDiscidetail.jsp"><FONT face="Arial" color =white size=2>Student Disciplinary
 Deatil.</font></a><br>	
 <img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="StudentShortAtt" href="BITOOL/attendancepercenWisebreackup.jsp"><FONT face="Arial" color =white size=2>ATT.Precentage Breakup</font></a><br>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/StudentShortAttendance.jsp"><FONT face="Arial" color =white size=2>StudentShortAtt.</font></a><br>	
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Programwisestudentstrenght" href="BITOOL/testgrd.jsp"><FONT face="Arial" color =white size=2>Prog.wise stud Strenght grid</font></a><br> 
 
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="EligibleStudent" href="BITOOL/StudPerformance.jsp"><FONT face="Arial" color =white size=2>EligibleStudent
 </font></a><br>	
 <!--<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentCGPA" href="BITOOL/specialapproval.jsp"><FONT face="Arial" color =white size=2>Special Approval(Stud.)
 </font></a><br>-->
 <!--<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Programwisestudentstrenght" href="BITOOL/Programwisestudentstrenght.jsp"><FONT face="Arial" color =white size=2>Prog.wise stud Strenght</font></a><br>-->
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Programwisestudentstrenght" href="BITOOL/Programwisestudentstrenghtnew.jsp"><FONT face="Arial" color =white size=2>Prog.wise stud Strenght NEW</font></a><br>
 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Programwisestudentstrenght" href="BITOOL/Programwisestudentstrenghtupgrade.jsp"><FONT face="Arial" color =white size=2>Prog.wise stud Strenght <IMG SRC="../Images/ar2.gif" WIDTH="16" HEIGHT="16" BORDER="0" ALT=""></font></a><br>

 <!-- <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Programwisestudentstrenght" href="BITOOL/Programwisestudentstrenghtupgrademm.jsp"><FONT face="Arial" color =white size=2>Prog.wise stud Strenght with search </font></a><br> -->
 <%
 }
 %>
 </span>
 <div class="menutitlee" onclick="SwitchMenue('sub111')"><img src="../Images/entearrow.jpeg" width=15 ><FONT SIZE="2" COLOR="">&nbsp;BI-EMPLOYEE</FONT> <img src="../Images/arrow.gif"></div>
 <span class="submenue" id="sub111">
 <%
 qry="Select WEBKIOSK.ShowLink('263','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

    Rs = db.getRowset(qry);
    if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>
	

	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="StudentShortAtt" href="BITOOL/Increament.jsp"><FONT face="Arial" color =white size=2>Increament-List</font></a>

	</font></a>
	<br>       
	
	 <img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/typewiseStaffStrenght.jsp"><FONT face="Arial" color =white size=2>Staff LIst
	</font></a>
	<br>
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Student Hostel" href="BITOOL/DeptwiseStaffStrenght.jsp"><FONT face="Arial" color =white size=2>Deptt.Staff Strenght
	</font></a>
	<br> 
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="Student Hostel" href="BITOOL/visitingfaculty.jsp"><FONT face="Arial" color =white size=2>Visiting faculty
	</font></a>
	<br>
	
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/employeemisconduct.jsp"><FONT face="Arial" color =white size=2>Employee Disciplinary</font></a>
	
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/joininglist.jsp"><FONT face="Arial" color =white size=2>Joining List
	</font></a>
	<br>
	
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/resiginglist.jsp"><FONT face="Arial" color =white size=2>Resigning List
	</font></a>
	<br>
	
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/Onleave.jsp"><FONT face="Arial" color =white size=2>On Leave(EMP.)List
	</font></a>
	<br>
	
	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Student Hostel" href="BITOOL/Manpowerlist.jsp"><FONT face="Arial" color =white size=2>ManPower List
	</font></a>
	<br>
	
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/sel.jsp"><FONT face="Arial" color =white size=2>Shortlisted candidates(vacancy Wise)	</font></a><br>
	
	<!-- --- -->
	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/shortlisted.jsp"><FONT face="Arial" color =white size=2>Shortlisted candidates
	</font></a><br>


	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/vacancyn.jsp"><FONT face="Arial" color =white size=2>Vacancy Wise Application
	</font></a><br>

	<img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/vacancyfloated.jsp"><FONT face="Arial" color =white size=2>Vacancy floated 
	</font></a><br>

	<!-- <img src="../Images/bullet4.gif">&nbsp;<a target="DetailSection" title="FeeCollectionReport" href="BITOOL/vacancy.jsp"><FONT face="Arial" color =white size=2>test1
	</font></a><br> -->
	
	<!-- ---- -->
	</span></span>
	<%
	}
	qry="Select WEBKIOSK.ShowLink('188','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";

      Rs = db.getRowset(qry);
      if (Rs.next() && Rs.getString("SL").equals("Y"))
	{
	%>

	<img src="../Images/bullet4.gif">&nbsp;<a  target="DetailSection" title="Students VC Remarks" href="../CommonFiles/VCPage/ALLStudentVCRemarks.jsp?MEMTYPE=E"><FONT face="Arial" color =white size=2>View Employees VC<br><font color='#de6400'>&nbsp; &nbsp</font>Remarks </font></a><br>	
	<%
	}

    }  
      %>
 </span>




   </td>
   </tr>
<!--
<!--
<TR>
	<TD nowrap><img src="../Images/bull.gif">&nbsp;<A Target='_New' HREF='UG-1.xls'><FONT face="Arial" color =white size=2><STRONG>UG-1 Time Table</STRONG></FONT></A></TD>
</TR>

<tr>
	<TD nowrap><img src="../Images/bull.gif">&nbsp;<A href="UG-2.xls" target='_New'><FONT face="Arial" color =white size=2><STRONG>UG-2 Time Table</STRONG></FONT></A></TD>
</tr>

<TR>
	<TD nowrap><img src="../Images/bull.gif">&nbsp;<A href="UG-3.xls" target=_New><FONT face="Arial" color =white size=2><STRONG>UG-3 Time Table</STRONG></FONT></A></TD>
</tr>

<TR>
    	<TD nowrap><img src="../Images/bull.gif">&nbsp;<A href="UG-4.xls" target=_New><FONT face="Arial" color =white size=2><STRONG>UG-4 Time Table</STRONG></FONT></A></TD>
</TR>

<tr>
    	<TD nowrap><img src="../Images/bull.gif">&nbsp;<A href="PG.xls" target=_New><FONT face="Arial" color =white size=2><STRONG>PG Time Table</STRONG></FONT></A></TD>
</tr>

<tr><td><img src="../Images/bull.gif">&nbsp;<A Target='_New' HREF='FAS/TDSDeclaration.jsp?Type=I'><FONT face="Arial" size =2 color=white><STRONG>TDS Decleration</STRONG></FONT></a></td></tr>
<tr><td><img src="../Images/bull.gif">&nbsp;<A Target='_New' HREF='FAS/TDSDeclaration.jsp?Type=D'><FONT face="Arial" size =2 color=white><STRONG>TDS Decleration</STRONG></FONT></a></td></tr>
<tr><td><img src="../Images/bull.gif">&nbsp;<A Target='_New' HREF='FAS/TDSDeclaration.jsp?Type=H'><FONT face="Arial" size =2 color=white><STRONG>TDS Decleration</STRONG></FONT></a></td></tr>
-->
<TR>

<TD><img src="../Images/bull.gif">&nbsp;<A title="FAQ" href="../FAQ/FAQEmployee.HTML" target="New"><FONT face="Times New Roman" color =white size=2><STRONG>FAQ</STRONG></FONT></A></TD></TR></FONT></FONT> 




<TD><img src="../Images/bull.gif"><A title="User Manual" href="../FAQ/KIOSK.pdf" target="New">
<FONT face="Times New Roman" color="yellow" size=3><STRONG>User Manual</STRONG></FONT></A>
</TD></TR></FONT></FONT> 
<%

// if (mMemberID.equals("UNIV-M00004") || mMemberID.equals("UNIV-C00003"))
//{
%>
	<!-- <br><A href="AcademicInfo/EMP_changestudchoice.jsp" target=DetailSection"><font color=Blue><b>Student Re-Choice</b></font></A><br><br> -->
<%
//}


qry="Select WEBKIOSK.ShowLink('46','"+ mMemberID +"','E','"+mRole+"','"+ mIPAddress +"') SL from dual";
//out.print(qry);
Rs = db.getRowset(qry);
if (Rs.next() && Rs.getString("SL").equals("Y"))
{
%>
</tr>
<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Change Password" href="../CommonFiles/ChangePassword.jsp" title="Change password" target="DetailSection"><FONT face="Times New Roman" size =2 color=white><STRONG>Change Password</STRONG></FONT></A></TD>
</tr>
<%
}
%>

<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Secret Question" href="../CommonFiles/AskSecretQuestion.jsp" target="DetailSection"><FONT face="Times New Roman" size =2 color=white><STRONG>Secret Question</STRONG></FONT></A></TD>
</tr>
<tr>
	<td valign=Top><img src="../Images/bull.gif">&nbsp;<A title="Logout/Signout" href="javascript:UnLoadWindows();" onClick()="javascript:self.window.close();"><FONT face="Times New Roman" size =2 color=white><STRONG>Logout</STRONG></FONT></A></td>
</tr>
</TBODY></TABLE>
<%

 //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
  }
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
   }
  //-----------------------------
}
else
{

	out.print("<br><img src='../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
out.print(e.getMessage());
}
%>
</BODY></HTML>