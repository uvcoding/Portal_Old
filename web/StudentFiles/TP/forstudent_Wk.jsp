 <%--
    Document   : placementregis_history
    Created on : 4/7/2014
    Author     : mohit.sharma
--%>

<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>

<%

        DBHandler db = new DBHandler();
         OLTEncryption enc=new OLTEncryption();
        int rsum=0,ssum=0,tsum=0,usum=0,vsum=0,wsum=0,xset=0,r=0;
        ResultSet rs =  null;
		ResultSet rst = null;
		ResultSet rsf=  null,rs7=null,rs10=null;
        ResultSet rsd = null,rss=null;
        ResultSet rs1 = null;
        ResultSet rs2 = null,rs3=null,rs5=null,rs6=null,rs9=null,rs11=null;
        ResultSet rsc = null;
String WORKEXPERIANCE="",PROJECT="",INTERNSHIP="",ADD="";

        String qry11="",qry = "",qury="",qry6="",mCritvales1="",qry8="",qry2="",table="",qryc="",mSUBB="",mSUBN="",value="",mDMemberCode="",criteriaid="",criteriatable="",mLTP="",qry1="",inst="",institute="",academic="",academicyear="",criteriavalue="",mChkMemID="",qry5="",msg="",address1="",address2="",state="",city="";
		String qryt = "",Event="",Programcode="",Companycode="",status="",remarks="" ,sysdate="",criteriafield="";
        GlobalFunctions gb = new GlobalFunctions();
	    String mRegCode = "",event="", Academicyear="",mMemberID="",selected="",select="";
        String mEXAMCODE = "" ,mSubjID="",DataSublist="" ,mProgCode="",QryProgCode="",companycode="";
        String mAcademicYear = "",program="",programcode="",mMemberType="",reason="",reason1="";
        String mProgramCode = "";
        String mInstCode = "",mName="";
		String  mreg="" ,mRound="";
		String mHOSTELTYPE = "" , macade="" ,mbranc="" ,sem="",semester="",branch="",branchcode="",mCritvales="" ;
		String mprog="",enddate="",fromdate="",qry9="";
		String mBranchCode = "",msid="",mCode="",mES="",mSubj1="",qrysubj="",Subject="";
        int n=0,i=0,p=0;
        String qryx="",mLTP1="",Branch="",mAcadmeicYear="",mProgram="",mMemberCode="",qry3="";
        ResultSet rsx=null,rs4=null,rs8=null,rsttt=null;
        String reqAction="",mSemester="",mMemberName="",mcheck="",mcheck1="",mcheck2="",mQuota="";
		String mInst="",mSubject="",minst="" ,qrys="",Semester="",qry4
="",mprint="N",qrydetail="";
		int rsum80t1=0,rsum80t2=0,rsum80t3=0,ssum70t1=0,ssum70t2=0,ssum70t3=0,tsum60t1=0,tsum60t2=0,tsum60t3=0,
					usum50t1=0,usum50t2=0,usum50t3=0,vsum40t1=0,vsum40t2=0,vsum40t3=0,wsum30t1=0,wsum30t2=0,wsum30t3=0;
		int count=0 ,Flag=0,cSet=0,subslno=0,k=0,s=0,w=0,f=0,m=0,x=0;



int ttsum1=0,ttsum2=0,ttsum3=0;

mMemberID=request.getParameter("value");



if (session.getAttribute("value")==null)
{
	mMemberID=request.getParameter("value");
}
else
{
	mMemberID=session.getAttribute("value").toString().trim();
}

 


qrydetail=" select  nvl(quota,'NA')quota, institutecode,enrollmentno, semester ,branchcode,academicyear,programcode,STUDENTNAME from studentmaster_w where studentid='"+mMemberID+"'   ";

rsttt=db.getRowset(qrydetail);
if(rsttt.next()){
mInst=rsttt.getString("institutecode").trim();
	mSemester=rsttt.getString("semester").trim();
	mBranchCode=rsttt.getString("branchcode").trim();
	mAcadmeicYear=rsttt.getString("academicyear").trim();
	mProgram=rsttt.getString("programcode").trim();
	mMemberType="S";
	mQuota=rsttt.getString("quota").trim();
mMemberName=rsttt.getString("STUDENTNAME").trim();
	mMemberCode=rsttt.getString("enrollmentno").trim();

}

//out.print("studentid"+mMemberID);


%>
<HTML>
    <head>
        <TITLE>#### JIIT [ Attendance PercentageWise BreackUp]</TITLE>
