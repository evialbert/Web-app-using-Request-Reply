<%@ page import="model.City" %>
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
<h3>Hi <%=userName %>, your login was successful.</h3>
<br>
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
        <div class="tr-group">
            <form class="tr" action = /EditFlightServlet method="post">
                <span class="td"><input type = "hidden" name = "planeId" value = "${f.key.id}">${f.key.id}</span>
                <span class="td">
                    <select name="planeTypeTable" id = "planeTypeTable">
                        <option value = "${f.key.airplaneType}">${f.key.airplaneType}</option>
                        <option value="airplane">airplane</option>
                        <option value="airbus">airbus</option>
                        <option value="helicopter">helicopter</option>
                        <option value="balloon">balloon</option>
                    </select>
                </span>
                <span class="td">
                    <select name = "departureCityTable" id = "departureCityTable">
                        <c:forEach items = "${cityList}" var = "city">
                            <c:choose>
                                <c:when test="${city.name == f.value[0].name}">
                                    <option selected value = "${city.name}">${city.name}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value = "${city.name}">${city.name}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </span>
                <span class="td"><input type="datetime-local" id = "departureDateTable" name = "departureDateTable" value = "${f.key.departureDate}"></span>
                <span class="td">
                    <select name = "arrivalCityTable" id = "arrivalCityTable" selected = "${f.value[1].name}">
                        <c:forEach items = "${cityList}" var = "city">
                            <c:choose>
                                <c:when test="${city.name == f.value[1].name}">
                                    <option selected value = "${city.name}">${city.name}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value = "${city.name}">${city.name}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </span>
                <span class="td"><input type="datetime-local" name = "arrivalDateTable" id = "arrivalDateTable" value = "${f.key.arrivalDate}"></span>
                <span class="td"><button type="submit"> Edit </button></span>
            </form>

            <span class="removeButton">
                <form action="DeleteFlightServlet" method="post">
                    <input type = "hidden" name = "flightToDelete" value = "${f.key.id}">
                    <button type="submit"> Remove</button>
                </form>
            </span>
        </div>
    </c:forEach>
</div>
<div id = "newFlight">
    <p> Add new flight </p>
    <form action="AddFlightServlet" method="post">
        <label for = "planeType"> Airplane type: </label>
        <select name="planeType" id = "planeType">
            <option value="airplane">airplane</option>
            <option value="airbus">airbus</option>
            <option value="helicopter">helicopter</option>
            <option value="balloon">air ballon</option>
        </select>
        <label for = "departureCity">Departure city</label>
        <select name = "departureCity" id = "departureCity">
            <c:forEach items = "${cityList}" var = "city">
                <option value = "${city.name}">${city.name}</option>
            </c:forEach>
        </select>
        <label for = "departureDate">Departure date</label>
        <input type="datetime-local" name="departureDate" id = "departureDate">
        <label for = "arrivalCity"> Arrival city </label>
        <select name = "arrivalCity" id = "arrivalCity">
            <c:forEach items = "${cityList}" var = "city">
                <option value = "${city.name}">${city.name}</option>
            </c:forEach>
        </select>
        <label for = "arrivalDate">Arrival date</label>
        <input type="datetime-local" name="arrivalDate" id = "arrivalDate">
        <button type="submit" name="addNewFlight">Add</button>
    </form>
</div>
<div id="newCity">
    <form action="/AddCityServlet" method="post">
        <p>Add new city</p>
        <label for = "cityname"> Name</label>
        <input type="text" id = "cityname" name="cityname">
        <label>Latitude</label>
        <input type="text" name = "latitude">
        <label>Longitude</label>
        <input type="text" name = "longitude">
        <button type="submit" name ="addNewCity"> Add </button>
    </form>
</div>
<form action="LogoutServlet" method="post">
    <input type="submit" value="Logout" >
</form>
</body>
</html>