<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
String mInst="", mHead="";
if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();

if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=mInst+" ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Examination Event/Sub Event Tagging ] </TITLE>

<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
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



function ChangeOptions(Exam,DataEvent,DataCombo,Event,Subject)
{    
  removeAllOptions(Event);	
	var QryEvent='';
		alert(DataEvent+"sdsd");
     for(i=0;i<DataEvent.options.length;i++)
       {
		var v1;
		var pos;
		var ec;
		var ev;
		var len;
		var otext;
		var v1=DataEvent.options(i).value;
		len= v1.length ;	
		pos=v1.indexOf('***');
		ec=v1.substring(0,pos);
		ev=v1.substring(pos+3,len);
		if (ec==Exam)
		 { 	
			var optn = document.createElement("OPTION");
			optn.text=DataEvent.options(i).text;
			optn.value=ev;
			if (QryEvent=='') QryEvent=ev;
			Event.options.add(optn);
			
		  }
		}
 	 
	   removeAllOptions(Subject);	 
	    for(i=0;i<DataCombo.options.length;i++)
	      {  
			var v1s;
			var pos1;
			var pos2;
			var exams;
			var evs;
			var lens;
			var sc;
			var otexts;
			var v1s=DataCombo.options(i).value;
			lens= v1s.length ;	
			pos1=v1s.indexOf('***');
			pos2=v1s.indexOf('///')
			exams=v1s.substring(0,pos1);
			evs=v1s.substring(pos1+3,pos2);
			sc=v1s.substring(pos2+3,lens);

		if (exams==Exam && QryEvent==evs)
		 { 				
			var optns = document.createElement("OPTION");
			optns.text=DataCombo.options(i).text;
			optns.value=sc;
			Subject.options.add(optns);
		}
		
	   }
}

function ChangeCombo(Event,DataCombo,SubEvent)
{

        removeAllOptions(SubEvent);
		//alert("xcxxx"+SubEvent);
	var optn = document.createElement("OPTION");

	optn.text="<--Select an Sub-Event-->";
	optn.value="NONE";
	SubEvent.options.add(optn);
	
	for(i=0;i<DataCombo.options.length;i++)
        {//alert("xcxxx"+SubEvent);
	
                var v1;
		var pos;
		var examevent;
		var subevent;
		var len;
		var v1=DataCombo.options(i).value;
		
		len= v1.length ;	
		pos=v1.indexOf('***');
		examevent=v1.substring(0,pos);
		subevent=v1.substring(pos+3,len);
		//alert(examevent+"xcxxx"+Event);
		if (examevent==Event)
		{ 	
			var optn = document.createElement("OPTION");
			optn.text=DataCombo.options(i).text;
			optn.value=subevent;
			SubEvent.options.add(optn);
		}
	}
}

function removeAllOptions(selectbox)
{
	var i;
//	alert(selectbox+"sdfsdfsdf");
	//alert(selectbox.options.length+"sdfsdf");
	for(i=selectbox.options.length-1 ; i>=0 ; i--)
	{

		selectbox.remove(i);
	}
}

</script>

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
<script language=javascript>
<!--
function trim(str) 
{
 s = str.replace(/^(\s)*/, ''); 
 s = s.replace(/(\s)*$/, ''); 
 return s; 
} 
function validate()
{
  	var expw=trim(document.frm2.EXPWEIGHTAGE.value);
	var wtg=trim(document.frm2.WEIGHTAGE.value);
	var mmax=trim(document.frm2.MAXMARKS.value);
	if (expw=='')
		expw=0;
	if (wtg=='')
		wtg=0;
	if (mmax=='')
		mmax=0;

	if (isNaN(parseFloat(expw)) || isNaN(parseFloat(wtg)) || isNaN(parseFloat(mmax)))
        { 
		alert('Weightae and Maximum Marks must be Numeric');
		return false;
	}
	else
	{
		expw=parseFloat(expw);
		wtg=parseFloat(wtg);
		mmax=parseFloat(mmax);
		if (expw<1)
		{
			alert('You have allready taken Maximum allowed Weightage. No more weightage allowed for this Event/Sub Event'); 
			document.frm2.WEIGHTAGE.focus();
			return false;
		}
		if (parseFloat(wtg)>parseFloat(expw) ||parseFloat(wtg)<1)
		{
			alert('Weightage must be between 1 and '+expw ); 
			document.frm2.WEIGHTAGE.focus();
			return false;
		}
		if(mmax<1)
		{
			alert('Maximum Marks must be >0'); 
			document.frm2.MAXMARKS.focus();
			return false;
		}
		return true;
        }
}
//-->
 </script>
</head>
<body aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >
<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="",minst="",mComp="",mDMemberID="";
String mExamID="",mExamid="",meventcode="",mSubEventCode="",mEventCode="",mSubj="",msubj="";
String qry="",mDualMarks="N",MOM="",Dt1="",Dt2="",mEventCode1="",mEE="",meventcode1="";
double mAllowedWeightage=0,MaxAW=100;
double mAllowedWeightageSubEv=0,MaxAWSubEv=100,EveSubEveVal=0;
int msno=0, len=0, pos=0, ctr=0;
String mCurDate="", mDate1="", mDate2="", msubeven="";
String mFullMarks="100";
ResultSet rs=null, rss=null, rs1=null, rrss=null, rsChkSubEv=null;
ResultSet rse=null;

