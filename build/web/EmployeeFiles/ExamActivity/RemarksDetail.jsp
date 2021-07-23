<%-- 
    Document   : RemarksDetail
    Created on : Jun 10, 2009, 3:03:27 PM
    Author     : S.Saurabh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd"><%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.*,java.io.*,lotus.domino.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%
        String qry = "", mWebEmail = "";
        DBHandler db = new DBHandler();
        OLTEncryption enc = new OLTEncryption();
        GlobalFunctions gb = new GlobalFunctions();
        ResultSet rs = null, rs1 = null;
        String mMemberID = "", mMemberType = "", mMemberCode = "", mCurDate = "";
        String mEmpName = "", mWorkDt = "", mCompCode = "", mInst = "", mEID = "";
        String LoginIDTime = "", mDeptCode = "", mRightsID = "223", mSRCType = "";
        String mRecipient = "", mFromDatabase = "", mRecipientId = "", recipientid = "";
        String mAcademicYear = "", mProgram = "", mBranch = "", mSectd = "", mailType = "", mSubject = "";
        String mDateFrom = "", mDateTo = "";
        String mSender = "", mStdName = "", mRemarks = "", mTransId = "";

        int sn = 0;
        try {
            if (session.getAttribute("MemberCode") == null) {
                mMemberCode = "";
            } else {
                mMemberCode = session.getAttribute("MemberCode").toString().trim();
            }
            if (session.getAttribute("CompanyCode") == null) {
                mCompCode = "";
            } else {
                mCompCode = session.getAttribute("CompanyCode").toString().trim();
            }

            if (session.getAttribute("MemberID") == null) {
                mMemberID = "";
            } else {
                mMemberID = session.getAttribute("MemberID").toString().trim();
            }

            if (session.getAttribute("MemberType") == null) {
                mMemberType = "";
            } else {
                mMemberType = session.getAttribute("MemberType").toString().trim();
            }
            if (request.getParameter("message") == null) {
                mTransId = "";
            } else {
                mTransId = request.getParameter("message").toString().trim();
            }
//out.print(mRemarks);
            String mHead = "";
            if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
                mHead = session.getAttribute("PageHeading").toString().trim();
            } else {
                mHead = "JIIT ";
            }
%>
<HTML>
    <head>
        <TITLE>#### <%=mHead%> [ Employee Lists] </TITLE>
        <script language="JavaScript" type ="text/javascript" src="js/datetimepicker.js"></script>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
    </head>
    <body  topmargin=4 rightmargin=0 leftmargin=0 bottommargin=0 bgColor="#fce9c5">
        <%
    if (!mMemberID.equals("") || !mMemberCode.equals("")) {
        mMemberID = enc.decode(mMemberID);
        mMemberCode = enc.decode(mMemberCode);

        String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
        String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
        String mIPAddress = session.getAttribute("IPADD").toString().trim();
        String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
        ResultSet RsChk = null;


        //-----------------------------
        //-- Enable Security Page Level
        //-----------------------------
        qry = "Select WEBKIOSK.ShowLink('246','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
        RsChk = db.getRowset(qry);
        if (RsChk.next() && RsChk.getString("SL").equals("Y")) {


            try {

        %>
        <table id=id1 width="100%" ALIGN=CENTER bottommargin=0  topmargin=0>
            <tr><TD align=middle><font color="#a52a2a" style="FONT-SIZE: medium; FONT-FAMILY: fantasy"><b><u>View Remarks Detail</u></B></font></TD>
            </font></td></tr>
        </TABLE>
        <br>
        <table cellspacing=4 cellpadding=4 align=center border=1>
            <tr>
                <%
            qry = "SELECT NVL(APPROVALREQUESTREMARKS,' ')APPROVALREQUESTREMARKS FROM UPDREQ#STUDENTWISEGRADE WHERE TRANSID='" + mTransId + "'";
            rs = db.getRowset(qry);
            if (rs.next()) {
                %>
        <td nowrap><font color=black face=arial size=2><%=rs.getString("APPROVALREQUESTREMARKS")%></font></td></tr></table>
        <%
                    }
                //-----------------------------
                //-- Enable Security Page Level
                //-----------------------------


                } catch (Exception e) {
                    out.print(e);
                }

            } else {
        %>
        <br>
        <font color=red>
            <h3>	<br><img src='.../Images/Error1.jpg'>Access Denied (authentication_failed) </h3><br>
            <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team.
        </font>	<br>	<br>	<br>	<br>
        <%                }
            //-----------------------------
            } else {
                out.print("<br><img src='../../Images/Error1.jpg'>");
                out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Verdana' color='Red'> Session Timeout Please <a href='../index.jsp' target=_New>Login</a> to continue</font> <br>");
            }
        }//end of try
        catch (Exception e) {
            //	out.println(e.getMessage());
        }

        %>
        <%-- <center>
    <table ALIGN=Center VALIGN=TOP>
    <tr>
    <td valign=middle>
    <IMG style="WIDTH: 28px; HEIGHT: 28px" src="../../Images/CampusConnectLogo.bmp">
    <FONT size =4 style="FONT-FAMILY: cursive"><b>Campus Connect</b></FONT>&nbsp;&nbsp;&nbsp;<FONT size =2 style="FONT-FAMILY: cursive">... an <b>IRP</b> Solution</FONT><br>
    A product of <STRONG>JIL Information Technology Ltd.</STRONG></FONT><br>
        <FONT size =2>For your comments or suggestions please send an email at <A tabIndex=8 href='mailto:<%=mWebEmail%>'><%=mWebEmail%></A></FONT> 		</td></tr></table> --%>
    </body>
</Html>


