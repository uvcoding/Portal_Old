<%@ page language="java" import="java.sql.*,tietwebkiosk.*,eba.gethandler.*"%>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp" %>

<!--
Date 10.04.2019
-->
<%
        String marksArray[]=null;
        DBHandler db = new DBHandler();
        ResultSet rs = null, rs1=null, rs2=null,rs3=null,rsd=null;
        String qry="", qry1="",qry2="", mMOP="M", mMemberID="", mMemberType="", mDMemberID="", mDMemberType="E";
        String mComp="", mSelf="", mIC="", mEC="", mSC="", mList="", mOrder="", mEvent="", mSE="";
        int len=0, pos=0, ctr=0, qryCtr=0, counter=0;
		String mDebar="",mMedical="",mAbsent="",mUFM="",Color="",UFMMARKS="",deactive="";
		double Sum=0.0;
		String SumTotal="",PRORATA="",qryd="",PRORATA1="",PRORATA2="",PRORATA3="",PRORATA4="",UFMMARKS3="",UFMMARKS2="",UFMMARKS1="";

						String MEDICAL1="",MEDICAL2="",MEDICAL3="";
						String ABSENTCASE1="",ABSENTCASE2="",ABSENTCASE3="";

String _marks_Of_Test=(String)session.getAttribute("test_marks");
//System.out.println(_marks_Of_Test);
if(_marks_Of_Test!=null && !_marks_Of_Test.equals("")){
marksArray=_marks_Of_Test.split(",");
}
int counter_marks_array=1;

