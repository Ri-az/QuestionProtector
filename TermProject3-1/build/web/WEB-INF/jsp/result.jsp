<%-- 
    Document   : result
    Created on : Jun 20, 2018, 5:07:41 PM
    Author     : Jakir Hossain Riaz
--%>

<%@page import="java.sql.*"%>
<%@page import="dataaccessobject.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QuestionProtector|Result</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>
    </head>
    <body background= '<c:url value="/resources/images/genback.jpg"/>'>
        <jsp:include page="genusernav.jsp" flush="true"/>
        <div class="container" style="height: 580px; width: 80%; margin:0% 25%;">
            <iframe src="http://www.educationboardresults.gov.bd/" height="570px" width="67%"></iframe>
        </div>
        <script src="<c:url value="/resources/javascript/result.js"/>"></script>
    </body>
</html>
