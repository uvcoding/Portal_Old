<%@ page language="java" import="java.sql.*,java.math.*,tietwebkiosk.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="css/style_1.css" type="text/css" media="screen">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JIIT#_ACADEMIC_PEFORMANCE</title>
 
    <script language="javascript" type="text/javascript">
        function closeWindow()
        {
            window.close();
        }
    </script>

</head>
<%
        String mInst = "", mComp = "", mSrcType = "";
        String mInstitute = "";
        ResultSet RsChk = null;
        DBHandler db = new DBHandler();
        String mMemberID = "", mChkMemID = "";
        String mMemberType = "", mChkMType = "";
        String mMemberName = "", mRole = "", mIPAddress = "";
        String mMemberCode = "";
        String mRightsID = "";

        if (session.getAttribute("InstituteCode") == null) {
            mInst = "";
        } else {
            mInst = session.getAttribute("InstituteCode").toString().trim();
        }
        mInstitute = mInst;

        if (session.getAttribute("CompanyCode") == null) {
            mComp = "";
        } else {
            mComp = session.getAttribute("CompanyCode").toString().trim();
        }

        String mLoginComp = "";

        if (session.getAttribute("LoginComp") == null) {
            mLoginComp = "";
        } else {
            mLoginComp = session.getAttribute("LoginComp").toString().trim();
        }

        if (session.getAttribute("MemberID") == null) {
            mMemberID = "";
        } else {
            mMemberID = session.getAttribute("MemberID").toString().trim();
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

        if (session.getAttribute("MemberName") == null) {
            mMemberName = "";
        } else {
            mMemberName = session.getAttribute("MemberName").toString().trim();
        }

        if (session.getAttribute("MemberCode") == null) {
            mMemberCode = "";
        } else {
            mMemberCode = session.getAttribute("MemberCode").toString().trim();
        }
        if (request.getParameter("SrcType") == null) {
            mSrcType = "";
        } else {
            mSrcType = request.getParameter("SrcType").toString().trim();
        }
        if (mSrcType.equals("I")) {
            mRightsID = "83";
        }
        if (mSrcType.equals("A")) {
            mRightsID = "87";
        }
        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }

%>
<body>
    <%   
        //  out.println("nipun"+mMemberID+">>>>>"+mMemberCode+">>>>>"+mMemberName);
        if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
            OLTEncryption enc = new OLTEncryption();
            String mDMemberID = enc.decode(mMemberID);
            String mDMemberCode = enc.decode(mMemberCode);
            String mDMemberType = enc.decode(mMemberType);

            mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
            mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
            mIPAddress = session.getAttribute("IPADD").toString().trim();
            mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
            RsChk = null;

            ResultSet rs1 = null;
            String empType = "";
               
            String query = "select GUESTTYPE from GUEST where GUESTID='" + mChkMemID + "'";

            rs1 = db.getRowset(query);
            if (rs1.next()) {
                empType = rs1.getString(1);
            }

               String qry="select distinct nvl(guesttype,'') guesttype from guest where guestcode='"+mDMemberCode+"'";

                    RsChk = db.getRowset(qry);
                    if(RsChk.next())
                    {
                    empType=RsChk.getString("guesttype")==null?"":RsChk.getString("guesttype").trim();
                    }
