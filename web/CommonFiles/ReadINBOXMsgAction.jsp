<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
DBHandler db=new DBHandler();
ResultSet Rs=null,rs=null,rsi=null,rs1=null;
GlobalFunctions gb =new GlobalFunctions();
OLTEncryption enc=new OLTEncryption();
int mWFSeq=0;
String qry="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="", mMemberCode="", mDMemberCode="";
String mMemberName="", DT="",mrid="";
String mInst="",memType="",msbj="",msbjdet="";
String memID="", mEmpName="", mEmpCode="";

if (session.getAttribute("InstituteCode")==null)
	mInst="JIIT";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

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

if (request.getParameter("mrid")==null)
	mrid="";
else
	mrid=request.getParameter("mrid").toString().trim();



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Read Information Message First Time ] </TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
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

		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	        RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			
			qry="Update MESSAGESLIST SET READLASTTIME='Y' where  trim(MSGFROMUSERD)||trim(MSGFROMMEMBERTYPE)||trim(to_char(MSGDATETIME,'yyyymmddhh24missss'))='"+mrid+"'";
			int n=db.update(qry);	
			//out.print(qry);

			qry=" SELECT MSGFROMUSERD, nvl(MSGFROMMEMBERTYPE,'E') MSGFROMMEMBERTYPE, MSGSUBJECT, MSGTEXT, to_char(MSGDATETIME,'dd-Mon-yyyy HH:MI PM') DT , nvl(READLASTTIME,'N') FROM MESSAGESLIST Where trim(MSGFROMUSERD)||trim(MSGFROMMEMBERTYPE)||trim(to_char(MSGDATETIME,'yyyymmddhh24missss'))='"+mrid+"'";
			//out.print(qry);				
			RsChk=db.getRowset(qry);

			//out.print(qry);

			%>		
			<br><br><br><br>
			<table border=1 cellpadding=0 cellspacing=0 align=center width="80%">
			<%
			if (RsChk.next())
			{
				
				memID=RsChk.getString("MSGFROMUSERD");
				memType=RsChk.getString("MSGFROMMEMBERTYPE").trim();
				msbj=RsChk.getString("MSGSUBJECT").trim();
				DT = RsChk.getString("DT");
				msbjdet=RsChk.getString("MSGTEXT");
				
				if(memType.equals("E"))
				{
					qry="SELECT nvl(EMPLOYEENAME,' ')ENAME, nvl(EMPLOYEECODE,' ')ECODE from V#EmployeeList WHERE EMPLOYEEID='"+memID+"'";
				}
				else if(memType.equals("S"))
				{
					qry="SELECT nvl(STUDENTNAME,' ')ENAME, nvl(ENROLLMENTNO,' ')ECODE from  V#StudentList WHERE StudentID='"+memID+"' And INSTITUTECODE='"+mInst+"'";
				}
				else if(memType.equals("G"))
				{
					qry="SELECT nvl(GuestNAME,' ')ENAME, nvl(GuestID,' ')ECODE from  V#GuestList WHERE GuestID='"+memID+"' And INSTITUTECODE='"+mInst+"'";
				}
				
				//out.print("<<<"+memType+">>>  "+qry);
				rs=db.getRowset(qry);
				if (rs.next())
				{
					Rs=db.getRowset(qry);
					if(Rs.next())
					{
						mEmpName = Rs.getString("ENAME");
						mEmpCode = Rs.getString("ECODE");
					}
	
					%>
					<tr>
					<td>Message From :</td><td><%=mEmpName%> (<%=mEmpCode%>)</td>
					</tr>
					<tr>
					<td>Subject :</td><td> <%=msbj%></td>
					</tr>
					<td> Date Time :</td><td> <%=DT%></td>
					</tr>					
					<tr>
					<td> Mesage:</td><td> <%=msbjdet%></td>				
					</tr>
					<%		
				}
			}
				%>

				</table>
				<%


		}
		else
		{
			%>
			<br>
			<font color=red>
			<h3><br><img src='../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br><P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
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
//	out.print("Exception e"+qry);	
}
%>
</form>
</body>
</html>