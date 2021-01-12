<%-- 
    Document   : genusernav
    Created on : Jun 19, 2018, 12:48:20 AM
    Author     : Jakir Hossain Riaz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">QuestionProtector</a>
        </div>
        <ul class="nav navbar-nav">
            <li id="genhome"><a href="genhome.show">Home</a></li>
            <li class="dropdown" id="question"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Question<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="boardquesgen.show?s=1">Math</a></li>
                    <li><a href="boardquesgen.show?s=21">Bangla 1st paper</a></li>
                    <li><a href="boardquesgen.show?s=22">Bangla 2nd paper</a></li>
                    <li><a href="boardquesgen.show?s=31">English 1st paper</a></li>
                    <li><a href="boardquesgen.show?s=32">English 2nd paper</a></li>
                    <li><a href="boardquesgen.show?s=4">Physics</a></li>
                    <li><a href="boardquesgen.show?s=5">Chemistry</a></li>
                    <li><a href="boardquesgen.show?s=6">Biology</a></li>
                    <li><a href="boardquesgen.show?s=7">Religion</a></li>
                </ul>
            </li>
            <li id="result"><a href="result.show">Result</a></li>
            <li id="notice"><a href="notice.show">Notice</a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="welcome.show"> Login <span class="glyphicon glyphicon-log-in"></span></a></li>
        </ul>
    </div>
</nav>