//out.print(empType+"<br>");
                    if(empType.equals("T") )
                    {
                    mRole="GUEST";
                    }

              //      out.print(mRole);

             qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            // out.print(qry);

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
    %>

    <div class="menu">
        <ul id="nav">
        <%
        qry = "Select WEBKIOSK.ShowLink('380','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
       %>
        <li><a href="#">MASTER FORM(S)</a>
            <ul>
                <%--


                            <li><a href="Forms/Masters.jsp?menuid=indexingbodymaster">Indexing Body Master</a></li>
                            <li><a href="Forms/Masters.jsp?menuid=feedbackmaster">Feed Back Master</a></li>
                            <li><a href="Forms/Masters.jsp?menuid=feedbackratingmaster">Feed Back Rating Master</a></li>

                --%>
                <%  qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                %>      <li>
                    <a href="#">Common Masters</a>
                    <ul>
                        <%  qry = "Select WEBKIOSK.ShowLink('304','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/FacultyFeedbackMaster.jsp">Faculty Feedback Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('305','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/FacultyQuestionHead.jsp">Faculty Question Head Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('306','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="#">Category Type Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('307','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/Masters.jsp?menuid=categorymaster">Category Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('308','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Forms/Masters.jsp?menuid=calendermaster">Calendar Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('309','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/Masters.jsp?menuid=formmaster">Form Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('310','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Feedback Type Master</a></li>

                        <%}
                    qry = "Select WEBKIOSK.ShowLink('311','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Department Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('312','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Subject Master</a></li>
                    <%}%> </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('314','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Academic(Teaching and Learning)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('315','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/equipmentMaster.jsp">Equipment Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('316','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="#">Resource Master</a></li>
                        <%}
					qry = "Select WEBKIOSK.ShowLink('382','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/lrMaster.jsp">LR Master</a></li>
						<%}
                    qry = "Select WEBKIOSK.ShowLink('317','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="#">Book Master</a></li>
                        <%}%>
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('318','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Academic(Research)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('319','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/Masters.jsp?menuid=publicationmaster">Publication Master</a></li>
                        <%}
					qry = "Select WEBKIOSK.ShowLink('385','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/Masters.jsp?menuid=publicationtypemaster">Publication Type Master</a></li>






                        <%}
					qry = "Select WEBKIOSK.ShowLink('383','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/eventMaster.jsp">Event Master</a></li>
						<%}
					qry = "Select WEBKIOSK.ShowLink('384','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/indexingBodyMaster.jsp">Indexing Body Master</a></li>
						<%}
                    qry = "Select WEBKIOSK.ShowLink('322','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Patent Master</a></li>

                        <%} qry = "Select WEBKIOSK.ShowLink('323','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><li><a href="#">Award & Achievement</a></li></li>

                        <%}
                    qry = "Select WEBKIOSK.ShowLink('324','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="#">Interdisciplinary Master</a></li>
                        <%}%>
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('325','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {


                %>
                <li><a href="#">Stakeholder Relationship</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('326','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Parent Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('327','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="#">Alumini Master</a></li><%}%>
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('328','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Professional and Social Activities</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('329','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Process Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('330','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Workshop Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('331','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Conference Master</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('332','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Activity Master</a></li><%}%>
                    </ul>
                </li>
                <%}%>
            </ul>
        </li>
        <%}
            qry = "Select WEBKIOSK.ShowLink('333','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
    //    out.print(qry);
            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>

        <li><a href="#">TRANSACTION FORM(S)</a>
            <ul>
                <%--<li><a href="Forms/Masters.jsp?menuid=formtransaction">Form Detail/Transection</a></li>
                           <li><a href="Forms/Masters.jsp?menuid=feedbackheader">FeedBack Header</a></li>
                <li><a href="Forms/Masters.jsp?menuid=feedbacktransaction">FeedBack Transaction</a></li>--%>
                <%qry = "Select WEBKIOSK.ShowLink('334','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="#">Academic(Teaching and Learning)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('335','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                      RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="Forms/FacultyFeedBackTransaction.jsp">Faculty Feedback Transaction</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('336','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/equipmentTransaction.jsp">Department Feedback On Use Of Equipments</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('337','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>   <li><a href="Forms/learningResourceTransaction.jsp">Department Feedback On Learning Resources</a></li>
                        <%}%>
                    </ul>
                </li> <%}
            qry = "Select WEBKIOSK.ShowLink('339','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Academic(Research)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('340','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>    <li><a href="Forms/publicationTransaction.jsp">Publication Transaction(Summary)Details</a></li>
                        <%}
                     qry = "Select WEBKIOSK.ShowLink('320','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/projectMaster.jsp">Sponsored R&D Project</a></li>
                        <%}
					qry = "Select WEBKIOSK.ShowLink('321','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/projectMasterMasterPhd.jsp">Master And Ph.D Degrees</a></li>
					<%}
					qry = "Select WEBKIOSK.ShowLink('379','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/projectMasterBtech.jsp">Project Master-Master/B.Tech</a></li>
					<%}
                    qry = "Select WEBKIOSK.ShowLink('342','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="Forms/patentTransaction.jsp">Patent Registered By Faculty/Students</a></li>
                        <%}
					qry = "Select WEBKIOSK.ShowLink('338','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>    <li><a href="Forms/bookTransaction.jsp">Summary Of Review Articles And Books In Developing Areas</a></li><%}
                    qry = "Select WEBKIOSK.ShowLink('343','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Forms/awardAndAchievement.jsp">Award & Achievement</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('344','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Forms/interdisciplinary.jsp">Interdisciplinary Research</a></li><%}%>
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('345','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Stakeholder Relationship</a>
                    <ul>

                        <%
                    qry = "Select WEBKIOSK.ShowLink('346','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {
                        if (!empType.equals("") && empType.equals("TEC")) {

                        %>
                        <li><a href="Forms/sFacultyFeedbackTransaction.jsp">STK-Faculty Feedback Transaction</a></li>
                        <%}
                    }


                   /* qry = "Select WEBKIOSK.ShowLink('347','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {*/
                        if (empType.equals("NTEC")) {
                          %>
                        <li><a href="Forms/nonTeachingFeedback.jsp">Non Teaching Feedback Transaction</a></li>
                       <%}
                   // }
                    qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {

                        if (!empType.equals("NTEC") || empType.equals("NTEC")) {
                        %>

                        <!--  <li><a href="Forms/StudentEnrollnDOBValidation.jsp">Parent Feedback Transaction</a></li> -->

                        <%          }

                    }
                    qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><!--a href="Forms/trusteeFeedbackTransaction.jsp">Trustee Feedback Transaction</a></li-->
                        <!-- <li><a href="#">Parent Transaction</a></li> -->
                            <%}%>

                        <!--        <li><a href="#">Alumini</a></li> -->
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('348','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Professional and Social Activities</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('349','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Forms/workshopTransaction.jsp">Performa for approval of VC for Workshop/SC/GL/FDP</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('350','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Forms/workShopFeedback.jsp">Workshop/SC/GL/FDP Feedback Form</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('351','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Forms/industrialInteractions.jsp">Industrial Interactions Details</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('352','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Forms/industrialInteractionsFeedback.jsp">Industrial Interactions Feedback Form</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('353','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <%--    <li><a href="#">Process Transaction</a></li>--%>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('354','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>      <li><a href="Forms/conferenceTransaction.jsp">Performa For Approval Of Conference Details</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('381','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                    //out.print(qry);
                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>      <li><a href="Forms/budgetOfConferenceDetails.jsp">Budget Of Conference Details</a></li>
					<%}
					qry = "Select WEBKIOSK.ShowLink('386','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                    //out.print(qry);
                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>      <li><a href="Forms/feedbackOfConference.jsp">Feedback Of Conference</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('355','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>   <%-- <li><a href="#">Activity Transaction</a></li>--%><%}%>
                    </ul>
                </li>
                <%}%>
                <%
            qry = "Select WEBKIOSK.ShowLink('413','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">IT Services</a>
                    <ul>
                        <%
                   
                    
                   
                    qry = "Select WEBKIOSK.ShowLink('413','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>   <li><a href="Forms/ITServices.jsp">Feedback-IT Services</a></li><%}%>
                    </ul>
                </li>
                <%} 
            qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Student Activity & Placement</a>
                    <ul>
                        <%



                    qry = "Select WEBKIOSK.ShowLink('302','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                     <li><a href="Forms/PlacementForm.jsp">PlacementForm</a></li>
                     <li><a href="Forms/HubActivities.jsp">Hub Activities Form</a></li>
                    <li><a href="Forms/SocialActivityRelevance.jsp">SocialActivity & Relevence</a></li>
                    <li><a href="Forms/AwardAndAchivementt.jsp">Award & Achievement</a></li>


                    <%}%>
                    </ul>
                </li>
                <%}%>

            </ul>
        </li>
        <%}
            qry = "Select WEBKIOSK.ShowLink('356','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
        <li><a href="#">REPORT(S)</a>
            <ul>
                <%qry = "Select WEBKIOSK.ShowLink('357','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>   <li><a href="#">Academic(Teaching and Learning)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('358','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/FacultyFeedbackReport.jsp">Faculty FeedBack Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('359','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>    <li><a href="#">Equipment Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('360','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Resource Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('361','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="#">Book Report</a></li>

                <%
            qry= "Select WEBKIOSK.ShowLink('391','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            RsChk = db.getRowset(qry);

             if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
              <li><a href="Reports/FacultyFeedBackCount.jsp">FacultyFeedBackCount</a></li><%}%>
               <%}}%>
  
