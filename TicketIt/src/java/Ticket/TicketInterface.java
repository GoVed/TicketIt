/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ticket;

/**
 *
 * @author vedhs
 */
public interface TicketInterface {
    public String ID="";
    public int type=0;
    public double price = 0;
    public String customerName="";
    public String saveTicket();
}
