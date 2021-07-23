<%--
    Document   : FeeReceipt
    Created on : 11-01-2019, 3:15:58 PM
    Author     : VIVEK
and sysdate -b.TRANSDATETIME <=1 aRY CHANGE FOR PARTIAL PAYMENT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page language="java" import="java.sql.*,pgwebkiosk.*,java.util.ArrayList, java.util.HashMap, java.util.List, java.util.Map,java.text.DecimalFormat" %>

<%

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="";

%>
<HTML>

<head>
<style type="text/css">
body{

font-size:12px;
}
table{
font-size:12px;
}

.datafont
{
color:red;
color:#590000;
font-weight:bold;
border:#fce9c5;
background:transparent


}
</style>
 <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>
 <script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script language="JavaScript" type ="text/javascript">
	<!--
	  if (top != self) top.document.title = document.title;
	-->

</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script type="text/javascript">

$(document).ready(function(){

 $("#registrationcode").change(function(){

 if(!$("#registrationcode").val()==""){
 $("#errormsg").empty();
    $.getJSON("getStudentDetails.jsp",{institutecode : $("#institutecode").val(),regcode : $("#registrationcode").val(),companycode: $("#companycode").val(),memberid: $(  "#memberid").val(),membercode:$("#membercode").val()},ffff);


	}else{
	clearall();
	}

  });

}); // end of document.ready
function ffff(response){
      $.each(response, function(i, field){
       {
	   setValue(i,field);
	   $("#tabdiv").empty();
	   }
	   // $("div").append(field + " ");
      });



}


function setValue(n,v){

switch(n){

case 'enrollmentno':

$('#enrollno').val(v);
break;


case 'quota':
$('#quota').val(v);
break;

case 'program':
$('#programcode').val(v);
break;

case 'branchcode':
$('#branchcode').val(v);
break;

case 'studentname':
$('#studentname').val(v);
break;

case 'cat':
$('#categorycode').val(v);
break;

case 'acyear':
$('#academicyear').val(v);
break;

case 'sem':
$('#semester').val(v);
break;

case 'semestertype':
$('#semestertype').val(v);
break;



case 'progcode':
$('#progcode').val(v);
break;


case 'fathername':
$('#stdfname').val(v);
break;


case 'dateofbirth':
$('#stddob').val(v);
break;

case 'section':
$('#section').val(v);
break;

case 'subsection':
$('#subsection').val(v);
break;


case 'regforsemester':
$('#regforsemester').val(v);
break;



case 'errormsg':
clearall();
$("#errormsg").empty();
$("#errormsg").append("*"+v + "");
break;

case 'notfound':
clearall();
alert('You are not allow to register in '+$("#registrationcode").val());
break;
}
}

function clearall(){
var v="";
$('#enrollno').val(v);
$('#quota').val(v);
$('#programcode').val(v);
$('#branchcode').val(v);
$('#studentname').val(v);
$('#categorycode').val(v);
$('#academicyear').val(v);
$('#semester').val(v);
$('#semestertype').val(v);
$('#stdfname').val(v);
$('#stddob').val(v);
$('#section').val(v);
$('#subsection').val(v);

$("#errormsg").empty();
 $("#tabdiv").empty();
}

function resetForm(){
clearall();
 $("#tabdiv").empty();
var x=document.getElementById('registrationcode');
x.selectedIndex=0;

x.focus();

}
function validateForm(){

if($("#registrationcode").val()==""){
alert("Please Select Registration Code.");
return false;
}
else if($("#enrollno").val()==""){
alert("Enrollment No can't be blankaa.");
return true;
}
else if($("#quota").val()==""){
alert("Quota can't be blank.");
return false;
}
else if($("#programcode").val()==""){
alert("Program Code can't be blank.");
return false;
}
else if($("#branchcode").val()==""){
alert("Branch Code can't be blank.");
return false;
}
else if($("#studentname").val()==""){
alert("Student Name can't be blank.");
return false;
}
else if($("#academicyear").val()==""){
alert("Academic Year can't be blank.");
return false;
}
else if($("#semester").val()==""){
alert("Current Semester can't be blank.");
return false;
}
else if($("#semestertype").val()==""){
alert("Semester Type can't be blank.");
return false;
}
else{
return true;
}

}


</script>
</head>
<body style="width:96%"; aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<center>
<%
OLTEncryption enc=new OLTEncryption();
String qry="";
DBHandler db=new DBHandler();
GlobalFunctions gb =new GlobalFunctions();
ResultSet rs=null;
String mWebEmail="";
int mSNO=0;
int mData=0;
String mMemberID="";
String mMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mmMemberName="";
String mCompanyCode="";
String mAcademicYearCode="";
String mProgramCode="";
String mBranchCode="";
String mCurrentSem="";
int mCurSem=0;
String mMS="";
String mInstituteCode="";
String mMaxSemester="";

String mSCode="";
int tempc=0;
String pStudentID="";
String programCode="";
String pQuota="";
String academicYear="";
String branchCode="";
String pInstitutecode= "";
String pGlobalCompanyCode="";
String CategoryCode="";
String regCode="";
String progCode="";



String enrollmentno1=request.getParameter("enrollno")==null?"":request.getParameter("enrollno");
String quota1=request.getParameter("quota")==null?"":request.getParameter("quota");
String program1=request.getParameter("programcode")==null?"":request.getParameter("programcode");
String branch1=request.getParameter("branchcode")==null?"":request.getParameter("branchcode");
String studentName1=request.getParameter("studentname")==null?"":request.getParameter("studentname");
String academicYear1=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
String currSecm1=request.getParameter("semester")==null?"":request.getParameter("semester");
String setType1=request.getParameter("semestertype")==null?"":request.getParameter("semestertype");
String sfName=request.getParameter("stdfname")==null?"":request.getParameter("stdfname");
String dob=request.getParameter("stddob")==null?"":request.getParameter("stddob");
String regforsemester1=request.getParameter("regforsemester")==null?"":request.getParameter("regforsemester");
DecimalFormat df = new DecimalFormat("0.00");
boolean validateStudentForFee=false;

try
{
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
	mmMemberName=GlobalFunctions.toTtitleCase(mMemberName.trim());
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mCompanyCode="";
}
else
{
	mCompanyCode=session.getAttribute("CompanyCode").toString().trim();

}

if (session.getAttribute("AcademicYearCode")==null)
{
	mAcademicYearCode="";
}
else
{
	mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
}

if (session.getAttribute("ProgramCode")==null)
{
	mProgramCode="";
}
else
{
	mProgramCode=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranchCode="";
}
else
{
	mBranchCode=session.getAttribute("BranchCode").toString().trim();
}

if (session.getAttribute("CurrentSem")==null)
{
	mCurrentSem="";
}
else
{
	mCurrentSem=session.getAttribute("CurrentSem").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstituteCode="";
}
else
{
	mInstituteCode=session.getAttribute("InstituteCode").toString().trim();
}
if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
{
	try
	{
		mDMemberCode=enc.decode(mMemberCode);
		mMemberID=enc.decode(mMemberID);
	}
	catch(Exception e)
	{
		out.println(e.getMessage());
	}

	String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
	String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
	String mIPAddress=session.getAttribute("IPADD").toString().trim();
	String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());


	ResultSet RsChk=null;

 pStudentID=mMemberID;
 programCode=request.getParameter("programcode")==null?"":request.getParameter("programcode");
 pQuota=request.getParameter("quota")==null?"":request.getParameter("quota");
 academicYear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear");
 branchCode=request.getParameter("branchcode")==null?"":request.getParameter("branchcode");
 pInstitutecode=  mInstituteCode;
 pGlobalCompanyCode=request.getParameter("companycode")==null?"":request.getParameter("companycode");
 CategoryCode=request.getParameter("categorycode")==null?"":request.getParameter("categorycode");
 regCode=request.getParameter("registrationcode")==null?"":request.getParameter("registrationcode");

	progCode=request.getParameter("progcode")==null?"":request.getParameter("progcode");



  //-----------------------------
  //-- Enable Security Page Level
  //-----------------------------
