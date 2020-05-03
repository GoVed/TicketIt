<%-- 
    Document   : index
    Created on : 21 Jan, 2020, 11:12:48 PM
    Author     : vedhs
--%>

<%@page import="java.sql.*"%>
<%@page import="java.time.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <script>
            var checkEmail=1;
            function openEmail(){                
                var divobj=document.getElementById("registerForm"); 
                var inpEmail=document.getElementById("userEmail");
                var inpName=document.getElementById("userName");
                var inpPass=document.getElementById("userPass");
                var out="checkUser.jsp?"
                if(checkEmail)
                {
                    divobj.style.visibility = "visible" ; 
                    checkEmail=0;                  
                }
                else
                {
                    if(inpEmail.value !== "")
                    {
                        if(inpName.value !== "" && inpPass.value !== "")
                        {
                            out=out+"name="+inpName.value+"&pass="+inpPass.value+"&email="+inpEmail.value;
                            window.location.href = out; 
                        }
                        else
                            alert("Please enter username and password");
                    }
                    else
                        alert("Please enter the email");
                }
            }
            function ol(){
                var divobj=document.getElementById("registerForm");
                divobj.style.visibility = "hidden" ;
            }
            function login(){
                var inpName=document.getElementById("userName");
                var inpPass=document.getElementById("userPass");
                var out="checkUser.jsp?"
                if(inpName.value !== "" && inpPass.value !== "")
                {
                    out=out+"name="+inpName.value+"&pass="+inpPass.value;
                    window.location.href = out; 
                }
                else
                    alert("Please enter username and password");
            }
        </script>
    </head>
    <body onload="ol()">
        <h1 align="center">Login/Register</h1>
        
        <div class="table halfWidth">
            <div class="row">
                <div class="cell">Username </div>
                <div class="cell"><input type="text" id="userName"></div>                
            </div>
            <div class="row">
                <div class="cell">Password</div>
                <div class="cell"><input type="password" id="userPass"></div>
            </div>    
            <div class="row" id="registerForm">
                <div class='cell'>Email</div>
                <div class='cell'><input type='text' id="userEmail"></div>
            </div>
        </div>
        <div class="table halfWidth">
            <div class="row">
                <div class="cell"><button onclick="login()">Login</button></div>
            </div>
            <div class="row">
                <div class="cell"><button onclick="openEmail()">Register</button></div>
            </div>            
        </div>
    </body>
</html>

