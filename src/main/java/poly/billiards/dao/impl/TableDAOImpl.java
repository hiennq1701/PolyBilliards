/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import poly.billiards.dao.TableDAO;
import poly.billiards.entity.Table;
import poly.billiards.entity.TableType;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

/**
 *
 * @author Admin
 */
public class TableDAOImpl implements TableDAO {
    private static final String findAllSql = "SELECT bt.*, tt.Id as TableTypeId, tt.Name as TableTypeName FROM BilliardTable bt LEFT JOIN TableType tt ON bt.TableTypeId = tt.Id";
    private static final String findByIdSql = "SELECT bt.*, tt.Id as TableTypeId, tt.Name as TableTypeName FROM BilliardTable bt LEFT JOIN TableType tt ON bt.TableTypeId = tt.Id WHERE bt.Id = ?";
    private static final String createSql = "INSERT INTO BilliardTable (Name, Status, Price, TableTypeId) VALUES (?, ?, ?, ?)";
    private static final String updateSql = "UPDATE BilliardTable SET Status = ?, Price = ?, TableTypeId = ? WHERE Id = ?";
    private static final String deleteByIdSql = "DELETE FROM BilliardTable WHERE Id = ?";
    
    @Override
    public List<Table> findAll() {
        List<Table> tables = new ArrayList<>();
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement stmt = conn.prepareStatement(findAllSql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Table table = new Table();
                table.setId(rs.getInt("Id"));
                table.setName(rs.getString("Name"));
                table.setStatus(rs.getString("Status"));
                table.setPrice(rs.getDouble("Price"));
                
                // Xử lý TableType
                int tableTypeId = rs.getInt("TableTypeId");
                String tableTypeName = rs.getString("TableTypeName");
                
                if (!rs.wasNull()) { // Kiểm tra nếu TableTypeId không null
                    TableType tableType = new TableType(tableTypeId, tableTypeName);
                    table.setTableTypeId(tableTypeId);
                    table.setTableType(tableType);
                } else {
                    table.setTableTypeId(0);
                    table.setTableType(null);
                }
                
                tables.add(table);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return tables;
    }
    
    @Override
    public Table findById(int id) {
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement stmt = conn.prepareStatement(findByIdSql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Table table = new Table();
                table.setId(rs.getInt("Id"));
                table.setName(rs.getString("Name"));
                table.setStatus(rs.getString("Status"));
                table.setPrice(rs.getDouble("Price"));
                
                // Xử lý TableType
                int tableTypeId = rs.getInt("TableTypeId");
                String tableTypeName = rs.getString("TableTypeName");
                
                if (!rs.wasNull()) { // Kiểm tra nếu TableTypeId không null
                    TableType tableType = new TableType(tableTypeId, tableTypeName);
                    table.setTableTypeId(tableTypeId);
                    table.setTableType(tableType);
                } else {
                    table.setTableTypeId(0);
                    table.setTableType(null);
                }
                
                return table;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
    
    @Override
    public void create(Table table) {
        XQuery.execute(createSql, 
            table.getName(),
            table.getStatus(),
            table.getPrice(),
            table.getTableTypeId()
        );
    }
    
    @Override
    public void update(Table table) {
        XQuery.execute(updateSql,
            table.getStatus(),
            table.getPrice(),
            table.getTableTypeId(),
            table.getId()
        );
    }
    
    @Override
    public void deleteById(int id) {
        XQuery.execute(deleteByIdSql, id);
    }
}
