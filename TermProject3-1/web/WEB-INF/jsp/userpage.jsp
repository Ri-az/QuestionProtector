<%-- 
    Document   : userpage
    Created on : Jun 15, 2018, 8:46:43 PM
    Author     : Jakir Hossain Riaz
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*,java.util.Date"%>
<%@page import="dataaccessobject.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QuestionProtector|User</title>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>


        <script type="text/javascript">
            var myVar = setInterval(function () {
                myTimer()
            }, 1000);
            var counter = 0;
            function myTimer() {
                var date = new Date();
                document.getElementById("demo").innerHTML = date.toLocaleString();
            }
        </script>
    </head>
    <body>
        <jsp:include page="usernav.jsp" flush="true" />
        <div style="border: none; color: red; font-size: large;"><span id="demo" style="float: right;padding-right: 20px;"></span></div>
            <%
                String qid = "";
                String userName = "";
                String userid = "";
                String sd = "";
                String brd = "";

                if (request.getAttribute("fileid") != null) {
                    qid = request.getAttribute("fileid").toString();
                }
                if (request.getAttribute("Uname") != null) {
                    userName = request.getAttribute("Uname").toString();
                }
                if (request.getAttribute("uid") != null) {
                    userid = request.getAttribute("uid").toString();
                }

                if (request.getAttribute("showdialoge") != null) {
                    sd = request.getAttribute("showdialoge").toString();
                }

                if (request.getAttribute("board") != null) {
                    brd = request.getAttribute("board").toString();
                }
            %>

        <h1> Welcome to the <strong>Exam Question</strong> Page</h1><br>
        <div class="container">
            <div style="max-height: 500px;overflow-y: auto;">
                <table id="filetable" class="table table-striped" >
                    <thead>
                        <tr style="background-color: #f4511e;">
                            
                            <th class="text-left">Subject Code</th>
                            <th class="text-left">Board</th>
                            <th class="text-left">File Name</th>
                            <th class="text-right">File Size</th>
                            <th class="text-right">Question show Date</th>
                            <th class="text-right">Question Show Time</th>
                            <th class="text-right">Option</th>
                        </tr>
                    </thead>
                    <tbody id="fileTable">
                        <%
                            if (!brd.isEmpty()) {
                                Database db = new Database();
                                ResultSet rs = null;
                                if (db.createconnection()) {
                                    String find = "select * from usertype where board='" + brd + "'";
                                    rs = db.search(find);
                                    if (rs.next()) {
                                        qid = rs.getString("fileid").toString();
                                    }
                                    String qr = "select * from fileinfo where id='" + qid + "'";
                                    rs = db.search(qr);

                                    while (rs.next()) {
                                        String time = rs.getString("time");
                                        String min = time.substring(3, 5);
                                        String formate = "AM";
                                        int hour = Integer.parseInt(time.substring(0, 2));
                                        if (hour >= 12) {
                                            formate = "PM";
                                        }
                                        if (hour % 12 == 0) {
                                            hour = 12;
                                        } else {
                                            hour = hour % 12;
                                        }

                                        String converttime = hour + ":" + min + " " + formate;

                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                        Date dbtime = sdf.parse(rs.getString("date") + " " + rs.getString("time") + ":00");
                                        System.out.println("dbtime " + sdf.format(dbtime));

                                        Date curtime = new Date();
                                        System.out.println("Curtime " + sdf.format(curtime));


                        %>               
                        <tr>


                            
                            <td class="text-left"><% out.println(rs.getString("subjectcode"));%></td>
                            <td class="text-left"><% out.println(rs.getString("board"));%></td>
                            <td class="text-left"><% out.println(rs.getString("filename"));%></a></td>
                            <td class="text-right"> <% out.println(Math.round(Integer.parseInt(rs.getString("filesize")) / 1000));%> KB</td>
                            <td class="text-right"><% out.println(rs.getString("date"));%></td>
                            <td class="text-right"><%out.println(converttime);%></td>
                            <%
                                if (curtime.before(dbtime)) {
                            %>
                            <td class="text-right"><button class="btn btn-link" id="show" name="show" disabled onclick="window.location.assign('questionsecurity.show?fid=<%=qid%>&uid=<%=userid%>')">Show<span class="glyphicon glyphicon-open"></span></button></td>
                                    <%
                                    } else {
                                    %>
                            <td class="text-right"><button class="btn btn-link" id="show" name="show"  onclick="window.location.assign('questionsecurity.show?fid=<%=qid%>&uid=<%=userid%>')">Show<span class="glyphicon glyphicon-open"></span></button></td>
                                    <%
                                        }
                                    %>
                        </tr>
                        <%
                                    }
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div><br><br>

            <%
                if (sd.equals("yes")) {
            %>
            <script>
                var code = window.prompt("Check your mail & enter the security code:", "");
                if (code != null && code != "") {
                    window.location = "checkquessecurity.show?fid=<%=qid%>&uid=<%=userid%>&check=" + code;
                } else {
                    window.location.reload();
                }
            </script>

            <%
                }
            %>

        </div>
    </body>
</html>
