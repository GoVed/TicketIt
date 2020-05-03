<%-- 
    Document   : download
    Created on : 3 May, 2020, 12:45:43 AM
    Author     : vedhs
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Ticket.BusTicket"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
                        String path = "";
                        BusTicket tck = new BusTicket();
                        tck.setCustomerName(request.getParameter("name"));
                        tck.setStart(request.getParameter("from"));
                        tck.setEnd(request.getParameter("to"));
                        tck.setID(request.getParameter("bid"));
                        tck.setPrice(Double.parseDouble(request.getParameter("price")));
                        path = tck.saveTicket();
                        response.setContentType("text");
                        PrintWriter outdown = response.getWriter();
                        
                        response.setContentType("APPLICATION/OCTET-STREAM");
                        response.setHeader("Content-Disposition", "attachment; filename=\"" + tck.getID()+tck.getCustomerName() + ".txt\"");
                        FileInputStream fileInputStream = new FileInputStream(path);

                        int i;
                        while ((i = fileInputStream.read()) != -1) {
                            outdown.write(i);
                        }
                        fileInputStream.close();
                        outdown.close();
                    
            %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Downloading Ticket!</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
