/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.entity;

import java.util.Date;

/**
 *
 * @author MINH DANG
 */
public class Bill {
    private int id;
    private Date datecheckin, datecheckout;
    private int idtable, status;
    private float totalPrice;
    private String username;
    private String tableName;

    public Bill() {
    }

    public Bill(int id, Date datecheckin, Date datecheckout, int idtable, int status, float totalPrice, String username) {
        this.id = id;
        this.datecheckin = datecheckin;
        this.datecheckout = datecheckout;
        this.idtable = idtable;
        this.status = status;
        this.totalPrice = totalPrice;
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDatecheckin() {
        return datecheckin;
    }

    public void setDatecheckin(Date datecheckin) {
        this.datecheckin = datecheckin;
    }

    public Date getDatecheckout() {
        return datecheckout;
    }

    public void setDatecheckout(Date datecheckout) {
        this.datecheckout = datecheckout;
    }

    public int getIdtable() {
        return idtable;
    }

    public void setIdtable(int idtable) {
        this.idtable = idtable;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
    

    @Override
    public String toString() {
        return this.status + "(" +this.datecheckin + " " +this.datecheckout+")";
    }
    public enum Status {
        Servicing, Completed, Canceled;
    }
    public static final String DATE_PATTERN = "HH:mm:ss dd-MM-yyyy";
}
