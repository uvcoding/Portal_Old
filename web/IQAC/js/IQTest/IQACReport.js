/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var IqacReport_uri="";
var IqacReport = function() {
  this.url1 = "http://localhost:8084/JIIT/rest/IqacReportServices";
  this.typ="get";
  this.contType="application/json";
};

/*function pdfGenerate(pdfData){
 // alert("Gyan");
  IqacReport_uri='/FacultyFeedbackReortinPdf?pdfData='+pdfData+'';
  ReqResforParentReportinPDF(IqacReport_uri,"reportpart");
        }*/

function printDiv()
{ var newWin;
//alert("GYAN");
  var divToPrint=document.getElementById('report');
//alert("Bhatt");
//window.open("", "", "width=200, height=100");

newWin=window.open("","","width=100%,height=100%");

//alert("Bhatt");

  newWin.document.open();

  newWin.document.write('<html><head></head><body onload="window.print()" >'+divToPrint.innerHTML+'</body></html>');

  newWin.document.close();

 }



$(document).ready(function(){
 var url = window.location.pathname;
var filename = url.substring(url.lastIndexOf('/')+1);
if(filename=='ShFacultyFeedbackReport.jsp')
{
    $("#Institute").change(function(){
     IqacReport_uri='/feedbakcid?institute='+$("#Institute").val()+'';//alert(IqacReport_uri);
  ReqResforCombobox(IqacReport_uri,"feedbackid");
    });
    $("#feedbackid").change(function(){
     IqacReport_uri='/acadmicyear?institute='+$("#Institute").val()+'&feedbackid='+$("#feedbackid").val()+'';//alert(IqacReport_uri);
  ReqResforCombobox(IqacReport_uri,"acdyear");
    });
$("#submitbutton_ShFaculty").click(function(){

if($("#Institute").val()=='')
    {alert("Please select a Institute  ");return false;};

if($("#feedbackid").val()=='')
    {alert("Please select a feedbackid  ");return false;};


IqacReport_uri='/ShFacultyFeedBackReport?feedbackid='+$("#feedbackid").val()+'&institute='+$("#Institute").val()+'&acdyear='+$("#acdyear").val()+'';
//alert(IqacReport_uri);
ReqResforParentReport(IqacReport_uri,"reportpart");
});

}
if(filename=='FacultyFeedbackTransReport.jsp')
{
  IqacReport_uri='/comapnyforfacultytrans';//alert(IqacReport_uri);
  ReqResforCombobox(IqacReport_uri,"company");


$("#company").change(function(){
  IqacReport_uri='/instituteforfacultytrans?company='+$("#company").val()+'';
  ReqResforCombobox(IqacReport_uri,"Institute");
});

$("#Institute").change(function(){
 //
 IqacReport_uri='/academicyearforfacultytrans?instititute='+$("#Institute").val()+'&company='+$("#company").val()+'';
//  alert(IqacReport_uri);
  ReqResforCombobox(IqacReport_uri,"acadyear");
});

$("#acadyear").change(function(){
  IqacReport_uri='/departmentforfacultytrans?instititute='+$("#Institute").val()+'&company='+$("#company").val()+'&academicyear='+$("#acadyear").val()+'';
  ReqResforCombobox(IqacReport_uri,"department");
});

$("#department").change(function(){
  IqacReport_uri='/programforfacultytrans?instititute='+$("#Institute").val()+'&company='+$("#company").val()+'&academicyear='+$("#acadyear").val()+'&department='+$("#department").val()+'';
  ReqResforCombobox(IqacReport_uri,"program");
});

$("#submitbutton_facultyTrans").click(function(){
 if($("#company").val()=='')
    {alert("Please select a company  ");return false;};
if($("#Institute").val()=='')
    {alert("Please select a Institute  ");return false;};
if($("#acadyear").val()=='')
    {alert("Please select a academic year  ");return false;};
if($("#department").val()=='')
    {alert("Please select a department ");return false;};
if($("#program").val()=='')
    {alert("Please select a program ");return false;};
IqacReport_uri='/NonTechFacultyFeedBackReport?instititute='+$("#Institute").val()+'&company='+$("#company").val()+'&academicyear='+$("#acadyear").val()+'&department='+$("#department").val()+'&program='+$("#program").val()+'';
//alert(IqacReport_uri);
ReqResforParentReport(IqacReport_uri,"reportpart");
});




}

//------------------------------------------------------Faculty Feedback Count(Start)...........................................//

if(filename=='FacultyFeedBackCount.jsp')
{
$("#submitButton_FacultyCount").click(function(){
var feedback="";
//alert($("#Feedback1").prop("checked"));
if($("#Feedback1").prop("checked"))
{feedback='Y';
}else{
    feedback='N';

}




IqacReport_uri='/FacultyFeedbackCount?examcode='+$("#examcode").val()+'&LTP='+$("#LTP").val()+'&Feedback='+feedback;

ReqResforParentReport(IqacReport_uri,"reportpart");
});



}

//------------------------------------------------------Faculty Feedback Count(END)...........................................//



//-----------------------------------Faculty Feedback Summary Report(Start)--------------------------------------------------------------------//

if(filename=='FacultyFeedbackSummary.jsp')
{
$("#submitButton_FacultySummary").click(function(){

//alert("SATENDRA");





IqacReport_uri='/FacultyFeedbackSummary?instcode='+$("#instcode").val()+'&Feedbackcid='+$("#Feedbackcid").val()+'&examcode='+$("#examcode").val()+'&userid='+$("#userid").val()+'';
alert(IqacReport_uri);
ReqResforParentReport(IqacReport_uri,"reportpart");
});



}

//------------------------------------Faculty Feedback Summary Report (End)---------------------------------------------------------------------//


//-----------------------------------IT Services  Report(Start)--------------------------------------------------------------------//

if(filename=='ITServicesReport.jsp')
{
$("#ITServicesSummary").click(function(){


//alert("jhiii"+$("#instcode").val());
IqacReport_uri='/ITServicesReport?instcode='+$("#instcode").val()+'&EventCombo='+$("#EventCombo").val()+'&userid='+$("#userid").val()+'';

ReqResforParentReport(IqacReport_uri,"reportpart");
});



}

//------------------------------------IT Services  Report(Start) Report (End)---------------------------------------------------------------------//

if(filename=='AlumnifeedbackReport.jsp')
{
   IqacReport_uri='/institute_Alumni';//alert(IqacReport_uri);
   ReqResforCombobox(IqacReport_uri,"institute");

$("#institute").change(function(){
  IqacReport_uri='/academicyear_Alumni?institute='+$("#institute").val()+'';
ReqResforCombobox(IqacReport_uri,"academicyear");
});



$("#academicyear").change(function(){
  IqacReport_uri='/program_Alumni?academicyear='+$("#academicyear").val()+'&institute='+$("#institute").val()+'';
ReqResforCombobox(IqacReport_uri,"programcode1");
});

$("#programcode1").change(function(){
  IqacReport_uri='/branch_Alumni?academicyear='+$("#academicyear").val()+'&institute='+$("#institute").val()+'&program='+$("#programcode1").val()+'';
ReqResforCombobox(IqacReport_uri,"branch");
});

}
if(filename=='ParentfeedbackBranchwiseReport.jsp')
{
   IqacReport_uri='/institute';//alert(IqacReport_uri);
   ReqResforCombobox(IqacReport_uri,"institute");

}



if(filename=='NonTechingStaffFeedback.jsp')
{
IqacReport_uri='/AcademicyearForNonTec?institute='+$("#sessioninstitute").val();
ReqResforCombobox(IqacReport_uri,"acadyear");
$("#department").click(function(){
    if($("#acadyear").val()=='')
    {alert("Please choose academic year first ");return false;}});
$("#acadyear").change(function(){
IqacReport_uri='/DepartmentForNontec?academicyear='+$("#acadyear").val()+'';
ReqResforCombobox(IqacReport_uri,"department");
});

$("#submitbutton_NonTech").click(function(){
 if($("#acadyear").val()=='')
    {alert("Please choose academic year ");return false;};
if($("#department").val()=='')
    {alert("Please choose department  ");return false;};
IqacReport_uri='/NonTechFeedBackReport?academicyear='+$("#acadyear").val()+'&department='+$("#department").val()+'';
//alert(IqacReport_uri);
ReqResforParentReport(IqacReport_uri,"reportpart");
});
}


if(filename=='FacultyFeedbackReport.jsp')
{//
$("#examcode").click(function(){
    if($("#facultyfeedbackid").val()=='')
    {alert("Please choose faculty feedbackid first ");return false;}
});
$("#subject").click(function(){
    if($("#examcode").val()=='')
    {alert("Please choose examcode first ");return false;}
});
$("#facultyfeedbackid").change(function(){
    //alert("Gyan");
   IqacReport_uri='/examcodebasedonfstid?fstid='+$("#facultyfeedbackid").val()+'&institute='+$("#sessioninstitute").val()+'';
   alert("11111"+IqacReport_uri);
   ReqResforCombobox(IqacReport_uri,"examcode");
});

$("#examcode").change(function(){
    IqacReport_uri='/subjecttaggedEmployee?institute='+$("#sessioninstitute").val()+'&company='+$("#sessioncompany").val()+'&faculty='+$("#sessionloginid").val()+'&examcode='+$("#examcode").val()+'&feedbackid='+$("#facultyfeedbackid").val()+'';
   // alert(IqacReport_uri);
    ReqResforCombobox(IqacReport_uri,"facultyfeedbacksubject");
   // alert(IqacReport_uri+"1222222");
});

$("#submitbutton_FacultyFeedback").click(function(){
    //alert("Gyan");
     IqacReport_uri='/FacultyFeedbackReort?institute='+$("#sessioninstitute").val()+'&feedbackid='+$("#facultyfeedbackid").val()+'&company='+$("#sessioncompany").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#sessionloginid").val()+'&subject='+$("#facultyfeedbacksubject").val()+'&department='+$("#sessiondepartment").val()+'';
   alert(IqacReport_uri);
   ReqResforParentReport(IqacReport_uri,"reportpart");
    });


}


if(filename=='StudFeedbackAnalysisTheoryReport.jsp')
   {
    $("#examcode").click(function(){
    if($("#institute").val()=='')
    {alert("Please choose institute first ");return false;}
});
$("#faculty").click(function(){
    if($("#examcode").val()=='')
    {alert("Please choose exam code first ");return false;}
});
$("#subject").click(function(){
    if($("#faculty").val()=='')
    {alert("Please choose faculty first ");return false;}
});
$("#branchcode").click(function(){
    if($("#subject").val()=='')
    {alert("Please choose subject first ");return false;}
});
$("#section").click(function(){
    if($("#branchcode").val()=='')
    {alert("Please choose branch code first ");return false;}
});





$("#examcode").change(function(){
IqacReport_uri='/faculty?institute='+$("#institute").val()+'&company='+$("#company").val()+'&examcode='+$("#examcode").val()+'';
ReqResforCombobox(IqacReport_uri,"faculty");
});

$("#faculty").change(function(){
IqacReport_uri='/academicyearfor_EmpandExamcode?institute='+$("#institute").val()+'&company='+$("#company").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#faculty").val()+'';
ReqResfortextbox(IqacReport_uri,"acadyear");
});

$("#submitbutton_StudThoery").click(function(){

      if($("#company").val()=='')
    {alert("Please choose company ");return false;}
     if($("#institute").val()=='')
    {alert("Please choose institute");return false;}
     if($("#examcode").val()=='')
    {alert("Please choose examcode");return false;}
     if($("#faculty").val()=='')
    {alert("Please choose faculty");return false;}
     if($("#subject").val()=='')
    {alert("Please choose subject");return false;}
    if($("#branchcode").val()=='')
    {alert("Please choose branch");return false;}
    if($("#section").val()=='')
    {alert("Please choose sub section ");return false;}





        IqacReport_uri='/StudentFeedbackforTheory?institute='+$("#institute").val()+'&company='+$("#company").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#faculty").val()+'&subject='+$("#subject").val()+'&acadyear='+$("#acadyear").val()+'&branch='+$("#branchcode").val()+'';
        ReqResforParentReport(IqacReport_uri,"reportpart");
        })
$("#subject").change(function(){
        IqacReport_uri='/SectionBranchForSubject?institute='+$("#institute").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#faculty").val()+'&subject='+$("#subject").val()+'&acadyear='+$("#acadyear").val()+'';
        ReqResforCombobox(IqacReport_uri,"branchcode");
        });
$("#branchcode").change(function(){
IqacReport_uri='/sectionBranchForBrach?institute='+$("#institute").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#faculty").val()+'&acadyear='+$("#acadyear").val()+'&branch='+$("#branchcode").val()+'&subject='+$("#subject").val()+'';
ReqResforCombobox(IqacReport_uri,"section");
});


   }

$("#academicyear").click(function(){
    if($("#institute").val()=='')
    {alert("Please choose institute first ");return false;}
});
$("#programcode").click(function(){
    if($("#academicyear").val()=='')
    {alert("Please choose academic year first ");return false;}
});
$("#branch").click(function(){
    if($("#programcode").val()=='')
    {alert("Please choose program code first ");return false;}
});
$("#studentid").click(function(){
    if($("#branch").val()=='')
    {alert("Please choose branch code first ");return false;}
});
$("#academicyear").change(function(){
 IqacReport_uri='/'+$("#institute").val()+'/'+$("#academicyear").val();
ReqResforCombobox(IqacReport_uri,"programcode");
});
$("#institute").change(function(){

if(filename=='StudFeedbackAnalysisTheoryReport.jsp')
   {
IqacReport_uri='/examcode?institute='+$("#institute").val();
ReqResforCombobox(IqacReport_uri,"examcode");
}else{

 IqacReport_uri='/academicyear?institute='+$("#institute").val();
ReqResforCombobox(IqacReport_uri,"academicyear");
}});


$("#programcode").change(function(){
IqacReport_uri='/'+$("#institute").val()+'/'+$("#programcode").val()+'/'+$("#academicyear").val();
ReqResforCombobox(IqacReport_uri,"branch");
});
$("#branch").change(function(){
IqacReport_uri='/'+$("#institute").val()+'/'+$("#programcode").val()+'/'+$("#branch").val()+'/'+$("#academicyear").val();
ReqResforCombobox(IqacReport_uri,"studentid");
});





$("#submitbutton_Parent").click(function(){

/* if($("#company").val()=='')
    {alert("Please choose company ");return false;}
    if($("#institute").val()=='')
    {alert("Please choose institute ");return false;}*/
     if($("#academicyear").val()=='')
    {alert("Please choose academic year ");return false;}
     if($("#programcode").val()=='')
    {alert("Please choose program code ");return false;}
//     if($("#branch").val()=='')
      if($("#studentid").val()=='')
 {alert("Please choose Student ");return false;}
//alert("gyan");
IqacReport_uri='/parentreport?institute='+$("#institute").val()+'&program='+$("#programcode").val()+'&branch='+$("#branch").val()+'&acadyear='+$("#academicyear").val()+'&studentid='+$("#studentid").val()+'';
ReqResforParentReport(IqacReport_uri,"reportpart");
});

$("#submitbutton_ParentBranchWise").click(function(){

/* if($("#company").val()=='')
    {alert("Please choose company ");return false;}
    if($("#institute").val()=='')
    {alert("Please choose institute ");return false;}*/
     if($("#academicyear").val()=='')
    {alert("Please choose academic year ");return false;}
     if($("#programcode").val()=='')
    {alert("Please choose program code ");return false;}
//     if($("#branch").val()=='')
      if($("#branch").val()=='')
 {alert("Please choose branch ");return false;}
//alert("gyan");
IqacReport_uri='/parentreportBranchwise?institute='+$("#institute").val()+'&program='+$("#programcode").val()+'&branch='+$("#branch").val()+'&acadyear='+$("#academicyear").val()+'';
ReqResforParentReport(IqacReport_uri,"reportpart");
});
$("#submitbutton_Alumni").click(function(){

/* if($("#company").val()=='')
    {alert("Please choose company ");return false;}
    if($("#institute").val()=='')
    {alert("Please choose institute ");return false;}*/
     if($("#academicyear").val()=='')
    {alert("Please choose academic year ");return false;}
     if($("#programcode").val()=='')
    {alert("Please choose program code ");return false;}
//     if($("#branch").val()=='')
      if($("#branch").val()=='')
 {alert("Please choose branch ");return false;}
//alert("gyan");
IqacReport_uri='/alumnifeedback?institute='+$("#institute").val()+'&program='+$("#programcode1").val()+'&branch='+$("#branch").val()+'&acadyear='+$("#academicyear").val()+'';
ReqResforParentReport(IqacReport_uri,"reportpart");
});



});

