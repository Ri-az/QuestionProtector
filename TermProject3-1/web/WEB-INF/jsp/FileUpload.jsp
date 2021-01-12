<%-- 
    Document   : FileUpload
    Created on : Jun 11, 2018, 2:36:12 AM
    Author     : Jakir Hossain Riaz
--%>

<%@page import="java.util.Random"%>
<%@page import="dataaccessobject.Database"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QuesProtector|FileUpload</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/purl.js"/>"></script>

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

            <span id="flip"><button class="button" style="vertical-align:middle"><span>Add File</span></button></span><br><br>
            <div id="panel">
                <form action="fileuploadaction.show" method="post" enctype="multipart/form-data" onsubmit="return uploadfile();">
                    <div class="row">
                        <div class="col-md-1">
                            <label for="time">Time</label>
                        </div>
                        <div class="col-md-2">
                            <input type="time" class="form-control" id="time" name="time" data-toggle="tooltip" data-placement="top" title="HH:MM AM">
                        </div>

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
                    </div><br><br>
                    <div class="row">
                        <div class="col-md-1"><label for="filename">File Name</label></div>
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
            <%
                int rd = 0;
                String start = "";
                String dt = "", sc = "", bd = "", al = "";
                if (request.getAttribute("date") != null) {
                    dt = request.getAttribute("date").toString();
                    rd = 1;
                }
                if (request.getAttribute("scode") != null) {
                    sc = request.getAttribute("scode").toString();
                    rd = 1;
                }
                if (request.getAttribute("board") != null) {
                    bd = request.getAttribute("board").toString();
                    rd = 1;
                }
                if (request.getAttribute("myrnd") != null) {
                    start = request.getAttribute("myrnd").toString();
                    System.out.println(start);
                }
                if (request.getAttribute("Alert") != null) {
                    al = request.getAttribute("Alert").toString();
                    System.out.println(al);
                }
            %>

            <form action="searchfile.show" method="post" class="container-fluid">

                <div class="row" style="background-color: #f4511e; padding-top: 10px;"> 
                    <div class="col-md-1"></div>
                    <div class="col-md-1"><label for="dat">Date</label></div>
                    <div class="col-md-2">
                        <input type="date" class="form-control" onchange="searchchange();" id="dat" name="dat" value="<%=dt%>">
                    </div>

                    <div class="col-md-1"><label for="scode">Subject Code</label></div>
                    <div class="col-md-2">
                        <select id="scode" name="scode" class="form-control" onchange="searchchange();" value="<%=sc%>">
                            <option value="ALL">ALL</option>
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

                    <div class="col-md-1"><label for="brd1">Board</label></div>
                    <div class="col-md-2">
                        <select id="brd1" name="brd1" onchange="searchchange();" class="form-control">
                            <option value="all">All </option>
                            <option value="Dhaka" >Dhaka</option>
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
                    <div class="col-md-1"></div>
                </div>
            </form>
            <br><br>

            <div style="max-height: 500px;overflow-y: auto;">
                <table id="filetable" class="table table-striped" >
                    <thead>
                        <tr style="background-color: #f4511e;">
                            <th class="text-left">Time</th>
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

                            String qr = "select * from fileinfo ";
                            int flag = 0;
                            if (!dt.equals("")) {
                                if (flag == 0) {
                                    flag = 1;
                                    qr += " where date='" + dt + "' ";
                                } else {
                                    qr += " and date='" + dt + "' ";
                                }
                            }
                            if (!sc.equals("")) {
                                if (flag == 0) {
                                    flag = 1;
                                    qr += " where subjectcode='" + sc + "' ";
                                } else {
                                    qr += " and subjectcode='" + sc + "' ";
                                }
                            }
                            if (!bd.equals("")) {
                                if (flag == 0) {
                                    flag = 1;
                                    qr += " where board='" + bd + "' ";
                                } else {
                                    qr += " and board='" + bd + "' ";
                                }
                            }

                            if (db.createconnection()) {
                                rs = db.search(qr);
                            } else {
                                System.out.println("Database connection error!!");
                            }

                            int randselectedfileid = 0;
                            String randselectedfilename = "";
                            String randselectedfileboard = "";
                            if (!start.isEmpty()) {
                                int selectedrow = Integer.parseInt(start) - 1;
                                ResultSet randrow = db.search(qr + " LIMIT " + selectedrow + ",1");
                                if (randrow.next()) {
                                    randselectedfilename = randrow.getString("filename");
                                    randselectedfileid = randrow.getInt("id");
                                    randselectedfileboard = randrow.getString("board");
                                }
                            }

                            int count = 0;

                            while (rs.next()) {
                                if (rs.getInt("id") == randselectedfileid) {
                        %>
                        <tr class="danger">

                            <%
                            } else {
                            %>
                        <tr>
                            <%
                                }
                            %>

                            <td class="text-left"><% out.println(rs.getString("time"));%></td>
                            <td class="text-left"><% out.println(rs.getString("date"));%></td>
                            <td class="text-center"><% out.println(rs.getString("subjectcode"));%></td>
                            <td class="text-center"><% out.println(rs.getString("board"));%></td>
                            <td class="text-left"><a href="FileShow.show?id=<%=rs.getString("id")%>&tab=1" target="_blank"><% out.println(rs.getString("filename"));%></a></td>
                            <td class="text-right"> <% out.println(Math.round(Integer.parseInt(rs.getString("filesize")) / 1000));%> KB</td>
                            <td class="text-right"><button class="btn btn-link" id ="filebtn" name="filebtn" onclick="deletefile(<%=rs.getString("id")%>);">Delete <span class="glyphicon glyphicon-trash"></span></button>
                        </tr>
                        <%
                                count++;

                            }

                        %>
                    </tbody>
                </table>
            </div><br><br>

            <div class="container-fluid" style="background-color: #f4511e; padding: 5px;">
                <div class="row">
                    <div class="col-md-1"></div>

                    <div class="col-md-2">
                        <button class="form-control" style="border: none;" id="randbtn" name="randbtn" onclick="window.location.assign('randnumb.show?cnt=<%=count%>&date=<%=dt%>&board=<%=bd%>&scode=<%=sc%>');">Choose Randomly <span class="glyphicon glyphicon-random"></span></button>
                    </div>

                    <div class="col-md-6"><input type="text" class="form-control" id="randfilename" name="randfilename" value="<%=randselectedfilename%>"></div>

                    <div class="col-md-2">
                        <button class="form-control" style="border: none;" id="sendbtn" name="sendbtn" onclick="window.location.assign('sendrandfile.show?fileid=<%=randselectedfileid%>&board=<%=randselectedfileboard%>')">Send File <span class="glyphicon glyphicon-send"></span></button>
                    </div>

                    <div class="col-md-1"></div>
                </div>
            </div><br><br>
        </div>
        <%
            if (al.equals("yes")) {
        %>

        <script>
            alert("file send Successfull.");
        </script>

        <%
        } else if (al.equals("no")) {
        %>
        <script>
            alert("file send error.");
        </script>
        <%
            }
        %>
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


        <script src="<c:url value="/resources/javascript/FileUpload.js"/>"></script>
    </body>
</html>