String seqqry="Select WEBKIOSK.ShowLink('275','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
  RsChk= db.getRowset(seqqry);
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   {
  //----------------------


%>







<input id="x" name="x" type=hidden>
<table width="90%" ALIGN=CENTER bottommargin=0  topmargin=0>
<tr>

<TD colspan=0 align=middle><span style="font-weight: bold"><font color="#a52a2a" style="FONT-SIZE: 15px; FONT-FAMILY: verdana">Student On-line fee Payment</font></span></td>
</tr>
</TABLE>
<br>

<!-- My work start -->
<form  action="StudentFeeDetail.jsp">
<input type="hidden" id="institutecode" name="instituteidcode" value="<%=mInstituteCode%>"/>
<input type="hidden" id="companycode" name="companycode" value="<%=mCompanyCode%>"/>
<input type="hidden" id="memberid" name="memberid" value="<%=mChkMemID%>"/>
<input type="hidden" id="membercode" name="membercode" value="<%=mMemberCode%>"/>
<input type="hidden" id="progcode" name="progcode" value="<%=progCode%>"/>
<input type="hidden" id="stdfname" name="stdfname" value="<%=sfName%>"/>
<input type="hidden" id="stddob" name="stddob" value="<%=dob%>"/>

<input type="hidden" id="section" name="section" />
<input type="hidden" id="subsection" name="subsection" />


<table border="0" cellpadding="0" cellspacing="0"  style="width:90%;text-align:left;">
<tr> <td width="13%"><strong> &nbsp;&nbsp;&nbsp;Registration Code:</strong></td>
<td width="87%">
<%

qry=" select REGCODE, REGDESC from registrationmaster b where companycode='"+mCompanyCode+"' and INSTITUTECODE='"+mInstituteCode+"' "+
    " and FEECOLLECTION='Y' and  nvl(REGCOMPLETED,'N')='N' and ( trunc(sysdate) between trunc(REGDATEFROM) and  trunc(REGDATETO) )"+
    " and exists (select 1 from PG#TAGGINGFORONLINEFEE a where "+
    " a.companycode='"+mCompanyCode+"' and a.INSTITUTECODE='"+mInstituteCode+"' and a.ACADEMICYEAR='"+mAcademicYearCode+"' and a.PROGRAMCODE='"+mProgramCode+"' "+
    " and a.BRANCHCODE='"+mBranchCode+"' and a.regcode=b.regcode ) order by REGDATEFROM desc ";

rs=db.getRowset(qry);
//out.print(qry);

	   %>
<select id="registrationcode" name="registrationcode" style="width:250px" tabindex="1">
<option value="" >Select</option>
<%while(rs.next()){
tempc++;
if(rs.getString("regcode").equals(regCode)){
%>
<option value="<%=rs.getString("regcode")%>" selected="selected"><%=rs.getString("regcode")+" == "+rs.getString("regdesc")%></option>

<%
}else{
%>

<option value="<%=rs.getString("regcode")%>" ><%=rs.getString("regcode")+" == "+rs.getString("regdesc")%></option>

<%}}%>


</select>


&nbsp;&nbsp;&nbsp;
	<input type="submit"  id="tickbtn" name="tickbtn" value="" tabindex="2" onClick="return validateForm()"
	style="background:transparent url('images/check.gif') no-repeat top;height:25px;width:30px;background-position:center;" alt="Search">
&nbsp;&nbsp;&nbsp;
	<input type="button" value="" onClick="javascript:resetForm();" style="background:transparent url('images/clear.png') no-repeat top;height:25px;width:30px;background-position:center;" alt="Clear" tabindex="3">

 </td></tr>



</table>
<!-- My work end -->
<table width="90%" style="width:90%" >
  <tr><td width="100%">
<div id="form" style="width:100%;overflow:auto">
<fieldset>
    <legend style="color:#550000;font-weight:bold; ">Student Detail</legend>
    <table width="100%" style="width:100%"  border="0" cellpadding="2" cellspacing="2">
 <tr>
 <td  nowrap="nowrap" ><strong>Enrollment No:</strong></td>
 <td  style="font-weight:bold" ><input type="text" id="enrollno" style="width:100px;height:22px;"  class="datafont" name="enrollno"   readonly  value="<%=enrollmentno1%>"/> </td>
 <td   nowrap="nowrap">
 <strong>Student Name:</strong></td>


 <td  colspan="3">
 <!--
 <input type="text" id="gender" name="gender" size="12px;" readonly value="<%//=sex1%>" />
 --><input type="text" id="studentname" name="studentname" style="width:300px;height:22px;"  class="datafont"  value="<%=studentName1%>" readonly/>
</td>
 <td   nowrap="nowrap" >
 <!--
 <input type="text" id="studenttype" name="studenttype" size="10px;" value="<%//=type1%>"  readonly/>
 -->
 <strong>Program:</strong> </td>
 <td  >

 <input type="text" id="programcode" name="programcode" size="12px;"  value="<%=program1%>" style="width:100px;height:22px;" class="datafont" readonly/>

 </td>
 <td  nowrap="nowrap"><strong>Branch:</strong></td>
 <td  ><input type="text" id="branchcode" name="branchcode" size="12px;"  value="<%=branch1%>"  style="width:100px;height:22px;" class="datafont"  readonly/></td>


 </tr>

 <tr>
 <td  nowrap="nowrap"><strong>Acad. Yr:</strong></td>
 <td ><input type="hidden" id="categorycode" name="categorycode" value="<%=CategoryCode%>" />
 <input type="text" id="academicyear" name="academicyear" value="<%=academicYear1%>" style="width:100px;height:22px;" class="datafont" size="30px;" readonly/>
  </td>
  <td nowrap="nowrap"><strong>Current Semester:</strong></td><td><input type="text" id="semester" class="datafont" style="width:60px;height:22px:transparent"  name="semester" value="<%=currSecm1%>" size="12px;" readonly/></td>
 <td  nowrap="nowrap"  style="text-align:right;vertical-align:middle"><strong>Regis. For Sem.:</strong>
 </td><td>
 <input type="text" id="regforsemester" name="regforsemester"  value="<%=regforsemester1%>" style="width:60px;height:22px;" class="datafont" readonly/>
 </td>

 <td nowrap="nowrap"><strong>Semester Type:</strong></td><td><input type="text" id="semestertype" style="width:100px;height:22px;" class="datafont" name="semestertype" size="12px;" value="<%=setType1%>" readonly/></td>
  <td nowrap="nowrap"><strong>Quota:</strong></td><td><input type="text" id="quota" name="quota" size="12px;" style="width:100px;height:22px;"  class="datafont" value="<%=quota1%>" readonly/></td>
 </tr>
	</table>


   </fieldset>
</div>

</td>

</tr></table>
</form>

<%
if(tempc==0){

%>

<font color="#FF0000" style="font-weight:bold;font-size:12px;" >No Registration Code found for payment option.</font>
<%
}

%>
<font color="#FF0000" style="font-weight:bold;font-size:12px;" ><div id="errormsg"></div></font>




<script type="text/javascript">
	var st1 = new SortableTable(document.getElementById("table-1"),["CaseInsensitiveString","CaseInsensitiveString","Number","Number","Number","Number","Number"]);
</script>


<%//**************************************************************************************************************************

if(request.getParameter("tickbtn")!=null){
%>
<div id="tabdiv" style="width:90%">
<center>
<table  style="width:100%" >
  <tr><td width="54%"><legend style="color:#550000;font-weight:bold;" >&nbsp;Fee Details</legend></td><td width="2%" >&nbsp;</td>

<td width="2%" bgcolor="#00FFFF"></td>
<td width="10%" nowrap="nowrap">Dues are Pending</td>
<td width="2%" bgcolor="#FFFF00"></td>
<td width="19%" nowrap="nowrap">Negative Value(Excess Amount)</td>
</tr></table>
<hr>
</center>
<TABLE cellspacing=0  cellpadding=1 frame =box align="center" border=1
	 borderColor=black borderColorDark=white  style="width:100%">
     <TR align="middle" bgcolor="#ff8c00">
	 <TD width="5%"><P align=center><strong><FONT color=white face=Arial >&nbsp;S No.</FONT></strong></P></TD>
	   <TD width="11%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Registration Code</FONT></strong></P></TD>
	   <TD width="7%"><P align=center><strong><FONT color=white face=Arial>&nbsp;Semester & Type</FONT></strong></P></TD>
	   <TD width="9%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Quota</FONT></strong></P></TD>
	   <TD width="10%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Program Fee</FONT></strong></P></TD>
	   <TD width="11%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Approval Amount</FONT></strong></P></TD>
	   <TD width="10%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Discount</FONT></strong></P></TD>
	   <TD width="11%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Advance in Accounting<br>
       Currency</FONT></strong></P></TD>
	   <TD width="7%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Paid</FONT></strong></P></TD>
	   <TD width="11%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Dues</FONT></strong></P></TD>
       <TD width="13%"><P align=center><strong><FONT color=white face=Arial >&nbsp;Pay Now</FONT></strong></P></TD>
	</TR>




<%

try{
String varAdvance="A";
String varExcess="E";
String WithRegCode="Y";//request.getParameter("withregcode")==null?"":request.getParameter("withregcode");

String pSemester=request.getParameter("semester")==null?"":request.getParameter("semester");
String pSemesterType=request.getParameter("semestertype")==null?"":request.getParameter("semestertype");
String pHostel="";//request.getParameter("hostel")==null?"":request.getParameter("hostel");
String pHostelType="";//request.getParameter("hosteltype")==null?"":request.getParameter("hosteltype");
String pRegcode=request.getParameter("registrationcode")==null?"":request.getParameter("registrationcode");
String Temp="";
String errorStr="";

ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;
ResultSet rs4=null;
ResultSet rs5=null;
ResultSet rs6=null;
boolean mval1=false;

boolean result=false;
int Temp1=0;


String qry1="  Select FeeHead From FeeStructure  Where InstituteCode = '"+pInstitutecode+"'  And CompanyCode = '"+pGlobalCompanyCode+"'"+
            "  And AcademicYear= '"+academicYear+"'  And ProgramCode = '"+progCode+"'  And BranchCode= '"+branchCode+"'"+
            "  And Quota = '"+pQuota+"'  And Nvl('"+WithRegCode+"','N') = 'Y' And SemesterType = '"+pSemesterType+"'"+
            "  And Nvl(Deactive,'N') = 'N'"+
            "  Union All "+
            "  Select FeeHead From FeeStructureIndividual  Where InstituteCode = '"+pInstitutecode+"' And CompanyCode= '"+pGlobalCompanyCode+"'"+
            "  And AcademicYear='"+academicYear+"' And ProgramCode = '"+progCode+"'"+
            "  And BranchCode='"+branchCode+"' And StudentId    = '"+pStudentID+"'  And Nvl('"+WithRegCode+"','N') = 'Y'"+
            "  And SemesterType ='"+pSemesterType+"'  And Nvl(Deactive,'N') = 'N'  And Rownum = 1 ";


String qry2= " Select Distinct fs.FeeHead From C#WaitFeeStructure fs    Where Fs.InstituteCode = '"+pInstitutecode+"'"+
             " And Fs.CompanyCode= '"+pGlobalCompanyCode+"'  And Fs.AcademicYear = '"+academicYear+"'"+
             " And Fs.CategoryCode='"+CategoryCode+"'  And Fs.Quota= '"+pQuota+"'"+
             " And Fs.Semester = '"+pSemester+"' And Fs.SemesterType= '"+pSemesterType+"'  And Nvl(Fs.Deactive,'N')= 'N'";

if(!"".equals(progCode)){
rs1=db.getRowset(qry1);

while(rs1.next()){
Temp=rs1.getString("FeeHead");
if(Temp!=null){
break;
}
}
}else{
rs1=db.getRowset(qry2);

while(rs1.next()){
Temp=rs1.getString("FeeHead");
if(Temp!=null){
break;
}
}
}// end of else block;


if(Temp!=null){
result=true;
}
else{
result=false;
}

if(result==false){
errorStr="Fee structure not found.";
}
else{
String currencyCodeofAccounting="";
String qry3="Select Distinct CurrencyCode 	From CurrencyMaster	Where NVl(Deactive,'N')= 'N'	And AccountingCurrency = 'Y'";
rs2=db.getRowset(qry3);

if(rs2.next()){
currencyCodeofAccounting=rs2.getString(1);
}

if(currencyCodeofAccounting==null || !"".equals(currencyCodeofAccounting))
{
errorStr="Accounting Currency not Found in Currency Master. Contact Administrator..";
}
//=================================================================================//=========================================================
//PROCEDURE popfeeSemester IS
//Cursor 		BWF is
//	-------------------
 String qry4=" Select  b.ProgramCode programcode,b.BranchCode branchcode,Nvl(b.HostelAllow,'N') HostelAllow,Nvl(b.HostelType,'*') HostelType,	rm.RegCode regcode, b.Semester semester, b.SemesterType  semestertype,ExamCode examcode"+
             " From V#SFmStudentRegistration b,RegistrationMaster rm Where rm.RegCode = b.RegCode And rm.InstituteCode	= b.InstituteCode "+
	         " And rm.CompanyCode= b.CompanyCode ANd Nvl(rm.FeeCollection,'N') = 'Y'"+
             " And b.Institutecode  ='"+ pInstitutecode+"' And b.CompanyCode = '"+pGlobalCompanyCode+"' And b.StudentID = '"+pStudentID+"' "+
	         " And Nvl(b.RegAllow,'N') = 'Y' And b.AcademicYear='"+academicYear+"' And nvl(b.ProgramCode,'*') = Nvl('"+ progCode+"','*') "+
             " And  nvl(b.BranchCode,'*')= nvl('"+branchCode+"','*')order by b.Semester desc, b.SemesterType ,rm.RegDateFrom	";

	Temp ="N";

String hostelallow="";
	Map feeDetailMap=new HashMap();
	rs3=db.getRowset(qry4);
	//out.print(qry4);
     List feeDetailList =new ArrayList();
	while(rs3.next()){
        feeDetailMap=new HashMap();
		pSemester=rs3.getString("semester")==null?"":rs3.getString("semester");
	    pSemesterType= rs3.getString("semestertype")==null?"":rs3.getString("semestertype");
		feeDetailMap.put("Semester",pSemester);
		feeDetailMap.put("SemesterType",pSemesterType);
		feeDetailMap.put("Head","Sem-"+pSemester+"("+pSemesterType+")");
		feeDetailMap.put("Hostel",rs3.getString("HostelAllow")==null?"":rs3.getString("HostelAllow"));
		feeDetailMap.put("HostelType",rs3.getString("HostelType")==null?"":rs3.getString("HostelType"));
		feeDetailMap.put("Regcode",rs3.getString("regcode")==null?"":rs3.getString("regcode"));
		feeDetailMap.put("ExamCode",rs3.getString("examcode")==null?"":rs3.getString("examcode"));
		pHostel=hostelallow;
		pHostelType=rs3.getString("HostelType")==null?"":rs3.getString("HostelType");
		//pRegcode=rs3.getString("regcode")==null?"":rs3.getString("regcode");
//out.print(feeDetailMap.get("Regcode"));
		Temp = "Y";
		if("N".equals(hostelallow)){
		feeDetailMap.put("Hostel","N");
		pHostel="N";
		feeDetailMap.put("HostelType","*");
		pHostelType="*";
		}

		feeDetailList.add(feeDetailMap);
		} // end of while loop



if("N".equals(Temp)){
errorStr="Program Code / Branch Code  is not same in StudentRegistration..";

}

double  TempConversionRate=0.0d;
double  TempCurrencyAmount=0.0d;

Map tempMap1=null;
int n=0;
String msem="";
String msemtype="";
String mhostel="";
String mhostelType="";
String mRegCode="";
String mExamCode="";
String qry6="";
String qry9="";
String qry10="";
String qry11="";
String qry7="";
String qry8="";
String qry12="";
String qry13="";
double advCallectionAmt=0.0d;
double advRefund=0.0d;
double advanceAmt=0.0d;
double feeAmt=0.0d;
double disAmt=0.0d;
double paid1Amt=0.0d;
double refundAmt=0.0d;
double approvalAmt=0.0d;
double paidAmt=0.0d;
double duesAmt=0.0d;
double finalPaid=0.0d;
double fineWaiver=0.0d;
boolean validcurrency=true;

int srno=1;

if(feeDetailList.size()==0){
%>
<b><font color="#FF0000">Fee Structure has not been defined, Please contact to registrar/Account department.</font></b>
<%
}

// to cehck if any currency is  other then  accounting currency then is show error message
validcurrency=true;
for(int i=0;i<feeDetailList.size();i++){
feeDetailMap=new HashMap();
tempMap1=new HashMap();
mval1=false;
tempMap1=(Map)feeDetailList.get(i);
msem=tempMap1.get("Semester")==null?"":tempMap1.get("Semester").toString();
msemtype=tempMap1.get("SemesterType")==null?"":tempMap1.get("SemesterType").toString();
mhostel=tempMap1.get("Hostel")==null?"":tempMap1.get("Hostel").toString();
mhostelType=tempMap1.get("HostelType")==null?"":tempMap1.get("HostelType").toString();
mRegCode=tempMap1.get("Regcode")==null?"":tempMap1.get("Regcode").toString();
mExamCode=tempMap1.get("ExamCode")==null?"":tempMap1.get("ExamCode").toString();

qry11=" Select g.CurrencyCode "+
      " From FeeStructure g ,FeeHeads s Where g.InstituteCode= '"+pInstitutecode+"' And g.CompanyCode    = '"+pGlobalCompanyCode+"' And    g.Quota    = '"+pQuota+"' And  "+
	  " g.AcademicYear='"+academicYear+"'"+
      " And    g.ProgramCode= '"+progCode+"' And    g.BranchCode= '"+branchCode+"' And g.Semester= '"+msem+"' And    g.SemesterType='"+msemtype+"' And Nvl(g.FeeAmount,0)> 0 "+
      " And s.FeeHead=    g.FeeHead and s.InstituteCode=g.InstituteCode and s.CompanyCode=g.CompanyCode "+
      " And g.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+pInstitutecode+"' And f.CompanyCode = '"+pGlobalCompanyCode+"' And FeeType = 'H'"+
	  " And '"+mhostel+"' = 'N') And    Not Exists ( Select  Null  From  FeeStructureIndividual FSI1 Where  fsi1.InstituteCode    = '"+pInstitutecode+"'"+
	  " And fsi1.CompanyCode    = '"+pGlobalCompanyCode+"' And fsi1.StudentID= '"+pStudentID+"' And fsi1.AcademicYear = '"+academicYear+"'  And  "+
	  " fsi1.ProgramCode= '"+progCode+"'    And    fsi1.BranchCode    = '"+branchCode+"'  And Nvl(fsi1.Deactive,'N')= 'N' And fsi1.RegCode     = '"+mRegCode+"'"+
	  " And  fsi1.Semester = g.Semester    And    fsi1.SemesterType= g.SemesterType And fsi1.FeeHead= g.FeeHead)  And    Not Exists ( Select  Null  From  "+
	  " FeeStructureCriteria FSC1 Where  FSC1.InstituteCode    = '"+pInstitutecode+"' And FSC1.CompanyCode    = '"+pGlobalCompanyCode+"'"+
	  " And FSC1.AcademicYear = '"+academicYear+"'    And     FSC1.ProgramCode=  '"+progCode+"'    And    FSC1.BranchCode    = '"+branchCode+"' "+
      " And FSC1.Semester = g.Semester    And    FSC1.SemesterType= g.SemesterType And FSC1.FeeHead= g.FeeHead  And FSC1.Quota= g.Quota "+
      " And    (FSC1.Operator IN ('IN','=') And FSC1.CriteriaValue = '"+mhostel+"'))   "+
      " and g.currencycode<>'"+currencyCodeofAccounting+"' "+
      " Union All "+
      " Select   fc.CurrencyCode "+
      " From FeeStructureCriteria fc ,FeeHeads s Where fc.InstituteCode    =  '"+pInstitutecode+"' and fc.CompanyCode    = '"+pGlobalCompanyCode+"'  and "+
	  " fc.Quota= '"+pQuota+"' And    fc.AcademicYear    = '"+academicYear+"'  And    fc.ProgramCode    =  '"+progCode+"' And    fc.BranchCode= '"+branchCode+"' And  "+
	  " fc.Semester= '"+msem+"' And    fc.SemesterType= '"+msemtype+"' AND    NVL(fc.FeeAmount,0) >0  And    (fc.Operator In ('IN','=') And fc.CriteriaValue = '"+mhostel+"') "+
	  " And s.FeeHead=fc.FeeHead    And    s.InstituteCode    = fc.InstituteCode  And  fc.Feehead Not in( Select f.Feehead From Feeheads f Where "+
	  " f.InstituteCode = '"+pInstitutecode+"'  And f.CompanyCode = '"+pGlobalCompanyCode+"' And FeeType = 'H'/*'HOSTEL'*/ And '"+mhostel+"' = 'N') "+
	  " And   Not Exists ( Select  Null  From "+
	  " FeeStructureIndividual FSI1    Where  fsi1.InstituteCode= '"+pInstitutecode+"' And fsi1.CompanyCode=  '"+pGlobalCompanyCode+"'"+
      " And    fsi1.StudentID= '"+pStudentID+"'    And    fsi1.AcademicYear= '"+academicYear+"'  And fsi1.ProgramCode= '"+progCode+"'    And    "+
	  " fsi1.BranchCode    = '"+branchCode+"'  And    Nvl(fsi1.Deactive,'N')= 'N' "+
      " And    fsi1.RegCode = '"+mRegCode+"'      And    fsi1.Semester= fc.Semester    And     fsi1.SemesterType= fc.SemesterType    And fsi1.FeeHead= fc.FeeHead) "+
      " and fc.currencycode<>'"+currencyCodeofAccounting+"' "+
      " Union All "+
     //   -- Get Fee From Individual "+
      "  Select I.CurrencyCode "+
      "  From FeeStructureIndividual I,FeeHeads s Where  I.InstituteCode='"+pInstitutecode+"'  And I.CompanyCode= '"+pGlobalCompanyCode+"'  And  "+
	  "  I.StudentID    = '"+pStudentID+"' And I.AcademicYear    ='"+academicYear+"'  and    I.ProgramCode= '"+progCode+"' And    I.BranchCode ='"+branchCode+"' And "+
	  "  Nvl(I.Deactive,'N')= 'N' And    I.RegCode ='"+mRegCode+"' And    I.Semester    = '"+msem+"' And I.SemesterType='"+msemtype+"'"+
      "  And s.FeeHEad  = I.FeeHEad And  s.InstituteCode     = I.InstituteCode "+
      "  And    I.Feehead Not in( Select f.Feehead From Feeheads f Where f.InstituteCode = '"+pInstitutecode+"' and "+
	  "  f.CompanyCode = '"+pGlobalCompanyCode+"' And f.FeeType = 'H' And '"+mhostel+"' = 'N')  and i.currencycode<>'"+currencyCodeofAccounting+"'";


	rs3=db.getRowset(qry11);
if(rs3.next()){
validcurrency=false;

}

}// end of for loop


if(!validcurrency){
%>
<b><font color="#FF0000">You are not eligible  to pay online fee.</font></b>
<%
}

/////////////////////////< to show data of table >//////////////////////

for(int i=0;i<feeDetailList.size();i++) {
feeDetailMap=new HashMap();
tempMap1=new HashMap();
mval1=false;
tempMap1=(Map)feeDetailList.get(i);
msem=tempMap1.get("Semester")==null?"":tempMap1.get("Semester").toString();
msemtype=tempMap1.get("SemesterType")==null?"":tempMap1.get("SemesterType").toString();
mhostel=tempMap1.get("Hostel")==null?"":tempMap1.get("Hostel").toString();
mhostelType=tempMap1.get("HostelType")==null?"":tempMap1.get("HostelType").toString();
mRegCode=tempMap1.get("Regcode")==null?"":tempMap1.get("Regcode").toString();
mExamCode=tempMap1.get("ExamCode")==null?"":tempMap1.get("ExamCode").toString();
//out.print(mRegCode);

//qry6=qry6+" semester= ";
 advCallectionAmt=0.0d;
 advRefund=0.0d;
 advanceAmt=0.0d;
 feeAmt=0.0d;
 disAmt=0.0d;
 paid1Amt=0.0d;
 refundAmt=0.0d;
 approvalAmt=0.0d;
 paidAmt=0.0d;
 duesAmt=0.0d;
 finalPaid=0.0d;
 fineWaiver=0.0d;

 qry7= "Select Sum(nvl(ApprovalAmount,0)) ApprovalAmount From StudentSpecialApproval Where InstituteCode= '"+pInstitutecode+"'"+
		     " And CompanyCode = '"+pGlobalCompanyCode+"' And ForSemester= '"+msem+"'	And SemesterType= '"+msemtype+"'"+
		     " And StudentID= '"+pStudentID+"' And	RegCode	= '"+mRegCode+"' And	Trunc(DateOfApproval) <= Trunc(Sysdate) "+
			 " And nvl(Trunc(ApprovalUpTo),Trunc(Sysdate)) >= Trunc(Sysdate) And Nvl(Status,'P')='P' "+
		     " And Feehead Not in (Select F.FeeHead From FeeHeads f Where f.InstituteCode = '"+pInstitutecode +"'"+
		     " And  F.CompanyCode    = '"+pGlobalCompanyCode+"' And f.Feetype  = 'H' And '"+mhostel+"' = 'N' ) ";


 qry8=" Select nvl(x.PaidAmount,0) PaidAmount From (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransactionDetail d, FeeTransaction m,Feeheads h "+
	        " Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"' "+
	        " And m.AcademicYear = '"+academicYear+"'	And  m.Quota='"+pQuota+"' And	m.ForRegCode='"+mRegCode+"' "+
	        " ANd m.CompanyCode = d.CompanyCode And m.InstituteCode   = d.InstituteCode And m.FinancialYear=d.FinancialYear "+
	        " And m.TransactionType = d.TranSactionType And m.TransactionType	='R' And m.PRNO	=d.PRNO	And D.Feehead=h.FeeHead "+
	        " And d.CompanyCode = h.Companycode And h.FeeType	Not In ('"+varAdvance +"','"+varExcess+"')	And Nvl(d.FeePaidSemester,0)= Nvl('"+msem+"',0) "+
	        " And Nvl(d.SemesterType,'*')=Nvl('"+msemtype+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
            " fc.Prno = d.prno And fc.Slno = d.slno  AND fc.feehead = d.Feehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
	        " And fc.FinancialYear = d.FinancialYear And TransactionType = d.Transactiontype AND ConversionRateFlag = 'N'  "+
	        " And Fc.RecvCurrencyCode != D.FeeCurrencyCode) "+
            "  Union All "+
	        " Select nvl(Sum(Nvl(d.FeeCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h "+
	        " Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode ='"+pGlobalCompanyCode+"' And m.StudentID= '"+pStudentID +"'"+
	        " And m.AcademicYear= '"+academicYear+"' And   m.Quota='"+pQuota+"' And	m.ForRegCode= '"+mRegCode+"'"+
	        "  ANd m.CompanyCode = d.CompanyCode And m.InstituteCode  = d.InstituteCode And   m.FinancialYear=d.FinancialYear "+
	         "  And m.TNO=d.TNO And D.TOFeeheadOrGlID	= h.FeeHead And	d.CompanyCode = h.Companycode And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') "+
	         " And Nvl(d.Semester,0)= Nvl('"+msem+"',0)	And Nvl(d.SemesterType,'*')=Nvl('"+msemtype+"','*') And m.Docmode	!= 'C' "+
	         " AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE fc.Tno = d.Tno And fc.Slno = d.slno  AND fc.Tofeehead = d.ToFeeheadOrGlID "+
	         " And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear "+
	         " AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode) )x ";


 qry9=" Select nvl(nvl(x.PaidAmount,0),0) PaidAmount From (Select Sum(Nvl(d.FeeCurrencyAmount,0)) PaidAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
	        "  Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"'"+
"	And m.AcademicYear= '"+academicYear+"' And  m.Quota='"+pQuota+"' And m.ForRegCode='"+mRegCode+"' ANd	m.CompanyCode = d.CompanyCode "+
"	And m.TransactionType='P' And	m.PRNO	= d.PRNO And m.Transactiontype	=d.TransactionType And   m.FinancialYear  = d.FinancialYear "+
"	And m.instituteCode=d.InstituteCode And D.Feehead=h.FeeHead And	d.CompanyCode = h.Companycode And h.FeeType Not in ('"+varAdvance +"','"+varExcess+"') "+
"	And Nvl(d.RefundType,'*') <> 'R' And Nvl(d.FeePaidSemester,0)= Nvl('"+msem+"',0) And Nvl(d.SemesterType,'*')=Nvl('"+msemtype+"','*')"+
"	And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE fc.Prno = d.prno "+
"	And fc.Slno = d.Slno And fc.CompanyCode = d.CompanyCode	And fc.FinancialYear = d.Financialyear	And fc.TransactionType = d.TransactionType "+
"	And InstituteCode = d.InstituteCode AND fc.feehead = d.Feehead And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N') 	 "+
"      Union All "+
"	Select nvl(Sum(Nvl(d.FeeCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode= '"+pInstitutecode+"'"+
"	And m.CompanyCode= '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"' And m.FromAcademicYear= '"+academicYear+"'"+
"	And m.FromQuota	= '"+pQuota+"' And m.FromRegCode='"+mRegCode+"' ANd	m.CompanyCode = d.CompanyCode And m.InstituteCode= d.InstituteCode  "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And	D.FromFeehead=h.FeeHead And d.CompanyCode= h.Companycode  "+
"	And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)	= Nvl('"+msem+"',0) And	Nvl(d.FromSemesterType,'*')=Nvl('"+msemtype+"','*') "+
"	And m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode AND NOT EXISTS (SELECT null FROM FeeTransferDetailFC fc WHERE "+
"	fc.Tno = d.Tno And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.FromCurrencyCode) "+
"     Union All "+
"	Select nvl(Sum(Nvl(Fc.RecvCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc "+
"	Where m.InstituteCode= '"+pInstitutecode+"' And m.CompanyCode	= '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"'"+
"	And m.FromAcademicYear	= '"+academicYear+"' And  m.FromQuota='"+pQuota+"' And m.FromRegCode	='"+mRegCode+"'"+
"	ANd m.CompanyCode = d.CompanyCode And m.InstituteCode = d.InstituteCode And m.FinancialYear=d.FinancialYear "+
"	And m.TNO=d.TNO And D.FromFeehead = h.FeeHead And d.CompanyCode = h.Companycode And h.FeeType Not In ('"+varAdvance +"','"+varExcess+"') "+
"	And Nvl(d.FromSemester,0) = Nvl('"+msem+"',0) And Nvl(d.FromSemesterType,'*')=Nvl('"+msemtype+"','*')And m.DocMode != 'C'  "+
"	And d.FromCurrencyCode <> d.ToCurrencyCode AND fc.Tno = d.Tno And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode "+
"	And fc.InstituteCode = d.InstituteCode And fc.FinancialYear = d.FinancialYear )x ";

 qry10="Select nvl(x.AdvanceAmount,0) AdvanceAmount From (Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmount From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
"	Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"'	And m.StudentID	= '"+pStudentID+"'"+
"	And m.AcademicYear= '"+academicYear+"' And  m.Quota='"+pQuota+"' And	m.ForRegCode='"+mRegCode+"' ANd m.CompanyCode= d.CompanyCode "+
"	And m.TransactionType= 'R' And m.PRNO =d.PRNO And m.TransactionType = d.TransactionType "+
"	And m.InstituteCode = d.InstituteCode And m.FinancialYear = d.FinancialYear And d.FeeHead=h.FeeHead "+
"	And d.CompanyCode = h.Companycode And h.Feetype	in ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FeePaidSemester,0)= Nvl('"+msem+"',0) "+
"	And Nvl(d.SemesterType,'*')=Nvl('"+msemtype+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
"	fc.Prno = d.prno And fc.Slno = d.Slno AND fc.feehead = d.Feehead And fc.FinancialYear = d.FinancialYear And fc.InstituteCode = d.InstituteCode "+
"	And fc.CompanyCode = d.CompanyCode And fc.Transactiontype = d.TransactionType And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N')	 "+
"	Union All "+
"	Select nvl(Sum(Nvl(d.FeeAmount,0)),0) AdvanceAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode 	= '"+pInstitutecode+"'"+
"	And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID	='"+pStudentID+"' And m.AcademicYear= '"+academicYear+"' "+
"	And m.Quota='"+pQuota+"' And m.ForRegCode='"+mRegCode+"' ANd m.CompanyCode= d.CompanyCode And m.InstituteCode= d.InstituteCode "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And D.ToFeeheadOrGlID=h.FeeHead And d.CompanyCode     = h.Companycode "+
"	And h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.Semester,0)	= Nvl('"+msem+"',0) And Nvl(d.SemesterType,'*')	=Nvl('"+msemtype+"','*') "+
"	And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE fc.Tno = d.Tno And fc.Slno = d.slno  "+
"	AND fc.Tofeehead = d.ToFeeheadOrGlID And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.ToCurrencyCode) )x ";

 qry11="	Select nvl(x.AdvanceAmountRefund,0) PaidAmount from (Select Sum(Nvl(d.FeeAmount,0)) AdvanceAmountRefund	From FeeTransactionDetail d, FeeTransaction m,FeeHeads h "+
" Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.StudentID='"+pStudentID+"' And m.AcademicYear= '"+academicYear+"'"+
"	And m.Quota='"+pQuota+"' And	m.ForRegCode='"+mRegCode+"' ANd m.CompanyCode = d.CompanyCode And m.TransactionType='P' "+
"	And m.PRNO=d.PRNO And m.InstituteCode   = d.InstituteCode And m.Transactiontype = d.TransactionType And	m.FinancialYear = d.FinancialYear "+
"	And d.FeeHead	=h.FeeHead And d.CompanyCode = h.Companycode And h.Feetype in ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FeePaidSemester,0)= Nvl('"+msem+"',0) "+
"	And Nvl(d.SemesterType,'*')=Nvl('"+msemtype+"','*') And m.DocMode != 'C' AND NOT EXISTS (SELECT 'Y' FROM FEETRANSACTIONDETAILFC fc WHERE "+
"	fc.Prno = d.prno And fc.Slno = d.slno AND fc.feehead = d.Feehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear And TransactionType = d.Transactiontype And Fc.RecvCurrencyCode != D.FeeCurrencyCode "+
"	AND ConversionRateFlag = 'N')	 "+
"	Union All "+
"	Select nvl(Sum(Nvl(d.FeeAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h Where m.InstituteCode= '"+pInstitutecode+"'"+
"	And m.CompanyCode= '"+pGlobalCompanyCode+"'	And m.FromStudentID='"+pStudentID+"' And m.FromAcademicYear = '"+academicYear+"'"+
"	And m.FROMQuota='"+pQuota+"' And m.FromRegCode='"+mRegCode+"' ANd	m.CompanyCode = d.CompanyCode And m.InstituteCode = d.InstituteCode "+
"	And m.FinancialYear=d.FinancialYear And	m.TNO=d.TNO And	D.FromFeehead=h.FeeHead And d.CompanyCode= h.Companycode "+
"	And h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)= Nvl('"+msem+"',0) And Nvl(d.FromSemesterType,'*')=Nvl('"+msemtype+"','*') "+
"	And m.DocMode != 'C' And d.FromCurrencyCode = d.ToCurrencyCode	AND NOT EXISTS (SELECT 'Y' FROM FeeTransferDetailFC fc WHERE "+
"	fc.Tno = d.Tno And fc.Slno = d.slno AND fc.FromFeehead = d.FromFeehead And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear AND ConversionRateFlag = 'N' And Fc.RecvCurrencyCode != D.FromCurrencyCode)  "+
" Union All "+
"	Select nvl(Sum(Nvl(Fc.RecvCurrencyAmount,0)),0) PaidAmount From FeeTransferHead d, FeeTransfer m,Feeheads h,FeetransferDetailFc Fc "+
"	Where m.InstituteCode = '"+pInstitutecode+"' And m.CompanyCode = '"+pGlobalCompanyCode+"' And m.FromStudentID='"+pStudentID+"' "+
"	And m.FromAcademicYear= '"+academicYear+"' And  m.FromQuota='"+pQuota+"' And m.FromRegCode='"+mRegCode+"' ANd m.CompanyCode= d.CompanyCode "+
"	And m.InstituteCode = d.InstituteCode And m.FinancialYear=d.FinancialYear And m.TNO=d.TNO And D.FromFeehead=h.FeeHead "+
"	And d.CompanyCode = h.Companycode And 	h.FeeType In ('"+varAdvance +"','"+varExcess+"') And Nvl(d.FromSemester,0)	= Nvl('"+msem+"',0) "+
"	And Nvl(d.FromSemesterType,'*')	= Nvl('"+msemtype+"','*') And m.DocMode != 'C' And d.FromCurrencyCode <> d.ToCurrencyCode	"+
"	AND fc.Tno = d.Tno And fc.Slno = d.slno And fc.CompanyCode = d.CompanyCode And fc.InstituteCode = d.InstituteCode "+
"	And fc.FinancialYear = d.FinancialYear "+
"	 )x ";


/////////////////////////////////////////////////////////////////


		  qry6=

"	  Select  SUM(nvl(x.FeeAmount,0)) feeamount "+
" From (Select  Sum(g.FeeAmount) FeeAmount  "+
"    From FeeStructure g,FeeHeads s  "+
"    Where g.InstituteCode='"+pInstitutecode+"' "+
"    And g.CompanyCode='"+pGlobalCompanyCode+"' "+
"    And g.Quota= '"+pQuota+"'"+
"    And g.AcademicYear= '"+academicYear+"' "+
"    And Nvl(g.ProgramCode,'*')= Nvl('"+ progCode+"','*')  "+
"    And Nvl(g.BranchCode,'*')= Nvl('"+ branchCode+"','*') "+
"    And g.Semester=    '"+msem+"'  "+
"    And g.SemesterType       = '"+msemtype  +"'"+
"    ANd Nvl(g.FeeAmount,0)> 0  "+
"    And s.FeeHead=g.FeeHead  "+
"    And s.InstituteCode= g.InstituteCode   "+
"    And S.CompanyCode= g.CompanyCode "+
"    And Nvl(s.Deactive,'N')   = 'N' "+
"    And Nvl(S.FeeType,'*')<>'R'  "+
"    And Not Exists ( Select  Null  "+
"                     From    FeeStructureIndividual FSI1 "+
"                     Where fsi1.InstituteCode= '"+pInstitutecode+"'  "+
"                     And fsi1.CompanyCode='"+pGlobalCompanyCode+"' "+
"                     And fsi1.StudentID= '"+pStudentID+"'"+
"                     And fsi1.AcademicYear= '"+academicYear+"' "+
"                     And Nvl(fsi1.ProgramCode,'*')= Nvl('"+ progCode+"','*') "+
"                     And Nvl(fsi1.BranchCode,'*')= Nvl('"+ branchCode+"','*')  "+
"                      And Nvl(fsi1.Deactive,'N')      = 'N'   "+
"                      And fsi1.Semester  = g.Semester  "+
"                      And fsi1.SemesterType = g.SemesterType "+
"                      And fsi1.FeeHead= g.FeeHead  "+
"                      And fsi1.RegCode='"+mRegCode+"')"+
"    And Not Exists ( Select  Null  "+
"                     From FeeStructureCriteria fsc "+
"                     Where  fsc.InstituteCode   = '"+pInstitutecode+"'  "+
"                     And    fsc.CompanyCode =      '"+pGlobalCompanyCode+"'  "+
"                     And  fsc.AcademicYear = '"+academicYear+"' "+
"                     And  Nvl(fsc.ProgramCode,'*')= Nvl('"+progCode+"','*') "+
"                     And Nvl(fsc.BranchCode,'*')= Nvl('"+ branchCode+"','*')  "+
"                     And fsc.Semester= g.Semester "+
"                     And fsc.SemesterType= g.SemesterType"+
"                     And fsc.FeeHead     = g.FeeHead      "+
"                     And  fsc.Quota = g.Quota  "+
"                     And (fsc.operator IN ('IN','=') And Fsc.CriteriaValue  In('N'))) "+
"   And G.Feehead not in(Select F.FeeHead  "+
"                         From FeeHeads f Where f.InstituteCode = '"+pInstitutecode+"'  "+
"                         And f.CompanyCode     = '"+pGlobalCompanyCode+"'"+
"                         And (f.Feetype = 'H' And '"+mhostel+"' = 'N'))"+
"  Union All "+
"     Select Sum(i.FeeAmount) FeeAmount       "+
"     From    FeeStructureIndividual i, Feeheads s  "+
"     Where  i.InstituteCode= '"+pInstitutecode+"'  "+
"    And i.CompanyCode='"+pGlobalCompanyCode+"' "+
"     And i.StudentID= '"+pStudentID+"'"+
"     And i.AcademicYear = '"+academicYear+"'"+
"     And Nvl(i.ProgramCode,'*')= Nvl('"+progCode+"','*')  "+
"     And Nvl(i.BranchCode,'*') = Nvl('"+ branchCode+"','*')"+
"     And Nvl(i.Deactive,'N')    = 'N'   "+
"     And i.Semester = '"+msem+"'  "+
"     And i.SemesterType= '"+msemtype+"'   "+
"     And s.FeeHead =       i.FeeHead "+
"     And s.InstituteCode = i.InstituteCode "+
"     And S.CompanyCode = i.CompanyCode "+
"     And Nvl(S.FeeType,'*')      <>'R'   "+
"     And Nvl(s.Deactive,'N')   = 'N'  "+
"     And Nvl(i.RegCode,'"+mRegCode+"') = '"+mRegCode+"'       "+
"     And  i.Feehead not in (Select F.FeeHead  "+
"                             From FeeHeads f   "+
"                             Where f.InstituteCode = '"+pInstitutecode+"'     "+
"                             And f.CompanyCode     = '"+pGlobalCompanyCode+"'  "+
"                             And (f.Feetype = 'H' And '"+mhostel+"' = 'N') "+
"                            )  "+
"  UNION aLL "+
"  Select Sum(nvl(Fc.FeeAmount,0)) feeAmount  "+
"  From   FeeStructureCriteria FC,Feeheads s "+
"  Where fc.InstituteCode = '"+pInstitutecode+"'  "+
"  And  fc.CompanyCode = '"+pGlobalCompanyCode+"'    "+
"  And  fc.AcademicYear  = '"+academicYear+"'      "+
"  And Nvl(fc.ProgramCode,'*')= Nvl('"+progCode+"','*')  "+
"  And Nvl(fc.BranchCode,'*') = Nvl('"+ branchCode+"','*')  "+
"  And fc.Quota  = '"+pQuota+"'      "+
"  And  fc.Semester='"+msem+"'   "+
"  And  fc.SemesterType        = '"+msemtype  +"' "+
"  And (fc.operator IN ('IN','=') And Fc.CriteriaValue  In ( '*'))        "+
"  And  s.FeeHead=FC.FeeHead   "+
"  And  s.InstituteCode= FC.InstituteCode  "+
"  And  S.CompanyCode= FC.CompanyCode "+
"  And  Nvl(S.FeeType,'*')     <>'R'   "+
"  And  Nvl(s.Deactive,'N')   ='N' "+
"  And FC.Feehead not  in (Select F.FeeHead  "+
"                         From FeeHeads f   "+
"                         Where f.InstituteCode = '"+pInstitutecode+"'         "+
"                         And f.CompanyCode     = '"+pGlobalCompanyCode+"' "+
"                         And (f.Feetype = 'H' And 'N' = 'N') "+
"                         )   "+
"  And Exists (Select Null    "+
"                 From FeeStructure g      "+
"                 Where g.InstituteCode = '"+pInstitutecode+"'  "+
"                 And  g.CompanyCode='"+pGlobalCompanyCode+"'   "+
"                 And  g.Quota = '"+pQuota+"'  "+
"                 and  g.AcademicYear = '"+academicYear+"'   "+
"                 And  Nvl(g.ProgramCode,'*')= Nvl('"+progCode+"','*')       "+
"                 And  Nvl(g.BranchCode,'*') = Nvl('"+ branchCode+"','*')       "+
"                 And  g.Semester       =       '"+msem+"'      "+
"                 And  g.SemesterType   = '"+msemtype  +"'  "+
"                 And  g.FeeHEad       = fc.FeeHEad            "+
"                 )   "+
"  And  Not Exists ( Select Null       "+
"                     From   FeeStructureIndividual FSI1             "+
"                     Where fsi1.InstituteCode  = '"+pInstitutecode+"' "+
"                     And fsi1.CompanyCode   =  '"+pGlobalCompanyCode+"'  "+
"                     And fsi1.StudentID        = '"+pStudentID+"'"+
"                     And fsi1.AcademicYear     = '"+academicYear+"'  "+
"                     And Nvl(fsi1.ProgramCode,'*')= Nvl('"+progCode+"','*')  "+
"                     And Nvl(fsi1.BranchCode,'*') = Nvl('"+ branchCode+"','*') "+
"                     And Nvl(fsi1.Deactive,'N')  = 'N'  "+
"                     And fsi1.Semester   = FC.Semester     "+
"                     And fsi1.SemesterType = FC.SemesterType "+
"                     And fsi1.FeeHead   = FC.FeeHead "+
"                     And Fsi1.RegCode   ='"+mRegCode+"' "+
"                     And Fsi1.Feehead not in(Select F.FeeHead  "+
"                                             From FeeHeads f "+
"                                             Where f.InstituteCode = '"+pInstitutecode+"' "+
"                                             And f.CompanyCode     = '"+pGlobalCompanyCode+"' "+
"                                             And (f.Feetype = 'H' And '"+mhostel+"' = 'N' ))  "+
"                    ) "+
"  Union All     "+
"      	Select Sum(Nvl(FF.FineAmount,0)- Nvl(FF.WaiverAmount,0)) FeeAmount "+
" 		From FeeFineTransaction FF, FeeTransaction FT,FeeTransactionDetail Ftd,FeeHeads s "+
" 		Where Ft.InstituteCode    = '"+pInstitutecode+"'   "+
" 		And   ft.CompanyCode 			=	'"+pGlobalCompanyCode+"'   "+
" 		And   Ft.AcademicYear     = '"+academicYear+"' "+
"  		And		Nvl(ft.ProgramCode,'*')			= Nvl('"+progCode+"','*')  "+
" 		And		Nvl(ft.BranchCode,'*')			=  Nvl('"+ branchCode+"','*') "+
" 		And   Ft.Quota            = '"+pQuota+"'  "+
" 		And		ft.ForRegCode				=	'"+mRegCode+"'  "+
" 		And   Ft.StudentId        = '"+pStudentID+"' "+
" 		And   Ft.Docmode <> 'C' "+
" 		ANd   Ftd.FeePaidSemester	=	'"+msem+"' "+
" 		ANd   Ftd.SemesterType  	=	'"+msemtype +"' "+
" 		And   Ftd.CompanyCode			=	Ft.CompanyCode "+
" 		And   Ftd.FinancialYear		=	Ft.FinancialYear "+
" 		And   Ftd.Prno						=	Ft.Prno "+
" 		And   Ftd.TransactionType = Ft.TransactionType "+
" 		And   FF.CompanyCode      = Ftd.CompanyCode "+
" 		And   FF.FinancialYear    = Ftd.FinancialYear "+
" 		And   FF.Prno             = Ftd.Prno "+
" 		And   FF.TransactionType  = Ftd.TransactionType	 "+
" 		And   FF.CompanyCode      = Ftd.CompanyCode "+
" 		And   FF.FinancialYear    = Ftd.FinancialYear "+
" 		And   FF.Prno             = Ftd.Prno "+
" 		And   FF.FineFeeHead			=	Ftd.FeeHead "+
" 		And  FF.StudentID				  =	ft.StudentID	 "+
" 		ANd  Nvl(FF.TransactionType,'*') = 'R' "+
" 		And       s.FeeHead				=	Ftd.FeeHead "+
" 		And       s.InstituteCode = Ftd.InstituteCode	 "+
" 		And       S.CompanyCode 	= Ftd.CompanyCode "+
" 		And       Nvl(s.Deactive,'N') = 'N'		 "+
" 		And   'Y' = 'Y'	                       "+
" Union All        "+
"  Select  Sum(Fs.FeeAmount) FeeAmount      "+
"  From C#WaitFeeStructure fs,FeeHeads Fh   "+
"  Where Fs.InstituteCode       = '"+pInstitutecode+"'   "+
"  And Fs.CompanyCode          = '"+pGlobalCompanyCode+"'    "+
"  And Fs.AcademicYear          = '"+academicYear+"'   "+
"  And Fs.CategoryCode          = '"+CategoryCode +"'   "+
"  And Fs.Quota                 = '"+pQuota+"'   "+
"  And Fs.Semester              = '"+msem+"'   "+
"  And Fs.SemesterType              = '"+msemtype  +"' "+
"  And Nvl(Fs.Deactive,'N')= 'N'   "+
"  And Fh.FeeHead            =       fs.Feehead   "+
"  And Fh.InstituteCode    = fs.InstituteCode   "+
"  And Fh.CompanyCode   = fs.CompanyCode   "+
"  And Fh.FeeHead = fs.FeeHead   "+
"  And   Nvl(fh.FeeType,'*')     <>'R'    "+
"  And Nvl(Fh.deactive,'N') = 'N'   "+
"  And   Fs.Feehead not in (Select F.FeeHead  "+
"                           From FeeHeads f      "+
"                           Where f.InstituteCode = '"+pInstitutecode+"'   "+
"                           And f.CompanyCode     = '"+pGlobalCompanyCode+"' "+
"                           And (  f.Feetype = 'H' And '"+mhostel+"' = 'N')          "+
"                           )    "+
"  And '"+progCode+"' Is Null )X  Order By 1 ";
		 // out.print(qry6+"<br><br>");
		/////////////////////////////////////////
// to calculate discount.////////////////
qry12="Select 	Sum(nvl(DiscountAmount,0)) DisAmount From	StudentFeeDiscount	Where	InstituteCode= '"+pInstitutecode+"'"+
	  " And CompanyCode ='"+pGlobalCompanyCode+"' And	AcademicYear= '"+academicYear+"'"+
	  " And	Nvl(ProgramCode,'*')= Nvl('"+progCode+"','*') "+
	  "	And	Nvl(BranchCode,'*')	= Nvl('"+branchCode+"','*') "+
	  "	And	StudentID	= '"+pStudentID+"' "+
	  "	And	RegCode='"+mRegCode+"' 	And   SemesterType= '"+msemtype+"' "+
	  "	And Semester= '"+msem+"'	And	Feehead not in (Select F.FeeHead From FeeHeads f Where f.InstituteCode = '"+pInstitutecode+"' "+
	  " And f.CompanyCode     = '"+pGlobalCompanyCode+"' And ((f.Feetype = 'H' And  '"+mhostel+"' = 'N') ))";

////////////////////////////////////////////////////////////////////////////////////////

rs1=db.getRowset(qry6);
if(rs1.next()){
 double amt=0.0d;
 rs2=db.getRowset(qry7);
 amt=0.0d;
 while (rs2.next()){
 amt=amt+Double.parseDouble(rs2.getString("ApprovalAmount")==null?"0":rs2.getString("ApprovalAmount").toString());
 }
 feeDetailMap.put("Approval",df.format(amt));
approvalAmt=amt;


	rs2=db.getRowset(qry8);

	 amt=0.0d;

		while(rs2.next()){
	        amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());

			}
		paid1Amt=amt;
rs2=db.getRowset(qry9);

	 amt=0.0d;
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());
 		}

	refundAmt=amt;
rs2=db.getRowset(qry10);
	 amt=0.0d;
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("AdvanceAmount")==null?"0":rs2.getString("AdvanceAmount").toString());
		}
		advCallectionAmt=amt;
rs2=db.getRowset(qry11);
	 amt=0.0d;
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("PaidAmount")==null?"0":rs2.getString("PaidAmount").toString());
         	}
     advRefund=amt;