function ReqResforCombobox(IqacReport_uri,element)
{ try{var R1 = new IqacReport();
   alert(R1.url1+IqacReport_uri+"$$$$$"+R1.typ+"^^^^^"+R1.contType);
 $.ajax({
         url:R1.url1+IqacReport_uri,
         type:R1.typ,
         contentType:R1.contType,
         success:function(e){
        $("#"+element).empty();
        $("#"+element).append("<option value=''>Select</option>");
        alert("success");
for (var key in e)
            {
            $("#"+element).append("<option value='"+key+"'>"+ e[key]+"</option>");
            }},

        error : function (){

            alert("Error in geting Program...");
            }
    });
}catch(e)
{
    alert(e);
}
}

function ReqResfortextbox(IqacReport_uri,element)
{try{var R1 = new IqacReport();
  // alert(R1.url1+IqacReport_uri+"$$$$$"+R1.typ+"^^^^^"+R1.contType);
 $.ajax({
         url:R1.url1+IqacReport_uri,
        type:R1.typ,
        contentType:R1.contType,
            success:function(e){
              //  alert(e);
                $("#"+element).empty();
                $("#"+element).val(e);
                IqacReport_uri='/subjecttaggedforEmployee?institute='+$("#institute").val()+'&company='+$("#company").val()+'&examcode='+$("#examcode").val()+'&faculty='+$("#faculty").val()+'&acdemicyear='+e+'';
                ReqResforCombobox(IqacReport_uri,"subject");
},
            error : function (){
           //    alert("Error in geting rndlab...");
            }
        });
    }catch(e)

    {
       // alert(e);
    }
}

