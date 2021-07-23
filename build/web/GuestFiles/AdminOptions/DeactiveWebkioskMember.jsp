<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Lock/UnLock WebKiosk Member ] </TITLE>
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
	document.frm.x.value='ddd';
}
//-->
</script>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
function UserType_onchange() 
{
  var mUserType;
  mUserType=frm.MType.value;
  if (mUserType == 'S')
  {
   frm.txtCode.value  ="Enrollment No";
  }
  else if (mUserType=='E')
  {
   frm.txtCode.value  ="Employee Code";
  }
  else if(mUserType=='G')
  {
   frm.txtCode.value  ="Guest ID";
  }
  else 
  {
   frm.txtCode.value  ="Visitor ID";
  }			
}
function MemberCode_onchange() 
{
  var mUserCode;
  mUserCode=frm.MemberCode.value;	 
  frm.MemberCode.value = mUserCode.toUpperCase();
}
</SCRIPT>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
OLTEncryption enc=new OLTEncryption();
try
{
	DBHandler db=new DBHandler();
	ResultSet rs=null;
	ResultSet rs1=null;
	ResultSet rsd=null;
	ResultSet rse=null;
	ResultSet rss=null,rsi=null;

	String mMType="",mEMType="";
	String mMMType="",mEMMType="";
	String qry="",qry1="",qry2="";
	String mMemberID="";
	String mMemberType="",mInst="";

	String mMemberCode="";
	String mEMemberCode="";
	String mDeactive="";
	String Deactive="Y";
	String mDeac="",mradio="",memployee="",mMcode="",mcode="";

	int flag=0;

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
	if(!mMemberID.equals("") && !mMemberType.equals("")) 
	{
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mMacAddress =" "; //session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk=null;
		
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
	//-----------------------------
	//-- Enable Security Page Level  
	//-----------------------------
		qry="Select WEBKIOSK.ShowLink('68','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			//----------------------
			%>
			<form name="frm">
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0 topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">Lock/Unlock Webkiosk Login ID<br>[Admin User Only]</font></td></tr>
			</table>
		<!*********--Institute--************>
			<INPUT Type="Hidden" Name=Inst id=Inst Value=<%=mInst%>>
			<%
			qry="select distinct nvl(institutecode,' ')IC from INSTITUTEMASTER where nvl(DEACTIVE,'N')='N' ";
			rsi=db.getRowset(qry);
			while(rsi.next())
			{
				mInst=rsi.getString("IC");
			}
			%>
			<table cellpadding=5 align=center rules=groups border=2 style="WIDTH: 330px; HEIGHT: 100px">
			<%
			if(request.getParameter("radio")==null)
			{
				%>
				<tr><TD  colspan=3><B>Lock/Unlock Member : <input id='radio' type='radio' name='radio' value='Y' checked><font color=red>Lock</font></b>
				<input id='radio' type='radio' name='radio' value='N'><b><font color=green>UnLock</font></b></td>
				</tr>
				<%
			}
			else
			{
				mradio=request.getParameter("radio").toString().trim();
				if(mradio.equals("Y"))
				{
					%>
					<tr><TD  colspan=3><B>Lock/Unlock Member : <input id='radio' type='radio' name='radio' value='Y' checked><font color=red>Lock</font></b>
					<input id='radio' type='radio' name='radio' value='N'><b><font color=green>UnLock</font></b></td>
					</tr>
					<%
				}
				else
				{
					%>
					<tr><TD  colspan=3><B>Lock/Unlock Member : <input id='radio' type='radio' name='radio' value='Y' ><font color=red>Lock</font></b>
					<input id='radio' type='radio' name='radio' value='N' checked><b><font color=green>UnLock</font></b></td>
					</tr>
					<%
				}
			}	
			%>
			<tr><td colspan=0><FONT color=black>&nbsp;&nbsp;<FONT face=Arial size=2><STRONG>Member Type</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;</FONT></FONT></td>
			<td><select ID=MType Name=MType language="Javascript" onChange="UserType_onchange()"  onclick="UserType_onchange()"  style="WIDTH: 165px">
			<%
			if(request.getParameter("MType")==null)
			{
				%>
				<option value="S" Selected>Student</option>
		     		<option value="E">Employee</option>
				<option value="G">Guest</option>		
      			<option value="V">Visitor</option>		
				<%
			}
			else
			{
				if(request.getParameter("MType").toString().trim().equals("S"))
				{
					%>
					<option value="S" Selected>Student</option>
					<%
				}
				else
				{
					%>
					<option value="S">Student</option>
					<%
				}
				if(request.getParameter("MType").toString().trim().equals("E"))
				{
					%>
					<option value="E" Selected>Employee</option>
					<%
				}
				else
				{
					%>
					<option value="E">Employee</option>
					<%
				}
				if(request.getParameter("MType").toString().trim().equals("G"))
				{
					%>
					<option value="G" Selected>Guest</option>
					<%
				}
				else
				{
					%>
					<option value="G">Guest</option>
					<%
				}	
				if(request.getParameter("MType").toString().trim().equals("V"))
				{
					%>
					<option value="V" Selected>Visitor</option>
					<%
				}
				else
				{
					%>
					<option value="V">Visitor</option>
					<%
				}
			}
			%>
		 	</select>
			</td></tr><br>
			<tr><td><b>
			<%
			if (request.getParameter("MType")==null)
			{
				mMcode="Enrollment No";
				mcode="";
			}
			else
			{
				mMcode=request.getParameter("txtCode").toString().trim();
				mcode=request.getParameter("MemberCode").toString().trim();
				/*
				if(mMcode.equals("S"))
				mMcode="Enrollment No";
				else if(mMcode.equals("E"))
				mMcode="Employee Code";
				else if(mMcode.equals("G"))
				mMcode="Guest ID"; 
				else 
				mMcode="Visitor ID";
				*/
			}
			%>
			<INPUT Readonly name=txtCode value='<%=mMcode%>' style =" FONT-WEIGHT: bold; BACKGROUND-COLOR: #fce9c5; BORDER-BOTTOM: medium none; BORDER-LEFT-STYLE: none; BORDER-RIGHT-STYLE: none; BORDER-TOP-STYLE: none; 
			FONT-FAMILY: sans-serif; FONT-SIZE: x-small; FONT-STYLE: Bold; HEIGHT: 22px; TEXT-ALIGN: right; 
			VERTICAL-ALIGN: middle; WIDTH: 100px" size=12 lowsrc="" tabIndex=8 width="99"></b></td>
			<td><INPUT ID="MemberCode" Name="MemberCode" value='<%=mcode%>' LANGUAGE=javascript onchange="MemberCode_onchange();" style="WIDTH: 165px; HEIGHT: 25px" maxLength=50><FONT size=3 color=RED>*&nbsp;</FONT></td>
			</tr><tr>	
			<tr><td colspan=2 align=center><INPUT Type="submit" Value="Lock/Unlock Member" onclick="RefreshContents();">&nbsp;<INPUT Type="reset" Value="Reset"></td></tr>
			</table>
			</form>
			<%	
			if(request.getParameter("x")!=null)
			{
				if (request.getParameter("MType")==null)
				{
					mMType="";
					mMcode="Enrollment No";
				}
				else
				{
					mMType=request.getParameter("MType").toString().trim();
					mMcode=request.getParameter("MType").toString().trim();
				}
				if(request.getParameter("MemberCode")==null)
				{
					mMemberCode="";
				}
				else
				{
					mMemberCode=request.getParameter("MemberCode").toString().trim();
				}
				if (request.getParameter("radio")==null)
				{
					mradio="";
				}
				else
				{
					mradio=request.getParameter("radio").toString().trim();
				}
				if(!mMemberCode.equals(""))
				{
					mEMemberCode=enc.encode(mMemberCode);
					mEMType=enc.encode(mMType);
					if(mMType.equals("E"))
					flag=1;
					else if(mMType.equals("S"))
					flag=2;
					else if(mMType.equals("V"))
					flag=3;
					else 
					flag=4;
					if(flag==1)
					{
						qry="select employeename from employeemaster where employeecode='"+mMemberCode+"' ";
						rse=db.getRowset(qry);
						if(rse.next())
						{
							memployee=rse.getString("employeename");
						}
					} // closing of flag
					else if(flag==2)
					{
						qry="select studentname from studentmaster where enrollmentno='"+mMemberCode+"' ";
						rss=db.getRowset(qry);
						if(rss.next())
						{
							memployee=rss.getString("studentname");
						}
					}  // closing of flag2
		
					if(mradio.equals("Y"))
					{
						qry="select nvl(Deactive,'N')Deactive from membermaster Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
						rsd=db.getRowset(qry);
						if(rsd.next())
						{
							mDeac=rsd.getString("Deactive");
						}
						if(mDeac.equals("Y"))
						{
							out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login ID already Locked. </font></b></center>");
						}
						else
						{
							qry="update MEMBERMASTER set DEACTIVE='Y'  Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
							int n=db.update(qry);
				  			if(n>0)	
							{
		            				//---- Log Entry
						  		//-----------------																
								    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"DEACTIVE/ACTIVE WEBKIOSK MEMBER", "DEACTIVE KIOSK MEMBER ,Member Code : "+mMemberCode+" Member Type :"+mMType, "No MAC Address" , mIPAddress);
								//-----------------
								%>
								<table  rules=none border=1 bgcolor=white align=center>
								<tr><td rowspan=3><img src='../../Images/Lock.jpg' height=50 height=50></td>
								<td>&nbsp;</td></tr>
								<tr>
								<td><font color=Green size=3 face='Arial'><b>Login ID of&nbsp;<%=memployee%>&nbsp;has been<font color=Red> Locked </font>successfully...</font></b></td>
								</tr>
								<tr>
								<td>&nbsp;</td>
								</tr>
								</table>
								<%
							}
							else
							{
								out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select valid Member Type or enter valid Login ID</font></b></center>");
							}
						} //*********closing of deactive else
					}// closing of radio button
					else
					{
						qry="select 'Y' from employeemaster where employeecode='"+mMemberCode+"' UNION select 'Y' from studentmaster where enrollmentno='"+mMemberCode+"'";
						rse=db.getRowset(qry);
						//out.print(qry);
						if(rse.next())
						{
						qry="select nvl(Deactive,'N')Deactive from membermaster Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
						rsd=db.getRowset(qry);
						if(rsd.next())
						{
							mDeac=rsd.getString("Deactive");
						}
						if(mDeac.equals("N"))
						{
							out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login ID Alreday Unlocked. </font></b></center>");
						}
						else
						{
							qry="update MEMBERMASTER set DEACTIVE='N'  Where trim(ORATYP)='"+mEMType+"' and trim(ORACD)='"+mEMemberCode+"'";
							int n=db.update(qry);
						//	qry2="INSERT INTO LOGTRANSINFO (MEMBERID, MEMBERTYPE, TRANSTYPE,TRANSDETAIL, MACADDRESS, IPADDRESS,TRANSDATETIME) ";
						//	qry2=qry2+ " VALUES ('"+mChkMemID+"','"+mChkMType+"','Locked Member','"+mMemberCode+" "+mMType+"','"+mMacAddress+"','"+mIPAddress+"',sysdate ) ";
						//	int m=db.insertRow(qry2);
							if(n>0)			  
							{
							//---- Log Entry
						  	//-----------------
							    db.saveTransLog(mInst,mLogEntryMemberID,mLogEntryMemberType ,"DEACTIVE/ACTIVE WEBKIOSK MEMBER", "ACTIVE KIOSK MEMBER ,Member Code : "+mMemberCode+"Member Type :"+mMType, "No MAC Address" , mIPAddress);
							//-----------------
								%>
								<table rules=none border=1 Bgcolor=white align=center>
								<tr><td rowspan=3><img src='../../Images/UnLock.jpg' height=50 height=50></td>
								<td>&nbsp;</td></tr>
								<tr>
								<td><font color=Green size=3 face='Arial'><b>Login ID of&nbsp;<%=memployee%>&nbsp;has been<font color=blue> Unlocked </font>successfully...</font></b></td>
								</tr>
								<tr>
								<td>&nbsp;</td>
								</tr>
								</table>
								<%
							}
							else
							{
								out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select valid Member Type or enter valid Login ID</font></b></center>");
							}
						} //*********closing of deactive else
						}
						else
						{
							out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Login ID is Locked Permanently!</font></b></center>");
						}
					}	
				}
				else
				{
					out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Field(s) can't be empty</font></b></center>");
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
			<h3><br><img src='../../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
			<P>This page is not authorized/available for you.
			<br>For assistance, contact your network support team. 
			</font><br><br>
			<%
		}
		//-----------------------------
	}
	else
	{
		out.print("<center><img src='../../Images/Error1.jpg'>&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font></b></center>");
	}
}
catch(Exception e)
{
}
%>
<hr><table ALIGN=Center VALIGN=TOP>
<tr>
<td valign=middle>
<IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">	<FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT>
</td>
</tr>
</table>
</body>
</html>