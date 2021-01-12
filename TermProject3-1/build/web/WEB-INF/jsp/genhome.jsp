<%-- 
    Document   : genhome
    Created on : Jun 18, 2018, 8:19:06 PM
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
        <title>QuestionProtector|Home</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>
    </head>
    <body background= '<c:url value="/resources/images/genback.jpg"/>'>
        <jsp:include page="genusernav.jsp" flush="true"/>
        <div class="container" style="background-color: rgba(0,0,0,0.8); color:white; width: 80%;padding: 40px;">
            <h3 style="color: #f4511e;">Welcome to the official website of "Education Board of Bangladesh ".</h4><br><br>
                <p>
                    This website contains information about <strong>Education Board of Bangladesh </strong>and its organizational structure, wings, functionality, and responsibilities. 
                    This website also contains information about Education Sector Development Program of Bangladesh.<br><br>

                    There are nine Boards of <strong>Intermediate and Secondary Education </strong>are responsible for conducting the public examinations such as Secondary School Certificate and Higher Secondary Certificate level public examinations.
                    The Boards are also responsible for the recognition of the private sector educational institute.<br><br>
                    
                    Through this website Education Board can control the<strong> Intermediate and Secondary Education Question</strong> of the board. 
                    In this highly secured website education board can take the exam perfectly without any question leaked.
                </p>
            </h3>
        </div>
        
        <script src="<c:url value="/resources/javascript/genhome.js"/>"></script>
    </body>
</html>