<%@ page language="java" import="java.sql.*,tietwebkiosk.*,java.util.regex.*" %>
<%@ page errorPage="../../CommonFiles/ExceptionHandler.jsp,java.lang.ArrayIndexOutOfBoundsException" %>

<%-- 
    Document   : Set_QueryCriteria
    Created on : Jul 12, 2014, 11:42:31 AM
    Author     : Gyanendra.Bhatt
--%>
<%try{
String result="";
ResultSet rsSet=null;
DBHandler db=new DBHandler();
String event=request.getParameter("event")==null?"":request.getParameter("event").trim();
String comp=request.getParameter("comp")==null?"":request.getParameter("comp").trim();
String set=request.getParameter("set")==null?"":request.getParameter("set").trim();
String QrySet=" select distinct  cset from TP#ELIGIBILITYCRITERIA where eventcode='"+event+"' and companycode='"+comp+"' and rownum <=2 order by cset  ";
//System.out.print(QrySet+"*******");
rsSet=db.getRowset(QrySet);
while(rsSet.next())
    {
 result=set+"@"+result+rsSet.getString("cset")+"$";
    }


out.println(result);
}catch(Exception e)
        {
        out.print(e);
        }
%>
