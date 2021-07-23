<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*"%>
<%@ page errorPage="../../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
GlobalFunctions gb=new GlobalFunctions();

int mWFLvl=0,mDelWFLvl=0,mApplWFLvl=0;
int mTotal=0, n=0, n1=0, nnn=0;
int mFlag=0, mDelFlag=0, mRecFlag=0, ChkFlag=0, UpdtFrWFDetTblFlag=0;
int mWFSeq=0, mWFLevel=0;
double QryTotReqVal=0;
String mApprAuth="", mApprBy="", mWFCode="";
String QryDept="", mChangeCase="";
String mChk="",mReqNxt="", mActCurr="", mSetTextToFwd="", mTextToFwd="";
String qry="", AL1Val="";
HashSet AL1=new HashSet();
String mInst="", mComp="";
String mMemberID="", mDMemberID="";
String mMemberType="", mDMemberType="";
String mMemberCode="", mDMemberCode="";
String QryRID="", QryFaculty="", QryWFCode="", QryWFType="", QryDOA="", QryDOR="";
String QryChDvFor="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName10="",mName11="",mName12="",mName13="";

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

if (session.getAttribute("MemberID")==null)
{
	AL1Val="";
}
else
{
	AL1Val="NotNull";
	AL1=(HashSet)session.getAttribute("AddLevel");
}

if(request.getParameter("EID")==null)
{
	QryFaculty="";
}
else
{
	QryFaculty=request.getParameter("EID").toString().trim();	
}

if(request.getParameter("RID")==null)
{
	QryRID="";
}
else
{
	QryRID=request.getParameter("RID").toString().trim();	
}

if(request.getParameter("WFType")==null)
{
	QryWFType="";
}
else
{
	QryWFType=request.getParameter("WFType").toString().trim();	
}

if(request.getParameter("WFCode")==null)
{
	QryWFCode="LTC";
}
else
{
	QryWFCode=request.getParameter("WFCode").toString().trim();	
}

if(request.getParameter("DOA")==null)
{
	QryDOA="";
}
else
{
	QryDOA=request.getParameter("DOA").toString().trim();
}

if(request.getParameter("DOR")==null)
{
	QryDOR="";
}
else
{
	QryDOR=request.getParameter("DOR").toString().trim();
}

if(request.getParameter("Divert")==null)
{
	QryChDvFor="";
}
else
{
	QryChDvFor=request.getParameter("Divert").toString().trim();
}

if(request.getParameter("REQVAL")==null)
{
	QryTotReqVal=0;
}
else
{
	QryTotReqVal=Double.parseDouble(request.getParameter("REQVAL").toString().trim());
}

if (request.getParameter("TotalCount")==null)
{
	mTotal=0;
}
else
{
	mTotal=Integer.parseInt(request.getParameter("TotalCount").toString().trim());
}

if(QryChDvFor.equals("CurrCase"))
	mChangeCase="[for this request only]";
else if(QryChDvFor.equals("CurrEmp"))
	mChangeCase="[for this employee only]";
else if(QryChDvFor.equals("CurrDept"))
	mChangeCase="[for this department only]";

//out.print("EID "+QryFaculty+" WFCode "+QryWFCode+" WFType "+QryWFType+" From "+QryDOA+" To "+QryDOR+" Root for "+QryChDvFor);

