<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%
     
            String mVacCode = "";
			String mMemberID ="",mMemberType="",mMemberName="",mMemberCode="";
            String mInst="",mComp="",mDept="";
            

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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}


if (session.getAttribute("DepartmentCode")==null)
{
	mDept="";
}
else
{
	mDept=session.getAttribute("DepartmentCode").toString().trim();
}


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<html>
    <head>
	<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
        <TITLE>#### <%=mHead%> [ DepartmentSelection ]</TITLE>
        <link  rel="stylesheet" type="text/css" href="css/style.css">
        

<script language="JavaScript" type ="text/javascript">




function onFreeze(slno)
	{

		//alert(document.getElementById("Status"+slno)+"ddd");
		var ab=0;
		for(i=1; i<document.frm1.elements.length;i++)
		{
			 var e = document.frm1.elements[i]; 
			 var aa="Status";
			
		if (e.value=="N" && e.checked==true)
			{
				ab++;
				//alert("sddsd");
			}
				
		}
			
		if(ab>0)
		{
		var b=callMsgBox2('You have still '+ab+' record which are not processed are you still want to Freeze.');
		if (b==6)
		{
		return true;
		}
		else
		{		
		 return false;
		}
		}
		else
		{
		var b=callMsgBox2(' Are you sure you want to Freeze !');
		if (b==6)
		{
		return true;
		}
		else
		{		
		 return false;
		}
		}


	}
function EnterRemarks(ss,slno)
	{
	//alert(document.getElementById("Status"+slno).value+"sdds"+ss);

		if(document.getElementById("Status"+slno).value=="R")
		{
			alert("Please Enter Remarks ");
			document.getElementById("DeptRemarks"+slno).value="";
			document.getElementById("DeptRemarks"+slno).focus();
			return false;

		}

		//if(document.getElementByID(ss).value)
	}

function ColorCheck1(slno)
	{
	//alert(document.getElementById("TableRow"+slno).bgColor+"KK");
	
		document.getElementById("TableRow"+slno).bgColor='lightgreen';
		this.frm1.submit();

	}

function ColorCheck2(slno)
	{
	
				document.getElementById("TableRow"+slno).bgColor='pink';
				this.frm1.submit();
	}
	function ColorCheck3(slno)
	{
	
				document.getElementById("TableRow"+slno).bgColor='lightblue';
				this.frm1.submit();

	}

	function openWordDocPath(strLocation) {
		//alert("sdsdsdsd"+strLocation);
		var objWord;
		
		objWord = new ActiveXObject("Word.Application");
		//	alert("25215"+objWord);
		objWord.Visible = true;
		objWord.Documents.Open(strLocation);
	}
</script>
<SCRIPT LANGUAGE=vbscript>
function callMsgBox2(strMsg){
callMsgBox2 = msgBox(strMsg,4,"Application Selection:- Please Confirm")
}
</SCRIPT>
    </head>
    <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

	  <body id="top" aLink=#ff00ff rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
    <%

    GlobalFunctions gb = new GlobalFunctions();
    DBHandler db = new DBHandler();
    String qry = "";
    String qry1="",qry2="",qry3="",qry4="";
    ResultSet rsd = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    ResultSet rs2 = null;
    ResultSet rs3 = null;
    ResultSet rs4 = null;
    String mDDS = "";
    String mS = "";
    String mPS = "";
    session.setAttribute("APPLICANTID", null);
    session.setAttribute("MFLAG", null);
   String mPrev = "", mPostheld = "", mNatureofJob = "", mTypeofExp = "";
            String mTODATE="",mFROMDATE="";

			String mDMemberID ="",mDMemberCode ="",mDMemberType="",mRightID="255";
    
        int slno = 0,mSHORTLISTSEQNO=0,mShortSeq=0;
        String mAppName = "", mDOB = "", mAdd1 = "", mAdd2 = "", mAdd3 = "", mCity = "", mState = "", mDistrict = "", mApplicantID = "",mStatus="",mReject="",mSelect="",mSelectedStatus="",mRemarks="",mFinalShortList="";
		String mDisable="",mTabColor="";
	