<script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
<script type="text/javascript" src="js/sortabletable.js"></script>
<link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
<script type="text/javascript" src="sh/jquery-1.4.2.min.js"></script>

    <script type="text/javascript" src="sh/jquery.searchabledropdown-1.0.8.min.js"></script>
	<script type="text/javascript" >



        function getCurrentDateTime()

            {
				var currentDate;
				var retDateTime;
				currentDate = new Date();
                retDateTime=""+currentDate.getDate()+currentDate.getMonth()+currentDate.getFullYear()+currentDate.getHours()+currentDate.getMinutes()+currentDate.getSeconds();
				return retDateTime;
			}
	$(document).ready(function(){
			$("#value").html($("select#event :selected").text() + " (VALUE: " + $("select#event").val() + ")");
			$("select").change(function(){
				$("#value").html(this.options[this.selectedIndex].text + " (VALUE: " + this.value + ")");

				if(this.id=="event"){
					//alert(this.id+"...."+this.value);
				$.get("company.jsp",{event:$("select#event").val(),dt:getCurrentDateTime()},successfunction);
				}

			});
		});
        function successfunction(response)
    {
		if (response) {

			var x=response+"";
			//alert(x);
			if(x==""){}
			else{
				var arrayOfStrings = x.split("$");
                //alert(arrayOfStrings);
				$("select#companycode").empty();
				$('select#companycode').append("<option value=\"" + "" + "\">" +"Select"+ "</option>");
				for(var i=0;i<arrayOfStrings.length-1;i++){
                    var t=arrayOfStrings[i];
					$('select#companycode').append("<option value=\"" + t + "\">" + t+ "</option>");
				}
			}
		}

   }

function vari()
{
    var i=document.getElementById("event").value;
    var j=document.getElementById("companycode").value;
    var msg="";
    var k=0
if(i==(""))
    {
        msg="Event can not be left blank\n";
        k++;
    }
if(j==(""))
    {
        msg=msg+"Company can not be left blank\n";
        k++;
    }
    if(k>0)
        {
            alert(msg);
            return false;
        }
}




        </script>
</head>
    <body aLink=#ff00ff bgcolor=#fce9c5  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >


        <form name="frm"  method="post" >
        <input id="x" name="x" type=hidden>

    <%       try{if(mInst.equals("JIIT") || mInst.equals("J128")   || mInst.equals("JPBS"))
    {
table="TP#REGISTRATIONDETAIL";
    }
else if (mInst.equals("JUIT")){
table="TP#REGISTRATIONDETAIL";

}else if (mInst.equals("JUET")) {
table="TP#REGISTRATIONDETAIL";
}
else {
table="TP#REGISTRATIONDETAIL";
}
qry1="SELECT distinct NVL(COMPANYCODE,' ') c,status s,remarks r FROM "+table+"  Where " +
    " INSTITUTECODE='"+mInst+"' and " +
    "ACADEMICYEAR='"+mAcadmeicYear+"' and PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"'" +
    " and SEMESTER=to_number('"+mSemester+"') and studentid='"+mMemberID+"'";

 //out.print(qry1);
rs=db.getRowset(qry1);
rs1=db.getRowset(qry1);
if(!rs.next()){}
    else{%>
     <table width="70%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Registration History</u></B></FONT></font></td></tr>
        </table>

<table  align=center rules=groups border=3 bordercolor="black" width="70%"  name="tab" class="tab" id="tab" bgcolor="white" >
  <tr bgcolor="Silver">
      <td width="30%" align="center">Company Name</td>
      <td width="30%" align="center">Status</td>
      <td width="30%" align="center">Remarks</td>
  </tr>
 <%while(rs1.next()){
     String stat=rs1.getString("s")==null?"":rs1.getString("s").trim();
     if(stat.equals("I"))
         {
     status="Intrested";
     }
     else if(stat.equals("N"))
         {
     status="Not Intrested";
     }
     else{
     status="Pending";
     }
     %>
  <tr>
 <td width="30%" align="center"><%=rs1.getString("c")==null?"":rs1.getString("c").trim()%></td>
  <td width="30%" align="center"><%=status%></td>
 <td width="30%" align="center"><%=rs1.getString("r")==null?"":rs1.getString("r").trim()%></td>
</tr>
     <%}%> </table>
 <%}
}catch(Exception e){
out.print("Error in showing Registration History"+e);
}
    qry="SELECT COMPANYCODE,SELECTED, PACKAGEOFFEREDINLACKS FROM TP#AFTERINTERVIEW " +
        "where " +
        " INSTITUTECODE='"+mInst+"' and studentid='"+mMemberID+"'";
 //out.print(qry);
    rs=db.getRowset(qry);
rs1=db.getRowset(qry);
    if(!rs.next())
{}
else{%>

 <!--table width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Placement History</u></B></FONT></font></td></tr>
        </table>
<table  align=center rules=groups border=3 bordercolor="black" width="90%" name="tab" class="tab" id="tab" bgcolor="white" >
  <tr bgcolor="Silver">
      <td width="30%" align="center">Company Name</td>
      <td width="30%" align="center">Seleced</td>
  </tr>
<%while(rs1.next()){
selected=rs1.getString("SELECTED")==null?"":rs1.getString("SELECTED").trim();
if(selected.equals("N"))
    {
select="Not Selected.";
}
else{
select="Selected";
}

    %>
<tr>
      <td width="30%" align="center"><%=rs1.getString("COMPANYCODE")%></td>
      <td width="30%" align="center"><%=select%></td>
      </tr-->


<%}
}
    %>


       <br> <table width="70%" ALIGN=CENTER bottommargin=0  topmargin=0>
        <tr>
        <td colspan=0 align=middle>
            <font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: arial"><FONT SIZE="4" COLOR=""><B><u>Student Registration/Update</u></B></FONT></font></td></tr>
        </table >


