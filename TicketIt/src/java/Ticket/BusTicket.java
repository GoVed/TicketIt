/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ticket;

import java.io.*;

/**
 *
 * @author vedhs
 */
public class BusTicket implements TicketInterface {

    public String ID = "";
    public int type = 0;
    public double price = 0;
    public String customerName = "";
    public String start = "";
    public String end = "";

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getID() {
        return ID;
    }

    public void setID(String ID) {
        this.ID = ID;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    @Override
    public String saveTicket() {
        String path="D:/Software/Project Junk/java/TicketIt/savedTicket/"+ID + customerName + ".txt";
        try {
            FileWriter sf;           
            sf = new FileWriter(path);
            sf.write("Bus Ticket\nID:"+ID+"\nName:"+customerName+"\nFrom:"+start+"\nTo:"+end+"\nPrice paid:"+price);
            sf.close();
            System.out.println("Saved as "+ID + customerName + ".txt");
        }
        catch(Exception e)
        {
            System.out.println("error occured");
        }
        return path;
    }
}