String  READONLY="",mSubEvent="";
	String mApplicable="",qry1="",mLTP1="",mEventCode11="",mSubeventcode="";
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

	if (session.getAttribute("Designation")==null)
	{
		mDesg="";
	}
	else
	{
		mDesg=session.getAttribute("Designation").toString().trim();
	}
							
	if (session.getAttribute("Department")==null)
	{
		mDept="";
	}
	else
	{
		mDept=session.getAttribute("Department").toString().trim();
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

	qry="select to_Char(Sysdate,'dd-mm-yyyy') date1 from dual";
	rs=db.getRowset(qry);
	if (rs.next())
		mCurDate=rs.getString(1);

	if (request.getParameter("x")!=null || request.getParameter("xx")!=null)
	{
		if(request.getParameter("TXT1")==null)
			mDate1="";
		else
			mDate1=request.getParameter("TXT1").toString().trim();

		if(request.getParameter("TXT2")==null)
			mDate2="";
		else
			mDate2=request.getParameter("TXT2").toString().trim();
	}
	else
	{
		mDate1=mCurDate;
		mDate2=mCurDate;
	}

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
  //-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('58','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
			mDMemberCode=enc.decode(mMemberCode);
			mDMemberType=enc.decode(mMemberType);
			mDMemberID=enc.decode(mMemberID);
			%>
			<form name="frm" method="post" >
			<input id="x" name="x" type=hidden>
			<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
			<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><B>Students <%=msubeven%>Exam Event/Sub Event Subject Tagging</B></TD>
			</font></td></tr>
			</TABLE>
			<table cellpadding=3 cellspacing=1 width="90%"  align=center border=1>
			<tr><td colspan=2 align=center>&nbsp;<font color=navy face=arial size=2><STRONG>Employee : &nbsp;</STRONG></font><font color=black face=arial size=2><B><%=mMemberName%>[<%=mDMemberCode%>]</B>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Department : &nbsp;</STRONG></font><B><%=GlobalFunctions.toTtitleCase(mDept)%></B>
			&nbsp; &nbsp; &nbsp;<font color=navy face=arial size=2><STRONG>Designation : &nbsp;</STRONG></font><B><%=GlobalFunctions.toTtitleCase(mDesg)%></B>
			<hr></td></tr>

		<!--Institute****-->
			<tr>
			<td  align=right><FONT color=black><FONT face=Arial size=2><STRONG>Institute</STRONG></FONT>
			&nbsp;&nbsp;<select name=InstCode tabindex="0" id="InstCode">
			<OPTION selected Value =<%=mInst%>><%=mInst%></option>
			</select>&nbsp;
			</td>
			<td >
		
			<FONT color=black face=Arial size=2>&nbsp;&nbsp;&nbsp;<STRONG>Exam Code</STRONG></FONT>
			<%
			//******************06/02/2010 qry=NVL(LOCKEXAM,'N')='N'************ 
			qry=" Select Exam from (";
			qry+=" Select nvl(EXAMCODE,' ') Exam, EXAMPERIODFROM from EXAMMASTER Where INSTITUTECODE='"+mInst+"' AND";
           		qry+=" nvl(Deactive,'N')='N' AND NVL(LOCKEXAM,'N')='N' and examcode in (Select examcode from facultysubjecttagging)";
	           qry+=" and examcode in (select nvl(GRADEENTRYEXAMID,' ')GRADEENTRYEXAMID from COMPANYINSTITUTETAGGING Where InstituteCode='" + mInst + "' And CompanyCode='" + mComp + "') ";
     		      qry+=" order by EXAMPERIODFROM DESC";
			qry+=") where rownum<15 ORDER BY 1 DESC"; 
			//out.print(qry);
			rs=db.getRowset(qry);
			
			try
			{ 
			   if (request.getParameter("x")==null)
			   {
				%>
				<select name=Exam tabindex="0" id="Exam"	
				onclick="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);">
				<OPTION selected Value="NONE"><b><-- Select an Exam Code --></b></option>
				<%
				while(rs.next())
				{
					mExamid=rs.getString("Exam");
					%>
					<OPTION Value =<%=mExamid%>><%=mExamid%></option>
					<%
				}
			   }
			   else	
			   {
				%>
				<select name=Exam tabindex="0" id="Exam"	
				onclick="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);" onChange="ChangeOptions(Exam.value,DataEvent,DataCombo,Event,Subject);">
				<OPTION Value="NONE"><b><-- Select an Exam Code --></b></option>
				<%
	 			while(rs.next())
				{
					mExamid=rs.getString("Exam");
					if(mExamid.equals(request.getParameter("Exam").toString().trim()))
					{
						%>
						<OPTION selected Value =<%=mExamid%>><%=mExamid%></option>
						<%			
					}
				     	else
				      {
						%>
		      			<OPTION Value =<%=mExamid%>><%=mExamid%></option>
		      			<%			
				   	}
			 	}
			   }
			}
			catch(Exception e)
			{
			    //out.println(e.getMessage());
			}
			//
			%>
			</select>
			&nbsp; &nbsp; &nbsp;
			</td></tr>	
			
			
			
		<!--*********Exam Event Code**********-->
			<tr><td align="right">
			           <%
				
			

			 qry="Select Distinct nvl(EXAMCODE,' ')EXAMCODE, NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent, EVENTFROM from EXAMEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' and InstituteCode='" + mInst + "' Order By EVENTFROM, EXAMEVENTCODE";
			//out.print(qry);
			 rse=db.getRowset(qry);
                        %>
			<select name="DataEvent" tabindex="0" id="DataEvent" style="WIDTH:0px">
			<%
			try
			{ 
			 if (request.getParameter("x")==null)
			 {
				%>
				<OPTION selected Value="NONE"><b><-- Select an Event --></b></option>
				<%
				 while(rse.next())
				 {	mEventCode11=rse.getString("EXAMCODE")+"***"+rse.getString("EXAMEVENTCODE").toString().trim();
						%>
						<OPTION Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%			
					
				}
			}
			else
			{
				%>
				<OPTION Value="NONE"><b><-- Select an Event --></b></option>
				<%
				while(rse.next())
				{
					mEventCode11=rse.getString("EXAMCODE")+"***"+rse.getString("EXAMEVENTCODE").toString().trim();
					if(mEventCode11.equals(request.getParameter("DataEvent")))
	 				{
						
						%>
						<OPTION selected Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%
					}
				}
			}
		     }    
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
		     }
		     %>
	           </select>
		
			
			
			
			<!--*********Exam Event Code**********-->
		
			           <%
				
			 qry="Select Distinct nvl(EXAMCODE,' ')EXAMCODE, NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent, EVENTFROM from EXAMEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' and InstituteCode='" + mInst + "' Order By EVENTFROM, EXAMEVENTCODE";
			 //out.print(qry);
			 rse=db.getRowset(qry);
                        %>
			<select name="DataEvent" tabindex="0" id="DataEvent" style="WIDTH:0px">
			<%
			try
			{ 
			 if (request.getParameter("x")==null)
			 {
				%>
				<OPTION selected Value="NONE"><b><-- Select an Event --></b></option>
				<%
				 while(rse.next())
				 {	mEventCode11=rse.getString("EXAMCODE")+"***"+rse.getString("EXAMEVENTCODE").toString().trim();
						%>
						<OPTION Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%			
					
				}
			}
			else
			{
				%>
				<OPTION Value="NONE"><b><-- Select an Event --></b></option>
				<%
				while(rse.next())
				{
					mEventCode11=rse.getString("EXAMCODE")+"***"+rse.getString("EXAMEVENTCODE").toString().trim();
					if(mEventCode11.equals(request.getParameter("DataEvent")))
	 				{
						
						%>
						<OPTION selected Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value ="<%=mEventCode11%>"><%=rse.getString("ExamEvent")%></option>
						<%
					}
				}
			}
		     }    
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
		     }
		     %>
	           </select>
			
			
			
			
			<FONT color=black><FONT face=Arial size=2><STRONG>Event</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%
			 qry="Select Distinct NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent, EVENTFROM from EXAMEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' and InstituteCode='" + mInst + "' Order By EVENTFROM, EXAMEVENTCODE";
						//out.print(qry);
			 rs=db.getRowset(qry);
                        %>
			<select name="Event" tabindex="0" id="Event" 				onclick="ChangeCombo(Event.value,DataCombo,SubEvent);" 
			onChange="ChangeCombo(Event.value,DataCombo,SubEvent);" >	
			<%
			try
			{ 
			 if (request.getParameter("x")==null)
			 {
				%>
				<OPTION selected Value="NONE"><b><-- Select an Event --></b></option>
				<%
				 while(rs.next())
				 {
					 mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
					 if(meventcode.equals(""))
 					 {
						meventcode=mEventCode;
						//meventcode1=mEventCode;
						%>
						<OPTION Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
						<%			
					 }
					 else
					 {
						%>
						<OPTION Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
						<%			
					 }
				}
			}
			else
			{
				if(request.getParameter("SubEvent").toString().trim().equals("NONE"))
 					{
					%>
					<OPTION selected Value=NONE><--Select an Sub-Event--></option>
					<%			
					}
					else
 					{
					%>
					<OPTION Value =NONE><--Select an Sub-Event--></option>
					<%		
					}
				
				while(rs.next())
				{
					mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
					if(mEventCode.equals(request.getParameter("Event")))
	 				{
						meventcode=mEventCode;
						//meventcode1=mEventCode;
						%>
						<OPTION selected Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
						<%
					}
					else
					{
						%>
						<OPTION Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
						<%
					}
				}
			}
		     }    
		     catch(Exception e)
	     	     {
		    	//out.println(e.getMessage());
		     }
		     %>
	           </select>
		<!-- *****************DataCombo******************* -->
			<%
			try
			{
			 qry="Select Distinct NVL(SUBEVENTCODE,' ')EXAMEVENTCODE,nvl(EXAMEVENTCODE,' ')EXAMEVENT1, SUBEVENTDESC ExamEvent from EXAMSUBEVENTMASTER WHERE ExamCode='"+mExamid+"' and nvl(Deactive,'N')='N' and InstituteCode='" + mInst + "' order by EXAMEVENT1 ";
			// out.println(qry);
			 rs=db.getRowset(qry);
			 %>
			 <select name="DataCombo" tabindex="0" id="DataCombo" style="WIDTH:0px">
			 <%
	
			 if (request.getParameter("x")==null)
			 {
				%>
				<OPTION Value="NONE"><b><-- Select an Event --></b></option>
				<%
				while(rs.next())
				{
					//System.out.print(qry);
					mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
 					mEventCode1=rs.getString("EXAMEVENT1").toString().trim();
	            	     	mEE=mEventCode1+"***"+mEventCode;
					%>
					<OPTION Value ="<%=mEE%>"><%=rs.getString("ExamEvent")%></option> 
					<%
				}
			 }
			 else
			 {
				%>
				<OPTION Value="NONE"><b><-- Select an Event --></b></option>
				<%
				while(rs.next())
				{
					mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
 					mEventCode1=rs.getString("EXAMEVENT1").toString().trim();
			                mEE=mEventCode1+"***"+mEventCode;			
					if(mEventCode.equals(request.getParameter("DataCombo").toString().trim()))
	 				{
					%>
					 <OPTION selected Value ="<%=mEE%>"><%=rs.getString("ExamEvent")%></option> 
					<%			
					}
					else
					{
					%>
					 <OPTION Value ="<%=mEE%>"><%=rs.getString("ExamEvent")%></option> 
					<%			
					}
				}
			 }
			}
			catch(Exception e)
			{
			}
			%>
			<select>
			</td>
		
		<!-----------Exam Sub Event--------->
			<td nowrap>&nbsp;<FONT color=black face=Arial size=2><STRONG>Sub-Event</STRONG>&nbsp;</FONT>
			
			<%
				qry="Select Distinct NVL(SUBEVENTCODE,' ')EXAMEVENTCODE,SUBEVENTDESC ExamEvent ";
				qry=qry+" from EXAMSUBEVENTMASTER WHERE ExamCode='"+mExamid+"' and  ";
				qry=qry+" exameventcode='"+meventcode+"' and InstituteCode='" + mInst + "' and  nvl(Deactive,'N')='N' Order By EXAMEVENTCODE";
				//out.print(qry);
				rs=db.getRowset(qry);
				%>
			<select name="SubEvent" tabindex="0" id="SubEvent">	
			<%
			try
			{ 
				
				if (request.getParameter("SubEvent")==null)
				{
					//System.out.print("sdfsfsdf"+request.getParameter("SubEvent"));
					%>
					<option selected value="NONE"><--Select an Sub-Event--></option>
					<%

					while(rs.next())
					{
						mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
						mSubeventcode=mEventCode;
						%>
						<OPTION Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
						<%
					}
				}
				else
				{
					if(request.getParameter("SubEvent").toString().trim().equals("NONE"))
 					{
					%>
					<OPTION selected Value='NONE'><--Select an Sub-Event--></option>
					<%			
					}
					else
 					{
					%>
					<OPTION Value ='NONE'><--Select an Sub-Event--></option>
					<%		
					}
				
					while(rs.next())
					{
						mEventCode=rs.getString("EXAMEVENTCODE").toString().trim();
						if(mEventCode.equals(request.getParameter("SubEvent").toString().trim()))
 						{
							mSubeventcode=mEventCode;
							%>
							<OPTION selected Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
							<%		
						}
						else
						{
							%>
							<OPTION Value ="<%=mEventCode%>"><%=rs.getString("ExamEvent")%></option>
							<%			
						}
					}
				}
			}
			catch(Exception e)
			{
			}
			%>
			</select>
			</td></tr>

