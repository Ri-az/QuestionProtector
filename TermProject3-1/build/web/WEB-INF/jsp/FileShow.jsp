<%-- 
    Document   : FileShow
    Created on : Jun 13, 2018, 1:55:06 PM
    Author     : Jakir Hossain Riaz
--%>

<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="dataaccessobject.Database"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri = "http://www.springframework.org/tags/form" prefix = "form"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>QuestionProtector|FileShow</title>

        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="<c:url value="/resources/lib/css/bootstrap.min.css"/>">
        <script src="<c:url value="/resources/lib/js/jquery.js"/>"></script>
        <script src="<c:url value="/resources/lib/js/bootstrap.min.js"/>"></script>

    </head>
    <body>

        <%
            int fileid = 0;
            if (request.getAttribute("index") != null) {
                fileid = Integer.parseInt(request.getAttribute("index").toString());
            }
            String filetb = "";
            if (request.getAttribute("table") != null) {
                filetb = request.getAttribute("table").toString();
            }

            Database db = new Database();
            if (db.createconnection()) {
                String qr = "";
                if (filetb.equals("1")) {
                    qr = "select filename,file,filecontenttype,filesize from fileinfo where id=" + fileid;
                } else if (filetb.equals("2")) {
                    qr = "select noticename,noticefile,noticetype,noticesize from noticeinfo where id=" + fileid;
                } else if (filetb.equals("3")) {
                    qr = "select filename,file,filecontenttype,filesize from boardques where id=" + fileid;
                }

                ResultSet rs = null;
                rs = db.search(qr);
                if (rs.next()) {
                    InputStream input=null;
                    if (filetb.equals("1")) {
                        input = rs.getBinaryStream("file");
                    } else if (filetb.equals("2")) {
                        input = rs.getBinaryStream("noticefile");
                    } else if (filetb.equals("3")) {
                        input = rs.getBinaryStream("file");
                    } 

                    BufferedInputStream br = new BufferedInputStream(input);
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    int c;
                    while ((c = br.read()) != -1) {
                        baos.write(c);
                        baos.flush();
                    }
                    baos.flush();
                    byte[] content = baos.toByteArray();

                    response.reset();
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Type", "application/pdf");
                    response.setHeader("Content-Disposition", "inline;filename= QuestionProtector.pdf");

                    ServletOutputStream outs = response.getOutputStream();
                    outs.write(content);
                    outs.flush();
                    out.write(outs.toString());
                    outs.close();
                    baos.close();
                    br.close();
                    input.close();

                } else {
                    System.out.println("Database connection erronr in file show page");
                }
            }
        %>


    </body>
</html>
