<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs6=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0,cSet=0,f=0,z=0,q=0;
String qry="",qry1="",eventcode="",companycode="",qry2="",qry3="",criteriavalue="",qry6="";
String mColor="",mComp="",TRCOLOR="White",mWebEmail="",qry4="";
String mMemberID="",institutecode="",academicyear="",programcode="",sectionbranch="",mSemester="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="",criteriafield="",criteriatable="",link="";
String mInst="",criteriaid="",operator="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";

String mProg="",mBranch="",mAcademicYearCode="";

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
///out.print(mMemberID);
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



if (session.getAttribute("ProgramCode")==null)
{
	mProg="";
}
else
{
	mProg=session.getAttribute("ProgramCode").toString().trim();
}

if (session.getAttribute("BranchCode")==null)
{
	mBranch="";
}
else
{
	mBranch=session.getAttribute("BranchCode").toString().trim();
}

	if (session.getAttribute("AcademicYearCode")==null)
	{
		mAcademicYearCode="";
	}
	else
	{
		mAcademicYearCode=session.getAttribute("AcademicYearCode").toString().trim();
	}

//out.print(mAcademicYearCode);
	if (session.getAttribute("CurrentSem")==null)
	{
		mSemester="";
	}
	else
	{
		mSemester=session.getAttribute("CurrentSem").toString().trim();
	}


String mTime="";
qry="Select to_char(Sysdate,'DD-Mon-yyyy HH:MI:SS PM') mTime from Dual";
rs=db.getRowset(qry);
if (rs.next())
	mTime=rs.getString("mTime");
else
	mTime="";

String mHead="";

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
  mHead=session.getAttribute("PageHeading").toString().trim();
else
  mHead="JIIT ";

%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Alert/Message Window ]<%="sem"+mSemester%> </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>
 <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
<script>
function sorry(){
var f=document.getElementById("f").value;
if(f>0)
        {
alert(" Sorry!! You can't apply.");
  }
   
 }
