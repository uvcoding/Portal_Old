<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
try
{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JPBS";



GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
String qry="",qry1="",qry2="",qry3="",qry4="",str1="";
String mValue="",mAppSlno="",mSTUDENT="",mSTUDENTAPPSLNO="",mAppRadio="",mSTUDAPPSLNO="";
int mDOBMaxYear=1970;
int mDOBMinYear=1992;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
String mSTUDENTNAME="",mFATHERNAME="",mCATEGORY="",mSEX="",mNATIONALITY="",mCHECKSCORECARD="",mDATEOFBIRTH="",mAppNo="";
String mADDRESS1="",mADDRESS2="",mCITY="",mSTATE="",mPIN="",mCOUNTRY="",mPHONE="",mEMAILID="";
String mCHEQUEDDNO="",	mCHEQUEDDDATE="",mCHQDDTYPE="",	mAMOUNT="",	mBANKNAME="",mAPPEARINGININST="";
String mDOC="",		mQUALCODE="",		mQUALDESC="",		mPERCENTAGE="";
String 		mPERGRAD="",mPER10="",mPER12="";
String mPERCAT="",mSCORECAT="",mCHKCAT="";
String mPERMAT="",mSCOREMAT="",mCHKMAT="";
String mPERGMAT="",mSCOREGMAT="",mCHKGMAT="";
String mPERXAT="",mSCOREXAT="",mCHKXAT="",qry5="",mTESTCODE="";
String mDOC10="",mDOC12="",mDOCGRAD="",mRadio="";
		 ResultSet rst=null;
	 String	mAWT="",qryawt="";
String mPER10STREAM="",mPER10YEAR="",mPER10BOARD="";
String mPER12STREAM="",mPER12YEAR="",mPER12BOARD="";
String mPERGRADSTREAM="",mPERGRADYEAR="",mPERGRADBOARD="";
String mPEROT="",mPEROTSTREAM="",mPEROTYEAR="",mPEROTBOARD="",mDOCOT="";

//session.setAttribute("Click",mSelf);
session.setMaxInactiveInterval(10800); 
//out.print("sdfsfds"+session.getAttribute("APPLICATIONSLNO"));

%> 
<html>
<head>
<TITLE>#### <%=mHead%> [Edit Application Form ] </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology</title>
<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>

function ValidPhone()
	{

		var phone=document.LoginForm.MOBILE.value;

		var xx=phone.substring(0,1);
				//alert(phone+"sdfsdf"+xx);
		if(document.LoginForm.MOBILE.value=="+91" || xx=="0" || xx=="+" )
		{
					alert('Please Enter Valid Phone No.');
					return false;
		}
	}
	

function numbersonly(myfield, e, dec)
{
	var key;
	var keychar;
	if (window.event)
	key = window.event.keyCode;
	else if (e)
	   key = e.which;
	else
	   return true;
	keychar = String.fromCharCode(key);

	// control keys
	if ((key==null) || (key==0) || (key==8) || (key==9) || (key==13) || (key==27) )
		return true;
	// numbers
	else if ((("0123456789.").indexOf(keychar) > -1))
	   return true;
	// decimal point jump
	else if (dec && (keychar == "."))
	{
	   myfield.form.elements[dec].focus();
	   return false;
	}
	else
	   return false;
}




function isNumber(e)
        {
	
            var unicode=e.charCode? e.charCode : e.keyCode
            if (unicode!=8)
            { //if the key isn't the backspace key (which we should allow)
                if ((unicode<48||unicode>57)) //if not a number
                    return false; //disable key press
            }
        }
function ChangeCase() 
	{

		LoginForm.FirstName.value = LoginForm.FirstName.value.toUpperCase();
		

		LoginForm.FatherName.value = LoginForm.FatherName.value.toUpperCase();
	 
		LoginForm.ADDRESS1.value = LoginForm.ADDRESS1.value.toUpperCase();
		LoginForm.ADDRESS2.value = LoginForm.ADDRESS2.value.toUpperCase();
		
		LoginForm.CITY.value = LoginForm.CITY.value.toUpperCase();

		//Other();
		//Grad();
	} 
function button1_onclick(currdate) 
	{

		if(document.LoginForm.AppNo.value=="") 
			{
				alert('Application No. Should not be left blank');
				LoginForm.AppNo.focus();
					return(false);
			}


		if(document.LoginForm.FirstName.value=="") 
			{
				alert('First Name Should not be left blank');
				LoginForm.FirstName.focus();
					return(false);
			}

		
			if(document.LoginForm.FatherName.value=="" || document.LoginForm.FatherName.value==" ")
			{
				alert('Father Name  Should not be left blank');
				LoginForm.FatherName.focus();
					return(false);
			}

		if(document.LoginForm.ADDRESS1.value=="")
			{
				alert('Address Name Should not be left blank');
				LoginForm.ADDRESS1.focus();
					return(false);
			}
/*
		if(document.LoginForm.CITY.value=="")
			{
				alert('City Name Should not be left blank');
				LoginForm.CITY.focus();
					return(false);
			}


		if(document.LoginForm.PIN.value=="")
			{
				alert('PIN Code Should not be left blank');
				LoginForm.PIN.focus();
					return(false);
			}*/


if(document.LoginForm.DOB.value=="" || document.LoginForm.DOB.value==" ")
		{
				alert('Please enter your Date of Birth ');
				LoginForm.DOB.focus();
					return(false);
		}
		if(document.LoginForm.email.value=="" || document.LoginForm.email.value==" ")
		{
				alert('Please enter your Email-ID ');
				LoginForm.email.focus();
					return(false);
		}


			if(document.LoginForm.TenYear.value=="" || document.LoginForm.TenYear.value==" ")
		{
				alert('Please enter your 10th Year of Passing ');
				LoginForm.TenYear.focus();
					return(false);
		}
		if(document.LoginForm.TenBoard.value=="" || document.LoginForm.TenBoard.value==" ")
		{
				alert('Please enter your 10th Board ');
				LoginForm.TenBoard.focus();
					return(false);
		}
		if(document.LoginForm.TenPercent.value=="" || document.LoginForm.TenPercent.value==" ")
		{
				alert('Please enter your 10th Percentage ');
				LoginForm.TenPercent.focus();
					return(false);
		}
	
		if(document.LoginForm.TewYear.value=="" || document.LoginForm.TewYear.value==" ")
		{
				alert('Please enter  12th Year of Passing ');
				LoginForm.TewYear.focus();
					return(false);
		}
		if(document.LoginForm.TewBoard.value=="" || document.LoginForm.TewBoard.value==" ")
		{
				alert('Please enter  12th Board ');
				LoginForm.TewBoard.focus();
					return(false);
		}
		if(document.LoginForm.TewPercent.value=="" || document.LoginForm.TewPercent.value==" ")
		{
				alert('Please enter  12th Percentage ');
				LoginForm.TewPercent.focus();
					return(false);
		}
		if(document.LoginForm.TewStream.value=="Others" && document.LoginForm.TewStream1.value=="")
		{
				alert('Please enter  12th Stream ');
				LoginForm.TewStream1.focus();
					return(false);
		}


		
		if(document.LoginForm.GradYear.value=="" || document.LoginForm.GradYear.value==" ")
		{
				alert('Please enter  Graduation Year of Passing ');
				LoginForm.GradYear.focus();
					return(false);
		}
		if(document.LoginForm.GradBoard.value=="" || document.LoginForm.GradBoard.value==" ")
		{
				alert('Please enter  Graduation Board ');
				LoginForm.GradBoard.focus();
					return(false);
		}
		if(document.LoginForm.GradStream.value=="Others" && document.LoginForm.GradStream1.value=="")
		{
				alert('Please enter  Graduation Stream ');
				LoginForm.GradStream1.focus();
					return(false);
		}	



if(document.LoginForm.CATCOMP.value=="" && document.LoginForm.MATCOMP.value=="" && document.LoginForm.GMATCOMP.value=="" )
		{
				alert('Please enter Composite Score ');
				LoginForm.CATCOMP.focus();
					return(false);
		}
		
		
if(document.LoginForm.CATPER.value=="" && document.LoginForm.MATPER.value=="" && document.LoginForm.GMATTPER.value=="" )
		{
				alert('Please enter Percentile !');
				LoginForm.CATPER.focus();
					return(false);
		}


if(document.LoginForm.TenYear.value=="" && document.LoginForm.TewYear.value=="" && document.LoginForm.GradYear.value==""  && document.LoginForm.OtherYear.value=="")
		{
				alert('Please enter Year of Completion ');
				LoginForm.TenYear.focus();
					return(false);
		}

if(document.LoginForm.TenPercent.value=="" && document.LoginForm.TewPercent.value=="" && document.LoginForm.OtherPercent.value=="")
		{
				alert('Please enter Percentage of Qualification ');
				LoginForm.TenPercent.focus();
					return(false);
		}


var TenPercent=document.LoginForm.TenPercent.value;

var TewPercent=document.LoginForm.TewPercent.value;
//var GradPercent=document.LoginForm.GradPercent.value;
var OtherPercent=document.LoginForm.OtherPercent.value;

//alert(DPERCENT+"asd"+GPERCENT+"sdfasd"+PGPERCENT+"asd");

if(TenPercent>100.0) 
	{
			 alert('10th Percentage Should be less than 100 ');
			  LoginForm.TenPercent.focus();
			  return false;
	}
	 if(TewPercent>100.0)
	{
		 alert('12thPercentage Should be less than 100 ');
			  LoginForm.TewPercent.focus();
			  return false;
	}
	if  (OtherPercent>100.0)
	{
			 alert('Other Percentage Should be less than 100 ');
			  LoginForm.OtherPercent.focus();
			  return false;
	}

	
		
	


//alert(currdate+"sdfsfsfsfsdfs");

//	alert(currdate+"sdsd");
if(document.LoginForm.CATDATE.value!="")
{
var CATDATE=document.LoginForm.CATDATE.value;

var bb=CATDATE.substring(10,6)+CATDATE.substring(5,3)+CATDATE.substring(2,0);
//alert(currdate+"sdsd"+bb);
if(currdate>bb )
		{
			alert('Please Enter CAT DATE greater than the Current Date ');
			document.LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
			return false;
		}
}

if(document.LoginForm.MATDATE.value!="")
{
var MATDATE=document.LoginForm.MATDATE.value;
var mm=MATDATE.substring(10,6)+MATDATE.substring(5,3)+MATDATE.substring(2,0);
if(currdate>mm)
		{
			alert('Please Enter MAT DATE greater than the Current Date ');
			document.LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
			return false;
		}
}

if(document.LoginForm.GMATDATE.value!="")
{
var GMATDATE=document.LoginForm.GMATDATE.value;
var GG=GMATDATE.substring(10,6)+GMATDATE.substring(5,3)+GMATDATE.substring(2,0);
if(currdate>GG)
		{
			alert('Please Enter GMAT DATE greater than the Current Date ');
			document.LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
			return false ;
		}
}
	

//return false;

		if(document.LoginForm.DDNO.value==" " || document.LoginForm.DDNO.value=="")
		{
				alert('Please Enter DD Number ');
				LoginForm.DDNO.focus();
					return(false);
		}
		
		if(document.LoginForm.DDAMT.value==" " || document.LoginForm.DDAMT.value=="")
		{
				alert('Please Enter DD Amount ');
				LoginForm.DDAMT.focus();
					return(false);
		}
		if(document.LoginForm.DDDATE.value==" " || document.LoginForm.DDDATE.value=="")
		{
				alert('Please Enter DD Date ');
				LoginForm.DDDATE.focus();
					return(false);
		}

		if(document.LoginForm.BANK.value==" " || document.LoginForm.BANK.value=="")
		{
				alert('Please Enter Bank Name ');
				LoginForm.BANK.focus();
					return(false);
		}

if(document.LoginForm.DDDATE.value!="")
{
	var dddate=document.LoginForm.DDDATE.value;
	
	var aa=dddate.substring(10,6)+dddate.substring(5,3)+dddate.substring(2,0);

	if(currdate<aa)
		{
			alert('Please Enter DD Date less than the Current Date ');
			LoginForm.DDDATE.focus();
			return false ;
		}
}



}


function Other(stream)
	{
		//alert(stream);

		if(stream=="Others")
		{
				document.LoginForm.TewStream1.disabled=false;
				LoginForm.TewStream1.focus();
				return false;
		}
		else
		{
			
			document.LoginForm.TewStream1.disabled=true;
			
		}
	}
	function Grad(stream)
	{
		//alert(stream);

		if(stream=="Others")
		{
				document.LoginForm.GradStream1.disabled=false;
				LoginForm.GradStream1.focus();
				return false;
		}
		else
		{
			
			document.LoginForm.GradStream1.disabled=true;
			
		}
	}








function iSValidDDDate(DDDate)
{
//1 

if(document.LoginForm.DDDATE.value!="" && document.LoginForm.DDDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = DDDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDDDate = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDDDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DD  date field i.e DD-MM-YYYY.'); 
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.'); 
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.'); 
			LoginForm.DDDATE.value="";
			LoginForm.DDDATE.focus();
		  }
 //   } //2
  return (mISValidDDDate);
}
else
	//if(LoginForm.DDDATE.value==null)
	 {
		  alert('Please Enter the valid date format in DD date field i.e DD-MM-YYYY.'); 

	 }
}



