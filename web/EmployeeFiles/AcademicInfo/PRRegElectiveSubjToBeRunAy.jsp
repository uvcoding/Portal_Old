
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%

DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rss=null;
ResultSet rss12=null;
ResultSet rss123=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="";
String qry1="",qrys="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0;
int kk1=0;
String Tagg="";
int Data=0;
String mComp="";
String mMemberID="";
String mDMemberID="";
String mMemberType="";
String mDMemberType=""; 
String mMemberCode="";
String mDMemberCode="";
String mMemberName="";
String mInstitute="",mInst="";
String mExam="",mE="";
String mexam="";
String mLTP="";
String mltp="";
String mName1="",mName2="",mName3="",mName4="",mName5="",mName6="",mName7="",mName8="",mName9="",mName13="";
String mSubj="",mELECTIVECODE="";
String msubj="";
String mSubjType="";
String msubjType="",mST="",mCustomRun="",mCustom="",mSubRunPE="",mSubRunPS="";
int mFlag=0;
String qrry12="";
ResultSet rsss12=null;
String runlist="N";


if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
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



String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Elective Subject(s) to be Run by HOD ] </TITLE>


<script language="JavaScript" type ="text/javascript">
 
  if (top != self) top.document.title = document.title;

</script>
<script>

    function checkall(source) {
  checkboxes = document.getElementsByName('yearType');
  for(var i=0, n=checkboxes.length;i<n;i++) {
    checkboxes[i].checked = source.checked;
  }
}

</script>

