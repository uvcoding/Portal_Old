/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Iqac.Report;
import java.sql.ResultSet;
import java.sql.SQLException;
import tietwebkiosk.*;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
/**
 *
 * @author Gyanendra.Bhatt
 */
@Path("/IndusInterReport")
 public class IndustrialInteractionsReport {
  DBHandler db = new DBHandler();
  StringBuilder sb = new StringBuilder();
  StringBuilder guestLec = new StringBuilder();
  StringBuilder indusVisit = new StringBuilder();
  StringBuilder ledTrain = new StringBuilder();
  String qry,qry1,qry2,qry3;
  ResultSet rs = null,rs1=null,rs2=null,rs3=null;
  int k=0,i=0,j=0;

  @GET
    @Path("/company")
    @Produces(MediaType.APPLICATION_JSON)
    public String getCompany() throws SQLException {
   // Map hm  = new HashMap();
        qry = " select distinct nvl(A.COMPANYCODE,' ') COMPANYCODE,nvl(A.COMPANYNAME,' ') COMPANYNAME  " +
               " from companymaster a,COMPANYINSTITUTETAGGING b where nvl(a.deactive,'N')='N' and a.companycode=b.companycode " +
               " and nvl(b.deactive,'N')='N'";

        rs = db.getRowset(qry);
        while (rs.next()) {
            //hm.put(rs.getString("COMPANYCODE") , rs.getString("COMPANYNAME"));
            sb.append("\"" + rs.getString("COMPANYCODE") + "\":\"" + rs.getString("COMPANYNAME") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }



    @GET
    @Path("{company}")
    @Produces(MediaType.APPLICATION_JSON)
    public String getInstitute(@PathParam("company") String company) throws SQLException {
        try {
            qry = "select distinct nvl(A.INSTITUTECODE,' ') INSTITUTECODE,nvl(A.INSTITUTENAME,' ') INSTITUTENAME from " +
                    "institutemaster a,COMPANYINSTITUTETAGGING b where b.companycode='"+company+"'   AND a.institutecode = b.institutecode";
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
        qry = "select distinct  nvl(to_char(B.TRANSACTIONdate,'dd-mm-yyyy'),'') transdate ,nvl(B.TRANSACTIONID,' ') TRANSACTIONID  from  AP#PSAINDUSTRIALDETAILS b " +
                "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' order by transdate";
        rs = db.getRowset(qry);
        while (rs.next()) {
sb.append("\"" + rs.getString("TRANSACTIONID") + "\":\"" + rs.getString("transdate") + "\",");
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";
    }

    @GET
    @Path("/Department")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartment(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid) throws SQLException {
        try {
            qry = " SELECT (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                  " nvl(departmentcode,'') departmentcode FROM AP#PSAINDUSTRIALDETAILS b" +
                  " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' ";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }

    @GET
    @Path("/Departmentforconf")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforConf(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM Ap#psaconferencedetails b where b.companyid='"+company+"' and B.INSTITUTEID='"+institute+"'  ";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }

    @GET
    @Path("/DepartmentforProjects")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforProject(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM Ap#projectmaster b where b.companyid='"+company+"'   ";
            // System.out.println(qry);

                            sb.append("\"ALL\":\"ALL\",");

            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }


    @GET
    @Path("/DepartmentforProjectsPhd")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforProjectPhD(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM Ap#projectmasterphd b where b.companyid='"+company+"'   ";
            // System.out.println(qry);

                            sb.append("\"ALL\":\"ALL\",");

            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }



     @GET
    @Path("/DepartmentforBooks")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforBooks(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM Ap#bookdetail b where b.companyid='"+company+"'   ";
            // System.out.println(qry);

                            sb.append("\"ALL\":\"ALL\",");

            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }

      @GET
    @Path("/DepartmentforInterdis")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforInterdis(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM ap#interdispdetail b where b.companyid='"+company+"'   ";
            // System.out.println(qry);

                            sb.append("\"ALL\":\"ALL\",");

            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }


            @GET
    @Path("/DepartmentforAward")
    @Produces(MediaType.APPLICATION_JSON)
    public String getDepartmentforAward(@QueryParam("company") String company, @QueryParam("institute") String institute) throws SQLException {
        try {
            qry = " SELECT distinct (SELECT a.department  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    " nvl(departmentcode,'') departmentcode FROM ap#awdachdetail b where b.companyid='"+company+"'   ";
            // System.out.println(qry);

                            sb.append("\"ALL\":\"ALL\",");

            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("departmentcode")+"\":\"" + rs.getString("department") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }




    
  @GET
    @Path("/ProjectReportPhD")
 //   @Produces(MediaType.)
    public String getProjectReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("department") String department) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
            int p=0;
            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

           department=department.equals("ALL")?"":"departmentcode='"+department+"' and ";

             qry=" SELECT DISTINCT (SELECT department FROM departmentmaster WHERE departmentcode = a.departmentcode) department, (SELECT nvl(studentname,'')  studentname FROM studentmaster WHERE studentid =a.studentid AND" +
                     " "+department+" companyid = '"+company+"') studentname,nvl(PROJECTTITLE,'') PROJECTTITLE,nvl(PROJECTLEVEL,'') PROJECTLEVEL," +
                     "(SELECT employeename FROM v#staff WHERE employeeid = a.staffid ) employeename," +
                     "nvl(a.academicyear,'') academicyear,nvl(PROJECTSTATUS,'') PROJECTSTATUS,nvl(APISCORE,'') APISCORE FROM ap#projectmasterphd a WHERE" +
                     " "+department+" companyid = '"+company+"'  order by department asc ";
             rs=db.getRowset(qry);
             rs1=db.getRowset(qry);
             if(rs.next())
             {
                 department=department.equals("")?"ALL":(rs.getString("department")==null?"":rs.getString("department").trim());

                 sb.append("<br><div style='width: 80%; padding: 10px ;border: .2em solid;margin-left:8%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >QA-AR-Form 3<br>Frequency: Every Year<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Master and Ph.D. Degrees</u><br><br></font></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;' ><font size='2' > Name of the Department  : "+department+"<br></font></td></tr>");
                sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th>"+(department.equals("ALL")?"<th nowrap align='left'><font size='2' >Department</font></th>":"")+"<th nowrap align='left'><font size='2' >Title of Project/<br>Dissertation/Thesis</font></th><th nowrap align='left'><font size='2' >Student's Name</font></th><th nowrap align='left'><font size='2' >Level:<br>(Master/Ph.D.)</font></th><th nowrap align='left'><font size='2' >Supervisor(s) name(s)</font></th><th nowrap align='left'><font size='2' >Acad. <br> Year</font></th><th nowrap align='left'><font size='2' >Completed/On-going</font></th><th nowrap align='left'><font size='2' >API Score(*)</font></th></tr>");


           while(rs1.next())
           {p++;
                sb.append("<tr width='20%'><td nowrap align='left'><font size='2' >"+p+"</font></td>"+(department.equals("ALL")?"<td nowrap align='left'><font size='2' >"+(rs1.getString("department")==null?"":rs1.getString("department").trim())+"</font></td>":"")+"<td nowrap align='left'><font size='2' >"+(rs1.getString("PROJECTTITLE")==null?"":rs1.getString("PROJECTTITLE").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("studentname")==null?"":rs1.getString("studentname").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("PROJECTLEVEL")==null?"":(rs1.getString("PROJECTLEVEL").equals("M")?"Master":"Ph.D."))+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("employeename")==null?"":rs1.getString("employeename").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("academicyear")==null?"":rs1.getString("academicyear"))+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("projectstatus").equals("O")?"On-going":"Completed")+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("apiscore")==null?0:rs1.getString("apiscore"))+"</font></td></tr>");

           //totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
          sb.append("</table><br><br>");

 sb.append("<font size='2'>(*)<br>(i) 5/M.Tech degree awarded <br>(ii) 10/Ph.D. degree awarded <br>(iii) 7/Ph.D. thesis submitted <br>(iv) 3/On going Ph.D. thesis of more than 6");
 sb.append("<font size='2'>months duration <br>(v) In case of Joint guidance,points to be shared as in the case of jointly authored books.(Form 7 )<br>");

 sb.append("<br><br><br><br><br><font size='2' ><b>(Name and Signature)<b></font>");


 sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }




    @GET
    @Path("/BookReport")
 //   @Produces(MediaType.)
    public String getBookReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("department") String department,@QueryParam("startdate") String startdate,@QueryParam("enddate") String enddate) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
            int p=0;
            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

           department=department.equals("ALL")?"":"and b.departmentcode='"+department+"'  ";

             qry=" select distinct nvl((select department from departmentmaster where departmentcode=b.departmentcode),'') department," +
                     "nvl((select employeename from v#staff where employeeid=b.staffid)||(select studentname from studentmaster where studentid=b.staffid),'') employeename," +
                     "nvl(a.booktitle1||' '||a.booktitl2,'') title,nvl(a.bookchaptername,'') chapter ," +
                     "nvl(a.apiscore,'') apiscore,nvl(a.BOOKNATURE,'') casestudies from ap#bookmaster a,ap#bookdetail b " +
                     "where a.companyid=b.companyid and a.bookid=b.bookid  "+department+" order by department ";
             rs=db.getRowset(qry);
             rs1=db.getRowset(qry);
             if(rs.next())
             {
                 department=department.equals("")?"ALL":(rs.getString("department")==null?"":rs.getString("department").trim());

                 sb.append("<br><div style='width: 80%; padding: 10px ;border: .2em solid;margin-left:8%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >QA-AR-Form 7<br>Frequency: Every Year<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Summary of Review articles and Books in Devloping areas</u><br><br></font></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;' ><font size='2' > Name of the Department  : "+department+"<br></font></td></tr>");
                sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th>"+(department.equals("ALL")?"<th nowrap align='left'><font size='2' >Department</font></th>":"")+"<th nowrap align='left'><font size='2' >Faculty Name</font></th><th nowrap align='left'><font size='2' >Books<br>(with complete details)</font></th><th nowrap align='left'><font size='2' >Book Chapters</font></th><th nowrap align='left'><font size='2' >Articles/case studies</font></th><th nowrap align='left'><font size='2' >API Score</font></th></tr>");


           while(rs1.next())
           {p++;
                sb.append("<tr width='20%'><td nowrap align='left'><font size='2' >"+p+"</font></td>"+(department.equals("ALL")?"<td nowrap align='left'><font size='2' >"+(rs1.getString("department")==null?"":rs1.getString("department").trim())+"</font></td>":"")+"<td nowrap align='left'><font size='2' >"+(rs1.getString("employeename")==null?"":rs1.getString("employeename").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("title")==null?"":rs1.getString("title").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("chapter")==null?"":rs1.getString("chapter"))+"</font></td><td nowrap align='left'><font size='2' > "+(rs1.getString("casestudies")==null?"":(rs1.getString("casestudies").equals("T")?"Theory":"Practical"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("apiscore")==null?0:rs1.getString("apiscore"))+"</font></td></tr>");

           //totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
          sb.append("</table>(*)API Score<br><br>");

 sb.append("<font size='2'>(i) Books Published by International Publisher after Peer Review:50 per book <br>(ii) Published by National Publisher with ISBN/ISSN number ;25 per book<br>(iii) Published by Local Publisher with ISBN/ISSN number: 15 per book <br>(iv) Chapter in any of the above categories :20% of the category per chapter<br><br>in case of jointly authored books:<br><br>&nbsp;&nbsp;&nbsp;(a) Two Authors 60% to First/Principal Author and remaining 40% to the other author.<br>&nbsp;&nbsp;&nbsp;(b) More than Two Authors -40% to First/Principal Author and remaining 60% to be shared equally amoung all the other authors.</font><br>");
 sb.append("<br><br><br><br><br><font size='2' ><b>(Name and Signature)<b></font>");


 sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }





 @GET
    @Path("/InterdisReport")
 //   @Produces(MediaType.)
    public String getInterdisReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("department") String department,@QueryParam("startdate") String startdate,@QueryParam("enddate") String enddate) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
            int p=0;
            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

           department=department.equals("ALL")?"":"and b.departmentcode='"+department+"'  ";

             qry=" select distinct nvl((select department from departmentmaster where departmentcode=b.departmentcode),'') department," +
                     "nvl((select employeename from v#staff where employeeid=b.staffid),'') employeename ,nvl(a.detailsofworkdone,'')," +
                     " detailsofworkdone,nvl(b.role,'') roleofthecollaborator  from ap#interdispheader a,ap#interdispdetail b where" +
                     " a.companyid=b.companyid and a.transactionid=b.transactionid and a.departmentcode=b.departmentcode "+department+" ";
             rs=db.getRowset(qry);
             rs1=db.getRowset(qry);
             if(rs.next())
             {
                 department=department.equals("")?"ALL":(rs.getString("department")==null?"":rs.getString("department").trim());

                sb.append("<br><div style='width: 90%; padding: 10px ;border: .2em solid;margin-left:5%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >QA-AR-Form 8<br>Frequency: Every Year<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Interdisciplinary Research</u><br><br></font></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;' ><font size='2' > Name of the Department  : "+department+"<br></font></td></tr>");
                sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th>"+(department.equals("ALL")?"<th nowrap align='left'><font size='2' >Department</font></th>":"")+"<th nowrap align='left'><font size='2' >Name of Faculty</font></th><th nowrap align='left'><font size='2' >Details of work done<br>(Thesis/Dissertation/supervised;research paper published)</font></th><th nowrap align='left'><font size='2' >Role of the <br>Collaborator(Co-sup. or Co-author)</font></th></tr>");


           while(rs1.next())
           {p++;
                sb.append("<tr width='20%'><td nowrap align='left'><font size='2' >"+p+"</font></td>"+(department.equals("ALL")?"<td nowrap align='left'><font size='2' >"+(rs1.getString("department")==null?"":rs1.getString("department").trim())+"</font></td>":"")+"<td nowrap align='left'><font size='2' >"+(rs1.getString("employeename")==null?"":rs1.getString("employeename").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("detailsofworkdone")==null?"":rs1.getString("detailsofworkdone").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("roleofthecollaborator")==null?"":(rs1.getString("roleofthecollaborator").equals("A")?"Co-Author":(rs1.getString("roleofthecollaborator").equals("C")?"Collaborator":"Co-Supervisor")))+"</font></td></tr>");

           //totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
          sb.append("</table><br><br>");

 //sb.append("<font size='2'>(i)Books Published by International Publisher after Peer Review:50 per book (ii)Published by National Publisher with ISBN/ISSN number ;25 per book<br>(iii) Published by Local Publisher with ISBN/ISSN number: 15 per book (iv) Chapter in any of the above categories :20% of the category per chapter<br><br>in case of jointly authored books:<br><br>&nbsp;&nbsp;&nbsp;(a)Two Authors 60% to First/Principal Author and remaining 40% to the other author.<br>&nbsp;&nbsp;&nbsp;(b)More than Two Authors -40% to First/Principal Author and remaining 60% to be shared equally amoung all the other authors.</font><br>");
 sb.append("<br><br><br><br><br><font size='2' ><b>(Name and Signature)<b></font>");


 sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }


 @GET
    @Path("/AwardReport")
 //   @Produces(MediaType.)
    public String getAwardReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("department") String department,@QueryParam("startdate") String startdate,@QueryParam("enddate") String enddate) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
            int p=0;
            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

           department=department.equals("ALL")?"":"and b.departmentcode='"+department+"'  ";

             qry=" select distinct nvl((select department from departmentmaster where departmentcode=b.departmentcode),'') department," +
                     "nvl((select employeename from v#staff where employeeid=b.staffid  and b.stafftype='E')||" +
                     "(SELECT studentname  FROM studentmaster   WHERE studentid = b.staffid and b.stafftype='S') ,'') employeename," +
                     "nvl(a.awdacheventname||','||awdachorgbody||','||to_char(a.transactiondate,'dd-mon-yyyy')||','||awdachvenue ||' and '||awdachtitle,'') middata," +
                     "nvl(a.awdachtype,'') nature,nvl(a.awdachremarks,'') awdachremarks," +
                     "nvl(a.awdachsrank,'') AllIndiaRank  from ap#awdachmaster a,ap#awdachdetail b where a.awdachid=b.awdachid  and a.companyid=b.COMPANYID " +
                     " "+department+" order by department ";
             rs=db.getRowset(qry);
             rs1=db.getRowset(qry);
             if(rs.next())
             {
                 department=department.equals("")?"ALL":(rs.getString("department")==null?"":rs.getString("department").trim());

                sb.append("<br><div style='width: 90%; padding: 10px ;border: .2em solid;margin-left:5%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >QA-AR-Form 5<br>Frequency: Every Year<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Awards & Achievements</u><br><br></font></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;' ><font size='2' > Name of the Department  : "+department+"<br></font></td></tr>");
                sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th>"+(department.equals("ALL")?"<th nowrap align='left'><font size='2' >Department</font></th>":"")+"<th nowrap align='left'><font size='2' >Name of Faculty/Students</font></th><th nowrap align='left'><font size='2' >Details of the award<br>(Event,Organizing body,date,venue and Title of Award)</font></th><th nowrap align='left'><font size='2' >Nature of the award</font></th><th nowrap align='left'><font size='2' >Remarks on the Quality of Event</font></th><th nowrap align='left'><font size='2' >Rank/Position</font></th></tr>");


           while(rs1.next())
           {p++;
                sb.append("<tr width='20%'><td nowrap align='left'><font size='2' >"+p+"</font></td>"+(department.equals("ALL")?"<td nowrap align='left'><font size='2' >"+(rs1.getString("department")==null?"":rs1.getString("department").trim())+"</font></td>":"")+"<td nowrap align='left'><font size='2' >"+(rs1.getString("employeename")==null?"":rs1.getString("employeename").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("middata")==null?"":rs1.getString("middata").trim())+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("nature")==null?"":(rs1.getString("nature").equals("N")?"National":"International"))+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("awdachremarks")==null?"":rs1.getString("awdachremarks"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("AllIndiaRank")==null?"":rs1.getString("AllIndiaRank"))+"</font></td></tr>");

           //totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
          sb.append("</table><br><br>");

 //sb.append("<font size='2'>(i)Books Published by International Publisher after Peer Review:50 per book (ii)Published by National Publisher with ISBN/ISSN number ;25 per book<br>(iii) Published by Local Publisher with ISBN/ISSN number: 15 per book (iv) Chapter in any of the above categories :20% of the category per chapter<br><br>in case of jointly authored books:<br><br>&nbsp;&nbsp;&nbsp;(a)Two Authors 60% to First/Principal Author and remaining 40% to the other author.<br>&nbsp;&nbsp;&nbsp;(b)More than Two Authors -40% to First/Principal Author and remaining 60% to be shared equally amoung all the other authors.</font><br>");
 sb.append("<br><br><br><br><br><font size='2' ><b>(Name and Signature)<b></font>");


 sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }





    @GET
    @Path("/ProjectReport")
 //   @Produces(MediaType.)
    public String getProjectReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("department") String department,@QueryParam("startdate") String startdate,@QueryParam("enddate") String enddate) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
            int p=0;
            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

           department=department.equals("ALL")?"":"departmentcode='"+department+"' and ";

             qry=" SELECT (SELECT department FROM departmentmaster WHERE departmentcode = a.departmentcode) department," +
                     " nvl(a.projecttitle,'') projecttitle,nvl(a.projectauthority,'') projectauthority,nvl(a.projectcost,0) projectcost," +
                     "nvl(to_char(a.projectstartdate,'dd-mon-yyyy'),'') startdate,nvl(to_char(a.projectenddate,'dd-mon-yyyy'),'') enddate,nvl(projectstatus,'') projectstatus," +
                     "nvl(a.PROJECTPERSTATUS,'') PROJECTPERSTATUS,nvl(a.apiscore,'') apiscore from ap#projectmaster a  where "+department+" " +
                     " companyid='"+company+"' and projectstartdate between to_date('"+startdate+"','dd-mm-yyyy') and" +
                     "  to_date('"+enddate+"','dd-mm-yyyy') order by department asc ";
             rs=db.getRowset(qry);
             rs1=db.getRowset(qry);
             if(rs.next())
             {
                 department=department.equals("")?"ALL":(rs.getString("department")==null?"":rs.getString("department").trim());
                
                 sb.append("<br><div style='width: 99%; padding: 10px ;border: .2em solid;margin-left:0%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%' >");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >QA-AR-Form 2<br>Frequency: Every Year<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Academic(Research)<br>Sponsored R&D Projects</u><br><br></font></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;' ><font size='2' > Name of the Department  : "+department+"<br></font></td></tr>");
                sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th>"+(department.equals("ALL")?"<th nowrap align='left'><font size='2' >Department</font></th>":"")+"<th nowrap align='left'><font size='2' >Title of Project</font></th><th nowrap align='left'><font size='2' >Principal Investigator/<br>Co-Investigator</font></th><th nowrap align='left'><font size='2' >Cost of the project (in INR)</font></th><th nowrap align='left'><font size='2' >Duration</font></th><th nowrap align='left'><font size='2' >Completed/On-going</font></th><th nowrap align='left'><font size='2' >% of work left</font></th><th nowrap align='left'><font size='2' >API Score(*)</font></th></tr>");


           while(rs1.next())
           {p++;
                sb.append("<tr width='20%'><td nowrap align='left'><font size='2' >"+p+"</font></td>"+(department.equals("ALL")?"<td nowrap align='left'><font size='2' >"+(rs1.getString("department")==null?"":rs1.getString("department").trim())+"</font></td>":"")+"<td nowrap align='left'><font size='2' >"+(rs1.getString("projecttitle")==null?"":rs1.getString("projecttitle").trim())+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("projectauthority")==null?"":rs1.getString("projectauthority").trim())+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("projectcost")==null?"":rs1.getString("projectcost"))+"</font></td><td nowrap align='left'><font size='2' >From "+(rs1.getString("startdate")==null?"":rs1.getString("startdate"))+" to "+(rs1.getString("enddate")==null?"":rs1.getString("enddate"))+"</font></td><td nowrap align='left'><font size='2' >"+(rs1.getString("projectstatus").equals("O")?"On-going":"Completed")+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("PROJECTPERSTATUS")==null?"":(100-Integer.parseInt(rs1.getString("PROJECTPERSTATUS"))))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("apiscore")==null?0:rs1.getString("apiscore"))+"</font></td></tr>");

           //totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
          sb.append("</table>(*)<br><br>");

 sb.append("<font size='2'>(a)&nbsp;20 API points for each Sponsored Research Projects with grants of Rs. 10 lakhs or more: Rs . 3lakhs in case of HSS & Management.<br>");
 sb.append("(b)&nbsp;15 API points for each Sponsored Research Projects with grants  between Rs.4 to 10 lakhs,Rs. 1 to 3 lakhs in case of HSS & Management.<br>");
 sb.append("(c)&nbsp;10 API points for each Sponsored Research Projects with grants between Rs.0.5 to 4 lakhs,Rs. 0.25 to 1 lakhs in case of HSS & Management.<br>");
 sb.append("(d)&nbsp;For Consultancy Projects apply (a),(b) & (c) above with amount and API points reduced to 50% level.<br>");
 sb.append("(e)&nbsp;In case of Joint projects API points will be shared as in case of jointly authored books(see form 7).<br>");
 sb.append("<br><br><br><br><br><font size='2' ><b>(Name and Signature)<b></font>");


 sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }






     @GET
    @Path("/conference")
    @Produces(MediaType.APPLICATION_JSON)
    public String getConference(@QueryParam("company") String company, @QueryParam("institute") String institute,@QueryParam("department") String department) throws SQLException {
        try {
            qry = " select nvl(conferenceid,'') conferenceid,nvl(conferencename,'') conferencename from Ap#psaconferencedetails where " +
                    "departmentcode='"+department+"' and instituteid='"+institute+"' and companyid='"+company+"' order by conferencename";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("conferenceid")+"\":\"" + rs.getString("conferencename") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }




    @GET
    @Path("/budgetid")
    @Produces(MediaType.APPLICATION_JSON)
    public String getConferenceBudget(@QueryParam("company") String company, @QueryParam("institute") String institute,@QueryParam("department") String department,@QueryParam("conference") String conference) throws SQLException {
        try {
            qry = "select nvl(budgetid,'') budgetid from ap#psaconferencebudget where " +
                    "departmentcode='"+department+"' and instituteid='"+institute+"' and companyid='"+company+"' and CONFERENCEID='"+conference+"'  order by budgetid";
            // System.out.println(qry);
            rs = db.getRowset(qry);
            while (rs.next()) {
                sb.append("\""+rs.getString("budgetid")+"\":\"" + rs.getString("budgetid") + "\",");
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{" + sb.toString().substring(0, sb.length() - 1) + "}";

    }



    @GET
    @Path("/rnd")
   // @Produces(MediaType.APPLICATION_JSON)
    public String getRnDLab(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid,@QueryParam("dept") String department) throws SQLException {
        try {
            qry = "SELECT nvl(PSARANDDLABDETAILS,' ') rndlab ,nvl(PSASCHOLARFELLOWDETAILS,' ') PSASCHOLARFELLOWDETAILS  FROM AP#PSAINDUSTRIALDETAILS b" +
                    " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "'" +
                    " and b.departmentcode='"+department+"' ";
            // System.out.println(qry);
            rs = db.getRowset(qry);
           if (rs.next()) {
                sb.append( rs.getString("rndlab")+"@"+rs.getString("PSASCHOLARFELLOWDETAILS"));
              }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString();

    }












    @GET
    @Path("/conferencereport")
 //   @Produces(MediaType.)
    public String getconferenceReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("conference") String conference, @QueryParam("department") String department) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
              qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }



             qry="SELECT nvl(a.COMPANYID,' ') COMPANYID, nvl(a.INSTITUTEID,' ') INSTITUTEID, " +
                     "(select nvl(department,' ') department from departmentmaster where departmentcode=a.DEPARTMENTCODE) department," +
                     " nvl(a.CONFERENCEID,' ') CONFERENCEID, nvl(a.CONFERENCETYPE,' ') CONFERENCETYPE,nvl(a.CONFERENCENAME,'') CONFERENCENAME , " +
                     "nvl(a.SPECIFICFOCUSAREA,'') SPECIFICFOCUSAREA,nvl(a.OBJECTIVES,' ') OBJECTIVES,nvl(a.PROPOSEDOUTCOMES,' ') PROPOSEDOUTCOMES,  " +
                     "  nvl(a.PROPOSEDBUDGET,'0') PROPOSEDBUDGET,nvl(a.SUPPORTORGNAME,' ') SUPPORTORGNAME,nvl(a.SUPPORTORGBUDGET,'') SUPPORTORGBUDGET," +
                     "   nvl(to_char(a.CONFERENCESTARTDATE,'dd-mm-yyyy'),' ') CONFERENCESTARTDATE, nvl(to_char(a.CONFERENCEENDDATE,'dd-mm-yyyy'),' ') CONFERENCEENDDATE," +
                     " nvl(a.PARTICIPANTSNO,'0') PARTICIPANTSNO,nvl(a.PAPERSNO,'0') PAPERSNO,nvl(a.KEYNOTESPEAKERSNO,'0') KEYNOTESPEAKERSNO," +
                     "nvl(a.KEYNOTESPEAKERSNAMES,' ') KEYNOTESPEAKERSNAMES,nvl(a.INVITEDSPEAKERSNO,'0') INVITEDSPEAKERSNO,nvl(a.INVITEDSPEAKERSNAMES,' ') INVITEDSPEAKERSNAMES," +
                     " nvl(a.PARALLELSESSIONNO,'0') PARALLELSESSIONNO, nvl(a.TUTORIALWITHCONFERENCE,' ') TUTORIALWITHCONFERENCE,nvl(a.ANNUALEVENT,' ') ANNUALEVENT,nvl(a.GAINAREA,'') GAINAREA, nvl(a.OTHERREMARKS,'') OTHERREMARKS,nvl(a.ORGANIZINGSECRETARYNAME,'') ORGANIZINGSECRETARYNAME," +
                     " nvl(a.HODAPPROVAL,'') HODAPPROVAL,nvl(a.VCAPPROVAL,'') VCAPPROVAL,nvl(a.ENTRYBY,' ') ENTRYBY,nvl(to_char(a.ENTRYDATE,'dd-mm-yyyy'),' ') ENTRYDATE FROM AP#PSACONFERENCEDETAILS a where" +
                     " companyID='"+company+"' and instituteid='"+institute+"' and departmentcode='"+department+"' and  conferenceid='"+conference+"' ";
             rs=db.getRowset(qry);
             if(rs.next())
             {
                sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%'>");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >Form:QA-PSA-3A<br>Frequency-Annually in July<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Performa for Approval of Conference</u><br><br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >1. Department Name : "+rs.getString("department")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >2. Name of Proposed Conference : "+rs.getString("CONFERENCENAME")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'><font size='2' >3. Type-National or International ? : "+rs.getString("CONFERENCETYPE")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >4. Specific Focus Area : "+rs.getString("SPECIFICFOCUSAREA")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >5. Objectives : ( "+rs.getString("OBJECTIVES")+" ) </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >6. Proposed Outcomes : "+rs.getString("PROPOSEDOUTCOMES")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >7. Proposed Budget(Please submit detailed budget sheet also) : "+rs.getString("PROPOSEDBUDGET")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >8. Any other organization likely to support(Please specify the organization name and expected support) :"+rs.getString("SUPPORTORGNAME")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >9. <u>Conference Details-</u></font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >a. No. of Days and dates(suggested)- "+rs.getString("CONFERENCESTARTDATE")+" to "+rs.getString("CONFERENCEENDDATE")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >b. No. of participants expected-  "+rs.getString("PARTICIPANTSNO")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >c. No. of Papers expected- "+rs.getString("PAPERSNO")+"</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >b. No. and Names of Keynote Speakers(if finalized?) -"+rs.getString("KEYNOTESPEAKERSNO")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >e. No. and Names of Invited Speakers(if finalized?) - "+rs.getString("INVITEDSPEAKERSNO")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >f. No. of Parallel session expected - "+rs.getString("PARALLELSESSIONNO")+" </font><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >g. Any tutorials planned along with the conference(Please give details) - "+rs.getString("TUTORIALWITHCONFERENCE")+"</font><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >10. If this is annual event i.e. organized every year then please furnish details of 9 above for previous year :"+rs.getString("ANNUALEVENT")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >11. Likely gain to the institute(e.g.-research,new courses planned etc.) :"+rs.getString("GAINAREA")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Signature and name of Organizing Secretary</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Recommendation of HOD/Director</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Approved/Not Approved Vice Chancellor</font></td></tr>");

                sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }

 @GET
     @Path("/conferencefeedbackreport")
 //   @Produces(MediaType.)
    public String getconferencefeedbackReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("conference") String conference, @QueryParam("department") String department,@QueryParam("budgetid") String budgetid) throws SQLException {
        try {String qry1="",cdate="",due="",profit_loss="",proposedOutcome="",participantno="",peperno="",ans="";
        int totalRec=0,totalExp=0,diff=0,p=0,l=0;
            ResultSet rs1=null;
              qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }


              qry=" SELECT nvl(COMPANYID,' ') COMPANYID,nvl(INSTITUTEID,' ') INSTITUTEID," +
                     " (select nvl(a.department,' ') department from departmentmaster a where a.departmentcode='"+department+"') department," +
                     " nvl(CONFERENCEID,' ') CONFERENCEID,nvl(CONFERENCETYPE,' ') CONFERENCETYPE, nvl(CONFERENCENAME,' ') CONFERENCENAME, " +
                     " nvl(BUDGETID,' ') BUDGETID,nvl(KEYNOTESPEAKERSNO,'0') KEYNOTESPEAKERSNO,nvl(KEYNOTESPEAKERSNAMES,' ') KEYNOTESPEAKERSNAMES," +
                     "nvl(INVITEDSPEAKERSNO,'0') INVITEDSPEAKERSNO,nvl(INVITEDSPEAKERSNAMES,' ') INVITEDSPEAKERSNAMES," +
                     "nvl(SUPPORTORGNAME,' ') SUPPORTORGNAME,    nvl(SUPPORTORGBUDGET,'0') SUPPORTORGBUDGET,nvl(SPECIFICFOCUSAREA,'') SPECIFICFOCUSAREA,nvl(OBJECTIVES,'') OBJECTIVES," +
                     "nvl(to_char(CONFERENCESTARTDATE,'dd-Mon-yyyy')||' to '||to_char(CONFERENCEENDDATE,'dd-Mon-yyyy'),' ') durationdates ,  " +
                     " nvl(OTHERREMARKS,' ') OTHERREMARKS,nvl(ORGANIZINGSECRETARYNAME,' ') ORGANIZINGSECRETARYNAME,nvl(ACTUALOUTCOMES,'') ACTUALOUTCOMES," +
                     " nvl(HODAPPROVAL,' ') HODAPPROVAL,    nvl(VCAPPROVAL,' ') VCAPPROVAL,nvl(ENTRYBY,' ') ENTRYBY," +
                     " nvl(to_char(ENTRYDATE,'dd-mm-yyyy'),' ') ENTRYDATE FROM AP#PSACONFERENCEBUDGETACT " +
                     " where companyID='"+company+"' and instituteid='"+institute+"' and departmentcode='"+department+"' and  conferenceid='"+conference+"' and budgetid='"+budgetid+"'";
               rs=db.getRowset(qry);
             if(rs.next())
             {
                sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%'>");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >Form:QA-PSA-3C<br>Frequency-Annually in July<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Feedback on Conference</u><br><br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >1. Department Name : "+rs.getString("department")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >2. Name of the Conference : "+rs.getString("CONFERENCENAME")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'> <font size='2' >3. Exact dates : From "+rs.getString("durationdates")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'><font size='2' >4. Type-National or International ? : "+(rs.getString("CONFERENCETYPE").equals("I")?"International":"National")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >5. Specific Focus Area : "+rs.getString("SPECIFICFOCUSAREA")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >6. Objectives : "+rs.getString("OBJECTIVES")+"  </font></td></tr>");
               qry1="SELECT nvl(PROPOSEDOUTCOMES,'') PROPOSEDOUTCOMES,nvl(PARTICIPANTSNO,'') PARTICIPANTSNO,nvl(PAPERSNO,'') PAPERSNO   FROM " +
                       "AP#PSACONFERENCEDETAILS where COMPANYID='"+company+"' and INSTITUTEID='"+institute+"' and DEPARTMENTCODE='"+department+"' " +
                       "and CONFERENCEID='"+(rs.getString("CONFERENCEID")==null?"":rs.getString("CONFERENCEID").trim())+"'";
               rs1=db.getRowset(qry1);
               if(rs1.next())
               {
               proposedOutcome=rs1.getString("PROPOSEDOUTCOMES")==null?"":rs1.getString("PROPOSEDOUTCOMES").trim();
               participantno=rs1.getString("PARTICIPANTSNO")==null?"":rs1.getString("PARTICIPANTSNO").trim();
               peperno=rs1.getString("PAPERSNO")==null?"":rs1.getString("PAPERSNO").trim();
               }



                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >7.(a) Proposed Outcome  : "+proposedOutcome+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >7.(b) Actual Outcome :  "+rs.getString("ACTUALOUTCOMES")+"</font></td></tr>");
  sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >8.(a) Receipts :-  </font></td></tr>");
           qry1="SELECT   NVL (a.psarecexpid, '') psarecexpid,NVL (a.psarecexpcode, '') psarecexpcode," +
                   "NVL (a.psarecexpname, '') psarecexpname,NVL (a.aprecexptype, '') aprecexptype, " +
                   "NVL (b.recexpno, '') recexpno, NVL (b.recexprate, '') recexprate,NVL (b.recexpamount, '') recexpamount" +
                   " FROM ap#psarecexpmaster a, ap#psaconfrecexpactual b WHERE a.aprecexptype = 'R' AND a.deactive = 'N' AND" +
                   " a.aprecexptype = b.recexptype AND a.psarecexpcode = b.recexpcode and a.COMPANYID=b.COMPANYID ORDER BY a.psarecexpcode";
           rs1=db.getRowset(qry1);
           rs2=db.getRowset(qry1);
           if(rs2.next()){
                     sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th><th nowrap align='left'><font size='2' >Receipts Detail</font></th><th nowrap align='left'><font size='2' >Expected No.</font></th><th nowrap align='left'><font size='2' >Expected Rate</font></th><th nowrap align='left'><font size='2' >Amount</font></th></font></tr>");


           while(rs1.next())
           {p++;
           sb.append("<tr><td align='right'><font size='2' >"+p+"<td align='left' ><font size='2' >"+(rs1.getString("psarecexpname").equals("")?"":rs1.getString("psarecexpname"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPNO").equals("")?"":rs1.getString("RECEXPNO"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPRATE").equals("")?"":rs1.getString("RECEXPRATE"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"))+"</font></td></tr>");

           totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
           sb.append("<tr><td colspan='4' align='right'><font size='2'>Total (INR):</font> </td><td align='right'><font size='2'>"+totalRec+"/-</font></td></tr></table>");

           }
           p=0;

           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>(b). Expenditures :-  </font></td></tr>");
           qry1=" SELECT   NVL (a.psarecexpid, '') psarecexpid,NVL (a.psarecexpcode, '') psarecexpcode, " +
                " NVL (a.psarecexpname, '') psarecexpname,NVL (a.aprecexptype, '') aprecexptype, " +
                " NVL (b.recexpno, '') recexpno, NVL (b.recexprate, '') recexprate,NVL (b.recexpamount, '') recexpamount " +
                " FROM ap#psarecexpmaster a, ap#psaconfrecexpactual b WHERE a.aprecexptype = 'E' AND a.deactive = 'N' AND " +
                " a.aprecexptype = b.recexptype AND a.psarecexpcode = b.recexpcode and a.COMPANYID=b.COMPANYID ORDER BY a.psarecexpcode ";
           rs1=db.getRowset(qry1);
           rs2=db.getRowset(qry1);
           if(rs2.next()){
                     sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >Sl. No.</font></th><th nowrap align='left'><font size='2' >Expenditures Detail</font></th><th nowrap align='left'><font size='2' >Expected No.</font></th><th nowrap align='left'><font size='2' >Expected Rate</font></th><th nowrap align='left'><font size='2' >Amount</font></th></font></tr>");

           while(rs1.next())
           {p++;
           sb.append("<tr><td align='right'><font size='2' >"+p+"</td ><td align='left'><font size='2' >"+(rs1.getString("psarecexpname").equals("")?"":rs1.getString("psarecexpname"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPNO").equals("")?"":rs1.getString("RECEXPNO"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPRATE").equals("")?"":rs1.getString("RECEXPRATE"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"))+"</font></td></tr>");

           totalExp=totalExp+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
           sb.append("<tr><td colspan='4' align='right'><font size='2'>Total (INR):</font></td><td align='right'><font size='2'>"+totalExp+"/-</font></td></tr></table>");

           }
           diff=totalRec-totalExp;

           if(diff>0)
           {
           profit_loss="Profit";
           }else if(diff<0)
           {
           profit_loss="Loss";
           }else
           {
           profit_loss="Balanced";
           }

          // sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>7. Institute Support proposed :- "+rs.getString("SUPPORTORGNAME")+" </font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br> Expected profit/Loss to Institute :- Rs."+diff+"/- ("+profit_loss+")</font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>9. Analysis Summary :-</font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>- No. of registered Participants :"+participantno+"</font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>- No. of papers accepted :"+peperno+"</font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>- No. of papers presented:"+peperno+"</font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br><br>Please rate in the scale of 1 to 5 ,the following based on the feedback from participants,experts,volunteers and your own observations(1-lowest,5 heightest)<br></font></td></tr>");

           qry2="SELECT nvl(a.questionid,'') questionid,nvl(A.questionbody,'') questionbody,NVL(A.RATINGID,'') RATINGID ,nvl(b.subjective,'') subjective  FROM ap#facultyquestionmaster a ,ap#ratingmaster b " +
                   "WHERE  A.FEEDBACKID LIKE '%FEEDPSA00001%' AND A.COMPONENTTYPE='C' and a.feedbackid=b.feedbackid and   a.RATINGID=b.RATINGID ORDER BY a.SEQID  ";
               rs2=db.getRowset(qry2);
               while(rs2.next())
               {
                   if(rs2.getString("subjective").equals("Y")){
               qry3="SELECT nvl(APFEEDBACKUSERREMARKS,'') ans FROM ap#psafeedbackdetail where APFEEDBACKITEMID='"+rs2.getString("questionid")+"' and APFEEDBACKRATINGID='"+rs2.getString("RATINGID")+"'";
                rs3=db.getRowset(qry3);
                if(rs3.next())
                {
                ans=rs3.getString("ans")==null?"":rs3.getString("ans");
                }
                   }else  if(rs2.getString("subjective").equals("N")){
             qry3="SELECT nvl(APFEEDBACKRATING,'') ans FROM ap#psafeedbackdetail where APFEEDBACKITEMID='"+rs2.getString("questionid")+"' and APFEEDBACKRATINGID='"+rs2.getString("RATINGID")+"'";
            rs3=db.getRowset(qry3);
                if(rs3.next())
                {
                ans=rs3.getString("ans")==null?"":rs3.getString("ans");
                }
                   }
                   
               l++;
               sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>"+l+":"+(rs2.getString("questionbody").equals("")?"":rs2.getString("questionbody").trim())+" : "+(ans.equals("")?"":ans.trim())+(rs2.getString("subjective").trim().equals("Y")?"":"")+"</td></tr>");
               ans="";
               }





             sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Name and Signature of Coordinator</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><br><br><br><br><br><font size='2' >Comments and Recommendations of HOD/Director</font></td></tr>");
         sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Vice Chancellor</font></td></tr>");
                sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }






        }catch(Exception e)
        {
      e.printStackTrace();
        }
 return  sb.toString();
 }

     @GET
     @Path("/conferencebudgetreport")
 //   @Produces(MediaType.)
    public String getconferencebudgetReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("conference") String conference, @QueryParam("department") String department,@QueryParam("budgetid") String budgetid) throws SQLException {
        try {String qry1="",cdate="",due="",profit_loss="";
        int totalRec=0,totalExp=0,diff=0,p=0;
            ResultSet rs1=null;
              qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }



             qry="SELECT nvl(COMPANYID,' ') COMPANYID,nvl(INSTITUTEID,' ') INSTITUTEID," +
                     " (select nvl(a.department,' ') department from departmentmaster a where a.departmentcode='"+department+"') department," +
                     " nvl(CONFERENCEID,' ') CONFERENCEID,nvl(CONFERENCETYPE,' ') CONFERENCETYPE, nvl(CONFERENCENAME,' ') CONFERENCENAME, " +
                     " nvl(BUDGETID,' ') BUDGETID,nvl(KEYNOTESPEAKERSNO,'0') KEYNOTESPEAKERSNO,nvl(KEYNOTESPEAKERSNAMES,' ') KEYNOTESPEAKERSNAMES," +
                     "nvl(INVITEDSPEAKERSNO,'0') INVITEDSPEAKERSNO,nvl(INVITEDSPEAKERSNAMES,' ') INVITEDSPEAKERSNAMES," +
                     "nvl(SUPPORTORGNAME,' ') SUPPORTORGNAME,    nvl(SUPPORTORGBUDGET,'0') SUPPORTORGBUDGET," +
                     "nvl((to_date(CONFERENCEENDDATE,'dd-MM-yyyy')-to_date(CONFERENCESTARTDATE,'dd-MM-yyyy'))+1||' - ('||to_char(CONFERENCESTARTDATE,'dd-Mon-yyyy')||' to '||to_char(CONFERENCEENDDATE,'dd-Mon-yyyy')||')',' ') durationdates ,  " +
                     " nvl(OTHERREMARKS,' ') OTHERREMARKS,nvl(ORGANIZINGSECRETARYNAME,' ') ORGANIZINGSECRETARYNAME," +
                     " nvl(HODAPPROVAL,' ') HODAPPROVAL,    nvl(VCAPPROVAL,' ') VCAPPROVAL,nvl(ENTRYBY,' ') ENTRYBY," +
                     "nvl(to_char(ENTRYDATE,'dd-mm-yyyy'),' ') ENTRYDATE FROM AP#PSACONFERENCEBUDGET " +
                     " where companyID='"+company+"' and instituteid='"+institute+"' and departmentcode='"+department+"' and  conferenceid='"+conference+"' and budgetid='"+budgetid+"'";
             rs=db.getRowset(qry);
             if(rs.next())
             {
                sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%'>");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >Form:QA-PSA-3B<br>Frequency-Annually in July<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Budget Sheet for Proposed Conference</u><br><br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >1. Department Name : "+rs.getString("department")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >2. Name of Proposed Conference : "+rs.getString("CONFERENCENAME")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'> <font size='2' >3. No. of Days : "+rs.getString("durationdates")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >4. No. of invited guests(Keynote speakers,invited speakers,Session chairman etc.) : "+(Integer.parseInt(rs.getString("KEYNOTESPEAKERSNO"))+Integer.parseInt(rs.getString("INVITEDSPEAKERSNO")))+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >5. Receipts :-  </font></td></tr>");
           qry1="SELECT   NVL (a.psarecexpid, '') psarecexpid,NVL (a.psarecexpcode, '') psarecexpcode," +
                   "NVL (a.psarecexpname, '') psarecexpname,NVL (a.aprecexptype, '') aprecexptype, " +
                   "NVL (b.recexpno, '') recexpno, NVL (b.recexprate, '') recexprate,NVL (b.recexpamount, '') recexpamount" +
                   " FROM ap#psarecexpmaster a, ap#psaconfrecexp b WHERE a.aprecexptype = 'R' AND a.deactive = 'N' AND" +
                   " a.aprecexptype = b.recexptype AND a.psarecexpcode = b.recexpcode and a.COMPANYID=b.COMPANYID ORDER BY a.psarecexpcode";
           rs1=db.getRowset(qry1);
           rs2=db.getRowset(qry1);
           if(rs2.next()){
                     sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >S.No.</font></th><th nowrap align='left'><font size='2' >Receipts Detail</font></th><th nowrap align='left'><font size='2' >Expected No.</font></th><th nowrap align='left'><font size='2' >Expected Rate</font></th><th nowrap align='left'><font size='2' >Amount</font></th></font></tr>");

         
           while(rs1.next())
           {p++;
           sb.append("<tr><td align='right'><font size='2' >"+p+"<td align='left' ><font size='2' >"+(rs1.getString("psarecexpname").equals("")?"":rs1.getString("psarecexpname"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPNO").equals("")?"":rs1.getString("RECEXPNO"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPRATE").equals("")?"":rs1.getString("RECEXPRATE"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"))+"</font></td></tr>");
        
           totalRec=totalRec+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
           sb.append("<tr><td colspan='4' align='right'><font size='2'>Total (INR):</font> </td><td align='right'><font size='2'>"+totalRec+"/-</font></td></tr></table>");

           }
           p=0;
         
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>6. Expenditures :-  </font></td></tr>");
           qry1=" SELECT   NVL (a.psarecexpid, '') psarecexpid,NVL (a.psarecexpcode, '') psarecexpcode, " +
                " NVL (a.psarecexpname, '') psarecexpname,NVL (a.aprecexptype, '') aprecexptype, " +
                " NVL (b.recexpno, '') recexpno, NVL (b.recexprate, '') recexprate,NVL (b.recexpamount, '') recexpamount " +
                " FROM ap#psarecexpmaster a, ap#psaconfrecexp b WHERE a.aprecexptype = 'E' AND a.deactive = 'N' AND " +
                " a.aprecexptype = b.recexptype AND a.psarecexpcode = b.recexpcode and a.COMPANYID=b.COMPANYID ORDER BY a.psarecexpcode ";
           rs1=db.getRowset(qry1);
           rs2=db.getRowset(qry1);
           if(rs2.next()){
                     sb.append("<table border='2' rules='all' bordercolor='black'><tr width='20%'><th nowrap align='left'><font size='2' >Sl. No.</font></th><th nowrap align='left'><font size='2' >Expenditures Detail</font></th><th nowrap align='left'><font size='2' >Expected No.</font></th><th nowrap align='left'><font size='2' >Expected Rate</font></th><th nowrap align='left'><font size='2' >Amount</font></th></font></tr>");

           while(rs1.next())
           {p++;
           sb.append("<tr><td align='right'><font size='2' >"+p+"</td ><td align='left'><font size='2' >"+(rs1.getString("psarecexpname").equals("")?"":rs1.getString("psarecexpname"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPNO").equals("")?"":rs1.getString("RECEXPNO"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPRATE").equals("")?"":rs1.getString("RECEXPRATE"))+"</font></td><td nowrap align='right'><font size='2' >"+(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"))+"</font></td></tr>");

           totalExp=totalExp+Integer.parseInt(rs1.getString("RECEXPAMOUNT").equals("")?"":rs1.getString("RECEXPAMOUNT"));
           }
           sb.append("<tr><td colspan='4' align='right'><font size='2'>Total (INR):</font></td><td align='right'><font size='2'>"+totalExp+"/-</font></td></tr></table>");

           }
           diff=totalRec-totalExp;
           
           if(diff>0)
           {
           profit_loss="Profit";
           }else if(diff<0)
           {
           profit_loss="Loss";
           }else
           {
           profit_loss="Balanced";
           }

           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>7. Institute Support proposed :- "+rs.getString("SUPPORTORGNAME")+" </font></td></tr>");
           sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><br>8. Expected profit/Loss to Institute :- Rs."+diff+"/- ("+profit_loss+")</font></td></tr>");



//                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >a. Registration Fee : "+rs.getString("PROPOSEDOUTCOMES")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >- No. of expected registrations- "+rs.getString("PROPOSEDBUDGET")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >-Total Registration fee(expected) -"+rs.getString("SUPPORTORGNAME")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >b. External Financial Support-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >- Support from Govt. institutes(DST/DEITY etc.)- "+rs.getString("CONFERENCESTARTDATE")+" to "+rs.getString("CONFERENCEENDDATE")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Support from private organizatioons as sponsorship-  "+rs.getString("PARTICIPANTSNO")+" </font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Total External Support(Expected)- "+rs.getString("PAPERSNO")+"</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >c. Total Reciept(Expected) -"+rs.getString("KEYNOTESPEAKERSNO")+" </font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >6. Expenditures - "+rs.getString("INVITEDSPEAKERSNO")+" </font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >a. Expenditure on Registration Material - "+rs.getString("PARALLELSESSIONNO")+" </font><font size='2' nowrap> </td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >b. Remuneration and Travel reimbbursement for External Experts - "+rs.getString("TUTORIALWITHCONFERENCE")+"</font><font size='2' nowrap> </td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >c. Total participants including internal faculty :"+rs.getString("ANNUALEVENT")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >d. Expenditure on lunch,Tea snacks :"+rs.getString("GAINAREA")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >e. Expenditure on Conference dinner if hosted by the Institute  :"+rs.getString("GAINAREA")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- No. of Guests-  :"+rs.getString("GAINAREA")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Likely expenditure- :"+rs.getString("GAINAREA")+"</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >f. Expenditure on Invited Guests</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Lodging/Boarding-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Transportation(Local)-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Other facilitation-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >g. Expenditure on Souvenirs-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- No.-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Expenditure-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >h. Expenditure on conference proceedings</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Printing of proceedings</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' > . No.</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' > . Expenditure</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Proceedings in CD Form</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' > . No.</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >- Total Expenditure on proceedings </font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >i. Any Other Expenditure-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >j. Miscellaneous Expenditure-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >k. Total Expected Expenditure-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >7. Institute Support proposed-</font></td></tr>");
//                sb.append("<tr><td style='text-align:left;width:100%;' > <font size='2' >7. Expected Profile/Loss to Institute-</font></td></tr>");

                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Signature and name of Organizing Secretary</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >HOD/Director</font></td></tr>");

                sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }







    @GET
    @Path("/IndusReport")
   // @Produces(MediaType.APPLICATION_JSON)
    public String getIndusReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid) throws SQLException {
        try { String qry1="",cdate="";
            ResultSet rs1=null;

            qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }
            qry = "SELECT (SELECT nvl(a.department,' ')  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department,  " +
                    "NVL (TO_CHAR (b.TRANSACTIONdate, 'dd-Mon-yyyy'), '') transdate,  NVL (B.PSARANDDLABDETAILS, '') rnd," +
                    " NVL (B.PSASCHOLARFELLOWDETAILS, ' ') fellowdeatails, NVL(B.PSACOLLABORATIVEDEGREEDETAILS, ' ') collaborative,  " +
                    " NVL (B.PSAAUTHARTPUBDETAILS, ' ') authar,NVL (B.PSAINDSUPEDUCONFDETAILS, ' ') indusdetails,NVL(B.PSAGIFTCOMPENDETAILS, ' ') giftcomp, " +
                    " NVL (B.PSAOTHERINDUSTRYDETAILS, ' ') otherdetail FROM AP#PSAINDUSTRIALDETAILS b" +
                    " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' ";
            // System.out.println(qry);
                rs = db.getRowset(qry);
                if(rs.next()) {
                sb.append("<div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%'>");
                
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;' colspan='2' ><font size='2' >Form:QA-PSA-4A<br>Frequency-Every Semester Jan/July<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;' colspan='2' ><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Industrial Interactions Details</u><br><br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap><font size='2' >Department : "+rs.getString("department")+"</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
              
           qry1="SELECT NVL(B.PSAGUSETLECTURENAME,'  ') guestname,nvl(B.PSAGUESTLECTURETOPIC,'  ') Topic ," +
                "nvl((to_date(B.PSAendDATE,'dd-MM-yyyy')-to_date(B.PSAstartDATE,'dd-MM-yyyy'))+1||' - ('||to_char(B.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(B.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates ," +
                "nvl(B.PSANOOFPARTICIPANTS,0) participant FROM AP#PSAINDGLECTUREDETAILS b " +
                " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' ";
                rs1=db.getRowset(qry1);
                rs2=db.getRowset(qry1);
                if(rs1.next()){
                guestLec.append("<tr><td style='text-align:left;width:100%;height:20%;' valign='bottom' colspan='2'><font size='2' ><br><u>Details of Guest Lectures by Industrial experts</u></font></td></tr>");
                guestLec.append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='griddata' rules='all' border='2' width='80%' border-color='black'>");
                guestLec.append("<tr><td nowrap><font size='2' >Sl No.</td><td nowrap><font size='2' >Name</td><td nowrap><font size='2' >Topic</td><td nowrap><font size='2' >Duration including dates</td><td nowrap><font size='2' >Number of participants</td></tr>");

                while(rs2.next()){k++;
                guestLec.append("<tr><td nowrap><font size='2' >"+k+"</td><td nowrap><font size='2' >"+rs1.getString("guestname")+"</td><td nowrap><font size='2' >"+rs1.getString("Topic")+"</td><td nowrap><font size='2' >"+rs1.getString("durationdates")+"</td><td nowrap><font size='2' >"+rs1.getString("participant")+"</td></tr>");
                     }
                guestLec.append("</table></td></tr>");
                }
                sb.append(guestLec);
            qry2="SELECT   nvl(b.PSAINDUSTRIALVISITNAME,' ') indusname, nvl(b.PSAINDTOURDETAILS,' ') tourdetails, " +
                    "nvl((to_date(B.PSAendDATE,'dd-MM-yyyy')-to_date(B.PSAstartDATE,'dd-MM-yyyy'))+1||' Day - ('||to_char(B.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(B.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates," +
                    "nvl(b.PSANOOFPARTICIPANTS,0) participant FROM AP#PSAINDVISITTOURDETAILS b " +
                    "where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' " +
                    " ";
                rs1=db.getRowset(qry2);
                rs2=db.getRowset(qry2);
                if(rs1.next()){
                indusVisit.append("<tr><td style='text-align:left;width:100%;height:20%;' valign='bottom' colspan='2'><font size='2' ><br><u>Industrial visits and tours</u></font></td></tr>");
                indusVisit.append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='griddata' rules='all' border='2' width='80%' border-color='black'>");
                indusVisit.append("<tr><td nowrap><font size='2' >Sl No.</td><td nowrap><font size='2' >Name of Industry visited</td><td nowrap><font size='2' >Tour details</td><td nowrap><font size='2' >Duration including dates</td><td nowrap><font size='2' >Number of participants</td></tr>");

                while(rs2.next()){i++;
                indusVisit.append("<tr><td nowrap><font size='2' >"+i+"</td><td nowrap><font size='2' >"+rs1.getString("indusname")+"</td><td nowrap><font size='2' >"+rs1.getString("tourdetails")+"</td><td nowrap><font size='2' >"+rs1.getString("durationdates")+"</td><td nowrap><font size='2' >"+rs1.getString("participant")+"</td></tr>");
                     }
                indusVisit.append("</table></td></tr>");
                }
                sb.append(indusVisit);
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan=2><font size='2' >Details of Industry sponsored R&D Laboratories at the Institute:</font></td></tr><tr><td colspan=2 style='text-align:left;width:75%;' ><font size='2' nowrap>  "+rs.getString("rnd")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan=2><font size='2' >Details of Industry sponsored Scholarships/fellowships for students:</font></td></tr><tr><td colspan=2 style='text-align:left;width:75%;' ><font size='2' nowrap>  "+rs.getString("fellowdeatails")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan=2><font size='2' >Details of Industry sponsored Collaborative degree programs in the department,if any:</font></td></tr><tr><td colspan=2 style='text-align:left;width:75%;' ><font size='2' nowrap>  "+rs.getString("collaborative")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan=2><font size='2' >Details of Authorship and Attribution of Joint Articles,Publications and Presentations:</font></td></tr><tr><td colspan=2 style='text-align:left;width:75%;' ><font size='2' nowrap>  "+rs.getString("authar")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan=2><font size='2' >Details of Industry support for Education Conferences and Meetings/Social Events:</font></td></tr><tr><td colspan=2 style='text-align:left;width:75%;' ><font size='2' nowrap>  "+rs.getString("indusdetails")+"</td></tr>");

               qry3="SELECT nvl(b.PSAINDLEDTRAININGNAME,' ') ledname,nvl(B.PSAINDLEDTRAININGTOPIC,' ') topicoftrain," +
                    "nvl((to_date(B.PSAendDATE,'dd-MM-yyyy')-to_date(B.PSAstartDATE,'dd-MM-yyyy'))+1||' Day - ('||to_char(B.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(B.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates, " +
                    "nvl(B.PSANOOFPARTICIPANTS,0) participant FROM AP#PSAINDLEDTRAINDETAILS B "+
                    " where b.companyid='" + company + "' and B.INSTITUTEID='" + institute + "' and B.TRANSACTIONID='" + transactionid + "' " +
                    " ";
                rs1=db.getRowset(qry3);
                rs2=db.getRowset(qry3);
                if(rs1.next()){
                ledTrain.append("<tr><td style='text-align:left;width:100%;height:20%;' valign='bottom' colspan='2'><font size='2' ><br><u>Details of Industry-Led Training and Education:</u></font></td></tr>");
                ledTrain.append("<tr><td align='center' colspan='2'><table style='margin-left:10%' id='griddata' rules='all' border='2' width='80%' border-color='black'>");
                ledTrain.append("<tr><td nowrap><font size='2' >Sl No.</td><td nowrap><font size='2' >Name </td><td nowrap><font size='2' >Topic of Training</td><td nowrap><font size='2' >Duration including dates</td><td nowrap><font size='2' >Number of participants</td></tr>");

                while(rs2.next()){j++;
                ledTrain.append("<tr><td nowrap><font size='2' >"+j+"</td><td nowrap><font size='2' >"+rs1.getString("ledname")+"</td><td nowrap><font size='2' >"+rs1.getString("topicoftrain")+"</td><td nowrap><font size='2' >"+rs1.getString("durationdates")+"</td><td nowrap><font size='2' >"+rs1.getString("participant")+"</td></tr>");
                     }
                ledTrain.append("</table></td></tr>");
                }
                sb.append(ledTrain);
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><font size='2' >Details of Gifts or Compensation received by any Teaching/Non-teaching Staff:</font></td></tr><tr><td style='text-align:left;width:75%;' ><font size='2' nowrap> "+rs.getString("giftcomp")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><font size='2' >Other industry related activities to be conducted by department:</font></td></tr><tr><td style='text-align:left;width:75%;' ><font size='2' nowrap> "+rs.getString("otherdetail")+"</td></tr>");
                sb.append("<tr><td style='text-align:left;width:25%;height:10%;' nowrap colspan='2'><br><br><br><br><br><font size='2' >Name and signature of Raporteur<br><br><br><br><br>Signature of HOD</font></td></tr>");
                sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");


                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }



@GET
    @Path("/IndusInterFeedbackReport")
    //@Produces(MediaType)
    public String getIndusInterFeedbackReport(@QueryParam("company") String company, @QueryParam("institute") String institute, @QueryParam("transid") String transactionid, @QueryParam("dept") String department) throws SQLException {
        try {String qry1="",cdate="",due="";
            ResultSet rs1=null;
              qry="select to_char(sysdate,'dd-mm-yyyy') currentdate from dual ";
            rs=db.getRowset(qry);
            if(rs.next())
            {
            cdate=rs.getString("currentdate") ;
            }

        

             qry="SELECT (SELECT nvl(a.department,' ')  FROM departmentmaster a  WHERE a.departmentcode = b.departmentcode)  department," +
                     "(select nvl((to_date(g.PSAendDATE,'dd-MM-yyyy')-to_date(g.PSAstartDATE,'dd-MM-yyyy'))+1||' Day - ('||to_char(g.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(g.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates " +
                     "from AP#PSAINDGLECTUREDETAILS g where g.TRANSACTIONID=b.TRANSACTIONID) guestduration ," +
                     "nvl(decode(b.psaguestspeakerfeedback,'1','Fair','2','Good','3','Very Good','4','Excellent','5','Outstanding'),'Fair')" +
                     " guestspeaker," +
                     "nvl(decode(B.psaguestparticipantsfeedback,'1','Fair','2','Good','3','Very Good','4','Excellent','5','Outstanding'),'Fair')" +
                     " participantfeedback," +

                     "(select nvl((to_date(i.PSAendDATE,'dd-MM-yyyy')-to_date(i.PSAstartDATE,'dd-MM-yyyy'))+1||' Day - ('||to_char(i.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(i.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates" +
                     " from AP#PSAINDVISITTOURDETAILS i where i.TRANSACTIONID=b.TRANSACTIONID) indusduration,nvl(b.psaindustrialvisitfeedback,' ')" +
                     " indusvisitfeedback," +
                     "nvl(b.psaindustryfeedback,'1')" +
                     " industryfeedback," +
                     "nvl(B.psaindparticipantsfeedback,'1')" +
                     " indusparticipantfeedback,nvl(psaindustrialsuggestions,' ') suggestions," +
                     "nvl(b.psaoverallprojectfeedback,'1')" +
                     " overallprojectfeedback," +
                     "nvl(b.psapicopifeedback,'1')" +
                     " picopifeedback, nvl(psaprojectsuggestions,' ') projectsuggestion," +
                     "(select nvl((to_date(l.PSAendDATE,'dd-MM-yyyy')-to_date(l.PSAstartDATE,'dd-MM-yyyy'))+1||' Day - ('||to_char(l.PSASTARTDATE,'dd-Mon-yyyy')||' to '||to_char(l.PSAENDDATE,'dd-Mon-yyyy')||')',' ') durationdates" +
                     " from AP#PSAINDLEDTRAINDETAILS l where l.TRANSACTIONID=b.TRANSACTIONID) ledduration," +
                     "nvl(b.psaindledinstructorfeedback,'1') " +
                     "ledinstructorfeedback," +
                     "nvl(b.psaindledparticipantfeedback,'1')" +
                     " ledparticipantfeedback,nvl(psaresourcepersonfeedback,' ') personfeedback,nvl(psaindledsuggestions,' ') ledsuggestions," +
                     "nvl(psaremarks,'') psaremarks  FROM ap#psaindustrialfeedback b where b.transactionid='"+transactionid+"' and companyid='"+company+"' and " +
                     "instituteid='"+institute+"' and departmentcode='"+department+"' ";
             rs=db.getRowset(qry);
             if(rs.next())
             {
                sb.append("<br><div style='width: 60%; padding: 10px ;border: .2em solid;margin-left:20%;' id=report>");
                sb.append("<table id='reporttable' style='z-index:5%'>");
                sb.append("<tr><td style='text-align:right;width:100%;height:20%;'  ><font size='2' >Form:QA-PSA-4B<br>Frequency-Every Semester Jan/July<br>Date-"+cdate+"<br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:center;width:100%;height:20%;'><font size='3' ><u>Institute Academic Quality Assurance Cell<br>Professional and Social Activities Committee<br>Industrial Interactions Feedback Form</u><br><br></font></td><td></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Department : "+rs.getString("department")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Guest Lectures : Date and Duration "+rs.getString("guestduration")+" </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'><font size='2' >Feedback of Speaker about the Institute,Facilities and interest of the participants : "+rs.getString("guestspeaker")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of participants about the Guest Lecture (if taken) : "+rs.getString("participantfeedback")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Industrial visits and tours(Details of the visit with date) : ( "+rs.getString("indusduration")+" ) "+rs.getString("indusvisitfeedback")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of the participants : "+rs.getString("indusparticipantfeedback")+" [5(Highest)...1(Lowest)]</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of Industry : "+rs.getString("industryfeedback")+" [5(Highest)...1(Lowest)]</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Suggestions : "+rs.getString("suggestions")+"</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >Details of Industry sponsored R & D Laboratories at the institute</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><font size='2' >Overall Feedback of the Industry Sponsoring the project :(Project title and duration) "+rs.getString("overallprojectfeedback")+" [5(Highest)...1(Lowest)]</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of PI/Co-PI : "+rs.getString("picopifeedback")+" [5(Highest)...1(Lowest)]</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Suggestions : "+rs.getString("projectsuggestion")+"</font></td><td style='text-align:left;width:75%;' ><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' ><u>Details of Industry-Led Training and Education  </u>:  </font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of Instructor with training details and duration : "+rs.getString("ledinstructorfeedback")+" [5(Highest)...1(Lowest)] ( "+rs.getString("ledduration")+" )</font></td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Feedback of Participants : "+rs.getString("ledparticipantfeedback")+" [5(Highest)...1(Lowest)]</font><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;' ><font size='2' >Suggestions : "+rs.getString("ledsuggestions")+"</font><font size='2' nowrap> </td></tr>");
                sb.append("<tr><td style='text-align:left;width:100%;'  ><br><br><br><br><br><font size='2' >Name and signature of Raporteur</font></td></tr>");
                sb.append("</table></div><center><button id='Print' onclick='return printDiv();' >Print</button></center>");
                }else
                {
         sb.append("<center><font color=red>Please choose another criteria</font></center>");

                }

        } catch (Exception e) {
            e.printStackTrace();
        }

         return  sb.toString();
    }

    
}


