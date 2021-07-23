<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%
String mHead="",mCompCode ="";
String mCandCode="", MName="";
String mCandName="";
long mDt=0;
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JIIT ";
%>
<HTML>
<head>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />

<TITLE>#### <%=mHead%> [ View Department wise Employee Profile/information ] </TITLE>
 

<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>

<script language=javascript>
 
	function RefreshContents()
	{ 	
    	    document.frm.x.value='ddd';
    	    document.frm.submit();
	}
//-->
</SCRIPT>
<script>
if(window.history.forward(1) != null)
window.history.forward(1);
</script>
</head>
<body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
<%
//GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String qry="",x="";
int msno=0;
ResultSet rs=null;
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

if (session.getAttribute("CompanyCode")==null)
{
	mCompCode="JIIT";
}
else
{
	mCompCode=session.getAttribute("CompanyCode").toString().trim();
}

OLTEncryption enc=new OLTEncryption();
   if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mMemberCode=enc.decode(mMemberCode);
		mMemberType=enc.decode(mMemberType);
		mMemberID=enc.decode(mMemberID);
		
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;
		  //-----------------------------
		  //-- Enable Security Page Level  
		  //-----------------------------
		qry="Select WEBKIOSK.ShowLink('90','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
      	RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
		  //----------------------
		
				try
				{				
				%>
				<font size=4 face="arial" color="#a52a2a"><u><marquee scrolldelay=300 behavior=alternate>Click the desired Department to view Employee List of the same department</marquee></u></font>
				<table class="sort-table" id="TblEmpView" rules=rows cellSpacing=1 cellPadding=0 width="95%" align=center border=1>
				<thead>
				<tr bgcolor="#c00000">
				<td title="Click here to sort list on Serial Number"><font color="white"><b>Sno</b></font></td>
				<td title="Click here to sort list on Department Name"><font color="white"><b>Department</b></font></td>
				<td title="Click here to sort list on Employee Strength"><font color="white"><b>Employee Strength</b></font></td>
				</tr>
				</thead>
				<%
				qry="Select nvl(A.DEPARTMENTCODE,' ')DEPARTMENTCODE, nvl(A.DEPARTMENT , ' ') DEPARTMENT, " +
                        "count(Distinct B.EmployeeID) DeptSize from DEPARTMENTMASTER A, V#Staff B " +
                        "where A.DEPARTMENTCODE=B.DEPARTMENTCODE and B.COMPANYCODE  in ( 'UNIV','JPBS') " +
                        "and nvl(A.Deactive,'N')='N' and  b.EMPLOYEEID in (select EMPLOYEEID from employeemaster where " +
                        "      companycode in ( 'UNIV','JPBS') and nvl(deactive,'N')='N' )  " +
                        " Group by A.DEPARTMENTCODE,A.DEPARTMENT " +
                        "order by A.DEPARTMENT";
				rs=db.getRowset(qry);
				//out.print(qry);

                
				while(rs.next())
				{	msno++;
					
				
					mDt=rs.getLong("DeptSize");

                  //  out.print(rs.getString("DepartmentCode")+"ssss");
					%>
					<tr>
						<td Align=right><%=msno%></td>
						<td nowrap>&nbsp;<font size=2>
                            <A title='Click here to List employee of <%=rs.getString("Department")%> department'
                            href="IndvDeptEmpViewEmpInfo.jsp?DNO=<%=rs.getString("DepartmentCode").toString().trim()%>">
                                <%=rs.getString("Department")%>
                            &nbsp;&nbsp;(<%=rs.getString("DEPARTMENT")%>)</a></font></td>
						<td><font size=2><%=mDt%></font></td>
						</tr>
					<%
				}
			
				%>
				</table>
				<script type="text/javascript">
				var st1 = new SortableTable(document.getElementById("TblEmpView"),["Number","CaseInsensitiveString","Number"]);
				</script>
				<%
	
		}
		catch(Exception e)
		{
			//out.print(qry);
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
	<h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------




}
else
{
	out.print("<br><img src='Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
}

%>
</body>
</html>