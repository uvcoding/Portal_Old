<%--
    Document   : FeeReceiptPDF
    Created on : Jan 23, 2012, 3:45:07 PM
    Author     : ankur.verma
--%>

<%@page import="javax.servlet.*,javax.servlet.http.*,java.io.*,java.util.*,com.lowagie.text.pdf.*, com.lowagie.text.*,java.awt.Color.*,java.text.*"%>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">


<%

        String qry = "";
        DBHandler db = new DBHandler();
        ResultSet rs = null, rs1 = null, rs2 = null;
        String qry1 = "", mWebEmail = "";
            String DRAWNON = "", DDDATE = "", DDNO = "", qry2 = "", Shortdesc1 = "", mFeeAmountWord = "";
 DecimalFormat df = new DecimalFormat("#.00");
        String mMemberID = "";
        String mMemberType = "";
        String mMemberCode = "";
        String mDMemberCode = "";
        String mMemberName = "";
        String mmMemberName = "";
        String mCompanyCode = "";
        String mAcademicYearCode = "";
        String mProgramCode = "";
        String mBranchCode = "";
        String mCurrentSem = "";
        int mCurSem = 0;
        String mMS = "";
        String mInstituteCode = "";
		String mMaxSemester = "";
        String mSCode = "";
        String mSem = "", mCurrency = "", mPRNO = "", mProgname = "", mBranchname = "";
        double mFeeAmount = 0.0, FeeCurrencyAmount = 0.0;
        String FeeHeadDesc = "", Shortdesc = "", mInstName = "", mInstAddress = "", mChkMemID = "", mFatherName = "", PRDATE = "";
        String mInstituteCodeTemp="";
		//  mFeeAmount=request.getParameter("FEEAMOUNT");
        String payBy="";

        String mHead = "";
        if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
            mHead = session.getAttribute("PageHeading").toString().trim();
        } else {
            mHead = "JIIT ";
        }


%>
<HTML>
<head>
    <TITLE>#### <%=mHead%> [ View Academic Fee detail  ] </TITLE>

</head>

<%
	 response.setContentType("application/pdf");

        // Code 1
            if (request.getParameter("CompanyCode") == null) {
                mCompanyCode = "";
            } else {
                mCompanyCode = request.getParameter("CompanyCode").toString().trim();
            }


            if (request.getParameter("ProgramCode") == null) {
                mProgramCode = "";
            } else {
                mProgramCode = request.getParameter("ProgramCode").toString().trim();
            }

            if (request.getParameter("BranchCode") == null) {
                mBranchCode = "";
            } else {
                mBranchCode = request.getParameter("BranchCode").toString().trim();
            }


            if (request.getParameter("InstituteCode") == null) {
                mInstituteCode = "";
            } else {
                mInstituteCode = request.getParameter("InstituteCode").toString().trim();
            }


            //String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());

            if("JIIT".equalsIgnoreCase(mInstituteCode)){
			mInstituteCodeTemp=mInstituteCode+" 62";
			}
			else if("J128".equalsIgnoreCase(mInstituteCode)){
			mInstituteCodeTemp=mInstituteCode+" 128";
			}else{
					mInstituteCodeTemp=mInstituteCode;
			}


	String mMr = "", mDr = "",basePath="";

            mSem = request.getParameter("SEM");

            mPRNO = request.getParameter("PRNO").toString().trim();


           // basePath = "C:/jakarta-tomcat-5.0.25/webapps/ROOT/";

			 basePath = "C:/jboss/jboss-as-7.1.1.Final/standalone/deployments/ROOT.war/";

			//request.getParameter("basePath").toString().trim();

			mChkMemID=request.getParameter("STUDENTID").toString().trim();

 qry2 = "select distinct enrollmentno,initcap(studentname) studentname, initcap(fathername) fathername,decode(sex,'M','Mr.','F','Ms.')sex,decode(sex,'M','S/o.','F','D/o')sex1" +
                    " from studentmaster where studentid='" + mChkMemID + "' and nvl(deactive,'N')='N' and institutecode='" + mInstituteCode + "' ";

            rs2 = db.getRowset(qry2);
            if (rs2.next()) {
				mDMemberCode=rs2.getString("enrollmentno");
				mMemberName=rs2.getString("studentname");
                mFatherName = rs2.getString("fathername");
                mMr = rs2.getString("sex");
                mDr = rs2.getString("sex1");
            }


            qry = "select A.PROGRAMNAME,B.BRANCHDESC  from programmaster a,branchmaster b where " +
                    " a.INSTITUTECODE=b.INSTITUTECODE and a.INSTITUTECODE='" + mInstituteCode + "' " +
                    " AND A.PROGRAMCODE=B.PROGRAMCODE AND A.PROGRAMCODE='" + mProgramCode + "'" +
                    " AND B.BRANCHCODE='" + mBranchCode + "' ";


			rs = db.getRowset(qry);
            if (rs.next()) {
                mProgname = rs.getString("PROGRAMNAME");
                mBranchname = rs.getString("BRANCHDESC");
            }

            qry1 = "select a.INSTITUTECODE,a.INSTITUTENAME, a.CITY  aaa " +
                    " from institutemaster a where a.institutecode='" + mInstituteCode + "' ";


			rs1 = db.getRowset(qry1);
            if (rs1.next()) {
                mInstName = rs1.getString("INSTITUTENAME");
                mInstAddress = rs1.getString("aaa");
            }

