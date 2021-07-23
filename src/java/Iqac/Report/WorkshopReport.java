/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Iqac.Report;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import tietwebkiosk.*;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

/**
 *
 * @author Gyanendra.Bhatt 
 */
@Path("/WorkshopReport")
public class WorkshopReport {

    Map hm = new HashMap();

    public Map getHm() {
        return hm;
    }

    public void setHm(Map hm) {
        this.hm = hm;
    }
    DBHandler db = new DBHandler();
    StringBuilder sb = new StringBuilder();
    String qry;
    ResultSet rs = null;

    @POST
    @Path("/department")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmet() throws SQLException {
        qry = "select nvl(Departmentcode,' ') depcode,nvl(Department,' ') dep  from departmentmaster  where deactive='N' and DEPARTMENTTYPE='T' order by Department";
        rs = db.getRowset(qry);
        while (rs.next()) {
            sb.append("\"" + rs.getString("depcode") + "\":\"" + rs.getString("dep") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("/programtitle")
    @Produces(MediaType.APPLICATION_JSON)
    public String getProgramtitle(@QueryParam("department") String department, @QueryParam("startdate") String startdate, @QueryParam("enddate") String enddate) throws SQLException {
        qry = "select nvl(PSAPROGRAMTITLE,' ') programtitle,nvl(PSAPROGRAMTYPE,' ') programtype from  AP#PSAWORKSHOPDETAILS" +
                " where departmentcode='" + department + "' and psastartdate>=to_date('" + startdate + "','dd-mm-yyyy')" +
                " and psaenddate<=to_date('" + enddate + "','dd-mm-yyyy')";
        rs = db.getRowset(qry);
        while (rs.next()) {
            sb.append("\"" + rs.getString("programtitle") + "\":\"" + rs.getString("programtitle") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("/report")
    @Produces(MediaType.APPLICATION_JSON)
    public String getReport(@QueryParam("department") String department, @QueryParam("startdate") String startdate, @QueryParam("enddate") String enddate, @QueryParam("programtitle") String programtitle) throws SQLException {
        try {
            String qry1="";
            ResultSet rs1=null;

            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
             sb.append("\"sysdate\":\"" + rs.getString("currentdate") + "\",");
            }




            qry = "SELECT (select nvl(department,' ') from departmentmaster where departmentcode = '" + department + "') department,nvl(B.TRANSACTIONID,' ') TRANSACTIONID " +
                    ",nvl (decode(B.PSAPROGRAMTYPE,'W','WorkShops','S','Special Course','G','Guest Lecture','F','Faculty Developement Program','O','Others')" +
                    ",'Others') PROGRAMTYPE ,nvl(B.PSAPROGRAMTITLE,' ') PSAPROGRAMTITLE, nvl(to_char(B.PSASTARTDATE,'dd-Mon-yyyy'),' ') PSASTARTDATE, " +
                    "nvl(to_char(B.PSAENDDATE,'dd-Mon-yyyy'),' ') PSAENDDATE, nvl(B.PSAPROGRAMOBJECTIVE,' ') PSAPROGRAMOBJECTIVE," +
                    " nvl(B.PSATARGETAUDIENCE,' ') PSATARGETAUDIENCE ,nvl(B.PSATENTATIVEBUDGET,'0') PSATENTATIVEBUDGET " +
                    " from  AP#PSAWORKSHOPDETAILS" +
                    "  b where b.departmentcode='" + department + "'  and b.psastartdate>=to_date('" + startdate + "','dd-mm-yyyy')  and " +
                    "  b.PSAENDDATE<=to_date('" + enddate + "','dd-mm-yyyy')  and b.psaprogramtitle='" + programtitle + "' " +
                    "  ";
          //  System.out.println("qry : "+qry);

//           qry="SELECT (SELECT NVL (department, ' ')  FROM departmentmaster   WHERE departmentcode = '"+department+"') department,     " +
//                   "  NVL (b.transactionid, ' ') transactionid, " +
//                   " NVL (DECODE (b.psaprogramtype,'W', 'WorkShops','S', 'Special Course','G', 'Guest Lecture', 'F'," +
//                   " 'Faculty Developement Program','O', 'Others' ),'Others') programtype,       NVL (b.psaprogramtitle, ' ') psaprogramtitle," +
//                   "NVL (TO_CHAR (b.psastartdate, 'dd-Mon-yyyy'), ' ') psastartdate,     " +
//                   "  NVL (TO_CHAR (b.psaenddate, 'dd-Mon-yyyy'), ' ') psaenddate,NVL (b.psaprogramobjective, ' ') psaprogramobjective, " +
//                   "      NVL (b.psatargetaudience, ' ') psatargetaudience,NVL (b.psatentativebudget, '0') psatentativebudget   " +
//                   " FROM ap#psaworkshopdetails b WHERE b.departmentcode = '" + department + "'   AND b.psastartdate >= TO_DATE ('" + startdate + "', 'dd-mm-yyyy') " +
//                   "  AND b.psaenddate <= TO_DATE ('" + enddate + "', 'dd-mm-yyyy')   AND b.psaprogramtitle = '" + programtitle + "'" ;
            rs = db.getRowset(qry);
            if (rs.next()) {
                sb.append("\"department\":\"" + rs.getString("department") + "\",");
                sb.append("\"programtype\":\"" + rs.getString("PROGRAMTYPE") + "\",");
                sb.append("\"programtitle\":\"" + rs.getString("PSAPROGRAMTITLE") + "\",");
                sb.append("\"startdate\":\"" + rs.getString("PSASTARTDATE") + "\",");
                sb.append("\"enddate\":\"" + rs.getString("PSAENDDATE") + "\",");
                qry1="select ROUND(to_date('"+ rs.getString("PSAENDDATE")+"','DD-MM-YYYY')-to_date('"+rs.getString("PSASTARTDATE")+"','DD-MM-YYYY'),0)+1 due FROM DUAL";
                rs1=db.getRowset(qry1);
                if(rs1.next())
                {
                sb.append("\"duerations\":\"" + rs1.getString("due") + "\",");
                }



                sb.append("\"objective\":\"" + rs.getString("PSAPROGRAMOBJECTIVE") + "\",");
                sb.append("\"audience\":\"" + rs.getString("PSATARGETAUDIENCE") + "\",");
                sb.append("\"budget\":\"" + rs.getString("PSATENTATIVEBUDGET") + "\",");
                sb.append("\"transid\":\"" + rs.getString("TRANSACTIONID") + "\",");
                sb.append("\"participantfeedback\":\"" + rs.getString("PARTICIPANTSFEEDBACK") + "\",");
                sb.append("\"participantcomment\":\"" + rs.getString("PARTICIPANTFEEDBACKCOMMENT") + "\",");
                sb.append("\"personfeedback\":\"" + rs.getString("PERSONFEEDBACK") + "\",");
                sb.append("\"personcomment\":\"" + rs.getString("PERSONFBCOMMENT") + "\",");
                sb.append("\"raisedfund\":\"" + rs.getString("PSAFUNDSRAISED") + "\",");
                sb.append("\"spendfund\":\"" + rs.getString("PSAFUNDSSPENT") + "\",");
                sb.append("\"websiteupdate\":\"" + rs.getString("WEBSITEUPDATE") + "\",");
                sb.append("\"databaseupdate\":\"" + rs.getString("DATABASEUPDATE") + "\",");
                sb.append("\"personcomment\":\"" + rs.getString("PERSONFBCOMMENT") + "\",");
                sb.append("\"facultycomment\":\"" + rs.getString("PROGRAMREMARKS") + "\",");
            }else{
                sb.append("\"msg\":\"Y\",");
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("/griddata")
    @Produces(MediaType.APPLICATION_JSON)
    public String getGriddata(@QueryParam("transactionid") String transactionid) throws SQLException {

        int i = 0;



        qry = "SELECT nvl(c.employeename,'N/A') employeename,nvl(A.PSARESOURCEPERSONAFFILIATION,'N/A') affilation," +
                "(select nvl(DM.DESIGNATION,'N/A') DESIGNATION  from DESIGNATIONMaster DM where  DM.DESIGNATIONCODE=C.DESIGNATIONCODE) DESIGNATION," +
                "nvl(A.PSARESOURCEPERSONEXPERTISE,'N/A') Expertise  FROM AP#PSAWORKSHOPRESOURCE a, AP#PSAWORKSHOPDETAILS b, EMPLOYEEMASTER C  " +
                "WHERE a.transactionid = '" + transactionid + "'  AND A.COMPANYID = B.COMPANYID AND A.INSTITUTEID = B.INSTITUTEID AND " +
                "A.TRANSACTIONID = B.TRANSACTIONID  and A.PSARESOURCEPERSONID=C.employeeid";
        rs = db.getRowset(qry);
        while (rs.next()) {
            ++i;
            //  sb.append("{\"slno\":\""+i+"\",");
            sb.append("{\"employeename\":\"" + rs.getString("employeename").trim() + "\",");
            sb.append("\"affilation\":\"" + rs.getString("affilation").trim() + "\",");
            sb.append("\"DESIGNATION\":\"" + rs.getString("DESIGNATION").trim() + "\",");
            sb.append("\"Expertise\":\"" + rs.getString("Expertise").trim() + "\"},");
            }
       
        return "[" + sb.toString().substring(0, sb.length() - 1) + "]";
    }

    @GET
    @Path("/company")
    @Produces(MediaType.APPLICATION_JSON)
    public String getCompany() throws SQLException {
        qry = "select distinct nvl(A.COMPANYCODE,' ') COMPANYCODE,nvl(A.COMPANYNAME,' ') COMPANYNAME  from companymaster a,AP#PSAINDUSTRIALDETAILS b where A.COMPANYCODE=B.COMPANYID";
        rs = db.getRowset(qry);
        while (rs.next()) {
            sb.append("\"" + rs.getString("COMPANYCODE") + "\":\"" + rs.getString("COMPANYNAME") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("{company}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getInstitute(@PathParam("company") String company) throws SQLException {
        try {
            qry = "select distinct nvl(A.INSTITUTECODE,' ') INSTITUTECODE,nvl(A.INSTITUTENAME,' ') INSTITUTENAME from institutemaster a, AP#PSAINDUSTRIALDETAILS b " +
                    "where A.INSTITUTECODE=B.INSTITUTEID and b.companyid='" + company + "'";
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\"" + rs.getString("INSTITUTECODE") + "\":\"" + rs.getString("INSTITUTENAME") + "\",");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("{company}/{institute}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTransaction(@PathParam("company") String company, @PathParam("institute") String institute) throws SQLException {
        qry = "select distinct nvl(B.TRANSACTIONID||'-'||B.ENTRYBY ,'  ') transactiondetail,nvl(B.TRANSACTIONID,' ') TRANSACTIONID  from  AP#PSAINDUSTRIALDETAILS b " +
                "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "'";
        rs = db.getRowset(qry);
        while (rs.next()) {

            sb.append("\"" + rs.getString("TRANSACTIONID") + "\":\"" + rs.getString("transactiondetail") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("{company}/{institute}/{transactionid}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getTransactionDate(@PathParam("company") String company, @PathParam("institute") String institute, @PathParam("transactionid") String transactionid) throws SQLException {
        try {
            qry = "select nvl(to_char(b.TRANSACTIONdate,'dd-Mon-yyyy'),' ') transdate  from  AP#PSAINDUSTRIALDETAILS b " +
                    "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "'";
            rs = db.getRowset(qry);
            while (rs.next()) {

                sb.append("\"transdate\":\"" + rs.getString("transdate") + "\",");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("/IndusReport")
    @Produces(MediaType.APPLICATION_JSON)
    public String getIndusReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid, @QueryParam("transdate") String transdate) throws SQLException {
        try {
            qry = "SELECT (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    "NVL (TO_CHAR (b.TRANSACTIONdate, 'dd-Mon-yyyy'), ' ') transdate,  NVL (B.PSARANDDLABDETAILS, ' ') rnd," +
                    " NVL (B.PSASCHOLARFELLOWDETAILS, ' ') fellowdeatails,  NVL (B.PSACOLLABORATIVEDEGREEDETAILS, ' ') collaborative,  " +
                    " NVL (B.PSAAUTHARTPUBDETAILS, ' ') authar,NVL (B.PSAINDSUPEDUCONFDETAILS, ' ') indusdetails,NVL (B.PSAGIFTCOMPENDETAILS, ' ') giftcomp, " +
                    " NVL (B.PSAOTHERINDUSTRYDETAILS, ' ') otherdetail FROM AP#PSAINDUSTRIALDETAILS b" +
                    " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' and B.TRANSACTIONdate=to_date('" + transdate + "','dd-mm-yyyy')";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\"department\":\"" + rs.getString("department") + "\",");
                sb.append("\"transdate\":\"" + rs.getString("transdate") + "\",");
                sb.append("\"rnd\":\"" + rs.getString("rnd") + "\",");
                sb.append("\"fellowdeatails\":\"" + rs.getString("fellowdeatails") + "\",");
                sb.append("\"collaborative\":\"" + rs.getString("collaborative") + "\",");
                sb.append("\"authar\":\"" + rs.getString("authar") + "\",");
                sb.append("\"indusdetails\":\"" + rs.getString("indusdetails") + "\",");
                sb.append("\"giftcomp\":\"" + rs.getString("giftcomp") + "\",");
                sb.append("\"otherdetail\":\"" + rs.getString("otherdetail") + "\",");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }

    @GET
    @Path("/GuestLect")
    @Produces(MediaType.APPLICATION_JSON)
    public String getGuestLect(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid, @QueryParam("transdate") String transdate) throws SQLException {
        try {
            qry = "SELECT NVL(B.PSAGUSETLECTURENAME,'  ') guestname,nvl(B.PSAGUESTLECTURETOPIC,'  ') Topic ," +
                    "nvl(to_char(B.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(B.PSAENDDATE,'dd-Mon-yyyy'),' ') durationdates ," +
                    "nvl(B.PSANOOFPARTICIPANTS,0) participant FROM AP#PSAINDGLECTUREDETAILS b " +
                    "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' " +
                    "and B.TRANSACTIONdate=to_date('" + transdate + "','dd-mm-yyyy')";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("{\"guestname\":\"" + rs.getString("guestname") + "\",");
                sb.append("\"Topic\":\"" + rs.getString("Topic") + "\",");
                sb.append("\"durationdates\":\"" + rs.getString("durationdates") + "\",");
                sb.append("\"participant\":\"" + rs.getString("participant") + "\"},");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "[" + sb.toString().substring(0, sb.length() - 1) + "]";

    }

    @GET
    @Path("/IndusVisits")
    @Produces(MediaType.APPLICATION_JSON)
    public String getIndusVisits(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid, @QueryParam("transdate") String transdate) throws SQLException {
        try {
            qry = "SELECT   nvl(b.PSAINDUSTRIALVISITNAME,' ') indusname, nvl(b.PSAINDTOURDETAILS,' ') tourdetails, " +
                    "nvl(to_char(B.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(B.PSAENDDATE,'dd-Mon-yyyy'),' ') durationdates," +
                    "nvl(b.PSANOOFPARTICIPANTS,0) participant FROM AP#PSAINDVISITTOURDETAILS b " +
                    "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' " +
                    "and B.TRANSACTIONdate=to_date('" + transdate + "','dd-mm-yyyy')";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("{\"indusname\":\"" + rs.getString("indusname") + "\",");
                sb.append("\"tourdetails\":\"" + rs.getString("tourdetails") + "\",");
                sb.append("\"durationdates\":\"" + rs.getString("durationdates") + "\",");
                sb.append("\"participant\":\"" + rs.getString("participant") + "\"},");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "[" + sb.toString().substring(0, sb.length() - 1) + "]";

    }
}