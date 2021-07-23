/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * updated on 03092019
 */
var rc = 0;
var gridData = {};
var totalCount=0;
(function($) {
    $.fn.getServace = function(para)
    {
         //alert(JSON.stringify(para));
        $.ajax({
            type: 'POST',
            timeout: 50000,
            dataType: "json",
            handller: para.handller,
            url: '../' + para.service,
            data : 'jdata='+JSON.stringify(para).replace(/&/g,"").replace(/%/g,"")+'&d='+new Date(),
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
        case 'generateReport':
            gridData = jQuery.parseJSON(xhr.responseText);
            totalCount = gridData["totalrecords"];
            getGridData(gridData);
            break;
        case 'designationComboReport':
            $("#designation").empty();
            $("#designation").append(xhr.responseText);
            getDepartment();
            break;
        case 'departmentComboReport':
            $("#department").empty();
            $("#department").append(xhr.responseText);
            getGrade();
            break;
        case 'gradeComboReport':
            $("#grade").empty();
            $("#grade").append(xhr.responseText);
            break;
    }
});

function getCommonMasterTable()
{

}
function generateReportEM()
{
    if (jQuery.trim($('#companyCode').val()) == 0) {
        alert("Please Select the Company Code.");
        $('#companyCode').focus();
        return false;
    }
    if (jQuery.trim($('#employeeType').val()) == 0) {
        alert("Please Select the Employee Type.");
        $('#employeeType').focus();
        return false;
    }
    $("#total").html("");
    $("#gridhead").html("");
    $("#gridbody").html("");
    $("#gridbody").html(" <tr><td><img src='images/progressbar.gif' /></td></tr>");
    jData = {};
    jData.companyCode = $("#companyCode").val();
    jData.employeeType = $("#employeeType").val();
    jData.designation = $("#designation").val();
    jData.department = $("#department").val();
    jData.grade = $("#grade").val();
    jData.deactive = $("#deactive").val();
    jData.gender = $("#gender").val();
    jData.service = "EmployeeMasterServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}

function exportReport()
{
    if (jQuery.trim($('#companyCode').val()) == 0) {
        alert("Please Select the Company Code.");
        $('#companyCode').focus();
        return false;
    }
    if (jQuery.trim($('#employeeType').val()) == 0) {
        alert("Please Select the Employee Type.");
        $('#employeeType').focus();
        return false;
    }
    jData = {};
    jData.companyCode = $("#companyCode").val();
    jData.employeeType = $("#employeeType").val();
    jData.designation = $("#designation").val();
    jData.department = $("#department").val();
    jData.grade = $("#grade").val();
    jData.deactive = $("#deactive").val();
    jData.gender = $("#gender").val();
    jData.handller = "exportReport";
     jQuery("<form action='../EmployeeMasterServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
    //$(document).getServace(jData);
}

function getGridData() {

    var table = "";
    var rMarks="";
    var apiScore="";
   if(gridData[0]!=0){
   $("#total").html("<font color='Black' size='3' style='font-family:arial;width:2%'><b>Total Records</b></font>:-<b>"+totalCount+"<b>");
   $("#gridhead").html("");
   // $("#gridhead").html("<input type='hidden' name='institute' id='institute' value="+$("#instituteCode").val()+">");
      $("#gridhead").html("<tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Company Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Institute Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Designation</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Department</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Basic Pay</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Date of Joining</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Employee Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Grade</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Category Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Emp. Category Code</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Deactive</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:7%'>Current Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Current District</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Current State</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:7%'>Permanent Address</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Permanent District</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Permanent State</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Phone No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Mobile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Office Phone</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:4%'>Email ID</font></td></tr>");

    for (var key in gridData) {
        if(key!="totalrecords"){
                table = table + "<tr><td  style='width: 1%'><font size='1' style='font-family:arial'>" + key + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["companyCode"]==""?"&nbsp;":gridData[key]["companyCode"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["INSTITUTECODE"]==""?"&nbsp;":gridData[key]["INSTITUTECODE"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["employeeCode"]==""?"&nbsp;":gridData[key]["employeeCode"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["employeeName"]==""?"&nbsp;":gridData[key]["employeeName"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["fatherName"]==""?"&nbsp;":gridData[key]["fatherName"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["designation"]==""?"&nbsp;":gridData[key]["designation"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["department"]==""?"&nbsp;":gridData[key]["department"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["basicPay"]==""?"&nbsp;":gridData[key]["basicPay"]) + "</font></td>";
                table = table + "<td  style='width: 4%' nowrap><font size='1' style='font-family:arial'>" + (gridData[key]["dateOfBoirth"]==""?"&nbsp;":gridData[key]["dateOfBoirth"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["dateOfJoining"]==""?"&nbsp;":gridData[key]["dateOfJoining"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["employeeType"]==""?"&nbsp;":gridData[key]["employeeType"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["gradeCode"]==""?"&nbsp;":gridData[key]["gradeCode"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["categoryCode"]==""?"&nbsp;":gridData[key]["categoryCode"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["empCategoryCode"]==""?"&nbsp;":gridData[key]["empCategoryCode"]) + "</font></td>";
                table = table + "<td  style='width: 1%'><font size='1' style='font-family:arial'>" + (gridData[key]["gender"]==""?"&nbsp;":gridData[key]["gender"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["deactive"]==""?"&nbsp;":gridData[key]["deactive"]) + "</font></td>";
                table = table + "<td  style='width: 7%'><font size='1' style='font-family:arial'>" + (gridData[key]["currentAddress"]==""?"&nbsp;":gridData[key]["currentAddress"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["currentDistrict"]==""?"&nbsp;":gridData[key]["currentDistrict"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["currentState"]==""?"&nbsp;":gridData[key]["currentState"]) + "</font></td>";
                table = table + "<td  style='width: 7%'><font size='1' style='font-family:arial'>" + (gridData[key]["permanentAddress"]==""?"&nbsp;":gridData[key]["permanentAddress"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["permanentDistrict"]==""?"&nbsp;":gridData[key]["permanentDistrict"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["permanentState"]==""?"&nbsp;":gridData[key]["permanentState"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["phoneNo"]==""?"&nbsp;":gridData[key]["phoneNo"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["mobile"]==""?"&nbsp;":gridData[key]["mobile"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["officePhone"]==""?"&nbsp;":gridData[key]["officePhone"]) + "</font></td>";
                table = table + "<td  style='width: 4%'><font size='1' style='font-family:arial'>" + (gridData[key]["emailID"]==""?"&nbsp;":gridData[key]["emailID"]) + "</font></td></tr>";
        }}}else{
        $("#total").html("");
        $("#gridhead").html("");
        table =table+ "<tr bgcolor='red'><td><b><font size='1' style='font-family:arial;' color='white'>No Records Found</font></b></td></tr>";
    }
    if(gridData[0]!=0)
        {
       //table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='hidden' name='exceldata'  value='"+table.replace("'","\"")+"'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='9'><input type='submit' id='generateReport' value='Generate Report'  ></td></tr>";
       table = table + "<tr><td colspan='9' style='width: 50%' align='right'><input type='button' id='printReport' value='Print' onclick='JavaScript:window.print();' ></td><td style='width: 50%' colspan='9'><input type='button' id='generateReport' value='Generate Report' onclick='exportReport()' ></td></tr>";
        }
    $("#gridbody").html("");
    $("#gridbody").html("" + table);

}


function getDesignation()
{
    jData = {};
    jData.companyCode = $("#companyCode").val();
    jData.employeeType = $("#employeeType").val();
    jData.service = "CommonComboServlet";
    jData.handller = "designationComboReport";
    jData.comboId = "designationComboReport";
    $(document).getServace(jData);
}

function getDepartment()
{
    jData = {};
    jData.companyCode = $("#companyCode").val();
    jData.employeeType = $("#employeeType").val();
    jData.service = "CommonComboServlet";
    jData.handller = "departmentComboReport";
    jData.comboId = "departmentComboReport";
    $(document).getServace(jData);
}

function getGrade()
{
    jData = {};
    jData.companyCode = $("#companyCode").val();
    jData.employeeType = $("#employeeType").val();
    jData.service = "CommonComboServlet";
    jData.handller = "gradeComboReport";
    jData.comboId = "gradeComboReport";
    $(document).getServace(jData);
}