//------------------------------------------------------------------------------------------------


            Document document = new Document();
               try {

			PdfWriter.getInstance(document, response.getOutputStream()); // Code 2
            document.open();


            // Code 3
            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(113);
            // table.setHeaderRows(4);



            /* Image img = Image.getInstance( basePath+"Images/logo_1.JPG");
            img.scalePercent(50);
            PdfPCell cell = new PdfPCell();
            //  cell.setImage(img);
            cell.addElement(new Chunk(img, 5, 10));
            cell.setImage(img);
            cell.setColspan(1);
            cell.setFixedHeight(50);
            table.addCell(cell);*/


           Image img = Image.getInstance(basePath + "Images/logo_1.JPG");

            img.scalePercent(65);

            // PdfPTable table = new PdfPTable(3);
            PdfPCell cell = new PdfPCell();
            cell.setBorder(0);
            cell.addElement(new Chunk(img, 10, -35));

            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setTop(Element.ALIGN_TOP);

            table.addCell(cell);




            Font font12c = new Font(Font.NORMAL, 12, Font.BOLD);

            Chunk chunk6d = new Chunk(mInstName + "\n                   " + mInstAddress, font12c);
            Phrase ph6D = new Phrase(chunk6d);
            //ph6D.add("\n                                           ");
            //ph6D.add(mInstAddress);

            PdfPCell celld = new PdfPCell(new Paragraph(ph6D));

            celld.setColspan(3);
            celld.setBorder(0);
            //celld.setFixedHeight(50);
            celld.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld.setTop(Element.ALIGN_TOP);
//pdfHCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(celld);


            Font font12 = new Font(Font.BOLD, 11, Font.BOLD);
            Chunk chunkcd = new Chunk("                                                     Fee Receipt ", font12);
            Phrase phrasecd = new Phrase();
            phrasecd.add(chunkcd);
            // phrasecd.add("       Registrar Copy");
            PdfPCell cell5d = new PdfPCell(phrasecd);
            //table.addCell("");
            cell5d.setBorder(0);
            cell5d.setColspan(3);
            cell5d.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell5d);

            Font font1 = new Font(Font.NORMAL, 10, Font.BOLD);