try
{

        if (session.getAttribute("MemberID")==null)
            mMemberID="";
        else
            mMemberID=session.getAttribute("MemberID").toString().trim();
        if (session.getAttribute("MemberType")==null)
            mMemberType="";
        else
            mMemberType=session.getAttribute("MemberType").toString().trim();
        if (session.getAttribute("CompanyCode")==null)
            mComp="";
        else
            mComp=session.getAttribute("CompanyCode").toString().trim();


/*
        if(request.getAttribute("Click")!=null)
            mSelf=(String)request.getAttribute("Click");
        else
            mSelf="";
        if(request.getAttribute("InstCode")!=null)
            mIC=(String)request.getAttribute("InstCode");
        else
            mIC="";
        if(request.getAttribute("Exam")!=null)
            mEC=(String)request.getAttribute("Exam");
        else
            mEC="";
        if(request.getAttribute("Subject")!=null)
            mSC=(String)request.getAttribute("Subject");
        else
            mSC="";
        if(request.getAttribute("listorder")!=null)
            mList=(String)request.getAttribute("listorder");
        else
            mList="";
        if(request.getAttribute("order")!=null)
            mOrder=(String)request.getAttribute("order");
        else
            mOrder="";
        if(request.getAttribute("Event")!=null)
            mEvent=(String)request.getAttribute("Event");
        else
            mEvent="";
 */
/*
        if(request.getParameter("Click")!=null)
            mSelf=request.getParameter("Click");
        else
            mSelf="";
        if(request.getParameter("InstCode")!=null)
            mIC=request.getParameter("InstCode");
        else
            mIC="";
        if(request.getParameter("Exam")!=null)
            mEC=request.getParameter("Exam");
        else
            mEC="";
        if(request.getParameter("Subject")!=null)
            mSC=request.getParameter("Subject");
        else
            mSC="";
        if(request.getParameter("listorder")!=null)
            mList=request.getParameter("listorder");
        else
            mList="EnrollNo";
        if(request.getParameter("order")!=null)
            mOrder=request.getParameter("order");
        else
            mOrder="";
        if(request.getParameter("Event")!=null)
            mEvent=request.getParameter("Event");
        else
            mEvent="";
*/
        if(session.getAttribute("Click")!=null)
            mSelf=session.getAttribute("Click").toString().trim();
        else
            mSelf="";
        if(session.getAttribute("InstCode")!=null)
            mIC=session.getAttribute("InstCode").toString().trim();
        else
            mIC="";
        if(session.getAttribute("Exam")!=null)
            mEC=session.getAttribute("Exam").toString().trim();
        else
            mEC="";
        if(session.getAttribute("Subject")!=null)
            mSC=session.getAttribute("Subject").toString().trim();
        else
            mSC="";
        if(session.getAttribute("listorder")!=null)
            mList=session.getAttribute("listorder").toString().trim();
        else
            mList="EnrollNo";
        if(session.getAttribute("order")!=null)
            mOrder=session.getAttribute("order").toString().trim();
        else
            mOrder="";
        if(session.getAttribute("Event")!=null)
            mEvent=session.getAttribute("Event").toString().trim();
        else
            mEvent="";

        len=mEvent.length();
        pos=mEvent.indexOf("#");
        if(pos>0)
        {
           mSE=mEvent.substring(0,pos);
        }
        else
        {
            mSE=mEvent.toString().trim();
        }
	OLTEncryption enc=new OLTEncryption();
	mDMemberID=enc.decode(mMemberID);
	mDMemberType=enc.decode(mMemberType);
        //System.out.println("Self/Other:- "+mSelf+" Inst:- "+mIC+" Exam:- "+mEC+" Subject:- "+mSC+" List:- "+mList+" Order:- "+mOrder+" EventSubEvent:- "+mEvent+" Event:- "+mSE);
        if(mSelf.equals("Self") && qryCtr==0)
	{
                qryCtr++;


		qry2="SELECT  'Y' from V#StudentEventSubjectMarks ";
                qry2=qry2+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' ";
//                qry2=qry2+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N'  ";
                qry2=qry2+" and examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                qry2=qry2+" AND EMPLOYEEID='"+mDMemberID+"'  AND EVENTSUBEVENT='"+mEvent+"' ";
//System.out.print("JILIT - "+qry2);
			rs2=db.getRowset(qry2);
			if(rs2.next())
		{
          // out.print ("step 1");
				/*qry="select fstid,NVL(DEACTIVE,'N') DEACTIVE,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+ " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"'";
               // and nvl(DEACTIVE,'N')='N'
                        qry=qry+"   and nvl(locked,'N')='N'  and  nvl(STUDENTLTPDEACTIVE,'N')='N' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   ) and ";
		qry=qry+" examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		//qry=qry+" AND employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND (EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) ";
		//qry=qry+" AND employeeid in (Select '"+mDMemberID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND EVENTSUBEVENT='"+mEvent+"'  and ( (studentid,fstid) in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='"+mEvent+"'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	) OR  (studentid,fstid) NOT in (select  studentid,fstid from StudentEventSubjectMarks  where EVENTSUBEVENT='"+mEvent+"'  and nvl(DEACTIVE,'N')='N' and nvl(locked,'N')='N'	)  )" ;
		//qry=qry+"  and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and ltp IN ( decode((select APPLICABLEFOR from  exameventmaster where examcode = '"+mEC+"' AND EXAMEVENTCODE = '"+mSE+"' and institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )   GROUP BY fstid,DEACTIVE,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";*/

                qry="select a.fstid,NVL(a.DEACTIVE,'N') DEACTIVE,nvl(a.studentid,' ')studentid,nvl(a.studentname,' ')StudentName, nvl(a.enrollmentno,' ')EnrollNo, nvl(a.semester,0)Semester,";
		qry=qry+ " nvl(a.programcode,' ')||' ('||nvl(a.SECTIONBRANCH,' ')||' - '||a.subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING a ";
		qry=qry+" where a.institutecode='"+mIC+"'";
               // and nvl(DEACTIVE,'N')='N'
                        qry=qry+"   and nvl(a.locked,'N')='N' AND ((NVL (a.deactive, 'N') = 'N')  or     (a.studentid in (select x.studentid from studenteventsubjectmarks x where x.fstid = a.fstid and nvl(x.deactive,'N') = 'N')) ) and  nvl(STUDENTLTPDEACTIVE,'N')='N' and a.studentid   IN  (select b.studentid from studentregistration b where nvl(b.REGALLOW,'N')='Y' and b.EXAMCODE='"+mEC+"'  and b.institutecode='"+mIC+"'   ) and ";
		qry=qry+" a.examcode='"+mEC+"' and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
		//qry=qry+" AND employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND (a.EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) ";
		//qry=qry+" AND employeeid in (Select '"+mDMemberID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND a.EVENTSUBEVENT='"+mEvent+"'  and ( (a.studentid,a.fstid) in (select  c.studentid,c.fstid from StudentEventSubjectMarks c  where c.EVENTSUBEVENT='"+mEvent+"'  and nvl(c.DEACTIVE,'N')='N' and nvl(c.locked,'N')='N'	) OR  (a.studentid,a.fstid) NOT in (select  d.studentid,d.fstid from StudentEventSubjectMarks d where d.EVENTSUBEVENT='"+mEvent+"'  and nvl(d.DEACTIVE,'N')='N' and nvl(d.locked,'N')='N'	)  )" ;
		//qry=qry+"  and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and a.ltp IN ( decode((select e.APPLICABLEFOR from  exameventmaster e where e.examcode = '"+mEC+"' AND e.EXAMEVENTCODE = '"+mSE+"' and e.institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )   GROUP BY a.fstid,a.DEACTIVE,a.studentid,a.StudentName,a.enrollmentno,a.Semester, a.programcode,a.SECTIONBRANCH, a.subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";

/*SELECT   fstid, NVL (deactive, 'N') deactive, NVL (studentid, ' ') studentid,NVL (studentname, ' ') studentname, NVL (enrollmentno, ' ') enrollno, NVL (semester, 0) semester,
        NVL (programcode, ' ') || ' ('|| NVL (sectionbranch, ' ')|| ' - '|| subsectioncode|| ')' course    FROM v#exameventsubjecttagging a
        WHERE a.institutecode = 'J128'   AND NVL (a.LOCKED, 'N') = 'N'  AND ((NVL (a.deactive, 'N') = 'N')
     or     (a.studentid in (select x.studentid from studenteventsubjectmarks x where x.fstid = a.fstid))         )
     AND NVL (studentltpdeactive, 'N') = 'N'     AND a.studentid IN (            SELECT b.studentid              FROM studentregistration b
             WHERE NVL (b.regallow, 'N') = 'Y'               AND b.examcode = '2018ODDSEM'
               AND b.institutecode = 'J128')     AND a.examcode = '2018ODDSEM'     AND (a.ltp = 'L' OR (a.ltp = 'E' AND a.projectsubject = 'Y') OR a.ltp = 'P')     AND a.subjectid = '150052'     AND (a.employeeid = (SELECT 'UNIV-V00032' employeeid                        FROM DUAL))     AND a.eventsubevent = 'TEST-1'     AND a.ltp IN            (DECODE ((SELECT c.applicablefor                        FROM exameventmaster c     WHERE c.examcode = '2018ODDSEM'   AND c.exameventcode = 'TEST-1'       AND c.institutecode = 'J128'),                  'LT', 'L',                     'LP', 'L',                     'P'
                    )            )GROUP BY a.fstid,         a.deactive,         a.studentid,         a.studentname,         a.enrollmentno,
         a.semester,         a.programcode,         a.sectionbranch,         a.subsectioncode ORDER BY enrollno ASC*/





//out.print("111111"+qry);
//System.out.println("111111====SSSS"+qry);

        	}
		else
		{


		qry="select a.fstid,NVL(a.DEACTIVE,'N') DEACTIVE,nvl(a.studentid,' ')studentid,nvl(a.studentname,' ')StudentName, nvl(a.enrollmentno,' ')EnrollNo, nvl(a.semester,0)Semester,";
		qry=qry+ " nvl(a.programcode,' ')||' ('||nvl(a.SECTIONBRANCH,' ')||' - '||a.subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING a ";
		qry=qry+" where a.institutecode='"+mIC+"'";
                //and nvl(DEACTIVE,'N')='N'
                        qry=qry+" and nvl(a.locked,'N')='N' AND ((NVL (a.deactive, 'N') = 'N')  or     (a.studentid in (select x.studentid from studenteventsubjectmarks x where x.fstid = a.fstid and nvl(x.deactive,'N') = 'N')) ) and  nvl(a.STUDENTLTPDEACTIVE,'N')='N'  and a.studentid   IN  (select b.studentid from studentregistration b where nvl(b.REGALLOW,'N')='Y' and b.EXAMCODE='"+mEC+"'  and b.institutecode='"+mIC+"'   ) and ";
		qry=qry+" a.examcode='"+mEC+"' and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
		//qry=qry+" AND employeeid='"+mDMemberID+"' and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND (a.EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) ";
		//qry=qry+" AND employeeid in (Select '"+mDMemberID+"' EmployeeID from dual UNION Select EmployeeID from FacultySubjectTagging where FSTID in (SELECT FSTID FROM MULTIFACULTYSUBJECTTAGGING WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and EMPLOYEEID='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E')";
                qry=qry+" AND a.EVENTSUBEVENT='"+mEvent+"'  " ;

		//qry=qry+" and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and a.ltp IN ( decode((select c.APPLICABLEFOR from  exameventmaster c where c.examcode = '"+mEC+"' AND c.EXAMEVENTCODE = '"+mSE+"' and c.institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )  GROUP BY a.fstid,a.DEACTIVE,a.studentid,a.StudentName,a.enrollmentno,a.Semester, a.programcode,a.SECTIONBRANCH, a.subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";





		}
	//     out.print("JILIT - "+qry);

                qry1="SELECT distinct EVENTSUBEVENT from V#StudentEventSubjectMarks ";
                qry1=qry1+" where institutecode='"+mIC+"' ";
                qry1=qry1+" and nvl(DEACTIVE,'N')='N' ";
                qry1=qry1+" and nvl(locked,'N')='Y' and nvl(PUBLISHED,'N')='Y' ";
                qry1=qry1+"  and examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                qry1=qry1+" AND ((EMPLOYEEID=(Select '"+mDMemberID+"' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='"+mComp+"' and institutecode='"+mIC+"' and facultytype=decode('"+mDMemberType+"','E','I','E') and employeeid='"+mDMemberID+"')) and facultytype=decode('"+mDMemberType+"','E','I','E'))";
                qry1=qry1+" AND EVENTSUBEVENT<>'"+mEvent+"' " ;
                qry1=qry1+" Order By EVENTSUBEVENT ";

	}
	else if(!mSelf.equals("Self") && qryCtr==0)
	{
                qryCtr++;


					qry2="SELECT  'Y' from V#StudentEventSubjectMarks ";
                qry2=qry2+" where institutecode='"+mIC+"' ";
                qry2=qry2+" and nvl(DEACTIVE,'N')='N' ";
                //qry2=qry2+" and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                qry2=qry2+" and  examcode='"+mEC+"' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                qry2=qry2+" AND EMPLOYEEID='"+mDMemberID+"'  AND EVENTSUBEVENT='"+mEvent+"' ";
//System.out.print("JILIT - "+qry2);
			rs2=db.getRowset(qry2);
			if(rs2.next())
		{

//old Query
                            qry="select a.fstid,NVL(a.DEACTIVE,'N') DEACTIVE,nvl(a.studentid,' ')studentid,nvl(a.studentname,' ')StudentName, nvl(a.enrollmentno,' ')EnrollNo, nvl(a.semester,0)Semester,";
		qry=qry+" nvl(a.programcode,' ')||' ('||nvl(a.SECTIONBRANCH,' ')||' - '||a.subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING a ";
		qry=qry+" where a.institutecode='"+mIC+"' AND ((NVL (a.deactive, 'N') = 'N')  or     (a.studentid in (select x.studentid from studenteventsubjectmarks x where x.fstid = a.fstid and nvl(x.deactive,'N') = 'N')) )  and  nvl(a.STUDENTLTPDEACTIVE,'N')='N' and a.studentid   IN  (select b.studentid from studentregistration b  where nvl(b.REGALLOW,'N')='Y' and b.EXAMCODE='"+mEC+"'  and b.institutecode='"+mIC+"'   )  and nvl(a.locked,'N')='N'  and ";
		qry=qry+" a.examcode='"+mEC+"'  and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
		qry=qry+" AND a.EVENTSUBEVENT='"+mEvent+"'  and ( (a.studentid,a.fstid) in (select  c.studentid,c.fstid from StudentEventSubjectMarks c  where c.EVENTSUBEVENT='"+mEvent+"'   and nvl(c.locked,'N')='N'	) OR  (a.studentid,a.fstid) NOT in (select  d.studentid,d.fstid from StudentEventSubjectMarks d  where d.EVENTSUBEVENT='"+mEvent+"'   and nvl(d.locked,'N')='N'	)  )" ;
		qry=qry+" AND a.FSTID IN (SELECT e.FSTID FROM EX#SUBJECTGRADECOORDINATOR e WHERE  e.INSTITUTECODE='"+mIC+"' and e.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and e.FACULTYID='"+mDMemberID+"')";
		//qry=qry+" and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y'  and subjectID='"+mSC+"'and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and a.ltp IN ( decode((select f.APPLICABLEFOR from  exameventmaster f where f.examcode = '"+mEC+"' AND f.EXAMEVENTCODE = '"+mSE+"' and f.institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )  GROUP BY a.fstid,a.studentid,a.StudentName,a.enrollmentno,a.Semester, a.programcode,a.SECTIONBRANCH, a.subsectioncode,a.DEACTIVE";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";

                       /*    qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+" nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and  nvl(STUDENTLTPDEACTIVE,'N')='N' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   )  and nvl(locked,'N')='N'  and ";
		qry=qry+" examcode='"+mEC+"'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		qry=qry+" AND EVENTSUBEVENT='"+mEvent+"'" ;
		qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"')";
		//qry=qry+" and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y'  and subjectID='"+mSC+"'and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and ltp IN ( decode((select APPLICABLEFOR from  exameventmaster where examcode = '"+mEC+"' AND EXAMEVENTCODE = '"+mSE+"' and institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) )  GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";*/





		}
		else
		{


		/*qry="select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
		qry=qry+" nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
		qry=qry+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' and  nvl(STUDENTLTPDEACTIVE,'N')='N' and studentid   IN  (select studentid from studentregistration  where nvl(REGALLOW,'N')='Y' and EXAMCODE='"+mEC+"'  and institutecode='"+mIC+"'   ) and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
		qry=qry+" examcode='"+mEC+"'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
		qry=qry+" And EVENTSUBEVENT='"+mEvent+"' " ;
		qry=qry+" AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='"+mComp+"' and INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"')";

		//qry=qry+" and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and ltp IN ( decode((select APPLICABLEFOR from  exameventmaster where examcode = '"+mEC+"' AND EXAMEVENTCODE = '"+mSE+"' and institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) ) GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";

;*/
                           qry="select a.fstid,NVL(a.DEACTIVE,'N') DEACTIVE,nvl(a.studentid,' ')studentid,nvl(a.studentname,' ')StudentName, nvl(a.enrollmentno,' ')EnrollNo, nvl(a.semester,0)Semester,";
		qry=qry+" nvl(a.programcode,' ')||' ('||nvl(a.SECTIONBRANCH,' ')||' - '||a.subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING a ";
		qry=qry+" where a.institutecode='"+mIC+"' AND ((NVL (a.deactive, 'N') = 'N')  or     (a.studentid in (select x.studentid from studenteventsubjectmarks x where x.fstid = a.fstid and nvl(x.deactive,'N') = 'N')) )  and  nvl(a.STUDENTLTPDEACTIVE,'N')='N' and a.studentid   IN  (select b.studentid from studentregistration b where nvl(b.REGALLOW,'N')='Y' and b.EXAMCODE='"+mEC+"'  and b.institutecode='"+mIC+"'   )  and nvl(a.locked,'N')='N'  and ";
		qry=qry+" a.examcode='"+mEC+"'  and (a.ltp='L' OR (a.LTP='E' AND a.PROJECTSUBJECT='Y') OR a.LTP='P' ) and a.subjectID='"+mSC+"' ";
		qry=qry+" And a.EVENTSUBEVENT='"+mEvent+"' " ;
		qry=qry+" AND a.FSTID IN (SELECT c.FSTID FROM EX#SUBJECTGRADECOORDINATOR c WHERE  c.INSTITUTECODE='"+mIC+"' and c.FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and c.FACULTYID='"+mDMemberID+"')";

		//qry=qry+" and STUDENTID NOT  IN (Select distinct studentid from debarstudentdetail where nvl(REEXAMINATION,'N' )='Y' and subjectID='"+mSC+"' and institutecode='"+mIC+"'  AND EVENTSUBEVENT = '"+mEvent+"' and examcode='"+mEC+"') ";

		qry=qry+" and a.ltp IN ( decode((select d.APPLICABLEFOR  from  exameventmaster d where d.examcode = '"+mEC+"' AND d.EXAMEVENTCODE = '"+mSE+"' and d.institutecode = '"+mIC+"'),'LT','L','LP','L','P' ) ) GROUP BY a.fstid,a.studentid,a.StudentName,a.enrollmentno,a.Semester, a.programcode,a.SECTIONBRANCH, a.subsectioncode,a.DEACTIVE";
		qry=qry+" order by "+mList+ " "+mOrder+ " ";
//out.print("All+++"+qry);



//and subjectID='"+mSC+"'



		}

                qry1="SELECT distinct EVENTSUBEVENT from V#StudentEventSubjectMarks ";
                qry1=qry1+" where institutecode='"+mIC+"' and nvl(DEACTIVE,'N')='N' ";
                qry1=qry1+" and nvl(locked,'N')='Y' and nvl(PUBLISHED,'N')='Y'  ";
                qry1=qry1+" and examcode='"+mEC+"'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='"+mSC+"' ";
                qry1=qry1+" And EVENTSUBEVENT<>'"+mEvent+"' " ;
                qry1=qry1+" AND subjectid IN (SELECT subjectid FROM EX#SUBJECTGRADECOORDINATOR WHERE  ";
                qry1=qry1+"  INSTITUTECODE='"+mIC+"' and FACULTYTYPE=decode('"+mDMemberType+"','E','I','E') and FACULTYID='"+mDMemberID+"')";
                qry1=qry1+" order by EVENTSUBEVENT ";
	}


		//System.out.print("JILIT - "+qry);
        rs = db.getRowset(qry);
out.print ("step 3");
        // Lets Set up the GetHandler
        JspGetHandler myGetHandler = new JspGetHandler(response, out);

        // First we define columns we are sending in each record.

        myGetHandler.defineField("fstid");
        myGetHandler.defineField("SNo");
        myGetHandler.defineField("studentid");
        myGetHandler.defineField("EnrollNo");
        myGetHandler.defineField("StudentName");
        myGetHandler.defineField("AbsentOrDetained");
        myGetHandler.defineField("Marks");
		    myGetHandler.defineField("Color");

        myGetHandler.defineField("MarksHidden");
          myGetHandler.defineField("Updated");


        myGetHandler.defineField("PMarks");
        myGetHandler.defineField("PMarks1");
        myGetHandler.defineField("PMarks2");
        myGetHandler.defineField("PMarks3");
        myGetHandler.defineField("PMarks4");
        myGetHandler.defineField("PMarks5");
        myGetHandler.defineField("PMarks6");
        myGetHandler.defineField("PMarks7");
        myGetHandler.defineField("PMarks8");
        myGetHandler.defineField("PMarks9");
        myGetHandler.defineField("PMarks10");
        myGetHandler.defineField("FMarks");
        myGetHandler.defineField("Course");
        myGetHandler.defineField("Semester");
		myGetHandler.defineField("Sum1");


        // loop through the ResultSet from the Database and set values to myGetHandler
        Record curRecord;
        String mSID="", mSENo="", mSName="", mSMarks="", mSCourse="", mSSem="";
        String mEvent1="", mEvent2="", mEvent3="", mEvent4="", mEvent5="", mEvent6="", mEvent7="", mEvent8="", mEvent9="", mEvent10="", mPrevEvent="";
        String mSMarks1="", mSMarks2="", mSMarks3="", mSMarks4="", mSMarks5="", mSMarks6="", mSMarks7="", mSMarks8="", mSMarks9="", mSMarks10="", mPSMarks="";
		String qryde="";
			ResultSet rsde=null;

			String PRORATA11="",UFMMARKS11="",MEDICAL11="",ABSENTCASE11="";
        int a=0;
        rs2 = db.getRowset(qry1);
        while (rs2.next())
        {
            mPrevEvent=rs2.getString(1);
            if(mEvent1.equals(""))
                mEvent1=mPrevEvent;
            else if(mEvent2.equals(""))
                mEvent2=mPrevEvent;
            else if(mEvent3.equals(""))
                mEvent3=mPrevEvent;
            else if(mEvent4.equals(""))
                mEvent4=mPrevEvent;
            else if(mEvent5.equals(""))
                mEvent5=mPrevEvent;
            else if(mEvent6.equals(""))
                mEvent6=mPrevEvent;
            else if(mEvent7.equals(""))
                mEvent7=mPrevEvent;
            else if(mEvent8.equals(""))
                mEvent8=mPrevEvent;
            else if(mEvent9.equals(""))
                mEvent9=mPrevEvent;
            else if(mEvent10.equals(""))
                mEvent10=mPrevEvent;
            else
                mPrevEvent="";
        }
        rs2 = db.getRowset(qry1);
        while (rs.next())
        {
                ctr++;
                String CTR=ctr+".";
                mSID=rs.getString("studentid");
                mSENo = rs.getString("EnrollNo");
                mSName = rs.getString("StudentName");
                mSCourse = rs.getString("Course");
                mSSem = rs.getString("Semester");
                deactive = rs.getString("DEACTIVE");
                //session.setAttribute("DEACTIVE",deactive);
                //System.out.println("1111111111111111111112222"+session.getAttribute("DEACTIVE"));


				curRecord = myGetHandler.createNewRecord(mSID);


            qry="Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		 //  	System.out.print("JILIT - "+qry);
			rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks = rs1.getString("MARKSAWARDED1");




			qryd="Select DISTINCT NVL(EVENTSUBEVENT,' ')EVENTSUBEVENT, STUDENTID , NVL(MEDICALCASE,'N') MEDICALCASE, NVL( ABSENTCASE,'N')  ABSENTCASE, DECODE(PRORATA,'Y','P','N','N',' ','',PRORATA)PRORATA, nvl(UFMMARKS,'N')UFMMARKS from DEBARSTUDENTDETAIL      ";
			qryd=qryd+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qryd=qryd+" EVENTSUBEVENT='"+mEvent+"' and   ";
		    qryd=qryd+" fstid='"+rs1.getString("fstid")+"' and STUDENTID='"+rs1.getString("studentid")+"' ";
//	System.out.println(qryd);
				rsd=db.getRowset(qryd);
				if(rsd.next())
					{
						PRORATA11= rsd.getString("PRORATA");

							MEDICAL11= rsd.getString("MEDICALCASE");

								ABSENTCASE11= rsd.getString("ABSENTCASE");


     					UFMMARKS11= rsd.getString("UFMMARKS");

							if(UFMMARKS11.equals("Y"))
						{
								mSMarks="U";

						}
						else				if(PRORATA11.equals("P"))
						{
							mSMarks="P";
						}
						else 		if(MEDICAL11.equals("Y"))
						{
									mSMarks="M";
						}
							else 		if(ABSENTCASE11.equals("Y"))
						{
							mSMarks1="A";
						}
					}

                else
                {
                   if(mSMarks.equals("-1") && !rs1.getString("DETAINED").equals("N"))
                          mSMarks = rs1.getString("DETAINED")+"-";

                        if(mSMarks.equals("-1") && rs1.getString("DETAINED").equals("N"))
                            mSMarks = "";

                }



                }
				else
			{
				 mSMarks = "";
			}



                rs2 = db.getRowset(qry1);
                //System.out.print("Query - "+qry);
                while(rs2.next())
                {
                    counter++;
                }


                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent1+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
        	 //  System.out.println(qry);
                if(rs1.next())
                {
                    mSMarks1 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks1.equals("-1"))
                        mSMarks1 =  rs1.getString("DETAINED");
                        if(mSMarks1.equals("N"))
                            mSMarks1 = "";
                }
                else
                {
                    mSMarks1 = "";
                }




					// System.out.println(mSMarks1+" :: mSMarks1");


                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent2+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks2 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks2.equals("-1"))
                        mSMarks2 =  rs1.getString("DETAINED");
                        if(mSMarks2.equals("N"))
                            mSMarks2 = "";



                }
                else
                {
                    mSMarks2 = "";
                }


	// System.out.println(mSMarks2+" :: mSMarks2");

                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent3+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks3 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks3.equals("-1"))
                        mSMarks3 = rs1.getString("DETAINED");
                        if(mSMarks3.equals("N"))
                            mSMarks3 = "";



                }
                else
                {
                    mSMarks3 = "";
                }




                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent4+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks4 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks4.equals("-1"))
                        mSMarks4 =  rs1.getString("DETAINED");
                        if(mSMarks4.equals("N"))
                            mSMarks4 = "";
                }
                else
                {
                    mSMarks4 = "";
                }
                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent5+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks5 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks5.equals("-1"))
                        mSMarks5 =  rs1.getString("DETAINED");
                        if(mSMarks5.equals("N"))
                            mSMarks5 = "";
                }
                else
                {
                    mSMarks5 = "";
                }
                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent6+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks6 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks6.equals("-1"))
                        mSMarks6 =  rs1.getString("DETAINED");
                        if(mSMarks6.equals("N"))
                            mSMarks6 = "";
                }
                else
                {
                    mSMarks6 = "";
                }
                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent7+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks7 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks7.equals("-1"))
                        mSMarks7 = rs1.getString("DETAINED");
                        if(mSMarks7.equals("N"))
                            mSMarks7 = "";
                }
                else
                {
                    mSMarks7 = "";
                }
                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent8+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks8 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks8.equals("-1"))
                        mSMarks8 = rs1.getString("DETAINED");
                        if(mSMarks8.equals("N"))
                            mSMarks8 = "";
                }
                else
                {
                    mSMarks8 = "";
                }
                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent9+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks9 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks9.equals("-1"))
                        mSMarks9 =  rs1.getString("DETAINED");
                        if(mSMarks9.equals("N"))
                            mSMarks9 = "";
                }
                else
                {
                    mSMarks9 = "";
                }

                qry="Select nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry=qry+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry=qry+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry=qry+" EVENTSUBEVENT='"+mEvent10+"' and   ";
		    qry=qry+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		    rs1=db.getRowset(qry);
                if(rs1.next())
                {
                    mSMarks10 = rs1.getString("MARKSAWARDED1");
                    if(mSMarks10.equals("-1"))
                        mSMarks10 =  rs1.getString("DETAINED");
                        if(mSMarks10.equals("N"))
                            mSMarks10 = "";
                }
                else
                {
                    mSMarks10 = "";
                }






