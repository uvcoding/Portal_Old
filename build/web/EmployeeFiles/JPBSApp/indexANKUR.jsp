<%@ page language="java" import="java.sql.*,tietwebkiosk.*" %>
<%@ page errorPage="CommonFiles/ExceptionHandler.jsp" %> 
<%
try{
String mHead="";
if(session.getAttribute("PageHeading")!=null && !session.getAttribute("PageHeading").equals(""))
	mHead=session.getAttribute("PageHeading").toString().trim();
else
	mHead="JPBS";

GlobalFunctions gb =new GlobalFunctions();
DBHandler db=new DBHandler();
ResultSet rs=null;
String qry="",str1="";
String mValue="";

int mDOBMaxYear=1970;
int mDOBMinYear=1992;
String mMemberID="",mMemberType="",mMemberName="",mMemberCode="";
String mDMemberCode="",mDMemberType="",mDept="",mDesg="", mComp="", minst="", mInst="",mDMemberID="";
//session.setAttribute("Click",mSelf);
session.setMaxInactiveInterval(10800); 
session.setAttribute("APPLICATIONSLNO",null);
//out.print("sdfsfds"+session.getAttribute("APPLICATIONSLNO"));

session.setAttribute("MFLAG",null);

%> 
<html>
<head>
<TITLE>#### <%=mHead%> [ Application Form ] </TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Jaypee Institute of Information Technology</title>
<meta http-equiv="Page-Enter" content="revealTrans(Duration=1.0,Transition=1)">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>

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



function funstate()	
				{
					
					if(LoginForm.OS.checked==true)
					{
						
						LoginForm.Other.value="";
						LoginForm.GradProg.disabled=true;
						LoginForm.Other.disabled=false;
					}
					else
					{
						LoginForm.Other.value="";
						LoginForm.GradProg.disabled=false;
						LoginForm.Other.disabled=true;

					}
				}


function ChangeCase() 
	{
		LoginForm.FirstName.value = LoginForm.FirstName.value.toUpperCase();
		LoginForm.FatherName.value = LoginForm.FatherName.value.toUpperCase();
	 
		LoginForm.ADDRESS1.value = LoginForm.ADDRESS1.value.toUpperCase();
		LoginForm.ADDRESS2.value = LoginForm.ADDRESS2.value.toUpperCase();
		
		LoginForm.CITY.value = LoginForm.CITY.value.toUpperCase();
		Other();
		Grad();
	} 
	
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
	
function button1_onclick(currdate) 
	{


		
		if(document.LoginForm.FirstName.value=="" || document.LoginForm.FirstName.value==" ") 
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

if(document.LoginForm.DOB.value=="" || document.LoginForm.DOB.value==" ")
		{
				alert('Please enter your Date of Birth ');
				LoginForm.DOB.focus();
					return(false);
		}
		if(document.LoginForm.ADDRESS1.value=="" || document.LoginForm.ADDRESS1.value==" ")
			{
				alert('Address Name Should not be left blank');
				LoginForm.ADDRESS1.focus();
					return(false);
			}

		if(document.LoginForm.CITY.value=="" || document.LoginForm.CITY.value==" ")
			{
				alert('City Name Should not be left blank');
				LoginForm.CITY.focus();
					return(false);
			}



		if(document.LoginForm.PIN.value=="" || document.LoginForm.PIN.value==" ")
			{
				alert('PIN Code Should not be left blank');
				LoginForm.PIN.focus();
					return(false);
			}


		if(document.LoginForm.email.value=="" || document.LoginForm.email.value==" ")
		{
				alert('Please enter  Email-ID ');
				LoginForm.email.focus();
					return(false);
		}


		if(document.LoginForm.TenYear.value=="" || document.LoginForm.TenYear.value==" ")
		{
				alert('Please enter  10th Year of Passing ');
				LoginForm.TenYear.focus();
					return(false);
		}
		if(document.LoginForm.TenBoard.value=="" || document.LoginForm.TenBoard.value==" ")
		{
				alert('Please enter  10th Board ');
				LoginForm.TenBoard.focus();
					return(false);
		}
		if(document.LoginForm.TenPercent.value=="" || document.LoginForm.TenPercent.value==" ")
		{
				alert('Please enter  10th Percentage ');
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
		if(document.LoginForm.GradPercent.value=="" || document.LoginForm.GradPercent.value==" ")
		{
				alert('Please enter  Graduation Percentage ');
				LoginForm.GradPercent.focus();
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

if(document.LoginForm.TenPercent.value=="" && document.LoginForm.TewPercent.value=="" && document.LoginForm.GradPercent.value==""  && document.LoginForm.OtherPercent.value=="")
		{
				alert('Please enter Percentage of Qualification ');
				LoginForm.TenPercent.focus();
					return(false);
		}



var TenPercent=document.LoginForm.TenPercent.value;

var TewPercent=document.LoginForm.TewPercent.value;
var GradPercent=document.LoginForm.GradPercent.value;
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
	 if  (GradPercent>100.0)
	{
			 alert('Graduation Percentage Should be less than 100 ');
			  LoginForm.GradPercent.focus();
			  return false;
	}
	if  (OtherPercent>100.0)
	{
			 alert('Other Percentage Should be less than 100 ');
			  LoginForm.OtherPercent.focus();
			  return false;
	}

	

	
	
		
	//	alert("sdsd");

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

	
	var dddate=document.LoginForm.DDDATE.value;
	
	var aa=dddate.substring(10,6)+dddate.substring(5,3)+dddate.substring(2,0);
	//alert(currdate+"sdsd"+aa);
	if(currdate<aa)
		{
			alert('Please Enter DD Date less than the Current Date ');
			LoginForm.DDDATE.focus();
			return false ;
		}

//return false ;
}


function iSValidDate(pDate)
{
//1 

if(document.LoginForm.DOB.value!="" && document.LoginForm.DOB.value!=" " )
{
    var dn, mn, yn, maxday;
    var mDate = pDate;
    dn = 0;
    mn = 0;
    yn = 0;
    maxday = 0;
    var mISValidDate = false;
//	alert(mDate.length+"sssss");
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
              mISValidDate =true;
          } //5
		  else
		  {
  			alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.'); 
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
        } //4
		else
		  {
		alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.'); 
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
      } //3
	  else if(mDate.length!=10)
		  {
		  alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.'); 
			LoginForm.DOB.value="";
			LoginForm.DOB.focus();
		  }
 //   } //2
  return (mISValidDate);
}
else
	//if(LoginForm.DOB.value==null)
	 {
		  alert('Please Enter the valid date format in DOB date field i.e DD-MM-YYYY.'); 

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
	
	
	function RadioCheck()
	{
		//alert("sdas");
		

		if(document.LoginForm1.AppRadio1.checked==true)
		{
			 document.LoginForm1.AppRadio2.checked=false;
			 document.LoginForm1.AppNo.disabled=false;
			document.LoginForm1.IntAppNo.disabled=true;
			return(false);
		}
		
		
	}
	function OnLoad()
	{
	//alert(document.LoginForm1.z.value+"sada"s);
		document.LoginForm1.AppRadio1.checked=true;
		document.LoginForm1.AppNo.disabled=false;
		document.LoginForm1.IntAppNo.disabled=true;
		


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
	
	function RadioCheck1()
	{
		  if(document.LoginForm1.AppRadio2.checked==true)
		{
			 document.LoginForm1.AppRadio1.checked=false;
			 document.LoginForm1.IntAppNo.disabled=false;
			document.LoginForm1.AppNo.disabled=true;
			return(false);
		}
	}

	function Check()
	{
			
		if(document.LoginForm1.AppNo.value=="" && document.LoginForm1.IntAppNo.value=="") 
			{
			alert('Application No. Should not be left blank');
				document.LoginForm1.AppRadio1.checked=true;
				document.LoginForm1.AppNo.disabled=false;
				 document.LoginForm1.AppRadio2.checked=false;
				document.LoginForm1.IntAppNo.disabled=true;
				LoginForm1.AppNo.focus();
					return(false);
			}
		//alert(document.LoginForm.TenYear+"sdsd");
	}


</SCRIPT>
<script language="JavaScript" type ="text/javascript" src="../js/datetimepicker.js"></script>
</head>
<BODY bgcolor=white  rightmargin=0 leftmargin=0 topmargin=0 bottommargin=0 onLoad="OnLoad();" >
 <table  border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups borderColor=black>
<tr>
<td ALIGN=middle><FONT face=Verdana><STRONG><U><FONT size=3><FONT 
      color=brown 
      size=4>JAYPEE INSTITUTE OF INFORMATION TECHNOLOGY  <br>Jaypee Business School</FONT> 
      </FONT></U></STRONG></FONT><BR><FONT face=Verdana><FONT 
      size=1>(Eastablished U/S 3 of the UGC Act, 1956, vide notification No. F.9-27/2000-U-3 dated 1<sup>st</sup> November, 2004 
      of Govt of India)</FONT>       
  </FONT>                
</td>
</tr>
<tr><td ALIGN=middle><FONT 
      face=Verdana><STRONG><FONT size=4>MBA APPLICATION FORM - 2010 </font><br><FONT size=2>(Do not submit without copy of CAT/MAT/GMAT score card)</FONT></STRONG>
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
	  %>
<form method=post name="LoginForm1" >
  <input id="x" name="x" type=hidden>
  
  <%
if(request.getParameter("x")==null)
{
	%>
<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >

<tr><td ><FONT face=Verdana><b><INPUT TYPE="radio" NAME="AppRadio1"  id="AppRadio1" onClick=" RadioCheck();" Value="App" > &nbsp;Application No:</b></FONT><INPUT  Name="AppNo" ID="AppNo" size=2 maxlength=4 tabIndex=1 LANGUAGE=javascript onkeypress="return isNumber(event)"	><FONT 
      face="Times New Roman" color=#ff4500>*</FONT>
&nbsp;&nbsp;
<FONT face=Verdana><b> or &nbsp; &nbsp; 
<INPUT TYPE="radio"  onClick=" RadioCheck1();"  NAME="AppRadio2"   id="AppRadio2" Value="IntApp" >Click if InternetApp, Internet App No:&nbsp; INT </b></FONT><INPUT ID="IntAppNo" Name="IntAppNo"  size=3 maxlength=4 tabIndex=1 LANGUAGE=javascript onkeypress="return isNumber(event)"	><FONT 
      face="Times New Roman" color=#ff4500>*</FONT></td>
</tr>

<tr>

<td colspan =2 align=center><INPUT TYPE="submit" onclick="return Check();" tabIndex=2 value="Submit"></td>
</tr>
<%
}
%>


</form>

<form method=post action="ApplicationFormAction.jsp" name="LoginForm">

<%
if(request.getParameter("x")!=null)
{



String  mAppNo="",mIntAppNo="",mAppRadio1="",mAppRadio2="",mCurrDate="";



qry="Select To_char(Sysdate,'yyyymmdd' ) Dat from dual  ";
rs=db.getRowset(qry);
rs.next();
mCurrDate=rs.getString(1);


if(request.getParameter("AppNo")==null)
	mAppNo="";
else
	mAppNo=request.getParameter("AppNo").toString().trim();


if(request.getParameter("IntAppNo")==null)
	mIntAppNo="";
else
	mIntAppNo=request.getParameter("IntAppNo").toString().trim();

if(request.getParameter("AppRadio1")==null)
	mAppRadio1="";
else
	mAppRadio1=request.getParameter("AppRadio1").toString().trim();


if(request.getParameter("AppRadio2")==null)
	mAppRadio2="";
else
	mAppRadio2=request.getParameter("AppRadio2").toString().trim();

int mFlag=0,mCheckDD=0;
String mIntApplication="";

//out.print(mAppRadio1+"mAppRadio1"+mAppNo);
//out.print(mAppRadio2+"mAppRadio2"+mIntAppNo);
if(mAppRadio1.equals("App") && !mAppNo.equals(" ") )
{
mIntApplication=mAppNo;
mFlag=1;
mCheckDD=1;
}
else if(mAppRadio2.equals("IntApp") && !mIntAppNo.equals(" ")) 
{
 mIntApplication="INT"+mIntAppNo;
 mFlag=1;

}


//out.print(mIntApplication+"mIntApplication");
//if(!mIntApplication.equals(" ") )
if(mFlag==1 )
{
qry="select 'Y' from C#MBAAPPLICATIONMASTER where APPLICATIONNO='"+mIntApplication+"' and nvl(deactive,'N')='N'  ";
//out.print(qry);
rs=db.getRowset(qry);

if(!rs.next())
{

	%>

<input Type=hidden name="AppNo" id="AppNo" Value="<%=mIntApplication%>">


<table width="98%" border="1" cellpadding="0" cellspacing="0" style="FONT-SIZE: x-small"   valign="middle" align=center rules=groups >
<tr><td ><FONT face=Verdana><b>Application No :  <%=mIntApplication%></b></FONT><FONT 
       color=#ff4500>*</FONT>
</td></tr>
<tr><td ><FONT face=Verdana>1. Name of Candidate :</FONT><INPUT ID="FirstName" Name="FirstName" size=60 maxlength=60 tabIndex=2 	onfocusout="return ChangeCase()"><FONT 
      color=#ff4500>*</FONT></td>
</tr>
<tr>
<td colspan=3 align=left><FONT face=Verdana> 2. Father's Name 
      :  &nbsp;   &nbsp; &nbsp;</FONT>   <INPUT size=60 maxlength=60 Id="FatherName" Name="FatherName" 
      tabIndex=3  LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT 
      face=Verdana><FONT       color=#ff4500>*</FONT> </FONT>
</td>
</tr>
<tr>
<td><FONT face=Verdana>3. Gender <FONT color=tomato>*</FONT>   
<INPUT Type="radio" ID="Gender" Name="Gender" Value="M" checked tabIndex=4>Male
<INPUT Type="radio" ID="Gender" Name="Gender" Value="F"  
      tabIndex=5>Female</FONT> </SELECT><FONT face=Verdana> 
</FONT>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   &nbsp;&nbsp;&nbsp;<FONT face=Verdana>4. Date of Birth <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT 
      face="Times New Roman" 
      color=#ff4500>*</FONT>    
	<INPUT TYPE="text" NAME=DOB ID=DOB size=9 onchange="return iSValidDate(DOB.value)"  onclick="return iSValidDate(DOB.value)" tabindex=6  maxlength=10
	><!-- <a href="javascript:NewCal('DOB','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
	    
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
&nbsp; &nbsp; &nbsp; &nbsp;<input ID="ADDRESS1" Name="ADDRESS1" MaxLength=80 Size=70 tabIndex=13  LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT color=#ff4500>*</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input ID="ADDRESS2" Name="ADDRESS2" MaxLength=75 Size=70 tabIndex=14 LANGUAGE=javascript onfocusout="return ChangeCase()"><br>
&nbsp; &nbsp; &nbsp; &nbsp;<FONT face=Verdana size=2>City:</FONT> <input ID="CITY" Name="CITY" MaxLength=25 Size=25  tabIndex=15 LANGUAGE=javascript onfocusout="return ChangeCase()"><FONT 
      color=#ff4500>*</FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT face=Verdana size=2>PIN: <input ID="PIN" Name="PIN" MaxLength=8 Size=6 tabIndex=16 LANGUAGE=javascript onkeypress="return isNumber(event)"><FONT 
      color=#ff4500>*</FONT></FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;



 <FONT face=Verdana size=2>Country: 
<select name="Country" id="Country" tabIndex=17>
  <option value='INDIA' selected>India</option>
	<%
	/*try{	
	   qry="select distinct COUNTRYCODE,COUNTRYNAME FROM COUNTRYMASTER order by 2";

	     rs=db.getRowset(qry);
		while(rs.next())
		{
	%>
		<!--   <option value=<%=rs.getString("COUNTRYCODE")%>><%=rs.getString("COUNTRYNAME")%></option> -->
	<%
	/*	}
		}
		catch(Exception e)
		{

		}*/
	%>
 </select>	<font color=red>*</font>
 <FONT face=Verdana size=2>State: 
<SELECT ID="STATE" Name="STATE" tabIndex=18>
<option Value="Delhi" selected >Delhi
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
<option Value="MadhyaPradesh">Madhya Pradesh</option>
<option Value="Uttarakhand">Uttarakhand</option>
<option Value="WestBengal">West Bengal</option>
<option Value="ANI">Andaman and Nicobar Islands</option>
<option Value="Chandigarh">Chandigarh</option>
<option Value="DNH">Dadra and Nagar Haveli</option>
<option Value="DD">Daman and Diu</option>
<option Value="Lakshadweep">Lakshadweep</option>
<option Value="Puducherry">  Puducherry</option>
<option Value="Other">  Other</option>

</SELECT><FONT 
      color=#ff4500>*</FONT>&nbsp;
</FONT><FONT face=Verdana size=2>PhoneNo or Moblie No:<input ID="MOBILE" Name="MOBILE" onchange="return ValidPhone();" onkeypress="return isNumber(event)" MaxLength=20 Size=15 tabIndex=19  ></FONT>
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana> 7. Email Address (Mandatory	):&nbsp; <INPUT ID="email" Name="email" maxLength=50 size=50 tabIndex=20> <FONT  color=#ff4500>*</FONT> 
</FONT>   
</td>
</tr>

<tr>
<td colspan=3>
<FONT face=Verdana>8. Nationality: &nbsp;&nbsp;&nbsp;&nbsp; <INPUT Type="radio" ID="Nationality" Name="Nationality" Value="INDIAN" Checked tabIndex=21>Indian
&nbsp;&nbsp;&nbsp;<INPUT Type="radio" ID="Nationality" Name="Nationality" Value="FOREIGN" tabIndex=22>Foreign</FONT>       
</td>
</tr>


 <TR>
<td colspan=3 align=left><FONT face=Verdana>9. Current Qualification
 
 <br>
 <TABLE BORDER=1 ALIGN=center  cellspacing=2 cellpadding=2>
			<tr>
			<td>&nbsp;</td>
			<td><font face='Verdana' size=2 ><b>Year of Completion</b></td>
			<td><font face='Verdana' size=2 ><b>Stream </b></td>
			<td><font face='Verdana' size=2 ><b>Board / University</b></td>
			<td><font face='Verdana' size=2 ><b>% of Marks</b></td>
			</tr>
			<TR>
				
				<TD><font face='Verdana' size=2 >10th  &nbsp;&nbsp;
			
				</TD>
				<TD><INPUT TYPE="text" NAME="TenYear" id="TenYear" tabIndex=23  SIZE=15 MAXLENGTH=20 ><font color=red>*</font></TD>
				<td>&nbsp;</td>
				
				<TD><INPUT TYPE="text" NAME="TenBoard"   size=20 maxlength=50 tabIndex=25><font color=red>*</font></TD>
				<TD><INPUT TYPE="text" NAME="TenPercent" onchange="OnPercent();"   onKeyPress="return numbersonly(this, event); 
"  SIZE=3 MAXLENGTH=5 tabIndex=26><font color=red>*</font></TD>
			</TR>
			<TR>
				
				<TD><font face='Verdana' size=2 >12th &nbsp;&nbsp;
			
				</TD>
				<TD><INPUT TYPE="text" NAME="TewYear"   SIZE=15 MAXLENGTH=20 tabIndex=27></TD>
				<TD><select  Id="TewStream" Name="TewStream" onchange="Other(TewStream.value);" tabIndex=28 >
		<option Value="Science" selected >Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
				<option Value="Others">Others
		</option>
		</SELECT>
		<INPUT TYPE="text" NAME="TewStream1" id="TewStream1" MAXLENGTH=30 size=10 tabIndex=28>
		</TD>
					<TD><INPUT TYPE="text" NAME="TewBoard"   size=20 maxlength=50 tabIndex=29></TD>
						<TD><INPUT TYPE="text" NAME="TewPercent" onchange="OnPercent();"  onKeyPress="return numbersonly(this, event); 
"  SIZE=3 MAXLENGTH=5 tabIndex=30></TD>
			</TR>
			
			<TR>
			<TD><font face='Verdana' size=2 >Graduation&nbsp;
			
			</TD> 
				<TD><INPUT TYPE="text" NAME="GradYear"   SIZE=15 MAXLENGTH=20 tabIndex=31></TD>
				<TD><select  Id="GradStream" Name="GradStream" onchange="Grad(GradStream.value);" tabIndex=32 >
		<option Value="Science" selected >Science	</option>
		<option Value="Arts">Arts	</option>
		<option Value="Commerce">Commerce	</option>
		<option Value="Engineering">Engineering	</option>
		<option Value="Others">Others		</option>
		</SELECT>
		<INPUT TYPE="text" NAME="GradStream1" id="GradStream1" tabIndex=32  MAXLENGTH=30 size=10 >
		</TD>
					<TD><INPUT TYPE="text" NAME="GradBoard"   size=20 maxlength=50 tabIndex=33></TD>
						<TD><INPUT TYPE="text" NAME="GradPercent"  onchange="OnPercent();" onKeyPress="return numbersonly(this, event); 
"  SIZE=3 MAXLENGTH=5 tabIndex=34></TD>
			</TR>

			
			<TR>
			<TD><font face='Verdana' size=2 >Other(if any)&nbsp;

			</TD> 
				<TD><INPUT TYPE="text" NAME="OtherYear"   SIZE=15 MAXLENGTH=20 tabIndex=35 ></TD>
				<TD><INPUT TYPE="text" NAME="OtherStream"   SIZE=15 MAXLENGTH=30 tabIndex=36></TD>
				<TD><INPUT TYPE="text" NAME="OtherBoard"   size=20 maxlength=50 tabIndex=37></TD>
				<TD><INPUT TYPE="text" NAME="OtherPercent" onchange="OnPercent();"  onKeyPress="return numbersonly(this, event); 
"   SIZE=3 MAXLENGTH=5 tabIndex=38></TD>
			</TR>
			</TABLE>

<FONT face=Verdana><sup>*</sup> If appearing,attach certificate from Head of Institution.[e.g Science/Arts/Commerce/Others(specify)]<br>&nbsp;&nbsp;&nbsp;<b>Click</b>: <INPUT Type="radio" ID="Appear" Name="Appear" Value="Y"  tabIndex=38>Yes &nbsp;
	   <INPUT Type="radio" ID="Appear" Name="Appear"  checked Value="N" tabIndex=38>No


</td>
</tr>
<TR>

<td colspan=3 align=left><br><FONT face=Verdana>10. Please Fill as Applicable  (Attach copy of Score Card Mandatory) <br>



  <br>
	<TABLE BORDER=1 ALIGN=center cellspacing=2 cellpadding=2>
			<tr>
			<td><font face='Verdana' size=2 ><b>Exam</b></td>
			<td><font face='Verdana' size=2 ><b>Composite Score/Total Score</b></td>
			<td><font face='Verdana' size=2 ><b>Percentile/Total Percentile	</b></td>
			<td><font face='Verdana' size=2 ><b>Result Valid Upto</b></td>
			</tr>
			<TR>
				
				<TD><font face='Verdana' size=2 >CAT  &nbsp;&nbsp;
				
				</TD>
				<TD><INPUT TYPE="text" NAME="CATCOMP"  onkeypress="return isNumber(event)"  tabIndex=39  SIZE=3 MAXLENGTH=4></TD>
				<TD><INPUT TYPE="text" NAME="CATPER"  onKeyPress="return numbersonly(this, event); 
"   SIZE=3 MAXLENGTH=5 tabIndex=40></TD>
<TD><INPUT TYPE="text" NAME="CATDATE" onChange="return ValidCATDATE(CATDATE.value) "  onCLICK="return ValidCATDATE(CATDATE.value) "    tabIndex=40  SIZE=8 MAXLENGTH=10><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('CATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			<TR>	
				
				<TD><font face='Verdana' size=2 >MAT &nbsp;&nbsp;
				<!-- <INPUT Type="checkbox" ID="MatCheck" Name="MatCheck" Value="MatCheck"  > -->
				</TD>
				<TD><INPUT TYPE="text" NAME="MATCOMP" onkeypress="return isNumber(event)"  SIZE=3 MAXLENGTH=4 tabIndex=41></TD>
				<TD><INPUT TYPE="text" NAME="MATPER"  onKeyPress="return numbersonly(this, event); 
"  SIZE=3 MAXLENGTH=5 tabIndex=42></TD>
<TD><INPUT TYPE="text" NAME="MATDATE"  onClick="return ValidMATDATE(MATDATE.value) "    onChange="return ValidMATDATE(MATDATE.value) "  tabIndex=42  SIZE=8 MAXLENGTH=10><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('MATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			
			<TR>
			<TD><font face='Verdana' size=2 >GMAT&nbsp;
			<!-- <INPUT Type="checkbox" ID="GmatCheck" Name="GmatCheck" Value="GmatCheck"  >-->
			</TD> 
				<TD><INPUT TYPE="text" NAME="GMATCOMP" onkeypress="return isNumber(event)"  SIZE=3 MAXLENGTH=4 tabIndex=43></TD>
				<TD><INPUT TYPE="text" NAME="GMATPER"  onKeyPress="return numbersonly(this, event); 
"   SIZE=3 MAXLENGTH=5 tabIndex=44></TD>
<TD><INPUT TYPE="text" NAME="GMATDATE"   onClick="return ValidGMATDATE(GMATDATE.value) " onChange="return ValidGMATDATE(GMATDATE.value) "    tabIndex=44  SIZE=8 MAXLENGTH=10><font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font>
<!-- <a href="javascript:NewCal('GMATDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->
</TD>
			</TR>
			</TABLE>

</td></TR>


	<tr><td colspan=2>
 	    	<font face='Verdana' size=2 >
11. Documents Attached :  CheckSheet <br>
a) 10TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;<INPUT Type="checkbox" ID="Doc10" Name="Doc10" Value="Y" tabIndex=45 >
	   
<br>
b) 12TH  :  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; &nbsp;<INPUT Type="checkbox" ID="Doc12" Name="Doc12" Value="Y" tabIndex=46>
	 	   <br>
c) Graduation  :  &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp; &nbsp;&nbsp;&nbsp;<INPUT Type="checkbox" ID="DocGrade" Name="DocGrade" Value="Y" tabIndex=47>
<br>
d) Other  :  &nbsp;  &nbsp;   &nbsp;  &nbsp;  &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;
&nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp; &nbsp; <INPUT Type="checkbox" ID="DocOther" Name="DocOther" Value="Y" tabIndex=47>
	 	   <br>
e) Score Card of CAT/MAT/GMAT :<INPUT Type="Checkbox" ID="DocScore" Name="DocScore" Value="Y" tabIndex=48>
	  <br>

<tr>
<td colspan=3>
<FONT face=Verdana>
12. 
<%
	if(mCheckDD==1)
	{
	%>
&nbsp;
	Purchased Form	of Rs. 1200/-<br> 
	<%
	}
	else
	{
		%>

 Registration fee of Rs. 1,200/- by a Demand Draft favoring Jaypee Business
School, payable at Noida (UP) 201 307 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Number: <input ID="DDNO" Name="DDNO" MaxLength=30 Size=15 tabIndex=51><FONT 
      color=#ff4500>*</FONT>
DD Amount: <input ID="DDAMT" Name="DDAMT" MaxLength=4 Size=4 
     tabIndex=52 ><FONT color=#ff4500>*</FONT><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DD Date:  <font color=green face=arialblack font size=2><b> (DD-MM-YYYY)&nbsp;</b></font><FONT 
      color=#ff4500>*</FONT>
    </FONT>   <INPUT TYPE="text" NAME="DDDATE" ID="DDDATE" onChange="return iSValidDDDate(DDDATE.value) " size=9  MaxLength=10  tabindex=53  
	>
	
	<!-- <a href="javascript:NewCal('DDDATE','ddmmyyyy')"><img src="../images/cal.gif" width="16" height="16" border="0" alt="Pick a Date"></a> -->


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT face=Verdana> Drawn on/Bank Name:</FONT> <INPUT size=30 maxlength=150 Id="BANK" Name="BANK" tabIndex=54><FONT color=#ff4500>*</FONT>&nbsp;
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<%
	}
	%>

</FONT>
</td>
</tr>
</table>
<table align=center >

<tr>
<td align=center colspan=5>
<INPUT id=button1 type="submit" value="Save" LANGUAGE=javascript onClick="return button1_onclick('<%=mCurrDate%>');" tabIndex=55>&nbsp;&nbsp;<INPUT id=button2 type=reset value="Reset" tabIndex=56></td></tr>
</table>

<%

}
else
{

out.print("<img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Application No. Already Exists <br>");	

}
}
else
	{
out.print("<img src='../../Images/Error1.jpg'>");
		out.print(" &nbsp;&nbsp;&nbsp <b><font size=3 face='Arial' color='Red'>Please Enter Application No.<br>");	

	}


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
</form>
<br>
</BODY></HTML>