try
{
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
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
		qry="Select WEBKIOSK.ShowLink('"+mRightID+"','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		//out.print(qry);
		
	if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	{
%>
     


		
<form method=post name="frm1" action="DepartmentSelectAction.jsp"  >

<%
	String mDeptCode="",mShow="",mNotSelect="",mFinal="";
int mMaxSeq=0;
//First Time Selection  //

if(request.getParameter("Vacancy")==null)
		mVacCode="";
	else
		mVacCode=request.getParameter("Vacancy").toString().trim();


if(request.getParameter("DeptCode")==null)
		mDeptCode="";
	else
		mDeptCode=request.getParameter("DeptCode").toString().trim();


	if(request.getParameter("ShowStatus")==null)
		mShow="";
	else
		mShow=request.getParameter("ShowStatus");



qry="SELECT   (MAX (d.shortlistseqno))AA                FROM hr#applicantshortlistmaster d               WHERE d.institutecode = '"+mInst+"'                 AND d.vacancycode = '"+mVacCode+"' and d.APPLICANTID in (select applicantid from hr#applicationmaster where institutecode = '"+mInst+"' and DEPARTMENTCODE='"+mDeptCode+"'  ) ";
out.print(qry);
rs=db.getRowset(qry);
if(rs.next())
mMaxSeq=rs.getInt("AA");

/*
if(mMaxSeq==1)
	mShow="N";
else if (mMaxSeq==3)
	mMaxSeq=2;
*/
String mVacDesc="",mDeptDesc="";

   qry = "SELECT distinct COMPANYCODE, INSTITUTECODE, VACANCYCODE, VACANCYDESCRIPTION," +
            " FROMPERIOD, TOPERIOD, BROADCAST, CLOSED, CLOSINGDATE FROM HR#VACANCYMASTER" +
            " WHERE NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD and" +
            " INSTITUTECODE='"+mInst+"' and VACANCYCODE='"+mVacCode+"' ";
//  	out.print("ssdsd"+qry);
	rs = db.getRowset(qry);
	if(rs.next())
		mVacDesc=rs.getString("VACANCYDESCRIPTION");

qry1 = "select distinct departmentcode,department from DEPARTMENTMASTER where" +
" nvl(DEACTIVE,'N')='N' and   departmentcode in (select distinct DEPARTMENTCODE from " +
"HR#VACANCYDEPARTMENTSELECTION   where INSTITUTECODE='"+mInst+"' AND GUESTID='"+mChkMemID+"' ) order by DEPARTMENT";
//out.print(qry1);
rsd = db.getRowset(qry1);
	if(rsd.next())
		mDeptDesc=rsd.getString("department");
		


		

String mTSelected="" ;
		qry1="select count(c.applicantid)selected from   hr#applicantshortlistmaster c,  hr#applicationmaster a,hr#applicantaddress D where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDeptCode+"'         and c.STATUS='S'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'    AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		//out.print(qry1);
		rs1=db.getRowset(qry1);
		if(rs1.next())
			mTSelected=rs1.getString("selected");
		else
			mTSelected="";


		String mTReject="" ;
			qry2="select count(c.applicantid)reject from   hr#applicantshortlistmaster c,  hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDeptCode+"'         and nvl(c.STATUS,'N')='R'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'              AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid ";
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTReject=rs1.getString("reject");
		else
			mTReject="";

		String mTNotProcess="";
			qry2="select count(c.applicantid)mTNotProcess from   hr#applicantshortlistmaster c,  hr#applicationmaster a,hr#applicantaddress D where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE a.vacancycode='"+mVacCode+"' and institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDeptCode+"'         and nvl(c.STATUS,'N')='N'   and  c.SHORTLISTSEQNO =2  and a.vacancycode ='"+mVacCode+"'              AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode  AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid";
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mTNotProcess=rs1.getString("mTNotProcess");
		else
			mTNotProcess="";




		String mALLSum="";
		qry2="select count(c.applicantid)AllResume from   hr#applicantshortlistmaster c,  hr#applicationmaster a ,hr#applicantaddress D where a.vacancycode in (select vacancycode from HR#VACANCYMASTER WHERE institutecode='"+mInst+"' and NVL(BROADCAST,'N')='Y' AND SYSDATE BETWEEN FROMPERIOD AND TOPERIOD ) and a.departmentcode ='"+mDeptCode+"'         and  c.SHORTLISTSEQNO =1  and a.vacancycode ='"+mVacCode+"'   AND a.applicantid = D.applicantid AND C.applicantid = D.applicantid AND a.applicantid = c.applicantid			and a.institutecode='"+mInst+"' AND a.vacancycode = c.vacancycode AND a.institutecode = c.institutecode";
		//out.print(qry2);
		rs1=db.getRowset(qry2);
		if(rs1.next())
			mALLSum=rs1.getString("AllResume");
		else
			mALLSum="";

		//int mTNotProcess=( Integer.parseInt(mALLSum) ) - (Integer.parseInt(mTSelected)+Integer.parseInt(mTReject));
		%>
		
		<table  border=1  borderColor=#D98242 rules=group align=left  topmargin=0 cellspacing=0 cellpadding=0>
		     <tr bgcolor="#FFCF83">

		<td class="labelcell" >
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=ALL&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> --> <font  size=2><b>	Resumes to be reviewed </td><td> <%=mALLSum%> </td>
		</tr>
		
		<tr bgColor="lightgreen">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=S&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>">  -->	<font color=green size=2><b> Resumes Shortlisted  </a></td><td> <%=mTSelected%> </td>
		</tr>

		<tr bgColor="pink">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=R&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> --><font color=red size=2><b>	Resumes Not Shortlisted. </a> </td><td> <%=mTReject%> 		</td>
		</tr>
	
		
		<tr bgColor="lightblue">
		<td class="labelcell">
		<!-- <a href="DepartmentLinks.jsp?ShowStatus=N&amp;Vacancy=<%=mVacCode%>&amp;DeptCode=<%=mDeptCode%>"> -->	<font color=blue size=2><b>Resume Yet to be Processed   </a></td><td> <%=mTNotProcess%> 		</td>
		</tr>
		</table>



   <table  align=center >
            <tr><td align=center ><h2>&nbsp;&nbsp; Initial ShortListing by Nominated Members &nbsp;&nbsp;</h2></td></tr>

			   <tr><td align=center ><h2>Vacancy-<%=mVacDesc%> &nbsp;&nbsp; Department-<%=mDeptDesc%> </h2></td></tr>

			   <tr><td align=center class="labelcell"><b>Name : <%=mMemberName%></td></tr>
        </table>



 <INPUT TYPE="hidden" NAME="ShowStatus" ID="ShowStatus" VALUE="<%=mShow%>">
 <table width="100%" border=1  borderColor=#D98242 rules=group align=center bottommargin=1 topmargin=0 cellspacing=0 cellpadding=2>
     <br>
     <tr bgcolor="#FFCF83">
	  <td  class="labelcell"><b><CENTER>SrNo.</CENTER></b></td>
       <td  class="labelcell"><b><CENTER>Candidate<br>Selection Status</CENTER></b></td>
         <td  class="labelcell"><b><CENTER>Name<br><br>Date of Birth</CENTER></b></td>
                  <td  class="labelcell"><b><CENTER>Address</CENTER></b></td>
         <TD  align=left class="labelcell" nowrap > <table cellspacing=0 cellpadding=0 width="100%" align=left> <td class="labelcell" nowrap colspan=4><b> Applicant Qualification
				  </td>
				 <!--  <tr >
                <td class="labelcell" valign="top"><b>Degree </b></td>
				<td class="labelcell" valign="top"><b>Institute</b></td>
                <td class="labelcell" valign="top"><b>Year</b></td>
             	</tr> -->
				</table></TD>
		          <!-- <TD  align=left class="labelcell" nowrap><b> Applicant Experience <hr> <br> Designation &nbsp;Company &nbsp; PFrom &nbsp; PTo &nbsp; &nbsp; &nbsp; &nbsp;TotalExp.</b></TD> -->

				  <td  align=left>
				  <table width="100%" align=left cellspacing=0 cellpadding=0  border=0> <td class="labelcell" nowrap colspan=6><b> Applicant Experience
				<!--  <hr>
				  <tr  >
                <td class="labelcell" valign="top" width="100px" align=left><b>Designation</b></td>
				<td class="labelcell" valign="top" width="100px" align=left><b>Institute<br>Company</b></td>
                <td class="labelcell" valign="top" width="70px" align=left><b>Period<br>From</b></td>
                <td class="labelcell" valign="top" width="70px" align=left><b>Period<br>To</b></td>
				<td class="labelcell" valign="top" width="70px" align=left><b>Total<br>Exp.</b></td>
				</tr> -->
				</table>
				</td>
   <TD  align=center class="labelcell"><b>Click to View CV </b></TD>
       
         <!-- <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" onClick="un_checkAllSelect()"  NAME="AllSelect" ID="AllSelect" value="S">Select All</b>
		 </td> 
		 <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" NAME="AllReject" ID="AllReject" onClick="un_checkAllReject()" value="R">Reject ALL</b>
		 </td>
		  <td  class="labelcell" nowrap><b>
		 <INPUT TYPE="checkbox" NAME="AllNotSelect" ID="AllNotSelect" onClick="un_checkAllNotSelect()" value="N">Not Selected</b>
		 </td> -->
         <td class="labelcell"><b><CENTER> Remarks of Shortlisting Member<br>(max. 100 words)</CENTER></b> </td>
     </tr>

     <%
	
        qry = " SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth, decode(a.GENDER,'M','Male','F','Female')GENDER " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,nvl(c.STATUS ,'N')STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(C.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid and	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND  ";
		if(mShow.equals("ALL"))
		{
		qry=qry+" c.shortlistseqno  in(                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'       and  nvl(d.status,'N')=decode  ('"+mShow+"' ,'ALL',nvl(d.status,'N'),'"+mShow+"' ) and d.vacancycode = '" + mVacCode + "' and a.APPLICANTID=d.APPLICANTID )   ";
		}
		else if(mShow.equals("S") ||  mShow.equals("R"))
		{
		qry=qry+" c.shortlistseqno = 2  ";
		}
		else if (mShow.equals("N"))
		{
			qry=qry+" c.shortlistseqno =2  ";
		}				
		qry=qry+"ORDER BY c.STATUS desc";	 
//out.print(qry+"mShow"+mShow);
	 /*
        qry = " SELECT round(months_between(sysdate,dateofbirth)/12)AGE , nvl(a.SHORTLISTED,' ')SHORTLISTED, decode(a.SHORTLISTED,'S','Selected','R','Rejected','',' ',a.SHORTLISTED)FINALSHORTLISTED,c.SHORTLISTSEQNO,a.APPLICANTID,nvl(a.firstname,' ') firstname,nvl(a.middlename,' ') middlename,nvl(a.lastname,' ') lastname,to_char(a.dateofbirth,'DD-MM-YYYY')dateofbirth " +
                ",nvl(b.CADDRESS1,' ')CADDRESS1, nvl(b.CADDRESS2,' ')CADDRESS2, nvl(b.CADDRESS3,' ')CADDRESS3, " +
                "nvl(b.CCITY,' ')ccity, nvl(b.CDISTRICT,' ')CDISTRICT, nvl(b.CSTATE,' ')CSTATE, b.CPIN,nvl(c.STATUS ,'N')STATUS ,nvl(c.REMARKS,' ')REMARKS ,nvl(a.final,'N') final   " +
"  FROM hr#applicationmaster a, hr#applicantaddress b,HR#APPLICANTSHORTLISTMASTER c" +
" WHERE a.applicantid = b.applicantid and	c.status =decode  ('"+mShow+"' ,'ALL',nvl(c.status,'N'),'"+mShow+"' ) " +                "   AND a.vacancycode = '" + mVacCode + "'" +
                "   AND a.departmentcode = '" + mDeptCode + "'    and a.APPLICANTID=c.APPLICANTID   and b.APPLICANTID=c.APPLICANTID   and a.VACANCYCODE=c.VACANCYCODE   and a.INSTITUTECODE=c.INSTITUTECODE AND A.COMPANYCODE=C.COMPANYCODE     AND A.INSTITUTECODE=C.INSTITUTECODE     AND a.institutecode = c.institutecode   AND (c.shortlistseqno) IN (                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'       and  nvl(status,'N')=decode  ('"+mShow+"' ,'ALL',nvl(d.status,'N'),'"+mShow+"' )                 AND d.vacancycode = '" + mVacCode + "'                              And a.applicantid=d.applicantid                             group by d.applicantid)     ORDER BY a.firstname";*/
        rs = db.getRowset(qry);
// out.print(qry);
        while (rs.next())
        {
            slno++;
				
			mFinalShortList=rs.getString("SHORTLISTED").toString().trim();
			mFinal=rs.getString("final").toString().trim();
			mSHORTLISTSEQNO=rs.getInt("SHORTLISTSEQNO");
            mApplicantID = rs.getString("APPLICANTID").toString();
            mAppName = rs.getString("firstname").toString().toUpperCase()+" "+rs.getString("middlename").toString().toUpperCase()+" "+rs.getString("lastname").toString().toUpperCase();
            mDOB = rs.getString("dateofbirth").toString();
            mAdd1 = rs.getString("CADDRESS1").toString().trim();
            mAdd2 = rs.getString("CADDRESS2").toString().trim();
            mAdd3 = rs.getString("CADDRESS3").toString().trim();
            mCity = rs.getString("ccity").toString().trim();
            mState = rs.getString("CSTATE").toString().trim();
            mDistrict = rs.getString("CDISTRICT").toString().trim();
			mStatus= rs.getString("STATUS").toString().trim();
			
			if(mSHORTLISTSEQNO==1)
			mShortSeq=mSHORTLISTSEQNO+1;
				else
			mShortSeq=mSHORTLISTSEQNO;

	//out.print(mStatus+"sdsss"+rs.getString("STATUS").toString().trim());		
							
			
				qry1="SELECT  SHORTLISTSEQNO, STATUS,nvl(REMARKS,' ')REMARKS  FROM HR#APPLICANTSHORTLISTMASTER a WHERE INSTITUTECODE='"+mInst+"' AND  VACANCYCODE='" + mVacCode + "' AND APPLICANTID ='"+mApplicantID+"' and  status =decode  ('"+mShow+"' ,'ALL',nvl(status,'N'),'"+mShow+"' ) and ";
				if(mShow.equals("ALL"))
		{
		qry1=qry1+" shortlistseqno  in(                      SELECT (MAX (d.shortlistseqno))                        FROM hr#applicantshortlistmaster d                       WHERE d.institutecode =  '"+mInst+"'       and  nvl(d.status,'N')=decode  ('"+mShow+"' ,'ALL',nvl(d.status,'N'),'"+mShow+"' ) and d.vacancycode = '" + mVacCode + "' and a.APPLICANTID=d.APPLICANTID )   ";
		}
		else if(mShow.equals("S") ||  mShow.equals("R"))
		{
		qry1=qry1+" shortlistseqno = 2  ";
		}
		else if (mShow.equals("N"))
		{
			qry1=qry1+" shortlistseqno =2  ";
		}			
		//	out.print(qry1);
				rs1=db.getRowset(qry1);
				if(rs1.next())
				{
					mSelectedStatus=rs1.getString("STATUS").toString().trim();
					mRemarks=rs1.getString("REMARKS").toString().trim();
					if(mSelectedStatus.equals("S"))
							{
								mSelect="checked";
							}
							else if(mSelectedStatus.equals("R"))
							{
								mReject="checked";
							}
							else if(mSelectedStatus.equals("N"))
							{
								mNotSelect="checked";
							}
				}
				else
				{
					mRemarks=rs.getString("REMARKS").toString().trim();
					/*if(mStatus.equals("S"))
							{
								mSelect="checked";
								
							}
							else if(mStatus.equals("R"))
							{
								mReject="checked";
							}
							else if(mStatus.equals("N"))
							{
									mNotSelect="checked";
							}*/
					mNotSelect="checked";
				}

			

				if(mFinal.equals("Y"))
			{
				//mSelect="checked"; 
				mDisable="disabled";

			}	

		/*if(mFinalShortList.equals("S"))
			{
				mSelect="checked"; 
				//mDisable="disabled";

			}
			else if(mFinalShortList.equals("R"))
			{
				mReject="checked";
				//mDisable="disabled";
			}*/

//	out.print(mSelect+"fff");\\

if(mSelect.equals("checked"))
	mTabColor="lightgreen";
else if(mReject.equals("checked"))
	mTabColor="pink";
else if(mNotSelect.equals("checked"))
	mTabColor="lightblue";

if(mMaxSeq==1)
			{mNotSelect="checked";
			mTabColor="lightblue";
			}
if(mMaxSeq==3)
			{
		mDisable="disabled";
			}


     %>
	 <input type="Hidden" name="ApplicationID<%=slno%>" id="ApplicationID<%=slno%>" value="<%=mApplicantID%>">
     <tr bgColor="<%=mTabColor%>" id="TableRow<%=slno%>" name="TableRow<%=slno%>"> 
	 <td  class="labelcell"  valign=top> <%=slno%>.</td>
	  <td nowrap valign=top class="labelcell">
             <input type="radio" name="Status<%=slno%>" value="S" id="Status<%=slno%>" <%=mDisable%> <%=mSelect%> onclick="ColorCheck1('<%=slno%>')" >
			 <font color=green > <b> Selected</b></font>
			 <br>
			 <input type="radio"  name="Status<%=slno%>" id="Status<%=slno%>" value="R" <%=mDisable%> <%=mReject%> onclick="ColorCheck2('<%=slno%>')">
			 <font color=red > <b> Rejected</b></font>
			 <br>
			 <input type="radio"  name="Status<%=slno%>" id="Status<%=slno%>" value="N" <%=mDisable%> <%=mNotSelect%>  onclick="ColorCheck3('<%=slno%>')">
			 <font color=blue > <b> Not Processed</b></font>
         </td>
		  	<%
			 mReject="";
			 mSelect="";
			 mNotSelect="";
			%>
         <td  class="labelcell" nowrap valign=top>
             <%=mAppName%><br><br> DOB :<%=mDOB%> <BR>Age :<%=rs.getString("Age")%> <BR> <BR> Gender :<%=rs.getString("GENDER")%>
         </td>
         <td class="labelcell" valign=top>
             <%=mAdd1%>&nbsp;<%=mAdd2%>&nbsp;<%=mAdd3%><br>
             <%=mCity%>&nbsp;<%=mState%>&nbsp;<%=mDistrict%>
         </td>

             <td class="labelcell" valign=top>
                 <table borderColor=#D98242 rules=group border=1 width="100%" cellspacing=2 cellpadding=0>
                   
					<tr>
                         <td class="labelcell" valign="top"><b>Degree&nbsp;</b></td>
                         <td class="labelcell" valign="top"><b>University/Institute
						 </b></td>
                         <td class="labelcell" valign="top"><b>Year</b></td>
						 	
                     </tr>
					 	<!-- <tr>  <td class="labelcell" colspan=4><hr></hr></td> </tr> -->
				
<%
try{
String mQCode = "", mINSTITUTION= "", mYEAROFPASSING = "", mArea = "";
qry1 = " SELECT nvl(a.QUALIFICATIONCODE,' ')QUALIFICATIONCODE, nvl(a.INSTITUTION,' ')INSTITUTION, a.APPLICANTID, " +
"  nvl(a.AREAOFQUALIFICATION,' ')AREAOFQUALIFICATION ,decode(a.yearofpassing,'0',' ',a.yearofpassing )yearofpassing,nvl(b.shortname ,' ')shortname ,b.SEQNO,nvl(a.QUALIFICATIONINSTITUTE,' ')QUALIFICATIONINSTITUTE, DECODE (a.yearofpassing, '0','2012' , a.yearofpassing) yearofpassing1 FROM HR#APPLICANTQUALIFICATION a,HR#QUALIFICATIONTAGGING b where a.APPLICANTID='" + mApplicantID + "' and b.INSTITUTECODE='"+mInst+"' AND  b.VACANCYCODE='" + mVacCode + "' and a.COMPANYCODE=b.COMPANYCODE and  a.INSTITUTECODE=b.INSTITUTECODE  and  a.QUALIFICATIONCODE=b.QUALIFICATIONCODE  order by yearofpassing1 desc";
//out.print(qry1);
rs1 = db.getRowset(qry1);
while (rs1.next()) {
mQCode = rs1.getString("shortname").toUpperCase();
mINSTITUTION = rs1.getString("INSTITUTION").toString();
mYEAROFPASSING = rs1.getString("YEAROFPASSING").toString();
mArea = rs1.getString("AREAOFQUALIFICATION").toString().toUpperCase();

//out.print(mYEAROFPASSING);
%>
<tr >
<td nowrap class="labelcell" align=left><%=mQCode%></td>
<td class="labelcell">&nbsp;<%=rs1.getString("QUALIFICATIONINSTITUTE")%>&nbsp;<%=mINSTITUTION%></td>
<td class="labelcell" align=right>&nbsp;&nbsp;<%=mYEAROFPASSING%></td>

</tr>
<%
}
}
catch(Exception e)
{
//out.print(e+"   12345");
}
%>
        </table>
    </td>
    <td valign=top  class="labelcell" >
        <table borderColor="#D98242" rules=group width="100%"  cellspacing=2 cellpadding=0 border=1 >
             <tr >
                <td class="labelcell" valign="top"><font size=2><b>Designation</b></td>
				<td class="labelcell" valign="top"><font size=2><b>Institute/Company</b></td>
                <td class="labelcell" valign="top"><font size=2><b>Period From</b></td>
                <td class="labelcell" valign="top"><font size=2><b>Period To</b></td>
				<td class="labelcell" valign="top"><font size=2><b>Total Exp.</b></td>
            </tr>
	<!-- 		<tr>  <td class="labelcell" colspan=5><hr></hr></td> </tr>  -->
                     <%
            try{
String mYear="",mMonth1="";
int mMonth=0;
            qry2 = "SELECT nvl(a.prevorganisation,' ')prevorganisation, " +
                    " nvl(a.postheld,' ')postheld, nvl(a.natureofjob,' ')natureofjob, " +
                    " nvl(to_char(FROMDATE,'FMMon DD,yyyy'),' ')FROMDATE, nvl(to_char(TODATE,'FMMon DD,yyyy'),' ')TODATE" +
                    " ,   nvl(SUBSTR (MONTHS_BETWEEN ( decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12,1,INSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12, '.') - 1  ),'N') year1, nvl(ROUND (  SUBSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),a.FROMDATE) / 12,INSTR (MONTHS_BETWEEN (decode(a.TILLDATE,'Y',sysdate, a.todate),FROMDATE) / 12,'.')) * 12 ),'0') month1, decode(a.tillDate,'Y','TillDate','',' ',a.tillDate)tillDate,to_char(a.todate,'yyymmdd')todatee FROM hr#applicantexperience a WHERE applicantid = '" + mApplicantID + "' order by  todatee desc";
       // out.print(qry2);
            rs2 = db.getRowset(qry2);
            while (rs2.next()) {
                mPrev = rs2.getString("prevorganisation").toUpperCase();
                mPostheld = rs2.getString("postheld").toString();
                mFROMDATE = rs2.getString("FROMDATE").toString();
                mTODATE = rs2.getString("TODATE").toString();
				mYear= rs2.getString("year1");
				mMonth= rs2.getInt("month1");
				if(mYear.equals("N"))
					mYear="";
				else
					mYear=mYear+"Year";
			
				if(mMonth==0)
					 mMonth1="";
				else
					 mMonth1=mMonth+"Month";
				
				//if(mTODATE.euqals(""))

                     %>
                     <tr  >
					
                         <td class="labelcell" valign="top" ><%=mPostheld%>&nbsp;</td>
                         <td class="labelcell" valign="top" ><%=mPrev%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mFROMDATE%>&nbsp;</td>
                         <td class="labelcell" nowrap valign="top" ><%=mTODATE%>&nbsp;<%= rs2.getString("tilldate")%></td>
						 <td class="labelcell" nowrap valign="top" ><%=mYear%><%=mMonth1%>&nbsp;</td>
						 
                     </tr>
                     <%
                     }

            }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }
                     %>
                 </table>

             </td>
             <td class="labelcell" nowrap valign=top>
                 <%
				 try{
                 String link="";
                 qry4="select nvl(CVFILENAME,'N')CVFILENAME  from HR#APPLICANTRESUME " +
                         "where APPLICANTID='" + mApplicantID + "'";
                         rs4=db.getRowset(qry4);
                         if(rs4.next())
                             {
                            link=rs4.getString("CVFILENAME").toString().trim();
							//link="//172.16.5.45/"+link;
							//link="data/HOLIDAYS 2011.doc";
							//link=link.substring( link.lastIndexOf("/data")+1);
							//out.print(link.substring( link.lastIndexOf("/data/")+1));
						//	out.print(link);
                                %>
                <!--  <INPUT TYPE="button" name="ViewCV" value="Click to View"  title="Click to View CV"  onClick="openWordDocPath('<%=link%>')"   > -->
                  <a href="<%=link%>" title="C.V.<%=link%>" target="_NEW" >View C.V.</a> 
                 </td>

             <%
                           }
			   }
            catch(Exception e)
                    {
                        out.print(e+"  Error");
                    }
            
           %>
            
         

			     <td valign=top class="labelcell">
                 <input name="DeptRemarks<%=slno%>" id="DeptRemarks<%=slno%>" <%=mDisable%>  style="width:150px" value="<%=mRemarks%>"  maxlength=200>
              </td>
		
         </tr>
         <%
				 	//mSelect=""; 
				//mDisable="";
        }
   //out.print(mDisable+"mDisable");
	 %>
	 <tr>
	 <td colspan="11" align="left">
	 <%
		 if(!mDisable.equals("disabled"))
					{
		 %>
	 <INPUT TYPE="submit" name="Submit1" value="Click To Save">
&nbsp;&nbsp;  &nbsp;&nbsp;  &nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;
	 <INPUT TYPE="submit" name="Freeze" value="Click To Freeze" onClick="return onFreeze('<%=slno%>');">
	 <%}
			 %>
	 </td>
	 </tr>
     </table>
	  <input type="Hidden" name="ShortlistSeq" id="ShortlistSeq" value="<%=mSHORTLISTSEQNO%>">
 <input type="Hidden" name="TotalCount" id="TotalCount" value="<%=slno%>">
 <input type="Hidden" name="VacancyCode" id="VacancyCode" value="<%=mVacCode%>">
  <input type="Hidden" name="DeptCode" id="DeptCode" value="<%=mDeptCode%>">
 
 <input type="Hidden" name="Institute" id="Institute" value="<%=mInst%>">
  <input type="Hidden" name="CompanyCode" id="CompanyCode" value="<%=mComp%>">

 </form>
 <%
 }
else
{
   %>
	<br>
	<font color=red>
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
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
	//out.print("Exception "+e);
}
%>