//-------------------- DEBAR STUDENTDETAIL -----------------------


qry2=" select NVL(A.DEBAR,'N')DEBAR,NVL(A.MEDICALCASE,'N')MEDICALCASE,NVL(A.ABSENTCASE,'N')ABSENTCASE,NVL(A.UFM ,'N')UFM,NVL(A.UFMMARKS ,'N')UFMMARKS,NVL(A.PRORATA,'N')PRORATA from DEBARSTUDENTDETAIL a  WHERE a.EXAMCODE='"+mEC+"' and a.fstid = '"+rs.getString("fstid")+"'  and a.INSTITUTECODE='"+mIC+"' and a.STUDENTID='"+mSID+"' AND A.SUBJECTID='"+mSC+"' and nvl(a.DEACTIVE,'N')='N' AND   A.EVENTSUBEVENT='"+mEvent+"' ";

//( a.EVENTSUBEVENT is null or A.FSTID IN (SELECT b.FSTID FROM        EXAMEVENTSUBJECTTAGGING b WHERE ( b.EVENTSUBEVENT LIKE ('TEST-3%') OR b.EVENTSUBEVENT         LIKE ('T-3%') OR   b.EVENTSUBEVENT LIKE ('T3%') OR b.EVENTSUBEVENT LIKE ('END%') OR         b.EVENTSUBEVENT='"+mEvent+"' )  and a.eventsubevent=b.EVENTSUBEVENT  ) ) ";
/*
AND A.FSTID IN (SELECT FSTID FROM EXAMEVENTSUBJECTTAGGING WHERE ( EVENTSUBEVENT LIKE ('TEST-3%') OR EVENTSUBEVENT LIKE ('T-3%') OR   EVENTSUBEVENT LIKE ('T3%') OR EVENTSUBEVENT LIKE ('END%') OR EVENTSUBEVENT='"+mEvent+"' )  ) " ;
*/
				//	System.out.print(qry2);
							rs3=db.getRowset(qry2);
							if(rs3.next())
							{
								mDebar=rs3.getString("DEBAR");
								mMedical=rs3.getString("MEDICALCASE");
								mAbsent=rs3.getString("ABSENTCASE");
								mUFM=rs3.getString("UFM");
								PRORATA=rs3.getString("PRORATA");
								UFMMARKS=rs3.getString("UFMMARKS");
							}
							else
							{
									mDebar="N";
									UFMMARKS="N";
									PRORATA="N";
									mMedical="N";
								mAbsent="N";
								mUFM="N";
								Color="";

							}