//new Font(Font.NORMAL, 10, Font.BOLD);   new Font(Font.NORMAL, 9, Font.NORMAL);
            Chunk chunkc = new Chunk("Registrar Copy", font1);
            Phrase phrasec = new Phrase();
            phrasec.add(chunkc);
            PdfPCell cell1 = new PdfPCell(phrasec);
            cell1.setColspan(1);
            cell1.setBorder(0);
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);

            table.addCell(cell1);

            Chunk chunkx = new Chunk("      ", font12);
            Phrase phrasex = new Phrase();
            phrasex.add(chunkx);
            PdfPCell cellx = new PdfPCell(phrasex);
            cellx.setColspan(4);
            cellx.setBorder(0);
            table.addCell(cellx);



            Chunk chunka = new Chunk(" Name : " + mMemberName + "\n Enrollment No  : " + mDMemberCode + "\n Program : " + mProgname + "\n Semester :" + mSem, font1);
            Phrase phrasea = new Phrase();
            phrasea.add(chunka);

            PdfPCell cell12 = new PdfPCell(phrasea);
            cell12.setColspan(2);
            cell12.setPadding(4);
            cell12.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cell12);



            qry1 = " select distinct  ft.FeePAidSemester,ft.SemesterType,ft.FeeHead FeeHead , fh.FeeHeadDesc FeeHeadDesc ," +
                    " ft.FeeCurrencycode FeeCurrencycode," +
                    " ft.FeeCurrencyAmount FeeCurrencyAmount,ft.prno prno,ft.transactiontype transactiontype, " +
                    " InitCap(cm.ShortDesc) Shortdesc,TO_CHAR(d.PRDATE,'DD-MM-YYYY')PRDATE from   FeeTransactiondetail FT, FeeHeads FH,CurrencyMaster Cm,Feetransaction d" +
                    " where  Ft.Feehead          = fh.FeeHead and    ft.Institutecode    = fh.Institutecode" +
                    " and    ft.CompanyCode      = fh.CompanyCode and    ft.COmpanyCode      = '" + mCompanyCode + "'" +
                    " and    ft.prno             = '" + mPRNO + "' and    ft.TransactionType  = 'R' and  " +
                    "  nvl(fh.Deactive,'N')= 'N' And  cm.CurrencyCode = ft.FEECURRENCYCODE " +
                    "and ft.COMPANYCODE=d.COMPANYCODE and ft.INSTITUTECODE=d.INSTITUTECODE and ft.PRNO=d.PRNO " +
                    " and d.STUDENTID='" + mChkMemID + "' " +
                    "and ft.TRANSACTIONTYPE=d.TRANSACTIONTYPE and ft.FINANCIALYEAR=d.FINANCIALYEAR";


            rs = db.getRowset(qry1);

           if(rs.next()){
			 do{
                // FeeHeadDesc=rs.getString("FeeHeadDesc");
                Shortdesc1 = rs.getString("Shortdesc");
                //  FeeCurrencyAmount=rs.getDouble("FeeCurrencyAmount");

                mFeeAmount = mFeeAmount + rs.getDouble("FeeCurrencyAmount");
                PRDATE = rs.getString("PRDATE");
            } while (rs.next());


           // qry = "SELECT common.toWord(TO_CHAR(TO_DATE(" + mFeeAmount + ",'J'),'JSP')) towords FROM   dual";

                         // Query   common.toWord(" + mFeeAmount + ") towords FROM   dual"; Updated on date 01.01.2019 Vivek Soni

             qry = "SELECT common.toWord(" + mFeeAmount + ") towords FROM   dual";

            rs = db.getRowset(qry);
            if (rs.next()) {
                mFeeAmountWord = rs.getString("towords");
            }

            Chunk chunkf = new Chunk(" Receipt No. : BANK -" + mPRNO + "\n Date  : " + PRDATE + "\n Institute : " + mInstituteCodeTemp + "\n   ", font1);
            Phrase phrasef = new Phrase();
            phrasef.add(chunkf);

            PdfPCell cellf = new PdfPCell(phrasef);
            cellf.setColspan(2);
            cellf.setPadding(4);
            cellf.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cellf);


 qry2="select PAYMENTOPTION   from FeeChequeDDDetail where PRno = '" + mPRNO + "'  ";
     rs = db.getRowset(qry2);
            if(rs.next()) {
                payBy = rs.getString("PAYMENTOPTION");
            }

