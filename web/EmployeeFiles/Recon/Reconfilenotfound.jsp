<%-- 
    Document   : Reconfilenotfound
    Created on : 25 Mar, 2017, 11:30:55 AM
    Author     : VIVEK.SONI
--%>


<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page isELIgnored="false" errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@ taglib prefix="ntb" uri="http://www.nitobi.com"%>

<html>
<%


String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead=" ";
session.setAttribute("CurrEvent","");
session.setAttribute("PrevEvent","");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");

%>



<head>


<TITLE>#### <%=mHead%> [ Event-Wise Marks Entry ] </TITLE>


<script language="JavaScript" type ="text/javascript">
<!--
  if (top != self) top.document.title = document.title;
-->

if(window.history.forward(1) != null)
window.history.forward(1);

</script>
<style type="text/css">
<!--

input-wrapper input[type=text] {
    width:100%;
    padding: 10px;
    margin: 0px;
}

table .last, td:last-child {
    padding: 2px 24px 2px 0px;
}

-->
</style>


</script>



</head>

<body  aLink=#ff00ff bgcolor=#fce9c5 rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 >

<%
GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="",markslocked="",selectedExam="",selectedEvent="",selectedEmp="",selectedInst="",selectedSub="",selectedDBEvent="",selectedname="",selectedcode="",SelectedText="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mExam="",mexam="",mExamid="",mEventsubevent="",mSubj="";
String qry="",qry1="",x="",msubsection="",mPrint="",facqry="";
int msno=0;
int len =0;
int pos=0;
String mSE="", mMaxMarks="";
double mWeight=0;
double mvalue=0,mMaxmarks=0,MyMax=0;
int ctr=0,flag=0;
String mStatus="";
String mIC="",mEC="",mSC="",mList="",mOrder="",mEvent="",mPrevEvent=""; //,mExamsubevent="",mExamevent="";
ResultSet rs=null,rss=null,rs1=null,rs2=null,rs3=null,rse=null,rsm=null,rsmm=null,facrse=null;
String mMOP="",mName5="",mlistorder="",mctr="",qrys="",mSelf="";
String msubeven="",mMarks="",mPerc="",mName1="",mMark="",mName2="",mName3="",msms="",mverified="", DEvent="";
String mEventsubevent1="",mSubj1="",msubj="",fromemp="";
session.setMaxInactiveInterval(10800);
session.setAttribute("Click",mSelf);



 if(session.getAttribute("isemp")==null)
			fromemp="";
		else
                    fromemp=session.getAttribute("isemp").toString();
if (session.getAttribute("Designation")==null)
	mDesg="";
else
	mDesg=session.getAttribute("Designation").toString().trim();
if (session.getAttribute("Department")==null)
	mDept="";
else
	mDept=session.getAttribute("Department").toString().trim();
if (session.getAttribute("MemberID")==null)
	mMemberID="";
else
	mMemberID=session.getAttribute("MemberID").toString().trim();
if (session.getAttribute("MemberType")==null)
	mMemberType="";
else
	mMemberType=session.getAttribute("MemberType").toString().trim();
if (session.getAttribute("MemberName")==null)
	mMemberName="";
else
	mMemberName=session.getAttribute("MemberName").toString().trim();
if (session.getAttribute("MemberCode")==null)
	mMemberCode="";
else
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
if (session.getAttribute("InstituteCode")==null)
	mInst="";
else
	mInst=session.getAttribute("InstituteCode").toString().trim();
if (session.getAttribute("CompanyCode")==null)
	mComp="";
else
	mComp=session.getAttribute("CompanyCode").toString().trim();
try
{
        OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals(""))
	{
            mDMemberCode=enc.decode(mMemberCode);
            mDMemberType=enc.decode(mMemberType);
            mDMemberID=enc.decode(mMemberID);
            String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
            String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
            String mIPAddress =session.getAttribute("IPADD").toString().trim();
            String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
            ResultSet RsChk1=null;

            selectedExam=request.getParameter("Exam");
            selectedEvent=request.getParameter("selectedEventCode");
            selectedEmp=request.getParameter("Emp");
            selectedInst=request.getParameter("Inst");
            selectedSub=request.getParameter("Subject");
            selectedDBEvent=request.getParameter("DBEventCode");
          // SelectedText=request.getParameter("textval");


	  //-----------------------------
	  //-- Enable Security Page Level
	  //-----------------------------

            qry="Select WEBKIOSK.ShowLink('400','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
            RsChk1= db.getRowset(qry);
            if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
            {
             String Thired="update MR#RECONCILEDDETAIL SET reconciled ='V',reconcileddate=sysdate,reconciledby='"+mDMemberCode+"' where  Institutecode='"+selectedInst+"' and examcode='"+selectedExam+"' and subjectid='"+selectedSub+"'" +
                          " and employeeid='"+selectedEmp+"' and eventsubevent='"+selectedDBEvent+"' and foreventsubevent='"+selectedEvent+"' ";
              int isupda=db.update(Thired);


     if(isupda>0){
     out.println("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Blue'> Record Verified Successfully............ </font> <br>");
     }else{

      out.println("&nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Blue'> Please Try again Later.............. </font> <br>");
     }


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
//catch(org.json.JSONException e)
catch(Exception e)
{
    //System.out.println(e);
}
%>
</body>
</html>
