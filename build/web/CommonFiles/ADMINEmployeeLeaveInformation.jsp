<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null,rsi=null,rs1=null,rs2=null,rsc=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
String qry="",qry1="",qry2="";
String mComp="";
String mEmployeeName="",mEmployeeCode="",mDepartment="";
String mMemberID="", mDMemberID="",mIndentDate="",mDesignation="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", mDept="", mDegs="",mDesignation1="";
String mInst="",mtext="",mCurrDate="";
String mDepartment1="",mLeaveYearCode="",mNatureOfJob="";
String mValDate="",mDay="",mFromDate="",mToDate="",mCategoryCode="",mSex=""; 
String mPresentDays="",mLeaveCode="",mLeaveTaken="",mBalance="";
String mHead="", mEmpType="", mEmpID="";
int flag=0;
qry="select to_Char(Sysdate,'dd-mm-yyyy') date1  from dual";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString("date1");

/*if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
	*/
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";

if (request.getParameter("mType")==null)
	mEmpType="";
else
	mEmpType=request.getParameter("mType").toString().trim();
if (request.getParameter("SID")==null)
	mEmpID="";
else
	mEmpID=request.getParameter("SID").toString().trim();



	if (session.getAttribute("COMPCODE")==null)
	{
		mComp="UNIV";
	}
	else
	{
		mComp=session.getAttribute("COMPCODE").toString().trim();
	}


String mInstCode="",qryc="";

if (session.getAttribute("INSCODE")==null)
{
	mInstCode="";
}
else
{
	mInstCode=session.getAttribute("INSCODE").toString().trim();
}


qryc=" select distinct companycode from employeemaster where employeeid='"+mEmpID+"'";
rsc=db.getRowset(qryc);
				if(rsc.next())
				{
				

mComp=rsc.getString("companycode");
}else{

mComp=mComp;
}



