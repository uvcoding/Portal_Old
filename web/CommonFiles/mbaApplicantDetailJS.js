/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
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
            debugger;
            gridData = jQuery.parseJSON(xhr.responseText);
            totalCount = gridData["totalrecords"];
            getGridData(gridData);
            break;
    }
});

function getCommonMasterTable()
{
    
}

function generateReportMBAApplicantDetail()
{
    alert("1212");
    if (jQuery.trim($('#admissionYear').val()) == 0) {
        alert("Please Select the Admission Year.");
        $('#admissionYear').focus();
        return false;
        
    } 
    if (jQuery.trim($('#applicationType').val()) == 0) {
        alert("Please Select the Application Type.");
        $('#applicationType').focus();
        return false;
    } 
    if (jQuery.trim($('#sortBy').val()) == 0) {
        alert("Please Select the Sort By.");
        $('#sortBy').focus();
        return false;
    } 
    $("#total").html("");
    $("#gridhead").html("");
    $("#gridbody").html("");
    $("#gridbody").html(" <tr><td><img src='images/progressbar.gif' /></td></tr>");
    jData = {};
    jData.admissionYear = $("#admissionYear").val();
    jData.applicationType = $("#applicationType").val();
    jData.sortBy = $("#sortBy").val();
    jData.service = "MBAApplicantDetailServlet";
    jData.handller = "generateReport";
    $(document).getServace(jData);
}


function exportReport()
{
     if (jQuery.trim($('#admissionYear').val()) == 0) {
        alert("Please Select the Admission Year.");
        $('#admissionYear').focus();
        return false;
    } 
    if (jQuery.trim($('#applicationType').val()) == 0) {
        alert("Please Select the Application Type.");
        $('#applicationType').focus();
        return false;
    } 
    if (jQuery.trim($('#sortBy').val()) == 0) {
        alert("Please Select the Sort By.");
        $('#sortBy').focus();
        return false;
    } 
    
    jData = {};
    jData.admissionYear = $("#admissionYear").val();
    jData.applicationType = $("#applicationType").val();
    jData.sortBy = $("#sortBy").val();
    jData.handller = "exportReport";
     jQuery("<form action='../MBAApplicantDetailServlet' method='post' target ='_blank'><input type='hidden' name='jdata'  value='"+(JSON.stringify(jData))+"'></form>").appendTo("body").submit().remove();
}