rs2=db.getRowset(qry12);
	 amt=0.0d;
		while(rs2.next()){
	         amt=amt+Double.parseDouble(rs2.getString("DisAmount")==null?"0":rs2.getString("DisAmount").toString());
         	}
     disAmt=amt;

 advanceAmt=advCallectionAmt-advRefund;

 feeAmt=	Double.parseDouble(rs1.getString("feeamount")==null?"0":rs1.getString("feeamount").toString());
 //disAmt=	Double.parseDouble(rs1.getString("DisAmount")==null?"0":rs1.getString("DisAmount").toString());
 paidAmt=paid1Amt;//Double.parseDouble(feeDetailMap.get("Paid1")==null?"0":feeDetailMap.get("Paid1").toString());

 duesAmt=feeAmt-(disAmt+(paid1Amt-refundAmt)+approvalAmt);
finalPaid=paid1Amt-refundAmt;
String bgColor="#FFFFFF";
%>

<TR>
<TD bgcolor="#FFFFFF"  style="text-align:center"><FONT color=black face=Arial ><%=srno%></FONT></TD>
<TD bgcolor="#FFFFFF"><FONT color=black face=Arial ><%=mRegCode%></FONT></TD>
<TD bgcolor="#FFFFFF"><FONT color=black face=Arial><%="Sem-"+msem+"("+msemtype+")"%></FONT></TD>
<TD bgcolor="#FFFFFF"><FONT color=black face=Arial > <%=pQuota%></FONT></TD>