if("P".equalsIgnoreCase(payBy)){

      qry2 = "Select DISTINCT ' Online Payment with Transaction ID. '|| PARTICULARS sss,  DRAWNON from FeeChequeDDDetail " +
                    "where PRno = '" + mPRNO + "'  ";

}else{

      qry2 = "Select DISTINCT '  DD No. '|| DDNO ||' dated '|| TO_CHAR(DDDATE,'DD-MM-YYYY')sss,  DRAWNON from FeeChequeDDDetail " +
                    "where PRno = '" + mPRNO + "'  ";

}

            rs = db.getRowset(qry2);
            while (rs.next()) {
                DDNO = DDNO + rs.getString("sss");

                DRAWNON = rs.getString("DRAWNON");

            }



//+" "+ mFeeAmount + "( )"+ " from "+mMr+" "+ mMemberName +" "+ mDr +" "+mFatherName + "vide "+ DDNO +", Drawn on "+ DRAWNON +" on account of :-



            Font font2 = new Font(Font.NORMAL, 10, Font.NORMAL);

			Chunk chunkg = new Chunk("");
			if("P".equalsIgnoreCase(payBy)){

			 chunkg = new Chunk("Received with thanks a sum of " + Shortdesc1 + " " + df.format(mFeeAmount) + " ("+ Shortdesc1 +" " + mFeeAmountWord + " Only) " + " from " + mMr + "" + mMemberName + " " + mDr + " " + mFatherName + " through" + DDNO + " on account of :-", font2);

			}
			else{

			 chunkg = new Chunk("Received with thanks a sum of " + Shortdesc1 + " " + df.format(mFeeAmount) + " ("+ Shortdesc1 +" " + mFeeAmountWord + " Only) " + " from " + mMr + "" + mMemberName + " " + mDr + " " + mFatherName + " vide" + DDNO + ", Drawn on " + DRAWNON + " on account of :-", font2);

			}






			Phrase phraseg = new Phrase();
            phraseg.add(chunkg);
            PdfPCell cellg = new PdfPCell(phraseg);
            cellg.setColspan(4);
            cellg.setBorder(0);
            cellg.setPadding(4);
            cellg.setHorizontalAlignment(Element.ALIGN_LEFT);
            table.addCell(cellg);

  rs1 = db.getRowset(qry1);

            PdfPTable table1 = new PdfPTable(2);
            table1.setWidthPercentage(80);

             Chunk  chunkcd01 =new  Chunk("");
			 Phrase  phrasecd01 = new Phrase();
			  PdfPCell cell01=null;

            while (rs1.next()) {

                FeeHeadDesc = rs1.getString("FeeHeadDesc");
                Shortdesc = rs1.getString("Shortdesc");
                FeeCurrencyAmount = rs1.getDouble("FeeCurrencyAmount");

                 chunkcd01 = new Chunk(FeeHeadDesc, font2);
                 phrasecd01 = new Phrase();
                phrasecd01.add(chunkcd01);
                 cell01= new PdfPCell(phrasecd01);

                cell01.setNoWrap(true);
                cell01.setPadding(2);
                cell01.setBorder(0);
                cell01.setHorizontalAlignment(Element.ALIGN_LEFT);
                table1.addCell(cell01);


                 chunkcd01 = new Chunk(Shortdesc + "    " + df.format(FeeCurrencyAmount), font2);
                  phrasecd01 = new Phrase();
                  phrasecd01.add(chunkcd01);
                 cell01 = new PdfPCell(phrasecd01);
                // cell41.setColspan(2);
				  cell01.setNoWrap(true);
                cell01.setBorder(0);
                cell01.setPadding(2);
                cell01.setHorizontalAlignment(Element.ALIGN_LEFT);
                table1.addCell(cell01);


            }







            PdfPCell cellh = new PdfPCell();
            cellh.setColspan(4);
            cellh.setBorder(0);
            cellh.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellh.addElement(table1);
            table.addCell(cellh);




            Font font = new Font(Font.NORMAL, 10, Font.BOLD);