<table align="center" width="70%" >
<tr>
<td align="left"><FONT face=Arial size=2><STRONG>Student Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</STRONG>&nbsp;&nbsp;<%=mMemberName%></FONT>
<td  align="right"><FONT face=Arial size=2><STRONG>Branch-Program&nbsp;&nbsp;:</STRONG>&nbsp;&nbsp;<%=mBranchCode+"&nbsp;-&nbsp;"+mProgram%></FONT>
</td></tr>
<tr><td  align="left"><FONT face=Arial size=2><STRONG>Current    Semester&nbsp;&nbsp;:</STRONG>&nbsp;&nbsp;<%=mSemester%></FONT></td>
<td align="right"><FONT face=Arial size=2><STRONG>Batch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :</STRONG>&nbsp;&nbsp;&nbsp;&nbsp;<%=mAcadmeicYear%></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>

	<br></table>
		<table  align=center rules=groups border=3 bordercolor="black" width="70%"  name="tab" class="tab" id="tab" bgcolor="white" >

<tr bgcolor="silver">
<td align="left" valign="top" width="40%" nowrap>
<FONT face=Arial size=2><STRONG>Choose Event-</STRONG></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>
			<%

			try
            {
                 qry="SELECT DISTINCT NVL (a.eventcode, '') e ,TO_CHAR (b.eventstartdate,'dd-mm-yyyy')StartDate,TO_CHAR (b.eventenddate,'dd-mm-yyyy')Enddate  FROM tp#eligibilitycriteria a,TP#EVENTMASTER b" +
                        " WHERE NVL (a.deactive, 'N') = 'N' AND to_date(TO_CHAR (SYSDATE, 'dd-mm-yyyy'),'dd-mm-yyyy') BETWEEN" +
                        " to_date(TO_CHAR (b.eventstartdate,'dd-mm-yyyy'),'dd-mm-yyyy')AND to_date(TO_CHAR (b.eventenddate, 'dd-mm-yyyy'),'dd-mm-yyyy')" +
                        "and  NVL (b.LOCKEVENT, 'N') = 'N'and a.eventcode=b.eventcode ";
// out.print(qry2);
				// out.print(qry);
                rs=db.getRowset(qry);
               %>


					<Select Name="event" tabindex="0" id="event">
                    <OPTION Value ="" ><CENTER><--select--></CENTER></OPTION>
                        <%//out.print(qry);
                    if(rs.next())
					{
						event=rs.getString("e");
			if((request.getParameter("x")!=null)||(request.getParameter("y")!=null))
			 			{
							%>
							<OPTION Selected  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
						else
						{
							%>
							<OPTION  Value =<%=event%>><%=rs.getString("e")%></option>
							<%
						}
					event=request.getParameter("event")==null?"":request.getParameter("event").trim();
					}
					%>
					</select>
			<%
			}catch(Exception e)
                {
        out.print("error123 is "+e);
            }

			// out.print("x="+request.getParameter("x"));
			 %>

				</td>
			<td nowrap colspan="2">
	<FONT color=black face=Arial size=2><b>Choose Company-</b></FONT><font color=red face=arial size=2><STRONG>*</STRONG></font>

<select name="companycode" id="companycode">
<OPTION seleceted Value ="" ><--select--></OPTION>
<%
             try{
qry1="SELECT DISTINCT NVL (a.companycode, ' ') c FROM tp#eligibilitycriteria a, tp#eventmaster b " +
        "WHERE NVL (a.deactive, 'N') = 'N' AND a.eventcode = '"+event+"' AND " +
        "TO_DATE (TO_CHAR (SYSDATE, 'dd-mm-yyyy'), 'dd-mm-yyyy') BETWEEN " +
        "to_date(TO_CHAR (b.eventstartdate, 'dd-mm-yyyy'),'dd-mm-yyyy') " +
        "AND to_date(TO_CHAR (b.eventenddate, 'dd-mm-yyyy'),'dd-mm-yyyy') " +
        "AND NVL (b.lockevent, 'N') = 'N' AND a.eventcode = b.eventcode  And not exists(Select   'Y' From    tp#eventcompanyparticipents x where   x.EventCode   = a.EventCode  And x.CompanyCode = a.CompanyCode And ( Nvl(x.Deactive,'N') = 'Y' Or   Nvl(x.LockCompany,'N') = 'Y')) AND  EXISTS ( SELECT 'Y'        FROM tp#eventcompanyparticipents x    WHERE x.eventcode = a.eventcode   AND x.companycode = a.companycode   AND TO_DATE (TO_CHAR (SYSDATE, 'dd-mm-yyyy'),  'dd-mm-yyyy'   ) BETWEEN TO_DATE   (TO_CHAR (X.REGISTRATIONFROMDATE,    'dd-mm-yyyy'                     ), 'dd-mm-yyyy'   )     AND TO_DATE (TO_CHAR (X.REGISTRATIONtODATE,   'dd-mm-yyyy'                                          ),                                                     'dd-mm-yyyy'                                                    )                      )";

       // System.out.print("qryyyyyyyyyyyyyy:"+qry1);
rs2=db.getRowset(qry1);
		if(request.getParameter("x")!=null )
		{

		while(rs2.next())
					{

            	companycode=rs2.getString("c");

			if(companycode.equals(request.getParameter("companycode").toString().trim()))
						{
					%>
						<option selected value=<%=companycode%> ><%=companycode%></option>
					<%  }
					else
						{%>
					<option  value=<%=companycode%> ><%=companycode%></option>
				<%	}

					}
		}
		else
			{
				while(rs2.next())
					{
					companycode=rs2.getString("c");
                    if(companycode.equals(request.getParameter("companycode").toString().trim()))
						{
					%>
						<option selected value=<%=companycode%> ><%=companycode%></option>
					<%  }
					else
						{%>
						<option  value=<%=companycode%> ><%=companycode%></option>
				<%	}

					}

			}


//System.out.println("mprogram="+mProgram);
		companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").trim();
		%>
</select>
		<%}catch(Exception e)
                {
        out.print("error is "+e);}%>
	</td>

   <td>
       <input type="submit" name="btn" id="btn" value="Show"  onclick="return vari();">
   </td>
</tr>
  </table>
 <br> </td>
  </tr>
  </form>
  <form>
  <table width="70%" >
      <%
    try{if(request.getParameter("x")!=null){
		Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
        Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();



/*mInst=rsttt.getString("institutecode").trim();
	mSemester=rsttt.getString("semester").trim();
	mBranchCode=rsttt.getString("branchcode").trim();
	mAcadmeicYear=rsttt.getString("academicyear").trim();
	mProgram=rsttt.getString("programcode").trim();
	mMemberType="S";
mMemberName=rsttt.getString("STUDENTNAME").trim();
	mMemberCode=rsttt.getString("enrollmentno").trim();*/
	//out.print(mInst+"*/*/*/*/*");

%><table  align=center rules=groups border=3 bordercolor="black" width="70%"name="tab" class="tab" id="tab" bgcolor="white" display="hidden" ><tr  bgcolor="silver"><td colspan=2>&nbsp;&nbsp;<B>Company Criteria:</B></td></tr><%
qry="SELECT   distinct a.CSET FROM " +
        "TP#ELIGIBILITYCRITERIAvalue a, tp#criteriamaster b where a.eventcode='"+Event+"' " +
        "and a.COMPANYCODE='"+Companycode+"' and  a.CRITERIAID=b.CRITERIAID ";
	

	if (mQuota.equals("LAT") || mQuota.equals("JPTC") || mQuota.equals("LATERAL") ) {
qry=qry+"  and a.criteriaid = 'QUOTA'  AND a.criteriavalue IN ('JPTC', 'LATERAL', 'LAT') AND NVL(A.FORDIPLOMA,'N')='Y'    ";
	}else {
	
	qry=qry+ "  and a.CRITERIAID='BATCH'   and a.criteriavalue='"+mAcadmeicYear+"'  AND NVL(A.FORDIPLOMA,'N')='N'   ";
	}


qry=qry+"order by a.cset ";
rs=db.getRowset(qry);
if(rs.next())
{
	cSet=rs.getInt("CSET")==0?0:rs.getInt("CSET");
//out.print(cSet);


qry2=" SELECT a.criteriaid, a.criteriaoperatorbefore, a.slno FROM tp#eligibilitycriteria a,TP#CRITERIAMASTER b where a.companycode='"+Companycode+"' and a.eventcode='"+Event+"' and a.cset='"+rs.getInt("CSET")+"' and a.criteriaid=b.criteriaid AND NVL (b.checkbacklog, 'N') <> 'Y' AND NVL (b.checkgap, 'N') <> 'Y' AND NVL (a.requiredinregistration, 'N') = 'Y' ";
rs2=db.getRowset(qry2);
// out.print(qry2+"</br>");
while(rs2.next())
{
mCritvales="";
value="";

qry4=" select CRITERIAID ,CRITERIATABLE ,CRITERIAFIELD  from TP#CRITERIAMASTER where criteriaid='"+rs2.getString("CRITERIAID")+"' AND nvl(checkbacklog,'N') <> 'Y' AND nvl(checkgap,'N') <> 'Y' ";

rs4=db.getRowset(qry4);
if(rs4.next())
{
 qry3=" select CRITERIAVALUE,SUBSLNO  from  TP#ELIGIBILITYCRITERIAVALUE  where companycode='"+Companycode+"' and eventcode='"+Event+"' and cset='"+rs.getInt("cset")+"'  and  criteriaid='"+rs2.getString("CRITERIAID")+"' and    slno='"+rs2.getString("slno")+"'  ";

rs3=db.getRowset(qry3);
//out.print(qry3+"</br>");
while(rs3.next())
{

//---TP



if(rs3.getInt("SUBSLNO")==1 && value.equals(""))
		{
			value=" '"+rs3.getString("CRITERIAVALUE")+"' ";
		}
		else
		{
			value=value+", '"+rs3.getString("CRITERIAVALUE")+"' ";
		}




}

if (rs2.getString("CRITERIAID").equals("CGPA") ||  rs2.getString("CRITERIAID").equals("CGPASEMESTER")){
ADD="";

}else{

ADD="";
}




qry6=" select distinct 'Y' from studentmaster_w a , "+rs4.getString("CRITERIATABLE")+"_w"+" b,TP#ELIGIBILITYCRITERIAVALUE c where c.criteriaid='"+rs2.getString("CRITERIAID")+"' and b."+rs4.getString("CRITERIAFIELD")+"  "+rs2.getString("criteriaoperatorbefore")+" ("+value+") and b.studentid='"+mMemberID+"' and a.INSTITUTECODE='"+mInst+"' " +
        " AND B.studentid = A.STUDENTID and c.cset='"+cSet+"' " ;

if(rs4.getString("CRITERIAFIELD").equals("CGPA"))
	{
qry6=qry6 +" And b.Semester =(select max(c.semester) from  v#studentsgpacgpa_w c where c.institutecode = b.institutecode and   c.studentid = b.studentid) ";
}



%>

<tr bgcolor="white"><td>&nbsp;&nbsp;<%=rs2.getString("CRITERIAID")%>&nbsp;&nbsp;</td><td>&nbsp;&nbsp;<%=rs2.getString("criteriaoperatorbefore")%>&nbsp;&nbsp; <%=value%></td></tr>

 
<%

//i m here 
//out.print(qry6+"</br>");
rs6=db.getRowset(qry6);
rs7=db.getRowset(qry6);

while(!rs6.next())
	{
reason=rs4.getString("CRITERIAFIELD");


++i;


if((reason.equals("CGPA"))||(reason.equals("SEMESTER")))
{
	
	if(k==0)
	{
k++;
msg="noteligble";
if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}
out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* CGPA  "+rs2.getString("criteriaoperatorbefore")+" "+value.substring(1,value.length()-1)+"  </font>"+"<br>");
	}
}
else if(reason.equals("PROGRAMCODE"))
		{
	if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}
	msg="noteligble";
out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* Your program code should be one of them "+value.substring(1,value.length()-1)+"  </font>"+"<br>");
}
else if(reason.equals("BRANCHCODE"))
		{if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}
	msg="noteligble";
out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* Your Branch should be one of them "+value.substring(1,value.length()-1)+"  </font>"+"<br>");
}
else if(reason.equals("PER12"))
		{if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;++++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}
	msg="noteligble";
out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* Your 12th % should be "+rs2.getString("criteriaoperatorbefore")+" "+value.substring(1,value.length()-1)+"  </font>"+"<br>");
}
else{

	out.print(mprint);
	if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+++++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}
msg="noteligble";
out.print("<font color=red>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*  "+reason+"  "+rs2.getString("criteriaoperatorbefore")+" ("+value.substring(1,value.length()-1)+")  </font>"+"<br>");
}


//out.print("<font color=red>re</font>"+"<br>");
xset=rs.getInt("CSET");

break;
}
if(rs7.next())
{if(( s==0) )
		{


s++;
 qry8="SELECT DISTINCT b.criteriaid,b.CRITERIAFIELD FROM tp#eligibilitycriteria a, tp#criteriamaster b WHERE a.companycode = '"+Companycode+"' AND a.eventcode = '"+Event+"' AND a.cset = '"+cSet+"' AND a.criteriaid = b.criteriaid AND NVL (b.checkbacklog, 'N') = 'Y' OR NVL (b.checkgap, 'N') = 'Y' AND NVL (a.requiredinregistration, 'N') = 'Y'";
	//out.print(qry8+"<br>");
rs8=db.getRowset(qry8);
while(rs8.next())
	{
	reason=rs8.getString("CRITERIAFIELD")==null?"":rs8.getString("CRITERIAFIELD").trim();
	//out.print(reason+"<br>");

if(reason.equals("YEAROFPASSING"))
		{
		qry11="SELECT DISTINCT a.criteriaoperatorbefore,b.CRITERIATABLE,b.CRITERIAFIELD,c.CRITERIAVALUE,to_char(d.ENTRYDATE,'yyyy') ENTRYDATE FROM tp#eligibilitycriteria a, tp#criteriamaster b,tp#eligibilitycriteriavalue c,studentmaster d WHERE a.companycode = '"+Companycode+"' AND a.eventcode = '"+Event+"' AND a.cset = '"+cSet+"' AND a.criteriaid = b.criteriaid AND b.criteriafield = '"+reason+"' AND a.criteriaid = c.criteriaid and a.CSET=c.CSET  and d.studentid='"+mMemberID+"' ";
  //out.print(qry11);
		rs11=db.getRowset(qry11);
        if(rs11.next()){
        qry9=" select distinct 'Y' from "+rs11.getString("CRITERIATABLE")+"_w"+" where  to_number('"+rs11.getString("ENTRYDATE")+"') -"+rs11.getString("CRITERIAFIELD")+"" +rs11.getString("criteriaoperatorbefore")+"'"+rs11.getString("CRITERIAVALUE")+"' and Upper(qualificationcode) = '12TH' and studentid='"+mMemberID+"' and INSTITUTECODE='"+mInst+"' ";
    //  out.print(qry9);
	  rs9=db.getRowset(qry9);
         if(!rs9.next())
			{w++;
      msg="noteligble";
	  if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+++++++++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* Gap Should be "+rs11.getString("criteriaoperatorbefore")+" "+rs11.getString("CRITERIAVALUE")+" </font>"+"</br>");
 }}
 }
else if(reason.equals("FAIL"))
		{qry11="SELECT DISTINCT a.criteriaoperatorbefore,b.CRITERIATABLE,b.CRITERIAFIELD,c.CRITERIAVALUE FROM tp#eligibilitycriteria a, tp#criteriamaster b,tp#eligibilitycriteriavalue c WHERE a.companycode = '"+Companycode+"' AND a.eventcode = '"+Event+"' AND a.cset = '"+cSet+"' AND a.criteriaid = b.criteriaid AND   b.criteriafield  = '"+reason+"' AND a.criteriaid = c.criteriaid and a.CSET=c.CSET";
 //out.print(qry11);
		rs11=db.getRowset(qry11);
        if(rs11.next()){
qry9=" select 'Y' from "+rs11.getString("CRITERIATABLE")+"_w "+" where institutecode = '"+mInst+"' and nvl("+rs11.getString("CRITERIAFIELD")+",'N') = 'Y' and studentid = '"+mMemberID+"' having count(*)"+rs11.getString("criteriaoperatorbefore")+""+rs11.getString("CRITERIAVALUE")+"  ";
// out.print(qry9);
 rs10=db.getRowset(qry9);
			if(!rs10.next())
			{w++;
			msg="noteligble";
			if(!mprint.equals("Y"))
		{
	out.print("<font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+++++++++++++You are not eligible for this company<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Required criteria .....</font></br>");
mprint="Y";
}out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color=red>* Backlogs Should be "+rs11.getString("criteriaoperatorbefore")+" "+rs11.getString("CRITERIAVALUE")+" </font>"+"</br>");
			}
		}}
	}
}
}



}
}





