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

    String SELECT_ALL_SQL = "SELECT * FROM Billinfo";
    String INSERT_SQL = "INSERT INTO Billinfo(idBill, idFood, count, FoodName, Discount, UnitPrice, HourlyRate, DiscountAmount, ServiceFee, OtherFee, Notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    String UPDATE_SQL = "UPDATE Billinfo SET idBill = ?, idFood = ?, count = ?, FoodName = ?, Discount = ?, UnitPrice = ?, HourlyRate = ?, DiscountAmount = ?, ServiceFee = ?, OtherFee = ?, Notes = ? WHERE id = ?";
    String DELETE_SQL = "DELETE Billinfo WHERE id = ?";
    String SELECT_BY_ID = "SELECT * FROM Billinfo WHERE id = ?";
    String SELECT_ID_BY_IDTABLE = "SELECT id FROM Billinfo WHERE idTable = ?";
    
    @Override
    public void insert(Billinfo entitype) {
        try {
            System.out.println("Đang insert Billinfo với ID Bill: " + entitype.getIdbill());
            System.out.println("Thông tin: Food=" + entitype.getFoodName() + ", Count=" + entitype.getCount());
            XJdbc.exeUpdate(INSERT_SQL, 
                    entitype.getIdbill(),
                    entitype.getIdfood(),
                    entitype.getCount(),
                    entitype.getFoodName(),
                    entitype.getDiscount(),
                    entitype.getUnitPrice(),
                    entitype.getHourlyRate(),
                    entitype.getDiscountAmount(),
                    entitype.getServiceFee(),
                    entitype.getOtherFee(),
                    entitype.getNotes());
            System.out.println("Insert Billinfo thành công!");
        } catch (Exception e) {
            System.err.println("Lỗi khi insert Billinfo: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void update(Billinfo entitype) {
        try {
            System.out.println("Đang update Billinfo với ID: " + entitype.getId());
            XJdbc.exeUpdate(UPDATE_SQL, 
                    entitype.getIdbill(), 
                    entitype.getIdfood(), 
                    entitype.getCount(),
                    entitype.getFoodName(),
                    entitype.getDiscount(),
                    entitype.getUnitPrice(),
                    entitype.getHourlyRate(),
                    entitype.getDiscountAmount(),
                    entitype.getServiceFee(),
                    entitype.getOtherFee(),
                    entitype.getNotes(),
                    entitype.getId());
            System.out.println("Update Billinfo thành công!");
        } catch (Exception e) {
            System.err.println("Lỗi khi update Billinfo: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
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
            System.out.println("Đang thực hiện query: " + sql);
            ResultSet rs = XJdbc.exeQuery(sql, args);
            while (rs.next()) {
                Billinfo tb = new Billinfo();
                tb.setId(rs.getInt("id"));
                tb.setIdbill(rs.getInt("idBill"));
                tb.setIdfood(rs.getString("idFood"));
                tb.setCount(rs.getInt("count"));
                tb.setFoodName(rs.getString("FoodName"));
                
                // Xử lý các cột có thể NULL
                Object discountObj = rs.getObject("Discount");
                tb.setDiscount(discountObj != null ? ((Number) discountObj).floatValue() : 0.0f);
                
                Object unitPriceObj = rs.getObject("UnitPrice");
                tb.setUnitPrice(unitPriceObj != null ? ((Number) unitPriceObj).floatValue() : 0.0f);
                
                Object hourlyRateObj = rs.getObject("HourlyRate");
                tb.setHourlyRate(hourlyRateObj != null ? ((Number) hourlyRateObj).floatValue() : 0.0f);
                
                Object discountAmountObj = rs.getObject("DiscountAmount");
                tb.setDiscountAmount(discountAmountObj != null ? ((Number) discountAmountObj).floatValue() : 0.0f);
                
                Object serviceFeeObj = rs.getObject("ServiceFee");
                tb.setServiceFee(serviceFeeObj != null ? ((Number) serviceFeeObj).floatValue() : 0.0f);
                
                Object otherFeeObj = rs.getObject("OtherFee");
                tb.setOtherFee(otherFeeObj != null ? ((Number) otherFeeObj).floatValue() : 0.0f);
                
                tb.setNotes(rs.getString("Notes"));
                list.add(tb);
            }
            System.out.println("Đọc được " + list.size() + " records từ Billinfo");
        } catch (Exception e) {
            System.err.println("Lỗi khi đọc dữ liệu Billinfo: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi đọc dữ liệu Billinfo: " + e.getMessage());
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
            System.out.println("=== BẮT ĐẦU DELETE BILLINFO ===");
            System.out.println("Gọi stored procedure: dbo.usp_LogAndShowDeletedBills");
            
            String sql = "{call dbo.usp_LogAndShowDeletedBills}";
            try (ResultSet rs = XJdbc.exeQuery(sql)) {
                // Đọc kết quả trả về từ stored procedure
                while (rs.next()) {
                    Object[] row = {
                        rs.getInt("Id"),
                        rs.getDate("DateCheckin"),
                        rs.getDate("DateCheckout"),
                        rs.getInt("IdTable"),
                        rs.getInt("Status"),
                        rs.getFloat("TotalPrice"),
                        rs.getString("Username"),
                        rs.getDate("DeletedAt")
                    };
                    list.add(row);
                }
            }
            
            System.out.println("Stored procedure trả về " + list.size() + " records");
            System.out.println("=== KẾT THÚC DELETE BILLINFO ===");
        } catch (Exception e) {
            System.err.println("Lỗi trong deleteBillInfo: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException();
        }
        return list;
    }

    /**
     * Lấy danh sách Billinfo theo id bill
     */
    public List<Billinfo> selectByBillId(int billId) {
        String sql = "SELECT * FROM Billinfo WHERE idBill = ?";
        System.out.println("Đang tìm Billinfo cho Bill ID: " + billId);
        List<Billinfo> result = selectBySQL(sql, billId);
        System.out.println("Tìm thấy " + result.size() + " records cho Bill ID: " + billId);
        return result;
    }
    
    /**
     * Lấy danh sách Billinfo từ bảng BillInfoDeleted theo id bill
     */
    public List<Billinfo> selectByBillIdFromDeleted(int billId) {
        String sql = "SELECT * FROM BillInfoDeleted WHERE idBill = ?";
        System.out.println("Đang tìm BillInfoDeleted cho Bill ID: " + billId);
        List<Billinfo> result = selectBySQL(sql, billId);
        System.out.println("Tìm thấy " + result.size() + " records từ BillInfoDeleted cho Bill ID: " + billId);
        return result;
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
