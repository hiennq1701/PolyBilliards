/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao.impl;

import java.sql.ResultSet;
import java.util.List;
import poly.billiards.dao.TableDAO;
import poly.billiards.entity.Table;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

/**
 *
 * @author Admin
 */
public class TableDAOImpl implements TableDAO {
    private static final String findAllSql = "SELECT * FROM BilliardTable";
    private static final String findByIdSql = "SELECT * FROM BilliardTable WHERE Id = ?";
    private static final String createSql = "INSERT INTO BilliardTable (Name, Status, Price) VALUES (?, ?, ?)";
    private static final String updateSql = "UPDATE BilliardTable SET Status = ?, Price = ? WHERE Id = ?";
    private static final String deleteByIdSql = "DELETE FROM BilliardTable WHERE Id = ?";
    
    @Override
    public List<Table> findAll() {
        return XQuery.getBeanList(Table.class, findAllSql);
    }
    
    @Override
    public Table findById(int id) {
        return XQuery.getSingleBean(Table.class, findByIdSql, id);
    }
    
    @Override
    public void create(Table table) {
        XQuery.execute(createSql, 
            table.getName(),
            table.getStatus(),
            table.getPrice()
        );
    }
    
    @Override
    public void update(Table table) {
        XQuery.execute(updateSql,
            table.getStatus(),
            table.getPrice(),
            table.getId()
        );
    }
    
    @Override
    public void deleteById(int id) {
        XQuery.execute(deleteByIdSql, id);
    }
}
