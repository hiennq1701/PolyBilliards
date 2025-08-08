/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.entity;

/**
 *
 * @author MINH DANG
 */
public class Table {
    private int id;
    private String name, status;
    private double price;
    private int tableTypeId;
    private TableType tableType;

    public Table() {
    }

    public Table(int id, String name, String status, double price) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.price = price;
    }

    public Table(int id, String name, String status, double price, int tableTypeId) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.price = price;
        this.tableTypeId = tableTypeId;
    }

    public Table(int id, String name, String status, double price, int tableTypeId, TableType tableType) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.price = price;
        this.tableTypeId = tableTypeId;
        this.tableType = tableType;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getTableTypeId() {
        return tableTypeId;
    }

    public void setTableTypeId(int tableTypeId) {
        this.tableTypeId = tableTypeId;
    }

    public TableType getTableType() {
        return tableType;
    }

    public void setTableType(TableType tableType) {
        this.tableType = tableType;
    }

    @Override
    public String toString() {
        return this.name;
    }
}
