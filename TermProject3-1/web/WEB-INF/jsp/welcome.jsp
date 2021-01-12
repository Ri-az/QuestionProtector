<%-- 
    Document   : welcome
    Created on : Jun 9, 2018, 1:22:56 PM
    Author     : Jakir Hossain Riaz
--%>

<%@page import="java.sql.*"%>
<%@page import="dataaccessobject.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<html>
    <head>
        <title>Welcome</title>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>

        <link href="<c:url value="/resources/css/welcome.css"/>" rel="stylesheet" type="text/css" />
    </head>
    <body background='<c:url value="/resources/images/loginbackground.jpg"/>'>
        <jsp:include page="genusernav.jsp" flush="true"/>
        <%String se = "";
            if (request.getAttribute("secure") != null) {
                se = request.getAttribute("secure").toString();
            }
            if (se.isEmpty()) {
        %>

        <div class="login-box">
            <img src="<c:url value="/resources/images/loginhead.jpg"/>" class="avator" alt="loginhead.jpg"/>
            <h1>Login Here</h1>

            <form method="post" action="checkvalidity.show">
                <table>
                    <tbody>
                        <tr style="color: white;">
                            <td>Username</td>
                            <td>: </td>
                            <td><input type="text" name="uname" id="uname" class="form-control" /></td>
                        </tr>
                        <tr style="color: white;">
                            <td>Password</td>
                            <td>: </td>
                            <td><input type="password" name="pass" id="pass" class="form-control"/></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td><input type="submit" value="login"/></td>
                        </tr>

                        <tr>
                            <td><a href="#">Forget_Password</a></td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <%
        } else if (se.equals("show")) {
            se = "";

        %>
        <div class="security">
            <img src="<c:url value="/resources/images/loginhead.jpg"/>" class="avator" alt="loginhead.jpg"/>
            <div style="margin: 0px 5px;">
                <form method="post" action="security.show">
                    <table width="100%">
                        <tbody>
                            <tr style="color:white;">
                                <td colspan="2">Security code</td>
                            </tr>
                            <tr>
                                <td><input type="text" id="sec" name="sec" class="form-control" style="width: 90%"></td>
                                <td style="float: right;"><button class="form-control" style="width: 100px" value="submit">Send <span class="glyphicon glyphicon-send"></span></td>
                            </tr>
                            <tr>
                                <td colspan="2"><button class="btn btn-link" style="color:white;" value="submit"><span class="glyphicon glyphicon-repeat"> ResendCode</span></td>
                            </tr>
                            <tr><td colspan="2" style="border-bottom: 2px solid red; color:white;">A security code is sent to your email. Check your email.</td></tr>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
        <%
            }
        %>
    </body>
</html>
