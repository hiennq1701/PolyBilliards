package poly.billiards.dao.impl;

import java.util.List;
import poly.billiards.entity.FoodCategory;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;
import poly.billiards.dao.FoodCategoryDAO;

public class FoodCategoryDAOImpl implements FoodCategoryDAO {

    private final String createSql = "INSERT INTO Categories(Id, Name) VALUES(?, ?)";
    private final String updateSql = "UPDATE Categories SET Name=? WHERE Id=?";
    private final String deleteByIdSql = "DELETE FROM Categories WHERE Id=?";
    
    private final String findAllSql = "SELECT * FROM Categories";
    private final String findByIdSql = findAllSql + " WHERE Id=?";

    @Override
    public FoodCategory create(FoodCategory entity) {
        Object[] values = {
            entity.getId(),
            entity.getName()
        };
        XJdbc.exeUpdate(createSql, values);
        return entity;
    }

    @Override
    public void update(FoodCategory entity) {
        Object[] values = {
            entity.getName(),
            entity.getId()
        };
        XJdbc.exeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(String id) {
        XJdbc.exeUpdate(deleteByIdSql, id);
    }

    @Override
    public List<FoodCategory> findAll() {
        return XQuery.getBeanList(FoodCategory.class, findAllSql);
    }

    @Override
    public FoodCategory findById(String id) {
        return XQuery.getSingleBean(FoodCategory.class, findByIdSql, id);
    }
}
