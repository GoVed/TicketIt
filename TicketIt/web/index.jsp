<%-- 
    Document   : index
    Created on : 21 Jan, 2020, 11:12:48 PM
    Author     : vedhs
--%>

<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            div.hoverable{
                transition-duration: 0.5s;
            }
            div.hoverable:hover{
                background-color: rgba(230,230,230,1);
                font-size: 105%;
                border: 1px dashed black;
            }
        </style>
    </head>
    <body>
        <h1 align="center">Login/Register</h1>
        <%
            Statement stm=null;
            Connection con=null;
            HttpServletRequest httpServletRequest = null;
            String userIpAddress =null;
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/TicketIt","root","root");
            stm=con.createStatement();
            int sc=0;
            
            httpServletRequest=(HttpServletRequest) request;

            // Proxy
            
            userIpAddress=httpServletRequest.getHeader("X-Forwarded-For");            
            if(userIpAddress == null) {
               userIpAddress = request.getRemoteAddr();
               System.out.println("IP Connected:"+userIpAddress);
               LocalDateTime now = LocalDateTime.now(); 
               sc=stm.executeUpdate("insert into ipLog values(\""+now+"\",\""+userIpAddress+"\")");             
            }
        %>
        <div class="table halfWidth">
            <div class="row">
                <div class="cell">Username </div>
                <div class="cell"><input type="text"></div>                
            </div>
            <div class="row">
                <div class="cell">Password</div>
                <div class="cell"><input type="password"></div>
            </div>            
        </div>
        <div class="table halfWidth">
            <div class="row">
                <div class="cell"><button>Login</button></div>
            </div>            
        </div>
    </body>
</html>