<%
            qry= "Select WEBKIOSK.ShowLink('391','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
            RsChk = db.getRowset(qry);

             if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
              <li>

                <%  if(mDMemberCode.equals("JIIT1188")||mDMemberCode.equals("JIIT1498")||mDMemberCode.equals("JIIT1458")||mDMemberCode.equals("JIIT1492")||mDMemberCode.equals("JIIT1390")) { %>

                  <a href="Reports/FacultyFeedbackSummary.jsp">FacultyFeedBackSummary</a>



                  <%}%> 

                  </li><%}%>


                </li> </ul><%}
            qry = "Select WEBKIOSK.ShowLink('362','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Academic(Research)</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('363','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/PublicationReport.jsp">Publication Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('363','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/patentTransactionReport.jsp">Patent Report</a></li>
                        <%}qry = "Select WEBKIOSK.ShowLink('363','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/bTechMajorProjectsReport.jsp">B.Tech Major Project Report</a></li>
                        <%}

                    qry = "Select WEBKIOSK.ShowLink('364','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/ProjectReport.jsp">Sponsored R&D Project Report</a></li>
                        <%}

                    qry = "Select WEBKIOSK.ShowLink('366','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/AwardandAchievmentReport.jsp">Award & Achievement</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('367','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/InterdisReport.jsp">Interdisciplinary</a></li><%
                    }
                    qry = "Select WEBKIOSK.ShowLink('367','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/MasterandPhD.jsp">Master and Ph.D. Degrees</a></li><%
                    }qry = "Select WEBKIOSK.ShowLink('367','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/BookReport.jsp">Summary of Review articles and Books</a></li><%
                    }%>
                    </ul>
                </li>
                <%}
            qry = "Select WEBKIOSK.ShowLink('368','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">Stakeholder Relationship</a>
                    <ul>
                        <%