//---------------------------------------------------------------


						if(UFMMARKS.equals("Y"))
								{
    							//mSMarks="0";
								Color="RED";
								mSName=mSName+" ***UFM";
								}


							if(PRORATA.equals("Y"))
								{
    							mSMarks="P";
								Color="RED";
									mSName=mSName+" ***P";
								}

							if(mDebar.equals("Y"))
								{
    							mSMarks="D";
								Color="RED";
									mSName=mSName+" ***D";
								}

								 if(mMedical.equals("Y"))
								{
										mSMarks="M";
										Color="Yellow";
											mSName=mSName+" ***M";
								}

								 if(mAbsent.equals("Y"))
								{
										mSMarks="A";
										Color="Orange";
											mSName=mSName+" ***A";
								}

								 if(mUFM.equals("Y"))
								{
										mSMarks="U";
										Color="darkgray";
											mSName=mSName+" ***U";
								}





        _marks_Of_Test =_marks_Of_Test.equals("null")?"":_marks_Of_Test.trim();
        if(!_marks_Of_Test.trim().equals(""))
{
curRecord.setField("Marks", marksArray[counter_marks_array]);
}else
{
curRecord.setField("Marks", mSMarks);
}

curRecord.setField("Color", Color);
counter_marks_array++;
//------------------ summ of marks



		//			 System.out.println(mSMarks1+" :: mSMarks1");