%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ View Employee Leave Information] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css"/>
<script language=javascript>
<!--
function RefreshContents()
{ 	
	document.frm.x.value='ddd';
	document.frm.submit();
}
//-->
if(window.history.forward(1) != null)
window.history.forward(1);	
</script>
<STYLE>input {font-size:13px;}</STYLE>
</HEAD>
</head>
<body aLink="#ff00ff" bgcolor="#fce9c5" leftmargin="0" topmargin="0">
<%
try
{
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
		qry="Select WEBKIOSK.ShowLink('216','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	 	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			%>
			<form name="frm"  method="post">
			<input id="x" name="x" type="hidden">
			<input type=hidden value=<%=mEmpID%> id=SID Name=SID>
			<input type=hidden value=<%=mEmpType%> id=mType Name=mType>
			<%
			try
			{
				qry="select distinct nvl(A.EMPLOYEENAME,' ')EMPLOYEENAME,B.DEPARTMENT DEPARTMENT,C.DESIGNATION DESIGNATION from EMPLOYEEMASTER A,DEPARTMENTMASTER B, DESIGNATIONMASTER C where A.employeeid='"+mEmpID+"' and A.DEPARTMENTCODE=B.DEPARTMENTCODE and A.DESIGNATIONCODE=C.DESIGNATIONCODE and nvl(A.DEACTIVE,'N')='N' and nvl(B.DEACTIVE,'N')='N' and nvl(C.DEACTIVE,'N')='N' ";
				//out.println(qry);
				rs=db.getRowset(qry);
				if(rs.next())
				{
					mEmployeeName=rs.getString("EMPLOYEENAME");					
					mDepartment1=rs.getString("DEPARTMENT");
					mDesignation1=rs.getString("DESIGNATION");
				}
			}
			catch(Exception e)
			{
				//out.print("Exception e"+e);
			}
			%>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			  <tr>
			   <td align=left nowrap><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Employee Leave Information</FONT></td>
			   <td align=right nowrap><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial">Login User :&nbsp; &nbsp;<%=mMemberName%>[Emp. Code: <%=mDMemberCode%>]</font></td>
			  </tr>
			</table>
			<center>
			<table align=center cellpadding="0" cellspacing="0" border="0" rules="groups">
			<tr>
				<td colspan=8 nowrap><hr>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Employee Name : </font> </B>
				<font color="#00008b" face=times new roman size=2><b>&nbsp;<%=mEmployeeName%> </b></font>
				<b><FONT face=Arial size=2>&nbsp;&nbsp;Designation : </font> </B>
				<font color="#00008b" face=times new roman><b> &nbsp;<%=GlobalFunctions.toTtitleCase(mDesignation1)%> </b></font>
				<b><FONT face=Arial size=2>&nbsp; Department : </font></B><font color="#00008b" face=times new roman><b>&nbsp;&nbsp;<%=GlobalFunctions.toTtitleCase(mDepartment1)%></b></font><hr>
				</td>
			</tr>							
			</table>
			</center>
			<center>
			<table cellpadding="4" cellspacing="" border="1" rules="groups">
			<tr>
				<td><font face="arial" size="2"><b>Leave Year Code</b>
				&nbsp;&nbsp;
				<%
				qry="Select distinct LEAVEYEARCODE from LEAVEYEAR where COMPANYCODE='"+mComp+"'  order by LEAVEYEARCODE desc ";
				//out.println(qry);
				rs=db.getRowset(qry);
				%>
				<select name="LeaveYearCode" id="LeaveYearCode">
				<%
				try
				{
					while(rs.next())
					{				
						if(request.getParameter("x")==null)
						{
							if(mLeaveYearCode.equals(""))
								mLeaveYearCode=rs.getString("LEAVEYEARCODE");
							%>
							<option value="<%=rs.getString("LEAVEYEARCODE")%>"><%=rs.getString("LEAVEYEARCODE")%></option>
							<%
						}
						else
						{
							if(request.getParameter("LeaveYearCode").equals(rs.getString("LEAVEYEARCODE")))
							{
								%>
								<option selected value="<%=request.getParameter("LeaveYearCode")%>"><%=request.getParameter("LeaveYearCode")%></option>
								<%
							}
							else
							{
								if(!request.getParameter("LeaveYearCode").equals(rs.getString("LEAVEYEARCODE")))
								{
									%>
									<option value="<%=rs.getString("LEAVEYEARCODE")%>"><%=rs.getString("LEAVEYEARCODE")%></option>
									<%
								}
							}
						}
					}
				}
				catch(Exception e)
				{
					//out.println("Exception e:-"+e);
				}
				%>					
				</select>
				&nbsp;&nbsp;<input type="submit" name="show" value="Show" style="FONT-WEIGHT: bold; FONT-SIZE: smaller; FLOAT: none; WIDTH: 60px; HEIGHT: 20px; FONT-VARIANT: normal; cursor:hand; background-color:transparent; border-width:1; border-color:black;">
				</td>
			</tr>
			</table>
			</center>
			<%
			if(request.getParameter("x")!=null)
			{
				if(request.getParameter("LeaveYearCode")==null)
					mLeaveYearCode="";
				else
					mLeaveYearCode=request.getParameter("LeaveYearCode");
			}
			try
			{
				qry="Select Least(sysdate,Todate) valDate,Trunc(Least(sysdate,Todate) -trunc(Fromdate))+1 day,to_char(FromDate,'dd-mm-rrrr')FromDate,to_char((LEAST(trunc(ToDate),trunc(SYSDATE+360))),'dd-mm-rrrr')ToDate from LeaveYear where COMPANYCODE='"+mComp+"' and LEAVEYEARCODE='"+mLeaveYearCode+"'";
			//	out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())  
				{						
					mValDate=rs.getString("valDate");
					mDay=rs.getString("day");
					mFromDate=rs.getString("FromDate");
					mToDate=rs.getString("ToDate");
					//out.println(mToDate+"   sss   "+mFromDate);
				}
				//out.println("aaaa"+mFromDate);
				qry="Select nvl(EMPCATEGORYCODE,'REG')CATEGORYCODE, nvl(SEX,'M') sex from EmployeeMaster where CompanyCode='"+mComp+"' and EmployeeId='"+mEmpID+"'";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())  
				{
					mCategoryCode=rs.getString("CategoryCode");
					mSex=rs.getString("SEX");
					//out.println("mCategoryCode :-"+mCategoryCode+"mSex :-"+mSex);
				}
				qry="Select nvl(NATUREOFJOB,' ') NATUREOFJOB from EMPLOYEEDETAIL where EmployeeId ='"+mEmpID+"'";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())  
				{
					mNatureOfJob=rs.getString("NATUREOFJOB");
					//out.println("aaaaa:-"+mNatureOfJob);
				}
				qry="Select Leave.Present('"+mComp+"','"+mCategoryCode+"','"+mEmpID+"',To_date('"+mFromDate+"','dd-mm-yyyy'),To_date('"+mToDate+"','dd-mm-yyyy')) Present from dual";
				//out.println(qry);
				rs=db.getRowset(qry);
				while(rs.next())  
				{
					mPresentDays=rs.getString("Present");						
				}
			}
			catch(Exception e)
			{
				//out.println("Exception e:-"+e);
			}
			%>
			<center>
			<table>
			<tr>
				<td>
				<font face="Arial" size=2><b>Total Days</b></font> <font face="Arial" size=2 color="navy"><b><%=mDay%></b></font>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; <font face="Arial" size=2><b>Total Present</b></font> <font face="Arial" size=2 color="navy"><b><%=mPresentDays%></font>
				</td>
			</tr>
			</table>
			</center>
			<center>
			<font face="Arial" size=3><u><b>Leave Summary</b></u></font>
			</center>
			<center>
			<TABLE frame=box style="FONT-FAMILY: Arial; FONT-SIZE: x-small"  border=1 bordercolor=Black bordercolordark=White cellpadding=2 cellspacing=0 width="40%">
			<TR  bgcolor=#ffa900>
				<TH><font face="Arial" size=2 color="white">Leave Type</font></TH>
				<TH><font face="Arial" size=2 color="white">Availed</font> </TH>
				<TH><font face="Arial" size=2 color="white">Balance</font></TH>
			</TR>
			<%
			try
			{
			   /*
				//a.LeaveApplicableTo
				qry="select leavecode, leavedescription , nvl(MAINTAINBALANCE,'Y') MAINTAINBALANCE  from  LEAVEMASTER a ";
				qry=qry+" where  nvl(deactive,'N') = 'N' and companycode = '"+mComp+"' and Sexspecific in ('B','"+mSex+"') ";
				qry=qry+" And Decode(nvl(a.LeaveApplicableTo,'B'),'B', Decode(nvl('"+mNatureOfJob+"','N'),'A', 'N', nvl('"+mNatureOfJob+"','N')), nvl(a.LeaveApplicableTo,'B'))= Decode(nvl('"+mNatureOfJob+"','N'),'A', 'N', nvl('"+mNatureOfJob+"','N'))";
				qry=qry+" and ((a.EMPCATEGORYCODE IN ('"+mCategoryCode+"','ALL')) or (a.EMPCATEGORYCODE ='ALL' and not exists(select EMPCATEGORYCODE from leavemaster b where b.EMPCATEGORYCODE ='"+mCategoryCode+"' and b.leavecode = a.leavecode and b.companycode = a.companycode  and b.Sexspecific in ('B','"+mSex+"'))))";
				qry=qry+" union select 'A', 'Absent','N' from Dual union  Select 'LWP', 'LWP','N' from dual";
			   */

//------To find out the leave code-------
				qry="select leavecode, leavedescription , nvl(MAINTAINBALANCE,'Y') MAINTAINBALANCE  from  LEAVEMASTER a ";
				qry=qry+" where  nvl(deactive,'N') = 'N' and companycode = '"+mComp+"' and Sexspecific in ('B','"+mSex+"') ";
				qry=qry+" and EMPCATEGORYCODE in ((Select nvl(EMPCATEGORYCODE,'REG') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mEmpID+"') Union Select 'ALL' from Dual)";
				qry=qry+" and LEAVEAPPLICABLETO in ((Select nvl(EMPLOYEETYPE,'TEC') from EMPLOYEEMASTER where COMPANYCODE='"+mComp+"' and EMPLOYEEID='"+mEmpID+"')  Union Select 'ALL' from Dual)";
				qry=qry+" Union Select 'A', 'Absent','N' from Dual Union Select 'LWP', 'LWP','N' from Dual";
//------To find out the leave code-------

				//out.print(qry);
				rs=db.getRowset(qry);
				while(rs.next())
				{
					mLeaveCode=rs.getString("leavecode");
					//out.println("aaaa:-"+mLeaveCode);
					qry1="Select Leave.TotalLeaveCodeWise('"+mComp+"','"+mEmpID+"',To_date('"+mFromDate+"','DD-MM-YYYY'),To_date('"+mToDate+"','DD-MM-YYYY'),'"+mLeaveCode+"')LEAVETAKEN from dual";
					//out.println(qry1);
					rs1=db.getRowset(qry1);
					while(rs1.next())
					{							
						mLeaveTaken=rs1.getString("LEAVETAKEN");
					}
					qry2="Select Leave.LeaveBalance('"+mComp+"','"+mCategoryCode+"','"+mEmpID+"' ,'"+mLeaveCode+"', To_date('"+mCurrDate+"','dd-mm-yyyy')) Bal from dual";
					//out.print(qry2);
					rs2=db.getRowset(qry2);
					while(rs2.next())
					{
						mBalance=rs2.getString("Bal");
					}
				//	out.println(qry2);
					if(Double.parseDouble(mLeaveTaken)>=0)
					{
						flag++;
						%>
						<TR>
						<TD align="center">&nbsp;<b><%=mLeaveCode%>&nbsp;&nbsp;(<%=rs.getString("leavedescription")%>)</b></TD>
						<TD align="center"><font face="Arial" size=2>&nbsp;<A href="ADMINEmployeeLeaveHistory.jsp?SID=<%=mEmpID%>&amp;LeaveCode=<%=mLeaveCode%>&amp;FromDate=<%=mFromDate%>&amp;ToDate=<%=mToDate%>" target=_New title="Click to show details of leave taken <%=mLeaveCode%> as <%=mLeaveTaken%> day(s)"><%=mLeaveTaken%></a></TD>
						<TD align="center">&nbsp;<%=mBalance%></TD>
						</TR>
						<%
					}						
				}
				if(flag>0)
				{
					%>
					<tr>
					<td colspan=9><marquee style="FONT-FAMILY: fantasy; FONT-SIZE: smaller; FONT-VARIANT: normal; FONT-WEIGHT: normal; HEIGHT: 15px; WIDTH: 297px" behavior=alternate  scrolldelay=200><FONT face="Arial" size=2>Click on Leave Taken column to view details</FONT></marquee></td>
					</tr>
					<%
				}
				else
				{
					%>
					<tr>
					<td colspan=9><marquee scrolldelay=200 style="FONT-FAMILY: cursive; FONT-SIZE: smaller; FONT-VARIANT: normal; FONT-WEIGHT: normal; HEIGHT: 15px; WIDTH: 297px"   behavior=alternate><FONT face="Arial" size=2>Leave available/taken data doesn't exist</FONT></marquee></td>
					</tr>
					<%
				}
			}
			catch(Exception e)
			{
				//out.println("Exception e:-"+e);
			}
			%>
			</table>
			</center>
			<%				
		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br> 
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{	
	//out.print("Exception e"+e);
}
%>
</form>
</body>
</html>