//ValidCATDATE
function ValidCATDATE(CATDATE)
{
//1 

if(document.LoginForm.CATDATE.value!="" && document.LoginForm.CATDATE.value!=" "  &&  document.LoginForm.CATDATE!=null)
{
    var dn, mn, yn, maxday;
    var mDate = CATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidCATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidCATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.CATDATE.value="";
			LoginForm.CATDATE.focus();
		  }
 //   } //2
  return (mISValidCATDATE);
}
else
	//if(LoginForm.CATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in CATDATE field i.e DD-MM-YYYY.'); 

	 }
 
}
	
function ValidMATDATE(MATDATE)
{
//1 

if(document.LoginForm.MATDATE.value!="" && document.LoginForm.MATDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = MATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidMATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidMATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.MATDATE.value="";
			LoginForm.MATDATE.focus();
		  }
 //   } //2
  return (mISValidMATDATE);
}
else
	//if(LoginForm.MATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in MATDATE field i.e DD-MM-YYYY.'); 

	 }
	  
}	
	
	function ValidGMATDATE(GMATDATE)
{
//1 

if(document.LoginForm.GMATDATE.value!="" && document.LoginForm.GMATDATE.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = GMATDATE;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidGMATDATE = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3).trim()=="-" && mDate.substring(5, 6).trim()=="-") { //4
           if (parseInt(mDate.substring(0,2).trim()) >= 1 &&
              parseInt(mDate.substring(0,2).trim()) <=31 &&
              parseInt(mDate.substring(3, 5).trim()) <= 12 &&
              parseInt(mDate.substring(3, 5).trim()) >= 1 &&
              parseInt(mDate.substring(6).trim()) >= 1900 &&
              parseInt(mDate.substring(6).trim()) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2).trim());
            mn = parseInt(mDate.substring(3,5).trim());
            yn = parseInt(mDate.substring(6).trim());
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidGMATDATE =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.'); 
			LoginForm.GMATDATE.value="";
			LoginForm.GMATDATE.focus();
		  }
 //   } //2
  return (mISValidGMATDATE);
}
else
	//if(LoginForm.GMATDATE.value==null)
	 {
		  alert('Please Enter the valid date format in GMATDATE field i.e DD-MM-YYYY.'); 

	 }
	 
}	
	



function ValidDateFrom(DateFrom)
{
//1 

//alert(document.getElementById(DateFrom).value+"aa"+DateFrom);	
if(document.getElementById(DateFrom).value!="" && document.getElementById(DateFrom).value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = document.getElementById(DateFrom).value;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDateFrom = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3)=="-" && mDate.substring(5, 6)=="-") { //4
           if (parseInt(mDate.substring(0,2)) >= 1 &&
              parseInt(mDate.substring(0,2)) <=31 &&
              parseInt(mDate.substring(3, 5)) <= 12 &&
              parseInt(mDate.substring(3, 5)) >= 1 &&
              parseInt(mDate.substring(6)) >= 1900 &&
              parseInt(mDate.substring(6)) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2));
            mn = parseInt(mDate.substring(3,5));
            yn = parseInt(mDate.substring(6));
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDateFrom =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.'); 
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.'); 
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.'); 
			document.getElementById(DateFrom).value="";
			document.getElementById(DateFrom).focus();
		  }
 //   } //2
  return (mISValidDateFrom);
}
else
	//if(LoginForm.DateFrom.value==null)
	 {
		  alert('Please Enter the valid date format in DateFrom field i.e DD-MM-YYYY.'); 

	 }
	 
}	