//System.out.println(" : : "+mSMarks1+" : : "+mSMarks2+" : : "+mSMarks3+" : : "+mSMarks4+" : : "+mSMarks5+" : : "+mSMarks6);
/*
if(!mSMarks1.equals("") && !mSMarks2.equals("")  && !mSMarks3.equals("")  && !mSMarks4.equals("")  && !mSMarks5.equals("")  && !mSMarks6.equals("")  )
			{*/



 Sum= (( mSMarks1.equals("") || mSMarks1.equals("A") || mSMarks1.equals("M") || mSMarks1.equals("U") || mSMarks1.equals("P") || mSMarks1.equals("D")  )?0: Double.parseDouble(mSMarks1) ) + ( (mSMarks2.equals("") || mSMarks2.equals("A") || mSMarks2.equals("M") || mSMarks2.equals("U") || mSMarks2.equals("D") ||  mSMarks2.equals("P") )?0: Double.parseDouble(mSMarks2)) + ((mSMarks3.equals("") || mSMarks3.equals("A") || mSMarks3.equals("M") || mSMarks3.equals("U") || mSMarks3.equals("D") ||  mSMarks3.equals("P") )?0: Double.parseDouble(mSMarks3) )  +
	 ((mSMarks4.equals("") || mSMarks4.equals("A") || mSMarks4.equals("M") || mSMarks4.equals("U") || mSMarks4.equals("D") ||  mSMarks4.equals("P") )?0: Double.parseDouble(mSMarks4) ) +
	 ((mSMarks5.equals("") || mSMarks5.equals("A") || mSMarks5.equals("M") || mSMarks5.equals("U") || mSMarks5.equals("D") ||  mSMarks5.equals("P") )?0: Double.parseDouble(mSMarks5) ) ;


 //+ Double.parseDouble(mSMarks3) +Double.parseDouble(mSMarks4) + Double.parseDouble(mSMarks5) + Double.parseDouble(mSMarks6);
		//}