//out.print(mChkMemID);
                      if(mChkMemID.equals("UNIV-M00026")||empType.equals("NTEC"))
                        {
                      %>
                    <li><a href="Reports/NonTechingStaffFeedback.jsp">Non-Teching Staff Feedback Report </a></li>
                    <li><a href="Reports/FacultyFeedbackTransReport.jsp">Faculty Feedback Transaction Report </a></li>
                    <li><a href="Reports/ShFacultyFeedbackReport.jsp">Consolidated Faculty Feedback Transaction Report </a></li>

                   <%
                      }



                    qry = "Select WEBKIOSK.ShowLink('372','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/ParentReport.jsp">Parent Report</a></li>
                        <%}qry = "Select WEBKIOSK.ShowLink('365','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                    <li><a href="Reports/ParentfeedbackBranchwiseReport.jsp">Parent Report Branchwise </a></li>
                    <li><a href="Reports/AlumnifeedbackReport.jsp">Alumni Report Branchwise </a></li>
                         <%}
                    qry = "Select WEBKIOSK.ShowLink('373','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="#">Alumini</a></li><%}%>


                  <%
            qry = "Select WEBKIOSK.ShowLink('374','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>

              </ul> </li> <li><a href="#">Professional and Social Activities</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('375','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/WorkshopReport.jsp">Workshop Detail Report</a></li>
                        <%}qry = "Select WEBKIOSK.ShowLink('369','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>  <li><a href="Reports/WorkshopFeedbackReport.jsp">Workshop Feedback Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('376','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <%--<li><a href="#">Process Report</a></li>--%>

                        <%}
                    qry = "Select WEBKIOSK.ShowLink('377','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/ConfernceApproval.jsp">Conference Approval Report</a></li>
                        <%}
                      qry = "Select WEBKIOSK.ShowLink('377','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/BudgetSheetReport.jsp">Conference Budget Sheet Report</a></li>
                        <%}
                      qry = "Select WEBKIOSK.ShowLink('377','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%><li><a href="Reports/Feedback_Conference.jsp">Conference Feedback Report</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('370','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/IndustrialInteractionReport.jsp">Industrial Interactions</a></li>
                        <%}
                    qry = "Select WEBKIOSK.ShowLink('371','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <li><a href="Reports/IndustrialInteractionsFeedbackReport.jsp">Industrial Interaction Feedbacks</a></li>

                        <%}
                    qry = "Select WEBKIOSK.ShowLink('378','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%> <%--<li><a href="#">Activity Report</a></li>--%><%}%>
                    </ul>
                </li>
                <%}
qry = "Select WEBKIOSK.ShowLink('413','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

            RsChk = db.getRowset(qry);
            if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                <li><a href="#">ITServices</a>
                    <ul>
                        <%qry = "Select WEBKIOSK.ShowLink('413','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";

                    RsChk = db.getRowset(qry);
                    if (RsChk.next() && RsChk.getString("SL").equals("Y")) {%>
                        <li><a href="Reports/ITServicesReport.jsp">Feedback-IT Services Summary</a></li>
                        <%}
	       
                     %>
                    </ul>
                </li>
                <%}
%>



            </ul>
        </li>
        <%}%>

        <li> <a onclick="closeWindow()" tittle='Close Tab/Window'  ><u>CLOSE</u></a> </li>

    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="menu"  style="position: fixed; width: 1390px">
        <ul id="nav">
        <li>  <a href="http://www.jilit.co.in" target="_new"><IMG SRC="CampusLynx.png" WIDTH="50" HEIGHT="50" BORDER="0" ALT="">&nbsp;&nbsp;Designed and Developed by JIL-INFORMATION TECHNOLOGY LTD.</a> </ul>
    </div>
    </li>
    <%} else {
    %>
    <br>
    <font color=red>
        <h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
        <br>For assistance, contact your network support team.
    </font>	<br>	<br>	<br>	<br>
    <%            }

        } else {
            %><br><img src='../../Images/Error1.jpg'>
          <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>
              <%
        }
    %>
</body>

</html>