// to add total

                 table1 = new PdfPTable(2);
                 chunkcd01 = new Chunk("Total        : ", font);
                 phrasecd01 = new Phrase();
                 phrasecd01.add(chunkcd01);
                 cell01= new PdfPCell(phrasecd01);
                 cell01.setNoWrap(true);
                 cell01.setPadding(2);
                 cell01.setBorder(0);
                 cell01.setHorizontalAlignment(Element.ALIGN_RIGHT);
                 table1.addCell(cell01);


                 chunkcd01 = new Chunk(Shortdesc + "    " +df.format(mFeeAmount), font);
                 phrasecd01 = new Phrase();
                 phrasecd01.add(chunkcd01);
                 cell01= new PdfPCell(phrasecd01);
                 cell01.setNoWrap(true);
                 cell01.setPadding(2);
                 cell01.setBorder(0);
                 cell01.setHorizontalAlignment(Element.ALIGN_LEFT);
                 table1.addCell(cell01);

             cellh = new PdfPCell();
            cellh.setColspan(4);
            cellh.setBorder(0);
            cellh.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellh.addElement(table1);
            table.addCell(cellh);


            Chunk chunk = new Chunk("\n\n\n" +"                                                       " +"  For " + mInstituteCode + "\n\n" + "Note: Cheque/DD/Online Payment subject to realisation.               Authorized Signatory", font);
            Phrase phrase = new Phrase();
            phrase.add(chunk);

            PdfPCell cell8 = new PdfPCell(phrase);
            cell8.setColspan(4);
            cell8.setBorder(0);
            cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(cell8);

////////////////////////////////////////
///////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


            // Code 3
            PdfPTable tableS = new PdfPTable(4);
            tableS.setWidthPercentage(113);
            img.scalePercent(65);
             cell = new PdfPCell();
            cell.setBorder(0);
            cell.addElement(new Chunk(img, 10, -35));

            cell.setHorizontalAlignment(Element.ALIGN_CENTER);
            cell.setTop(Element.ALIGN_TOP);

            tableS.addCell(cell);




             font12c = new Font(Font.NORMAL, 12, Font.BOLD);

             chunk6d = new Chunk(mInstName + "\n                   " + mInstAddress, font12c);
             ph6D = new Phrase(chunk6d);
            //ph6D.add("\n                                           ");
            //ph6D.add(mInstAddress);

             celld = new PdfPCell(new Paragraph(ph6D));

            celld.setColspan(3);
            celld.setBorder(0);
            //celld.setFixedHeight(50);
            celld.setHorizontalAlignment(Element.ALIGN_LEFT);
            celld.setTop(Element.ALIGN_TOP);
//pdfHCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(celld);


             font12 = new Font(Font.BOLD, 11, Font.BOLD);
             chunkcd = new Chunk("                                                     Fee Receipt ", font12);
             phrasecd = new Phrase();
            phrasecd.add(chunkcd);
            // phrasecd.add("       Registrar Copy");
             cell5d = new PdfPCell(phrasecd);
            //table.addCell("");
            cell5d.setBorder(0);
            cell5d.setColspan(3);
            cell5d.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell5d);

             font1 = new Font(Font.NORMAL, 10, Font.BOLD);