<% bgColor="#FFFFFF";
if(feeAmt<0){
bgColor="#FFFF00";
} %>

<TD bgcolor="<%=bgColor%>" style="text-align:right"><FONT color=black face=Arial ><%=df.format(feeAmt)%></FONT></TD>


<% bgColor="#FFFFFF";
if(approvalAmt<0){
bgColor="#FFFF00";
} %>
<TD bgcolor="<%=bgColor%>" style="text-align:right"><FONT color=black face=Arial ><%=df.format(approvalAmt)%></FONT></TD>

<% bgColor="#FFFFFF";
if(disAmt<0){
bgColor="#FFFF00";
} %>

<TD bgcolor="<%=bgColor%>" style="text-align:right"><FONT color=black face=Arial ><%=df.format(disAmt)%></FONT></TD>


<% bgColor="#FFFFFF";
if(advanceAmt<0){
bgColor="#FFFF00";
} %>

<TD bgcolor="<%=bgColor%>" style="text-align:right"><FONT color=black face=Arial ><%=df.format(advanceAmt)%></FONT></TD>
<% bgColor="#FFFFFF";
if(finalPaid<0){
bgColor="#FFFF00";
} %>
<TD bgcolor="<%=bgColor%>" style="text-align:right"> <FONT color=black face=Arial ><%=df.format(finalPaid)%></FONT></TD>