<input type=hidden name="Exam" id="Exam" value="<%=mExamid%>">
	<tr><td colspan=4 nowrap align=center>
		<INPUT TYPE="submit" Value="Submit">
	</td></tr>
	</table>
				</form>

<%


 //}
// out.print(request.getParameter("x")+"asdfsdasdadasda");
	if( request.getParameter("x")!=null )
	{
		mExamid=request.getParameter("Exam").toString().trim();
		mEventCode=request.getParameter("Event").toString().trim();
		mSubEvent=request.getParameter("SubEvent").toString().trim();
	
		
		qry1="Select Distinct examcode, NVL(EXAMEVENTCODE,' ')EXAMEVENTCODE, EXAMEVENTDESC ||'('||EXAMEVENTCODE||')' ExamEvent, nvl(APPLICABLEFOR,'N')APPLICABLEFOR from EXAMEVENTMASTER WHERE ExamCode='"+mExamid+"' AND EXAMEVENTCODE='"+mEventCode+"' and InstituteCode='" + mInst + "'  and nvl(Deactive,'N')='N' ";
		//out.print(qry1);
		  rs1=db.getRowset(qry1);
		 if(rs1.next())
		{
			mApplicable=rs1.getString("APPLICABLEFOR").toString().trim();
		}

		if(mApplicable.length()>1)
				{
				mLTP1=mApplicable.substring(0,1)+"','"+mApplicable.substring(1,2);
				}
				else
				{
					mLTP1=mApplicable;
				}



%>
		<form name=frm11 method=post >
		<input id="y" name="y" type=hidden>
		<input id="x" name="x" type=hidden>
		<input id="LTP" name="LTP" type=hidden VALUE="<%=mLTP1%>">
		<!--********Subject*****-->
		<table  cellpadding=1 cellspacing=0 width="90%"  align=center border=1>
			<tr><td colspan=1 nowrap ALIGN=CENTER>
					<!--********Subject*****-->
						<%
			qry="Select distinct subject, subjectID From (";
		 	qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
			qry=qry+" subjectmaster B where (A.LTP in ('"+mLTP1+"') and  nvl(A.PROJECTSUBJECT,'N')='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+"   and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
			qry=qry+" UNION";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.LTP in ('"+mLTP1+"') and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" UNION ";
		 	qry=qry+" (Select AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' subject , AA.subjectID subjectID from facultysubjecttagging AA, SubjectMaster CC , ";
			qry=qry+" ProgramSubjectTagging BB where AA.LTP in ('"+mLTP1+"') And BB.L=0 and BB.T=0 and nvl(AA.PROJECTSUBJECT,'N')<>'Y' and BB.P>0 And BB.ExamCode='"+mExamid+"' And AA.employeeid='"+mDMemberID+"' and AA.examcode='"+mExamid+"' ";
			qry=qry+" and aa.INSTITUTECODE='"+mInst+"' AND AA.INSTITUTECODE=BB.INSTITUTECODE And AA.EXAMCODE=BB.EXAMCODE And AA.ACADEMICYEAR=BB.ACADEMICYEAR And AA.PROGRAMCODE=BB.PROGRAMCODE And AA.TAGGINGFOR=BB.TAGGINGFOR And AA.SECTIONBRANCH=BB.SECTIONBRANCH And AA.SEMESTER=BB.SEMESTER And AA.BASKET=BB.BASKET And AA.SUBJECTID=BB.SUBJECTID ";
			qry=qry+" And AA.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
			qry=qry+" and nvl(AA.deactive,'N')='N' and nvl(BB.Deactive,'N')='N' and aa.INSTITUTECODE='"+mInst+"' AND ";
			qry=qry+" AA.INSTITUTECODE=CC.INSTITUTECODE AND BB.INSTITUTECODE=CC.INSTITUTECODE AND cc.SUBJECTID=BB.SUBJECTID AND AA.SUBJECTID=CC.SUBJECTID ";
			qry=qry+" and AA.SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' , AA.subjectID)";
			qry=qry+" MINUS";
		 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
			qry=qry+" SUBJECTMASTER B where A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
			qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
			qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
			qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
			qry=qry+" and NVL(STATUS,'D')='F') GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
			qry=qry+" )";
			rss=db.getRowset(qry);
			//out.print(qry);
			%>
			<FONT color=black><FONT face=Arial size=2><STRONG>Subject&nbsp;</STRONG></FONT></FONT>
			&nbsp;&nbsp;&nbsp;<select name=Subject tabindex="0" id="Subject">	
			<%
			try
			{
				if (request.getParameter("y")==null) 
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(msubj.equals(""))
			 			msubj=mSubj;
						%>
						<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
						<%			
					}
				}
				else
				{
					while(rss.next())
					{
						mSubj=rss.getString("SubjectID");
						if(mSubj.equals(request.getParameter("Subject").toString().trim()))
			 			{
							msubj=mSubj;
							%>
							<OPTION selected Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
							<%			
		     				}
					     	else
		      			{
							%>
		      				<OPTION Value =<%=mSubj%>><%=rss.getString("Subject")%></option>
					      	<%
					   	}
					}
				}
			}
			catch(Exception e)
			{
				//out.print(qry);
			}
			%>
			</select>
			</td>
			</TR>
			<tr>
			<td colspan=5 align=center>
			<INPUT Type="submit" Value="&nbsp; Show/Refresh &nbsp;">
			
	<input type=hidden name="SubEvent" id="SubEvent" value="<%=mSubEvent%>">	
	<input type=hidden name="Subject" id="Subject" value="<%=mSubj%>">		
 <input type=hidden name="Event" id="Event" value="<%=mEventCode%>">
