<%-- 
    Document   : download
    Created on : 3 May, 2020, 12:45:43 AM
    Author     : vedhs
--%>

<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="Ticket.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String path = "";
    String id="";
    if (Integer.parseInt(request.getParameter("type")) == 0) {
        BusTicket tck = new BusTicket();
        tck.setCustomerName(request.getParameter("name"));
        tck.setStart(request.getParameter("from"));
        tck.setEnd(request.getParameter("to"));
        tck.setID(request.getParameter("bid"));
        tck.setPrice(Double.parseDouble(request.getParameter("price")));
        path = tck.saveTicket();
        id=tck.ID;
    }
    
    if (Integer.parseInt(request.getParameter("type")) == 1) {
        MovieTicket tck = new MovieTicket();
        tck.customerName=request.getParameter("name");
        tck.mname=request.getParameter("mname");
        tck.tname=request.getParameter("tname");
        tck.ID=request.getParameter("bid");
        tck.price=Double.parseDouble(request.getParameter("price"));
        path = tck.saveTicket();
        id=tck.ID;
    }
    response.setContentType("text");
    PrintWriter outdown = response.getWriter();

    response.setContentType("APPLICATION/OCTET-STREAM");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + id + request.getParameter("name") + ".txt\"");
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
        <h1>Downloading your ticket...</h1>
    </body>
</html>