//new Font(Font.NORMAL, 10, Font.BOLD);   new Font(Font.NORMAL, 9, Font.NORMAL);
             chunkc = new Chunk("Student Copy", font1);
             phrasec = new Phrase();
            phrasec.add(chunkc);
             cell1 = new PdfPCell(phrasec);
            cell1.setColspan(1);
            cell1.setBorder(0);
            cell1.setHorizontalAlignment(Element.ALIGN_CENTER);

            tableS.addCell(cell1);

             chunkx = new Chunk("      ", font12);
             phrasex = new Phrase();
            phrasex.add(chunkx);
             cellx = new PdfPCell(phrasex);
            cellx.setColspan(4);
            cellx.setBorder(0);
            tableS.addCell(cellx);



             chunka = new Chunk(" Name : " + mMemberName + "\n Enrollment No  : " + mDMemberCode + "\n Program : " + mProgname + "\n Semester :" + mSem, font1);
             phrasea = new Phrase();
            phrasea.add(chunka);

             cell12 = new PdfPCell(phrasea);
            cell12.setColspan(2);
            cell12.setPadding(4);
            cell12.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cell12);



            qry1 = " select distinct  ft.FeePAidSemester,ft.SemesterType,ft.FeeHead FeeHead , fh.FeeHeadDesc FeeHeadDesc ," +
                    " ft.FeeCurrencycode FeeCurrencycode," +
                    " ft.FeeCurrencyAmount FeeCurrencyAmount,ft.prno prno,ft.transactiontype transactiontype, " +
                    " InitCap(cm.ShortDesc) Shortdesc,TO_CHAR(d.PRDATE,'DD-MM-YYYY')PRDATE from   FeeTransactiondetail FT, FeeHeads FH,CurrencyMaster Cm,Feetransaction d" +
                    " where  Ft.Feehead          = fh.FeeHead and    ft.Institutecode    = fh.Institutecode" +
                    " and    ft.CompanyCode      = fh.CompanyCode and    ft.COmpanyCode      = '" + mCompanyCode + "'" +
                    " and    ft.prno             = '" + mPRNO + "' and    ft.TransactionType  = 'R' and  " +
                    "  nvl(fh.Deactive,'N')= 'N' And  cm.CurrencyCode = ft.CurrencyCode " +
                    "and ft.COMPANYCODE=d.COMPANYCODE and ft.INSTITUTECODE=d.INSTITUTECODE and ft.PRNO=d.PRNO " +
                    " and d.STUDENTID='" + mChkMemID + "' " +
                    "and ft.TRANSACTIONTYPE=d.TRANSACTIONTYPE and ft.FINANCIALYEAR=d.FINANCIALYEAR";






             chunkf = new Chunk(" Receipt No. : BANK -" + mPRNO + "\n Date  : " + PRDATE + "\n Institute : " + mInstituteCodeTemp + "\n   ", font1);
             phrasef = new Phrase();
            phrasef.add(chunkf);

             cellf = new PdfPCell(phrasef);
            cellf.setColspan(2);
            cellf.setPadding(4);
            cellf.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cellf);


             font2 = new Font(Font.NORMAL, 10, Font.NORMAL);

			 chunkg = new Chunk("");
			if("P".equalsIgnoreCase(payBy)){

			 chunkg = new Chunk("Received with thanks a sum of " + Shortdesc1 + " " + df.format(mFeeAmount) + " ("+ Shortdesc1 +" " + mFeeAmountWord + " Only) " + " from " + mMr + "" + mMemberName + " " + mDr + " " + mFatherName + " through" + DDNO + " on account of :-", font2);

			}
			else{

			 chunkg = new Chunk("Received with thanks a sum of " + Shortdesc1 + " " + df.format(mFeeAmount) + " ("+ Shortdesc1 +" " + mFeeAmountWord + " Only) " + " from " + mMr + "" + mMemberName + " " + mDr + " " + mFatherName + " vide" + DDNO + ", Drawn on " + DRAWNON + " on account of :-", font2);

			}






			 phraseg = new Phrase();
            phraseg.add(chunkg);
             cellg = new PdfPCell(phraseg);
            cellg.setColspan(4);
            cellg.setBorder(0);
            cellg.setPadding(4);
            cellg.setHorizontalAlignment(Element.ALIGN_LEFT);
            tableS.addCell(cellg);



             table1 = new PdfPTable(2);
            table1.setWidthPercentage(80);

            rs1 = db.getRowset(qry1);

			 Chunk  chunkcd1 =new  Chunk("");
			 Phrase  phrasecd1 = new Phrase();
			  PdfPCell cell3=null;
            while (rs1.next()) {

                FeeHeadDesc = rs1.getString("FeeHeadDesc");
                Shortdesc = rs1.getString("Shortdesc");
                FeeCurrencyAmount = rs1.getDouble("FeeCurrencyAmount");

                // mFeeAmount=mFeeAmount+rs1.getDouble("FeeCurrencyAmount");


                 chunkcd1 = new Chunk(FeeHeadDesc, font2);
                 phrasecd1 = new Phrase();
                phrasecd1.add(chunkcd1);
                 cell3 = new PdfPCell(phrasecd1);

                cell3.setNoWrap(true);
                cell3.setPadding(2);
                cell3.setBorder(0);
                cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
                table1.addCell(cell3);


                 chunkcd1 = new Chunk(Shortdesc + "    " + df.format(FeeCurrencyAmount), font2);
                  phrasecd1 = new Phrase();
                  phrasecd1.add(chunkcd1);
                 cell3 = new PdfPCell(phrasecd1);
                // cell41.setColspan(2);
				  cell3.setNoWrap(true);
                cell3.setBorder(0);
                cell3.setPadding(2);
                cell3.setHorizontalAlignment(Element.ALIGN_LEFT);
                table1.addCell(cell3);


            }



             cellh = new PdfPCell();
            cellh.setColspan(4);
            cellh.setBorder(0);
            cellh.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellh.addElement(table1);
            tableS.addCell(cellh);




 font = new Font(Font.NORMAL, 10, Font.BOLD);