function getGridData() {
    
    
    
    var table = "";
    var rMarks="";
    var apiScore="";
   if(gridData[0]!=0){
   $("#total").html("<font color='Black' size='3' style='font-family:arial;width:2%'><b>Total Records</b></font>:-<b>"+totalCount+"<b>");  
   $("#gridhead").html("");
   // $("#gridhead").html("<input type='hidden' name='institute' id='institute' value="+$("#instituteCode").val()+">");
      $("#gridhead").html("<tr bgcolor='#c00000'><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Sno</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application SL No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Application No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Student Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Father Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Date of Birth</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Category</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:1%'>Gender</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address1</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:6%'>Address2</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>City</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>State</font></td><td nowrap><b><font color='white' size='1' style='font-family:arial;width:3%'>Pin</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Phone No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Email ID</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Stream</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>CAT Percentile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>CAT Score</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>MAT Percentile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>MAT Score</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>CMAT Percentile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>CMAT Score</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>CMAT Rank</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>GMAT Percentile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>GMAT Score</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>GMAT Rank</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>XAT Percentile</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>XAT Score</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>XAT Rank</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:3%'>Check Score Card</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD No</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Date</font></td> <td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Cheque DD Type</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Amount</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Bank Name</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Grad.PERCENTAGE</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Grad.PassYr</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>Grad.Univ.</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>10th Per(%)</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>10thPassYr</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>10th Board</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>12th.Per(%)</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>12th.PassYr</font></td><td ><b><font color='white' size='1' style='font-family:arial;width:2%'>12th.Board</font></td></tr>");

    for (var key in gridData) {
        if(key!="totalrecords"){
        table = table + "<tr><td  style='width: 1%'><font size='1' style='font-family:arial'>" + key + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["applicationSLNO"]==""?"&nbsp;":gridData[key]["applicationSLNO"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["applicationNO"]==""?"&nbsp;":gridData[key]["applicationNO"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["studentName"]==""?"&nbsp;":gridData[key]["studentName"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["fatherName"]==""?"&nbsp;":gridData[key]["fatherName"]) + "</font></td>";
	table = table + "<td  style='width: 3%' nowrap><font size='1' style='font-family:arial'>" + (gridData[key]["dateOfBirth"]==""?"&nbsp;":gridData[key]["dateOfBirth"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["category"]==""?"&nbsp;":gridData[key]["category"]) + "</font></td>";
	table = table + "<td  style='width: 1%'><font size='1' style='font-family:arial'>" + (gridData[key]["gender"]==""?"&nbsp;":gridData[key]["gender"]) + "</font></td>";
        table = table + "<td  style='width: 6%'><font size='1' style='font-family:arial'>" + (gridData[key]["address1"]==""?"&nbsp;":gridData[key]["address1"]) + "</font></td>";
	table = table + "<td  style='width: 6%'><font size='1' style='font-family:arial'>" +(gridData[key]["address2"]==""?"&nbsp;":gridData[key]["address2"])+ "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["city"]==""?"&nbsp;":gridData[key]["city"])+"</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["stateName"]==""?"&nbsp;":gridData[key]["stateName"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["pin"]==""?"&nbsp;":gridData[key]["pin"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["phone"]==""?"&nbsp;":gridData[key]["phone"]) + "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["emailID"]==""?"&nbsp;":gridData[key]["emailID"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["stream"]==""?"&nbsp;":gridData[key]["stream"])+ "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["catPercentile"]==""?"&nbsp;":gridData[key]["catPercentile"])+ "</font></td>";
        table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["catScore"]==""?"&nbsp;":gridData[key]["catScore"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["matPercentile"]==""?"&nbsp;":gridData[key]["matPercentile"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["matScore"]==""?"&nbsp;":gridData[key]["matScore"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["cmatPercentile"]==""?"&nbsp;":gridData[key]["cmatPercentile"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["cmatScore"]==""?"&nbsp;":gridData[key]["cmatScore"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["cmatRank"]==""?"&nbsp;":gridData[key]["cmatRank"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["gmatPercentile"]==""?"&nbsp;":gridData[key]["gmatPercentile"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["gmatScore"]==""?"&nbsp;":gridData[key]["gmatScore"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["gmatRank"]==""?"&nbsp;":gridData[key]["gmatRank"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["xatPercentile"]==""?"&nbsp;":gridData[key]["xatPercentile"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["xatScore"]==""?"&nbsp;":gridData[key]["xatScore"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["xatRank"]==""?"&nbsp;":gridData[key]["xatRank"]) + "</font></td>";
	table = table + "<td  style='width: 3%'><font size='1' style='font-family:arial'>" + (gridData[key]["checkScoreCard"]==""?"&nbsp;":gridData[key]["checkScoreCard"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDNo"]==""?"&nbsp;":gridData[key]["chequeDDNo"]) + "</font></td>";
        table = table + "<td  style='width: 2%' nowrap><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDDate"]==""?"&nbsp;":gridData[key]["chequeDDDate"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["chequeDDType"]==""?"&nbsp;":gridData[key]["chequeDDType"])+ "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["amount"]==""?"&nbsp;":gridData[key]["amount"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["bankName"]==""?"&nbsp;":gridData[key]["bankName"]) + "</font></td>";
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["gradPer"]==""?"&nbsp;":gridData[key]["gradPer"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["gradYop"]==""?"&nbsp;":gridData[key]["gradYop"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["gradUni"]==""?"&nbsp;":gridData[key]["gradUni"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["tenPer"]==""?"&nbsp;":gridData[key]["tenPer"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["tenYop"]==""?"&nbsp;":gridData[key]["tenYop"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["tenBrd"]==""?"&nbsp;":gridData[key]["tenBrd"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["twePer"]==""?"&nbsp;":gridData[key]["twePer"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["tweYop"]==""?"&nbsp;":gridData[key]["tweYop"]) + "</font></td>"
        table = table + "<td  style='width: 2%'><font size='1' style='font-family:arial'>" + (gridData[key]["tweBrd"]==""?"&nbsp;":gridData[key]["tweBrd"]) + "</font></td></tr>"

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