<% bgColor="#FFFFFF";
if(duesAmt>0){
bgColor="#00FFFF";
}else if(duesAmt<0){
bgColor="#FFFF00";
}

 %>
<TD bgcolor="<%=bgColor%>" style="text-align:right" > <FONT color=black face=Arial ><%=df.format(duesAmt)%></FONT></TD>

<TD  bgcolor="#FFFFFF" style="text-align:center;" > <FONT color=black face=Arial >




<%
srno++;


try{
qry11="select 'Y' from PG#TAGGINGFORONLINEFEE where  COMPANYCODE='"+pGlobalCompanyCode+"'  and INSTITUTECODE='"+pInstitutecode+"'"+
      "   and REGCODE='"+mRegCode+"' and EXAMCODE='"+mExamCode+"'"+
      "  and ACADEMICYEAR='"+academicYear+"' and PROGRAMCODE='"+progCode+"' and BRANCHCODE='"+branchCode+"'  and SEMESTER='"+msem+"' "+
      "  and SEMESTERTYPE='"+msemtype+"' and QUOTA='"+pQuota+"' and   trunc(sysdate) between trunc(FROMDATE) and  trunc(TODATE) ";

//out.print("qry1:"+qry11+"<br>");
rs2=db.getRowset(qry11);
//out.print("qry2:"+qry11+"<br>");
if(rs2.next()){
validateStudentForFee=true;
//out.print("validateStudentForFee 123 : "+validateStudentForFee);
}}catch(Exception e)
	{

}
qry11="select 'Y' from PG#FEETRANSACTIONMASTER A,PG#TRANSACTION B  , studentmaster C WHERE A.TID=B.TID AND B.TRANSACTIONFLAG='S' AND A.REGCODE='"+mRegCode+"'"+
     "  and a.COMPANYCODE='"+pGlobalCompanyCode+"' and a.INSTITUTECODE='"+pInstitutecode+"' and a.STUDENTID='"+pStudentID+"' and b.ENROLLMENTNO='"+enrollmentno1+"'"+
	 " and C.STUDENTID=A.STUDENTID AND C.PROGRAMCODE='"+progCode+"' AND C.BRANCHCODE='"+branchCode+"' AND C.QUOTA='"+pQuota+"' and A.TRANSACTIONSTATUS='S' and sysdate -b.TRANSDATETIME <=1";