<script language=javascript>
	
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
	
	function Link(str,linkstr)
	{ 	
			var cust=document.getElementById(str);
			//alert(cust.value);
			if(cust.value=="C")
			{
    	    var td=document.getElementById(str+"td");
			
			var link=document.createElement("a");
			
			link.setAttribute("href",linkstr);
			link.setAttribute("id",str+"a");
			link.appendChild(document.createTextNode("Click"));
			td.appendChild(link);
			}
			else if(cust.value=="Y")
			{
				var rem=document.getElementById(str+"a");
				rem.parentNode.removeChild(rem);
			}


			else if(cust.value=="N")
			{
				var rem=document.getElementById(str+"a");
				rem.parentNode.removeChild(rem);
			}

			
	}

	
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

 	     //-----------------------------
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		qry="Select WEBKIOSK.ShowLink('114','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
      
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry=" SELECT  a.EXAMCODE,ENDATE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and a.ExamCode in (Select PREREGEXAMID exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInstitute+"') and nvl(a.PRCOMPLETED,'N')='N' and ENDate is not null and fromdate is not null and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N' And (a.INSTITUTECODE, a.PREVENTCODE) In ";
			qry=qry+" (select b.INSTITUTECODE, b.PREVENTCODE from PREVENTS b where nvl(B.DEACTIVE,'N')='N'";
			qry=qry+" And NVL(B.MEMBERTYPE,'N')<>'S' GROUP BY b.INSTITUTECODE, b.PREVENTCODE)";
			rs= db.getRowset(qry);			
			//out.print(qry);
			if(rs.next())
			{
				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Elective Subject(s) Running Finalization by HOD [Pre registration]</b></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center  border=3 width="80%">
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				<!--*********Exam**********-->
				<td><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
				&nbsp;&nbsp;
				<%
				try
				{   
					qry="Select PREREGEXAMID Exam from COMPANYINSTITUTETAGGING Where COMPANYCODE='"+mLoginComp+"' And INSTITUTECODE='"+mInstitute+"'";
					//out.print(qry);
                    rs=db.getRowset(qry);
					if (request.getParameter("x")==null) 
				 	  {
						%>
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%   
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mexam.equals(""))
 							mexam=mExam;
							%>
							<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
							<%
						}
							%>
						</select>
						<%
					 }
					else
					{
					%>	
						<select name=Exam tabindex="0" id="Exam" style="WIDTH: 120px">	
						<%
						while(rs.next())
						{
							mExam=rs.getString("Exam");
							if(mExam.equals(request.getParameter("Exam").toString().trim()))
				 			{
								mexam=mExam;
								%>
								<OPTION selected Value =<%=mExam%>><%=rs.getString("Exam")%></option>
								<%			
						     	}
						     	else
						         {
							%>
							      	<OPTION Value =<%=mExam%>><%=rs.getString("Exam")%></option>
						      	<%			
						   	}
						}
						%>
						</select>
					  	<%
					 }
				 }    
				catch(Exception e)
				{
				// out.println("Error Msg");
				}
				%>
				
                                

				<B> &nbsp; &nbsp; Semester Type &nbsp; </b><select ID=SemType Name=SemType style="WIDTH: 100px">
				<%
					msemtype="ALL";
					%>
				<option selected value="ALL">ALL</option >
			 	</select>
                                </td></tr><tr><td> <B> Academic Year &nbsp; </b>
				<% //String qryyr="Select distinct ACADEMICYEAR from pr#studentsubjectchoice where examcode='"+mExam+"' AND subjecttype = 'E'";
                                   
                                 String qryyr="";
         qryyr=" SELECT distinct b.academicyear";
   qryyr=qryyr+" FROM prevents a,PREVENTSAYTagging b ";
   qryyr=qryyr+" WHERE a.institutecode = '"+mInstitute+"' ";
   qryyr=qryyr+"AND (a.preventcode) IN ( SELECT preventcode FROM preventmaster dd ";
   qryyr=qryyr+"WHERE examcode = '"+mexam+"' ";
   qryyr=qryyr+"AND NVL (prcompleted, 'N') = 'N' ";
   qryyr=qryyr+"AND NVL (prrequiredfor, 'S') <> 'S' ";
   qryyr=qryyr+"AND NVL (deactive, 'N') = 'N') ";
   qryyr=qryyr+"AND a.membertype <> 'S' AND a.memberid = '"+mDMemberID+"'  AND NVL (a.deactive, 'N') = 'N' ";
   qryyr=qryyr+"and a.institutecode=b.institutecode and a.PREVENTCODE=b.PREVENTCODE and a.MEMBERTYPE=b.MEMBERTYPE and a.MEMBERID=b.MEMBERID and NVL (b.elrnningfinalizedbyhod, 'N') <> 'Y' order by 1 desc  ";
                                //out.print(qryyr);
                                rss12=db.getRowset(qryyr);
                                   %>
                                   

                                <input type="checkbox" name="yearType" value="ALL" onClick="checkall(this)">ALL</input>
                                    <%
                                   while(rss12.next()){

                                      
                                %>
				 <input type="checkbox" name="yearType" value='<%=rss12.getString("ACADEMICYEAR")%>'><%=rss12.getString("ACADEMICYEAR")%></input>
                                <%}%>
			 	
                                    </td></tr><tr><td align="center"><INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td></tr>
				</table>
				</form>
				<%				 
				int mData=0;
				int maxCol=0;
				int mSbjChoice=0;
				
		
				if (request.getParameter("Exam")==null)
					mE=mexam;
				else
					mE=request.getParameter("Exam").toString().trim();
		
				if(request.getParameter("SemType")==null)
					mSemType=msemtype;
				else
					mSemType=request.getParameter("SemType").toString().trim();
				
				mST="E";
				/*qry="select distinct  BDT.PROGRAMCODE PROGRAMCODE ,BDT.ACADEMICYEAR ACADEMICYEAR,BDT.TAGGINGFOR TAGGINGFOR, BDT.SECTIONBRANCH SECTIONBRANCH, nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N')LastStatus,NVL(C.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,B.SUBJECTTYPE SUBJECTTYPE,B.SEMESTER SEMESTER,B.SEMESTERTYPE SEMESTERTYPE,B.EXAMCODE EXAMCODE from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C, BRANCHDEPTTAGGING BDT  where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"'  And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') "; 
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
						qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
						qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
				      		qry=qry+" And B.INSTITUTECODE=BDT.INSTITUTECODE and B.ACADEMICYEAR=BDT.ACADEMICYEAR and B.PROGRAMCODE=BDT.PROGRAMCODE and B.TAGGINGFOR=BDT.TAGGINGFOR and B.SECTIONBRANCH=BDT.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=BDT.INSTITUTECODE and C.ACADEMICYEAR=BDT.ACADEMICYEAR and C.PROGRAMCODE=BDT.PROGRAMCODE and c.TAGGINGFOR=BDT.TAGGINGFOR and c.SECTIONBRANCH=BDT.SECTIONBRANCH";
						qry=qry+" And BDT.DEPARTMENTCODE in (Select Departmentcode from HODList where EmployeeID='"+mDMemberID+"')";
						qry=qry+" Group By BDT.PROGRAMCODE ,BDT.ACADEMICYEAR,BDT.TAGGINGFOR, BDT.SECTIONBRANCH,B.ElectiveCode,A.SubjectCode,B.SubjectID,nvl(A.Subject,A.SubjectCode), nvl(C.SubjectRunning,'N'),C.CUSTOMFINALIZED,B.SUBJECTTYPE,B.SEMESTER,B.SEMESTERTYPE,B.EXAMCODE ";
						qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";
						
						qry="";*/

				/*qry="Select 'Y' from PREVENTS Where   ";
				qry=qry+" INSTITUTECODE='"+mInstitute+"' and ( nvl(ELRNNINGFINALIZEDBYHOD,'N')='Y' or nvl(LOADDISTRIBUTIONSTATUS,'N') in ('F','A'))";
				qry=qry+" and (PREVENTCODE) in (Select PREVENTCODE from PREVENTMASTER dd where ";
				qry=qry+" EXAMCODE='"+mE+"' and nvl(PRCOMPLETED,'N')='N' and nvl(PRREQUIREDFOR,'S')<>'S' and nvl(DEACTIVE,'N')='N')";
				qry=qry+" and MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' and nvl(DEACTIVE,'N')='N'"; */
				// If EL has not been approved then process

    //satendra

