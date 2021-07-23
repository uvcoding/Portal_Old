          /* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var rc = 0;
var gridData = {};
var cupage = {};
var selectSupervisorInfo = {};
var selectStudentInfo = {};
(function($) {
    $.fn.getServace = function(para)
    {
        // alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,""),
            error: function() {
                rc++;
                if (rc != 3) {

                }
                $("errorDiv").html("An Error Occured With Request.....");
            }
        });
        return this;
    };
}(jQuery));


$(document).ajaxComplete(function(event, xhr, settings) {
    switch (settings.handller) {
        case 'selectSupervisorInfo':
            selectSupervisorInfo = jQuery.parseJSON(xhr.responseText);
            getSelectSupervisorInfoInPopUp(selectSupervisorInfo);
            $('#TOTAL').html("Total No.of Record(s): " + selectSupervisorInfo[1].totalrecords);
            break;
        case 'selectStudentInfo':
            selectStudentInfo = jQuery.parseJSON(xhr.responseText);
            getSelectStudentInfoInPopUp(selectStudentInfo);
            $('#TOTALStudent').html("Total No.of Record(s): " + selectStudentInfo[1].totalrecords);
            break;
        case 'setDepartment':
            var selectDepartmentInfo = jQuery.parseJSON(xhr.responseText);
            $("#departmentCode").val(selectDepartmentInfo["departmentCode"]);
            $("#departmentName").val(selectDepartmentInfo["departmentName"]);
            break;
        case 'saveupdate':
            if(xhr.responseText!="")
                {
                    alert("Record Saved Successfully");
                }
            resetValues();
            break;
        case 'select':
            gridData = jQuery.parseJSON(xhr.responseText);
            if (gridData["0"] != 0) {
            getGridData(gridData);
            $('#TOT').html("Total No.of Record(s): " + gridData[1].totalrecords);
             }
            break;
        case 'SelectforUpdate':
            var selectData = jQuery.parseJSON(xhr.responseText);
            $("#projectID").val(selectData["projectID"]);
            $("#projectCode").val(selectData["projectCode"]);
            $("#projectTitle").val(selectData["projectTitle"]);
            $("#studentName").val(selectData["studentName"]+"-"+selectData["enrollNo"]);
            $("#supervisorName").val(selectData["employeeName"]);
            $("#departmentCode").val(selectData["departmentCode"]);
            $("#departmentName").val(selectData["departmentName"]);
            $("#projectLevel").val(selectData["projectLevel"]);
            $("#projectStatusAsOnDate").val(selectData["projectStatusOnDate"]);
            $("#projectPerStatus").val(selectData["projectPerStaus"]);
            $("#projectRemarks").val(selectData["projectRemarks"]);
            $("#projectAPIScore").val(selectData["projectAPIScore"]);
            if (selectData["active"] == 'N')
            {
                $("#activeN").prop("checked", true);
            } else
            {
                $("#activeY").prop("checked", true)
            }
             $("#academicYear").val(selectData["academicYear"]);
             $("#studentID").val(selectData["studentID"]);
             $("#staffID").val(selectData["staffID"]);
            getProjectStatus();
            break;
    }
});





function getCommonMasterTable()
{
    $("#activeY").prop("checked", true);
    $(".number").numeric();
    $("#projectStatus").prop("disabled", true); 
   $("#paggingPopUp").getPagging();
   $("#paggingPopUp1").getPagging();
   $("#supervisorNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    }); 
    $("#studentNameTable").yattable({
        width: "100%",
        height: 150,
        scrolling: "yes"
    }); 
    $("#pagging").getPagging();
    getSelectGridData("0");
    
    cupage.pr = 0;
    $("#previous").hide();
    $("#first").hide();
    
//    $("#pagging").click(function() {
//        cupage.pr = eval($("#pagging").val());
//    });
    $("#first").click(function() {
        getSelectGridData("0");
        cupage.pr = 0;
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#previous").click(function() {
        getSelectGridData((eval(cupage.pr) - eval($("#pagging").val())));
        cupage.pr = (eval(cupage.pr) - eval($("#pagging").val()));
        if (cupage.pr == "0") {
            $("#previous").hide();
            $("#first").hide();
        }
        $("#next").show();
        $("#last").show();
    });
    $("#next").click(function() {
        getSelectGridData((eval(cupage.pr) + eval($("#pagging").val())));
        cupage.pr = (eval(cupage.pr) + eval($("#pagging").val()));
        if (cupage.pr > (eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())))
        {
            $("#next").hide();
            $("#last").hide();
        }
        $("#previous").show();
        $("#first").show();
    });
    $("#last").click(function() {
    
        getSelectGridData((eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val())));
        cupage.pr = (eval(gridData[1].totalrecords) / eval($("#pagging").val()) * eval($("#pagging").val()) - eval($("#pagging").val()));
        $("#next").hide();
        $("#last").hide();
        $("#previous").show();
        $("#first").show();
    });
    
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
   
    if(dd<10){
        dd="0"+dd
    } 
    if (mm < 10) {
        $("#projectStatusAsOnDate").val(dd + "-" +"0"+ mm + "-" + yyyy);
    } else
    {
        $("#projectStatusAsOnDate").val(dd + "-" + mm + "-" + yyyy);
    }
}

function getProjectStatus()
{
    
    var projectPerStatus = $("#projectPerStatus").val();
    if (eval(projectPerStatus) < 100 && eval(projectPerStatus) > 0)
    {
        $("#projectStatus").val("On going");
    }
    if (eval(projectPerStatus) == 0)
    {
        $("#projectStatus").val("Rejected");
    }
    if (eval(projectPerStatus) == 100)
    {
        $("#projectStatus").val("Complete");
    }
    
    if (projectPerStatus == "")
    {
        $("#projectStatus").val("");
    }
    if (eval(projectPerStatus)>100)
    {
        alert("Please Enter Project(% of work) between 0 to 100");
        $("#projectPerStatus").val("");
        $("#projectStatus").val("");
        $("#projectPerStatus").focus();
    }
}

$(function() {
    $("#supervisorNames").dialog({
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width:$( window ).width()-130,
        height:300
        
    });
    $("#supervisorName").click(function() {
        $("#searchNames").val("");
        $("#supervisorNames").dialog("open");
        getSupervisorNames("0");

    });
});

function getSupervisorNames(pno)
{
    
    jData = {};
    if ($("#paggingPopUp").val() == "ALL") {
        jData.epg = selectSupervisorInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp").val()));
    }
    jData.spg = pno;
    jData.searchNames = $("#searchNames").val();
    jData.companyID = $("#compsession").val();
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "selectSupervisorInfo";
    $(document).getServace(jData);

}

function getSelectSupervisorInfoInPopUp(){
     var table = "";
     $("#popupHeader").html("");
     $("#popupHeader").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Supervisor Code</th><th style='width: 48%'>Supervisor Name</th>");
    
     for (var key in selectSupervisorInfo) {
        table = table + "<tr ondblclick='setNames("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectSupervisorInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectSupervisorInfo[key]["employeeCode"] + "</td><td  style='width: 48%;text-align: left'>" + selectSupervisorInfo[key]["employeename"] + "</td></tr>";
    }

    $("#supervisorNameBody").html("");
    $("#supervisorNameBody").html("" + table);
   
 $("#popupHeaderTable").css("width",$("#supervisorNameBody").width());
}

$(document).keydown(function(e) {
    if (e.keyCode == 13) {
      getSupervisorNames("0");
      getStudentNames("0");
      getSelectGridData("0");
    }
});

$(function() {
    $("#studentNames").dialog({
        autoOpen: false,
        show: {
            effect: "blind",
            duration: 1000
        },
        hide: {
            effect: "explode",
            duration: 1000
        },
        width:$( window ).width()-130,
        height:300
        
    });
    $("#studentName").click(function() {
        $("#searchNamesStudent").val("");
        $("#studentNames").dialog("open");
        getStudentNames("0");

    });
});

function getStudentNames(pno)
{
    
    jData = {};
    if ($("#paggingPopUp1").val() == "ALL") {
        jData.epg = selectStudentInfo[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#paggingPopUp1").val()));
    }
    jData.spg = pno;
    jData.searchNames = $("#searchNamesStudent").val();
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "selectStudentInfo";
    $(document).getServace(jData);

}

function getSelectStudentInfoInPopUp(){
     var table = "";
     $("#popupHeader1").html("");
     $("#popupHeader1").html("<th style='width: 5%'>S No.</th><th style='width: 47%'>Enrollment Number</th><th style='width: 48%'>Student Name</th>");
    
     for (var key in selectStudentInfo) {
        table = table + "<tr ondblclick='setNamesStudent("+key+")'  style='cursor:pointer;'><td  style='width: 5%;text-align: left'>" + selectStudentInfo[key]["sno"] + "</td><td  style='width: 47%;text-align: left'>" + selectStudentInfo[key]["enrollmentNo"] + "</td><td  style='width: 48%;text-align: left'>" + selectStudentInfo[key]["studentName"] + "</td></tr>";
    }

    $("#studentNameBody").html("");
    $("#studentNameBody").html("" + table);
   
 $("#popupHeaderTable1").css("width",$("#studentNameBody").width());
}

function setNames(key)
{
    $("#staffID").val(selectSupervisorInfo[key]["employeeID"]);
    $("#supervisorName").val(selectSupervisorInfo[key]["employeename"]);
    $("#supervisorNames").dialog("close");
    
}

function setNamesStudent(key)
{
    $("#studentID").val(selectStudentInfo[key]["studentID"]);
    $("#studentName").val(selectStudentInfo[key]["studentName"]+"-"+selectStudentInfo[key]["enrollmentNo"]);
    $("#studentNames").dialog("close");
    jData = {};
    jData.programCode = selectStudentInfo[key]["programCode"];
    jData.branchCode = selectStudentInfo[key]["branchCode"];
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "setDepartment";
    $(document).getServace(jData);
}

function formsubmit()
{
    
    if (jQuery.trim($('#projectTitle').val()) == "") {
        alert("Please Enter the Project Title.");
        $('#projectTitle').focus();
        return false;
    } 
    if (jQuery.trim($('#studentName').val()) == "") {
        alert("Please Enter the Student Name.");
        $('#studentName').focus();
        return false;
    } 
    if (jQuery.trim($('#supervisorName').val()) == "") {
        alert("Please Enter the Supervisor Name.");
        $('#supervisorName').focus();
        return false;
    } 
    if (jQuery.trim($('#departmentName').val()) ==0) {
        alert("Please Select the Department Name.");
        $('#departmentName').focus();
        return false;
    } 
    if (jQuery.trim($('#projectLevel').val()) == 0) {
        alert("Please Select the Project Level.");
        $('#projectLevel').focus();
        return false;
    } 
    if (jQuery.trim($('#projectStatusAsOnDate').val()) == "") {
        alert("Please Enter the Project Status Date.");
        $('#projectStatusAsOnDate').focus();
        return false;
    } 
    if (jQuery.trim($('#projectPerStatus').val()) == "") {
        alert("Please Enter the Project(% of work).");
        $('#projectPerStatus').focus();
        return false;
    } 
    
    
    if ($('input[name=active]:checked').length <= 0)
    {
        alert("Please choose Active Y/N.");
        return false;
    }
    if (jQuery.trim($('#academicYear').val()) ==0) {
        alert("Please Select the Academic Year.");
        $('#academicYear').focus();
        return false;
    } 
    
    
    
    
    jData = {};
    jData.projectID = $("#projectID").val();
    jData.companyid = $("#compsession").val();
    jData.projectCode = $("#projectCode").val();
    jData.projectTitle=$("#projectTitle").val();
    jData.studentID=$("#studentID").val();
    jData.staffID=$("#staffID").val();
    jData.departmentCode=$("#departmentCode").val();
    jData.projectLevel=$("#projectLevel").val();
    jData.projectStatusAsOnDate=$("#projectStatusAsOnDate").val();
    jData.projectPerStatus=$("#projectPerStatus").val();
    jData.projectStatus=getProjectStatusCode($("#projectStatus").val());
    jData.projectRemarks=$("#projectRemarks").val();
    jData.projectAPIScore=$("#projectAPIScore").val();
    if ($("#activeY").prop("checked")) {
        jData.deactive="N";
    }
    if ($("#activeN").prop("checked")) {
        jData.deactive="Y";
    }
    jData.entryBy = $("#entryBy").val();
    jData.academicYear=$("#academicYear").val();
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "saveupdate";
    $(document).getServace(jData);  
}

function getProjectStatusCode(projectStatus)
{
    var pStatus = "";
    if (projectStatus == "On going")
    {
        pStatus = "O";
    }
    if (projectStatus == "Complete")
    {
        pStatus = "C";
    }
    if (projectStatus == "Rejected")
    {
        pStatus = "R";
    }
    return pStatus;
}

function getProjectStatusName(pStatus)
{
   var tempValue="";
   if(pStatus=="O")
   {
     tempValue="On going";  
   }
   if(pStatus=="C")
   {
     tempValue="Complete";  
   }
   if(pStatus=="R")
   {
     tempValue="Rejected";  
   }
   return tempValue; 
}

function resetValues()
{
    $("#projectID").val("0");
    $("#staffID").val("0");
    $("#studentID").val("0");
    $("#projectCode").val("");
    $("#projectTitle").val("");
    $("#studentName").val("");
    $("#supervisorName").val("");
    $("#departmentName").val("");
    $("#projectLevel").val("0");
    $("#projectPerStatus").val("");
    $("#projectStatus").val("");
    $("#projectStatusAsOnDate").val("");
    $("#projectRemarks").val("");
    $("#projectAPIScore").val("");
    $("input:radio").attr("checked", false);
    $("#academicYear").val("");
    location.reload();

}

function  getSelectGridData(pno) {

    jData = {};
    if ($("#pagging").val() == "ALL") {
        jData.epg = gridData[1].totalrecords;
    } else {
        jData.epg = (eval(pno) + eval($("#pagging").val()));
    }
    jData.spg = pno;
    jData.searchbox = $("#searchbox").val();
    jData.companyID = $("#compsession").val();
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "select";
    $(document).getServace(jData);
}

function getGridData() {
    $("#mastergrid").yattable({
        width: "100%",
        height: 300,
        scrolling: "yes"
    });
    var table = "";
    var rMarks="";
    var apiScore="";
   $("#gridhead").html("");
      $("#gridhead").html("<th style='width: 5%'>Sl No.</th><th style='width: 8%'>Department Name</th><th style='width: 8%'>Project Code</th><th style='width: 12%'>Project Title</th><th style='width: 8%'>Student Name</th><th style='width: 8%'>Supervisor Name</th><th style='width: 8%'>Project Level</th><th style='width: 8%'>Project % of Work</th><th style='width: 8%'>Project Status</th><th style='width: 8%'>Project Remarks</th><th style='width: 8%'>Project API Score</th><th style='width: 6%'>Active Y/N</th><th style='width: 5%'></th>");

    for (var key in gridData) {
        rMarks=gridData[key]["projectRemarks"];
        apiScore=gridData[key]["projectAPIScore"];
        if(rMarks==null)
            {
             rMarks="";   
            }
            if(apiScore==null)
            {
             apiScore="";   
            }
        table = table + "<tr><td  style='width: 5%'>" + gridData[key]["slno"] + "</td><td  style='width: 8%'>" + gridData[key]["departmentName"] + "</td><td  style='width: 8%'>" + gridData[key]["projectCode"] + "</td><td  style='width: 12%'>" + gridData[key]["projectTitle"] + "</td>";
        table = table + "<td  style='width: 8%'>" + gridData[key]["studentName"] +"-"+gridData[key]["enrollNo"]+ "</td><td  style='width: 8%'>" + gridData[key]["employeeName"] + "</td><td  style='width: 8%'>" + getProjectLevel(gridData[key]["projectLevel"]) + "</td>";
        table = table + "<td  style='width: 8%'>" + gridData[key]["projectPerStatus"] + "</td><td  style='width: 8%'>" +getProjectStatusName(gridData[key]["projectStatus"]) + "</td><td  style='width: 8%'>" + rMarks+ "</td>";
        table = table + "<td  style='width: 8%'>" + apiScore + "</td><td  style='width: 6%'>" + gridData[key]["active"] + "</td>";
        table = table + "<td style='width: 5%;'><img src='../images/edit.png' style='cursor: pointer'  title='Edit Record' onclick='updateMasterRecord(\"" + gridData[key]["projectID"] + "\")'></td></tr>";
    }

    $("#gridbody").html("");
    $("#gridbody").html("" + table);
    $("#mastergrid1").css("width", $("#mastergrid").width());

}

function getProjectLevel(pLevel)
{
    var tempValue="";
   if(pLevel=="P")
   {
     tempValue="Ph.D";  
   }
   if(pLevel=="M")
   {
     tempValue="Master";  
   }
   return tempValue; 
}

function updateMasterRecord(projectID)
{
    jData = {};
    jData.service = "ProjectMasterMasterPhdServlet";
    jData.handller = "SelectforUpdate";
    jData.projectID = projectID;
    $(document).getServace(jData);
}