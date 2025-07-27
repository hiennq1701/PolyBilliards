package poly.billiards.ui.manager;

import poly.billiards.entity.Food;

public interface FoodController extends CrudController<Food>{
    void fillCategories();
    void chooseFile();
}

