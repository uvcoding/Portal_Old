/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
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
public class BTechMajorProjectsReportDB {
    private Connection dbConnection;
    private PreparedStatement pStmt;
    private CallableStatement callableStatement = null;
    private ResultSet rs;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public BTechMajorProjectsReportDB() {
        dbConnection = DBUtility.getConnection();
    }

    private enum scase {

        generateReport
    }

    public String selectSaveUpdateData(String jdata) {
        Map hm = new HashMap();
        String responseString = "";

        ObjectMapper mapper = new ObjectMapper();
        try {
            hm = mapper.readValue(jdata, new TypeReference<HashMap>() {
            });

            switch (BTechMajorProjectsReportDB.scase.valueOf((String) hm.get("handller").toString())) {
                case generateReport:
                    responseString = mapper.writeValueAsString(generateReport(hm));
                    break;
               

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return responseString;
    }
    
    private Map generateReport(Map hm) {
        Map data = new HashMap();
        TreeMap tm = new TreeMap();
        String searchBoxValue = "";
        StringBuilder sqry = new StringBuilder();
        try {
            

            sqry.append("SELECT NVL(VS.EMPLOYEENAME,'')EMPLOYEENAME,NVL(AM.PROJECTTITLE,'')PROJECTTITLE,");
            sqry.append("NVL(AM.ACADEMICYEAR,'')ACADEMICYEAR,");
            sqry.append("NVL(AD.APPUBLICATIONTYPEDESCRIPTION,'')APPUBLICATIONTYPEDESCRIPTION");
            sqry.append(" FROM AP#PROJECTMASTERBTECH AM,AP#PUBLICATIONTYPEMASTER AD,V#STAFF VS WHERE");
            sqry.append(" AM.COMPANYID=AD.COMPANYID AND AM.APPUBLICATIONTYPEID=AD.APPUBLICATIONTYPEID");
            sqry.append(" AND VS.EMPLOYEEID=AM.STAFFID AND AM.DEPARTMENTCODE='"+hm.get("department")+"' ");
            sqry.append("AND AM.COMPANYID='"+hm.get("institute")+"' AND AM.ACADEMICYEAR='"+hm.get("academicYear")+"'");
            int k = 1;
            pStmt = dbConnection.prepareStatement(sqry.toString());
            rs = pStmt.executeQuery();
            while (rs.next()) {
                data = new HashMap();
                data.put("employeeName", rs.getString(1));
                data.put("projectTitle", rs.getString(2));
                data.put("academicYear", rs.getString(3));
                data.put("publicationType", rs.getString(4));
                tm.put(k, data);
                k++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tm;
    }
}