// to add total

                 table1 = new PdfPTable(2);
                 chunkcd01 = new Chunk("Total        : ", font);
                 phrasecd01 = new Phrase();
                 phrasecd01.add(chunkcd01);
                 cell01= new PdfPCell(phrasecd01);
                 cell01.setNoWrap(true);
                 cell01.setPadding(2);
                 cell01.setBorder(0);
                 cell01.setHorizontalAlignment(Element.ALIGN_RIGHT);
                 table1.addCell(cell01);


                 chunkcd01 = new Chunk(Shortdesc + "    " +df.format(mFeeAmount), font);
                 phrasecd01 = new Phrase();
                 phrasecd01.add(chunkcd01);
                 cell01= new PdfPCell(phrasecd01);
                 cell01.setNoWrap(true);
                 cell01.setPadding(2);
                 cell01.setBorder(0);
                 cell01.setHorizontalAlignment(Element.ALIGN_LEFT);
                 table1.addCell(cell01);

             cellh = new PdfPCell();
            cellh.setColspan(4);
            cellh.setBorder(0);
            cellh.setHorizontalAlignment(Element.ALIGN_LEFT);
            cellh.addElement(table1);
            tableS.addCell(cellh);


             chunk = new Chunk("\n\n\n" +"                                                       " +"  For " + mInstituteCode + "\n\n" + "Note: Cheque/DD/Online Payment subject to realisation.               Authorized Signatory", font);
             phrase = new Phrase();
            phrase.add(chunk);

             cell8 = new PdfPCell(phrase);
            cell8.setColspan(4);
            cell8.setBorder(0);
            cell8.setHorizontalAlignment(Element.ALIGN_CENTER);
            tableS.addCell(cell8);





























////////////////////////////////////S/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////



//---------------------------------------------------------------------------------------------


            PdfPTable table2D = new PdfPTable(4);
            table2D.setWidthPercentage(200);

            Chunk chunk6 = new Chunk("\n\n\n\n\n - - - - - - - - - - - - - - - - - - - please tear from here - - - - - - - - - - - - - - - - - -\n\n\n\n\n\n", font1);
            Phrase ph6 = new Phrase(chunk6);
            ph6.add("\n");
            PdfPCell cell6 = new PdfPCell(new Paragraph(ph6));
            cell6.setColspan(4);
            cell6.setBorder(0);
            cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            table2D.addCell(cell6);


            document.add(table);

            document.add(table2D);

            document.add(tableS);


 }else{

  PdfPTable table2 = new PdfPTable(4);
            table2.setWidthPercentage(200);

            Chunk chunk6 = new Chunk("\n\n\n\n\n - - - - - - - - - - - - - - - - - - - Data Not Found - - - - - - - - - - - - - - - - - -\n\n\n\n\n\n", font1);
            Phrase ph6 = new Phrase(chunk6);
            ph6.add("\n");
            PdfPCell cell6 = new PdfPCell(new Paragraph(ph6));
            cell6.setColspan(4);
            cell6.setBorder(0);
            cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            table2.addCell(cell6);

  document.add(table2);
 }


			document.close();



        //----------------------



        } catch (DocumentException e) {
            e.printStackTrace();
        }
%>

    </body>
</html>
