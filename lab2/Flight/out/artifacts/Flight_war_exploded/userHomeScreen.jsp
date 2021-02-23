<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
         pageEncoding="US-ASCII" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
    <title>Airline</title>
    <LINK rel="stylesheet" href="airline.css" type="text/css">
</head>
<body>
<%
    //allow access only if session exists
    String user = null;
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.html");
    }else user = (String) session.getAttribute("user");
    String userName = null;
    String sessionID = null;
    Cookie[] cookies = request.getCookies();
    if(cookies !=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")) userName = cookie.getValue();
            if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
        }
    }
%>
<h3>Hi <%=userName %>, Login successful. Your Session ID=<%=sessionID %></h3><br>
<p>List of flights</p>

<div class = "table" id = "flightsTable">
    <div class="tr">
        <span class="th">ID</span>
        <span class="th">Airplane type</span>
        <span class="th">Departure city</span>
        <span class="th">Departure date</span>
        <span class="th">Arrival city</span>
        <span class="th">Arrival date</span>
    </div>
    <c:forEach items = "${flights}" var = "f">
        <div class="tr">
            <span class="td">${f.key.id}</span>
            <span class="td">${f.key.airplaneType}</span>
            <form class="td" action="/LocalTimeServlet" method="post">
                <input type="hidden" name = "city" value = "${f.value[0].name}"/>
                <button type="submit"> ${f.value[0].name}</button>
            </form>
            <span class="td">${f.key.departureDate}</span>
            <form class="td" action="/LocalTimeServlet" method="post">
                <!--span class="td"-->
                <input type="hidden" name = "city" value = "${f.value[1].name}"/>
                <button type="submit"> ${f.value[1].name}</button>
                <!--/span-->
            </form>
            <span class="td">${f.key.arrivalDate}</span>
        </div>
    </c:forEach>
</div>
<form action="LogoutServlet" method="post">
    <button type="submit">Logout</button>
</form>
</body>
</html>
