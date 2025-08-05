/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao;

import java.util.List;
import poly.billiards.entity.Table;

/**
 *
 * @author Admin
 */
public interface TableDAO {
    List<Table> findAll();
    Table findById(int id);
    void create(Table table);
    void update(Table table);
    void deleteById(int id);
}