qrry12="SELECT 'Y' FROM preventsaytagging a WHERE a.institutecode = '"+mInstitute+"' AND (a.preventcode) IN ( SELECT preventcode ";
 qrry12=qrry12+" FROM preventmaster dd  WHERE examcode = '"+mE+"'  AND NVL (prcompleted, 'N') = 'N' ";
  qrry12=qrry12+" AND NVL (prrequiredfor, 'S') <> 'S' AND NVL (deactive, 'N') = 'N') AND a.membertype <> 'S' ";
  qrry12=qrry12+" AND a.memberid = '"+mDMemberID+"' AND NVL (a.deactive, 'N') = 'N' AND NVL (a.elrnningfinalizedbyhod, 'N') = 'Y' and rownum = 1 ";
      rsss12=db.getRowset(qrry12);
     // out.print(qrry12);
   if(rsss12.next()){

     runlist="Y";


}


  //satendra
   qry=" SELECT distinct b.academicyear"; 
   qry=qry+" FROM prevents a,PREVENTSAYTagging b ";
   qry=qry+" WHERE a.institutecode = '"+mInstitute+"' ";
   qry=qry+"AND (a.preventcode) IN ( SELECT preventcode FROM preventmaster dd ";
   qry=qry+"WHERE examcode = '"+mE+"' ";
   qry=qry+"AND NVL (prcompleted, 'N') = 'N' ";
   qry=qry+"AND NVL (prrequiredfor, 'S') <> 'S' ";
   qry=qry+"AND NVL (deactive, 'N') = 'N') ";
   qry=qry+"AND a.membertype <> 'S' AND a.memberid = '"+mDMemberID+"'  AND NVL (a.deactive, 'N') = 'N' ";
   qry=qry+"and a.institutecode=b.institutecode and a.PREVENTCODE=b.PREVENTCODE and a.MEMBERTYPE=b.MEMBERTYPE and a.MEMBERID=b.MEMBERID and NVL (b.elrnningfinalizedbyhod, 'N') <> 'Y' ";


				rs=db.getRowset(qry);

 
                               // out.print(qry);
				if (rs.next())
				{ 
				%>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<form name="frm1" ID="frm1" Action="PRRegElectiveSubjToBeRunActionAy.jsp" method=post>
				<tr bgcolor='#ff8c00'> 
				<th align=left><font color=white>Program-Branch (Academic Year)</font></th>
				<th><font color=white>Subject</font></th>
                <th><font color=white>Student Limit</font></th>
				<th><font color=white>To Be Offered</font></th>
				<%
				
				
				qry="select max(B.CHOICE) CHOICE from  PR#STUDENTSUBJECTCHOICE B where ";
				qry=qry+" B.INSTITUTECODE='"+mInstitute+"' And B.EXAMCODE='"+mE+"' And B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
				qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (Select D.INSTITUTECODE, D.EXAMCODE ";
				qry=qry+" from PREVENTMASTER D Where D.EXAMCODE='"+mE+"' and nvl(D.DEACTIVE,'N')='N' ";
				qry=qry+" And (D.INSTITUTECODE, D.PREVENTCODE) in (Select E.INSTITUTECODE, E.PREVENTCODE ";
				qry=qry+" from PREVENTS E Where E.MEMBERTYPE<>'S' and E.MEMBERID='"+mDMemberID+"' And nvl(E.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(E.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(E.DEACTIVE,'N')='N') )";
				//out.print(qry);
				rs=db.getRowset(qry);

					if (rs.next()) 
						maxCol=rs.getInt(1); 
					else 
						maxCol=0;

					for(int i=1;i<=maxCol;i++)
					{
					%>
					 <th><font color=white>Choice-<%=i%></font</th>
					<%
					}
					%>
					</tr>
					<%String year="";
					if (mST.equals("E"))
						{
                           String[] items = request.getParameterValues("yearType");
                           StringBuilder sb=new StringBuilder();
                           
                             for(int I = 0; I < items.length; I++){
                                 String var12="";
                                 if(I==0){
                                    var12  ="'"+items[I]+"'";

                                     }else{
                                       var12=",'"+items[I]+"'";
                                }
                               //  String var12=",'"+items[I]+"'";
                              sb=sb.append(var12);
                              
                             }
                   session.setAttribute("sb", sb);

					/***********New Querry by Sajjad 12-04-2017****************/

							qry="select nvl(count(B.CHOICE),-1) Tot ,b.academicyear||b.programcode ||b.taggingfor ||b.sectionbranch ||b.subjectid SubjectGrp ,Choice ";
							qry=qry+" from  PR#STUDENTSUBJECTCHOICE B ,pr#departmentsubjecttagging dst Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And ";
							qry=qry+" B.SUBJECTTYPE='"+mST+"' And B.ACADEMICYEAR in ("+sb+") and  b.institutecode = dst.institutecode AND b.academicyear = dst.academicyear ";
							qry=qry+" AND b.programcode = dst.programcode AND b.taggingfor = dst.taggingfor AND b.sectionbranch = dst.sectionbranch AND b.subjectid = dst.subjectid  ";
							qry=qry+" AND dst.departmentcode in (Select Departmentcode from HODList where EmployeeID='"+mDMemberID+"') And nvl(B.DEACTIVE,'N')='N' ";
							qry=qry+" group by    b.academicyear , b.programcode ,b.taggingfor ,b.sectionbranch  ,b.subjectid ,Choice"; 
							//out.print(qry+"<br><br><br>");
							rs1=db.getRowset(qry);
		
						/***********Changed by Sajjad****************/

                                                qry="select distinct  BDT.PROGRAMCODE PROGRAMCODE ,BDT.ACADEMICYEAR ACADEMICYEAR,BDT.TAGGINGFOR TAGGINGFOR, BDT.SECTIONBRANCH SECTIONBRANCH,  NVL(C.STUDENTLIMIT,'0') STUDENTLIMIT, nvl(A.Subject,A.SubjectCode ) SUBJECT , A.SubjectCode SC, B.SubjectID SID, nvl(B.ElectiveCode, ' ') ElectiveCode, max(B.CHOICE) MaxChoice, nvl(C.SubjectRunning,'N')LastStatus,NVL(C.CUSTOMFINALIZED,'N')CUSTOMFINALIZED,B.SUBJECTTYPE SUBJECTTYPE,B.SEMESTER SEMESTER,B.SEMESTERTYPE SEMESTERTYPE,B.EXAMCODE EXAMCODE from SUBJECTMASTER A, ";
						qry=qry+" PR#STUDENTSUBJECTCHOICE B, PR#ELECTIVESUBJECTS C, PR#DepartmentSubjectTagging BDT  where A.INSTITUTECODE=B.INSTITUTECODE And A.INSTITUTECODE=C.INSTITUTECODE And B.SUBJECTTYPE='"+mST+"'";
						qry=qry+" And B.INSTITUTECODE='"+mInstitute+"' AND A.SUBJECTID=B.SUBJECTID and A.SUBJECTID=C.SUBJECTID and b.ExamCode=C.ExamCode and B.EXAMCODE='"+mE+"' ";
                                                qry=qry+"and B.ACADEMICYEAR IN("+sb+")  ";
                                                qry=qry+" And  B.SEMESTERTYPE=decode('"+ mSemType +"','ALL',B.SEMESTERTYPE,'"+ mSemType +"') ";
						qry=qry+" And B.SUBJECTTYPE='"+mST+"' And (b.INSTITUTECODE,b.EXAMCODE) in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
						qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
						qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
						qry=qry+" And nvl(A.DEACTIVE,'N')='N' And nvl(B.DEACTIVE,'N')='N' And nvl(C.Deactive,'N')='N'";
						qry=qry+" And B.INSTITUTECODE=BDT.INSTITUTECODE and B.ACADEMICYEAR=BDT.ACADEMICYEAR and B.PROGRAMCODE=BDT.PROGRAMCODE and B.TAGGINGFOR=BDT.TAGGINGFOR and B.SECTIONBRANCH=BDT.SECTIONBRANCH";
						qry=qry+" And C.INSTITUTECODE=BDT.INSTITUTECODE and BDT.DEPARTMENTCODE in (Select Departmentcode from HODList where EmployeeID='"+mDMemberID+"') and a.SUBJECTID=BDT.SUBJECTID and b.SUBJECTID=bdt.SUBJECTID and b.EXAMCODE=bdt.EXAMCODE and c.SUBJECTID=bdt.SUBJECTID and c.EXAMCODE=bdt.examcode";
						qry=qry+" Group By BDT.PROGRAMCODE ,BDT.ACADEMICYEAR,BDT.TAGGINGFOR, BDT.SECTIONBRANCH,B.ElectiveCode,A.SubjectCode,B.SubjectID,nvl(A.Subject,A.SubjectCode), nvl(C.SubjectRunning,'N'),C.CUSTOMFINALIZED,B.SUBJECTTYPE,B.SEMESTER,B.SEMESTERTYPE,B.EXAMCODE,STUDENTLIMIT ";
						qry=qry+" Order by ElectiveCode,count(*) Desc,Subject";
                                           }
					//out.print(qry);
					
					rs=db.getRowset(qry);
					%>
					<input type=hidden Name='InstCode' ID='InstCode' value='<%=mInstitute%>'>
					<input type=hidden Name='ExamCode' ID='ExamCode' value='<%=mE%>'>
					<input type=hidden Name='SubjectType' ID='SubjectType' value='<%=mST%>'>
					<input type=hidden Name='SemType' ID='SemType' value='<%=mSemType%>'>

					<%

					String mColor="";
					int mChoice=0;
					String mLastStatus="";
					String mSubjectGrp="";
					String mCol1="LightGrey";
					String mCol2="#ffffff";
					String mChkCode="",mChkOldCode="",mName10="",mName11="",mName12="";

					while(rs.next())
					{ 
					//	mData=1;
						ctr++;
						mName1="SUBJCODE"+ctr;
						mName2="RUNNING"+ctr;
						mName3="ELECTIVE"+ctr;
						mName4="LASTSTATUS"+ctr;
						mName5="PRGCODE"+ctr;
						mName6="TAGGINGFOR"+ctr;
						mName7="SECIONBRANCH"+ctr;
						mName8="ACYEAR"+ctr;
						mName9="SUBJID"+ctr;
						mName10="SEMESTER"+ctr;
						mName11="SEMESTERTYPE"+ctr;
						mName12="SBJECT"+ctr;
                        mName13="STUDENTLIMIT"+ctr;
						mCustom="CUSTOM"+ctr;
						mChkCode=rs.getString("PROGRAMCODE")+rs.getString("SECTIONBRANCH") +rs.getString("ACADEMICYEAR")+rs.getString("ELECTIVECODE");
						if (mST.equals("E"))
							mELECTIVECODE=rs.getString("ELECTIVECODE");
						else
							mELECTIVECODE=" ";
						mSbjChoice=rs.getInt("MaxChoice");
						if (!mChkCode.equals(mChkOldCode))
							{
							   if (mChoice==0)
								mChoice=1 ;
							   else
								mChoice=0 ;
							mChkOldCode=mChkCode;
							}

						if (mChoice==0) 
							mColor=mCol1;
						else
						      mColor=mCol2;

						mLastStatus=rs.getString("LastStatus").toString().trim();
						/*sajjad*/
						mSubjectGrp=rs.getString("ACADEMICYEAR")+rs.getString("PROGRAMCODE")+rs.getString("TAGGINGFOR")+rs.getString("SECTIONBRANCH")  +rs.getString("SID");
						//	rs.getString("SubjectGrp"); /*sajjad*/
						//mCustomRun=rs.getString("CUSTOMFINALIZED").toString().trim();
						%>
						<tr bgcolor="<%=mColor%>">
						<td>&nbsp;<%=rs.getString("PROGRAMCODE")%>-<%=rs.getString("SECTIONBRANCH")%>
						 &nbsp;(<%=rs.getString("ACADEMICYEAR")%>)</td>
						<td nowrap>&nbsp;<%=rs.getString("SC")%>&nbsp; - &nbsp;
						<%
						    if (mELECTIVECODE.equals(" "))
					      	{
							%>	
								<%=rs.getString("SUBJECT")%>
							<%
							}
							else	
							{		
							%>
								<%=rs.getString("SUBJECT")%>&nbsp;(<%=mELECTIVECODE%>)&nbsp;
							<%		
							}
							
						//out.print(mLastStatus+"LastStatus"+mCustomRun+"Custom");	
						%>
                        </td ><td align="right"><%=rs.getString("STUDENTLIMIT")==null?"0":rs.getString("STUDENTLIMIT")%>&nbsp;&nbsp;</td>
						<input type=hidden Name=<%=mName1%> ID=<%=mName1%> value='<%=rs.getString("SC")%>'>
						<input type=hidden Name="<%=mName3%>" ID="<%=mName3%>" value='<%=mELECTIVECODE%>'>
						<input type=hidden Name=<%=mName4%> ID=<%=mName4%> value='<%=mLastStatus%>'>
						<input type=hidden Name=<%=mName5%> ID=<%=mName5%> value='<%=rs.getString("PROGRAMCODE")%>'>
						<input type=hidden Name=<%=mName6%> ID=<%=mName6%> value='<%=rs.getString("TAGGINGFOR")%>'>
						<input type=hidden Name=<%=mName7%> ID=<%=mName7%> value='<%=rs.getString("SECTIONBRANCH")%>'>
						<input type=hidden Name=<%=mName8%> ID=<%=mName8%> value='<%=rs.getString("ACADEMICYEAR")%>'>
						<input type=hidden Name=<%=mName9%> ID=<%=mName9%> value='<%=rs.getString("SID")%>'>
						<input type=hidden Name=<%=mName10%> ID=<%=mName10%> value='<%=rs.getString("SEMESTER")%>'>
						<input type=hidden Name=<%=mName11%> ID=<%=mName11%> value='<%=rs.getString("SEMESTERTYPE")%>'>
						<input type=hidden Name=<%=mName12%> ID=<%=mName12%> value='<%=rs.getString("SUBJECT")%>'>
                        <input type=hidden Name=<%=mName13%> ID=<%=mName13%> value='<%=rs.getString("STUDENTLIMIT")%>'>
						<input type=hidden Name="<%=mCustom%>" ID="<%=mCustom%>" value='<%=mCustomRun%>'>					
						<td>
						<%	
						String linkstr="PRRegElectiveSubjCriteriaAy.jsp?PCode="+rs.getString("PROGRAMCODE")+"&amp;SecBranch="+rs.getString("SECTIONBRANCH")+"&amp;SubjectID="+rs.getString("SID")+"&amp;SubjectType="+rs.getString("SUBJECTTYPE")+"&amp;Semester="+rs.getString("SEMESTER")+"&amp;SemType="+rs.getString("SEMESTERTYPE")+"&amp;AYear="+rs.getString("ACADEMICYEAR") ;
						%>
						  <span id="<%=mName2+"td"%>"></span>
						<select name="<%=mName2%>" id="<%=mName2%>" onchange="Link('<%=mName2%>','<%=linkstr%>')">
						<%	
							/*if(mCustomRun.equals("Y") )
				    		 {	*/
							 %>
							  <!--     <option SELECTED Value="C">Custom</option> -->
							      
								 <%// mFlag=1;
							 // }	
							//else
							if(mLastStatus.equals("Y") )
							
							{	
								%>
								<option selected Value="Y">Yes</option>
								<option Value="N">No</option>
								<!-- <option Value="C">Custom</option> -->
								<%
									//mFlag=0;
							 }
							 else
							 {	
								 %>
							      <option selected Value="N">No</option>
							      <option Value="Y">Yes</option>
								 <!--  <option Value="C">Custom</option> -->
								 <%
									 //mFlag=0;
							  }	
							%>					
						    </select>
							<%
								if(mFlag==1)
								{
								%>
								  <a href ="PRRegElectiveSubjCriteriaAy.jsp?PCode=<%=rs.getString("PROGRAMCODE")%>&amp;SecBranch=<%=rs.getString("SECTIONBRANCH")%>&amp;SubjectID=<%=rs.getString("SID")%>&amp;SubjectType=<%=rs.getString("SUBJECTTYPE")%>&amp;Semester=<%=rs.getString("SEMESTER")%>&amp;SemType=<%=rs.getString("SEMESTERTYPE")%>&amp;AYear=<%=rs.getString("ACADEMICYEAR")%>">Click</a>
								<%
								}
								
							%>
     						</td> 
						<%	
							// Subject cum Choice wise Student Count
								
						    for (int mCh=1;mCh<=maxCol;mCh++)
							{
								/***********Changed by Sajjad****************	   
								qry="select nvl(count(B.CHOICE),-1) Tot from  PR#STUDENTSUBJECTCHOICE B Where B.INSTITUTECODE='"+mInstitute+"' AND B.EXAMCODE='"+mE+"' And B.SUBJECTTYPE='"+mST+"'";
								qry=qry+" And B.SubjectId='"+rs.getString("SID")+"' And B.Choice="+mCh+" And (b.INSTITUTECODE,b.EXAMCODE) ";
								qry=qry+" in (select PE.INSTITUTECODE,PE.ExamCode from PREVENTMASTER PE Where PE.INSTITUTECODE='"+mInstitute+"' and PE.EXAMCODE='"+mE+"' and nvl(PE.PRCOMPLETED,'N')='N' and nvl(PE.PRBROADCAST,'N')='Y' and nvl(PE.PRREQUIREDFOR,'N')<>'S' and nvl(PE.DEACTIVE,'N')='N'";
								qry=qry+" And (PE.INSTITUTECODE, PE.PREVENTCODE) in (Select D.INSTITUTECODE, D.PREVENTCODE ";
								qry=qry+" from PREVENTS D Where D.MEMBERTYPE<>'S' and MEMBERID='"+mDMemberID+"' And nvl(D.ELRNNINGFINALIZEDBYHOD,'N')='N' and nvl(D.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(D.DEACTIVE,'N')='N') )";
								qry=qry+" And B.ACADEMICYEAR='"+rs.getString("ACADEMICYEAR")+"' and B.PROGRAMCODE='"+rs.getString("PROGRAMCODE")+"'";
								qry=qry+" And B.TAGGINGFOR='"+rs.getString("TAGGINGFOR")+"' and B.SECTIONBRANCH='"+rs.getString("SECTIONBRANCH")+"'";
								qry=qry+" And nvl(B.DEACTIVE,'N')='N'";
								qry=qry+" Order by Choice";
								//out.print(qry);
								rs1=db.getRowset(qry);
							      if (rs1.next() && rs1.getInt(1)>0)
								   {
									%>
										<td align=right><%=rs1.getInt(1)%>&nbsp;&nbsp;</td>
									<%
								    }		
								else
								   {
									%>
										<td>&nbsp;</td>
									<%

								   }	*/
							int j =0 ;
								while(rs1.next())
								{
								 // out.print(mSubjectGrp +" "+rsn.getString(2));
								 if (mSubjectGrp.equals(rs1.getString(2)) && mCh == (rs1.getInt(3) ))
									{

								 if ( rs1.getInt(1)>0)
								   {
									%>
										<td align=right><%=rs1.getInt(1)%>&nbsp;&nbsp;</td>
									<%
								    }		
								else
								   {
									%>
										<td>&nbsp;</td>
									<%

								   }
								   j = 1;
									break; //exit the loop
								  }
                                }
								if (j!=1)
								{
									%>
										<td>&nbsp;</td>
									<%
								}
							  rs1.first();
							  /***********Changed by Sajjad****************/	   
							  }
					


					%>
					</tr>
					<%
					
  					}

			if (mData==0)
		{
				%>				 
				<tr><td colspan=<%=maxCol+5%> ALIGN=CENTER><font color=Blue size=3><b>Elective Subject(s) to be Run is <sup>#</sup>Finalized</b>?&nbsp; <input name=finalized id=finalized type="Radio" Value="YES"><b>Yes</b>&nbsp; &nbsp; &nbsp;<input Type="Radio" value="NO" checked name=finalized id=finalized><b>No</b>  </font></td></tr>

				<TR><TD colspan=<%=maxCol+5%> ALIGN=CENTER><INPUT Type="submit" Value="Save Running Subjects"></TD></TR>
				<%
				}
				%>
				<input type=hidden Name='Total' ID='Total' value='<%=ctr%>'>
				<tr><td colspan=<%=maxCol+5%>
				<b><u>Note:</u></b><br>
				<font color=red><b><sup>#</sup>Finalized:</b>
					Once You <b>Finalized</b> (Select <b>YES</b> and click on <b>SAVE</b>) then further modification of Elective Subjects to be run will not be possible and the selected Subjects will be taken as RUNNING SUBJECTS
				</red></td></tr>
			</form>
			</TABLE>
			 <%
			}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration : Elective Subject Rnning is already approved/Finalized</FONT><br>
		</P>

		</P>
		 <%
		}


  		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared or Registration completed</FONT></P>
		 <%
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
	<h3><br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>This page is not authorized/available for you.
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
if(runlist.equals("Y")){ %>
<b>Click here to see a list of finalized <a href='ElectiveSubjectRunningListAY.jsp'><font color="blue">Elective Sbjects(Running)</font></a></b><br><br>
<%}%>
</body>
</html>
