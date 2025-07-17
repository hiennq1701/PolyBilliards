package poly.billiards.ui.manager;

import poly.billiards.entity.Food;

public interface DrinkController extends CrudController<Drink>{
    void fillCategories();
    void chooseFile();
}

