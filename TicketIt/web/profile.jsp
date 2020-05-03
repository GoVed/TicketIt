<%-- 
    Document   : profile
    Created on : 3 May, 2020, 1:10:04 AM
    Author     : vedhs
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Statement stm = null;
    Statement stm2 = null;
    Connection con = null;
    HttpServletRequest httpServletRequest = null;
    String userIpAddress = null;
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/TicketIt", "root", "root");
    stm = con.createStatement();
    stm2 = con.createStatement();

    String name = request.getParameter("name");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=name%>'s Profile</title>
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
    </head>
    <body>
        <h1>Hello <%=name%></h1><hr>
        <br>
        <P>
            <%
                ResultSet rs = stm.executeQuery("select * from boughtticket where username='" + name + "'");

                out.println("<div class='table halfWidth border'>Your Tickets");
                
                while (rs.next()) {
                    out.println("<div class='row'>");
                    if (rs.getInt("type") == 0) {
                        
                        ResultSet ir = stm2.executeQuery("select * from ticketbus where id='" + rs.getInt("ticketid") + "'");                        
                        while (ir.next()) {
                            out.println("<div class='cell'>"+ir.getString("start") + " to " + ir.getString("end") + "  :   " + ir.getDouble("price") + "</div><div class='cell'><a href='showTicket.jsp?bid=" + ir.getInt("id") + "&type=0&name=" + name + "'><button>Show</button></a></div>");
                        }
                    }
                    out.println("</div>");
                }
                out.println("</div>");
            %>
        </P>
    </body>
</html>
