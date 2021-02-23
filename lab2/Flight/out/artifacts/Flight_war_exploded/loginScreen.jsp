<%--
  Created by IntelliJ IDEA.
  User: Imola
  Date: 10/29/2018
  Time: 10:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Airline Company</title>
    <LINK rel="stylesheet" href="airline.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
</head>
<body>
    <h1><i class="fas fa-plane-departure"></i>Airline</h1>
    <h2>Please enter your credentials</h2>
    <form action="LoginServlet" method="post" id = "loginForm" name = "loginForm">
        <label for="username"> Username: </label>
        <input type="text" name="username" id = "username"><br/>
        <label for="password"> Password: </label>
        <input type="password" name="password" id="password"><br/>
        <button type="submit" id="loginButton">Log in</button>
    </form>
</body>
</html>
