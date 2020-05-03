<%-- 
    Document   : index
    Created on : 21 Jan, 2020, 11:12:48 PM
    Author     : vedhs
--%>

<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Statement stm = null;
    Connection con = null;
    HttpServletRequest httpServletRequest = null;
    String userIpAddress = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TicketIt", "root", "root");
    stm = con.createStatement();
    int sc = 0;
    int x = 0;
    String name = "";
    httpServletRequest = (HttpServletRequest) request;

    // Proxy
    userIpAddress = httpServletRequest.getHeader("X-Forwarded-For");
    if (userIpAddress == null) {
        userIpAddress = request.getRemoteAddr();
        System.out.println("IP Connected:" + userIpAddress);
        LocalDateTime now = LocalDateTime.now();
        sc = stm.executeUpdate("insert into ipLog values(\"" + now + "\",\"" + userIpAddress + "\")");
    }
    if (request.getParameter("name") != null) {
        name = request.getParameter("name");
    }
    if (request.getParameter("pass") != null) {
        x = 1;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>TicketIt: Get Ticket easily</title>
        <style>
            div.table{
                display : table;                                                
                text-align: center;
                background-color: rgba(245,245,245,0.15);
            }
            div.halfWidth{
                width : 50%;
                margin: auto;
            }
            div.fullWidth{
                width : 100%;
                margin: 0px;
            }
            div.row{
                display:table-row;
                margin: 5px;
                text-align: center;                
            }           
            div.cell{
                display:table-cell;                
                padding: 3px;
                width:auto;            
            }
            div.border{
                border: 0.5px solid gray;                
            }     

        </style>
        <script>
            function ol() {
                var out = "index.jsp?name=";
                out = out + "<%=name%>";
                var tname = "";
                tname = "<%=name%>";
                if (tname.length > 0){
                    document.getElementById("loginCell").innerHTML = tname;                    
                }
                if (<%=x%>)
                    window.location.href = out;

            }
            function buyBus() {
                var out = "buyTicket.jsp";
                var tname = "";
                tname = "<%=name%>";
                if (tname.length > 0)
                    window.location.href = out + "?name=" + tname + "&type=bus";
                else
                    window.location.href = "login.jsp";
            }
            function buyMovie() {
                var out = "buyTicket.jsp";
                var tname = "";
                tname = "<%=name%>";
                if (tname.length > 0)
                    window.location.href = out + "?name=" + tname + "&type=movie";
                else
                    window.location.href = "login.jsp";
            }
            function login() {

                var tname = "";
                tname = "<%=name%>";
                if (tname.length > 0)
                    window.location.href = "profile.jsp?name=" + tname;
                else
                    window.location.href = "login.jsp";

            }
        </script>
    </head>
    <body onload="ol()">
        <div class="table fullWidth">
            <div class="row">
                <div class="cell" style="text-align:left">
                    <h1>TicketIt</h1>
                </div>

                <div class="cell" style='text-align:right'>
                    <button onclick='login()' id="loginCell">Login</button>                    
                </div>                
            </div>
        </div>
        <hr>

        <div class="table halfWidth border">

            <div class="row">
                <div class="cell">Bus Ticket</div>
                <div class="cell"><button onclick="buyBus()">Buy</button></div>
            </div>
            <div class="row">
                <div class="cell">Movie Ticket</div>
                <div class="cell"><button onclick="buyMovie()">Buy</button></div>
            </div>
        </div>

    </body>
</html>
