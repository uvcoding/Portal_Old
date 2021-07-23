/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import jdbc.DBUtility;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

/**
 *
 * @author nipun.gupta
 */
public class AwardAndAchievementDB {
    private Connection dbConnection;
    private PreparedStatement pStmt=null;
    private CallableStatement callableStatement = null;
    private ResultSet rs=null;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public AwardAndAchievementDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        selectStaffInfo, saveupdate, select, SelectforUpdate,Delete,selectStudentInfo
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (AwardAndAchievementDB.scase.valueOf((String) hm.get("handller").toString())) {
                case selectStaffInfo:
                    responseString = mapper.writeValueAsString(selectStaffInfo(hm));
                    break;
                case selectStudentInfo:
                    responseString = mapper.writeValueAsString(selectStudentInfo(hm));
                    break;
                case saveupdate:
                    responseString = SaveUpdateData(hm);
                    break;
                case select:
                    responseString = mapper.writeValueAsString(getSelectData(hm));
                    break;
                case SelectforUpdate:
                    responseString = mapper.writeValueAsString(selectForUpdate(hm));
                    break;
                case Delete:
                    responseString = mapper.writeValueAsString(getDeleteData(hm));
                    break;

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
    
    private Map selectStaffInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        Map SelectData = new HashMap();
        try {

            if (!hm.get("searchNames").equals("")) {
                searchBoxValue = "and (vs.employeename like '%" + hm.get("searchNames") + "%')";
            }
            sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (employeeid) Totalrecord FROM v#staff where nvl(deactive,'N')='N' and departmentcode='"+hm.get("departmentID")+"' and employeeid not in(" + hm.get("totalStaffIDS") + ")) a,\n"
                    + "(SELECT * FROM ( select nvl(vs.employeeid,'')employeeid,nvl(vs.employeetype,'')employeetype,nvl(vs.employeename,'')employeename,"
                    + "nvl(dm.department,'')department,nvl(vs.departmentcode,'')departmentcode, ROWNUM R "
                    + "from v#staff vs,departmentmaster dm where VS.DEPARTMENTCODE=DM.DEPARTMENTCODE and nvl(vs.deactive,'N')='N' and vs.departmentcode='"+hm.get("departmentID")+"'"
                  //  + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") " + searchBoxValue + "  and vs.employeeid not in(select  STAFFID from AP#PATENTDETAIL where PATENTID='" + hm.get("patentID") + "')order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                    + " and vs.employeeid not in(" + hm.get("totalStaffIDS") + ") " + searchBoxValue + " order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");

            int k = 1;
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("totalrecords", rs.getString(1));
                SelectData.put("memberID", rs.getString(2));
                SelectData.put("memberType", rs.getString(3));
                SelectData.put("memberName", rs.getString(4));
                SelectData.put("department", rs.getString(5));
                SelectData.put("departmentCode", rs.getString(6));
                SelectData.put("sno", rs.getString(7));
                tm.put(k, SelectData);
                k++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
    
     private Map selectStudentInfo(Map hm) {
        StringBuffer sqry = new StringBuffer();
        Map tm = new TreeMap();
        String searchBoxValue="";
        Map SelectData = new HashMap();
        try {
            
            if(!hm.get("searchNames").equals("")){
              searchBoxValue="and (studentname like '%"+hm.get("searchNames")+"%')";
              }
            
             /* ------------------This is for active or currently serving academic------------------------------------------------------

              sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (sm.studentid) Totalrecord FROM studentmaster sm,branchdepttagging bt,departmentmaster dm where nvl(sm.deactive,'N')='N' and sm.programcode is not null and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' and sm.studentid not in(" + hm.get("totalStudentIDS") + ")) a,\n"
                        +"(SELECT * FROM ( select nvl(sm.studentid,'')studentid,nvl(sm.studentname,'')studentname,nvl(sm.programcode,'')programcode,nvl(sm.branchcode,'')branchcode,"
                        + "NVL (bt.departmentcode, '') departmentcode, NVL (dm.department, '') department,ROWNUM R "
                        + "from studentmaster sm,branchdepttagging bt,departmentmaster dm where nvl(sm.deactive,'N')='N' AND sm.programcode IS NOT NULL "
                        + " and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' "
                        + " and sm.studentid not in(" + hm.get("totalStudentIDS") + ") "+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                    */

             sqry.append("SELECT a.*, B.*" + "  FROM (SELECT COUNT (sm.studentid) Totalrecord FROM studentmaster sm,branchdepttagging bt,departmentmaster dm where sm.programcode is not null and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' and sm.studentid not in(" + hm.get("totalStudentIDS") + ")) a,\n"
                        +"(SELECT * FROM ( select nvl(sm.studentid,'')studentid,nvl(sm.studentname,'')studentname,nvl(sm.programcode,'')programcode,nvl(sm.branchcode,'')branchcode,"
                        + "NVL (bt.departmentcode, '') departmentcode, NVL (dm.department, '') department,ROWNUM R "
                        + "from studentmaster sm,branchdepttagging bt,departmentmaster dm where  sm.programcode IS NOT NULL "
                        + " and BT.INSTITUTECODE=SM.INSTITUTECODE and BT.ACADEMICYEAR=SM.ACADEMICYEAR and BT.SECTIONBRANCH=SM.BRANCHCODE and BT.PROGRAMCODE=SM.PROGRAMCODE and BT.DEPARTMENTCODE=DM.DEPARTMENTCODE and bt.departmentcode='"+hm.get("departmentID")+"' "
                        + " and sm.studentid not in(" + hm.get("totalStudentIDS") + ") "+searchBoxValue+" order by R) WHERE r > ").append(hm.get("spg")).append(" AND r <= ").append(hm.get("epg")).append(") b");
                
                int k = 1;
                if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                pStmt = dbConnection.prepareStatement(sqry.toString());
                rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData = new HashMap();
                SelectData.put("totalrecords", rs.getString(1));
                SelectData.put("memberID", rs.getString(2));
                SelectData.put("memberType", "S");
                SelectData.put("memberName", rs.getString(3));
                SelectData.put("departmentCode", rs.getString(6));
                SelectData.put("department",rs.getString(7));
                SelectData.put("sno", rs.getString(8));
                tm.put(k, SelectData);
                k++;
            }
           
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
    
    
    
    private String SaveUpdateData(Map hm) {

        StringBuilder sqry = new StringBuilder();
        StringBuilder eqry = new StringBuilder();
        ArrayList list = (ArrayList) hm.get("para");
        String id = "";
        try {
            if (hm.get("awardAchievementID").equals("0")) { 
                try {
                    if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                    callableStatement = dbConnection.prepareCall("{call generateID(?,?,?)}");
                    callableStatement.setString(1, "0001");
                    callableStatement.setString(2, "FBMId");
                    callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR);
                    callableStatement.execute();
                    id = callableStatement.getString(3);
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (callableStatement != null) {
                        callableStatement.close();
                    }
                }

                eqry.append("insert into  AP#AWDACHMASTER ( COMPANYID,AWDACHID,");
                eqry.append("TRANSACTIONDATE,AWDACHTYPE,AWDACHCODE,AWDACHTITLE,AWDACHEVENTNAME,");
                eqry.append("AWDACHVENUE,AWDACHORGBODY,AWDACHREMARKS,AWDACHSRANK,ENTRYBY,ENTRYDATE,AWDACHYEAR,PRIZE)");
                eqry.append(" VALUES('").append(hm.get("companyID")).append("','").append(id).append("',");
                eqry.append("to_date('").append(hm.get("transactionDate")).append("','dd-mm-yyyy'),'").append(hm.get("natureOfAwardAchievement")).append("','").append(id).append("','").append(hm.get("awardAchievementTitle")).append("',");
                eqry.append("'").append(hm.get("awardAchievementEventName")).append("','");
                eqry.append(hm.get("venue")).append("',");
                eqry.append("'").append(hm.get("organizingBody")).append("','")
                .append(hm.get("awardAchievementRemarks")).append("','")
                .append(hm.get("allIndiaRank")).append("','").append(hm.get("entryBy"))
                .append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM')").append(",'")
                .append(hm.get("awardAchievementYear")).append("','")
                .append(hm.get("prize")).append("')");
                if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                pStmt = dbConnection.prepareStatement(eqry.toString());
                pStmt.executeUpdate();

            } else {
                sqry.append("Update AP#AWDACHMASTER set COMPANYID='").append(hm.get("companyID"))
                .append("',TRANSACTIONDATE=to_date('").append(hm.get("transactionDate"))
                .append("','dd-mm-yyyy'),AWDACHTYPE='").append(hm.get("natureOfAwardAchievement")).append("',");
                sqry.append("AWDACHCODE='").append(hm.get("awardAchievementID"))
                .append("',AWDACHTITLE='").append(hm.get("awardAchievementTitle"))
                .append("',AWDACHEVENTNAME='").append(hm.get("awardAchievementEventName"));
                sqry.append("',AWDACHVENUE='").append(hm.get("venue"))
                .append("',AWDACHORGBODY='").append(hm.get("organizingBody"))
                .append("'");
                sqry.append(",AWDACHREMARKS='").append(hm.get("awardAchievementRemarks"))
                .append("',AWDACHSRANK='").append(hm.get("allIndiaRank"))
                .append("',ENTRYBY='").append(hm.get("entryBy"))
                .append("',ENTRYDATE=to_date(sysdate,'dd-MM-RRRR HH:SS PM'),AWDACHYEAR='"+hm.get("awardAchievementYear")+"' where AWDACHID='")
                .append(hm.get("awardAchievementID")).append("'");
                if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                pStmt = dbConnection.prepareStatement(sqry.toString());
                pStmt.executeUpdate();
                id = hm.get("awardAchievementID").toString();

            }



            String Querry = " delete from AP#AWDACHDETAIL where AWDACHID = '" + hm.get("awardAchievementID") + "'";
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(Querry);
            pStmt.executeUpdate();

            if (hm.get("awardAchievementID").equals("0")) {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#AWDACHDETAIL ( COMPANYID,");
                    eqry.append("AWDACHID,STAFFTYPE,STAFFID,DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','")
                    .append(id).append("',");
                    eqry.append("'").append(mp.get("employeeType")).append("','")
                    .append(mp.get("staffID")).append("',");
                    eqry.append("'").append(mp.get("departmentCode")).append("','")
                    .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                    if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                    pStmt = dbConnection.prepareStatement(eqry.toString());
                    pStmt.executeUpdate();
                }

            } else {
                for (int x = 0; x < list.size(); x++) {
                    eqry = new StringBuilder();
                    Map mp = (Map) list.get(x);
                    eqry.append("insert into  AP#AWDACHDETAIL ( COMPANYID,");
                    eqry.append("AWDACHID,STAFFTYPE,STAFFID,DEPARTMENTCODE,ENTRYBY,ENTRYDATE)");
                    eqry.append(" VALUES('").append(mp.get("companyID")).append("','")
                    .append(mp.get("awardAchievementID")).append("',");
                    eqry.append("'").append(mp.get("employeeType")).append("','")
                    .append(mp.get("staffID")).append("',");
                    eqry.append("'").append(mp.get("departmentCode")).append("','")
                    .append(mp.get("entryBy")).append("',to_date(sysdate,'dd-MM-RRRR HH:SS PM'))");
                    if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
                    pStmt = dbConnection.prepareStatement(eqry.toString());
                    pStmt.executeUpdate();
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
            return "Record Not Saved";
        }
        return id;
    }
    
    private Map getSelectData(Map hm) {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        StringBuilder sqry = new StringBuilder();
        try {
            if (!hm.get("searchbox").equals("")) {
                searchBoxValue = "where (am.AWDACHCODE like '%" + hm.get("searchbox") + "%' or am.AWDACHORGBODY like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.AWDACHEVENTNAME like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.AWDACHYEAR like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.AWDACHREMARKS like '%" + hm.get("searchbox") + "%'";
                searchBoxValue = searchBoxValue + " or am.AWDACHSRANK like '%" + hm.get("searchbox") + "%')";
            }

            sqry.append("SELECT a.*, B.* FROM (SELECT COUNT (AWDACHID) Totalrecord FROM  AP#AWDACHMASTER) a,\n"
                    + "  (SELECT *\n"
                    + "  FROM (select nvl(am.AWDACHID,'')AWDACHID,"
                    + "nvl(am.AWDACHTYPE,'')AWDACHTYPE,"
                    + "nvl(am.AWDACHTITLE,'')AWDACHTITLE,"
                    + "nvl(am.AWDACHEVENTNAME,'')AWDACHEVENTNAME,"
                    + "nvl(am.AWDACHREMARKS,'')AWDACHREMARKS,"
                    + "nvl(am.AWDACHSRANK,'')AWDACHSRANK,"
                    + "nvl(am.AWDACHORGBODY,'')AWDACHORGBODY,nvl(am.AWDACHYEAR,'')AWDACHYEAR,"
                    + " row_number() over (order by am.AWDACHID desc)  R from AP#AWDACHMASTER am"
                    + " " + searchBoxValue + ")\n"
                    + " WHERE r > " + hm.get("spg") + " AND r <= " + hm.get("epg") + ") b ");
            int k = 1;
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("slno", rs.getString(10));
                data.put("totalrecords", rs.getString(1));
                data.put("awardAchievementID", rs.getString(2));
                data.put("natureOfAwardAchievement", rs.getString(3));
                data.put("awardAchievementTitle", rs.getString(4));
                data.put("awardAchievementEventName", rs.getString(5));
                data.put("awardAchievementRemarks", rs.getString(6));
                data.put("allIndiaRank", rs.getString(7));
                data.put("organizingBody", rs.getString(8));
                data.put("awardAchievementYear", rs.getString(9));
                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
    
    private Map selectForUpdate(Map hm) {
        StringBuilder sqry = new StringBuilder();
        StringBuilder sqry1 =new StringBuilder();
        TreeMap tm = new TreeMap();
        Map SelectData = new HashMap();
        Map SelectData1 = new HashMap();
        int k = 1;
        try {
            sqry.append(" select to_char(TRANSACTIONDATE,'dd-mm-yyyy')TRANSACTIONDATE,"
                    + "nvl(AWDACHTYPE,'')AWDACHTYPE,"
                    + "nvl(AWDACHTITLE,'')AWDACHTITLE,"
                    + "nvl(AWDACHEVENTNAME,'')AWDACHEVENTNAME,"
                    + "nvl(AWDACHVENUE,'')AWDACHVENUE,"
                    + "nvl(AWDACHORGBODY,'')AWDACHORGBODY,"
                    + "nvl(AWDACHREMARKS,'')AWDACHREMARKS,nvl(AWDACHSRANK,'')AWDACHSRANK,nvl(AWDACHYEAR,'')AWDACHYEAR from AP#AWDACHMASTER");
            sqry.append(" where ").append("AWDACHID='").append(hm.get("awardAchievementID")).append("'");
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {

                SelectData.put("awardAchievementID", hm.get("awardAchievementID"));
                SelectData.put("transactionDate", rs.getString(1));
                SelectData.put("natureOfAwardAchievement", rs.getString(2));
                SelectData.put("awardAchievementTitle", rs.getString(3));
                SelectData.put("awardAchievementEventName", rs.getString(4));
                SelectData.put("venue", rs.getString(5));
                SelectData.put("organizingBody", rs.getString(6));
                SelectData.put("awardAchievementRemarks", rs.getString(7));
                SelectData.put("allIndiaRank", rs.getString(8));
                SelectData.put("awardAchievementYear", rs.getString(9));

            }
            sqry = new StringBuilder();
            sqry.append(" select nvl(AD.STAFFTYPE,'')STAFFTYPE,NVL (AD.STAFFID, '') STAFFID, NVL (vs.EMPLOYEENAME, '') EMPLOYEENAME,"
                    + "NVL(AD.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT"
                    + " FROM AP#AWDACHDETAIL AD ,V#STAFF VS,DEPARTMENTMASTER DM");
            sqry.append(" where VS.EMPLOYEEID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND ").append("AWDACHID='").append(hm.get("awardAchievementID")).append("'");
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("memberType", rs.getString(1));
                SelectData1.put("choose", rs.getString(1));
                SelectData1.put("memberID", rs.getString(2));
                SelectData1.put("memberName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
                tm.put(k, SelectData1);
                k++;


            }
            
            sqry1 = new StringBuilder();
            sqry1.append(" select nvl(AD.STAFFTYPE,'')STAFFTYPE,NVL (AD.STAFFID, '') STAFFID, NVL (SM.STUDENTNAME, '') STUDENTNAME,"
                    + "NVL(AD.DEPARTMENTCODE,'')DEPARTMENTCODE,nvl(DM.DEPARTMENT,'')DEPARTMENT"
                    + " FROM AP#AWDACHDETAIL AD ,STUDENTMASTER SM,DEPARTMENTMASTER DM");
            sqry1.append(" where SM.STUDENTID=AD.STAFFID AND DM.DEPARTMENTCODE=AD.DEPARTMENTCODE AND STAFFTYPE='S' AND ").append("AWDACHID='").append(hm.get("awardAchievementID")).append("'");
            if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
            pStmt = dbConnection.prepareStatement(sqry1.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                SelectData1 = new HashMap();
                SelectData1.put("memberType", rs.getString(1));
                SelectData1.put("choose", rs.getString(1));
                SelectData1.put("memberID", rs.getString(2));
                SelectData1.put("memberName", rs.getString(3));
                SelectData1.put("departmentCode", rs.getString(4));
                SelectData1.put("departmentName", rs.getString(5));
                tm.put(k, SelectData1);
                k++;


            }
            SelectData.put("childMap", tm);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SelectData;
    }
    
     private Map getDeleteData(Map hm) {
        
          try {
              if(dbConnection.isClosed()){
                    dbConnection=DBUtility.getConnection(dbConnection);
                }
           Statement st= dbConnection.createStatement();
            String qry1 = "delete from AP#AWDACHDETAIL where AWDACHID = '" + hm.get("awardAchievementID") + "'";
            st.addBatch(qry1);
            String qry2 = "delete from AP#AWDACHMASTER where AWDACHID = '" + hm.get("awardAchievementID") + "'";
            st.addBatch(qry2);
            st.executeBatch();

        } catch (Exception e) {
            
            e.printStackTrace();
        }
        return new HashMap();
    }
}