SumTotal=Double.toString(Sum);


curRecord.setField("Sum1", SumTotal);

//---------------------- debar studentdetail




			qryd="Select DISTINCT NVL(EVENTSUBEVENT,' ')EVENTSUBEVENT, STUDENTID , NVL(MEDICALCASE,'N') MEDICALCASE, NVL( ABSENTCASE,'N')  ABSENTCASE, DECODE(PRORATA,'Y','P','N','N',' ','',PRORATA)PRORATA, nvl(UFMMARKS,'N')UFMMARKS from DEBARSTUDENTDETAIL      ";
			qryd=qryd+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qryd=qryd+" EVENTSUBEVENT='"+mEvent1+"' and   ";
		    qryd=qryd+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
//	System.out.println(qryd);
				rsd=db.getRowset(qryd);
				if(rsd.next())
					{
						PRORATA1= rsd.getString("PRORATA");

							MEDICAL1= rsd.getString("MEDICALCASE");

								ABSENTCASE1= rsd.getString("ABSENTCASE");


     					UFMMARKS1= rsd.getString("UFMMARKS");

							if(UFMMARKS1.equals("Y"))
						{
								mSMarks1=mSMarks1+"* UFM";

						}
						else				if(PRORATA1.equals("P"))
						{
							mSMarks1=mSMarks1+" *"+PRORATA1;
						}
						else 		if(MEDICAL1.equals("Y"))
						{
									mSMarks1=mSMarks1+"* M";
						}
							else 		if(ABSENTCASE1.equals("Y"))
						{
							mSMarks1=mSMarks1+"* A";
						}
					}
					else
					{
						mSMarks1=mSMarks1;
					}


			qryd="Select DISTINCT NVL(EVENTSUBEVENT,' ')EVENTSUBEVENT, STUDENTID, NVL(MEDICALCASE,'N') MEDICALCASE, NVL( ABSENTCASE,'N')  ABSENTCASE, DECODE(PRORATA,'Y','P','N','N',' ','',PRORATA)PRORATA, nvl(UFMMARKS,'N')UFMMARKS from DEBARSTUDENTDETAIL      ";
			qryd=qryd+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qryd=qryd+" EVENTSUBEVENT='"+mEvent2+"' and   ";
		    qryd=qryd+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
				rsd=db.getRowset(qryd);

				if(rsd.next())
					{
						PRORATA2= rsd.getString("PRORATA");


						UFMMARKS2= rsd.getString("UFMMARKS");

							MEDICAL2= rsd.getString("MEDICALCASE");

								ABSENTCASE2= rsd.getString("ABSENTCASE");

							if(UFMMARKS2.equals("Y"))
						{
								mSMarks2=mSMarks2+"* UFM";

						}
						else				if(PRORATA2.equals("P"))
						{
							mSMarks2=mSMarks2+" *"+PRORATA2;
						}
						else 		if(MEDICAL2.equals("Y"))
						{
									mSMarks2=mSMarks2+"* M";
						}
							else 		if(ABSENTCASE2.equals("Y"))
						{
							mSMarks2=mSMarks2+"* A";
						}

					}
						else
					{
						mSMarks2=mSMarks2;
					}


			qryd="Select DISTINCT NVL(EVENTSUBEVENT,' ')EVENTSUBEVENT, STUDENTID,  NVL(MEDICALCASE,'N') MEDICALCASE, NVL( ABSENTCASE,'N')  ABSENTCASE,  DECODE(PRORATA,'Y','P','N','N',' ','',PRORATA)PRORATA, nvl(UFMMARKS,'N')UFMMARKS from DEBARSTUDENTDETAIL      ";
			qryd=qryd+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qryd=qryd+" EVENTSUBEVENT='"+mEvent3+"' and   ";
		    qryd=qryd+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";