rs2=db.getRowset(qry11);

if(rs2.next()){
mval1=true;
}
/*
*
* Note1. : If semester is 1 then dont show pay now button .
* Note2. : If a student having another currency like $ into any fee head . block him to pay fee. (Student's fee cant include other currency.)
*
*/

if(duesAmt>0  && mRegCode.equals(pRegcode)){
if(mval1){%>
<font color="#009900"><b title="Payment for this registration code has been successfully done. Please Contact to Admin for pending posting">
Posting Panding.
</b></font>
<%}
else if(!validcurrency){
%>
&nbsp;
<%
}
else{
//out.print("validateStudentForFee="+validateStudentForFee+"<br>");
if(validateStudentForFee){
validateStudentForFee=false;
String amt1=df.format(duesAmt);
//enc.encrypt
/*String encamt=enc.encrypt(amt1);
String enreg=enc.encode(mRegCode);
String encenroll=enc.encode(enrollmentno1);*/

%>
<a href="StudentFeeHistory.jsp?regcode=<%=mRegCode%>&pamt=<%=amt1%>
&enrollno=<%=enrollmentno1%>
&prog=<%=program1%>
&branch=<%=branch1%>
&academicyear=<%=academicYear1%>
&currsem=<%=currSecm1%>
&sfname=<%=sfName%>
&dob=<%=dob%>
&msem=<%=msem%>
&msemtype=<%=msemtype%>
&mhostel=<%=mhostel%>
&mhosteltype=<%=mhostelType%>
&mcategorycode=<%=CategoryCode%>
&mquota=<%=pQuota%>
&currecyc=<%=currencyCodeofAccounting%>
&WithRegCode=<%=WithRegCode%>
&section=<%=request.getParameter("section")==null?"":request.getParameter("section")%>
&subsection=<%=request.getParameter("subsection")==null?"":request.getParameter("subsection")%>
"
>
Pay Now
 </a>
<%

}else{%>
<font color="#FF0000"><b>No Permission to Pay Online.</b></font>
<%}
%>
<%}
}
%>
</TD>
</TR>
<%
} // end of rs1.next() end of main loop
}// end of for loop
}// end of else block   errorStr="Fee structure not found."

}catch(Exception e ){
System.out.println(e);
}

%>
</table>
</div>
<br><Marquee><A href="FeePaymentTransactionCharges.html" target="_new"  alt="Click here to view on line Transaction Charges details"><font size=4><b>Click to view On Line Transaction Charge detail</a></b></font></Marquee>
<%

}// end of if(request.getParameter("tickbtn")!=null)





%>

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
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team.
	<br>	<br>	<br>	<br></P>
   <%
	}
}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}
}
catch(Exception e)
{
System.out.println(e);
}
%>
</center>
<div></div>
</body>
</html>
