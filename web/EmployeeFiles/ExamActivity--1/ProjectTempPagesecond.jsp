<html>
<body>
<%
String Excel="",finalsave="";
if(request.getParameter("Excel")==null)
	Excel="";
else
	Excel=request.getParameter("Excel");
if(request.getParameter("finalsave")==null)
	finalsave="";
else
	finalsave=request.getParameter("finalsave");


if(!Excel.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("ProjectStudentGradesXLS.jsp");
	rd.forward(request,response);
}
if(!finalsave.equals(""))
{
	RequestDispatcher rd=request.getRequestDispatcher("ProjectFinalSaveGradeCalculation.jsp");
	rd.forward(request,response);
}
%>
</body>
</html>