<input type=hidden name="Exam" id="Exam" value="<%=mExamid%>">
			</td>
			</tr>
			<tr>
			<td colspan=2>
			</td></tr>
			 </table></form>
			<%
	}
			if(request.getParameter("y")!=null )
			{
				
				//out.print(request.getParameter("Event")+"dfsf");
				if(request.getParameter("Exam")!=null && request.getParameter("Event")!=null && request.getParameter("Subject")!=null )
				{
					mExamID=request.getParameter("Exam").toString().trim();
					mSubj=request.getParameter("Subject").toString().trim();
					
					mEventCode=request.getParameter("Event").toString().trim();
					
					if(request.getParameter("SubEvent")!=null)
					mSubEventCode=request.getParameter("SubEvent").toString().trim();
					else
						mSubEventCode="NONE";

				//	out.println(mSubEventCode+"ssssssssss");
				
					

					double WEIGHTAGE=0,MAXMARKS=0,mW=0;

					String mEv="";
					if(mSubEventCode.equals("NONE"))
						mEv=mEventCode;
					else
						mEv=mEventCode+"#"+mSubEventCode;

				//	out.println(mEv+"ssssssssss");
                    		if(!mEventCode.equals("NONE") && !mExamID.equals("NONE"))
					{

					qry="Select 'Y' from ExamSubEventMaster Where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
					rsChkSubEv=db.getRowset(qry);
				//	out.print(qry);
					int ABCDFlag=0;

					if(!rsChkSubEv.next())
						ABCDFlag++;
					else if(rsChkSubEv.next() && !mSubEventCode.equals("NONE"))
						ABCDFlag++;
					//out.print("ABCDFlag - "+ABCDFlag);
					if(ABCDFlag>0)
					{

				 	qry="select to_char(EVENTFROM,'dd-mm-yyyy')MDF,to_char(EVENTUPTO,'dd-mm-yyyy')MDU from EXAMEVENTMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
					rs=db.getRowset(qry);
					//out.print(qry);
					if(rs.next())
					{
						mDate1=rs.getString("MDF");
						mDate2=rs.getString("MDU");
					}

//*******************************************************************
					qry="Select distinct FSTID FROM (";
		 			qry=qry+"(select A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' subject , A.subjectID subjectID from facultysubjecttagging A, ";
					qry=qry+" subjectmaster B where (A.LTP in ('"+mLTP1+"') and  A.PROJECTSUBJECT='Y') and A.employeeid='"+mDMemberID+"' and A.examcode='"+mExamid+"' and A.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
					qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.subjectID=B.subjectID and nvl(A.deactive,'N')='N' and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.subject,' ')||'('|| nvl(B.subjectcode,' ')||')' , A.subjectID)";
					qry=qry+" UNION";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.LTP in ('"+mLTP1+"') and A.COORDINATORID='"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.COORDINATORTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" UNION ";
				 	qry=qry+" (Select AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' subject , AA.subjectID subjectID from facultysubjecttagging AA, SubjectMaster CC , ";
					qry=qry+" ProgramSubjectTagging BB where AA.SUBJECTID='"+mSubj+"' AND AA.LTP in ('"+mLTP1+"') AND nvl(AA.PROJECTSUBJECT,'N')<>'Y' And BB.L=0 and BB.T=0 and BB.P>0 And BB.ExamCode='"+mExamid+"' And AA.employeeid='"+mDMemberID+"' and AA.examcode='"+mExamid+"' ";
					qry=qry+" and aa.INSTITUTECODE='"+mInst+"' AND AA.INSTITUTECODE=BB.INSTITUTECODE And AA.EXAMCODE=BB.EXAMCODE And AA.ACADEMICYEAR=BB.ACADEMICYEAR And AA.PROGRAMCODE=BB.PROGRAMCODE And AA.TAGGINGFOR=BB.TAGGINGFOR And AA.SECTIONBRANCH=BB.SECTIONBRANCH And AA.SEMESTER=BB.SEMESTER And AA.BASKET=BB.BASKET And AA.SUBJECTID=BB.SUBJECTID ";
					qry=qry+" And AA.facultytype=decode('"+mDMemberType+"','E','I','E') ";	
					qry=qry+" and nvl(AA.deactive,'N')='N' and nvl(BB.Deactive,'N')='N' and aa.INSTITUTECODE='"+mInst+"' AND ";
					qry=qry+" AA.INSTITUTECODE=CC.INSTITUTECODE AND BB.INSTITUTECODE=CC.INSTITUTECODE AND cc.SUBJECTID=BB.SUBJECTID AND AA.SUBJECTID=CC.SUBJECTID ";
					qry=qry+" and AA.SUBJECTID not IN (SELECT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') GROUP BY AA.FSTID, nvl(CC.subject,' ')||'('|| nvl(CC.subjectcode,' ')||')' , AA.subjectID)";
					qry=qry+" MINUS";
				 	qry=qry+" (select A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' subject , A.subjectID subjectID from V#EX#SUBJECTGRADECOORDINATOR A, ";
					qry=qry+" SUBJECTMASTER B where A.EMPLOYEEID='"+mDMemberID+"' and A.COORDINATORID<>'"+mDMemberID+"' and A.EXAMCODE='"+mExamid+"' and A.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') ";
					qry=qry+" and a.INSTITUTECODE='"+mInst+"' and A.INSTITUTECODE=B.INSTITUTECODE and A.SUBJECTID=B.SUBJECTID and nvl(B.Deactive,'N')='N'";
					qry=qry+" and A.FSTID NOT IN (SELECT FSTID FROM EX#GRADESUBJECTBREAKUP WHERE EMPLOYEEID='"+mDMemberID+"')";
					qry=qry+" and a.SUBJECTID not IN (SELECT DISTINCT SUBJECTID FROM GRADECALCULATION WHERE examcode='"+mExamid+"'";
					qry=qry+" and NVL(STATUS,'D')='F') AND A.SUBJECTID='"+mSubj+"' GROUP BY A.FSTID, nvl(B.SUBJECT,' ')||'('|| nvl(B.SUBJECTCODE,' ')||')' , A.SUBJECTID)";
					qry=qry+" ) order by fstid";
					rss=db.getRowset(qry);
					//out.print(qry);
					String QryFSTID="";
					while(rss.next())
					{
						if(QryFSTID.equals(""))
							QryFSTID="'"+rss.getString(1)+"'";
						else
							QryFSTID=QryFSTID+",'"+rss.getString(1)+"'";
					}
//*******************************************************************
//*******************************************************************
					qry="Select 'Y' from exameventsubjecttagging where fstid in ("+QryFSTID+") and eventsubevent='"+mEv+"'";
					//out.print(qry);
					rss=db.getRowset(qry);
					if(!rss.next())
					{
					qry="select nvl(B.EMPLOYEENAME,' ')||' ('||EMPLOYEECODE||')' EMPNM, nvl(PROGRAMCODE,' ')PROGRAMCODE, nvl(A.SECTIONBRANCH,' ')SECBR, nvl(A.SUBSECTIONCODE,' ')SUBSEC, nvl(A.SEMESTER,0)SEM";
					qry=qry+" FROM FACULTYSUBJECTTAGGING A, V#STAFF B WHERE A.EMPLOYEEID=B.EMPLOYEEID AND A.FSTID in ("+QryFSTID+") and a.INSTITUTECODE='"+mInst+"' ";
					qry=qry+" AND A.FSTID in (Select d.fstid from studentltpdetail d where ExamCode='"+mExamID+"') ORDER BY EMPNM, SECBR, SUBSEC";
					rs1=db.getRowset(qry);
					//out.print(qry);
					%>
					<table bgcolor=#fce9c5 class="sort-table" id="table-1" align=center border=0 cellsapcing=0 cellpadding=0>
					<%
					while(rs1.next())
					{
						%>
						<tr bgcolor=white><td><font face=arial><B><%=rs1.getString("EMPNM")%></td><td> : </td><td><%=rs1.getString("PROGRAMCODE")%> (<%=rs1.getString("SECBR")%>-<%=rs1.getString("SUBSEC")%>)</b></font></td></tr>
						<%
					}
					//out.print(QryFSTID);
					%>
					</table>
					<%
					// Find EventCode weightage
					qry="Select "+MaxAW+" Weightage from EXAMEVENTMASTER where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
				 	 //out.print(qry);
					try
					{
						rs=db.getRowset(qry);	
						if (rs.next())
						{
							WEIGHTAGE=rs.getDouble("Weightage");
						}
					}
					catch(Exception e)
					{
					}

					// Find in Subject Event/Sub Event Tagging

					qry="Select nvl(sum(Weightage),0) Weightage from (select distinct EVENTSUBEVENT, nvl(Weightage,0) Weightage from V#EXAMEVENTSUBJECTTAGGING where INSTITUTECODE='"+mInst+"' and EXAMCODE='"+mExamID+"'";
					qry=qry+" and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') AND EmployeeID='"+mDMemberID+"' and SubjectID='"+mSubj+"' )"; // and (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y'))";
					// out.println(qry);
					try
					{
						rs=db.getRowset(qry);
						mW=0;
						if (rs.next() && rs.getDouble("Weightage")>0)
						{
							mW=rs.getDouble("Weightage");
						}
						WEIGHTAGE=WEIGHTAGE-mW;
					}
					catch(Exception e)
					{
					}
					%>						
					<table align=center border=1>
					<form name=frm2 action='EmpExamEventSubjTaggingAction.jsp' method=post onsubmit="return validate();">
					<tr><TD colspan=5><b>
					Event-Marks Entry From &nbsp; <input Name=TXT1 Id=TXT1 Type=text maxlength=10 size=10 value='<%=mDate1%>' readonly> to <input Name=TXT2 Name=TXT2 Type=text Value='<%=mDate2%>' maxlength=10 size=10 readonly>
					&nbsp; &nbsp; &nbsp; 
					Dual Marks Entry System &nbsp; &nbsp; 
					<%
					qry="Select distinct 'Y' from FacultySubjectTagging Where INSTITUTECODE='"+mInst+"' and COMPANYCODE='"+mComp+"' and ExamCode='"+mExamID+"' and SubjectId='"+mSubj+"' and  LTP in ('"+mLTP1+"') and nvl(PROJECTSUBJECT,'N')='Y'";
					qry=qry+" AND EXISTS (SELECT 'Y' FROM EXAMSUBEVENTMASTER WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND  EXAMEVENTCODE='"+mEventCode+"' AND SUBEVENTCODE='"+mSubEventCode+"' and nvl(DOUBLEENTRY,'Y')='Y')";
					//out.print(qry);
					rs=db.getRowset(qry);
					%>
					<select Name="DualEntry" Id="DualEntry">
					<%
					if(rs.next())
					{
						%>
						<option selected value="Y">Yes</option>
						<%
					}
					else
					{
						%>
						<option selected value="N">No</option>
						<%
					}
					%>
					</select>
					</b></td></tr>
					<tr><TD colspan=2><b>Total Weightage &nbsp; </b></td><td colspan=3><%=MaxAW%></td></tr>
					<tr><TD colspan=2><b>Weightage Already Availed &nbsp; </b></td><TD colspan=3>
					<%
					int mEvFl=0;
					mAllowedWeightage=0;
					qry="Select nvl(A.EVENTSUBEVENT,' ') EVENTSUBEVENT,nvl(A.WEIGHTAGE,0) WEIGHTAGE  From V#EXAMEVENTSUBJECTTAGGING A ";
					qry=qry+" WHERE A.INSTITUTECODE='"+mInst+"' AND A.EXAMCODE='"+mExamID+"' AND A.SUBJECTID='"+mSubj+"'";  // And (LTP='L' OR NVL(PROJECTSUBJECT,'N')='Y')";
					qry=qry+" and (A.EMPLOYEEID='"+mDMemberID+"' OR A.CORDFACULTYID='"+mDMemberID+"') Group By A.EVENTSUBEVENT, A.WEIGHTAGE ORDER BY EVENTSUBEVENT,WEIGHTAGE ";
					//out.print(qry);
					rs=db.getRowset(qry);
					while(rs.next())
					{
						mEvFl++;
						%><%=rs.getString("EVENTSUBEVENT")%> :- <%=rs.getDouble("WEIGHTAGE")%><br><%
						mAllowedWeightage=mAllowedWeightage+rs.getDouble("WEIGHTAGE");
					}
					if(mEvFl==0)
						%>&nbsp;<%
					mAllowedWeightage=MaxAW-mAllowedWeightage;
					%>
					</b></td></tr>
					<tr><TD colspan=2><b>Balance Weightage &nbsp; </b></td><td colspan=3><%=mAllowedWeightage%></td></tr>
					<!--<tr><td colspan=3 align=left><b>Maximum Allowed Weightage: <%=mAllowedWeightage%> out of <%=MaxAW%></b></td></tr>-->
                              <%
                              String SubEvLike=mEventCode+"#";
                              if(mEv.indexOf("#")>0)
                              {
                              	qry="Select WEIGHTAGE from ExamEventMaster WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EXAMEVENTCODE='"+mEventCode+"'";
                                    rs=db.getRowset(qry);
                                    if(rs.next())
                                    	MaxAWSubEv=rs.getDouble(1);

						qry="Select distinct EVENTSUBEVENT, (WEIGHTAGE)WeightageSunEv from ExamEventSubjectTagging WHERE FSTID IN ("+QryFSTID+") AND EVENTSUBEVENT LIKE '"+SubEvLike+"%'";
                                    //System.out.println(qry);
                                    rs=db.getRowset(qry);
                                    while(rs.next())
                                    {
                                    	mAllowedWeightageSubEv=mAllowedWeightageSubEv+rs.getDouble(2);
						}
                                    mAllowedWeightageSubEv=MaxAWSubEv-mAllowedWeightageSubEv;

						if(mAllowedWeightage<=mAllowedWeightageSubEv)
						{
	                                    %>
      	                              <td colspan=5 align=left><b>Maximum Allowed Weightage for <%=mEventCode%> : <%=mAllowedWeightage%> out of <%=MaxAWSubEv%></b></td></tr>
            	                        <%
						}
						else
						{
	                                    %>
      	                              <td colspan=5 align=left><b>Maximum Allowed Weightage for <%=mEventCode%> : <%=mAllowedWeightageSubEv%> out of <%=MaxAWSubEv%></b></td></tr>
            	                        <%
						}
					}
                              %>
					<tr>
					<%
						if(mInst.equals("JPBS"))
						{
								  READONLY=" ";
						}
						else
						{
							READONLY="READONLY";
						}

					if(!mSubEventCode.equals("NONE"))
					{
                              	qry="Select nvl(WEIGHTAGE,0)WEIGHTAGE from ExamSubEventMaster WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EXAMEVENTCODE='"+mEventCode+"' AND SUBEVENTCODE='"+mSubEventCode+"' and nvl(Deactive,'N')='N'";
                                    rrss=db.getRowset(qry);
						//out.print(qry);
                                    if(rrss.next())
                                    	EveSubEveVal=rrss.getDouble(1);
						//out.print("Prefixed Weightage for this Subevent - "+EveSubEveVal);
						%>
						<td><b>Assign '<%=mEv%>' <br>Weightage in Percentage :<b></td><td><input size=3 maxlength=6 Type=text name='WEIGHTAGE' id='WEIGHTAGE' value=<%=EveSubEveVal%> <%=READONLY%>></td>
						<td><b>Assign '<%=mEv%>' <br>Full Marks for Evaluation :<b></td><td><input size=3 maxlength=6 Type=text name='MAXMARKS' id='MAXMARKS' value=<%=mFullMarks%>></td>
						<%
					}
					else
					{
                              	qry="Select nvl(WEIGHTAGE,0)WEIGHTAGE from ExamEventMaster WHERE INSTITUTECODE='"+mInst+"' AND EXAMCODE='"+mExamID+"' AND EXAMEVENTCODE='"+mEventCode+"' and nvl(Deactive,'N')='N'";
                                    rrss=db.getRowset(qry);
						//out.print(qry);
                                    if(rrss.next())
                                    	EveSubEveVal=rrss.getDouble(1);
						//out.print("Prefixed Weightage for this Event - "+EveSubEveVal);
						%>
						<td><b>Assign '<%=mEventCode%>' Weightage in Percentage :<b></td><td><input size=5 maxlength=6 Type=text name='WEIGHTAGE' id='WEIGHTAGE' value=<%=EveSubEveVal%> <%=READONLY%>></td>
						<td><b>Assign '<%=mEventCode%>' Full Marks for Evaluation :<b></td><td><input size=5 maxlength=6 Type=text name='MAXMARKS' id='MAXMARKS' value=<%=mFullMarks%>></td>
						<%
					}
					%>
					<input Type=hidden value=<%=mInst%> id="InstCode" name="InstCode">
					<input Type=hidden value=<%=mExamid%> id="Exam" name="Exam">
					<input Type=hidden value="<%=mInst%>" Name="Inst" ID="Inst">
					<input Type=hidden value="<%=mExamID%>" Name="ExamCode" ID="ExamCode">
					<input Type=hidden value="<%=mSubj%>" Name="SubjectID" ID="SubjectID">
				 	<input Type=hidden value="<%=mEv%>" Name="EventSubEventCode" ID="EventSubEventCode">

					<input Type=hidden value="<%=mDualMarks%>" Name="DualEntry" ID="DualEntry">
					<input Type=hidden value="<%=WEIGHTAGE%>" Name='EXPWEIGHTAGE' ID='EXPWEIGHTAGE'>
					<input Type=hidden value="<%=mDate1%>" Name='Date1' ID='Date1'>
					<input Type=hidden value="<%=mDate2%>" Name='Date2' ID='Date2'>
					<td><input Type=Submit value='Click to Tag Event-Subevent' Name=btn2 id=btn2></td>
					</tr>
					</form>
					</table>
					<%
					} // Select An Event
					else
					{
						%><CENTER><img src='../../Images/Error1.jpg'> <b><font size=3 face='Arial' color='Red'>You have already tagged with this Event/Sub-Event ! &nbsp; Please choose another Event/Sub-Event ...</font></CENTER><%
					}

				   } // Subevent chosed if exist
				   else
				   {
					out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'> <b><font size=3 face='Arial' color='Red'>Sub-Event is required for this Event!</font> <br>");
				   }

				   } // EventSubevent is already tagged
				   else
				   {
					out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'> <b><font size=3 face='Arial' color='Red'>Please choose Event/Sub-Event!</font> <br>");
				   }
//*******************************************************************
				} // Mandatory Items cannot be null
				else
				{
					out.print(" &nbsp;&nbsp;&nbsp <img src='../../Images/Error1.jpg'> <b><font size=3 face='Arial' color='Red'> All Items are mandatory</font> <br>");	
				}
			}
			
	//	}	 
	
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