function xlsFormatfn()
{
    var fileName = "Faculty_FeedBack_Report_Xl";
    var htmlData="<html><head></head><body ><center><table id=reporttable style=z-index:5%;width:100% >";
    htmlData=htmlData+"<tr><td style=text-align:center;width:100%;height:20%;  colspan=2><font size=3 >";
    htmlData=htmlData+"<u>Institute Academic Quality Assurance Cell<br>Stackholder Relationship<br>Faculty Feedback Transaction Report</u>";
    htmlData=htmlData+"<br><br></font></td></tr></table></center>"+$("#report1").html()+"</center></body></html>";
 jQuery("<form action='/rest/IqacReportServices/Faculty_FeedBack_Report_Xl' name='order' method='post' ><input name='fileData' value='"+htmlData+"'></form>").appendTo('body').submit().remove();

}



function ReqResforParentReport(IqacReport_uri,element)
{
    try{var R1 = new IqacReport();
  // alert(R1.url1+IqacReport_uri+"$$$$$"+R1.typ+"^^^^^"+R1.contType);
 $.ajax({
         url:R1.url1+IqacReport_uri,
         type:R1.typ,
         contentType:R1.contType,
        beforeSend:function()
        {
            $("#"+element).html("<center><font color='green' size='2'>Please Wait.....</font></center>");
        },
         success:function(e){
           //  alert(e);
           var  mainReport=e.split(" $$$");



        $("#"+element).empty();
        $("#"+element).append(mainReport[0]);
        $("#pdfButton").click(function (){
        var report= e.split("<button");

        var R12 = new IqacReport();
        IqacReport_uri='/FacultyFeedbackReortinPdf';


   var html="<form id='form1' method='Post' action='"+R12.url1+IqacReport_uri+"' target='_blank'>";
      //  var finaleport=report[0].replace("'","");
       html=html+"<input type='hidden' name='pdfData' id='pdfData' value=''/>";
       html=html+"<input type='hidden' name='filename' id='filename' value=''/>";
       html=html+"</form>";
      $("body").append(html);
      $("#pdfData").val(report[0]);
      $("#filename").val(mainReport[1]);


$("#form1").submit();
});
},

        error : function (){
 }
    });
}catch(e)
{
    alert(e);
}
}


/*function ReqResforParentReportinPDF(IqacReport_uri,element)
{//alert("GYan");
    try{var R1 = new IqacReport();
    window.open(R1.url1+IqacReport_uri);

}catch(e)
{
    alert(e);
}
}*/