</script>
<SCRIPT LANGUAGE="JavaScript"> 
	function un_check()
	{
	 for (var i = 0; i < document.frm1.elements.length; i++) 
	 {
	  var e = document.frm1.elements[i]; 
	  if ((e.name != 'allbox') && (e.type == 'checkbox')) 
	  { 
	   e.checked = document.frm1.allbox.checked;
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
<script>
function openWindow( url )
{
  window.open(url, '_blank');
  window.focus();
}
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>

<center>
<!--<marquee direction="right" height="150" scrollamount="5" behavior="scroll" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee1"><img src="../../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/9.jpg"></marquee>
<marquee direction="righttoleft" height="25" width="102%" scrolldelay="50" scrollamount="5" behavior="scroll" loop="0" style="font-family:Verdana;font-size:25px;text-decoration:none;color:#FFFFFF;background-color:navy;" id="Marquee2"><STRONG>Site is Under Construction. Modules will open one by one after sometime.</STRONG></marquee>-->
<%
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{

//out.print(mMemberID);

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
		qry="Select WEBKIOSK.ShowLink('164','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{




/*

qry="select to_char(TRANSDATETIME,'dd-mm-yyyy hh:mi:ss am')TRANSDATETIME  from (select * from LOGTRANSINFO  a where a.MEMBERID ='"+mChkMemID+"'  and a.TRANSTYPE='LASTLOGIN' AND A.TRANSDATETIME < SYSDATE  and a.TRANSDATETIME not in (select max(TRANSDATETIME) from LOGTRANSINFO where MEMBERID ='"+mChkMemID+"'  and TRANSTYPE='LASTLOGIN') ORDER BY A.TRANSDATETIME desc) where rownum<2";
rs=db.getRowset(qry);
if(rs.next())
{
	mTime=rs.getString("TRANSDATETIME");

}*/
%>

<p align=right>
<font color=darkbrown size=2 face='verdana'><b>Welcome , <%=mMemberName%> </b></font>
</p>
<%qry="select 'Y' from  TP#AFTERINTERVIEW " +
        "where INSTITUTECODE='"+mInst+"' and studentid='"+mChkMemID+"'and SELECTED='Y' ";
//out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
    {
z++;
}

if(z>0)
{link="../TP/placementregis_history.jsp";}
else
{
link="../TP/forstudent.jsp";
}       %>
<!--<p align=center >
<a  target="DetailSection" onclick="return sorry();" id="link" title="Pre Registration/Subject Choice Entry" href="<%=link%>"><FONT face="Arial" color ="darkpink" size=2>>>>Click here for Company Regisrtration </font></a><br>
</p>-->

<%/*qry="SELECT distinct NVL(EventCode,'') EventCode,NVL(Companycode,'') Companycode," +
        "nvl(INSTITUTECODE,'') INSTITUTECODE,nvl(ACADEMICYEAR,'') ACADEMICYEAR, " +
        "nvl(PROGRAMCODE,'') PROGRAMCODE,nvl(SECTIONBRANCH,'')SECTIONBRANCH," +
        "nvl(SEMESTER,'') SEMESTER FROM TP#REGISTRATIONPARAMETERS where INSTITUTECODE='"+mInst+"' " +
        " and ACADEMICYEAR='"+mAcademicYearCode+"' and PROGRAMCODE='"+mProg+"' and SECTIONBRANCH='"+mBranch+"' " +
        " and semester='"+mSemester+"' and to_char(sysdate,'dd-mm-yyyy') between  to_char(FROMPERIOD,'dd-mm-yyyy')" +
        " and to_char(TODATE,'dd-mm-yyyy')  ";
//out.print(qry);
rs=db.getRowset(qry);
while(rs.next())
{
eventcode=rs.getString("EventCode")==null?"":rs.getString("EventCode").trim();
companycode=rs.getString("Companycode")==null?"":rs.getString("Companycode").trim();
//out.print("event"+eventcode);
//out.print("company"+companycode);
try{
/*qry1="SELECT  distinct CRITERIAID FROM TP#ELIGIBILITYCRITERIA a,tp#criteriamaster b " +
        "where eventcode='"+eventcode+"' and COMPANYCODE='"+companycode+"'and " +
        " b.CHECKBACKLOG!='Y' and b.CHECKGAP!='Y' ";
qry1="SELECT distinct b.criteriaid FROM tp#eligibilitycriteria a, tp#criteriamaster b WHERE a.eventcode = '"+eventcode+"' AND" +
        " a.companycode = '"+companycode+"' AND nvl(b.checkbacklog,'N') <> 'Y' AND nvl(b.checkgap,'N') <> 'Y' ";
//out.print(qry1);
rs1=db.getRowset(qry1);
while(rs1.next())
{
criteriaid=rs1.getString("CRITERIAID")==null?"":rs1.getString("CRITERIAID");
qry2="SELECT  distinct a.CSET,b.CRITERIATABLE CRITERIATABLE, b.CRITERIAFIELD CRITERIAFIELD FROM " +
        "TP#ELIGIBILITYCRITERIA a, tp#criteriamaster b where a.eventcode='"+eventcode+"' " +
        "and a.COMPANYCODE='"+companycode+"' and a.CRITERIAID='"+criteriaid+"'and a.CRITERIAID=b.CRITERIAID  "+
        " ";
//out.print(qry2);
rs2=db.getRowset(qry2);
while(rs2.next())
{cSet=rs2.getInt("CSET")==0?0:rs2.getInt("CSET");
criteriatable=rs2.getString("CRITERIATABLE")==null?"":rs2.getString("CRITERIATABLE");
criteriafield=rs2.getString("CRITERIAFIELD")==null?"":rs2.getString("CRITERIAFIELD");
qry3="SELECT distinct a.CRITERIAVALUE,b.CRITERIAOPERATORBEFORE FROM TP#ELIGIBILITYCRITERIAVALUE a,TP#ELIGIBILITYCRITERIA b where a.eventcode='"+eventcode+"' and" +
        " a.COMPANYCODE='"+companycode+"' and a.CRITERIAID='"+criteriaid+"' and a.cset='"+cSet+"' " +
        "and a.eventcode=b.eventcode            and a.COMPANYCODE=b.COMPANYCODE            and a.CRITERIAID=b.CRITERIAID            and a.CSET=b.CSET            and a.SLNO=b.SLNO";
//out.print(qry3);
rs3=db.getRowset(qry3);
while(rs3.next())
    {
criteriavalue=rs3.getString("CRITERIAVALUE")==null?"":rs3.getString("CRITERIAVALUE").trim();
qry4="SELECT distinct a.CRITERIAVALUE,b.CRITERIAOPERATORBEFORE FROM TP#ELIGIBILITYCRITERIAVALUE a,TP#ELIGIBILITYCRITERIA b where b.eventcode='"+eventcode+"' and" +
        " b.COMPANYCODE='"+companycode+"' and b.CRITERIAID='"+criteriaid+"' and b.cset='"+cSet+"' " +
        "and a.CRITERIAVALUE='"+criteriavalue+"'";
rs4=db.getRowset(qry4);
while(rs4.next())
    {
operator=rs4.getString("CRITERIAOPERATORBEFORE")==null?"":rs4.getString("CRITERIAOPERATORBEFORE").trim();

}

}//out.print("criteriaid : "+criteriaid+" cSet : "+cSet+" criteriavalue : "+criteriavalue+" oprator :"+operator+"</br>");
qry6="select distinct 'Y' from studentmaster a , "+criteriatable+" b,TP#ELIGIBILITYCRITERIAVALUE c where " +
        "c.criteriaid='"+criteriaid+"' and b."+criteriafield+"  "+operator+" c.criteriavalue and b.studentid='"+mDMemberID+"'" +
        " AND B.studentid = A.STUDENTID ";
//out.print(qry6);
rs6=db.getRowset(qry6);
if(!rs6.next())
    {
f++;
}

  }}

    qry="SELECT distinct b.criteriaid  FROM tp#eligibilitycriteria a, tp#criteriamaster b " +
             "WHERE a.eventcode = '"+eventcode+"'   AND a.companycode = '"+companycode+"'   AND" +
             " nvl(b.checkGAP,'N') = 'Y'";

    rs=db.getRowset(qry);
if(rs.next())
    {
criteriaid=rs.getString(1)==null?"":rs.getString(1).trim();


qry1=" select Distinct 'Y' from v#studentqualification b,v#studentmaster a,tp#eligibilitycriteriavalue c where " +
    "upper(b.qualificationcode) = '12TH' and c.criteriaid = '"+criteriaid+"' " +
    "and '20'||substr(a.academicyear,1,2)-yearofpassing <= c.criteriavalue and" +
    " b.institutecode = a.institutecode and b.studentid = a.studentid and a.academicyear = '"+mAcademicYearCode+"' " +
    " and b.studentid='"+mDMemberID+"' ";
//out.print(qry1);
rs1=db.getRowset(qry1);
if(!rs1.next())
    {
z++;
}
}






//qry2="SELECT  CRITERIAID, CSET, SLNO, SUBSLNO, CRITERIAVALUE FROM TP#ELIGIBILITYCRITERIAVALUE" +
  //      " where CRITERIAID='"+criteriaid+"' and CRITERIAVALUE "+operator+" () <br>";
//out.print(qry2);

//out.print("criteriaid : "+criteriaid+" cSet : "+cSet+"criteriavalue : "+criteriavalue+" oprator :"+operator+"</br>");



}catch(Exception e)
{
 out.print("error is"+e);
 }}*/








		//	qry="SELECT  distinct COUNT(*)  FROM studentmaster a, PG#TAGGINGFORONLINEFEE b WHERE a.studentid = b.TOUSERID    and a.STUDENTID= and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE ";
				
qry=" select  to_char(b.TODATE,'dd Mon yyyy')todate from STUDENTREGISTRATION a,PG#TAGGINGFORONLINEFEE b where        a.PROGRAMCODE='"+mProg+"' AND A.BRANCHCODE='"+mBranch+"'      AND A.ACADEMICYEAR='"+mAcademicYearCode+"'        AND A.INSTITUTECODE='"+mInst+"'    AND a.EXAMCODE=b.EXAMCODE                  AND A.STUDENTID='"+mDMemberID+"'             and    a.INSTITUTECODE=b.INSTITUTECODE and               a.ACADEMICYEAR=b.ACADEMICYEAR                and a.PROGRAMCODE=b.PROGRAMCODE                and A.BRANCHCODE=B.BRANCHCODE    AND A.SEMESTER=B.SEMESTER  and        trunc(sysdate) >= trunc(b.FROMDATE) and trunc(sysdate) <=trunc(b.TODATE)    AND A.STUDENTID IN (SELECT STUDENTID FROM STUDENTMASTER C WHERE C.INSTITUTECODE=A.INSTITUTECODE AND A.STUDENTID=C.STUDENTID    AND NVL(C.DEACTIVE,'N')='N' AND C.QUOTA=B.QUOTA  ) ";	
			// out.print(qry);
				rs=db.getRowset(qry);

				if(rs.next())
			{
			%>
				
			<font size=3 color=Green face=arial>
			<b>
			 Note:- Dear Students you can pay fees online through payment gateway under Fee Detail<br>
			 Last date of Online Fee submission is -: <%=rs.getString("todate")%>
			 </b>
			</font>
<%
			}
				%>

			<!--FLOW CHART
			 <TABLE cellspacing='1' cellpadding='1' border=1>
			<TR>
			<td> <FONT FACE=VERDANA SIZE=2 color=Green ><b>1.</b></font></td>
				<TD > <FONT FACE=VERDANA SIZE=2 color=Green ><B> Attend orientation talks on Elective courses,<br> to be conducted under Deptt.<br> arrangement (watch out for Notices)</B></TD>
				<TD><FONT FACE=VERDANA SIZE=2 color=Green><B> 21-24 April </B>  </TD>
			</TR>

			<TR>
			<td><FONT FACE=VERDANA SIZE=2 color=Green > <b>2.</b></font></td>
				<TD > <FONT FACE=VERDANA SIZE=2 color=Green><B> Consult faculty counselors / Course Coordinators<br> in their Cabins before filling up the details <br>in the Webkiosk</B></TD>
				<TD><FONT FACE=VERDANA SIZE=2 color=Green><B> 26 April 2010 - 1 May 2010 </B>  </TD>
			</TR>

			<TR>
			<td><FONT FACE=VERDANA SIZE=2 color=Green > <b>3.</b></font></td>
				<TD > <FONT FACE=VERDANA SIZE=2 color=Green><B>    View the pre-registration status on Kiosk <br>and inform variations (if any) to the Registrar   </B></TD>
				<TD><FONT FACE=VERDANA SIZE=2 color=Green><B> 14 May 2010 </B>  </TD>
			</TR>
			<TR>
			<td> <FONT FACE=VERDANA SIZE=2 color=Green ><b>4.</b></font></td>
				<TD > <FONT FACE=VERDANA SIZE=2 color=Green><B> You shall be required to deposit fee and take <br>final registration document for next semester.  </B></TD>
				<TD><FONT FACE=VERDANA SIZE=2 color=Green><B> July 2010, as per schedule <br> announced in the academic calendar.  </B>  </TD>
			</TR>
			</TABLE>
			</font> -->
			<%		
			

		///qry="Select 'Y' from StudentMedicalHistory where StudentID='"+mChkMemID+"'";
		//ResultSet rrss=db.getRowset(qry);
		///if(!rrss.next())
		//{
			//response.sendRedirect("StudentMedicalHistoryEntry.jsp");
		//}

			
			
						
/*
   ====================================================================================
   Get Information Message regarding the Leave Approval/Cancellation
   ====================================================================================
*/
			//	qry="Select COUNT(*) from MESSAGEFORME where MEMBERID='"+mDMemberID+"' and MEMBERTYPE='"+mFactType+"' and COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mInst+"' AND nvl(MSGFLAG,'N')='N' AND nvl(DEACTIVE,'N')='N' GROUP BY MEMBERID, MEMBERTYPE, COMPANYCODE, INSTITUTECODE";

			/*
				qry="SELECT  distinct COUNT(*)  FROM studentmaster a, EMAILSENDDETAIL b WHERE a.studentid = b.TOUSERID    and a.STUDENTID='"+mDMemberID+"' and a.INSTITUTECODE='"+mInst+"' and a.INSTITUTECODE=b.INSTITUTECODE ";
				rs=db.getRowset(qry);*/

				//out.print(qry);
				%><br><%
				//if(rs.next())
				//{
					%>
			 		<!-- <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy">
					<table border=0 bordercolor='silver' cellpadding=0 cellspacing=0>
					<tr><td nowrap><FONT COLOR=Blue face=verdana size=2><B> <%=rs.getInt(1)%> new information message to view</b></font></td></tr>
					<tr><td align=center><a target=_new href="GetINBOXMessage.jsp"><img src='../../Images/ClickHere.gif'></a></td></tr>
					</table> -->
					<%
			//	}
/*
  =================================================================================
  =================================================================================

*/
			//-----------------------------
			//---Enable Security Page Level  
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
  }

%>
<br><br><br><br><br><br><br><br><br><br><br><br>
<table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small;border-spacing:1px;border-style:outset;border-color:grey" align=center bordercolor="grey">
                    <TR bgcolor=white>
                    <td>				
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A style="color: white"  href="http://www.campuslynx.in" target=new  color=white><IMG align=center src="../../Images/CampusLynx.png" style="border-color: white">
					</A><br><FONT size =2 style="FONT-FAMILY: ARIal"><b>&nbsp;Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =1 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution&nbsp;</FONT>
					</td><td>
					<FONT size =1 color=BLACK>&nbsp;Software developed and maintained by </font><br>
					<STRONG>&nbsp;<A HREF="http://www.jilit.co.in" target=new><FONT SIZE="2" COLOR="BLACK">JIL Information Technology Ltd.</FONT></A>&nbsp;</STRONG></FONT>
					</td>
					</tr>
					</table><table border="1" class="table" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small;border-spacing:1px;border-style:outset;border-color:grey" align=center bordercolor="grey">
				    <TR bgcolor=white><td><FONT size =1 color=BLACK>&nbsp;For your comments or suggestions please send an email at	 <A tabIndex=8 href="campus.support@jalindia.co.in">&nbsp;<FONT SIZE="1" COLOR="blue">campus.support@jalindia.co.in</FONT></A></FONT></td></TR>
				    </table>   		
</body>
</Html>
