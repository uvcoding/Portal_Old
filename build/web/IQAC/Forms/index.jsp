<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="css/style_1.css" type="text/css" media="screen">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JIIT#_ACADEMIC_PEFORMANCE</title>
        
        <script language="javascript" type="text/javascript">
 
            function closeWindow() {
                window.close();
            }
        </script>
       
    </head>
    <body>
      
            <div class="menu">
                <ul id="nav">

                    <li><a href="#">MASTER FORM(S)</a>
                        <ul>
                           <%-- 
                            
                            
                            <li><a href="Forms/Masters.jsp?menuid=indexingbodymaster">Indexing Body Master</a></li>
                            <li><a href="Forms/Masters.jsp?menuid=feedbackmaster">Feed Back Master</a></li>
                            <li><a href="Forms/Masters.jsp?menuid=feedbackratingmaster">Feed Back Rating Master</a></li>
                           
                            --%>
                           <li><a href="#">Common Masters</a>
                                     <ul>
                                         <li><a href="#">Category Type Master</a></li>
   <li><a href="Forms/Masters.jsp?menuid=categorymaster">Category Master</a></li>
   <li><a href="Forms/Masters.jsp?menuid=calendermaster">Calendar Master</a></li>
       <li><a href="Forms/Masters.jsp?menuid=formmaster">Form Master</a></li>
                                         <li><a href="#">Feedback Type Master</a></li>
           <li><a href="Forms/FacultyFeedbackMaster.jsp">Faculty Feedback Master</a></li>
             <li><a href="Forms/FacultyQuestionHead.jsp">Faculty Question Head Master</a></li>
                                         <li><a href="#">Department Master</a></li>
                                         <li><a href="#">Subject Master</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Academic(Teaching and Learning)</a>
                                    <ul>
  <li><a href="Forms/Masters.jsp?menuid=equipmentmaster">Equipment Master</a></li>
                                         <li><a href="#">Resource Master</a></li>
                                         <li><a href="#">Book Master</a></li>
                                     </ul>
                           
                           </li>
                           <li><a href="#">Academic(Research)</a>
                                     <ul>
<li><a href="Forms/Masters.jsp?menuid=publicationmaster">Publication Master</a></li>
                                         <li><a href="#">Project Master</a></li>
                                         <li><a href="#">Patent Master</a></li>
                                         <li><a href="#">Award & Achievement</a></li>
                                         <li><a href="#">Interdisciplinary Master</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Stakeholder Relationship</a>
                                     <ul>
                                         <li><a href="#">Parent Master</a></li>
                                         <li><a href="#">Alumini Master</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Professional and Social Activities</a>
                                     <ul>
                                         <li><a href="#">Process Master</a></li>
                                         <li><a href="#">Workshop Master</a></li>
                                         <li><a href="#">Conference Master</a></li>
                                         <li><a href="#">Activity Master</a></li>
                                     </ul>
                           </li>
                           
                        </ul>
                    </li>
                    <li><a href="#">TRANSACTION FORM(S)</a>
                        <ul>
                            <%--<li><a href="Forms/Masters.jsp?menuid=formtransaction">Form Detail/Transection</a></li>
                           <li><a href="Forms/Masters.jsp?menuid=feedbackheader">FeedBack Header</a></li>
                           <li><a href="Forms/Masters.jsp?menuid=feedbacktransaction">FeedBack Transaction</a></li>--%>
                           <li><a href="#">Academic(Teaching and Learning)</a>
                                     <ul>
                                         <li><a href="Forms/FacultyFeedBackTransaction.jsp">Feedback Transaction</a></li>
                                         <li><a href="#">Equipment Transaction</a></li>
                                         <li><a href="#">Resource Transaction</a></li>
                                         <li><a href="#">Book Transaction</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Academic(Research)</a>
                                     <ul>
                                         <li><a href="#">Publication Transaction</a></li>
                                         <li><a href="#">Project Transaction</a></li>
                                         <li><a href="#">Patent Transaction</a></li>
                                         <li><a href="#">Award & Achievement</a></li>
                                         <li><a href="#">Interdisciplinary</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Stakeholder Relationship</a>
                                     <ul>
                                         <li><a href="#">Feedback Transaction</a></li>
                                         <li><a href="#">Parent Transaction</a></li>
                                         <li><a href="#">Alumini</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Professional and Social Activities</a>
                                     <ul>
                                         <li><a href="#">Process Transaction</a></li>
            <li><a href="Forms/workshopTransaction.jsp">Workshop Transaction</a></li>
               <li><a href="Forms/workShopFeedback.jsp">Workshop Feedback</a></li>
         <li><a href="Forms/industrialInteractions.jsp">Industrial Interactions</a></li>
                                         <li><a href="#">Conference Transaction</a></li>
                                         <li><a href="#">Activity Transaction</a></li>
                                     </ul>
                           </li>

                                
                        </ul>
                    </li>
                    <li><a href="#">REPORT(S)</a>
                        <ul>
                           <li><a href="#">Academic(Teaching and Learning)</a>
                                    <ul>
                                         <li><a href="#">Feedback Report</a></li>
                                         <li><a href="#">Equipment Report</a></li>
                                         <li><a href="#">Resource Report</a></li>
                                         <li><a href="#">Book Report</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Academic(Research)</a>
                                     <ul>
                                         <li><a href="#">Publication Report</a></li>
                                         <li><a href="#">Project Transaction</a></li>
                                         <li><a href="#">Patent Report</a></li>
                                         <li><a href="#">Award & Achievement</a></li>
                                         <li><a href="#">Interdisciplinary</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Stakeholder Relationship</a>
                                     <ul>
                                         <li><a href="#">Feedback Report</a></li>
                                         <li><a href="#">Parent Report</a></li>
                                         <li><a href="#">Alumini</a></li>
                                     </ul>
                           </li>
                           <li><a href="#">Professional and Social Activities</a>
                                     <ul>
                                         <li><a href="#">Process Report</a></li>
                                         <li><a href="#">Workshop Report</a></li>
                                         <li><a href="#">Conference Report</a></li>
                                         <li><a href="#">Activity Report</a></li>
                                     </ul>
                           </li>
                        </ul> 
                    </li>
                    <li> <a onclick="closeWindow()" tittle='Close Tab/Window'  ><u>CLOSE</u></a> </li>
            </div>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="menu"  style="position: fixed; width: 1390px">
        <ul id="nav">
            <li>  <a href="http://www.jilit.co.in" target="_new"><IMG SRC="CampusLynx.png" WIDTH="50" HEIGHT="50" BORDER="0" ALT="">&nbsp;&nbsp;Designed and Developed by JIL-INFORMATION TECHNOLOGY LTD.</a> </ul>  
    </div>
</li>
</body>
</html>

