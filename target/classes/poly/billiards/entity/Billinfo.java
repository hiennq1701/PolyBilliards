/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.entity;

/**
 *
 * @author MINH DANG
 */
public class Billinfo {
    private int id, idbill, count;
    private String idfood;
    private String foodName;
    private double discount,unitPrice;
 
    public Billinfo() {
    }

    public Billinfo(int id, int idbill, String idfood, int count) {
        this.id = id;
        this.idbill = idbill;
        this.idfood = idfood;
        this.count = count;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdbill() {
        return idbill;
    }

    public void setIdbill(int idbill) {
        this.idbill = idbill;
    }

    public String getIdfood() {
        return idfood;
    }

    public void setIdfood(String idfood) {
        this.idfood = idfood;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return this.toString();
    }    
}