if(i>0 || w>0)
	{

}

		else {
m++;

%></table><BR>
<table  align=center rules=groups border=3 bordercolor="black" width="70%" name="tab" class="tab" id="tab" bgcolor="white" display="hidden" >

<%qry="SELECT COMPANYNAME name, EMAILID email,ADDRESS1, ADDRESS2, ADDRESS3 FROM TP#COMPANYMASTER " +
        "where companycode='"+Companycode+"'";
//out.print(qry);
rs=db.getRowset(qry);

if(rs.next()){
%>

 <tr bgcolor="silver">
        <td nowrap align="" width="50%" colspan=2><b>Company Name : </b><%=rs.getString("name")%>&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;</td>
       <!--  <td nowrap align="center" width="50%"><b>Email-id : </b><%=rs.getString("email")%></td> -->
   </tr>
    <%

} qury="SELECT nvl(to_char(eventdate,'dd-mm-yyyy'),'') eventdate,nvl(upper(to_char(eventdate,'day')),'') day, nvl(to_char(timefrom,'hh:mm AM'),'') timefrom, nvl(timeto,'') timeto, nvl(venue,'') venue,nvl(venueaddress1,'') venueaddress1, nvl(venueaddress2,'') venueaddress2, nvl(city,'') city, nvl(state,'') state,nvl(typeofactivity,'') typeofactivity " +
        "FROM tp#participentseventdates WHERE eventcode = '"+event+"' AND companycode = '"+companycode+"'";
//out.print(qury);
rss=db.getRowset(qury);
while(rss.next()){
    mRound=rss.getString("typeofactivity")==null?"":rss.getString("typeofactivity");
if(mRound.equals("W"))
    {
    mRound="Written";
}else if(mRound.equals("G"))
    {
    mRound="Group Discussion";
}
else if(mRound.equals("I"))
    {
    mRound="Interview";
}
//out.print(mRound);
 %>
 <%address1=rss.getString("venueaddress1")==null?"":rss.getString("venueaddress1").trim();
   address2=rss.getString("venueaddress2")==null?"":rss.getString("venueaddress2").trim();
	state=rss.getString("state")==null?"":rss.getString("state").trim();
    city=rss.getString("city")==null?"":rss.getString("city").trim();

if(r==0)
 {r++;%> <tr> <td nowrap align="left"  colspan="2"><b>Event Location&nbsp;:&nbsp;</b><%=rss.getString("venue")==null?"":rss.getString("venue").trim()%>
   <!-- <br><b>Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: </b><%=address1+","+address2%> -->
   <br><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b><%=state+","+city%></td></tr>
<%}%><tr>
    <td nowrap align="left" width="50%"><%if(p==0)
 {p++;%><b>Details &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;</b><%}if(x>0){%>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<%}x++;%>
    <%=mRound+"&nbsp; at &nbsp;"+rss.getString("day")+"&nbsp;"+"("+rss.getString("eventdate")+")&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"%></td>
    <td nowrap align="center" width="50%"><b>Reporting Time 
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;:&nbsp;</b><%=rss.getString("timefrom")==null?"":rss.getString("timefrom").trim()+"&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;"+"<br>"%></td>
  </tr>
<%}%>
<tr>
<td>
    <br>
<b>Registretion Status:</b>
<%qry="SELECT status FROM TP#REGISTRATIONDETAIL where " +
        "Eventcode='"+event+"' and companycode='"+companycode+"' and INSTITUTECODE='"+mInst+"' " +
        "and STUDENTID='"+mMemberID+"' ";
 
rs=db.getRowset(qry);
if(!rs.next())
{
%>
<input type="radio" name="status" value="I" />Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="N" />Not Intrested</br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="P" checked />Pending
<%}else{
    if(rs.getString("status").equals("I"))
    {
   mcheck="checked";
}else if(rs.getString("status").equals("N"))
{
 mcheck1="checked";
}
    else
    {
mcheck2="checked";
} %>
<input type="radio" name="status" value="I" <%=mcheck%>/>Intrested<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="N" <%=mcheck1%>/>Not Intrested<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="radio" name="status" value="P" <%=mcheck2%> />Pending
<%}%>

</td></tr> <tr>



 <td align="left" nowrap>
 
 <b>Remarks:&nbsp;&nbsp;&nbsp;
 <%qry="SELECT REMARKS FROM TP#REGISTRATIONDETAIL where " +
        "Eventcode='"+event+"' and companycode='"+companycode+"' and INSTITUTECODE='"+mInst+"' " +
        "and STUDENTID='"+mMemberID+"'";
 //out.print(qry);
rs=db.getRowset(qry);
if(!rs.next())
{
 %>

 <input type="text" style="width:260px;" length="160" name="remarks" id="remarks" value=""></b>
 </td>
  </tr>
   <tr>
        <td align="right" colspan="2">
      <!--  <a target="_new" name="CVOpen" id="CVOpen" value="A"  href="UploadFileApp.jsp?Enroll=<%=mMemberID%>"  onClick="openNewWindow()"><B>Attach your C.V  </B></a> -->  <input type="submit" value="Submit"/> 
         </td>
    </tr>

 <%}else{%>
 <input type="text" style="width:260px;" length="160" name="remarks" id="remarks" value="<%=rs.getString("REMARKS")==null?"":rs.getString("REMARKS").trim()%>"/></b>

   <tr>
        <td align="right" colspan="2">
     <!--   <a target="_new" name="CVOpen" id="CVOpen" value="A"  href="UploadFileApp.jsp" onClick="openNewWindow()"><B>Attach your C.V </B></a>  --><input type="submit"   value="Update"/> 
         </td>
    </tr>

 <%}%>








   </table>
   <br>
   </td>
   </tr>
   </table>
<%}}	else{
out.print("<center><font color=red><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;You can not apply because of your batch</font></center>");
}%>

