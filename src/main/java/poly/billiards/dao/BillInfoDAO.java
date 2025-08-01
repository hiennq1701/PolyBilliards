/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package poly.billiards.dao;

import poly.billiards.entity.Billinfo;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import poly.billiards.util.XJdbc;

/**
 *
 * @author MINH DANG
 */
public class BillInfoDAO extends SysDAO<Billinfo, Integer> {

    String SELECT_ALL_SQL = "SELECT * FROM BillInfo";
    String INSERT_SQL = "INSERT INTO BillInfo(idBill, idFood, count) VALUES (?, ?, ?)";
    String UPDATE_SQL = "UPDATE BillInfo SET idBill = ?, idFood = ?, count = ? WHERE id = ?";
    String DELETE_SQL = "DELETE BillInfo WHERE id = ?";
    String SELECT_BY_ID = "SELECT * FROM BillInfo WHERE id = ?";
    String SELECT_ID_BY_IDTABLE = "SELECT id FROM BillInfo WHERE idTable = ?";
    
    @Override
    public void insert(Billinfo entitype) {
        XJdbc.exeUpdate(INSERT_SQL, 
                entitype.getIdbill(),
                entitype.getIdfood(),
                entitype.getCount());
    }

    @Override
    public void update(Billinfo entitype) {
        XJdbc.exeUpdate(UPDATE_SQL, 
                entitype.getIdbill(), 
                entitype.getIdfood(), 
                entitype.getCount(),
                entitype.getId());
    }

    @Override
    public void delete(Integer id) {
        XJdbc.exeUpdate(DELETE_SQL, id);
    }

    @Override
    public List<Billinfo> selectAll() {
        return selectBySQL(SELECT_ALL_SQL);
    }

    @Override
    public Billinfo findById(Integer id) {
        List<Billinfo> list = selectBySQL(SELECT_BY_ID, id);
        return list.size() > 0 ? list.get(0) : null;
    }

    @Override
    public List<Billinfo> selectBySQL(String sql, Object... args) {
        List<Billinfo> list = new ArrayList<>();
        try {
            ResultSet rs = XJdbc.exeQuery(sql, args);
            while (rs.next()) {
                Billinfo tb = new Billinfo();
                tb.setId(rs.getInt("id"));
                tb.setIdbill(rs.getInt("idBill"));
                tb.setIdfood(rs.getString("idFood"));
                tb.setCount(rs.getInt("count"));
                list.add(tb);
            }
        } catch (Exception e) {
            throw new RuntimeException();
        }
        return list;
    }

    
    public Billinfo findbyIdTable(int idtable){
        List<Billinfo> list = selectBySQL(SELECT_ID_BY_IDTABLE, idtable);
        return list.size() > 0 ? list.get(0) : null;
    }
    
    
    //Xóa và lưu trữ thông tin bill
    public List<Object[]> deleteBillInfo(){
        List<Object[]> list = new ArrayList<>();
        try {
            ResultSet rs = null;
            try {
                String sql = "{call dbo.usp_LogAndShowDeletedBills}";
                rs = XJdbc.exeQuery(sql);
            } catch (Exception e) {
                e.printStackTrace();
            }finally{
                rs.getStatement().getConnection().close();  
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException();
        }
        return list;
    }

    /**
     * Lấy danh sách Billinfo theo id bill
     */
    public List<Billinfo> selectByBillId(int billId) {
        String sql = "SELECT * FROM BillInfo WHERE idBill = ?";
        return selectBySQL(sql, billId);
    }
    
    /**
     * Xóa Billinfo theo id bill và id food
     */
    public void deleteByBillIdAndFoodId(int billId, String foodId) {
        String sql = "DELETE FROM BillInfo WHERE idBill = ? AND idFood = ?";
        XJdbc.exeUpdate(sql, billId, foodId);
    }
    
    /**
     * Cập nhật số lượng theo id bill và id food
     */
    public void updateCountByBillIdAndFoodId(int billId, String foodId, int newCount) {
        String sql = "UPDATE BillInfo SET count = ? WHERE idBill = ? AND idFood = ?";
        XJdbc.exeUpdate(sql, newCount, billId, foodId);
    }
}