String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ <%=gb.toTtitleCase(QryWFCode)%> Request Approval ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<SCRIPT LANGUAGE="JavaScript"> 
function un_check()
{
 for (var i = 0; i < document.frm.elements.length; i++) 
 {
  var e = document.frm.elements[i]; 
  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
  { 
   e.checked = document.frm.allbox.checked;
  }
 }
}
</SCRIPT>
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
	
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals(""))
	{
		OLTEncryption enc=new OLTEncryption();
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
		qry="Select WEBKIOSK.ShowLink('171','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			// For Log Entry Purpose
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
			//--------------------------------------
			%>
			<form name="frm"  method="get" >
			<input id="x" name="x" type=hidden>
			<table id=id1 width=100% ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Divert/Change Route For <%=QryWFCode%> [<%=QryWFType%>] Work Flow</B></font><br><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><%=mChangeCase%></font></TD>
			</font></td></tr>
			</TABLE>
			<!--Hiddens****-->
			<input type=hidden Name='WFCode' ID='WFCode' value='<%=QryWFCode%>'>
			<input type=hidden Name='WFType' ID='WFType' value='<%=QryWFType%>'>
			<input type=hidden Name='RID' ID='RID' value='<%=QryRID%>'>
			<input type=hidden Name='EID' ID='EID' value='<%=QryFaculty%>'>
			<input type=hidden Name='DOA' ID='DOA' value='<%=QryDOA%>'>
			<input type=hidden Name='DOR' ID='DOR' value='<%=QryDOR%>'>
			<input type=hidden Name='Divert' ID='Divert' value='<%=QryChDvFor%>'>
			<input type=hidden Name='REQVAL' ID='REQVAL' value='<%=QryTotReqVal%>'>
			<%
			//----------------------
			if(QryChDvFor.equals("CurrCase"))
			{
				if (request.getParameter("TotalCount")!=null && Integer.parseInt(request.getParameter("TotalCount").toString().trim())>0)
				{
					//out.print("Total : "+mTotal);
					for (int i=1;i<=mTotal;i++)
					{
						mRecFlag=0;
						mName1="ApprAuth_"+String.valueOf(i).trim();
						mName2="ApprByH_"+String.valueOf(i).trim();
						mName3="ApprByO_"+String.valueOf(i).trim();
						mName4="ApprByE_"+String.valueOf(i).trim();
						mName5="ApprByD_"+String.valueOf(i).trim();
						mName6="Checked_"+String.valueOf(i).trim();
						mName7="WFLevel_"+String.valueOf(i).trim();
						mName8="WFSeq_"+String.valueOf(i).trim();
						mName9="SelfDept_"+String.valueOf(i).trim();
						mName10="RequiredNext_"+String.valueOf(i).trim();
						mName11="ActiveCurr_"+String.valueOf(i).trim();
						mName12="SetTextToFwd_"+String.valueOf(i).trim();
						mName13="TextToFwd_"+String.valueOf(i).trim();

						if(request.getParameter(mName6)!=null)
							mChk=request.getParameter(mName6);
						else
							mChk="";

						if(request.getParameter(mName10)!=null)
							mReqNxt=request.getParameter(mName10);
						else
							mReqNxt="";

						if(request.getParameter(mName11)!=null)
							mActCurr=request.getParameter(mName11);
						else
							mActCurr="";

						if(request.getParameter(mName12)!=null)
							mSetTextToFwd=request.getParameter(mName12);
						else
							mSetTextToFwd="";

						if(request.getParameter(mName13)!=null)
							mTextToFwd=request.getParameter(mName13);
						else
							mTextToFwd="";
						//out.print(mSetTextToFwd +" "+ mTextToFwd);

						if (request.getParameter(mName7)!=null)
							mWFLevel=Integer.parseInt(request.getParameter(mName7));
						else
							mWFLevel=0;

						if (request.getParameter(mName8)!=null)
							mWFSeq=Integer.parseInt(request.getParameter(mName8));
						else
							mWFSeq=0;

						if (request.getParameter(mName9)!=null)
							QryDept=request.getParameter(mName9).toString().trim();
						else
							QryDept="";
			//--------------------------------------------------
						if(mChk.equals("UnChecked"))
						{
							UpdtFrWFDetTblFlag++;

							qry="Select nvl(APPROVALBY,' ')APPROVALBY from WF#WORKFLOWDETAIL where COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"' AND WFLEVEL='"+mWFLevel+"' AND REQUESTID='"+QryRID+"'";
							rs=db.getRowset(qry);
							if(rs.next())
							{
								mApprAuth=rs.getString("APPROVALBY");
							}
							qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
							rs=db.getRowset(qry);
							if(rs.next())
							{
								qry="UPDATE WF#REQUESTWORKFLOWPATH SET APPROVALBY='E', APPROVALAUTHORITY='"+mApprAuth+"', APPROVALTEXTTOBEDISPLAYED='"+mTextToFwd+"' WHERE REQUESTID='"+QryRID+"' AND";
								qry=qry+" COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
								n=db.update(qry);
							}
							else
							{
								qry="INSERT INTO WF#REQUESTWORKFLOWPATH (REQUESTID, COMPANYCODE, INSTITUTECODE, DEPARTMENTCODE, WFSEQUENCE, WFLEVEL, APPROVALBY, APPROVALAUTHORITY, APPROVALTEXTTOBEDISPLAYED)";
								qry=qry+"VALUES ('"+QryRID+"', '"+mComp+"', '"+mInst+"', '"+QryDept+"', '"+mWFSeq+"', '"+mWFLevel+"', 'E', '"+mApprAuth+"', '"+mTextToFwd+"')";
								n=db.insertRow(qry);
							}
						}
			//--------------------------------------------------
						else if(mActCurr.equals("E") && mChk.equals("Checked"))
						{
							if (request.getParameter(mName1)!=null)
								mApprBy=request.getParameter(mName1);
							else
								mApprBy="";
							if(mApprBy.equals("H"))
							{
								if (request.getParameter(mName2)!=null)
									mApprAuth=request.getParameter(mName2);
								else
									mApprAuth="";
								int len=0, pos1=0, pos2=0;
								len=mApprAuth.length();
								pos1=mApprAuth.indexOf("[");
								pos2=mApprAuth.indexOf("]");
								mApprAuth=mApprAuth.substring(pos1+1,pos2);
							}
							else if(mApprBy.equals("O"))
							{
								if (request.getParameter(mName3)!=null)
									mApprAuth=request.getParameter(mName3);
								else
									mApprAuth="";
							}
							else if(mApprBy.equals("E"))
							{
								if (request.getParameter(mName4)!=null)
									mApprAuth=request.getParameter(mName4);
								else
									mApprAuth="";
							}
							else if(mApprBy.equals("D"))
							{
								if (request.getParameter(mName5)!=null)
									mApprAuth=request.getParameter(mName5);
								else
									mApprAuth="";
							}
							if(mChk.equals("Checked"))
							{
							//-------------
							//--Update here
							//-------------
							   if(mSetTextToFwd.equals("Y"))
							   {
								qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
								rs=db.getRowset(qry);
								if(rs.next())
								{
									qry="UPDATE WF#REQUESTWORKFLOWPATH SET APPROVALBY='"+mApprBy+"', APPROVALAUTHORITY='"+mApprAuth+"', APPROVALTEXTTOBEDISPLAYED='"+mTextToFwd+"' WHERE REQUESTID='"+QryRID+"' AND";
									qry=qry+" COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
									n=db.update(qry);
								}
								else
								{
									qry="INSERT INTO WF#REQUESTWORKFLOWPATH (REQUESTID, COMPANYCODE, INSTITUTECODE, DEPARTMENTCODE, WFSEQUENCE, WFLEVEL, APPROVALBY, APPROVALAUTHORITY, APPROVALTEXTTOBEDISPLAYED)";
									qry=qry+"VALUES ('"+QryRID+"', '"+mComp+"', '"+mInst+"', '"+QryDept+"', '"+mWFSeq+"', '"+mWFLevel+"', '"+mApprBy+"', '"+mApprAuth+"', '"+mTextToFwd+"')";
									n=db.insertRow(qry);
								}
								//out.print(qry);
							   }
							   else if(!mSetTextToFwd.equals("Y"))
							   {
								qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
								rs=db.getRowset(qry);
								if(rs.next())
								{
									qry="UPDATE WF#REQUESTWORKFLOWPATH SET APPROVALBY='"+mApprBy+"', APPROVALAUTHORITY='"+mApprAuth+"' WHERE REQUESTID='"+QryRID+"' AND";
									qry=qry+" COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
									n=db.update(qry);
								}
								else
								{
									qry="INSERT INTO WF#REQUESTWORKFLOWPATH (REQUESTID, COMPANYCODE, INSTITUTECODE, DEPARTMENTCODE, WFSEQUENCE, WFLEVEL, APPROVALBY, APPROVALAUTHORITY)";
									qry=qry+"VALUES ('"+QryRID+"', '"+mComp+"', '"+mInst+"', '"+QryDept+"', '"+mWFSeq+"', '"+mWFLevel+"', '"+mApprBy+"', '"+mApprAuth+"')";
									n=db.insertRow(qry);
								}
							   }
							   if(n>0)
							   {
								mFlag=5;
								mRecFlag=mFlag;
								// Log Entry
								//-----------------
								      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"APPROVE "+QryWFCode+" WORK FLOW LEVEL", "WFCode:"+mWFCode+" WFType:"+QryWFType+" Req Dept:"+QryDept+" WFSeq:"+mWFSeq, "NO MAC Address" , mIPAddress);
								//-----------------
							   }
							   mFlag=0;
							}
							else
							{
								ChkFlag++;
							}
						}
			//--------------------------------------------------
						else if(mActCurr.equals("D") && mChk.equals("Checked"))
						{
							qry="Select 'Y' from WF#REQUESTWORKFLOWPATH where REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+mWFSeq+"'";
							rs=db.getRowset(qry);
							if(rs.next())
							{
								qry="DELETE FROM WF#REQUESTWORKFLOWPATH WHERE ";
								qry=qry+" REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
								qry=qry+" AND DEPARTMENTCODE='"+QryDept+"' AND WFLEVEL='"+mWFLevel+"'";
								//out.print(qry);
								n1=db.update(qry);
								if(n1>0)
								{
									// Log Entry
									//-----------------
								      db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"DISCARD "+QryWFCode+" WORK FLOW LEVEL", "WFCode:"+mWFCode+" WFType:"+QryWFType+" Req Dept:"+QryDept+" WFSeq:"+mWFSeq, "NO MAC Address" , mIPAddress);
									//-----------------
									mDelFlag++;
									mDelWFLvl=mWFLevel;

									qry="SELECT nvl(WFLEVEL,0) WFLEVEL FROM WF#REQUESTWORKFLOWPATH WHERE REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
									qry=qry+" AND DEPARTMENTCODE='"+QryDept+"' AND WFLEVEL > "+mDelWFLvl+" order by WFLEVEL ASC";
									rs=db.getRowset(qry);
									//out.print(qry);
									while(rs.next())
									{
										mWFLvl=rs.getInt("WFLEVEL");
										mApplWFLvl=mWFLvl-1;
										//out.print(mApplWFLvl);

										qry="UPDATE WF#REQUESTWORKFLOWPATH SET WFLEVEL='"+mApplWFLvl+"' WHERE";
										qry=qry+" REQUESTID='"+QryRID+"' AND COMPANYCODE='"+mComp+"' AND INSTITUTECODE='"+mInst+"'";
										qry=qry+" AND DEPARTMENTCODE='"+QryDept+"' AND WFLEVEL='"+mWFLvl+"'";
										//out.print(qry);
										int pn=db.update(qry);
									}
								}
							}
						}
			//--------------------------------------------------
					}
					if(mRecFlag>0)
					{
						%><BR><CENTER><%
						out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'>"+gb.toTtitleCase(QryWFCode)+" Work Flow Route has been changed successfully...</font></b><br>");
						%></CENTER><%
					}
					if(mTotal==ChkFlag)
					{
						%><BR><CENTER><%
						out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'>No Record Selected...</font></b><br>");
						%></CENTER><%
					}
					if(mDelFlag>0)
					{
						%><BR><CENTER><%
						out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='green'>"+gb.toTtitleCase(QryWFCode)+" Work Flow Level has been discarded successfully...</font></b><br>");
						%></CENTER><%
					}
				}
			//-----Use Iterator Here------
				if(AL1!=null)
				{
					Iterator itr=AL1.iterator();
					int nnnFlag=0;
					while(itr.hasNext())
					{
						String Ele=(String)itr.next();
						String RID="", COMP="", INST="", DEPT="", APBY="", APAU="", TXTDSP="";
						String SEQ="", LVL="";
						//out.print(Ele);
						int len=0, pos1=0, pos2=0, pos3=0, pos4=0, pos5=0, pos6=0, pos7=0, pos8=0;
						len=Ele.length();
						pos1=Ele.indexOf("///");
						pos2=Ele.indexOf("***");
						pos3=Ele.indexOf("@@@");
						pos4=Ele.indexOf("###");
						pos5=Ele.indexOf("&&&");
						pos6=Ele.indexOf("(((");
						pos7=Ele.indexOf(")))");
						pos8=Ele.indexOf("[[[");
						RID=Ele.substring(0,pos1);
						COMP=Ele.substring(pos1+3,pos2);
						INST=Ele.substring(pos2+3,pos3);
						DEPT=Ele.substring(pos3+3,pos4);
						SEQ=Ele.substring(pos4+3,pos5);
						LVL=Ele.substring(pos5+3,pos6);
						APBY=Ele.substring(pos6+3,pos7);
						APAU=Ele.substring(pos7+3,pos8);
						TXTDSP=Ele.substring(pos8+3,len);
						//out.print("RID - "+RID+" COMP - "+COMP+" INST - "+INST+" DEPT - "+DEPT+" SEQ - "+SEQ+" LEVEL - "+LVL+" APBY - "+APBY+" APAU - "+APAU+" TXTTOBEDSP - "+TXTDSP);

						qry="Select 'Y' from WF#REQUESTWORKFLOWPATH WHERE REQUESTID='"+RID+"' AND COMPANYCODE='"+COMP+"' AND INSTITUTECODE='"+INST+"' AND DEPARTMENTCODE='"+DEPT+"' AND WFSEQUENCE='"+SEQ+"' AND WFLEVEL='"+LVL+"'";
						rs=db.getRowset(qry);
						//out.print(qry);
						if(rs.next())
						{
							qry="UPDATE WF#REQUESTWORKFLOWPATH SET APPROVALBY='"+APBY+"', APPROVALAUTHORITY='"+APAU+"', APPROVALTEXTTOBEDISPLAYED='"+TXTDSP+"' WHERE REQUESTID='"+RID+"' AND";
							qry=qry+" COMPANYCODE='"+COMP+"' AND INSTITUTECODE='"+INST+"' AND DEPARTMENTCODE='"+QryDept+"' AND WFSEQUENCE='"+SEQ+"'";
							nnn=db.update(qry);
						}
						else
						{
							qry="INSERT INTO WF#REQUESTWORKFLOWPATH(REQUESTID, COMPANYCODE, INSTITUTECODE, DEPARTMENTCODE, WFSEQUENCE, WFLEVEL, APPROVALBY, APPROVALAUTHORITY, APPROVALTEXTTOBEDISPLAYED)";
							qry=qry+"VALUES('"+RID+"','"+COMP+"','"+INST+"','"+DEPT+"','"+SEQ+"','"+LVL+"','"+APBY+"','"+APAU+"', '"+TXTDSP+"')";
							nnn=db.insertRow(qry);
						}
						if(nnn>0)
						{
							nnnFlag++;
							qry="Select Employeecode from Employeemaster where employeeid='"+mChkMemID+"'";
							rs=db.getRowset(qry);
							rs.next();
						  //-----------Log Entry------------
							db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType,"WORK FLOW LEVEL ADDITION - FOR "+QryWFCode+"", "WFCode: "+QryWFCode+" WFType: "+QryWFType+" WFLevel: "+LVL+" WFSeq: "+SEQ+" Dept: "+QryDept, "No MAC Address" , mIPAddress);
						  //----------------------------------
						}
					}
					if(nnnFlag>0)
					{
						%><CENTER><br><%
						out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Green'>"+gb.toTtitleCase(QryWFCode)+" WorkFlow Level Addition Successful...</font> <br>");
						%></CENTER><%
						session.removeAttribute("AddLevel");
					}
					else
					{
						%><CENTER><br><%
						out.print("<img src='../../../Images/Error1.gif'>");
						out.print("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Error while adding!</font> <br>");
						%></CENTER><%
					}
				}
			//----------------------------
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
			<h3>	<br><img src='../../../Images/Error1.gif'>	Access Denied (authentication_failed) </h3><br>
			<P>	This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font>	<br>	<br>	<br>	<br>  
			<%
		}
	//-----------------------------
	}
	else
	{
		out.print("<br><img src='../../../Images/Error1.gif'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}
}
catch(Exception e)
{
	out.print(e.getMessage());
}
%>
</form>
</body>
</html>