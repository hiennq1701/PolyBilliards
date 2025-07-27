package poly.billiards.ui.manager;

import poly.billiards.entity.Food;

public interface DrinkController extends CrudController<Food>{
    void fillCategories();
    void chooseFile();
}

