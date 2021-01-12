<%-- 
    Document   : previousquestion
    Created on : Jul 4, 2018, 11:55:28 AM
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
        <title>QuestionProtector|Previous Question</title>
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
            <div id="uploadalert" style="display:none;"></div>

            <span id="flip"><button class="button" style="vertical-align:middle;width:30%;"><span>Upload Previous Board Question</span></button></span><br><br>
            <div id="panel">
                <form action="boardquesupaction.show" method="post" enctype="multipart/form-data" onsubmit="return uploadquesfile();">
                    <div class="row">
                        <div class="col-md-1">
                            <label for="date">Date</label>
                        </div>
                        <div class="col-md-2">
                            <input type="date" class="form-control" id="date" name="date">
                        </div>

                        <div class="col-md-1"><label for="subcode">Subject Code</label></div>
                        <div class="col-md-2">
                            <select id="subcode" name="subcode" class="form-control">
                                <option value="Ban_101">Ban_101</option>
                                <option value="Ban_102">Ban_102</option>
                                <option value="Eng_107">Eng_107</option>
                                <option value="Eng_108">Eng_108</option>
                                <option value="Islam_111">Islam_111</option>
                                <option value="Math_109">Math_109</option>
                                <option value="Phy_136">Phy_136</option>
                                <option value="Chem_137">Chem_137</option>
                                <option value="Bio_138">Bio_138</option>
                            </select>
                        </div>

                        <div class="col-md-1"><label for="board">Board</label></div>
                        <div class="col-md-2">
                            <select id="board" name="board" class="form-control">
                                <option value="Dhaka">Dhaka</option>
                                <option value="Comilla">Comilla</option>
                                <option value="Chittagong">Chittagong</option>
                                <option value="Rajshahi">Rajshahi</option>
                                <option value="Jessore">Jessore</option>
                                <option value="Sylhet">Sylhet</option>
                                <option value="Dinajpur">Dinajpur</option>
                                <option value="Barishal">Barishal</option>
                                <option value="Madrasah">Madrasah</option>
                            </select>
                        </div>
                        <div class="col-md-1"><label for="filename">File Name</label></div>
                        <div class="col-md-2">
                            <input type="file" id="filename" name="filename" multiple onchange="selectedquesfiles();">
                        </div>
                    </div><br>

                    <div style="max-height: 300px;overflow-y: auto;">
                        <table id="questable" class="table table-striped" style="background-color: #d9d9d9;">

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
                            <th class="text-center">Subject Code</th>
                            <th class="text-right">Board</th>
                            <th class="text-left">File Name</th>
                            <th class="text-right">File Size</th>
                            <th class="text-right">Option</th>
                        </tr>
                    </thead>
                    <tbody id="fileTable">
                        <%
                            Database db = new Database();
                            ResultSet rs = null;

                            String qr = "select * from boardques";
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
                        <td class="text-center"><% out.println(rs.getString("subjectcode"));%></td>
                        <td class="text-center"><% out.println(rs.getString("board"));%></td>
                        <td class="text-left"><a href="FileShow.show?id=<%=rs.getString("id")%>&tab=3" target="_blank"><% out.println(rs.getString("filename"));%></a></td>
                        <td class="text-right"> <% out.println(Math.round(Integer.parseInt(rs.getString("filesize")) / 1000));%> KB</td>
                        <td class="text-right"><button class="btn btn-link" id ="filebtn" name="filebtn" onclick="deletefile(<%=rs.getString("id")%>);">Delete <span class="glyphicon glyphicon-trash"></span></button>
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
                    $("#filetable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>

        <script src="<c:url value="/resources/javascript/boardques.js"/>"></script>
    </body>
</html>
