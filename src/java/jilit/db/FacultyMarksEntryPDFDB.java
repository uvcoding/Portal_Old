/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package jilit.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jdbc.DBUtility;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.net.InetAddress;
import javax.servlet.ServletContext;
import tietwebkiosk.DBHandler;
import tietwebkiosk.GlobalFunctions;
import tietwebkiosk.OLTEncryption;

/**
 *
 * @author nipun.gupta
 */
public class FacultyMarksEntryPDFDB {

    private Connection dbConnection;
    private PreparedStatement pStmt;
    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

    public FacultyMarksEntryPDFDB() {
        dbConnection = DBUtility.getConnection();
    }

    public void selectSaveUpdateData(HttpServletRequest req, HttpServletResponse res) {

        try {

            PdfPCell cell;
            PdfPTable table = new PdfPTable(24);
            BaseFont bf = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.EMBEDDED);
            Font font1 = new Font(bf, 10, Font.BOLD);
            Font font2 = new Font(bf, 10, Font.NORMAL);
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yy hh.mm aa");
            String formattedDate = dateFormat.format(new Date()).toString();
            
            GlobalFunctions gb = new GlobalFunctions();
            OLTEncryption enc = new OLTEncryption();
            DBHandler db = new DBHandler();
            ResultSet rs = null, rssub = null, rsm = null,rs1=null;
            String mMemberID = "", mMemberType = "", mDMemberType = "", mMemberName = "", mMemberCode = "", mInst = "", mDMemberCode = "", mCheckFstid = "";
            String mComp = "", mSelf = "", mIC = "", mEC = "", mSC = "", mList = "", mOrder = "", mEvent = "", mSE = "", qry = "", qry1 = "",qry2 = "", mMOP = "";
            int len = 0, pos = 0, ctr = 0;
            double mWeight = 0, mMaxmarks = 0;
            String dirname = "PDFDownload",mSMarks="";
            String filepath ="";
            String mSubcode = "", qrysub = "", mNam = "";
            if (req.getSession().getAttribute("MemberID") == null) {
                mMemberID = "";
            } else {
                mMemberID = req.getSession().getAttribute("MemberID").toString().trim();
            }

            if (req.getSession().getAttribute("MemberType") == null) {
                mMemberType = "";
            } else {
                mMemberType = req.getSession().getAttribute("MemberType").toString().trim();
            }

            if (req.getSession().getAttribute("MemberName") == null) {
                mMemberName = "";
            } else {
                mMemberName = req.getSession().getAttribute("MemberName").toString().trim();
            }

            if (req.getSession().getAttribute("MemberCode") == null) {
                mMemberCode = "";
            } else {
                mMemberCode = req.getSession().getAttribute("MemberCode").toString().trim();
            }

            if (req.getSession().getAttribute("InstituteCode") == null) {
                mInst = "";
            } else {
                mInst = req.getSession().getAttribute("InstituteCode").toString().trim();
            }

            if (req.getSession().getAttribute("CompanyCode") == null) {
                mComp = "";
            } else {
                mComp = req.getSession().getAttribute("CompanyCode").toString().trim();
            }

            if (req.getSession().getAttribute("Click") != null) {
                mSelf = req.getSession().getAttribute("Click").toString().trim();
            } else {
                mSelf = "";
            }
            if (req.getSession().getAttribute("InstCode") != null) {
                mIC = req.getSession().getAttribute("InstCode").toString().trim();
            } else {
                mIC = "";
            }
            if (req.getSession().getAttribute("Exam") != null) {
                mEC = req.getSession().getAttribute("Exam").toString().trim();
            } else {
                mEC = "";
            }
            if (req.getSession().getAttribute("Subject") != null) {
                mSC = req.getSession().getAttribute("Subject").toString().trim();
            } else {
                mSC = "";
            }
            if (req.getSession().getAttribute("listorder") != null) {
                mList = req.getSession().getAttribute("listorder").toString().trim();
            } else {
                mList = "EnrollNo";
            }
            if (req.getSession().getAttribute("order") != null) {
                mOrder = req.getSession().getAttribute("order").toString().trim();
            } else {
                mOrder = "";
            }
            if (req.getSession().getAttribute("Event") != null) {
                mEvent = req.getSession().getAttribute("Event").toString().trim();
            } else {
                mEvent = "";
            }
            len = mEvent.length();
            pos = mEvent.indexOf("#");
            if (pos > 0) {
                mSE = mEvent.substring(0, pos);
            } else {
                mSE = mEvent.toString().trim();
            }


            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                String mCode = enc.decode(mMemberCode);
                String mChkMemID = enc.decode(req.getSession().getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(req.getSession().getAttribute("MemberType").toString().trim());
                String mIPAddress = req.getSession().getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(req.getSession().getAttribute("ROLENAME").toString().trim());


                
                qrysub = "select subject,subjectcode from subjectmaster where InstituteCode='" + mIC + "' and subjectID='" + mSC + "' and nvl(deactive,'N')='N' ";
                //System.out.println(qrysub);
                rssub = db.getRowset(qrysub);
                if (rssub.next()) {
                    mNam = rssub.getString("subject");
                    mSubcode = rssub.getString("subjectcode");
                } else {
                    mNam = "";
                    mSubcode = "";
                }
                String name = "", time = "";
                String query123 = "select employeename,to_char(sysdate,'DD/MM/YYYY HH:MI:SS AM')dd from employeemaster where employeeid='" + mChkMemID + "'";
                //out.println(query123);
                rssub = db.getRowset(query123);
                if (rssub.next()) {
                    name = rssub.getString("employeename");
                    time = rssub.getString("dd");
                }
                InetAddress ip;
                String hostname;
                
                
                filepath = req.getRealPath("");
                File dir = new File(filepath+"\\"+dirname);
                if(!dir.exists())
                {
                  dir.mkdirs();  
                }
                
                OutputStream file = new FileOutputStream(new File(filepath+"\\"+dirname+"\\"+"Marks-"+mEvent+"-"+mNam+"-"+formattedDate+".pdf"));
               //For PDF Report
                Document document = new Document();
                PdfWriter.getInstance(document, file);



                document.open();//PDF document opened........			       

                Font myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 20, BaseColor.RED);
                Paragraph paragraph = new Paragraph("Marks Entry Student List", myFont);
                paragraph.setAlignment(Element.ALIGN_CENTER);
                document.add(paragraph);

                document.add(Chunk.NEWLINE);


                if (mSelf.equals("Self")) {
                    myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                    paragraph = new Paragraph("Faculty Name - " + name + " (" + mCode + ")", myFont);
                    paragraph.setAlignment(Element.ALIGN_LEFT);
                    document.add(paragraph);
                } else {
                    myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                    paragraph = new Paragraph("Coordinator Name - " + name + " (" + mCode + ")", myFont);
                    paragraph.setAlignment(Element.ALIGN_LEFT);
                    document.add(paragraph);
                }

                myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                paragraph = new Paragraph("Date & Time - " + new Date().toString(), myFont);
                paragraph.setAlignment(Element.ALIGN_LEFT);
                document.add(paragraph);

                myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                paragraph = new Paragraph("Subject - " + mNam + "(" + mSubcode + ")", myFont);
                paragraph.setAlignment(Element.ALIGN_LEFT);
                document.add(paragraph);

                myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                paragraph = new Paragraph("Exam Code - " + mEC, myFont);
                paragraph.setAlignment(Element.ALIGN_LEFT);
                document.add(paragraph);

                myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 8);
                paragraph = new Paragraph("Event-Subevent - " + mEvent, myFont);
                paragraph.setAlignment(Element.ALIGN_LEFT);
                document.add(paragraph);

