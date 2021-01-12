<%-- 
    Document   : home
    Created on : Jun 9, 2018, 2:16:33 PM
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
        <title>questionProtector|Admin</title>
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
            <div id="homealert" style="display:none;">

            </div>
            <h1>Welcome to admin page</h1>

            <span id="flip"><button class="button" style="vertical-align:middle"><span>Add User</span></button></span><br><br>
            <div id="panel">
                <form action="adduser.show" method="post" onsubmit="return addfunction();">
                    <div class="row"> 
                        <div class="col-md-1">
                            <label for="uname">Username:</label>
                        </div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="uname" name="uname">
                        </div>

                        <div class="col-md-1"><label for="pwd">Password:</label></div>
                        <div class="col-md-2">
                            <input type="password" class="form-control" id="pwd" name="pwd">
                        </div>
                        <div class="col-md-1"><label for="brd">Board:</label></div>
                        <div class="col-md-2">
                            <select id="brd" class="form-control" name="brd">
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

                        <div class="col-md-1"><label for="city">City:</label></div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="city" placeholder="City Name" name="city">
                        </div>

                    </div><br>

                    <div class="row">
                        <div class="col-md-1"><label for="mbl">Mobile:</label></div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="mbl" placeholder="Mobile/Phone" name="mbl">
                        </div>

                        <div class="col-md-1"><label for="email">Email:</label></div>
                        <div class="col-md-2">
                            <input type="email" class="form-control" id="email" placeholder="Email" name="email">
                        </div>

                        <div class="col-md-1"><label for="type">Category:</label></div>
                        <div class="col-md-2">
                            <select id="type" name="type" class="form-control">
                                <option value="admin">Admin</option>
                                <option value="user">user</option>
                            </select>
                        </div>

                        <div class="col-md-1"><label for="centercode">Center Code:</label></div>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="centercode" name="centercode">
                        </div>

                    </div><br>

                    <div class="row">
                        <div class="col-md-11"></div>
                        <div class="col-md-1">
                            <button type="submit" class="btn btn-success">Add <span class="glyphicon glyphicon-plus-sign"></span></button>  
                        </div>
                    </div>
                </form>
            </div>

            <br>



            <div style="float:right;">
                <div class="input-group">
                    <input type="text" id="myInput" class="form-control" placeholder="Search..." name="search" style="width:180px;">
                </div>
            </div>
            <br><br>
            <div>
                <table id="hometable" class="table table-hover table-striped">
                    <thead>
                        <tr style="background-color:#f4511e;">
                            <th class="text-center">ID</th>
                            <th class="text-center">User Name</th>
                            <th class="text-center">Board</th>
                            <th class="text-center">City</th>
                            <th class="text-center">Phone</th>
                            <th class="text-center">Email Address</th>
                            <th class="text-center">Category</th>
                            <th class="text-center">Center Code</th>
                            <th class="text-center">Option</th>
                        </tr>
                    </thead>
                    <tbody id="myTable">
                        <%
                            Database db = new Database();
                            ResultSet rs = null;
                            if (db.createconnection()) {
                                rs = db.search("select *from logininfo");
                            } else {
                                System.out.println("Database connection error!!");
                            }

                            while (rs.next()) {
                        %>
                        <tr>
                            <td><% out.println(rs.getString("id"));%></td>
                            <td><% out.println(rs.getString("username"));%></td>
                            <td><% out.println(rs.getString("board"));%></td>
                            <td><% out.println(rs.getString("city"));%></td>
                            <td><% out.println(rs.getString("phoneno"));%></td>
                            <td><% out.println(rs.getString("email"));%></td>
                            <td><% out.println(rs.getString("category"));%></td>
                            <td><% out.println(rs.getString("centercode"));%></td>
                            <td>
                                <button type="button" class="btn btn-link" data-toggle="modal" data-target="#myModal" onclick="homeuserupdate('<%=rs.getInt("id")%>', '<%=rs.getString("username")%>', '<%=rs.getString("password")%>', '<%=rs.getString("board")%>', '<%=rs.getString("city")%>', '<%=rs.getString("phoneno")%>', '<%=rs.getString("email")%>', '<%=rs.getString("category")%>', '<%=rs.getString("centercode")%>');"><span class="glyphicon glyphicon-edit"></span>Update</button><button type="button" class="btn btn-link" onclick="homeuserdelete(<%=rs.getString("id")%>);"><span class="glyphicon glyphicon-trash"></span>Delete</button></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>


            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Update User <span id="modalhead"></span></h4>
                        </div>
                        <div class="modal-body">
                            <div id="homealert1"></div>
                            <form action="updateuser.show" method="post" onsubmit="return updatefunction();">
                                <input type="hidden" id="tableid" name="tableid">
                                <div class="row">
                                    <div class="col-md-1">
                                        <label for="uname1">Username:</label>
                                    </div>
                                    <div class="col-md-2">
                                        <input type="text" class="form-control" id="uname1" name="uname1">
                                    </div>

                                    <div class="col-md-1"><label for="pwd1">Password:</label></div>
                                    <div class="col-md-2">
                                        <input type="password" class="form-control" id="pwd1" name="pwd1">
                                    </div>
                                    <div class="col-md-1"><label for="brd1">Board:</label></div>
                                    <div class="col-md-2">
                                        <select id="brd1" class="form-control" name="brd1">
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

                                    <div class="col-md-1"><label for="city1">City:</label></div>
                                    <div class="col-md-2">
                                        <input type="text" class="form-control" id="city1" name="city1">
                                    </div>

                                </div><br>

                                <div class="row">
                                    <div class="col-md-1"><label for="mbl1">Mobile:</label1></div>
                                    <div class="col-md-2">
                                        <input type="text" class="form-control" id="mbl1" name="mbl1">
                                    </div>

                                    <div class="col-md-1"><label for="email1">Email:</label></div>
                                    <div class="col-md-2">
                                        <input type="email" class="form-control" id="email1" name="email1">
                                    </div>

                                    <div class="col-md-1"><label for="type1">Category:</label></div>
                                    <div class="col-md-2">
                                        <select id="type1" class="form-control" name="type1">
                                            <option value="admin">Admin</option>
                                            <option value="user">user</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1"><label for="centercode1">Center Code:</label></div>
                                    <div class="col-md-2">
                                        <input type="text" class="form-control" id="centercode1" name="centercode1">
                                    </div>

                                </div><br>

                                <div>
                                    <div class="col-md-10"></div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-success">Update <span class="glyphicon glyphicon-edit"></span></button>  
                                    </div>
                                </div><br>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $("#myInput").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#myTable tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
        <script src="<c:url value="/resources/javascript/home.js"/>"></script>
    </body>
</html>
