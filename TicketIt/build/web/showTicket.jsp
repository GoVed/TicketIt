<%-- 
    Document   : showTicket
    Created on : 2 May, 2020, 7:33:57 PM
    Author     : vedhs
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Ticket.BusTicket"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Statement stm = null;
    Connection con = null;
    HttpServletRequest httpServletRequest = null;
    String userIpAddress = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TicketIt", "root", "root");
    stm = con.createStatement();
    String name = "";
    String id = "";
    String type = "";
    int tid = 0;
    int sc = 0;
    if (request.getParameter("name") != null) {
        name = request.getParameter("name");
    }
    if (request.getParameter("bid") != null) {
        id = request.getParameter("bid");
    }
    if (request.getParameter("type") != null) {
        type = request.getParameter("type");
    }
    ResultSet at = stm.executeQuery("select id from boughtticket");
    while (at.next()) {
        tid = at.getInt("id");
    }
    tid++;

    if (Integer.parseInt(type) == 0) {
        if (request.getParameter("buy") != null) {
            if (Integer.parseInt(request.getParameter("buy")) == 1) {
                int ticketcount = 0;
                ResultSet tc = stm.executeQuery("select available from ticketbus where id='" + id + "'");
                while (tc.next()) {
                    ticketcount = tc.getInt("available");
                }
                if (ticketcount > 0) {
                    sc = stm.executeUpdate("insert into boughtticket values('" + id + "','" + name + "','" + type + "','" + tid + "')");
                    sc = 1;

                    sc = stm.executeUpdate("update ticketbus set available='" + (ticketcount - 1) + "' where id='" + id + "'");
                } else {
                    out.println("No tickets left");
                }
            }
        }
    }

    if (Integer.parseInt(type) == 1) {
        if (request.getParameter("buy") != null) {
            if (Integer.parseInt(request.getParameter("buy")) == 1) {
                int ticketcount = 0;
                ResultSet tc = stm.executeQuery("select available from ticketmovie where id='" + id + "'");
                while (tc.next()) {
                    ticketcount = tc.getInt("available");
                }
                if (ticketcount > 0) {
                    sc = stm.executeUpdate("insert into boughtticket values('" + id + "','" + name + "','" + type + "','" + tid + "')");
                    sc = 1;

                    sc = stm.executeUpdate("update ticketmovie set available='" + (ticketcount - 1) + "' where id='" + id + "'");
                } else {
                    out.println("No tickets left");
                }
            }
        }
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Ticket</title>
        <script>
            function ol()
            {
                out = "showTicket.jsp?bid=" + "<%=id%>" + "&type=" + "<%=type%>" + "&name=" + "<%=name%>";
                print = "";
                if (<%=sc%>)
                    window.location.href = out;
                else {
                    if (<%=type%> === 0)
                        print = "<b>Bus Ticket</b><hr>";
                    if (<%=type%> === 1)
                        print = "<b>Movie Ticket</b><hr>";
            <%
                String from = "";
                String to = "";
                String mname = "";
                String tname = "";
                Double price=0.0;
                if (Integer.parseInt(type) == 0) {
                    ResultSet ti = stm.executeQuery("select * from ticketbus where id=" + id);

                    price = 0.0;
                    while (ti.next()) {
                        from = ti.getString("start");
                        to = ti.getString("end");
                        price = ti.getDouble("price");
                    }
                }

                if (Integer.parseInt(type) == 1) {
                    ResultSet ti = stm.executeQuery("select * from ticketmovie where id=" + id);

                    price = 0.0;
                    while (ti.next()) {
                        mname = ti.getString("moviename");
                        tname = ti.getString("theatername");
                        price = ti.getDouble("price");
                    }
                }

            %>
                    if (<%=type%> === 0) {
                        print = print + "<div class='table'>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>From</div>";
                        print = print + "<div class='cell'><%=from%></div>";
                        print = print + "</div>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>To</div>";
                        print = print + "<div class='cell'><%=to%></div>";
                        print = print + "</div>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>Price</div>";
                        print = print + "<div class='cell'><%=price%></div>";
                        print = print + "</div>";
                        print = print + "</div>";
                        print = print + "<button onclick='sdbus()'>Download</button>";
                    }

                    if (<%=type%> === 1) {
                        print = print + "<div class='table'>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>Movie:</div>";
                        print = print + "<div class='cell'><%=mname%></div>";
                        print = print + "</div>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>Theater:</div>";
                        print = print + "<div class='cell'><%=tname%></div>";
                        print = print + "</div>";
                        print = print + "<div class='row'>";
                        print = print + "<div class='cell'>Price</div>";
                        print = print + "<div class='cell'><%=price%></div>";
                        print = print + "</div>";
                        print = print + "</div>";
                        print = print + "<button onclick='sdmovie()'>Download</button>";
                    }
                    document.getElementById("ticket").innerHTML = print;
                }
            }
            function sdbus() {
                window.location.href = "download.jsp?bid=<%=id%>&type=<%=type%>&name=<%=name%>&from=<%=from%>&to=<%=to%>&price=<%=price%>";
            }
            function sdmovie() {
                window.location.href = "download.jsp?bid=<%=id%>&type=<%=type%>&name=<%=name%>&mname=<%=mname%>&tname=<%=tname%>&price=<%=price%>";
            }
        </script>
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
        </style>
    </head>
    <body onload='ol()'>
        <h1>Your Ticket</h1>
        <p id='ticket'>

        </p>
    </body>
</html>
