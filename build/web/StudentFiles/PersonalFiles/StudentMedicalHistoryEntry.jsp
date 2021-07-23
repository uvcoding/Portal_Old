<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
int mSno=0, TotInboxItem=0;
String qry="",qry1="";
String mColor="",mComp="",TRCOLOR="White",mWebEmail="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType="";
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInst="";
String mFacultyName="",mFaculty="", mMsg="";
String QryFaculty="",mEID="",mENM="",mcolor="";

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

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
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
<TITLE>#### <%=mHead%> [ Student Medical History ] </TITLE>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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
function Validate()
{
var emailID=document.frm.EmailID
	
	if ((emailID.value==null)||(emailID.value=="")){
		alert("Please Enter your Email ID")
		emailID.focus()
		return false;
	}
}

function setFocus1A()
{
	if(document.frm.PrstC3[0].value=='Y')
	{
	    	document.frm.PrstC3a[0].disabled=false;
		document.frm.PrstC3a[1].checked=true;
	    	document.frm.PrstC3a[1].disabled=false;
	    	document.frm.txtPrstC3.disabled=false;
	}
}
function setFocus1B()
{
	if(document.frm.PrstC3[1].value=='N')
	{
	    	document.frm.PrstC3a[0].disabled=true;
		document.frm.PrstC3a[1].checked=true;
	    	document.frm.PrstC3a[1].disabled=true;
	    	document.frm.PrstC3a1[0].disabled=true;
	    	document.frm.PrstC3a1[1].disabled=true;
	    	document.frm.PrstC3a1[2].disabled=true;
	    	document.frm.PrstC3a1[3].disabled=true;
	    	document.frm.txtPrstC3.disabled=true;
	    	document.frm.txtPrstC3a.disabled=true;
	}
}
function setFocus2A()
{
	if(document.frm.PrstC3a[0].value=='Y')
	{
	    	document.frm.PrstC3a1[0].disabled=false;
	    	document.frm.PrstC3a1[1].disabled=false;
	    	document.frm.PrstC3a1[2].disabled=false;
	    	document.frm.PrstC3a1[3].disabled=false;
	    	document.frm.txtPrstC3a.disabled=false;
	}
}
function setFocus2B()
{
	if(document.frm.PrstC3a[1].value=='N')
	{
	    	document.frm.PrstC3a1[0].disabled=true;
	    	document.frm.PrstC3a1[1].disabled=true;
	    	document.frm.PrstC3a1[2].disabled=true;
	    	document.frm.PrstC3a1[3].disabled=true;
	    	document.frm.txtPrstC3a.disabled=true;
	}
}
function funOnLoad()
{
	if(document.frm.txtPrstC1.value=='')
	    	document.frm.txtPrstC1.disabled=true;
	if(document.frm.txtPrstC2.value=='')
	    	document.frm.txtPrstC2.disabled=true;
	if(document.frm.txtPrstC3.value=='')
	    	document.frm.txtPrstC3.disabled=true;
	if(document.frm.txtPrstC3a.value=='')
	    	document.frm.txtPrstC3a.disabled=true;
	if(document.frm.txtPastC1.value=='')
	    	document.frm.txtPastC1.disabled=true;
	if(document.frm.txtPastC2.value=='')
		document.frm.txtPastC2.disabled=true;
	if(document.frm.txtPastC3.value=='')
	    	document.frm.txtPastC3.disabled=true;
	if(document.frm.txtPastC4.value=='')
	    	document.frm.txtPastC4.disabled=true;
	if(document.frm.txtPastC5.value=='')
	    	document.frm.txtPastC5.disabled=true;
	if(document.frm.txtPastC6.value=='')
	    	document.frm.txtPastC6.disabled=true;
	if(document.frm.txtMajorComp.value=='')
	    	document.frm.txtMajorComp.disabled=true;
	if(document.frm.txtDrugIntake.value=='')
	    	document.frm.txtDrugIntake.disabled=true;
}
function funChangeTxtPrstC1A()
{
	if(document.frm.PrstC1[0].value=='Y')
	{
	    	document.frm.txtPrstC1.disabled=false;
	}
}
function funChangeTxtPrstC1B()
{
	if(document.frm.PrstC1[1].value=='N')
	{
	    	document.frm.txtPrstC1.disabled=true;
	}
}
function funChangeTxtPrstC2A()
{
	if(document.frm.PrstC2[0].value=='Y')
	{
	    	document.frm.txtPrstC2.disabled=false;
	}
}
function funChangeTxtPrstC2B()
{
	if(document.frm.PrstC2[1].value=='N')
	{
	    	document.frm.txtPrstC2.disabled=true;
	}
}
function funChangeTxtPastC1A()
{
	if(document.frm.PastC1[0].value=='Y')
	{
	    	document.frm.txtPastC1.disabled=false;
	}
}
function funChangeTxtPastC1B()
{
	if(document.frm.PastC1[1].value=='N')
	{
	    	document.frm.txtPastC1.disabled=true;
	}
}
function funChangeTxtPastC2A()
{
	if(document.frm.PastC2[0].value=='Y')
	{
	    	document.frm.txtPastC2.disabled=false;
	}
}
function funChangeTxtPastC2B()
{
	if(document.frm.PastC2[1].value=='N')
	{
	    	document.frm.txtPastC2.disabled=true;
	}
}
function funChangeTxtPastC3A()
{
	if(document.frm.PastC3[0].value=='Y')
	{
	    	document.frm.txtPastC3.disabled=false;
	}
}
function funChangeTxtPastC3B()
{
	if(document.frm.PastC3[1].value=='N')
	{
	    	document.frm.txtPastC3.disabled=true;
	}
}
function funChangeTxtPastC4A()
{
	if(document.frm.PastC4[0].value=='Y')
	{
	    	document.frm.txtPastC4.disabled=false;
	}
}
function funChangeTxtPastC4B()
{
	if(document.frm.PastC4[1].value=='N')
	{
	    	document.frm.txtPastC4.disabled=true;
	}
}
function funChangeTxtPastC5A()
{
	if(document.frm.PastC5[0].value=='Y')
	{
	    	document.frm.txtPastC5.disabled=false;
	}
}
function funChangeTxtPastC5B()
{
	if(document.frm.PastC5[1].value=='N')
	{
	    	document.frm.txtPastC5.disabled=true;
	}
}
function funChangeTxtPastC6A()
{
	if(document.frm.PastC6[0].value=='Y')
	{
	    	document.frm.txtPastC6.disabled=false;
	}
}
function funChangeTxtPastC6B()
{
	if(document.frm.PastC6[1].value=='N')
	{
	    	document.frm.txtPastC6.disabled=true;
	}
}
function funChangeTxtSurgeryOrAccidentA()
{
	if(document.frm.MajorComp[0].value=='Y')
	{
	    	document.frm.txtMajorComp.disabled=false;
	}
}
function funChangeTxtSurgeryOrAccidentB()
{
	if(document.frm.MajorComp[1].value=='N')
	{
	    	document.frm.txtMajorComp.disabled=true;
	}
}
function funChangeTxtDrugIntakeA()
{
	if(document.frm.DrugIntake[0].value=='Y')
	{
	    	document.frm.txtDrugIntake.disabled=false;
	}
}
function funChangeTxtDrugIntakeB()
{
	if(document.frm.DrugIntake[1].value=='N')
	{
	    	document.frm.txtDrugIntake.disabled=true;
	}
}
</script>
</head>
<body aLink=#ff00ff bgcolor='#fce9c5' rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad="funOnLoad()">
<p align=center>
<font color=darkbrown size=3 face='verdana'><b><U>Medical Form</U></b></font>
</p>
<center>
<!--<marquee direction="right" height="150" scrollamount="5" behavior="scroll" style="font-family:Verdana;font-size:13px;text-decoration:none;color:#FFFFFF;background-color:transparent;" id="Marquee1"><img src="../../PhotoImages/1.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/2.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/3.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/5.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/6.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/7.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/8.jpg">&nbsp;&nbsp;<img src="../../PhotoImages/9.jpg"></marquee>
<marquee direction="righttoleft" height="25" width="102%" scrolldelay="50" scrollamount="5" behavior="scroll" loop="0" style="font-family:Verdana;font-size:25px;text-decoration:none;color:#FFFFFF;background-color:navy;" id="Marquee2"><STRONG>Site is Under Construction. Modules will open one by one after sometime.</STRONG></marquee>-->
<%
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

		String mName="", mRoll="", mRoomNo="", mPrstC1="", mPrstC2="", mPrstC3="", mPrstC3a="", mPrstC3a1="";
		String mPastC1="", mPastC2="", mPastC3="", mPastC4="", mPastC5="", mPastC6="";
		String mMajorComp="", mDrugIntake="", mAnyOther="";

		String mAllergicToDrug="", mHOAddition="", mPsychiatricIllness="", mTypeOfPITreatment="", mHypertension="";
		String mDiabetesMellitus="", mBronchialAsthma="", mAllergicBronchites="", mConvulsioris="", mCongentialDiease="";
		String mAnyMajorOrAccidental="", mAnyDrugIntake="";

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('247','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
		{
			%>
			<form name=frm id=frm Action="StudentMedicalHistoryEntryAction.jsp">
			<input id="x" name="x" type=hidden>
			<table align=center cellpadding=0 width=90%>
			<%
				if(request.getAttribute("message")==null)
					mMsg="";
				else
					mMsg=(String)request.getAttribute("message");
				if(mMsg.equals("Msg1"))
				{
					%>
					<CENTER><b><font size=4 face='Arial' color='Green'>Your Medical Form is submitted successfully...</font></b><br><br>
					<A href="../Academic/NRBackLogSubjectListFistScreen.jsp"><font color=red size=2 face='verdana'><b>Click to View Webkiosk</b></font></A>
					</CENTER>
					<%
				}
				else if(mMsg.equals("Msg2"))
				{
					%>
					<CENTER><b><font size=3 face='Arial' color='Green'>Your Medical Form is updated successfully...</font></b><br><br></CENTER>
					
					<%
				}
					
				if(request.getParameter("RoomNo")!=null)
					mRoomNo=request.getParameter("RoomNo").toString().trim();
				else
					mRoomNo="";
				if(request.getParameter("PrstC1")!=null)
					mPrstC1=request.getParameter("PrstC1").toString().trim();
				else
					mPrstC1="";
				if(request.getParameter("txtPrstC1")!=null)
					mAllergicToDrug=request.getParameter("txtPrstC1").toString().trim();
				else
					mAllergicToDrug="";
				if(request.getParameter("PrstC2")!=null)
					mPrstC2=request.getParameter("PrstC2").toString().trim();
				else
					mPrstC2="";
				if(request.getParameter("txtPrstC2")!=null)
					mHOAddition=request.getParameter("txtPrstC2").toString().trim();
				else
					mHOAddition="";
				if(request.getParameter("PrstC3")!=null)
					mPrstC3=request.getParameter("PrstC3").toString().trim();
				else
					mPrstC3="";
				if(request.getParameter("txtPrstC3")!=null)
					mPsychiatricIllness=request.getParameter("txtPrstC3").toString().trim();
				else
					mPsychiatricIllness="";
				if(request.getParameter("PrstC3a")!=null)
					mPrstC3a=request.getParameter("PrstC3a").toString().trim();
				else
					mPrstC3a="";
				if(request.getParameter("txtPrstC3a")!=null)
					mTypeOfPITreatment=request.getParameter("txtPrstC3a").toString().trim();
				else
					mTypeOfPITreatment="";
				if(request.getParameter("PrstC3a1")!=null)
					mPrstC3a1=request.getParameter("PrstC3a1").toString().trim();
				else
					mPrstC3a1="";
				if(request.getParameter("PastC1")!=null)
					mPastC1=request.getParameter("PastC1").toString().trim();
				else
					mPastC1="";
				if(request.getParameter("txtPastC1")!=null)
					mHypertension=request.getParameter("txtPastC1").toString().trim();
				else
					mHypertension="";
				if(request.getParameter("PastC2")!=null)
					mPastC2=request.getParameter("PastC2").toString().trim();
				else
					mPastC2="";
				if(request.getParameter("txtPastC2")!=null)
					mDiabetesMellitus=request.getParameter("txtPastC2").toString().trim();
				else
					mDiabetesMellitus="";
				if(request.getParameter("PastC3")!=null)
					mPastC3=request.getParameter("PastC3").toString().trim();
				else
					mPastC3="";
				if(request.getParameter("txtPastC3")!=null)
					mBronchialAsthma=request.getParameter("txtPastC3").toString().trim();
				else
					mBronchialAsthma="";
				if(request.getParameter("PastC4")!=null)
					mPastC4=request.getParameter("PastC4").toString().trim();
				else
					mPastC4="";
				if(request.getParameter("txtPastC4")!=null)
					mAllergicBronchites=request.getParameter("txtPastC4").toString().trim();
				else
					mAllergicBronchites="";
				if(request.getParameter("PastC5")!=null)
					mPastC5=request.getParameter("PastC5").toString().trim();
				else
					mPastC5="";
				if(request.getParameter("txtPastC5")!=null)
					mConvulsioris=request.getParameter("txtPastC5").toString().trim();
				else
					mConvulsioris="";
				if(request.getParameter("PastC6")!=null)
					mPastC6=request.getParameter("PastC6").toString().trim();
				else
					mPastC6="";
				if(request.getParameter("txtPastC6")!=null)
					mCongentialDiease=request.getParameter("txtPastC6").toString().trim();
				else
					mCongentialDiease="";
				if(request.getParameter("MajorComp")!=null)
					mMajorComp=request.getParameter("MajorComp").toString().trim();
				else
					mMajorComp="";
				if(request.getParameter("txtMajorComp")!=null)
					mAnyMajorOrAccidental=request.getParameter("txtMajorComp").toString().trim();
				else
					mAnyMajorOrAccidental="";
				if(request.getParameter("txtDrugIntake")!=null)
					mAnyDrugIntake=request.getParameter("txtDrugIntake").toString().trim();
				else
					mAnyDrugIntake="";
				if(request.getParameter("AnyOther")!=null)
					mAnyOther=request.getParameter("AnyOther").toString().trim();
				else
					mAnyOther="";
			qry="Select A.StudentName SName, A.EnrollmentNo EnrollNo, nvl(B.HOSTELROOMNO,' ') RoomNo, NVL(B.PRS_HOALLERGICTODRUG,' ')PRS_HOALLERGICTODRUG,";
			qry+=" NVL(B.PRS_HOADDITION,' ')PRS_HOADDITION, NVL(B.PRS_HOPSYCHIATRICILLNESS,' ')PRS_HOPSYCHIATRICILLNESS,";
			qry+=" NVL(B.PRS_PI_ONTREATMENT,' ')PRS_PI_ONTREATMENT, nvl(B.PRS_PI_TYPEOFTREATMENT,' ')PRS_PI_TYPEOFTREATMENT, NVL(B.PST_HOHYPERTENSION,' ')PST_HOHYPERTENSION,";
			qry+=" NVL(B.PST_HODIABETESMELLITUS,' ')PST_HODIABETESMELLITUS, NVL(B.PST_HOBRINICALASTHAMA,' ')PST_HOBRINICALASTHAMA,";
			qry+=" NVL(B.PST_HOALLERGICBRONCHITES,' ')PST_HOALLERGICBRONCHITES, NVL(B.PST_HOCONVULSIORISORFITS,' ')PST_HOCONVULSIORISORFITS,";
			qry+=" NVL(B.PST_HOANYCONGENTIALDIEASES,' ')PST_HOANYCONGENTIALDIEASES, NVL(B.HOANYMAJORSURGERYORACCIDENT,' ')HOANYMAJORSURGERYORACCIDENT,";
			qry+=" NVL(B.HOANYDRUGINTAKE,' ')HOANYDRUGINTAKE, NVL(B.ANYOTHER,' ')ANYOTHER";
			qry+=" from StudentMaster A, StudentMedicalHistory B Where A.STUDENTID=B.STUDENTID AND B.studentid='"+mChkMemID+"'";
			//out.print(qry);
			rs1=db.getRowset(qry);
			if(rs1.next())
			{
				mRoomNo=rs1.getString("RoomNo").trim();
				mAllergicToDrug=rs1.getString("PRS_HOALLERGICTODRUG").trim();
				mHOAddition=rs1.getString("PRS_HOADDITION").trim();
				mPsychiatricIllness=rs1.getString("PRS_HOPSYCHIATRICILLNESS").trim();
				mTypeOfPITreatment=rs1.getString("PRS_PI_TYPEOFTREATMENT").trim();
				mHypertension=rs1.getString("PST_HOHYPERTENSION").trim();
				mDiabetesMellitus=rs1.getString("PST_HODIABETESMELLITUS").trim();
				mBronchialAsthma=rs1.getString("PST_HOBRINICALASTHAMA").trim();
				mAllergicBronchites=rs1.getString("PST_HOALLERGICBRONCHITES").trim();
				mConvulsioris=rs1.getString("PST_HOCONVULSIORISORFITS").trim();
				mCongentialDiease=rs1.getString("PST_HOANYCONGENTIALDIEASES").trim();
				mAnyMajorOrAccidental=rs1.getString("HOANYMAJORSURGERYORACCIDENT").trim();
				mAnyDrugIntake=rs1.getString("HOANYDRUGINTAKE").trim();
				mAnyOther=rs1.getString("ANYOTHER").trim();
			}
String mChkPrs1A="", mChkPrs1B="", mChkPrs2A="", mChkPrs2B="", mChkPrs3A="", mChkPrs3B="", mChkPrs4A="", mChkPrs4B="", mChkPst1A="", mChkPst1B="", mChkPst2A="", mChkPst2B="", mChkPst3A="", mChkPst3B="", mChkPst4A="", mChkPst4B="", mChkPst5A="", mChkPst5B="", mChkPst6A="", mChkPst6B="", mChkMajorA="", mChkMajorB="", mChkDrugA="", mChkDrugB="";
			if(!mAllergicToDrug.equals(""))
			{
				mChkPrs1A="checked";
				mChkPrs1B="";
			}
			else
			{
				mChkPrs1A="";
				mChkPrs1B="checked";
			}
			if(!mHOAddition.equals(""))
			{
				mChkPrs2A="checked";
				mChkPrs2B="";
			}
			else
			{
				mChkPrs2A="";
				mChkPrs2B="checked";
			}
			if(!mPsychiatricIllness.equals(""))
			{
				mChkPrs3A="checked";
				mChkPrs3B="";
			}
			else
			{
				mChkPrs3A="";
				mChkPrs3B="checked";
			}
			if(!mTypeOfPITreatment.equals(""))
			{
				mChkPrs4A="checked";
				mChkPrs4B="";
			}
			else
			{
				mChkPrs4A="";
				mChkPrs4B="checked";
			}
			if(!mHypertension.equals(""))
			{
				mChkPst1A="checked";
				mChkPst1B="";
			}
			else
			{
				mChkPst1A="";
				mChkPst1B="checked";
			}
			if(!mDiabetesMellitus.equals(""))
			{
				mChkPst2A="checked";
				mChkPst2B="";
			}
			else
			{
				mChkPst2A="";
				mChkPst2B="checked";
			}
			if(!mBronchialAsthma.equals(""))
			{
				mChkPst3A="checked";
				mChkPst3B="";
			}
			else
			{
				mChkPst3A="";
				mChkPst3B="checked";
			}
			if(!mAllergicBronchites.equals(""))
			{
				mChkPst4A="checked";
				mChkPst4B="";
			}
			else
			{
				mChkPst4A="";
				mChkPst4B="checked";
			}
			if(!mConvulsioris.equals(""))
			{
				mChkPst5A="checked";
				mChkPst5B="";
			}
			else
			{
				mChkPst5A="";
				mChkPst5B="checked";
			}
			if(!mCongentialDiease.equals(""))
			{
				mChkPst6A="checked";
				mChkPst6B="";
			}
			else
			{
				mChkPst6A="";
				mChkPst6B="checked";
			}
			if(!mAnyMajorOrAccidental.equals(""))
			{
				mChkMajorA="checked";
				mChkMajorB="";
			}
			else
			{
				mChkMajorA="";
				mChkMajorB="checked";
			}
			if(!mAnyDrugIntake.equals(""))
			{
				mChkDrugA="checked";
				mChkDrugB="";
			}
			else
			{
				mChkDrugA="";
				mChkDrugB="checked";
			}


			qry="Select StudentName, EnrollmentNo from StudentMaster Where studentid='"+mChkMemID+"' AND INSTITUTECODE='"+mInst+"' ";
			rs=db.getRowset(qry);
			if(rs.next())
			{
			%>
			<tr><bR>
			<td align=left colspan=4><Font color=Red face=arial size=2><U><b>Note : </b></U><b>	 Confirmation of Medical History, Name & Email-ID <bR>
		<UL>
			<LI>Mandatory
			<LI>In case you do not fill,you will not be able to proceed.
			<LI>In case of wrong Mail ID - Please correct & submit.
			<LI>In case of correction in Name contact in Registry.</b>
		</UL>
			</font></td>
			
			
			</tr>

			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Name : </b></font></td>
			<td nowrap><Font color=navy face=arial size=3><%=rs.getString(1)%></Font></td>
			</tr>

			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Roll No : </b></font></td>
			<td nowrap><Font color=navy face=arial size=3><%=rs.getString(2)%></Font></td>
			</tr>
			<%}%>
			<tr>
			<td align=left><Font color=navy face=arial size=3><b>Hostel/Room No. : </b></font></td>
			<td nowrap><INPUT ID="RoomNo" Name="RoomNo" Type="text" value="<%=mRoomNo%>" style="WIDTH: 160px; HEIGHT: 22px" maxLength=30></td>
<%		
qry="select nvl(StEmailid,' ') sEmail,  nvl(PaEmailid,' ') pEmail from Studentphone where STUDENTID='" +mChkMemID+ "'";
rs=db.getRowset(qry);
if ( rs.next())
{
	%>
<tr>
			<td align=left><Font color=navy face=arial size=3><b>Student Email-ID : </b></font></td>
			<td nowrap><INPUT ID="EmailID" Name="EmailID" Type="text" value="<%=rs.getString(1)%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=30></Font></td>
			</tr>
			<%
}
	else
			{
				%>
<tr>
			<td align=left><Font color=navy face=arial size=3><b>Student Email-ID : </b></font></td>
			<td nowrap><INPUT ID="EmailID" Name="EmailID" Type="text"  style="WIDTH: 300px; HEIGHT: 22px" maxLength=60></Font></td>
			</tr>
			<%
			}
	%>

			<td align=right><b><a href="StudentMedicalHistoryReport.jsp" target="NEW" title="click to view submitted medical history"><font color=blue size=3 face=verdana>View Medical History</font></a></b></td>
			</tr>
			</table>

			<table align=center width=90% cellpadding=1 border=1 cellspacing=0>
			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Present Complaint </U></b></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Any History of Allergic to Drug : </b></font></td>
			<td nowrap><INPUT ID="PrstC1" Name="PrstC1" Type="radio" value="Y" <%=mChkPrs1A%> onClick="funChangeTxtPrstC1A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPrstC1" Name="txtPrstC1" Type="text" value="<%=mAllergicToDrug%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PrstC1" Name="PrstC1" Type="radio" value="N" <%=mChkPrs1B%> onClick="funChangeTxtPrstC1B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; History of Addiction : </b></font></td>
			<td nowrap><INPUT ID="PrstC2" Name="PrstC2" Type="radio" value="Y" <%=mChkPrs2A%> onClick="funChangeTxtPrstC2A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPrstC2" Name="txtPrstC2" Type="text" value="<%=mHOAddition%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PrstC2" Name="PrstC2" Type="radio" value="N" <%=mChkPrs2B%> onClick="funChangeTxtPrstC2B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td valign=top><Font color=black face=arial size=2><b>&nbsp; Psychiatric illness : </b></font></td>
			<td nowrap><INPUT ID="PrstC3" Name="PrstC3" Type="radio" value="Y" <%=mChkPrs3A%> onClick="setFocus1A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPrstC3" Name="txtPrstC3" Type="text" value="<%=mPsychiatricIllness%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PrstC3" Name="PrstC3" Type="radio" value="N" <%=mChkPrs3B%> onClick="setFocus1B()"><font face=arial size=2 color=green><B>No</B></font>
			<BR>
			<Font color=black face=arial size=2><b>&nbsp;On Treatment?</b></font>
			<BR>
			&nbsp; <INPUT ID="PrstC3a" Name="PrstC3a" Type="radio" value="Y" disabled <%=mChkPrs4A%> onClick="setFocus2A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPrstC3a" Name="txtPrstC3a" Type="text" value="<%=mTypeOfPITreatment%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PrstC3a" Name="PrstC3a" Type="radio" value="N" <%=mChkPrs4B%> disabled onClick="setFocus2B()"><font face=arial size=2 color=green><B>No</B></font>
			<BR>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Schilzophrenia" disabled><font face=arial size=2 color=navy><B>Schilzophrenia</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Maniac Desression" disabled><font face=arial size=2 color=navy><B>Maniac Desression</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Anxiety Neurosis" disabled><font face=arial size=2 color=navy><B>Anxiety Neurosis</B></font>
			&nbsp; <INPUT ID="PrstC3a1" Name="PrstC3a1" Type="radio" value="Depresion" disabled><font face=arial size=2 color=navy><B>Depresion</B></font>
			</td>
			</tr>

			<tr>
			<td colspan=2><Font color=black face=arial size=3><b><U>Past History </U></b></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Hypertension : </b></font></td>
			<td nowrap><INPUT ID="PastC1" Name="PastC1" Type="radio" value="Y" <%=mChkPst1A%> onClick="funChangeTxtPastC1A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC1" Name="txtPastC1" Type="text" value="<%=mHypertension%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC1" Name="PastC1" Type="radio" value="N" <%=mChkPst1B%> onClick="funChangeTxtPastC1B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Diabetes Mellitus : </b></font></td>
			<td nowrap><INPUT ID="PastC2" Name="PastC2" Type="radio" value="Y" <%=mChkPst2A%> onClick="funChangeTxtPastC2A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC2" Name="txtPastC2" Type="text" value="<%=mDiabetesMellitus%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC2" Name="PastC2" Type="radio" value="N" <%=mChkPst2B%> onClick="funChangeTxtPastC2B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Bronchial Asthma : </b></font></td>
			<td nowrap><INPUT ID="PastC3" Name="PastC3" Type="radio" value="Y" <%=mChkPst3A%> onClick="funChangeTxtPastC3A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC3" Name="txtPastC3" Type="text" value="<%=mBronchialAsthma%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC3" Name="PastC3" Type="radio" value="N" <%=mChkPst3B%> onClick="funChangeTxtPastC3B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Allergic Bronchites : </b></font></td>
			<td nowrap><INPUT ID="PastC4" Name="PastC4" Type="radio" value="Y" <%=mChkPst4A%> onClick="funChangeTxtPastC4A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC4" Name="txtPastC4" Type="text" value="<%=mAllergicBronchites%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC4" Name="PastC4" Type="radio" value="N" <%=mChkPst4B%> onClick="funChangeTxtPastC4B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Convulsioris or Fits : </b></font></td>
			<td nowrap><INPUT ID="PastC5" Name="PastC5" Type="radio" value="Y" <%=mChkPst5A%> onClick="funChangeTxtPastC5A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC5" Name="txtPastC5" Type="text" value="<%=mConvulsioris%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC5" Name="PastC5" Type="radio" value="N" <%=mChkPst5B%> onClick="funChangeTxtPastC5B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><Font color=black face=arial size=2><b>&nbsp; Any Congential Dieases : </b></font></td>
			<td nowrap><INPUT ID="PastC6" Name="PastC6" Type="radio" value="Y" <%=mChkPst6A%> onClick="funChangeTxtPastC6A()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtPastC6" Name="txtPastC6" Type="text" value="<%=mCongentialDiease%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="PastC6" Name="PastC6" Type="radio" value="N" <%=mChkPst6B%> onClick="funChangeTxtPastC6B()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><BR><Font color=black face=arial size=2><b>History of any major Surgery or Accident<BR>(in which there was loss of consciousness) : </b></font></td>
			<td nowrap><BR><INPUT ID="MajorComp" Name="MajorComp" Type="radio" value="Y" <%=mChkMajorA%> onClick="funChangeTxtSurgeryOrAccidentA()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtMajorComp" Name="txtMajorComp" Type="text" value="<%=mAnyMajorOrAccidental%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="MajorComp" Name="MajorComp" Type="radio" value="N" <%=mChkMajorB%> onClick="funChangeTxtSurgeryOrAccidentB()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td nowrap><BR><Font color=black face=arial size=2><b>History of any Drug Intake : </b></font></td>
			<td nowrap><BR><INPUT ID="DrugIntake" Name="DrugIntake" Type="radio" value="Y" <%=mChkDrugA%> onClick="funChangeTxtDrugIntakeA()"><font face=arial size=2 color=red><B>Yes</B></font> <INPUT ID="txtDrugIntake" Name="txtDrugIntake" Type="text" value="<%=mAnyDrugIntake%>" style="WIDTH: 300px; HEIGHT: 22px" maxLength=50> &nbsp; <INPUT ID="DrugIntake" Name="DrugIntake" Type="radio" value="N" <%=mChkDrugB%> onClick="funChangeTxtDrugIntakeB()"><font face=arial size=2 color=green><B>No</B></font></td>
			</tr>

			<tr>
			<td colspan=2><BR><Font color=black face=arial size=2><b>Other History (If Any) : </b></font>
			&nbsp; <INPUT ID="AnyOther" Name="AnyOther" Type="text" value="<%=mAnyOther%>" style="WIDTH: 600px; HEIGHT: 22px" maxLength=250></td>
			</tr>
			</table>
			<table align=center><tr><td nowrap><input type=submit onclick="return Validate();" name=submit value=SUBMIT style="background-color:transparent;border-color:navy;color:navy"></td>&nbsp; &nbsp;<td nowrap><input type=reset name=reset value=CLEAR style="background-color:transparent;border-color:navy;color=navy"></td></tr></table>
			</form>
			<%

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
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
	}  
  }
  catch(Exception e)
  {
  }

%>
<br>
<table align=center><tr><td align=left>
<IMG  src="../../Images/CampusLynx.png">
</td>
<td >
<FONT size =4 style="FONT-FAMILY: ARIal"><b>Campus Lynx</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
<FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 
</body>
</Html>