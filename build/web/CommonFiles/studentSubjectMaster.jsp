<%-- 
    Document   : studentSubjectMaster
    Created on : 26 Sep, 2015, 4:16:36 PM
    Author     : nipun.gupta
--%>
<!DOCTYPE html>
<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="ExceptionHandler.jsp" %> 
<%@page import="jilit.db.CommonComboData"%>
<%
    String mHead = "", mInstCode = "";
    String mCandCode = "", MName = "";
    String mCandName = "";
    String URL = "";

    if (session.getAttribute("PageHeading") != null && !session.getAttribute("PageHeading").equals("")) {
        mHead = session.getAttribute("PageHeading").toString().trim();
    } else {
        mHead = "JIIT ";
    }
%>
<HTML>
    <head>
        <style type="text/css" media="print">

            @media print
            {
                @page { size: landscape; }
                #non-printable { display: none; }
                #printable {
                    display: block;
                    width: 1500;
                }
            }

        </style>
        <script type="text/javascript" src="js/sortabletable.js"></script>
        <script type="text/javascript" src="js/json2.js"></script>
        <link type="text/css" rel="StyleSheet" href="css/sortabletable.css" />
        <link rel="stylesheet" href="../IQAC/css/Style.css">
        <link rel="stylesheet" href="../IQAC/css/jquery-ui.css"/>
        <TITLE>JIIT </TITLE>
        <script src="../IQAC/js/jquery/jquery-1.10.2.js"></script>
        <script src="../IQAC/js/jquery/jquery-ui.js"></script>
        <script src="../IQAC/js/jquery/yattable.js"></script>
        <script src="../IQAC/js/jquery/numeric-1.0.js"></script>
        <script src="../IQAC/js/IQTest/CommonServiceJs.js"></script>
        <script src="../IQAC/js/IQTest/ComboJs.js"></script>
        <script src="js/studentSubjectMasterJS.js"></script>
        <script>
            $(document).ready(function() {

                getCommonMasterTable();
            });
        </script>
        <style>
            .custom-combobox {
                position: relative;
                display: inline-block;
                font-size: 15px;
            }
            .custom-combobox-toggle {
                position: absolute;
                top: 0;
                bottom: 0;
                margin-left: -1px;
                padding: 0;
                font-size: 15px;
            }
            .custom-combobox-input {
                margin: -1px;
                padding: 0px 0px;
                font-size: 15px;
            }
            a {

                font-size: 12px;
            }
            .ui-autocomplete {
                max-height: 300px;
                overflow-y: auto;
                /* prevent horizontal scrollbar */
                overflow-x: hidden;
                /* add padding to account for vertical scrollbar */
                padding-right: 20px;
            } 
            
        </style>
        <script>
            (function($) {
                $.widget("custom.combobox", {
                    _create: function() {
                        this.wrapper = $("<span>")
                                .addClass("custom-combobox")
                                .insertAfter(this.element);

                        this.element.hide();
                        this._createAutocomplete();
                        this._createShowAllButton();
                    },
                    _createAutocomplete: function() {
                        var selected = this.element.children(":selected"),
                                value = selected.val() ? selected.text() : "";
                        this.input = $("<input>")
                                .appendTo(this.wrapper)
                                .val(value)
                                .attr("title", "")
                                .addClass("custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left")
                                .autocomplete({
                            delay: 0,
                            minLength: 0,
                            source: $.proxy(this, "_source")
                        })
                                .tooltip({
                            tooltipClass: "ui-state-highlight"
                        });

                        this._on(this.input, {
                            autocompleteselect: function(event, ui) {
                                ui.item.option.selected = true;
                                this._trigger("select", event, {
                                    item: ui.item.option
                                });
                            },
                            autocompletechange: "_removeIfInvalid"
                        });
                    },
                    _createShowAllButton: function() {
                        var input = this.input,
                                wasOpen = false;

                        $("<a>")
                                .attr("tabIndex", -1)
                                .attr("title", "Subjects")
                                .tooltip()
                                .appendTo(this.wrapper)
                                .button({
                            icons: {
                                primary: "ui-icon-triangle-1-s"
                            },
                            text: false
                        })
                                .removeClass("ui-corner-all")
                                .addClass("custom-combobox-toggle ui-corner-right")
                                .mousedown(function() {
                            wasOpen = input.autocomplete("widget").is(":visible");
                        })
                                .click(function() {
                            input.focus();

                            // Close if already visible
                            if (wasOpen) {
                                return;
                            }

                            // Pass empty string as value to search for, displaying all results
                            input.autocomplete("search", "");
                        });
                    },
                    _source: function(request, response) {
                        var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                        response(this.element.children("option").map(function() {
                            var text = $(this).text();
                            if (this.value && (!request.term || matcher.test(text)))
                                return {
                                    label: text,
                                    value: text,
                                    option: this
                                };
                        }));
                    },
                    _removeIfInvalid: function(event, ui) {
                        // Selected an item, nothing to do
                        if (ui.item) {
                            return;
                        }
                        // Search for a match (case-insensitive)
                        var value = this.input.val(),
                                valueLowerCase = value.toLowerCase(),
                                valid = false;
                        this.element.children("option").each(function() {
                            if ($(this).text().toLowerCase() === valueLowerCase) {
                                this.selected = valid = true;
                                return false;
                            }
                        });
                        // Found a match, nothing to do
                        if (valid) {
                            return;
                        }

                        // Remove invalid value

                        this.input
                                .val("")
                                .attr("title", value + " didn't match any item")
                                .tooltip("open");
                        this.element.val("");
                        this._delay(function() {
                            this.input.tooltip("close").attr("title", "");
                        }, 2500);
                        this.input.autocomplete("instance").term = "";
                    },
                    _destroy: function() {
                        this.wrapper.remove();
                        this.element.show();
                    }
                });
            })(jQuery);

            $(function() {
                $("#subject").combobox();

            });
        </script>
    </head>
    <body aLink=#ff00ff bgcolor="#fce9c5" rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0>
        <%
            CommonComboData ccd = new CommonComboData();
            //GlobalFunctions gb =new GlobalFunctions();
            DBHandler db = new DBHandler();
            String mMemberID = "", mMemberType = "", mMemberName = "", mMemberCode = "";
            String mDMemberCode = "", mDMemberType = "", mDept = "", mDesg = "", mInst = "", minst = "", mDMemberID = "";
            String qry = "", mEnOrNm = "", x = "", cInst = "", mCheck = "", institute = "";
            int msno = 0;
            ResultSet rs = null;
            if (session.getAttribute("Designation") == null) {
                mDesg = "";
            } else {
                mDesg = session.getAttribute("Designation").toString().trim();
            }

            if (session.getAttribute("Department") == null) {
                mDept = "";
            } else {
                mDept = session.getAttribute("Department").toString().trim();
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

            if (session.getAttribute("InstituteCode") == null) {
                mInstCode = "JIIT";
            } else {
                mInstCode = session.getAttribute("InstituteCode").toString().trim();
            }
            session.setAttribute("INSCODE", " ");
            OLTEncryption enc = new OLTEncryption();
            if (!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) {
                mDMemberCode = enc.decode(mMemberCode);
                mDMemberType = enc.decode(mMemberType);
                mDMemberID = enc.decode(mMemberID);

                String mChkMemID = enc.decode(session.getAttribute("MemberID").toString().trim());
                String mChkMType = enc.decode(session.getAttribute("MemberType").toString().trim());
                String mIPAddress = session.getAttribute("IPADD").toString().trim();
                String mRole = enc.decode(session.getAttribute("ROLENAME").toString().trim());
                ResultSet RsChk1 = null;
                //-----------------------------
                //-- Enable Security Page Level  
                //-----------------------------
                qry = "Select WEBKIOSK.ShowLink('388','" + mChkMemID + "','" + mChkMType + "','" + mRole + "','" + mIPAddress + "') SL from dual";
                RsChk1 = db.getRowset(qry);
                if (RsChk1.next() && RsChk1.getString("SL").equals("Y")) {

        %>

        <form name="studentSubjectMasterReport">
            <div id="non-printable"> 
                <table cellpadding=2 cellspacing=2 align=center rules=groups border=1 width="80px">
                    <tr><td align="center" colspan='4' bgcolor='#c00000'><font color=white size='2'><b>Student Subject Master</b></font></td></tr>
                    <tr>
                        <td style="text-align: right;" nowrap><FONT size="2">Institute Code<span class="req"> *</span> :</font></td><td style="text-align: left"><select  name='instituteCode' id='instituteCode'  class='combo' style=''  title='Institute Code' onchange="getExamCode()"><%=ccd.commonJspCombo("{\"comboId\":\"instituteCodeCombo\"}")%></select></td>
                        <td style="text-align: right" nowrap><FONT size="2">Exam Code<span class="req"> *</span> :</font></td><td style="text-align: left">
                            <select  name='examCode' id='examCode'  class='combo' style=''  title='Exam Code' onchange="getSubject()">
                                <option value='0'>Select Exam Code</option>     
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right"><FONT size="2">LTP:</font></td><td style="text-align: left">
                            <select  name='ltp' id='ltp'  class='combo' style=''  title='LTP' onchange="getSubject()">
                                <option value='0'>Select LTP</option>  
                                <option value='L'>L</option>  
                                <option value='T'>T</option>  
                                <option value='P'>P</option>  
                            </select></td>
                        <td style="text-align: right"><FONT size="2">Deactive:</font></td><td style="text-align: left">
                            <select  name='deactive' id='deactive'  class='combo' style=''  title='Deactive'>
                                <option value='0'>Select Deactive</option>
                                <option value='Y'>Yes</option>
                                <option value='N'>No</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right"><FONT size="2">Subjects:</font></td><td style="text-align: left;">
                            <select  name='subject' id='subject'  class='combo' style='font-size: 12px;'  title='Subject'>
                            </select>

                        </td>
                        <td id="excelSubjects" onclick="generateExcelReportForSubjects()" style="cursor: pointer;" nowrap></td>
                        <td colspan="2" align="right"><input type="button" id="submitReport" value="Submit"  style="margin-right: 60%" onclick="generateReportSSM()"></td> 
                    </tr>
                    
                </table>
            </div>
            <div id="printable">
                <div id="total">
                </div>
                <table class="sort-table" id="TblStdView" rules='ALL' style="width:auto;" cellSpacing=0 cellPadding=0  align=center border=1>
                    <thead id="gridhead">
                    </thead>
                    <tbody id="gridbody" style="width:auto;">
                    </tbody>
                </table>
            </div>
        </form>



        <%                //-----------------------------
            //-- Enable Security Page Level  
            //-----------------------------
        } else {
        %>
        <br>
        <font color=red>
        <h3>	<br><img src='../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
        <P>	This page is not authorized/available for you.
            <br>For assistance, contact your network support team. 
            </font>	<br>	<br>	<br>	<br>
            <%           }
                    //-----------------------------




                } else {
                    out.print("<br><img src='Images/Error1.jpg'>");
                    out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='index.jsp'>Login</a> to continue</font> <br>");
                }

            %>
    </body>
</html>                              