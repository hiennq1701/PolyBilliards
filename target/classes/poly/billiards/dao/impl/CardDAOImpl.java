package poly.billiards.dao.impl;

import java.util.List;
import poly.billiards.dao.CardDAO;
import poly.billiards.entity.Table;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

public class CardDAOImpl implements CardDAO {

    private final String createSql = "INSERT INTO Cards(Id, Status) VALUES(?, ?)";
    private final String updateSql = "UPDATE Cards SET Status=? WHERE Id=?";
    private final String deleteByIdSql = "DELETE FROM Cards WHERE Id=?";
    
    private final String findAllSql = "SELECT * FROM Cards";
    private final String findByIdSql = findAllSql + " WHERE Id=?";

    @Override
    public Table create(Table entity) {
        Object[] values = {
            entity.getId(),
            entity.getStatus()
        };
        XJdbc.exeUpdate(createSql, values);
        return entity;
    }

    @Override
    public void update(Table entity) {
        Object[] values = {
            entity.getStatus(),
            entity.getId()
        };
        XJdbc.exeUpdate(updateSql, values);
    }

    @Override
    public void deleteById(Integer id) {
        XJdbc.exeUpdate(deleteByIdSql, id);
    }

    @Override
    public List<Table> findAll() {
        return XQuery.getBeanList(Table.class, findAllSql);
    }

    @Override
    public Table findById(Integer id) {
        return XQuery.getSingleBean(Table.class,findByIdSql, id);
    }
}
