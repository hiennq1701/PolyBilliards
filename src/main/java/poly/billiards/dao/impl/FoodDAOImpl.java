package poly.billiards.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import poly.billiards.entity.Food;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XStr;
import poly.billiards.util.XQuery;
import poly.billiards.dao.FoodDAO;

public class FoodDAOImpl implements FoodDAO {

    private final String createSql = "INSERT INTO Food(Id, Name, Image, UnitPrice, Discount, Available, CategoryId) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private final String updateSql = "UPDATE Food SET Name=?, Image=?, UnitPrice=?, Discount=?, Available=?, CategoryId=? WHERE Id=?";
    private final String deleteByIdSql = "DELETE FROM Food WHERE Id=?";
    
    private final String findAllSql = "SELECT * FROM Food";
    private final String findByIdSql = findAllSql + " WHERE Id=?";
    private final String findByCategoryIdSql = findAllSql + " WHERE CategoryId=?";
    private final String findByNameSql = findAllSql + " WHERE Name LIKE ?";

    @Override
    public Food create(Food entity) {
        // Chỉ sinh mã nếu chưa có mã
        if (entity.getId() == null || entity.getId().trim().isEmpty()) {
            entity.setId(XStr.getKey());
        }
        Object[] values = {
            entity.getId(),
            entity.getName(),
            entity.getImage(),
            entity.getUnitPrice(),
            entity.getDiscount(),
            entity.isAvailable(),
            entity.getCategoryId()
        };
        XJdbc.exeUpdate(createSql, values);
        return entity;
    }

    @Override
    public void update(Food entity) {
        Object[] values = {
            entity.getName(),
            entity.getImage(),
            entity.getUnitPrice(),
            entity.getDiscount(),
            entity.isAvailable(),
            entity.getCategoryId(),
            entity.getId()
        };
        XJdbc.exeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(String id) {
        XJdbc.exeUpdate(deleteByIdSql, id);
    }

    @Override
    public List<Food> findAll() {
        return XQuery.getBeanList(Food.class, findAllSql);
    }

    @Override
    public Food findById(String id) {
        return XQuery.getSingleBean(Food.class, findByIdSql, id);
    }

    @Override
    public List<Food> findByCategoryId(String categoryId) {
        return XQuery.getBeanList(Food.class, findByCategoryIdSql, categoryId);
    }    

    @Override
    public List<Food> findByName(String name) {
        return XQuery.getBeanList(Food.class, findByNameSql, "%" + name + "%");
    }

    @Override
    public List<Food> findByKeyword(String keyword) {
        return XQuery.getBeanList(Food.class, findByNameSql, "%" + keyword + "%");
    }
}
