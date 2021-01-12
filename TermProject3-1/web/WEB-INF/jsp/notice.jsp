<%-- 
    Document   : notice
    Created on : Jun 20, 2018, 10:22:52 PM
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
        <title>QuestionProtector|Notice</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>
    </head>
    <body background= '<c:url value="/resources/images/genback.jpg"/>'>
        <jsp:include page="genusernav.jsp" flush="true"/>
        <div class="container">
            <div style="background-color: rgba(0,0,0,0.8);width: 95%; height: 560px; margin: 0% 3%">
                <div style="max-height: 500px;overflow-y: auto; padding: 10px 30px; color: white;">
                    <table id="filetable" class="table table-row">
                        <thead>
                            <tr style="background-color: #f4511e;">
                                <th class="text-left">Date</th>
                                <th class="text-left">File Name</th>
                                <th class="text-right">File Size</th>
                            </tr>
                        </thead>
                        <tbody id="fileTable">
                            <%
                                Database db = new Database();
                                ResultSet rs = null;
                                String qr = "select * from noticeinfo order by date desc";
                                if (db.createconnection()) {
                                    rs = db.search(qr);
                                } else {
                                    System.out.println("Database connection error!!");
                                }

                                if (!rs.next()) {
                            %>
                        <td class="text-left">No Files Found</td>
                        <%
                            }
                            while (rs.next()) {
                        %>
                        <tr>
                            <td class="text-left"><% out.println(rs.getString("date"));%></td>
                            <td class="text-left"><a href="FileShow.show?id=<%=rs.getString("id")%>&tab=2" target="_blank"><% out.println(rs.getString("noticename"));%></a></td>
                            <td class="text-right"> <% out.println(Math.round(Integer.parseInt(rs.getString("noticesize")) / 1000));%> KB</td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>

            </div>
            <script src="<c:url value="/resources/javascript/notice.js"/>"></script>
    </body>
</html>