<input type="hidden" name="remarks" id="remarks" value="<%=remarks%>">
<input type="hidden" name="status" id="status" value="<%=status%>">
<input type="hidden" name="companycode" id="companycode" value="<%=companycode%>">
<input type="hidden" name="event" id="event" value="<%=event%>">


<input type="hidden" name="studentid" id="studentid" value="<%=mMemberID%>">

<input type="hidden" name="institutecode" id="institutecode" value="<%=mInst%>">
<input type="hidden" name="semester" id="semester" value="<%=mSemester%>">
<input type="hidden" name="branchcode" id="branchcode" value="<%=mBranchCode%>">
<input type="hidden" name="academicyear" id="academicyear" value="<%=mAcadmeicYear%>">
<input type="hidden" name="programcode" id="programcode" value="<%=mProgram%>">
<input type="hidden" name="membertype" id="membertype" value="<%=mMemberType%>">
<input type="hidden" name="STUDENTNAME" id="STUDENTNAME" value="<%=mMemberName%>">
<input type="hidden" name="enrollmentno" id="enrollmentno" value="<%=mMemberCode%>">
 


<input type="hidden" name="y" id="y">
<%}
    if(request.getParameter("y")!=null){
    //qry="select sysdate from dual";
    //rs=db.getRowset(qry);
    //while(rs.next()){
 //sysdate=rs.getString("sysdate");
   // }
try{
try{

 //PROJECT=request.getParameter("PROJECT")==null?"":request.getParameter("PROJECT").toString().trim();
 // INTERNSHIP=request.getParameter("INTERNSHIP")==null?"":request.getParameter("INTERNSHIP").toString().trim();
  /// WORKEXPERIANCE=request.getParameter("WORKEXPERIANCE")==null?"":request.getParameter("WORKEXPERIANCE").toString().trim();

//out.print("*/*/*/*/*");
mMemberID=request.getParameter("studentid")==null?"":request.getParameter("studentid").toString().trim();

mInst=request.getParameter("institutecode")==null?"":request.getParameter("institutecode").toString().trim();
mSemester=request.getParameter("semester")==null?"":request.getParameter("semester").toString().trim();
mBranchCode=request.getParameter("branchcode")==null?"":request.getParameter("branchcode").toString().trim();
mAcadmeicYear=request.getParameter("academicyear")==null?"":request.getParameter("academicyear").toString().trim();



mMemberType=request.getParameter("membertype")==null?"":request.getParameter("membertype").toString().trim();
mMemberName=request.getParameter("STUDENTNAME")==null?"":request.getParameter("STUDENTNAME").toString().trim();
mMemberCode=request.getParameter("enrollmentno")==null?"":request.getParameter("enrollmentno").toString().trim();

mProgram=request.getParameter("programcode")==null?"":request.getParameter("programcode").toString().trim();


Event=request.getParameter("event")==null?"":request.getParameter("event").toString().trim();
remarks=request.getParameter("remarks")==null?"":request.getParameter("remarks").toString().trim();
status=request.getParameter("status")==null?"":request.getParameter("status").toString().trim();
Companycode=request.getParameter("companycode")==null?"":request.getParameter("companycode").toString().trim();
 


 

}catch(Exception e){
out.print("Error in getting data"+e);
}

qry2="SELECT 'Y' FROM "+table+" " +
        "where EVENTCODE='"+Event+"' and COMPANYCODE='"+Companycode+"' and INSTITUTECODE='"+mInst+"' and ACADEMICYEAR='"+mAcadmeicYear+"' and " +
        "PROGRAMCODE='"+mProgram+"' and SECTIONBRANCH='"+mBranchCode+"' and SEMESTER=to_number('"+mSemester+"') and STUDENTID='"+mMemberID+"'";
//out.print(qry2);
rs1=db.getRowset(qry2);
if(rs1.next()){
qry="UPDATE "+table+" SET STATUS='"+status+"',PROJECT ='"+PROJECT+"',INTERNSHIP ='"+INTERNSHIP+"',WORKEXPERIANCE ='"+WORKEXPERIANCE+"'  ,REMARKS ='"+remarks+"',DATEOFREGISTRATION = sysdate " +
        "WHERE  EVENTCODE ='"+Event+"' AND    COMPANYCODE = '"+Companycode+"'  " +
        " AND INSTITUTECODE ='"+mInst+"'  AND    ACADEMICYEAR = '"+mAcadmeicYear+"'   " +
        " AND PROGRAMCODE = '"+mProgram+"' AND    SECTIONBRANCH  = '"+mBranchCode+"'" +
        " AND    SEMESTER = '"+mSemester+"' AND STUDENTID ='"+mMemberID+"' ";
//out.print(qry);
int t=db.update(qry);


session.setAttribute("value",mMemberID);
if(t>0)
    {
out.print("<table width=100% ><tr width=100% ><td align=center  ><font color=green size=4 > You have been successfully  updated your registration details for this company.  Refresh Page</font></td></tr></table>");}
}
else
{
qry1="INSERT INTO "+table+" (EVENTCODE, COMPANYCODE, INSTITUTECODE, ACADEMICYEAR, PROGRAMCODE, " +
        "SECTIONBRANCH,SEMESTER,STUDENTID, STATUS,REMARKS,PROJECT,INTERNSHIP,WORKEXPERIANCE, DATEOFREGISTRATION, REGISTEREDBY) VALUES " +
        "( '"+Event+"','"+Companycode+"','"+mInst+"','"+mAcadmeicYear+"','"+mProgram+"','"+mBranchCode+"'," +
        "to_number('"+mSemester+"'),'"+mMemberID+"','"+status+"','"+remarks+"','"+PROJECT+"','"+INTERNSHIP+"','"+WORKEXPERIANCE+"',sysdate,'"+mDMemberCode+"')";
 //out.print(qry1);
int l=db.insertRow(qry1);


session.setAttribute("value",mMemberID);
if(l>0)
    {
if(status.equals("I")){
out.print("<table width=100% ><tr width=100% ><td align=center  ><font color=green size=4 >You have been successfully registered for this company  </font></td></tr></table>");
}else if(status.equals("N")){
out.print("<table width=100% ><tr width=100% ><td align=center  ><font color=Red size=4 >You have not registered for this company  </font></td></tr></table>");
}else if(status.equals("P")){
out.print("<table width=100% ><tr width=100% ><td align=center  ><font color=green size=4 >You have not registered for this company your registration is pending.  </font></td></tr></table>");
}
}
}
}






catch(Exception e){
out.print("Error in insert"+e);
}
}

}
catch(Exception e){
out.print("Error in showing company details"+e);
}
%>
</form>
</body>
        </html>