<%-- 
    Document   : noticeupload
    Created on : Jun 20, 2018, 10:25:46 PM
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
        <title>QuestionProtector|NoticeUpload</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>

        <link href="<c:url value="/resources/css/home.css"/>" rel="stylesheet" type="text/css" />

        <script>
            $(document).ready(function () {
                $("#flip").click(function () {
                    $("#panel").slideToggle("slow");
                });
            });
        </script>
    </head>
    <body>

        <jsp:include page="header.jsp" flush="true" />
        <div class="container">
            <div id="noticealert" style="display:none;"></div>

            <span id="flip"><button class="button" style="vertical-align:middle"><span>Upload Notice</span></button></span><br><br>
            <div id="panel">
                <form action="noticeuploadaction.show" method="post" enctype="multipart/form-data" onsubmit="return noticeuploadfile();">
                    <div class="row">
                        <div class="col-md-1">
                            <label for="date">Date</label>
                        </div>
                        <div class="col-md-2">
                            <input type="date" class="form-control" id="date" name="date">
                        </div>

                        <div class="col-md-2"><label for="filename">Notice File Name</label></div>
                        <div class="col-md-4">
                            <input type="file" id="filename" name="filename" multiple onchange="selectedfiles();">
                        </div>
                    </div><br>

                    <div style="max-height: 300px;overflow-y: auto;">
                        <table id="filetable" class="table table-striped" style="background-color: #d9d9d9;">

                        </table>
                    </div>
                    <div id="uploadbtn" align="right">

                    </div>

                </form>

            </div><br><br>

            <div style="float:right;">
                <div class="input-group">
                    <input type="text" id="myInput" class="form-control" placeholder="Search..." name="search" style="width:180px;">
                </div>
            </div>
            <br><br>

            <div style="max-height: 500px;overflow-y: auto;">
                <table id="filetable" class="table table-striped" >
                    <thead>
                        <tr style="background-color: #f4511e;">
                            <th class="text-left">Date</th>
                            <th class="text-left">File Name</th>
                            <th class="text-right">File Size</th>
                            <th class="text-right">Option</th>
                        </tr>
                    </thead>
                    <tbody id="fileTable">
                        <%
                            Database db = new Database();
                            ResultSet rs = null;
                            String tablename = "noticeinfo";

                            String qr = "select * from noticeinfo ";
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
                        <td class="text-right"><button class="btn btn-link" id ="filebtn" name="filebtn" onclick="deleteNotice(<%=rs.getString("id")%>);">Delete <span class="glyphicon glyphicon-trash"></span></button>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div><br><br>





        </div>
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#fileTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>

        <script src="<c:url value="/resources/javascript/noticeupload.js"/>"></script>
    </body>
</html>
