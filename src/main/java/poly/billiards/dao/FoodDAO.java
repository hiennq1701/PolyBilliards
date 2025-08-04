package poly.billiards.dao;

import java.util.List;
import poly.billiards.entity.Food;

public interface FoodDAO extends CrudDAO<Food, String>{
    /**
     * Truy vấn theo loại
     * 
     * @param categoryId mã loại đồ uống
     * @return kết quả truy vấn
     */
    List<Food> findByCategoryId(String categoryId);
    List<Food> findByName(String name);
    List<Food> findByKeyword(String keyword);
}
