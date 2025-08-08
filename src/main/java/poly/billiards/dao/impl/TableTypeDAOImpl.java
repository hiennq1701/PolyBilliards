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
import poly.billiards.dao.TableTypeDAO;
import poly.billiards.entity.TableType;
import poly.billiards.util.XJdbc;

/**
 *
 * @author Admin
 */
public class TableTypeDAOImpl implements TableTypeDAO {
    
    private static final String findAllSql = "SELECT * FROM TableType ORDER BY Id";
    private static final String findByIdSql = "SELECT * FROM TableType WHERE Id = ?";
    private static final String createSql = "INSERT INTO TableType (Name) VALUES (?)";
    private static final String updateSql = "UPDATE TableType SET Name = ? WHERE Id = ?";
    private static final String deleteByIdSql = "DELETE FROM TableType WHERE Id = ?";
    
    @Override
    public List<TableType> findAll() {
        List<TableType> list = new ArrayList<>();
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement ps = conn.prepareStatement(findAllSql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                TableType tableType = new TableType();
                tableType.setId(rs.getInt("Id"));
                tableType.setName(rs.getString("Name"));
                list.add(tableType);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    
    @Override
    public TableType findById(int id) {
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement ps = conn.prepareStatement(findByIdSql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    TableType tableType = new TableType();
                    tableType.setId(rs.getInt("Id"));
                    tableType.setName(rs.getString("Name"));
                    return tableType;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
    
    @Override
    public void create(TableType tableType) {
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement ps = conn.prepareStatement(createSql)) {
            
            ps.setString(1, tableType.getName());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    
    @Override
    public void update(TableType tableType) {
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement ps = conn.prepareStatement(updateSql)) {
            
            ps.setString(1, tableType.getName());
            ps.setInt(2, tableType.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    
    @Override
    public void deleteById(int id) {
        try (Connection conn = XJdbc.getConnection();
             PreparedStatement ps = conn.prepareStatement(deleteByIdSql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
