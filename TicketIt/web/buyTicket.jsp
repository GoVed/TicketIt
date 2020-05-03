<%-- 
    Document   : buyTicket
    Created on : 25 Apr, 2020, 12:23:01 AM
    Author     : vedhs
--%>

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
    if (request.getParameter("name") != null) {
        name = request.getParameter("name");
    }

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Buy Bus Ticket</title>
        <script>
            function buy(bid, type) {
                var tname = "";
                tname = "<%=name%>";
                window.location.href = "showTicket.jsp?bid=" + bid + "&type=" + type + "&buy=1&name=" + tname;
            }
            function showFull() {
                alert("No seats left!");
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
    <body>
        <h1>Welcome <%=name%> </h1>
        <hr>
        <p>Available Tickets</p><br>
        <div class='table halfWidth'>

            <%
                if (request.getParameter("type").equals("bus")) {
                    out.println("<div class='row'>"
                            + "<div class='cell'>From</div>"
                            + "<div class='cell'>To</div>"
                            + "<div class='cell'>Available seats</div>"
                            + "<div class='cell'>Price</div>"
                            + "<div class='cell'></div>"
                            + "</div>");
                    ResultSet at = stm.executeQuery("select * from ticketbus");
                    while (at.next()) {
                        if (Integer.parseInt(at.getString("available")) > 0) {
                            out.println("<div class='row'>"
                                    + "<div class='cell'>" + at.getString("start") + "</div>"
                                    + "<div class='cell'>" + at.getString("end") + "</div>"
                                    + "<div class='cell'>" + at.getString("available") + "</div>"
                                    + "<div class='cell'>" + at.getDouble("price") + "</div>"
                                    + "<div class='cell'><button onclick='buy(" + at.getInt("id") + ",0)'>Buy</button></div>"
                                    + "</div>");
                        } else {
                            out.println("<div class='row'>"
                                    + "<div class='cell'>" + at.getString("start") + "</div>"
                                    + "<div class='cell'>" + at.getString("end") + "</div>"
                                    + "<div class='cell'>" + at.getString("available") + "</div>"
                                    + "<div class='cell'>" + at.getDouble("price") + "</div>"
                                    + "<div class='cell'><button onclick='showFull()'>Buy</button></div>"
                                    + "</div>");
                        }
                    }
                }

                if (request.getParameter("type").equals("movie")) {
                    out.println("<div class='row'>"
                            + "<div class='cell'>Movie</div>"
                            + "<div class='cell'>Theater</div>"
                            + "<div class='cell'>Available seats</div>"
                            + "<div class='cell'>Price</div>"
                            + "<div class='cell'></div>"
                            + "</div>");
                    ResultSet at = stm.executeQuery("select * from ticketmovie");
                    while (at.next()) {
                        if (Integer.parseInt(at.getString("available")) > 0) {
                            out.println("<div class='row'>"
                                    + "<div class='cell'>" + at.getString("moviename") + "</div>"
                                    + "<div class='cell'>" + at.getString("theatername") + "</div>"
                                    + "<div class='cell'>" + at.getString("available") + "</div>"
                                    + "<div class='cell'>" + at.getDouble("price") + "</div>"
                                    + "<div class='cell'><button onclick='buy(" + at.getInt("id") + ",1)'>Buy</button></div>"
                                    + "</div>");
                        } else {
                            out.println("<div class='row'>"
                                    + "<div class='cell'>" + at.getString("moviename") + "</div>"
                                    + "<div class='cell'>" + at.getString("theatername") + "</div>"
                                    + "<div class='cell'>" + at.getString("available") + "</div>"
                                    + "<div class='cell'>" + at.getDouble("price") + "</div>"
                                    + "<div class='cell'><button onclick='showFull()'>Buy</button></div>"
                                    + "</div>");
                        }
                    }
                }
            %>
        </div>
    </body>
</html>
