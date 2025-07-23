/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao;

import poly.billiards.entity.Bill;
import poly.billiards.entity.Billinfo;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import poly.billiards.util.XAuth;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

/**
 *
 * @author MINH DANG
 */
public class BillDAO extends SysDAO<Bill, Integer> {

    String SELECT_ALL_SQL = "SELECT * FROM Bill";
    String INSERT_SQL = "INSERT INTO Bill(DateCheckin, IdTable, Status, TotalPrice) VALUES (?, ?, ?, ?)";
    String UPDATE_SQL = "UPDATE Bill SET DateCheckout = ?, IdTable = ?, Status = ?, TotalPrice = ? WHERE Id = ?";
    String DELETE_SQL = "DELETE Bill WHERE Id = ?";
    String SELECT_BY_ID = "SELECT * FROM Bill WHERE Id = ?";
    String SELECT_ID_BY_IDTABLE = "select Id from bill where IdTable = ?";
    String SELECT_DATECHECKIN_BY_IDTABLE = "select DateCheckin from Bill where IdTable = ?";

    @Override
    public void insert(Bill entitype) {
        // Khi tạo bill mới, TotalPrice mặc định là 0
        XJdbc.exeUpdate(INSERT_SQL, entitype.getDatecheckin(), entitype.getIdtable(), entitype.getStatus(), 0);
    }

    @Override
    public void update(Bill entitype) {
        XJdbc.exeUpdate(UPDATE_SQL,
                entitype.getDatecheckout(),
                entitype.getIdtable(),
                entitype.getStatus(),
                entitype.getTotalPrice(),
                entitype.getId());
    }

    @Override
    public void delete(Integer id) {
        XJdbc.exeUpdate(DELETE_SQL, id);
    }

    @Override
    public List<Bill> selectAll() {
        return selectBySQL(SELECT_ALL_SQL);
    }

    @Override
    public Bill findById(Integer id) {
        List<Bill> list = selectBySQL(SELECT_BY_ID, id);
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    public List<Bill> selectBySQL(String sql, Object... args) {
        List<Bill> list = new ArrayList<>();
        try {
            ResultSet rs = XJdbc.exeQuery(sql, args);
            while (rs.next()) {
                Bill b = new Bill();
                b.setId(rs.getInt("Id"));
                b.setDatecheckin(rs.getDate("DateCheckin"));
                b.setDatecheckout(rs.getDate("DateCheckout"));
                b.setIdtable(rs.getInt("IdTable"));
                b.setStatus(rs.getInt("Status"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Integer findbyIdBill(int idtable) {
        try {
            ResultSet rs = XJdbc.exeQuery(SELECT_ID_BY_IDTABLE, idtable);
            while (rs.next()) {
                return rs.getInt("Id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Timestamp findDatebyIdtable(int idtable) {
        try {
            ResultSet rs = XJdbc.exeQuery(SELECT_DATECHECKIN_BY_IDTABLE, idtable);
            while (rs.next()) {
                return rs.getTimestamp("DateCheckin");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy danh sách hóa đơn theo khoảng thời gian DateCheckIn
     */
    public List<Bill> selectByDateRange(Date begin, Date end) {
        String sql = "SELECT * FROM Bill WHERE DateCheckin >= ? AND DateCheckin <= ?";
        return selectBySQL(sql, begin, end);
    }
}
