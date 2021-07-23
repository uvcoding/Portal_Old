<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
int n=0;
double mPAID=0,mLWP=0,mTotalLvDays=0;
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="", mComp="";
String mWebEmail="";
String mEname="",mRem="",mEID="";

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

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if(request.getParameter("Remarks")==null)
{
	mRem="";
}
else
{
	mRem=request.getParameter("Remarks").toString().trim();
}

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Cancel Leave Request ] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
</script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script language=javascript>
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
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	OLTEncryption enc=new OLTEncryption();
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

		qry="Select Distinct NVL(INSTITUTECODE,' ')InstCode from institutemaster WHERE nvl(Deactive,'N')='N' ";
		rs=db.getRowset(qry);
		if(rs.next())
			mInst=rs.getString(1);	
		else
			mInst="JIIT";
		
	//-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
	  
		qry="Select WEBKIOSK.ShowLink('165','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
		  	%>
			<form name="frm"  method="post"  >
			<input id="x" name="x" type=hidden>
			<br><br>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: Large; FONT-FAMILY: fantasy"><b>Your Leave Request Is Canceled!!</b></font></td></tr>
			</TABLE>
			<br>
	<%
 	            // For Log Entry 
				//--------------------------------------
				String mLogEntryMemberID="",mLogEntryMemberType="";
				if (session.getAttribute("LogEntryMemberID")==null || session.getAttribute("LogEntryMemberID").toString().trim().equals(""))
					mLogEntryMemberID="";
				else
					mLogEntryMemberID=session.getAttribute("LogEntryMemberID").toString().trim();

				if (session.getAttribute("LogEntryMemberType")==null || session.getAttribute("LogEntryMemberType").toString().trim().equals(""))
					mLogEntryMemberType="";
				else
					mLogEntryMemberType=session.getAttribute("LogEntryMemberType").toString().trim();

				if (mLogEntryMemberType.equals(""))
					mLogEntryMemberType=mMemberType;

				if (mLogEntryMemberID.equals(""))
					mLogEntryMemberID=mMemberID;

				if (!mLogEntryMemberType.equals(""))
					mLogEntryMemberType=enc.decode(mLogEntryMemberType);

				if (!mLogEntryMemberID.equals(""))
					mLogEntryMemberID=enc.decode(mLogEntryMemberID);
					
				
					String mRID="";
					
					mRID=request.getParameter("REQUESTID");
					
					mEID=request.getParameter("EID");

					qry="select EmployeeName from EmployeeMaster where EmployeeID='"+mEID+"' ";
					rs=db.getRowset(qry);
					if(rs.next())
					{
						mEname=rs.getString(1);
					}
					qry="UPDATE LEAVEREQUEST SET STATUS='C', APPROVEDBY='"+mChkMemID+"', APPROVEDDATE=sysdate,APPROVALCANCELREMARKS='"+mRem+"' ";
					qry=qry+" Where REQUESTID='"+mRID+"' ";
					//out.print(qry);
					n=db.update(qry);
					if(n>0)
						{
							// Log Entry
							//-----------------
 							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType,"LEAVE CANCEL", "Staff :"+mEname+" RequestID :"+mRID, "NO MAC ADDRESS",  mIPAddress);
							//-----------------
						response.sendRedirect("CancelLeaveRequest.jsp");
						}
					else
						{
						%><CENTER><%
						out.print("<img src='../../../Images/Error1.jpg'>");
						out.print("<font size=4 color=red face='arial'><b>Error while saving record...</b></font>");
						%></CENTER><%
						}
				

		//-----------------------------
		//-- Enable Security Page Level  
		//-----------------------------
		}//end of RsChk
 	else
   		{
		%>
			<br>
			<font color=red>
			<h3><br><img src='../../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br><br><br> 
   		<%
  		}
		//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}      
}//try end
catch(Exception e)
{
	out.print(" Error is there!!!!");
}
%>
<br><br>
<table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../../Images/CampusConnectLogo.bmp">
<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT>  
</td></tr></table>
</form>
</body>
</html>