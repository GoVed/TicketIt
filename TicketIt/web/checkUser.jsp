<%-- 
    Document   : checkUser
    Created on : 27 Jan, 2020, 9:07:42 PM
    Author     : vedhs
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checking Info</title>
    </head>
    <body>
        <h1>Loading...</h1>
        <%
            Statement stm=null;
            Connection con=null;
            HttpServletRequest httpServletRequest = null;
            String userIpAddress =null;
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/TicketIt","root","root");
            stm=con.createStatement();
            int sc=0;       
            
            if(request.getParameter("email")!=null)
            {
                try{
                sc=stm.executeUpdate("insert into userdata values('"+request.getParameter("name") +"','"+request.getParameter("pass") +"','"+request.getParameter("email") +"')");
                out.println("Success, redirecting");
                RequestDispatcher toHome=request.getRequestDispatcher("index.jsp");
                request.removeAttribute("pass");
                request.removeAttribute("email");
                request.setAttribute("name",request.getParameter("name") );
                toHome.forward(request, response);
                }
                catch(Exception e)
                {                        
                    RequestDispatcher toHome=request.getRequestDispatcher("login.jsp");     
                    request.removeAttribute("pass");
                    request.removeAttribute("email");
                    request.removeAttribute("name");
                    toHome.forward(request,response);
                }
                finally{
                    out.println("OOPS! A huge error occured.");
                    out.println("<a href='login.jsp'>Go back?</a>");
                }
            }
            else
            {
                try{
                    ResultSet getpass = stm.executeQuery("select password from userdata where username='"+request.getParameter("name")+"'");
                    getpass.next();                   
                    if(request.getParameter("pass").equals(getpass.getString("password"))){
                        RequestDispatcher toHome=request.getRequestDispatcher("index.jsp");
                        request.removeAttribute("pass");
                        request.removeAttribute("email");
                        request.setAttribute("name",request.getParameter("name") );
                        toHome.forward(request, response);
                    }
                    else{
                        RequestDispatcher toHome=request.getRequestDispatcher("login.jsp");     
                        request.removeAttribute("pass");
                        request.removeAttribute("email");
                        request.removeAttribute("name");
                        toHome.forward(request,response);
                    }
                }
                catch(Exception e){
                    RequestDispatcher toHome=request.getRequestDispatcher("login.jsp");     
                    request.removeAttribute("pass");
                    request.removeAttribute("email");
                    request.removeAttribute("name");
                    toHome.forward(request,response);
                }
                finally{
                    out.println("OOPS! A huge error occured.");
                    out.println("<a href='login.jsp'>Go back?</a>");
                }
            }
        %>
        
    </body>
</html>