function ValidDateTo(DateTo)
{
//1 

//alert(document.getElementById(DateTo).value+"aa"+DateTo);	
if(document.getElementById(DateTo).value!="" && document.getElementById(DateTo).value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = document.getElementById(DateTo).value;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDateTo = false;
   // if (isNumeric(mDate.substring(0, 2)) && isNumeric(mDate.substring(3, 5)) &&
   // isNumeric(mDate.substring(6))) { //2]
	 if (mDate.length==10) {
        //3
        if (mDate.substring(2, 3)=="-" && mDate.substring(5, 6)=="-") { //4
           if (parseInt(mDate.substring(0,2)) >= 1 &&
              parseInt(mDate.substring(0,2)) <=31 &&
              parseInt(mDate.substring(3, 5)) <= 12 &&
              parseInt(mDate.substring(3, 5)) >= 1 &&
              parseInt(mDate.substring(6)) >= 1900 &&
              parseInt(mDate.substring(6)) <= 3000) { //5
            dn = parseInt(mDate.substring(0, 2));
            mn = parseInt(mDate.substring(3,5));
            yn = parseInt(mDate.substring(6));
            if (mn == 4 || mn == 6 || mn == 9 || mn == 11)
              maxday = 30;
            else if (mn == 1 || mn == 3 || mn == 5 || mn == 7 || mn == 8 ||
                     mn == 10 || mn == 12)
              maxday = 31;
            else if (mn == 2 && (yn % 4 == 0 || yn % 400 == 0))
              maxday = 29;
            else
              maxday = 28;

            if (mn > 0 && mn <= 12 && dn > 0 && dn <= maxday)
              mISValidDateTo =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.'); 
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.'); 
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
      } //3
	  else  if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.'); 
			document.getElementById(DateTo).value="";
			document.getElementById(DateTo).focus();
		  }
 //   } //2
  return (mISValidDateTo);
}
else
	//if(LoginForm.DateTo.value==null)
	 {
		  alert('Please Enter the valid date format in DateTo field i.e DD-MM-YYYY.'); 

	 }
	 
}	



</SCRIPT>
<script language="JavaScript" type ="text/javascript" src="../js/datetimepicker.js"></script>
</head>
<BODY bgcolor="lightyellow"  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0  >
 <table  border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups borderColor=black>
<tr>
<td ALIGN=middle><FONT face=Verdana><STRONG><U><FONT size=3><FONT 
      color=brown 
      size=4>JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY UNIVERSITY <br>Jaypee Business School</FONT> 
      </FONT></U></STRONG></FONT><BR><FONT face=Verdana><FONT 
      size=1>((Declared Deemed to be University u/s 3 of the UGC Act,1956))</FONT>       
  </FONT>                
</td>
</tr>
<tr><td ALIGN=middle><FONT 
      face=Verdana><STRONG><FONT size=4>MBA APPLICATION FORM - 2012 </font><br><FONT size=2>(Do not submit without copy of CAT/XAT/MAT/GMAT score card)</FONT></STRONG>
      <BR>
</FONT>                         
</td></tr>
</table>
<%

if (session.getAttribute("MemberID")==null)
{
	mMemberID="";
}
else
{
	mMemberID=session.getAttribute("MemberID").toString().trim();
}

if (session.getAttribute("MemberType")==null)
{
	mMemberType="";
}
else
{
	mMemberType=session.getAttribute("MemberType").toString().trim();
}

if (session.getAttribute("MemberName")==null)
{
	mMemberName="";
}
else
{
	mMemberName=session.getAttribute("MemberName").toString().trim();
}

if (session.getAttribute("MemberCode")==null)
{
	mMemberCode="";
}
else
{
	mMemberCode=session.getAttribute("MemberCode").toString().trim();
}

if (session.getAttribute("InstituteCode")==null)
{
	mInst="";
}
else
{
	mInst=session.getAttribute("InstituteCode").toString().trim();
}

if (session.getAttribute("CompanyCode")==null)
{
	mComp="";
}
else
{
	mComp=session.getAttribute("CompanyCode").toString().trim();
}

	OLTEncryption enc=new OLTEncryption();
	if(!mMemberID.equals("") && !mMemberCode.equals("") && !mMemberName.equals("")) 
	{
		mDMemberCode=enc.decode(mMemberCode);
		mDMemberType=enc.decode(mMemberType);
		mDMemberID=enc.decode(mMemberID);
		String mChkMemID=enc.decode(session.getAttribute("MemberID").toString().trim());
		String mChkMType=enc.decode(session.getAttribute("MemberType").toString().trim());
		String mIPAddress =session.getAttribute("IPADD").toString().trim();
		String mRole=enc.decode(session.getAttribute("ROLENAME").toString().trim());
		ResultSet RsChk1=null;

	  //-----------------------------
	  //-- Enable Security Page Level  
	  //-----------------------------

		qry="Select WEBKIOSK.ShowLink('228','"+ mChkMemID+"','"+mChkMType+"','"+mRole+"','"+ mIPAddress +"') SL from dual";
	      RsChk1= db.getRowset(qry);
		if (RsChk1.next() && RsChk1.getString("SL").equals("Y"))
		   {
	  //----------------------

	  String mCurrDate="";
qry="Select To_char(Sysdate,'yyyymmdd' ) Dat from dual  ";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString(1);
	  
String  mAppYear="2012";
	  
	  %>

<form method=post  name="Form">
	  <input id="x" name="x" type=hidden>

<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >

<tr><td>
<FONT face=Verdana color="blue" size=2><b>&nbsp;Applicant SL.NO./Name:</b></FONT>
<%
	qry="select distinct APPLICATIONSLNO,STUDENTNAME FROM couns2301.C#MBAAPPLICATIONMASTER where nvl(DEACTIVE,'N')='N' and APPLICATIONSLNO like '"+mAppYear+"%' order by APPLICATIONSLNO";
	     //out.println("APPLICATIONSLNO,STUDENTNAME = " + qry);
	//	 out.print(qry);
	     rs=db.getRowset(qry);
		 %>
<Select  Name="AppSlno" ID="AppSlno"  >
<option value="Select" Selected><--Select Applicant Name--></option>
<%
	try
	 {	
	 if (request.getParameter("x")==null) 
		{
		 while(rs.next())
			{
				
					mAppSlno=rs.getString("APPLICATIONSLNO");
					%>
					<option value='<%=rs.getString("APPLICATIONSLNO")%>'><%=rs.getString("APPLICATIONSLNO")%>&nbsp;---><%=rs.getString("STUDENTNAME")%></option>
				<%
			
			}
		}
		else
		{
			while(rs.next())
			{
				mAppSlno=rs.getString("APPLICATIONSLNO");
				if (mAppSlno.equals(request.getParameter("AppSlno")))
				{
					%>
					<OPTION selected Value ='<%=mAppSlno%>'><%=mAppSlno%>&nbsp;---><%=rs.getString("STUDENTNAME")%></option>
					<%
				}
				else
				{
					%>
					<OPTION Value ='<%=mAppSlno%>'><%=mAppSlno%>&nbsp;---><%=rs.getString("STUDENTNAME")%></option>
					<%
				}
			}
		}
	 }
		catch(Exception e)
		{
//onkeypress="return isNumber(event)"
		}
	%>
 </select>

 
</td> 
<TD>

<FONT face=Verdana color="blue" size=2><b>&nbsp;Applicant No./Name :</b></FONT>
<%
	qry1="select distinct STUDENTNAME,APPLICATIONNO APPLICATIONSLNO FROM couns2301.C#MBAAPPLICATIONMASTER where nvl(DEACTIVE,'N')='N' and APPLICATIONSLNO like '"+mAppYear+"%' order by APPLICATIONSLNO";
	     rs1=db.getRowset(qry1);
		 %>
<Select  Name="STUDENTAPPSLNO" ID="STUDENTAPPSLNO"  >
<option value="Select1" Selected><--Select Applicant No.--></option>
<%
	try
	 {	
	 if (request.getParameter("x")==null) 
		{
		 while(rs1.next())
			{
				
					mSTUDENTAPPSLNO=rs1.getString("APPLICATIONSLNO");
					mSTUDENT=rs1.getString("STUDENTNAME");
					%>
					<option value='<%=rs1.getString("APPLICATIONSLNO")%>'><%=rs1.getString("APPLICATIONSLNO")%>&nbsp;----> <%=rs1.getString("STUDENTNAME")%></option>
				<%
			
			}
		}
		else
		{
			while(rs1.next())
			{
				mSTUDENTAPPSLNO=rs1.getString("APPLICATIONSLNO");
				mSTUDENT=rs1.getString("STUDENTNAME");

				if (mSTUDENTAPPSLNO.equals(request.getParameter("STUDENTAPPSLNO")))
				{
					%>
					<OPTION selected Value ='<%=mSTUDENTAPPSLNO%>'><%=mSTUDENTAPPSLNO%>&nbsp;----><%=mSTUDENT%></option>
					<%
				}
				else
				{
					%>
					<OPTION Value ='<%=mSTUDENTAPPSLNO%>'><%=mSTUDENTAPPSLNO%>&nbsp;----><%=mSTUDENT%></option>
					<%
				}
			}
		}
	 }
		catch(Exception e)
		{
//onkeypress="return isNumber(event)"
		}
	%>
 </select>	
</TD>
<tr>

<td colspan =2 align=center><INPUT TYPE="submit" value="Submit"></td>
</tr>
</tr>

</form>

<%
if(request.getParameter("x")!=null)
{



/*
if(request.getParameter("Radio1")==null)
	mAppRadio="";
else
	mAppRadio=request.getParameter("Radio1").toString().trim();

if(request.getParameter("AppSlno")==null)
	mAppSlno="";
else
	mAppSlno=request.getParameter("AppSlno").toString().trim();


if(request.getParameter("STUDENTAPPSLNO")==null)
	mSTUDAPPSLNO="";
else
	mSTUDAPPSLNO=request.getParameter("STUDENTAPPSLNO").toString().trim();
*/





if(!request.getParameter("AppSlno").equals("Select"))
{
if (request.getParameter("AppSlno")==null)
	mAppSlno="";
else
 	mAppSlno=request.getParameter("AppSlno").toString().trim();
}
else
{
	if (request.getParameter("STUDENTAPPSLNO")==null)
		mAppSlno="";
	else
 		mAppSlno=request.getParameter("STUDENTAPPSLNO").toString().trim();
}




	qry="SELECT APPLICATIONSLNO, APPLICATIONNO, nvl(STUDENTNAME,' ')STUDENTNAME,  FATHERNAME,nvl(to_char(DATEOFBIRTH,'dd-mm-yyyy'),' ')DATEOFBIRTH, nvl(CATEGORY,' ')CATEGORY,   nvl(SEX,' ' )SEX, nvl(NATIONALITY,' ')NATIONALITY,nvl(CHECKSCORECARD,' ')CHECKSCORECARD,decode(APPEARINGININST,'Y','Yes','N','No','No') APPEARINGININST  FROM couns2301.C#MBAAPPLICATIONMASTER  where (APPLICATIONSLNO ='"+mAppSlno+"' or APPLICATIONNO ='"+mAppSlno+"') and  APPLICATIONSLNO like '"+mAppYear+"%' ";
	//out.print(qry);
	rs=db.getRowset(qry);
	if(rs.next())
	{

	mAppNo=rs.getString("APPLICATIONNO").toString().trim();
	
	mAppSlno=rs.getString("APPLICATIONSLNO").toString().trim();
	//out.println("mAppNo = " + mAppNo);
	
	mSTUDENTNAME=rs.getString("STUDENTNAME").toString().trim();
	//out.println("mSTUDENTNAME = " + mSTUDENTNAME);
	
	mFATHERNAME=rs.getString("FATHERNAME").toString().trim();
	//out.println("mFATHERNAME = " + mFATHERNAME);		
	
	mCATEGORY=rs.getString("CATEGORY").toString().trim();
	//out.println("mCATEGORY = " + mCATEGORY);
	
	mSEX=rs.getString("SEX").toString().trim();
	//out.println("mSEX = " + mSEX);
	
	mNATIONALITY=rs.getString("NATIONALITY").toString().trim();
	//out.println("mNATIONALITY = " + mNATIONALITY);
	
	mCHECKSCORECARD=rs.getString("CHECKSCORECARD").toString().trim();
	//out.println("mCHECKSCORECARD = " + mCHECKSCORECARD);
       	
       	mAPPEARINGININST=rs.getString("APPEARINGININST").toString().trim();
       	//out.println("mAPPEARINGININST = " + mAPPEARINGININST);
	
	mDATEOFBIRTH=rs.getString("DATEOFBIRTH").toString().trim();
	//out.println("mDATEOFBIRTH = " + mDATEOFBIRTH);
	}
else
	{
	out.print("<br><img src='../../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please select one of the option  ApplicationSLNO <br>");
	}
	qry2="SELECT NVL(ADDRESS1,' ')ADDRESS1, NVL(ADDRESS2,' ')ADDRESS2,NVL(CITY,' ')CITY, NVL(STATE,' ')STATE,NVL(PIN,' ')PIN,NVL(COUNTRY,' ')COUNTRY, NVL(PHONE,' ')PHONE,NVL(EMAILID,' ')EMAILID FROM couns2301.C#MBAAPPLICANTADD where  APPLICATIONSLNO ='"+mAppSlno+"' and APPLICATIONSLNO like '"+mAppYear+"%' ";
	//out.print(qry2);
	rs2=db.getRowset(qry2);
	if(rs2.next())
	{
		mADDRESS1=rs2.getString("ADDRESS1").toString().trim();
			//out.println("mADDRESS1 = " + mADDRESS1);

		mADDRESS2=rs2.getString("ADDRESS2").toString().trim();
			//out.println("mADDRESS2 = " + mADDRESS2);

		mCITY=rs2.getString("CITY").toString().trim();
			//out.println("mCITY = " + mCITY);

		mSTATE=rs2.getString("STATE").toString().trim();
			//out.println("mSTATE = " + mSTATE);

		mPIN=rs2.getString("PIN").toString().trim();
			//out.println("mPIN = " + mPIN);

		mCOUNTRY=rs2.getString("COUNTRY").toString().trim();
			//out.println("mCOUNTRY = " + mCOUNTRY);

		mPHONE=rs2.getString("PHONE").toString().trim();
			//out.println("mPHONE = " + mPHONE);

		mEMAILID=rs2.getString("EMAILID").toString().trim();
			//out.println("mEMAILID = " + mEMAILID);
		
	}
qry3="SELECT  NVL(CHEQUEDDNO,' ')CHEQUEDDNO, nvl(to_char(CHEQUEDDDATE,'dd-mm-yyyy'),' ')CHEQUEDDDATE, CHQDDTYPE, NVL(AMOUNT,0)AMOUNT, NVL(BANKNAME,' ')BANKNAME FROM couns2301.C#MBAFEE where  APPLICATIONSLNO ='"+mAppSlno+"' and APPLICATIONSLNO like '"+mAppYear+"%' ";
//out.print(qry3);
rs3=db.getRowset(qry3);
if(rs3.next())
	{
	
	mCHEQUEDDNO=rs3.getString("CHEQUEDDNO");

	mCHEQUEDDDATE=rs3.getString("CHEQUEDDDATE").toString().trim();
	
	mAMOUNT=rs3.getString("AMOUNT").toString().trim();
	

	mBANKNAME=rs3.getString("BANKNAME").toString().trim();
	mCHQDDTYPE=rs3.getString("CHQDDTYPE").toString().trim();
	}


	
	String  mCALL2="",mCATDATE="",mMATDATE="",mGMATDATE="";
	qry5="SELECT  TESTCODE, PERCENTAGE,COMPOSITESCORE,CHECKSCORE,CALL1,CALL2,CALL3,to_char(RESULTVALIDUPTO,'dd-mm-yyyy')RESULTVALIDUPTO FROM couns2301.C#MBATESTSCORE where  APPLICATIONSLNO ='"+mAppSlno+"' and APPLICATIONSLNO like '"+mAppYear+"%' ";
//out.println(qry5);
rs5=db.getRowset(qry5);
while(rs5.next() )
	{

	mTESTCODE=rs5.getString("TESTCODE").toString().trim();
	//  mCALL2=rs5.getString("CALL2").toString().trim();
	
		if(mTESTCODE.equals("CAT"))
		{
	mPERCAT=rs5.getString("PERCENTAGE");
	mSCORECAT=rs5.getString("COMPOSITESCORE");
	mCATDATE=rs5.getString("RESULTVALIDUPTO");
	mCHKCAT=rs5.getString("CHECKSCORE");
	mCATDATE=(mCATDATE==null)?"":mCATDATE.trim();
		}
		if(mTESTCODE.equals("MAT"))
		{
	mPERMAT=rs5.getString("PERCENTAGE");
	mSCOREMAT=rs5.getString("COMPOSITESCORE");
		mMATDATE=rs5.getString("RESULTVALIDUPTO");
	mCHKMAT=rs5.getString("CHECKSCORE");
	mMATDATE=(mMATDATE==null)?"":mMATDATE.trim();
		}
		
		if(mTESTCODE.equals("GMAT"))
		{
mPERGMAT=rs5.getString("PERCENTAGE");
mSCOREGMAT=rs5.getString("COMPOSITESCORE");
	mGMATDATE=rs5.getString("RESULTVALIDUPTO");
mCHKGMAT=rs5.getString("CHECKSCORE");
mGMATDATE=(mGMATDATE==null)?"":mGMATDATE.trim();
		}

		/*if(mTESTCODE.equals("AWT") && mCALL2.equals("Y") )
		{
			 mCALL2=rs5.getString("CALL2");
		}*/
		
	}
//out.print(mCALL2+"asdd");
%>
<FORM  method=post action="EditApplicationFormAction.jsp" name="LoginForm">
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >
<tr>
<td >


<FONT face=Verdana color="blue" size=2><b>&nbsp;Application No:</b></FONT><INPUT  Name="AppNo" ID="AppNo" value="<%=mAppNo%>" size=15 maxlength=30 tabIndex=1 LANGUAGE=javascript  onkeypress="return isNumber(event)"	><FONT 
      face="Times New Roman" color=#ff4500>*</FONT>
&nbsp;&nbsp;


 </td>
</tr>

<tr><td ><FONT face=Verdana>1. Name of Candidate :</FONT><INPUT ID="FirstName" Name="FirstName"  value="<%=mSTUDENTNAME%>" size=60 maxlength=60 tabIndex=2 LANGUAGE="javascript"	onfocusout="return ChangeCase()"><FONT 
      face="Times New Roman" color=#ff4500>*</FONT></td>
</tr>
<tr>
<td colspan=3 align=left><FONT face=Verdana> 2. Father's Name 
      :&nbsp;&nbsp;&nbsp;</FONT>   <INPUT size=60 maxlength=60 Id="FatherName" Name="FatherName" value="<%=mFATHERNAME%>"
      tabIndex=3  LANGUAGE="javascript" onfocusout="return ChangeCase()"><FONT 
      face=Verdana><FONT 
      face="Times New Roman" color=#ff4500>*</FONT> </FONT>
</td>
</tr>
<tr>
<td>
<FONT face=Verdana>3. Gender <FONT color=tomato>*</FONT>   

<%
if(mSEX.equals("M"))
	{
	%>
	<INPUT Type="radio" ID="Gender" Name="Gender" Value="M" checked tabIndex=4>
	<%
	}
	else
	{
%>
	<INPUT Type="radio" ID="Gender" Name="Gender" Value="M"  tabIndex=4>
	<%
	
	}
%>
Male
<%
if(mSEX.equals("F"))
	{
	%>
<INPUT Type="radio" ID="Gender" Name="Gender" Value="F"   checked   tabIndex=5>
<%
	}
	else
	{
%>
	<INPUT Type="radio" ID="Gender" Name="Gender" Value="F"  tabIndex=5>
	<%
	
	}
%>
 Female
	  
	  </FONT> </SELECT><FONT face=Verdana> 
</FONT>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;<FONT face=Verdana>4. Date of Birth <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT 
      face="Times New Roman" 
      color=#ff4500>*</FONT>    
	<INPUT TYPE="text" NAME=DOB ID=DOB size=9 tabindex=6 value="<%=mDATEOFBIRTH%>"  maxlength=10
	><a href="javascript:NewCal('DOB','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a>
	    
</td>
</tr>
<tr><td colspan=3>

 <FONT face=Verdana>5. Category:<FONT face="Times New Roman" 
      color=#ff4500>*</FONT>  
		<INPUT Type="radio" ID="Category" Name="Category" Value="GEN" checked tabIndex=9>General (GEN)
	   <INPUT Type="radio" ID="Category" Name="Category" Value="SC" tabIndex=10>SC
	   <INPUT Type="radio" ID="Category" Name="Category" Value="ST" tabIndex=11>ST
	   <INPUT Type="radio"  ID="Category" Name="Category" Value="OBC" tabIndex=12>OBC
	   </FONT>
      <br>
   
</td>
</tr>
<tr>
		
<td colspan=3><FONT face=Verdana size=2>6. Address of the Candidate</FONT>
<br>
&nbsp; &nbsp; &nbsp; &nbsp;<input ID="ADDRESS1" Name="ADDRESS1" MaxLength=80 Size=70 tabIndex=13 value="<%=mADDRESS1%>" LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT color=#ff4500>*</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input ID="ADDRESS2" Name="ADDRESS2" value="<%=mADDRESS2%>"  MaxLength=75 Size=70 tabIndex=14 LANGUAGE=javascript onfocusout="return ChangeCase()"><br>
&nbsp; &nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>City:</FONT> <input ID="CITY" Name="CITY" value="<%=mCITY%>" MaxLength=25 Size=25  tabIndex=15 LANGUAGE=javascript onfocusout="return ChangeCase()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Verdana size=2>PIN: <input ID="PIN" Name="PIN" value="<%=mPIN%>" MaxLength=8 Size=6 tabIndex=16 LANGUAGE=javascript onkeypress="return isNumber(event)"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



 <FONT face=Verdana size=2>Country: 
<select name="Country" id="Country" tabIndex=17>
  <option value='INDIA' selected>India</option>
	
 </select>	
 <FONT face=Verdana size=2>State: 
<SELECT ID="STATE" Name="STATE" tabIndex=18>
<option selected value="<%=mSTATE%>"><%=mSTATE%></option>	

<option Value="Delhi"  >Delhi
<option Value="AndhraPradesh">Andhra Pradesh
<option Value="Arunachal Pradesh">Arunachal Pradesh
<option Value="Assam">Assam
<option Value="Bihar">Bihar
<option Value="Chhattisgarh">Chhattisgarh
<option Value="Goa">Goa
<option Value="Gujarat">Gujarat
<option Value="Haryana">Haryana
<option Value="Himachal Pradesh">Himachal Pradesh
<option Value="JammuandKashmir">Jammu and Kashmir
<option Value="Jharkhand">Jharkhand
<option Value="Karnataka">Karnataka
<option Value="Kerala">Kerala
<option Value="Maharashtra">Maharashtra
<option Value="Meghalaya">Meghalaya</option>
<option Value="Mizoram">Mizoram</option>
<option Value="Nagaland">Nagaland</option>
<option Value="Punjab">Punjab</option>
<option Value="Rajasthan">Rajasthan</option>
<option Value="TamilNadu">Tamil Nadu</option>
<option Value="Tripura">Tripura</option>
<option Value="UttarPradesh">Uttar Pradesh</option>
<option Value="Uttarakhand">Uttarakhand</option>
<option Value="WestBengal">West Bengal</option>
<option Value="Andaman&NicobarIslands">Andaman and Nicobar Islands</option>
<option Value="Chandigarh">Chandigarh</option>
<option Value="DNH">Dadra and Nagar Haveli</option>
<option Value="DD">Daman and Diu</option>
<option Value="Lakshadweep">Lakshadweep</option>
<option Value="Puducherry">  Puducherry</option>

</SELECT>&nbsp;
</FONT><FONT face=Verdana size=2>PhoneNo or Moblie No:<input ID="MOBILE" Name="MOBILE" value="<%=mPHONE%>"  onkeypress="return isNumber(event)"  MaxLength=30 Size=15 tabIndex=19 
     ></FONT>
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana> 7. Email Address (if any):&nbsp; <INPUT ID="email" Name="email" value="<%=mEMAILID%>"  maxLength=50 size=50 tabIndex=20>  
</FONT>   
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana>8. Nationality: &nbsp;&nbsp;&nbsp;&nbsp; 
<%
	if(mNATIONALITY.equals("INDIAN"))
	{

	%>
<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="INDIAN" Checked tabIndex=21>Indian
&nbsp;&nbsp;&nbsp;
<%
	}
else
	{
	%>
<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="INDIAN"  tabIndex=21>Indian
&nbsp;&nbsp;&nbsp;
<%
	}
if(mNATIONALITY.equals("FOREIGN"))
	{
%>
<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="FOREIGN" Checked tabIndex=22>Foreign
<%
	}
else
	{
%>
<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="FOREIGN" tabIndex=22>Foreign
<%
	
	}
%>
</FONT>       
</td>
</tr>
<%
qry4="SELECT  nvl(QUALIFICATIONCODE,' ')QUALIFICATIONCODE,nvl(QUALIFICATIONDESC,' ')QUALIFICATIONDESC,NVL(BOARD,' ')BOARD, NVL(PASSINGYEAR,'')PASSINGYEAR, NVL(STREAM,' ')STREAM,nvl(percentage,0) percentage, nvl(DOCUMENT,' ')DOCUMENT FROM couns2301.C#QUALIFICATION where  APPLICATIONSLNO ='"+mAppSlno+"'  and APPLICATIONSLNO like '"+mAppYear+"%' ";
	

rs4=db.getRowset(qry4);
while(rs4.next() )
	{


		mQUALCODE=rs4.getString("QUALIFICATIONCODE").toString().trim();
		
		if(mQUALCODE.equals("10TH"))
		{	
		mPER10=rs4.getString("PERCENTAGE");	
		
		mPER10YEAR=rs4.getString("PASSINGYEAR");
		mPER10BOARD=rs4.getString("BOARD");
		mDOC10=rs4.getString("DOCUMENT").toString().trim();
		}
		if(mQUALCODE.equals("12TH"))
		{		
		mPER12=rs4.getString("PERCENTAGE");
		mPER12STREAM=rs4.getString("STREAM");
		mPER12YEAR=rs4.getString("PASSINGYEAR");
		mPER12BOARD=rs4.getString("BOARD");
		mDOC12=rs4.getString("DOCUMENT").toString().trim();
		}
		if(mQUALCODE.equals("GRAD"))
		{		
		mPERGRAD=rs4.getString("PERCENTAGE");
		mPERGRADSTREAM=rs4.getString("STREAM");
		mPERGRADYEAR=rs4.getString("PASSINGYEAR");
		mPERGRADBOARD=rs4.getString("BOARD");
		mDOCGRAD=rs4.getString("DOCUMENT").toString().trim();

		}
		if(mQUALCODE.equals("OTHER"))
		{
		mPEROT=rs4.getString("PERCENTAGE");
		mPEROTSTREAM=rs4.getString("STREAM");
		mPEROTYEAR=rs4.getString("PASSINGYEAR");
		mPEROTBOARD=rs4.getString("BOARD");
		mDOCOT=rs4.getString("DOCUMENT").toString().trim();

		}
		
	}
	String  mSelect="",mSelect2="";
if ( mPER12STREAM.equals("Science") || mPER12STREAM.equals("Arts") || mPER12STREAM.equals("Commerce")
 || mPER12STREAM.equals("Engineering")  )
	{
	   mSelect="";
	}
	else
	{
		 mSelect=mPER12STREAM;
		mPER12STREAM="Others";
	}


if ( mPERGRADSTREAM.equals("Science") || mPERGRADSTREAM.equals("Arts") || mPERGRADSTREAM.equals("Commerce")
 || mPERGRADSTREAM.equals("Engineering")  )
	{
	   mSelect2="";
	}
	else
	{
		 mSelect2=mPERGRADSTREAM;
		mPERGRADSTREAM="Others";
	}
	%>
 <TR>
<td colspan=3 align=left><FONT face=Verdana>9. Current Qualification

 <br>
 <TABLE BORDER=1 ALIGN=center  cellspacing=2 cellpadding=2>
			<tr>
			<td>&nbsp;</td>
			<td><font face='Verdana' size=1 ><b>Year of Completion/Awaited</b></td>
			<td><font face='Verdana' size=1 ><b>Stream </b></td>
			<td><font face='Verdana' size=1 ><b>Board / University</b></td>
			<td><font face='Verdana' size=1 ><b>% of Marks</b></td>
			</tr>
			<TR>
				
			<TD><font face='Verdana' size=2 >10th <font color=red>*</font> &nbsp;&nbsp;
					
		</TD>
		<TD><INPUT TYPE="text" NAME="TenYear" id="TenYear" VALUE="<%=mPER10YEAR%>" tabIndex=23  SIZE=15 MAXLENGTH=20><font color=red>*</font></TD>
		<TD>&nbsp;&nbsp;&nbsp;
		</TD>
		<TD><INPUT TYPE="text" NAME="TenBoard" VALUE="<%=mPER10BOARD%>"    size=20 maxlength=80 tabIndex=25><font color=red>*</font></TD>
		<TD><INPUT TYPE="text" NAME="TenPercent"  VALUE="<%=mPER10%>"   onKeyPress="return numbersonly(this, event); 	"  SIZE=3 MAXLENGTH=5 tabIndex=26><font color=red>*</font></TD>
		</TR>
		<TR>
		<TD><font face='Verdana' size=2 >12th <font color=red>*</font> &nbsp;&nbsp;
			
		</TD>
		<TD><INPUT TYPE="text" NAME="TewYear"   VALUE="<%=mPER12YEAR%>"  SIZE=15	 MAXLENGTH=20 tabIndex=27 ></TD>
		<TD><select  Id="TewStream" Name="TewStream" onchange="Other(TewStream.value);" tabIndex=28 >
		<option  Value="<%=mPER12STREAM%>" selected ><%=mPER12STREAM%>	</option>
		<option Value="Science">Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
		<option Value="Engineering">Engineering	</option>
		<option Value="Others">Others
		</option>
		</SELECT>
		<INPUT TYPE="text" NAME="TewStream1" value="<%=mSelect%>" id="TewStream1" MAXLENGTH=30 size=10 tabIndex=28>
		</TD>
		<TD><INPUT TYPE="text" NAME="TewBoard"  VALUE="<%=mPER12BOARD%>"   size=20 maxlength=80 tabIndex=29></TD>
		<TD>
		<INPUT TYPE="text" NAME="TewPercent" VALUE="<%=mPER12%>"    onKeyPress="return numbersonly(this, event); "  SIZE=3 MAXLENGTH=5 tabIndex=30></TD>
		</TR>
			
		<TR>
		<TD><font face='Verdana' size=2 >Graduation <font color=red>*</font>&nbsp;
		</TD> 
		<TD><INPUT TYPE="text" NAME="GradYear" VALUE="<%=mPERGRADYEAR%>"  SIZE=15 MAXLENGTH=20 tabIndex=31 ></TD>
		<TD><select  Id="GradStream" Name="GradStream" tabIndex=32  onchange="Grad(GradStream.value);">
		<option Value="<%=mPERGRADSTREAM%>" selected ><%=mPERGRADSTREAM%>	</option>
		<option Value="Science"  >Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
		<option Value="Engineering">Engineering	</option>
		<option Value="Others">Others
		</option>
		</SELECT>
		<INPUT TYPE="text" NAME="GradStream1"  value="<%=mSelect2%>" id="GradStream1" tabIndex=32  MAXLENGTH=30 size=10 >
		</TD>
		<TD><INPUT TYPE="text" NAME="GradBoard" VALUE="<%=mPERGRADBOARD%>"  size=20 maxlength=80 tabIndex=33></TD>
		<TD><INPUT TYPE="text" NAME="GradPercent" VALUE="<%=mPERGRAD%>"  onKeyPress="return numbersonly(this, event);"  SIZE=3 MAXLENGTH=5 tabIndex=34></TD>
			</TR>

			
			<TR>
			<TD><font face='Verdana' size=2 >Other(if any)&nbsp;

			</TD> 
				<TD><INPUT TYPE="text" NAME="OtherYear"  VALUE="<%=mPEROTYEAR%>"  SIZE=15 MAXLENGTH=20 tabIndex=35 ></TD>
				<TD><INPUT TYPE="text" NAME="OtherStream" VALUE="<%=mPEROTSTREAM%>"   SIZE=15 MAXLENGTH=40 tabIndex=36></TD>
				<TD><INPUT TYPE="text" NAME="OtherBoard" VALUE="<%=mPEROTBOARD%>"   size=20 maxlength=80 tabIndex=37></TD>
				<TD><INPUT TYPE="text" NAME="OtherPercent" VALUE="<%=mPEROT%>"   onKeyPress="return numbersonly(this, event); 
"   SIZE=3 MAXLENGTH=5 tabIndex=38></TD>
			</TR>
			</TABLE>

<FONT face=Verdana><sup>*</sup> If appearing,attach certificate from Head of Institution.[e.g Science/Arts/Commerce/Others(specify)]<br>&nbsp;&nbsp;&nbsp;<b>Click</b>:  <%
		 if(mAPPEARINGININST.equals("Yes"))
		{
		 %>
		 <INPUT Type="radio" ID="Appear" Name="Appear" Value="Y" checked tabIndex=39>Yes &nbsp;
			<%
		}
		else
		{	
		 %>
		 <INPUT Type="radio" ID="Appear" Name="Appear" Value="Y" tabIndex=39>Yes &nbsp;
			<%
		}	
		 if(mAPPEARINGININST.equals("No"))
		{
		 %>
		 <INPUT Type="radio" ID="Appear" Name="Appear" Value="N" checked tabIndex=40>No &nbsp;
			<%
		}
		else
		{	
		 %>
		 <INPUT Type="radio" ID="Appear" Name="Appear" Value="N" tabIndex=40>No &nbsp;
			<%
		}		%>


</td>
</tr>


<tr>
<td colspan=3 align=left><br><FONT face=Verdana>10. Please Fill as Applicable  (Attach copy of Score Card Mandatory) <br>



  <br>
	<TABLE BORDER=1 ALIGN=center cellspacing=2 cellpadding=2>
			<tr>
			<td><font face='Verdana' size=1 ><b>Exam</b></td>
			<td><font face='Verdana' size=1 ><b>Composite Score/Total Score</b></td>
			<td><font face='Verdana' size=1 ><b>Percentile/Total Percentile	</b></td>
				<td><font face='Verdana' size=1 ><b>Result Valid Upto</b></td>
			</tr>
			<TR>
		
				<TD><font face='Verdana' size=2 >CAT <font color=red>*</font> &nbsp;&nbsp;
<INPUT Type="hidden" ID="CAT" Name="CAT" Value="CAT" >
				
	
				</TD>
				<TD><INPUT TYPE="text" NAME="CATCOMP" value="<%=mSCORECAT%>"  tabIndex=41  SIZE=3 MAXLENGTH=6></TD>
				<TD><INPUT TYPE="text" NAME="CATPER" value="<%=mPERCAT%>"  onKeyPress="return numbersonly(this, event); "   SIZE=3 MAXLENGTH=5 tabIndex=42></TD>
<TD><INPUT TYPE="text" NAME="CATDATE" id="CATDATE"   value="<%=mCATDATE%>"  onChange="return ValidCATDATE(CATDATE.value) "  onCLICK="return ValidCATDATE(CATDATE.value) "    tabIndex=42  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('CATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			<TR>
	
				<TD><font face='Verdana' size=2 >MAT <font color=red>*</font> &nbsp;&nbsp;
 
				<INPUT Type="hidden" ID="MAT" Name="MAT" Value="MAT" >

				</TD>
				<TD><INPUT TYPE="text" NAME="MATCOMP" value="<%=mSCOREMAT%>" SIZE=3 MAXLENGTH=6 tabIndex=43></TD>
				<TD><INPUT TYPE="text" NAME="MATPER" value="<%=mPERMAT%>"  onKeyPress="return numbersonly(this, event);"  SIZE=3 MAXLENGTH=5 tabIndex=44></TD>
				<TD><INPUT TYPE="text" NAME="MATDATE"  id="MATDATE"  value="<%=mMATDATE%>"  onClick="return ValidMATDATE(MATDATE.value) "    onChange="return ValidMATDATE(MATDATE.value) "  tabIndex=44  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('MATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			
			<TR>
		
			<TD><font face='Verdana' size=2 >GMAT <font color=red>*</font>&nbsp;
			<INPUT Type="hidden" ID="GMAT" Name="GMAT" Value="GMAT" >
			</TD> 
				<TD><INPUT TYPE="text" NAME="GMATCOMP" onkeypress="return isNumber(event)"  value="<%=mSCOREGMAT%>"  SIZE=3 MAXLENGTH=6 tabIndex=45></TD>
				<TD><INPUT TYPE="text" NAME="GMATPER" value="<%=mPERGMAT%>"   SIZE=3 MAXLENGTH=5 tabIndex=46></TD>
				<TD><INPUT TYPE="text" NAME="GMATDATE"  id="GMATDATE"  value="<%=mGMATDATE%>"  onClick="return ValidGMATDATE(GMATDATE.value) " onChange="return ValidGMATDATE(GMATDATE.value) "    tabIndex=46  SIZE=8 MAXLENGTH=10><font color=green face=arialblack  size=1><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>	</TABLE>

			</TR>
		





<TR>

<td colspan=4 align=left><br><FONT face=Verdana>11. Work Experience <br>
  <br>
	<TABLE BORDER=1 ALIGN=center cellspacing=2 cellpadding=2>
			<tr>
			<td><font face='Verdana' size=1 ><b>Postion</b></td>
			
			<td><font face='Verdana' size=1 ><b>Name of Organisation </b></td>
			<td><font face='Verdana' size=1 ><b>Job Profile</b></td>
			<td><font face='Verdana' size=1 ><b>Duration From</b></td>
			<td><font face='Verdana' size=1 ><b>Duration To</b></td>
			</tr>
			
			<%

String qrycomp="SELECT APPLICATIONSLNO, EXPSLNO, COMPANYNAME,    DESIGNATION,to_char(nvl(WORKDATEFROM,SYSDATE),'dd-MM-yyyy')  WORKDATEFROM,to_char(nvl(WORKDATETO,SYSDATE),'dd-MM-yyyy')   WORKDATETO,    WORKINGAREA FROM couns2301.C#MBAAPPLICANTWORKEXP WHERE APPLICATIONSLNO='"+mAppSlno+"' and APPLICATIONSLNO like '"+mAppYear+"%' order by EXPSLNO";
ResultSet rscomp=db.getRowset(qrycomp);
rs=db.getRowset(qrycomp);
int i=0;

if(rs.next())
	{
//out.println(qrycomp);
while(rscomp.next())
{
	++i;
				%>
			<TR>
				
				<TD valign="top"> 
				
				<INPUT TYPE="text" NAME="DESIGNATION<%=i%>" id="DESIGNATION<%=i%>" value="<%=rscomp.getString("DESIGNATION")%>"  tabIndex=44 SIZE=25 MAXLENGTH=200>
				
				</TD>

			<TD valign="top">
				<INPUT TYPE="text" NAME="COMPANY<%=i%>" id="COMPANY<%=i%>" value="<%=rscomp.getString("COMPANYNAME")%>"  tabIndex=44  SIZE=25 MAXLENGTH=200>
				</TD>
				<TD valign="top">
				<INPUT TYPE="text" NAME="AREA<%=i%>" id="AREA<%=i%>"  value="<%=rscomp.getString("WORKINGAREA")%>"   tabIndex=44  SIZE=25 MAXLENGTH=200>
				</TD>



				<TD >
				<INPUT TYPE="text" NAME="WORKDATEFROM<%=i%>"   id="WORKDATEFROM<%=i%>" value="<%=rscomp.getString("WORKDATEFROM")%>"  onchange="return ValidDateFrom('WORKDATEFROM<%=i%>') "   tabIndex=44  SIZE=8 MAXLENGTH=10>
				<font color=green face=arialblack> <font size=1><b> <Br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
				<TD>
				<INPUT TYPE="text" NAME="WORKDATETO<%=i%>" id="WORKDATETO<%=i%>" value="<%=rscomp.getString("WORKDATETO")%>"   tabIndex=44  SIZE=8 MAXLENGTH=10  onchange="return ValidDateTo('WORKDATETO<%=i%>') " >
				<font color=green face=arialblack> <font size=1><b> <br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
			</TR>
			<%
				}


	}
	else
	{
				for( i=1; i<=3;i++)
				{
				%>
			<TR>
				
				<TD valign="top"> <INPUT TYPE="text" NAME="DESIGNATION<%=i%>" id="DESIGNATION<%=i%>"  tabIndex=44 SIZE=25 MAXLENGTH=200>
				</TD>

			<TD valign="top">
				<INPUT TYPE="text" NAME="COMPANY<%=i%>" id="COMPANY<%=i%>"  tabIndex=44  SIZE=25 MAXLENGTH=200>
				</TD>
				<TD valign="top">
				<INPUT TYPE="text" NAME="AREA<%=i%>" id="AREA<%=i%>"    tabIndex=44  SIZE=25 MAXLENGTH=200>
				</TD>



				<TD >
				<INPUT TYPE="text" NAME="WORKDATEFROM<%=i%>"   id="WORKDATEFROM<%=i%>"  onchange="return ValidDateFrom('WORKDATEFROM<%=i%>') "   tabIndex=44  SIZE=8 MAXLENGTH=10>
				<font color=green face=arialblack> <font size=1><b> <Br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
				<TD>
				<INPUT TYPE="text" NAME="WORKDATETO<%=i%>" id="WORKDATETO<%=i%>"   tabIndex=44  SIZE=8 MAXLENGTH=10  onchange="return ValidDateTo('WORKDATETO<%=i%>') " >
				<font color=green face=arialblack> <font size=1><b> <br>(DD-MM-YYYY)&nbsp;</b></font>
				</TD>
			</TR>
			<%
				}
					
	}

					%>
				
	<INPUT TYPE="hidden" NAME="totalexp" id="totalexp" value="<%=i%>" >		
			</TABLE>

</td></TR>



</td></TR>



<TR>
<%
String mCareerG="",mCareer="";

qry="SELECT APPLICATIONSLNO, OBJECTIVESLNO, CAREEROBJECTIVE,    JBSHELP FROM couns2301.C#MBAOBJECTIVE where APPLICATIONSLNO='"+mAppSlno+"' and APPLICATIONSLNO like '"+mAppYear+"%' ";
rs=db.getRowset(qry);
if(rs.next())
	{
		mCareer=rs.getString("CAREEROBJECTIVE");
		mCareerG=rs.getString("JBSHELP");

	}

	%>
<td colspan=4 align=left><br><FONT face=Verdana>12. Describe your most important Career Objectives (Max 200 Words) <br>
  &nbsp;&nbsp;&nbsp; <!-- <INPUT TYPE="text" NAME="Career" id="Career" value="<%=mCareer%>" maxlength=200 tabIndex=45  size=150 >
 -->
  <TEXTAREA NAME="Career" ROWS="5" COLS="80" maxlength=200 tabIndex=45 ><%=mCareer%></TEXTAREA>

</td>
</tr>

<TR>

<td colspan=4 align=left><br><FONT face=Verdana>13. Describe how will the JBS MBA help you in achieving the above career goal ? <br>
  &nbsp;&nbsp;&nbsp; <!-- <INPUT TYPE="text" NAME="Careergoal" id="Careergoal" value="<%=mCareerG%>" maxlength=1000 tabIndex=45  size=150 > -->
   <TEXTAREA NAME="Careergoal" ROWS="5" COLS="80" maxlength=1000 tabIndex=45 ><%=mCareerG%></TEXTAREA>

</td>
</tr>







<tr><td colspan=2>
 	    	<font face='Verdana' size=2 >
14. Documents Attached :  CheckSheet <br>
a) 10TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
<%
	if(mDOC10.equals("Y"))
	{
	%>
<INPUT Type="checkbox" ID="Doc10" Name="Doc10" Value="Y" checked tabIndex=47 >
	<%
	}
	else
	{
	%>
		<INPUT Type="checkbox" ID="Doc10" Name="Doc10" Value="Y" tabIndex=47 >

	 <%
	}
		%>
		<INPUT Type="hidden" ID="10TH" Name="10TH" Value="10TH"   > 
				
<br>
b) 12TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
	<%
	if(mDOC12.equals("Y"))
	{
	%>
	<INPUT Type="checkbox" ID="Doc12" Name="Doc12" Value="Y" checked tabIndex=48>
	 
	
		 <%
	}
	else
	{
	%>
	<INPUT Type="checkbox" ID="Doc12" Name="Doc12" Value="Y" tabIndex=48>
	
	<%
	}
	 %> <INPUT Type="hidden" ID="12TH" Name="12TH" Value="12TH"   > 	 <br>
c) Graduation  : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
	<%
	if(mDOCGRAD.equals("Y"))
	{
	%>
	<INPUT Type="checkbox" ID="DocGrade" Name="DocGrade" checked Value="Y" tabIndex=49>
		
	<%
	}
	else
	{
	%>
	<INPUT Type="checkbox" ID="DocGrade" Name="DocGrade" Value="Y" tabIndex=49>
	<%
	}
	%>
 <INPUT Type="hidden" ID="GRAD" Name="GRAD" Value="GRAD"   > 
	 <br>
d) Other  : &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
&nbsp; &nbsp;&nbsp; &nbsp;
	<%
	if(mDOCOT.equals("Y"))
	{
	%>
	<INPUT Type="checkbox" ID="DocOther" Name="DocOther" checked Value="Y" tabIndex=50>
		
	<%
	}
	else
	{
	%>
	<INPUT Type="checkbox" ID="DocOther" Name="DocOther" Value="Y" tabIndex=50>
	<%
	}
	%>	 
	 <br>
	 e) Score Card of CAT/MAT/XAT/GMAT :
		   <%
if(mCHECKSCORECARD.equals("Y"))
{
%>
<INPUT Type="Checkbox" ID="DocScore" Name="DocScore" Value="Y" checked tabIndex=51>
<%
}
else
	{
	%>
<INPUT Type="Checkbox" ID="DocScore" Name="DocScore" Value="Y"  tabIndex=51>

	<%
	}
	%>  
	  <br>
<tr>
<td colspan=3>
<FONT face=Verdana>

<%
	if(mCHQDDTYPE.equals("P"))
	{
	%>

15.  &nbsp;
Purchased Form	: <b>Rs. 1200 /-</b>
     
	<%
	}
	%>
	<br> 

<%
	if(mCHQDDTYPE.equals("D"))
		{
	
	%>	
15. Registration fee of Rs. 1,200/- by a Demand Draft favoring Jaypee Business
School, payable at Noida (UP) 201 307 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Number: <input ID="DDNO" Name="DDNO" MaxLength=6 value="<%=mCHEQUEDDNO%>" MaxLength=30 Size=15 tabIndex=52><FONT 
      color=#ff4500>*</FONT>
DD Amount: 

	<input ID="DDAMT" Name="DDAMT" MaxLength=4 Size=4 value="<%=mAMOUNT%>"
     tabIndex=53 ><FONT color=#ff4500>*</FONT>

	 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Date:  <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT 
      color=#ff4500>*</FONT>
    </FONT>   <INPUT TYPE="text" NAME=DDDATE ID=DDDATE size=9 tabindex=54 onChange="return iSValidDDDate(DDDATE.value) "  value="<%=mCHEQUEDDDATE%>"
	><!-- <a href="javascript:NewCal('DDDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=Verdana> Drawn on/Bank Name:</FONT> <INPUT size=30 value="<%=mBANKNAME%>" maxlength=150 Id="BANK" Name="BANK" tabIndex=55><FONT color=#ff4500>*</FONT>&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</FONT>
</td>
</tr>
</table>
<%
	}
%>
<table align=center >

<tr>
<td align=center colspan=5>
 <INPUT TYPE="hidden" NAME="AppSlno" id="AppSlno" value="<%=mAppSlno%>" >


<INPUT id=button1 type="submit" value="Update" LANGUAGE=javascript onClick="return button1_onclick('<%=mCurrDate%>');" tabIndex=56>&nbsp;&nbsp;</td></tr>
</table>
</form>
<br>
</BODY></HTML>

<%
}
//-----------------------------
  //-- Enable Security Page Level  
  //-----------------------------
}
  
  else
   {
   %>
	<br>
	<font color=red>
	<h3>	<br><img src='../../Images/Error1.jpg'>	Access Denied (authentication_failed) </h3><br>
	<P>	This page is not authorized/available for you.
	<br>For assistance, contact your network support team. 
	</font>	<br>	<br>	<br>	<br>
   <%
	
	
   }
  //-----------------------------



}
else
{
	out.print("<br><img src='../../Images/Error1.jpg'>");
	out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'> Session Timeout Please <a href='../../index.jsp' target=_New>Login</a> to continue</font> <br>");
}      
}
catch(Exception e)
{
// out.print("aaaaaaaaaaaaa");
}
%>