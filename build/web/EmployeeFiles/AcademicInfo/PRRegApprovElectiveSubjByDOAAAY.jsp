<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %> 
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %> 
<%
DBHandler db=new DBHandler();
ResultSet rs=null;
ResultSet insert=null;
ResultSet rs1=null;
GlobalFunctions gb =new GlobalFunctions();
String qry="",mst="";
String qry1="";
String x="",t="",mfactype="",mSemType="",msemtype="";
int ctr=0;
int kk1=0;
String Tagg="";
int Data=0;
String v="";
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
String mSubj="",mELECTIVECODE="",mDepcode="";
String msubj="";
String mSubjType="";
String msubjType="",mST="",mSubcode="",mDept="";
ResultSet rss12=null;

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
 
 String mLoginComp="";


if (session.getAttribute("LoginComp")==null)
{
	mLoginComp="";
}
else
{
	mLoginComp=session.getAttribute("LoginComp").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInstitute="";
}
else
{
	mInstitute=session.getAttribute("InstituteCode").toString().trim();
}
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<TITLE>#### <%=mHead%> [ Approval of Elective Subject Running by DOAA] </TITLE>
<script language="JavaScript" type ="text/javascript">
<!-- 
  if (top != self) top.document.title = document.title;
-->
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

	
	      
	     //-- Enable Security Page Level  
	     //-----------------------------
		
		mInst=mInstitute;

		qry="Select WEBKIOSK.ShowLink('123','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
		RsChk= db.getRowset(qry);
		if (RsChk.next() && RsChk.getString("SL").equals("Y"))
	   	{
		  //----------------------
	
			qry=" SELECT distinct a.EXAMCODE from PREVENTMASTER a WHERE a.INSTITUTECODE='"+ mInstitute +"' and nvl(a.PRCOMPLETED,'N')='N' and nvl(a.PRBROADCAST,'N')='Y'";
			qry=qry+" AND NVL(PRREQUIREDFOR,'S')<>'S' AND NVL(a.DEACTIVE,'N')='N'";
			rs= db.getRowset(qry);			

			if(rs.next())
			{		
				%>
				<form name="frm"  method="get" >
				<input id="x" name="x" type=hidden>
				<table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
				<tr><TD colspan=0 align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><B>Approval of Elective Subject(s) Running by DOAA</b></TD>
				</font></td></tr>
				</TABLE>
				<table cellpadding=1 cellspacing=0 align=center rules=groups border=3 width="60%">
				<!--Institute****-->
				<INPUT name=InstCode TYPE=HIDDEN id="InstCode" VALUE='<%=mInstitute%>'>
				<tr>
				

				<!--*********Exam**********-->
                                <!--satendra---->
				<td nowrap><FONT color=black><FONT face=Arial size=2><STRONG>Exam Code</STRONG></FONT></FONT>
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

				</td>

                                <!--satendra---->
                                <!--exam code------>
                                <td>
				<B> &nbsp; &nbsp; Semester Type &nbsp; </b><select ID=SemType Name=SemType style="WIDTH: 60px">
				<%
					msemtype="ALL";
					%>
					<option selected value="ALL">ALL</option>			     	
			 	</select></td></tr>
                                <!--satendra-->
                                <tr>
                                <td>

                                 <B> Academic Year &nbsp; </b>
				<% //String qryyr="Select distinct ACADEMICYEAR from pr#studentsubjectchoice where examcode='"+mExam+"' AND subjecttype = 'E'";

                                String qrry12="";
                                qrry12="SELECT distinct a.academicyear FROM preventsaytagging a WHERE a.institutecode = '"+mInstitute+"' AND (a.preventcode) IN ( SELECT preventcode ";
                                qrry12=qrry12+" FROM preventmaster dd  WHERE examcode = '"+mExam+"'  AND NVL (prcompleted, 'N') = 'N' ";
                                qrry12=qrry12+" AND NVL (prrequiredfor, 'S') <> 'S' AND NVL (deactive, 'N') = 'N') AND a.membertype <> 'S' ";
                                qrry12=qrry12+" AND NVL (a.deactive, 'N') = 'N' AND NVL (a.elrnningfinalizedbyhod, 'N') = 'Y' AND NVL (a.Approved, 'N') <> 'Y' ";
                               // out.print(qrry12);
                                rss12=db.getRowset(qrry12);
                                   %>


                                <input type="checkbox" name="yearType" value="ALL" onClick="checkall(this)">ALL</input>
                                    <%
                                   while(rss12.next()){


                                %>
				 <input type="checkbox" name="yearType" value='<%=rss12.getString("academicyear")%>'><%=rss12.getString("ACADEMICYEAR")%></input>
                                <%}%>



 

                                </td>

                                <td align="right">
				<INPUT Type="submit" Value="&nbsp;OK&nbsp;"></td></tr>
				</table>
				</form>
				<TABLE rules=all cellSpacing=0 cellPadding=0 border=1 align=center>
				<tr bgcolor='#ff8c00'>
				 <th><Font color=white>SrNo.</font></th>
				 <th><Font color=white>Department</font></th>
				 <th><Font color=white>Name of HOD</font></th>
				 <th><Font color=white>Click to Approve</font></th>
				 <th><Font color=white>Approval Status</font></th>
				</tr>
				<%
	 			int mData=0;
				int maxCol=0;
				int jk=0;
				if (request.getParameter("InstCode")==null)
						mInstitute=mInst;
					else		
						mInstitute=request.getParameter("InstCode").toString().trim();
		
					if (request.getParameter("Exam")==null)
						mE=mexam;
					else
						mE=request.getParameter("Exam").toString().trim(); 
			
					if(request.getParameter("SemType")==null)
						mSemType=msemtype;
					else
						mSemType=request.getParameter("SemType").toString().trim();
					 
						mST="E";

					
				  if (mST.equals("E"))
					{
                                      try{
                                      String qrydlt="delete tempay";
                                      int insrt=db.update(qrydlt);
                                     }catch(Exception e){
                                     }
                               String[] items =  request.getParameterValues("yearType");
                               StringBuilder academicyr=new StringBuilder();

                                 for(int I = 0; I < items.length; I++){
                                    String var12="";
                                     if(I==0){
                                           var12  ="'"+items[I]+"'";

                                         }else{
                                            var12=",'"+items[I]+"'";
                                }
                               // String var12=",'"+items[I]+"'";
                                 academicyr=academicyr.append(var12);
                                     try{
                                     String qryy123="Insert into  tempAY values('"+items[I]+"')";
                                      int  insrt=db.insertRow(qryy123);
                                       }catch(Exception e){

                                         
                                         }


                             }
                                  session.setAttribute("academicyr", academicyr);

                                                 //out.print(academicyr);

                   //Staendra newew


                   //satendra neww 
                                                  //out.print("");
						qry = "select distinct D.DEPARTMENT DEPARTMENT, D.DEPARTMENTCODE ,decode(nvl(e.APPROVED,'N'),'N','No','Y','Yes','Unk') LastStatus , V.EmployeeID,V.EMPLOYEENAME From V#STAFFSTUDENT V, PREVENTS T,DEPARTMENTMASTER D,preventsaytagging e Where D.DEPARTMENTCODE=V.DEPARTMENTCODE AND   decode(T.MEMBERTYPE,'E','I','S','S','E')=V.EMPLOYEETYPE and T.MEMBERID=V.EMPLOYEEID ";
						qry = qry+" and t.institutecode=e.institutecode  and t.PREVENTCODE=e.PREVENTCODE  and t.MEMBERTYPE=e.MEMBERTYPE  and t.MEMBERID=e.MEMBERID    and e.academicyear in("+academicyr+") ";
                                                qry = qry+" And Nvl(e.ELRNNINGFINALIZEDBYHOD,'N')='Y' and nvl(T.LOADDISTRIBUTIONSTATUS,'N')='N' and nvl(T.DEACTIVE,'N')='N' ";
						qry = qry+" And  (V.DEPARTMENTCODE,T.MEMBERID) in (select H.DEPARTMENTCODE,H.EMPLOYEEID from HODList H";
						qry = qry+" Where H.INSTITUTECODE='"+mInstitute+"' and nvl(H.DEACTIVE,'N')='N') ";
						qry = qry+" And  (T.PREVENTCODE) in (select M.PREVENTCODE from PREVENTMASTER M";
						qry = qry+" Where M.INSTITUTECODE='"+mInstitute+"' and M.EXAMCODE='"+mE+"' and nvl(M.PRCOMPLETED,'N')='N'";
						qry = qry+" And nvl(M.PRREQUIREDFOR,'N') <>'S' and nvl(M.DEACTIVE,'N')='N')  order by DEPARTMENT ";
		                                //out.print(qry);
                                                rs=db.getRowset(qry);
						String mLastStatus="";
						while(rs.next())
						{ 
					              jk++;
					               mLastStatus=rs.getString("LastStatus");
						 %> 
					        <td><%=jk%></td>
					        <td><%=rs.getString("DEPARTMENT")%></td>
					        <td><%=rs.getString("EMPLOYEENAME")%></td>
					        <td><A target=_new title ="Click here to approve/see list of Elective Subjects of <%=rs.getString("DEPARTMENTCODE")%> Department " href='PRRegELApprovalByDOAAActionAY.jsp?DID=<%=rs.getString("DEPARTMENTCODE")%>&amp;ST=<%=rs.getString("LastStatus")%>&amp;EX=<%=mE%>&amp;EID=<%=rs.getString("EmployeeID")%>'><font color='blue'><b>Approves/View Subj.</b></font></a></td>
						<td><%=mLastStatus%></td>
						</tr>
						<%
                                               }
  					  }

					%>
					</form>
			</TABLE>
			 <%
			
  		}
		else
		{
		%>
		<font color=red>
		<h3>	<br><img src='../../Images/Error1.jpg'>
		Pre- Registration Event has not been declared</FONT></P>
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
//out.print("error ");
}
%>
</body>
</html>