// System.out.println(qryd+" ----------- ");
				rsd=db.getRowset(qryd);
				if(rsd.next())
					{
						PRORATA3= rsd.getString("PRORATA");

							UFMMARKS3= rsd.getString("UFMMARKS");

								MEDICAL3= rsd.getString("MEDICALCASE");

								ABSENTCASE3= rsd.getString("ABSENTCASE");


							if(UFMMARKS3.equals("Y"))
						{
								mSMarks3=mSMarks3+"* UFM";

						}
						else				if(PRORATA3.equals("P"))
						{
							mSMarks3=mSMarks3+" *"+PRORATA3;
						}
							else 		if(MEDICAL3.equals("Y"))
						{
									mSMarks3=mSMarks3+"* M";
						}
							else 		if(ABSENTCASE3.equals("Y"))
						{
							mSMarks3=mSMarks3+"* A";
						}

					}
						else
					{
						mSMarks3=mSMarks3;
					}
		//---------------------------------------


 //System.out.println(mSMarks+" :: mSMarks1:::::"+mSMarks1 +" ::: mSMarks2 :: "+mSMarks2 + " :::mSMarks3"+mSMarks3);

// System.out.println(rs.getString("fstid")+" ----------- mSM"+rs.getString("fstid"));


                curRecord.setField("fstid", rs.getString("fstid"));
                curRecord.setField("SNo", CTR);
                curRecord.setField("studentid", rs.getString("studentid"));
                curRecord.setField("EnrollNo", mSENo);
                //System.out.println("deactive---"+deactive);
                if(deactive.equals("Y")){
                    //System.out.println("deactive---if"+deactive);
                curRecord.setField("StudentName", mSName+" (DEACTIVE)");
               System.out.println("deactive---if2"+deactive);
               System.out.println("11111"+curRecord.getField("StudentName").toString().trim());
                }
                else
                {
                    //System.out.println("deactive---else"+deactive);
                  curRecord.setField("StudentName", mSName);
                  //System.out.println("deactive---else2"+deactive);
                }
                curRecord.setField("AbsentOrDetained", "B");

				curRecord.setField("MarksHidden", mSMarks);
              	curRecord.setField("PMarks", mPSMarks);
                curRecord.setField("PMarks1", mSMarks1);
                curRecord.setField("PMarks2", mSMarks2);
                curRecord.setField("PMarks3", mSMarks3);
                curRecord.setField("PMarks4", mSMarks4);
                curRecord.setField("PMarks5", mSMarks5);
                curRecord.setField("PMarks6", mSMarks6);
                curRecord.setField("PMarks7", mSMarks7);
                curRecord.setField("PMarks8", mSMarks8);
                curRecord.setField("PMarks9", mSMarks9);
                curRecord.setField("PMarks10", mSMarks10);

		curRecord.setField("Course", mSCourse);
                curRecord.setField("Semester", mSSem);
                curRecord.setField("Updated", "n");


                myGetHandler.addRecord(curRecord);
                a++;


			//session.setAttribute("TotRec",CTR);
        }
		//session.setAttribute("Counter",ctr);
        myGetHandler.writeToClient("UTF-8",out);
}
catch( Exception e)
{
    out.print(e+"LLLLL");
}
%>