                document.add(Chunk.NEWLINE);

                if (mSelf.equals("Self")) {
                    qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                    qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                    qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                    qry = qry + " examcode='" + mEC + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                    qry = qry + " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mIC + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                    qry = qry + " AND EVENTSUBEVENT='" + mEvent + "' ";
                    qry = qry + "  AND ( (studentid, fstid) IN (SELECT studentid, fstid FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"'";
                    qry = qry + " AND NVL (DEACTIVE, 'N') = 'N' AND NVL (locked, 'N') = 'N') OR (studentid, fstid) NOT IN (SELECT studentid, fstid ";
                    qry = qry + " FROM StudentEventSubjectMarks WHERE EVENTSUBEVENT = '"+mEvent+"' AND NVL (DEACTIVE, 'N') = 'N' ";
                    qry = qry + " AND NVL (locked, 'N') = 'Y')) AND STUDENTID NOT IN (SELECT DISTINCT studentid FROM debarstudentdetail WHERE NVL (REEXAMINATION, 'N') = 'Y') ";
                    qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                    qry = qry + " order by " + mList + " " + mOrder + " ";

                    qry1 = "select WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                    qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                    qry1 += " AND ((EMPLOYEEID=(Select '" + mChkMemID + "' EmployeeID from dual)) OR (fstid in (select fstid from FACULTYSUBJECTTAGGING where companycode='" + mComp + "' and institutecode='" + mInst + "' and facultytype=decode('" + mDMemberType + "','E','I','E') and employeeid='" + mChkMemID + "')) and facultytype=decode('" + mDMemberType + "','E','I','E'))";
                    qry1 += " And EVENTSUBEVENT='" + mEvent + "' and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N' ";

                } else if (!mSelf.equals("Self")) {
                    qry = "select fstid,nvl(studentid,' ')studentid,nvl(studentname,' ')StudentName, nvl(enrollmentno,' ')EnrollNo, nvl(semester,0)Semester,";
                    qry = qry + " nvl(programcode,' ')||' ('||nvl(SECTIONBRANCH,' ')||' - '||subsectioncode||')' Course from V#EXAMEVENTSUBJECTTAGGING ";
                    qry = qry + " where institutecode='" + mIC + "' and nvl(DEACTIVE,'N')='N' and nvl(PROCEEDSECOND,'N')='N' and nvl(locked,'N')='N' and nvl(PUBLISHED,'N')='N' and ";
                    qry = qry + " examcode='" + mEC + "'  and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P' ) and subjectID='" + mSC + "' ";
                    qry = qry + " And EVENTSUBEVENT='" + mEvent + "' ";
                    qry = qry + " AND FSTID IN (SELECT FSTID FROM EX#SUBJECTGRADECOORDINATOR WHERE COMPANYCODE='" + mComp + "' and INSTITUTECODE='" + mIC + "' and FACULTYTYPE=decode('" + mDMemberType + "','E','I','E') and FACULTYID='" + mChkMemID + "')";
                    qry = qry + " GROUP BY fstid,studentid,StudentName,enrollmentno,Semester, programcode,SECTIONBRANCH, subsectioncode";
                    qry = qry + " order by " + mList + " " + mOrder + " ";

                    qry1 = "select  WEIGHTAGE, MARKSORPERCENTAGE, MAXMARKS from V#EXAMEVENTSUBJECTTAGGING  ";
                    qry1 += " where institutecode='" + mIC + "' and  examcode='" + mEC + "' ";
                    qry1 += " And EVENTSUBEVENT='" + mEvent + "'  ";
                    qry1 += " and (ltp='L' OR (LTP='E' AND PROJECTSUBJECT='Y') OR LTP='P') and subjectID='" + mSC + "' AND  NVL (deactive, 'N') = 'N'";
                }
                //System.out.println(qry);
                rsm = db.getRowset(qry1);
                if (rsm.next()) {
                    mMOP = rsm.getString("MARKSORPERCENTAGE");
                    mMaxmarks = rsm.getDouble("MAXMARKS");
                    mWeight = rsm.getDouble("WEIGHTAGE");
                }
                if (mMOP.equals("M")) {
                    
                    cell = new PdfPCell(new Paragraph("Mode of Entry -", font1));
                         cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Marks", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Maximum Marks -", font1));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(5);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(mMaxmarks+"", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(3);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Weightage -", font1));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(mWeight+"", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    document.add(table);
                } else {
                    cell = new PdfPCell(new Paragraph("Mode of Entry -", font1));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Percentage", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Maximum Marks -", font1));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(5);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(mMaxmarks+"", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(3);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph("Weightage -", font1));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    cell = new PdfPCell(new Paragraph(mWeight+"", font2));
                    cell.setHorizontalAlignment(Element.ALIGN_LEFT);
                    cell.setColspan(4);
                    cell.setBorder(0);
                    table.addCell(cell);
                    document.add(table);
                }
                rs = db.getRowset(qry);
                table = new PdfPTable(4);
                myFont = FontFactory.getFont(FontFactory.TIMES_BOLD, 12);
                cell = new PdfPCell(new Paragraph("Student Label for Marks Entry (Before Saving)", myFont));
                cell.setColspan(4);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(20.0f);
                cell.setBackgroundColor(new BaseColor(140, 221, 8));
                table.addCell(cell);
                Font myFont1 = FontFactory.getFont(FontFactory.TIMES_BOLD, 12, BaseColor.RED);
                while (rs.next()) {
                    ctr++;
                    if (ctr == 1) {

                       
                        table.addCell(new Paragraph("Sr. No.",myFont1));
                        table.addCell(new Paragraph("Enrollment No.",myFont1));
                        table.addCell(new Paragraph("Student Name",myFont1));
                        table.addCell(new Paragraph(mEvent + " Marks",myFont1));
                        table.setSpacingBefore(20.0f);       // Space Before table starts, like margin-top in CSS
                        table.setSpacingAfter(20.0f);


                    }
                    
                     qry2="Select fstid,studentid,nvl(MARKSAWARDED1,-1)MARKSAWARDED1, ";
		    qry2=qry2+" nvl(DETAINED,'N') DETAINED from V#STUDENTEVENTSUBJECTMARKS ";
		    qry2=qry2+" where INSTITUTECODE='"+mIC+"' and EXAMCODE='"+mEC+"' and ";
		    qry2=qry2+" EVENTSUBEVENT='"+mEvent+"' and   ";
		    qry2=qry2+" fstid='"+rs.getString("fstid")+"' and STUDENTID='"+rs.getString("studentid")+"' ";
		 //  	System.out.print("JILIT - "+qry);
			rs1=db.getRowset(qry2);
                if(rs1.next())
                {
                    mSMarks = rs1.getString("MARKSAWARDED1");
                    
                    table.addCell(ctr + "");
                    table.addCell(rs.getString("EnrollNo"));
                    table.addCell(rs.getString("StudentName"));
                    table.addCell(mSMarks);
                    table.setSpacingBefore(20.0f);       // Space Before table starts, like margin-top in CSS
                    table.setSpacingAfter(20.0f);
                }

                }
                document.add(table);
                document.close();

                file.close();

                System.out.println("Pdf created successfully..");
            }


            res.setContentType("application/pdf");
            PrintWriter out = res.getWriter();
            String filename = "Marks-"+mEvent+"-"+mNam+"-"+formattedDate+".pdf";
            String filepath1 = filepath+"\\"+dirname+"\\";
            res.setContentType("application/pdf");
            res.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

            FileInputStream fileInputStream = new FileInputStream(filepath1 + filename);

            int i;
            while ((i = fileInputStream.read()) != -1) {
                out.write(i);
            }
            fileInputStream.close();
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
