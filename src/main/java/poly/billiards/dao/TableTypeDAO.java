/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao;

import java.util.List;
import poly.billiards.entity.TableType;

/**
 *
 * @author Admin
 */
public interface TableTypeDAO {
    List<TableType> findAll();
    TableType findById(int id);
    void create(TableType tableType);
    void update(TableType tableType);
    void deleteById(int id);
}
