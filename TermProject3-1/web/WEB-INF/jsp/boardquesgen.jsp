<%-- 
    Document   : boardquesgen
    Created on : Jul 6, 2018, 4:36:31 PM
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
        <title>QuestionProtector|Board Question</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>
        
    </head>
    <body background= '<c:url value="/resources/images/genback.jpg"/>'>
        <jsp:include page="genusernav.jsp" flush="true"/>

        <div class="container">
            <div style="background-color: rgba(0,0,0,0.8);width: 95%; height: 580px;margin: 0% 3%">
                <div style="max-height: 500px;overflow-y: auto; padding: 10px 30px; color: white;">
                    <table id="filetable" class="table table-row">
                        <thead>
                            <tr style="background-color: #f4511e;">
                                <th class="text-left">Date</th>
                                <th class="text-left">Subject Code</th>
                                <th class="text-left">Board</th>
                                <th class="text-left">File Name</th>
                                <th class="text-right">File Size</th>
                            </tr>
                        </thead>
                        <tbody id="fileTable">
                            <%
                                String Page = "";
                                if (request.getAttribute("s") != null) {
                                    Page = request.getAttribute("s").toString();
                                }
                                Database db = new Database();
                                ResultSet rs = null;
                                String qr = "";

                                if (Page.equals("1")) {
                                    qr = "select * from boardques where subjectcode='Math_109' order by date desc";
                                } else if (Page.equals("21")) {
                                    qr = "select * from boardques where subjectcode='Ban_101' order by date desc";
                                } else if (Page.equals("22")) {
                                    qr = "select * from boardques where subjectcode='Ban_102' order by date desc";
                                } else if (Page.equals("31")) {
                                    qr = "select * from boardques where subjectcode='Eng_107' order by date desc";
                                } else if (Page.equals("32")) {
                                    qr = "select * from boardques where subjectcode='Eng_108' order by date desc";
                                } else if (Page.equals("4")) {
                                    qr = "select * from boardques where subjectcode='Phy_136' order by date desc";
                                } else if (Page.equals("5")) {
                                    qr = "select * from boardques where subjectcode='Chem_137' order by date desc";
                                } else if (Page.equals("6")) {
                                    qr = "select * from boardques where subjectcode='Bio_138' order by date desc";
                                } else if (Page.equals("7")) {
                                    qr = "select * from boardques where subjectcode='Islam_111' order by date desc";
                                }

                                if (db.createconnection()) {
                                    rs = db.search(qr);
                                } else {
                                    System.out.println("Database connection error!!");
                                }
                            while (rs.next()) {
                        %>
                        <tr>
                            <td class="text-left"><% out.println(rs.getString("date"));%></td>
                            <td class="text-left"><% out.println(rs.getString("subjectcode"));%></td>
                            <td class="text-left"><% out.println(rs.getString("board"));%></td>
                            <td class="text-left"><a href="FileShow.show?id=<%=rs.getString("id")%>&tab=3" target="_blank"><% out.println(rs.getString("filename"));%></a></td>
                            <td class="text-right"> <% out.println(Math.round(Integer.parseInt(rs.getString("filesize")) / 1000));%> KB</td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="<c:url value="/resources/javascript/boardquesgen.js"/>"></script>
    </body>
</html>
