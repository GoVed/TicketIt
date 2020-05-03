/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ticket;

import java.io.FileWriter;

/**
 *
 * @author vedhs
 */
public class MovieTicket implements TicketInterface {
    
    public String ID="";
    public int type=0;
    public double price = 0;
    public String customerName="";
    public String mname="";
    public String tname="";
    @Override
    public String saveTicket() {
        String path="D:/Software/Project Junk/java/TicketIt/savedTicket/"+ID + customerName + ".txt";
        try {
            FileWriter sf;           
            sf = new FileWriter(path);
            sf.write("Movie Ticket\nID:"+ID+"\nName:"+customerName+"\nMovie:"+mname+"\nTheater:"+tname+"\nPrice paid:"+price);
            sf.close();
            System.out.println("Saved as "+ID + customerName + ".txt");
        }
        catch(Exception e)
        {
            System.out.println("error occured"+e);
        }
        return path;
    }
    
}
